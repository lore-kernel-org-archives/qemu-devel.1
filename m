Received: from eggs.gnu.org ([2001:4830:134:3::10]:49154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dYB1A-0008DY-HH
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dYB17-0002Yz-9r
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:57:24 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dYB17-0002Uo-44
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:57:21 -0400
Received: by mail-io0-f180.google.com with SMTP id q2so11179762ioe.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 05:57:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87inin1g78.fsf@dusky.pond.sub.org>
References: <20170720091902.22476-1-apahim@redhat.com>
	<20170720091902.22476-2-apahim@redhat.com>
	<87inin1g78.fsf@dusky.pond.sub.org>
From: Amador Pahim <apahim@redhat.com>
Date: Thu, 20 Jul 2017 14:57:15 +0200
Message-ID: <CALAZnb1uWT__Pnd-zeP3_L+t+JDtK42+KHV9qo_r6qXWs4P64w@mail.gmail.com>
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, ehabkost@redhat.com, mreitz@redhat.com, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

On Thu, Jul 20, 2017 at 1:49 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Amador Pahim <apahim@redhat.com> writes:
>
>> Current implementation is broken. It does not really test if the child
>> process is running.
>
> What usage exactly is broken by this?  Got a reproducer for me?

Problem is that 'returncode' is not set without a calling
poll()/wait()/communicate(), so it's only useful to test if the
process is running after such calls. But if we use 'poll()' instead,
it will, according to the docs, "Check if child process has
terminated. Set and return returncode attribute."

Reproducer is:

 >>> import subprocess
 >>> devnull = open('/dev/null', 'rb')
 >>> p = subprocess.Popen(['qemu-system-x86_64', '-broken'],
stdin=devnull, stdout=devnull, stderr=devnull, shell=False)
 >>> print p.returncode
 None
 >>> print p.poll()
 1
 >>> print p.returncode
 1


>
>> The Popen.returncode will only be set after by a poll(), wait() or
>> communicate(). If the Popen fails to launch a VM, the Popen.returncode
>> will not turn to None by itself.
>
> Hmm.  What is the value of .returncode then?

returncode starts with None and becomes the process exit code when the
process is over and one of that three methods is called (poll(),
wait() or communicate()).

There's an error in my description though. The correct would be: "The
Popen.returncode will only be set after a call to poll(), wait() or
communicate(). If the Popen fails to launch a VM, the Popen.returncode
will not turn from None to the actual return code by itself."


>
>> Instead of using Popen.returncode, let's use Popen.poll(), which
>> actually checks if child process has terminated.
>>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>  scripts/qemu.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 880e3e8219..f0fade32bd 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -86,7 +86,7 @@ class QEMUMachine(object):
>>              raise
>>
>>      def is_running(self):
>> -        return self._popen and (self._popen.returncode is None)
>> +        return self._popen and (self._popen.poll() is None)
>>
>>      def exitcode(self):
>>          if self._popen is None:
>                return None
>            return self._popen.returncode
>
> Why is this one safe?

Here it's used just to retrieve the value from the Popen.returncode.
It's not being used to check whether the process is running or not.
