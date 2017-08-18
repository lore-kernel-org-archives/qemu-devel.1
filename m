Received: from eggs.gnu.org ([2001:4830:134:3::10]:59647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1diiL8-0006MX-N9
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1diiL5-0004jd-Dj
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:33:34 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:37886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1diiL5-0004jB-8o
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:33:31 -0400
Received: by mail-it0-f46.google.com with SMTP id 76so7801988ith.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 07:33:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87shgp0yj1.fsf@dusky.pond.sub.org>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-5-apahim@redhat.com>
	<87tw19s0d7.fsf@dusky.pond.sub.org>
	<CALAZnb3=A4JMfuLLV5wjF5zhEhw7z717bA6CJYP70GwLJvdtpg@mail.gmail.com>
	<87shgp0yj1.fsf@dusky.pond.sub.org>
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 18 Aug 2017 16:33:29 +0200
Message-ID: <CALAZnb38k_uu-WhRmN13zpBa21nCsGu09dPe4W4DMHVpHL5fjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Fri, Aug 18, 2017 at 3:57 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Amador Pahim <apahim@redhat.com> writes:
>
>> On Tue, Aug 15, 2017 at 10:26 AM, Markus Armbruster <armbru@redhat.com> wrote:
>>> Amador Pahim <apahim@redhat.com> writes:
>>>
>>>> The current message shows 'self._args', which contains only part of the
>>>> options used in the qemu command line.
>>>>
>>>> This patch makes the qemu full args list an instance variable and then
>>>> uses it in the negative exit code message.
>>>>
>>>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>>>> ---
>>>>  scripts/qemu.py | 17 ++++++++++++-----
>>>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>> index e3ea534ec4..9434ccc30b 100644
>>>> --- a/scripts/qemu.py
>>>> +++ b/scripts/qemu.py
>>>> @@ -48,6 +48,7 @@ class QEMUMachine(object):
>>>>          self._iolog = None
>>>>          self._socket_scm_helper = socket_scm_helper
>>>>          self._debug = debug
>>>> +        self._qemu_full_args = None
>>>>
>>>>      # This can be used to add an unused monitor instance.
>>>>      def add_monitor_telnet(self, ip, port):
>>>> @@ -140,9 +141,14 @@ class QEMUMachine(object):
>>>>          qemulog = open(self._qemu_log_path, 'wb')
>>>>          try:
>>>>              self._pre_launch()
>>>> -            args = self._wrapper + [self._binary] + self._base_args() + self._args
>>>> -            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
>>>> -                                           stderr=subprocess.STDOUT, shell=False)
>>>> +            self._qemu_full_args = None
>>>> +            self._qemu_full_args = (self._wrapper + [self._binary] +
>>>> +                                    self._base_args() + self._args)
>>>
>>> Why set self._qemu_full_args twice?
>>
>> If it's not cleaned up and an exception happens in
>> "self._qemu_full_args = (self._wrapper ...", the message logged in the
>> "except" will expose an outdated version of it.
>
> Ignorant question: why aren't we cleaning it up?

The "self._qemu_full_args = None" is the cleanup. Case the next
instruction fails, exception will have "None" instead of arguments
from a previous launch().

>
>>>> +            self._popen = subprocess.Popen(self._qemu_full_args,
>>>> +                                           stdin=devnull,
>>>> +                                           stdout=qemulog,
>>>> +                                           stderr=subprocess.STDOUT,
>>>> +                                           shell=False)
>>>>              self._post_launch()
>>>>          except:
>>>>              if self.is_running():
>>>> @@ -163,8 +169,9 @@ class QEMUMachine(object):
>>>>
>>>>              exitcode = self._popen.wait()
>>>>              if exitcode < 0:
>>>> -                LOG.error('qemu received signal %i: %s', -exitcode,
>>>> -                          ' '.join(self._args))
>>>> +                LOG.error('qemu received signal %i:%s', -exitcode,
>>>> +                          ' Command: %r.' % ' '.join(self._qemu_full_args)
>>>> +                          if self._qemu_full_args else '')
>>>
>>> The last argument is hard to read.
>>
>> Ok, I'm making it easier.
>>
>>>
>>>>              self._load_io_log()
>>>>              self._post_shutdown()
>>>
>>> The subprocess module appears to keep track of the full command with
>>> methods check_call() and check_output(): its in exception
>>> CalledProcessError right when you need it.  Sadly, it doesn't appear to
>>> be tracked with method Popen().
>>
>> Indeed.
