Received: from eggs.gnu.org ([2001:4830:134:3::10]:35096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1diiay-0003ek-9c
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1diiav-0006X1-5v
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:49:56 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1diiau-0006Wp-VJ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:49:53 -0400
Received: by mail-it0-f44.google.com with SMTP id 77so8027533itj.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 07:49:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k2210ybh.fsf@dusky.pond.sub.org>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-8-apahim@redhat.com>
	<878tilryx4.fsf@dusky.pond.sub.org>
	<CALAZnb1naw=TtrsDaBw3ehESCp7ET42DUuc=cSTQTXpsKsvoyw@mail.gmail.com>
	<87k2210ybh.fsf@dusky.pond.sub.org>
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 18 Aug 2017 16:49:51 +0200
Message-ID: <CALAZnb26B0v9murz-fSuhoXxy2DwHjvUcRT+EJpEP9ER+_O6gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 7/7] qemu.py: include debug information
 on launch error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Fri, Aug 18, 2017 at 4:01 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Amador Pahim <apahim@redhat.com> writes:
>
>> On Tue, Aug 15, 2017 at 10:57 AM, Markus Armbruster <armbru@redhat.com> wrote:
>>> Amador Pahim <apahim@redhat.com> writes:
>>>
>>>> When launching a VM, if an exception happens and the VM is not
>>>> initiated, it is useful to see the qemu command line that was executed
>>>> and the output of that command.
>>>>
>>>> Before this patch:
>>>>
>>>>     >>> import qemu
>>>>     >>> vm = qemu.QEMUMachine('qemu-system-aarch64', debug=True)
>>>>     >>> vm.launch()
>>>>     Traceback (most recent call last):
>>>>       File "<stdin>", line 1, in <module>
>>>>       File "qemu.py", line 175, in launch
>>>>         self._launch()
>>>>       File "qemu.py", line 189, in _launch
>>>>         self._post_launch()
>>>>       File "qemu.py", line 154, in _post_launch
>>>>         self._qmp.accept()
>>>>       File "qmp/qmp.py", line 145, in accept
>>>>         self.__sock, _ = self.__sock.accept()
>>>>       File "/usr/lib64/python2.7/socket.py", line 206, in accept
>>>>         sock, addr = self._sock.accept()
>>>>     socket.timeout: timed out
>>>>     >>>
>>>>
>>>> After this patch:
>>>>
>>>>     >>> import qemu
>>>>     >>> vm = qemu.QEMUMachine('qemu-system-aarch64', debug=True)
>>>>     >>> vm.launch()
>>>>     DEBUG:qemu:Error launching VM. Command: 'qemu-system-aarch64
>>>>     -chardev socket,id=mon,path=/var/tmp/qemu-5298-monitor.sock
>>>>     -mon chardev=mon,mode=control -display none -vga none'.
>>>>     Output: 'qemu-system-aarch64: No machine specified, and there
>>>>     is no default\nUse -machine help to list supported machines\n'.
>>>>     Traceback (most recent call last):
>>>>       File "<stdin>", line 1, in <module>
>>>>       File "qemu.py", line 175, in launch
>>>>         self._launch()
>>>>       File "qemu.py", line 189, in _launch
>>>>         self._post_launch()
>>>>       File "qemu.py", line 154, in _post_launch
>>>>         self._qmp.accept()
>>>>       File "qmp/qmp.py", line 145, in accept
>>>>         self.__sock, _ = self.__sock.accept()
>>>>       File "/usr/lib64/python2.7/socket.py", line 206, in accept
>>>>         sock, addr = self._sock.accept()
>>>>     socket.timeout: timed out
>>>>     >>>
>>>>
>>>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>>>> ---
>>>>  scripts/qemu.py | 12 +++++++++++-
>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>> index e9a3a96d13..43fd0b072c 100644
>>>> --- a/scripts/qemu.py
>>>> +++ b/scripts/qemu.py
>>>> @@ -158,7 +158,10 @@ class QEMUMachine(object):
>>>>              self._remove_if_exists(self._created_files.pop())
>>>>
>>>>      def launch(self):
>>>> -        '''Launch the VM and establish a QMP connection'''
>>>> +        '''
>>>> +        Try to launch the VM and make sure we cleanup and expose the
>>>> +        command line/output in case of exception.
>>>> +        '''
>>>>
>>>>          if self.is_running():
>>>>              raise QEMULaunchError('VM already running.')
>>>> @@ -169,6 +172,7 @@ class QEMUMachine(object):
>>>>                                    'before launching again.')
>>>>
>>>>          try:
>>>> +            self._iolog = None
>>>>              self._qemu_full_args = None
>>>>              self._qemu_full_args = (self._wrapper + [self._binary] +
>>>>                                      self._base_args() + self._args)
>>>> @@ -176,9 +180,15 @@ class QEMUMachine(object):
>>>>              self._pending_shutdown = True
>>>>          except:
>>>>              self.shutdown()
>>>> +            LOG.debug('Error launching VM.%s%s',
>>>> +                      ' Command: %r.' % ' '.join(self._qemu_full_args)
>>>> +                      if self._qemu_full_args else '',
>>>> +                      ' Output: %r.' % self._iolog
>>>> +                      if self._iolog else '')
>>>
>>> This nested interpolation is too ugly to live :)
>>
>> I find it beautiful :)
>> Killing it anyway.
>>
>>>
>>> Nesting is easy to avoid:
>>>
>>>                LOG.debug('Error launching VM\n. ' Command: %r. Output: %r.'
>>>                          % (' '.join(self._qemu_full_args)
>>>                             if self._qemu_full_args else '',
>>>                             self._iolog
>>>                             if self._iolog else ''))
>>
>> In this case we will have the strings "Command: " and "Output:" even
>> with no content to expose.
>
> No command should not happen.

It can happen, if we fail before the self._qemu_full_args become ready
(i.e. if self._base_args() fails).

>
> No output would be bad news.  Making that explicit in the logs feels
> right to me.

Same here. But even more likely to happen, as one exception either
pre_launch() or launch() can trigger this message without an output.
But if that's your preference, I don't really mind having:
INFO:qemu:Error launching VM. Command: ''. Output: ''.


>
>>> Why %r and not %s?
>>
>> It's a matter of preference. I tend to avoid allowing messages to
>> break the log line. Anyway, I'm improving this.
>
> That's a really good point.  I'd go as far and call %s wrong now :)
>
> Output could be arbitrarily long, though.

Hard to say what's a sane limit. I'd prefer to log it all and let the
scripts tweak that using the logging.Formatter, if they want to.

>
>>> Are you sure '\n' is appropriate in the argument of LOG.debug()?
>>>
>>> Why cram everything into a single LOG.debug()?
>>>
>>>                LOG.debug('Error launching VM')
>>>                LOG.debug('Command: %s' % (' '.join(self._qemu_full_args)
>>>                                           if self._qemu_full_args else ''))
>>>                LOG.debug('Output: %s' % self._iolog if self._iolog else ''))
>>
>> Sure, I'm ok with both ways.
>>
>>>
>>>>              raise
>>>>
>>>>      def _launch(self):
>>>> +        '''Launch the VM and establish a QMP connection.'''
>>>>          self._pre_launch()
>>>>          devnull = open(os.path.devnull, 'rb')
>>>>          self._popen = subprocess.Popen(self._qemu_full_args,
