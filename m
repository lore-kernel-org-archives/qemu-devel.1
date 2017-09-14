Received: from eggs.gnu.org ([2001:4830:134:3::10]:33314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dsZxr-00006n-F7
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dsZxo-0007C4-7P
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:38:19 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:55418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dsZxo-0007Ay-2b
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:38:16 -0400
Received: by mail-io0-f178.google.com with SMTP id z187so3191367ioz.12
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 12:38:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905031853.GN22515@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-7-apahim@redhat.com>
	<20170905031853.GN22515@lemon.lan>
From: Amador Pahim <apahim@redhat.com>
Date: Thu, 14 Sep 2017 21:38:13 +0200
Message-ID: <CALAZnb1Lxu8jHWYM6f76RWGOOrGgq9L8sfKVceR4ygZC1NxyXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Daniel Berrange <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On Tue, Sep 5, 2017 at 5:18 AM, Fam Zheng <famz@redhat.com> wrote:
> On Fri, 09/01 13:28, Amador Pahim wrote:
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
>> This patch moves to pre_launch() the responsibility to make sure we only
>> create files that are not pre-existent and to populate a list of
>> controlled files. This list will then be used as the reference of
>> files to remove during the cleanup (post_shutdown()).
>>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> ---
>>  scripts/qemu.py | 30 +++++++++++++++++++++++-------
>>  1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 3ebe5ee0a4..c26e1412f9 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -41,6 +41,7 @@ class QEMUMachine(object):
>>              monitor_address = os.path.join(test_dir, name + "-monitor.sock")
>>          self._monitor_address = monitor_address
>>          self._qemu_log_path = os.path.join(test_dir, name + ".log")
>> +        self._qemu_log_fd = None
>>          self._popen = None
>>          self._binary = binary
>>          self._args = list(args) # Force copy args in case we modify them
>> @@ -50,6 +51,7 @@ class QEMUMachine(object):
>>          self._socket_scm_helper = socket_scm_helper
>>          self._debug = debug
>>          self._qemu_full_args = None
>> +        self._created_files = []
>>
>>      # This can be used to add an unused monitor instance.
>>      def add_monitor_telnet(self, ip, port):
>> @@ -128,30 +130,44 @@ class QEMUMachine(object):
>>                  '-display', 'none', '-vga', 'none']
>>
>>      def _pre_launch(self):
>> -        self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address, server=True,
>> -                                                debug=self._debug)
>> +        try:
>> +            self._qmp = qmp.qmp.QEMUMonitorProtocol(self._monitor_address,
>> +                                                    server=True,
>> +                                                    debug=self._debug)
>> +        except:
>> +            raise
>
> What's the point of "except: raise"? It seems useless.

The point is to execute the block in the else only when no exception
happens. When some exception happens, I want to raise it without
executing the else block.

>
>> +        else:
>> +            if not isinstance(self._monitor_address, tuple):
>> +                self._created_files.append(self._monitor_address)
>> +
>> +        try:
>> +            flags = os.O_CREAT | os.O_EXCL | os.O_WRONLY
>> +            os.open(self._qemu_log_path, flags)
>
> Why change to os.open() instead of open()?

I want to create the file only if it does not exist. The open() flag
'x' is available only in python 3.3. For python <3.3, we need the
os.open() to have that feature.

>
>> +        except:
>> +            raise
>> +        else:
>> +            self._created_files.append(self._qemu_log_path)
>> +            self._qemu_log_fd = open(self._qemu_log_path, 'wb')
>>
>>      def _post_launch(self):
>>          self._qmp.accept()
>>
>>      def _post_shutdown(self):
>> -        if not isinstance(self._monitor_address, tuple):
>> -            self._remove_if_exists(self._monitor_address)
>> -        self._remove_if_exists(self._qemu_log_path)
>> +        while self._created_files:
>> +            self._remove_if_exists(self._created_files.pop())
>>
>>      def launch(self):
>>          '''Launch the VM and establish a QMP connection'''
>>          self._iolog = None
>>          self._qemu_full_args = None
>>          devnull = open(os.path.devnull, 'rb')
>> -        qemulog = open(self._qemu_log_path, 'wb')
>>          try:
>>              self._pre_launch()
>>              self._qemu_full_args = (self._wrapper + [self._binary] +
>>                                      self._base_args() + self._args)
>>              self._popen = subprocess.Popen(self._qemu_full_args,
>>                                             stdin=devnull,
>> -                                           stdout=qemulog,
>> +                                           stdout=self._qemu_log_fd,
>>                                             stderr=subprocess.STDOUT,
>>                                             shell=False)
>>              self._post_launch()
>> --
>> 2.13.5
>>
>
> Fam
