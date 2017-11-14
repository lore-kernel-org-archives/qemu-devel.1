Received: from eggs.gnu.org ([2001:4830:134:3::10]:33475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eEOm8-0003iZ-Ih
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eEOm5-0004TP-75
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:08:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52292
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1eEOm5-0004So-1f
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:08:21 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAE053pq110143
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 19:08:13 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e7nkxg7y4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 19:08:13 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 17:08:12 -0700
References: <20171113213945.20049-1-apahim@redhat.com>
	<20171113213945.20049-3-apahim@redhat.com>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 22:08:04 -0200
MIME-Version: 1.0
In-Reply-To: <20171113213945.20049-3-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <c12472b9-b4a2-8dca-2960-968e02357926@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v9 2/8] qemu.py: better control of created
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, crosa@redhat.com

On 11/13/2017 07:39 PM, Amador Pahim wrote:
> To launch a VM, we need to create basically two files: the monitor
> socket (if it's a UNIX socket) and the qemu log file.
> 
> For the qemu log file, we currently just open the path, which will
> create the file if it does not exist or overwrite the file if it does
> exist.
> 
> For the monitor socket, if it already exists, we are currently removing
> it, even if it's not created by us.
> 
> This patch moves to pre_launch() the responsibility to create a
> temporary directory to host the files so we can remove the whole
> directory on post_shutdown().

s/pre_launch()/_pre_launch()/
s/post_shutdown()/_post_shutdown()/

> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 65d9ad688c..58f00bdd64 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -17,6 +17,8 @@ import logging
>  import os
>  import subprocess
>  import qmp.qmp
> +import shutil
> +import tempfile
> 
> 
>  LOG = logging.getLogger(__name__)
> @@ -72,10 +74,10 @@ class QEMUMachine(object):
>              wrapper = []
>          if name is None:
>              name = "qemu-%d" % os.getpid()
> -        if monitor_address is None:
> -            monitor_address = os.path.join(test_dir, name + "-monitor.sock")
> +        self._name = name
>          self._monitor_address = monitor_address
> -        self._qemu_log_path = os.path.join(test_dir, name + ".log")
> +        self._qemu_log_path = None
> +        self._qemu_log_fd = None

Is our intent to hold an integer file descriptor in self._qemu_log_fd?

Python's built-in open() returns a file object, which is what we're
using here.

Do you think it shall be named, for example, _qemu_log_file to avoid
confusion with integer file descriptors, usually denoted by "fd"?

>          self._popen = None
>          self._binary = binary
>          self._args = list(args)     # Force copy args in case we modify them
> @@ -85,6 +87,8 @@ class QEMUMachine(object):
>          self._socket_scm_helper = socket_scm_helper
>          self._qmp = None
>          self._qemu_full_args = None
> +        self._test_dir = test_dir
> +        self._temp_dir = None
> 
>          # just in case logging wasn't configured by the main script:
>          logging.basicConfig()
> @@ -134,16 +138,6 @@ class QEMUMachine(object):
> 
>          return proc.returncode
> 
> -    @staticmethod
> -    def _remove_if_exists(path):
> -        '''Remove file object at path if it exists'''
> -        try:
> -            os.remove(path)
> -        except OSError as exception:
> -            if exception.errno == errno.ENOENT:
> -                return
> -            raise
> -
>      def is_running(self):
>          return self._popen is not None and self._popen.returncode is None
> 
> @@ -173,6 +167,13 @@ class QEMUMachine(object):
>                  '-display', 'none', '-vga', 'none']
> 
>      def _pre_launch(self):
> +        self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
> +        if not isinstance(self._monitor_address, tuple):
> +            self._monitor_address = os.path.join(self._temp_dir,
> +                                                 self._name + "-monitor.sock")
> +        self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
> +        self._qemu_log_fd = open(self._qemu_log_path, 'wb')
> +
>          self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
>                                                  server=True)
> 
> @@ -180,23 +181,28 @@ class QEMUMachine(object):
>          self._qmp.accept()
> 
>      def _post_shutdown(self):
> -        if not isinstance(self._monitor_address, tuple):
> -            self._remove_if_exists(self._monitor_address)
> -        self._remove_if_exists(self._qemu_log_path)
> +        if self._qemu_log_fd is not None:
> +            self._qemu_log_fd.close()
> +            self._qemu_log_fd = None
> +
> +        self._qemu_log_path = None
> +
> +        if self._temp_dir is not None:
> +            shutil.rmtree(self._temp_dir)
> +            self._temp_dir = None
> 
>      def launch(self):
>          '''Launch the VM and establish a QMP connection'''
>          self._iolog = None
>          self._qemu_full_args = None
>          devnull = open(os.path.devnull, 'rb')
> -        qemulog = open(self._qemu_log_path, 'wb')
>          try:
>              self._pre_launch()
>              self._qemu_full_args = (self._wrapper + [self._binary] +
>                                      self._base_args() + self._args)
>              self._popen = subprocess.Popen(self._qemu_full_args,
>                                             stdin=devnull,
> -                                           stdout=qemulog,
> +                                           stdout=self._qemu_log_fd,
>                                             stderr=subprocess.STDOUT,
>                                             shell=False)
>              self._post_launch()
> 


-- 
Murilo
