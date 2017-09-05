Received: from eggs.gnu.org ([2001:4830:134:3::10]:59831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4OG-0008Ql-Pm
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4OC-0001cz-0w
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:19:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp4OB-0001c0-Ns
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:18:59 -0400
Date: Tue, 5 Sep 2017 11:18:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905031853.GN22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-7-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901112829.2571-7-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 06/13] qemu.py: make sure we only remove
 files we create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Fri, 09/01 13:28, Amador Pahim wrote:
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
> This patch moves to pre_launch() the responsibility to make sure we only
> create files that are not pre-existent and to populate a list of
> controlled files. This list will then be used as the reference of
> files to remove during the cleanup (post_shutdown()).
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 3ebe5ee0a4..c26e1412f9 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -41,6 +41,7 @@ class QEMUMachine(object):
>              monitor_address = os.path.join(test_dir, name + "-monitor.sock")
>          self._monitor_address = monitor_address
>          self._qemu_log_path = os.path.join(test_dir, name + ".log")
> +        self._qemu_log_fd = None
>          self._popen = None
>          self._binary = binary
>          self._args = list(args) # Force copy args in case we modify them
> @@ -50,6 +51,7 @@ class QEMUMachine(object):
>          self._socket_scm_helper = socket_scm_helper
>          self._debug = debug
>          self._qemu_full_args = None
> +        self._created_files = []
>  
>      # This can be used to add an unused monitor instance.
>      def add_monitor_telnet(self, ip, port):
> @@ -128,30 +130,44 @@ class QEMUMachine(object):
>                  '-display', 'none', '-vga', 'none']
>  
>      def _pre_launch(self):
> -        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address, server=True,
> -                                                debug=self._debug)
> +        try:
> +            self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
> +                                                    server=True,
> +                                                    debug=self._debug)
> +        except:
> +            raise

What's the point of "except: raise"? It seems useless.

> +        else:
> +            if not isinstance(self._monitor_address, tuple):
> +                self._created_files.append(self._monitor_address)
> +
> +        try:
> +            flags = os.O_CREAT | os.O_EXCL | os.O_WRONLY
> +            os.open(self._qemu_log_path, flags)

Why change to os.open() instead of open()?

> +        except:
> +            raise
> +        else:
> +            self._created_files.append(self._qemu_log_path)
> +            self._qemu_log_fd = open(self._qemu_log_path, 'wb')
>  
>      def _post_launch(self):
>          self._qmp.accept()
>  
>      def _post_shutdown(self):
> -        if not isinstance(self._monitor_address, tuple):
> -            self._remove_if_exists(self._monitor_address)
> -        self._remove_if_exists(self._qemu_log_path)
> +        while self._created_files:
> +            self._remove_if_exists(self._created_files.pop())
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
> -- 
> 2.13.5
> 

Fam
