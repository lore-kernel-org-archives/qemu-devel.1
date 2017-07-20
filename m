Received: from eggs.gnu.org ([2001:4830:134:3::10]:37226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dYDf5-0001CB-F7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dYDf2-0006xq-9j
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:46:47 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:33528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dYDf2-0006xQ-4Z
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:46:44 -0400
Received: by mail-it0-f45.google.com with SMTP id j81so367652ita.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:46:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87vamnuovc.fsf@dusky.pond.sub.org>
References: <20170720091902.22476-1-apahim@redhat.com>
	<20170720091902.22476-2-apahim@redhat.com>
	<87inin1g78.fsf@dusky.pond.sub.org>
	<CALAZnb1uWT__Pnd-zeP3_L+t+JDtK42+KHV9qo_r6qXWs4P64w@mail.gmail.com>
	<87vamnuovc.fsf@dusky.pond.sub.org>
From: Amador Pahim <apahim@redhat.com>
Date: Thu, 20 Jul 2017 17:46:42 +0200
Message-ID: <CALAZnb3d1U1iAviG7q1r5quuL7phpha76+PoYdMxQW-h6BXyRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu.py: fix is_running()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Cleber Rosa <crosa@redhat.com>

On Thu, Jul 20, 2017 at 5:09 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Amador Pahim <apahim@redhat.com> writes:
>
>> On Thu, Jul 20, 2017 at 1:49 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>> Amador Pahim <apahim@redhat.com> writes:
>>>
>>>> Current implementation is broken. It does not really test if the child
>>>> process is running.
>>>
>>> What usage exactly is broken by this?  Got a reproducer for me?
>>
>> Problem is that 'returncode' is not set without a calling
>> poll()/wait()/communicate(), so it's only useful to test if the
>> process is running after such calls. But if we use 'poll()' instead,
>> it will, according to the docs, "Check if child process has
>> terminated. Set and return returncode attribute."
>>
>> Reproducer is:
>>
>>  >>> import subprocess
>>  >>> devnull = open('/dev/null', 'rb')
>>  >>> p = subprocess.Popen(['qemu-system-x86_64', '-broken'],
>> stdin=devnull, stdout=devnull, stderr=devnull, shell=False)
>>  >>> print p.returncode
>>  None
>>  >>> print p.poll()
>>  1
>>  >>> print p.returncode
>>  1
>>
>>>> The Popen.returncode will only be set after by a poll(), wait() or
>>>> communicate(). If the Popen fails to launch a VM, the Popen.returncode
>>>> will not turn to None by itself.
>>>
>>> Hmm.  What is the value of .returncode then?
>>
>> returncode starts with None and becomes the process exit code when the
>> process is over and one of that three methods is called (poll(),
>> wait() or communicate()).
>>
>> There's an error in my description though. The correct would be: "The
>> Popen.returncode will only be set after a call to poll(), wait() or
>> communicate(). If the Popen fails to launch a VM, the Popen.returncode
>> will not turn from None to the actual return code by itself."
>
> Suggest to add ", and is_running() continues to report True".
>
>>>> Instead of using Popen.returncode, let's use Popen.poll(), which
>>>> actually checks if child process has terminated.
>>>>
>>>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>> ---
>>>>  scripts/qemu.py | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>>> index 880e3e8219..f0fade32bd 100644
>>>> --- a/scripts/qemu.py
>>>> +++ b/scripts/qemu.py
>>>> @@ -86,7 +86,7 @@ class QEMUMachine(object):
>>>>              raise
>>>>
>>>>      def is_running(self):
>>>> -        return self._popen and (self._popen.returncode is None)
>>>> +        return self._popen and (self._popen.poll() is None)
>>>>
>>>>      def exitcode(self):
>>>>          if self._popen is None:
>>>                return None
>>>            return self._popen.returncode
>>>
>>> Why is this one safe?
>>
>> Here it's used just to retrieve the value from the Popen.returncode.
>> It's not being used to check whether the process is running or not.
>
> If self._popen is not None, we return self._popen.returncode.  It's None
> if .poll() etc. haven't been called.  Can this happen?  If not, why not?
> If yes, why is returning None then okay?

Yes, that can happen. This method is not returning an up-to-date
returncode, it's serving just as a wrapper to the attribute, being the
attribute updated or not.
I lack the background on why it was coded that way, but considering
the API-user perspective, I agree with you. We should return
self._popen.poll() here indeed. Fixing that.
