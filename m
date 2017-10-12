Received: from eggs.gnu.org ([2001:4830:134:3::10]:55619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2lGt-00029b-3Z
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2lGo-0007CW-16
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:44:03 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:47433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e2lGn-0007BD-PO
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:43:57 -0400
Received: by mail-wm0-f43.google.com with SMTP id t69so16642395wmt.2
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 14:43:56 -0700 (PDT)
References: <20171012143548.18581-1-pbonzini@redhat.com>
	<20171012143548.18581-3-pbonzini@redhat.com>
	<449dd7e8-42cd-fd4a-da2b-35f22552bc39@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5592714-d129-9580-57d7-06de323503d8@redhat.com>
Date: Thu, 12 Oct 2017 23:43:53 +0200
MIME-Version: 1.0
In-Reply-To: <449dd7e8-42cd-fd4a-da2b-35f22552bc39@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/i386: trap on instructions
 longer than >15 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 12/10/2017 21:30, Richard Henderson wrote:
> On 10/12/2017 07:35 AM, Paolo Bonzini wrote:
>> Besides being more correct, arbitrarily long instruction allow the
>> generation of a translation block that spans three pages.  This
>> confuses the generator and even allows ring 3 code to poison the
>> translation block cache and inject code into other processes that are
>> in guest ring 3.
>>
>> This is an improved (and more invasive) fix for the bug fixed in commit
>> 30663fd ("tcg/i386: Check the size of instruction being translated",
>> 2017-03-24).  In addition to being more precise (and generating the
>> right exception, which is #GP rather than #UD), it distinguishes better
>> between page faults and too long instructions, as shown by this test case:
>>
>>     #include <sys/mman.h>
>>     #include <string.h>
>>     #include <stdio.h>
>>
>>     int main()
>>     {
>>             char *x = mmap(NULL, 8192, PROT_READ|PROT_WRITE|PROT_EXEC,
>>                            MAP_PRIVATE|MAP_ANON, -1, 0);
>>             memset(x, 0x66, 4096);
>>             x[4096] = 0x90;
>>             x[4097] = 0xc3;
>>             char *i = x + 4096 - 15;
>>             mprotect(x + 4096, 4096, PROT_READ|PROT_WRITE);
>>             ((void(*)(void)) i) ();
>>     }
>>
>> ... which produces a #GP without the mprotect, and a #PF with it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  target/i386/translate.c | 29 ++++++++++++++++++++++-------
>>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +    if (sigsetjmp(s->jmpbuf, 0) != 0) {
> 
> Any particular reason to use sigsetjmp(x, 0) instead of setjmp(x)?
> Certainly there are no signal frames that the longjmp will pass...

sigsetjmp is used to _not_ save the signal mask.  On OS X setjmp saves
the signal mask by default, which is slower.

Paolo
