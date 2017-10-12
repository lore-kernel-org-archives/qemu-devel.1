Received: from eggs.gnu.org ([2001:4830:134:3::10]:52951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2jCB-0003p3-9z
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2jC8-0006Hn-7T
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:31:03 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:45752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2jC7-0006HS-UL
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:31:00 -0400
Received: by mail-pf0-x235.google.com with SMTP id d28so6310998pfe.2
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 12:30:59 -0700 (PDT)
References: <20171012143548.18581-1-pbonzini@redhat.com>
	<20171012143548.18581-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <449dd7e8-42cd-fd4a-da2b-35f22552bc39@linaro.org>
Date: Thu, 12 Oct 2017 12:30:55 -0700
MIME-Version: 1.0
In-Reply-To: <20171012143548.18581-3-pbonzini@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 10/12/2017 07:35 AM, Paolo Bonzini wrote:
> Besides being more correct, arbitrarily long instruction allow the
> generation of a translation block that spans three pages.  This
> confuses the generator and even allows ring 3 code to poison the
> translation block cache and inject code into other processes that are
> in guest ring 3.
> 
> This is an improved (and more invasive) fix for the bug fixed in commit
> 30663fd ("tcg/i386: Check the size of instruction being translated",
> 2017-03-24).  In addition to being more precise (and generating the
> right exception, which is #GP rather than #UD), it distinguishes better
> between page faults and too long instructions, as shown by this test case:
> 
>     #include <sys/mman.h>
>     #include <string.h>
>     #include <stdio.h>
> 
>     int main()
>     {
>             char *x = mmap(NULL, 8192, PROT_READ|PROT_WRITE|PROT_EXEC,
>                            MAP_PRIVATE|MAP_ANON, -1, 0);
>             memset(x, 0x66, 4096);
>             x[4096] = 0x90;
>             x[4097] = 0xc3;
>             char *i = x + 4096 - 15;
>             mprotect(x + 4096, 4096, PROT_READ|PROT_WRITE);
>             ((void(*)(void)) i) ();
>     }
> 
> ... which produces a #GP without the mprotect, and a #PF with it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/translate.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +    if (sigsetjmp(s->jmpbuf, 0) != 0) {

Any particular reason to use sigsetjmp(x, 0) instead of setjmp(x)?
Certainly there are no signal frames that the longjmp will pass...


r~
