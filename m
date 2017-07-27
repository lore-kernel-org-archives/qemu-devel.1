Received: from eggs.gnu.org ([2001:4830:134:3::10]:56963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dadjJ-0002eh-PD
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dadjG-0006Iy-IF
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:01:09 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dadjG-0006IU-DP
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:01:06 -0400
Received: by mail-io0-f178.google.com with SMTP id m88so67737115iod.2
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 01:01:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725211729.GX2757@localhost.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-7-apahim@redhat.com>
	<20170725211729.GX2757@localhost.localdomain>
From: Amador Pahim <apahim@redhat.com>
Date: Thu, 27 Jul 2017 10:01:04 +0200
Message-ID: <CALAZnb0EddnADxHGP05ngzzJ-n99iU02jTtx3xZN3h1SHhQ9Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 6/6] qemu.py: include qemu command line
 and output on launch error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, Daniel Berrange <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On Tue, Jul 25, 2017 at 11:17 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Jul 25, 2017 at 07:10:14PM +0200, Amador Pahim wrote:
>> When launching a VM, if an exception happens and the VM is not
>> initiated, it is useful to see the qemu command line that was executed
>> and the output of that command.
>>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> ---
>>  scripts/qemu.py | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index e18e8ec657..abfa3eebe9 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -131,7 +131,8 @@ class QEMUMachine(object):
>>
>>      def launch(self):
>>          '''
>> -        Try to launch the VM and make sure we cleanup on exception.
>> +        Try to launch the VM and make sure we cleanup and expose the
>> +        command line/output in case of exception.
>>          '''
>>          if self.is_running():
>>              return
>> @@ -142,18 +143,24 @@ class QEMUMachine(object):
>>              self.shutdown()
>>
>>          try:
>> -            self._launch()
>> +            args = None
>> +            args = self._wrapper + [self._binary] + self._base_args() + self._args
>> +            self._launch(args)
>
> I think it would be easier to set a self._full_qemu_args
> attribute instead of passing data around through local variables
> and method arguments.

Ok, matter of preference. I'm ok with both.

>
>>              self._shutdown_pending = True
>>          except:
>>              self.shutdown()
>> +            sys.stderr.write('Error launching VM.\n%s%s' %
>> +                             ('Command:\n%s\n' %
>> +                              ' '.join(args) if args else '',
>> +                              'Output:\n%s\n' %
>> +                              ''.join(self._iolog) if self._iolog else ''))
>
> I suggest making this conditional on self._debug.

Ok.

>
> We could also introduce a QEMULaunchError exception class
> containing this info, but I'm unsure if we should raise it on
> every exception, or raise more specific custom exceptions on
> specific cases (e.g. one exception for QMP timeout, another for
> QEMU binary not found, another for QEMU killed by a signal, etc).

I'd prefer to keep the original exceptions and make this a debug message.

>
>
>>              raise
>>
>> -    def _launch(self):
>> +    def _launch(self, args):
>>          '''Launch the VM and establish a QMP connection.'''
>>          devnull = open('/dev/null', 'rb')
>>          qemulog = open(self._qemu_log_path, 'wb')
>>          self._pre_launch()
>> -        args = self._wrapper + [self._binary] + self._base_args() + self._args
>>          self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
>>                                         stderr=subprocess.STDOUT, shell=False)
>>          self._post_launch()
>> --
>> 2.13.3
>>
>
> --
> Eduardo
