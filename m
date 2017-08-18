Received: from eggs.gnu.org ([2001:4830:134:3::10]:50336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dihm4-0001R2-F6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dihlz-0005Tl-IH
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:57:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dihlz-0005SP-9D
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:57:15 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-5-apahim@redhat.com>
	<87tw19s0d7.fsf@dusky.pond.sub.org>
	<CALAZnb3=A4JMfuLLV5wjF5zhEhw7z717bA6CJYP70GwLJvdtpg@mail.gmail.com>
Date: Fri, 18 Aug 2017 15:57:06 +0200
In-Reply-To: <CALAZnb3=A4JMfuLLV5wjF5zhEhw7z717bA6CJYP70GwLJvdtpg@mail.gmail.com>
	(Amador Pahim's message of "Fri, 18 Aug 2017 14:24:11 +0200")
Message-ID: <87shgp0yj1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 4/7] qemu.py: improve message on
 negative exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

Amador Pahim <apahim@redhat.com> writes:

> On Tue, Aug 15, 2017 at 10:26 AM, Markus Armbruster <armbru@redhat.com> wrote:
>> Amador Pahim <apahim@redhat.com> writes:
>>
>>> The current message shows 'self._args', which contains only part of the
>>> options used in the qemu command line.
>>>
>>> This patch makes the qemu full args list an instance variable and then
>>> uses it in the negative exit code message.
>>>
>>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>>> ---
>>>  scripts/qemu.py | 17 ++++++++++++-----
>>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>> index e3ea534ec4..9434ccc30b 100644
>>> --- a/scripts/qemu.py
>>> +++ b/scripts/qemu.py
>>> @@ -48,6 +48,7 @@ class QEMUMachine(object):
>>>          self._iolog = None
>>>          self._socket_scm_helper = socket_scm_helper
>>>          self._debug = debug
>>> +        self._qemu_full_args = None
>>>
>>>      # This can be used to add an unused monitor instance.
>>>      def add_monitor_telnet(self, ip, port):
>>> @@ -140,9 +141,14 @@ class QEMUMachine(object):
>>>          qemulog = open(self._qemu_log_path, 'wb')
>>>          try:
>>>              self._pre_launch()
>>> -            args = self._wrapper + [self._binary] + self._base_args() + self._args
>>> -            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
>>> -                                           stderr=subprocess.STDOUT, shell=False)
>>> +            self._qemu_full_args = None
>>> +            self._qemu_full_args = (self._wrapper + [self._binary] +
>>> +                                    self._base_args() + self._args)
>>
>> Why set self._qemu_full_args twice?
>
> If it's not cleaned up and an exception happens in
> "self._qemu_full_args = (self._wrapper ...", the message logged in the
> "except" will expose an outdated version of it.

Ignorant question: why aren't we cleaning it up?

>>> +            self._popen = subprocess.Popen(self._qemu_full_args,
>>> +                                           stdin=devnull,
>>> +                                           stdout=qemulog,
>>> +                                           stderr=subprocess.STDOUT,
>>> +                                           shell=False)
>>>              self._post_launch()
>>>          except:
>>>              if self.is_running():
>>> @@ -163,8 +169,9 @@ class QEMUMachine(object):
>>>
>>>              exitcode = self._popen.wait()
>>>              if exitcode < 0:
>>> -                LOG.error('qemu received signal %i: %s', -exitcode,
>>> -                          ' '.join(self._args))
>>> +                LOG.error('qemu received signal %i:%s', -exitcode,
>>> +                          ' Command: %r.' % ' '.join(self._qemu_full_args)
>>> +                          if self._qemu_full_args else '')
>>
>> The last argument is hard to read.
>
> Ok, I'm making it easier.
>
>>
>>>              self._load_io_log()
>>>              self._post_shutdown()
>>
>> The subprocess module appears to keep track of the full command with
>> methods check_call() and check_output(): its in exception
>> CalledProcessError right when you need it.  Sadly, it doesn't appear to
>> be tracked with method Popen().
>
> Indeed.
