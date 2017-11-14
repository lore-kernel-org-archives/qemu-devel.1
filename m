Received: from eggs.gnu.org ([2001:4830:134:3::10]:58945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1eEW3y-0006cH-1e
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1eEW3t-0006Rj-5i
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:55:18 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:56264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1eEW3t-0006P8-0K
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:55:13 -0500
Received: by mail-io0-f172.google.com with SMTP id p186so23455441ioe.12
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 23:55:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c12472b9-b4a2-8dca-2960-968e02357926@linux.vnet.ibm.com>
References: <20171113213945.20049-1-apahim@redhat.com>
	<20171113213945.20049-3-apahim@redhat.com>
	<c12472b9-b4a2-8dca-2960-968e02357926@linux.vnet.ibm.com>
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 14 Nov 2017 08:55:09 +0100
Message-ID: <CALAZnb0M=VWD4DAGJ9JGdBgKODX4EguZ6VCyrgDcs3Jm_TKFgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Murilo_Opsfelder_Ara=C3=BAjo?= <muriloo@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Tue, Nov 14, 2017 at 1:08 AM, Murilo Opsfelder Ara=C3=BAjo
<muriloo@linux.vnet.ibm.com> wrote:
> On 11/13/2017 07:39 PM, Amador Pahim wrote:
>> To launch a VM, we need to create basically two files: the monitor
>> socket (if it's a UNIX socket) and the qemu log file.
>>
>> For the qemu log file, we currently just open the path, which will
>> create the file if it does not exist or overwrite the file if it does
>> exist.
>>
>> For the monitor socket, if it already exists, we are currently removing
>> it, even if it's not created by us.
>>
>> This patch moves to pre_launch() the responsibility to create a
>> temporary directory to host the files so we can remove the whole
>> directory on post_shutdown().
>
> s/pre_launch()/_pre_launch()/
> s/post_shutdown()/_post_shutdown()/
>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> ---
>>  scripts/qemu.py | 42 ++++++++++++++++++++++++------------------
>>  1 file changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 65d9ad688c..58f00bdd64 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -17,6 +17,8 @@ import logging
>>  import os
>>  import subprocess
>>  import qmp.qmp
>> +import shutil
>> +import tempfile
>>
>>
>>  LOG =3D logging.getLogger(__name__)
>> @@ -72,10 +74,10 @@ class QEMUMachine(object):
>>              wrapper =3D []
>>          if name is None:
>>              name =3D "qemu-%d" % os.getpid()
>> -        if monitor_address is None:
>> -            monitor_address =3D os.path.join(test_dir, name + "-monitor=
.sock")
>> +        self._name =3D name
>>          self._monitor_address =3D monitor_address
>> -        self._qemu_log_path =3D os.path.join(test_dir, name + ".log")
>> +        self._qemu_log_path =3D None
>> +        self._qemu_log_fd =3D None
>
> Is our intent to hold an integer file descriptor in self._qemu_log_fd?
>
> Python's built-in open() returns a file object, which is what we're
> using here.
>
> Do you think it shall be named, for example, _qemu_log_file to avoid
> confusion with integer file descriptors, usually denoted by "fd"?

Sure.

>
>>          self._popen =3D None
>>          self._binary =3D binary
>>          self._args =3D list(args)     # Force copy args in case we modi=
fy them
>> @@ -85,6 +87,8 @@ class QEMUMachine(object):
>>          self._socket_scm_helper =3D socket_scm_helper
>>          self._qmp =3D None
>>          self._qemu_full_args =3D None
>> +        self._test_dir =3D test_dir
>> +        self._temp_dir =3D None
>>
>>          # just in case logging wasn't configured by the main script:
>>          logging.basicConfig()
>> @@ -134,16 +138,6 @@ class QEMUMachine(object):
>>
>>          return proc.returncode
>>
>> -    @staticmethod
>> -    def _remove_if_exists(path):
>> -        '''Remove file object at path if it exists'''
>> -        try:
>> -            os.remove(path)
>> -        except OSError as exception:
>> -            if exception.errno =3D=3D errno.ENOENT:
>> -                return
>> -            raise
>> -
>>      def is_running(self):
>>          return self._popen is not None and self._popen.returncode is No=
ne
>>
>> @@ -173,6 +167,13 @@ class QEMUMachine(object):
>>                  '-display', 'none', '-vga', 'none']
>>
>>      def _pre_launch(self):
>> +        self._temp_dir =3D tempfile.mkdtemp(dir=3Dself._test_dir)
>> +        if not isinstance(self._monitor_address, tuple):
>> +            self._monitor_address =3D os.path.join(self._temp_dir,
>> +                                                 self._name + "-monitor=
.sock")
>> +        self._qemu_log_path =3D os.path.join(self._temp_dir, self._name=
 + ".log")
>> +        self._qemu_log_fd =3D open(self._qemu_log_path, 'wb')
>> +
>>          self._qmp =3D qmp.qmp.QEMUMonitorProtocol(self._monitor_address=
,
>>                                                  server=3DTrue)
>>
>> @@ -180,23 +181,28 @@ class QEMUMachine(object):
>>          self._qmp.accept()
>>
>>      def _post_shutdown(self):
>> -        if not isinstance(self._monitor_address, tuple):
>> -            self._remove_if_exists(self._monitor_address)
>> -        self._remove_if_exists(self._qemu_log_path)
>> +        if self._qemu_log_fd is not None:
>> +            self._qemu_log_fd.close()
>> +            self._qemu_log_fd =3D None
>> +
>> +        self._qemu_log_path =3D None
>> +
>> +        if self._temp_dir is not None:
>> +            shutil.rmtree(self._temp_dir)
>> +            self._temp_dir =3D None
>>
>>      def launch(self):
>>          '''Launch the VM and establish a QMP connection'''
>>          self._iolog =3D None
>>          self._qemu_full_args =3D None
>>          devnull =3D open(os.path.devnull, 'rb')
>> -        qemulog =3D open(self._qemu_log_path, 'wb')
>>          try:
>>              self._pre_launch()
>>              self._qemu_full_args =3D (self._wrapper + [self._binary] +
>>                                      self._base_args() + self._args)
>>              self._popen =3D subprocess.Popen(self._qemu_full_args,
>>                                             stdin=3Ddevnull,
>> -                                           stdout=3Dqemulog,
>> +                                           stdout=3Dself._qemu_log_fd,
>>                                             stderr=3Dsubprocess.STDOUT,
>>                                             shell=3DFalse)
>>              self._post_launch()
>>
>
>
> --
> Murilo
>
