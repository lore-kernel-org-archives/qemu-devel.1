Received: from eggs.gnu.org ([2001:4830:134:3::10]:56024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVHhg-0000qE-B0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVHhf-0007mj-52
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:29:20 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:34677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ricardo.ribalda@gmail.com>)
	id 1dVHhf-0007ll-0L
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:29:19 -0400
Received: by mail-io0-x244.google.com with SMTP id f66so1983714iof.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 06:29:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5316bcf4-63b5-5ce3-05d8-a6c5b75cff65@twiddle.net>
References: <20170711212123.4368-1-rth@twiddle.net>
	<5316bcf4-63b5-5ce3-05d8-a6c5b75cff65@twiddle.net>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 12 Jul 2017 15:28:55 +0200
Message-ID: <CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] target/i386: Implement all TBM
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com

Hi Richard

Thanks for your patch! I have applied it to my tree, but i still get
SIGSEGV. I think that I might have found the problem. It seems to be
related to the bmi instruction blsr, which seems to be not properly
implemented.

On this example:

#include <stdio.h>

int test_blsr(int val){

return (val & (val - 1));
}


int main(int argc, char *argv) {
volatile int val = 4096;

fprintf(stdout, "%d\n", test_blsr(val));

return 0;
}

When it is compiled with -march=bdver4 -static -O3 test_blsr , the
compiler produces:

0000000000400af0 <test_blsr>:
  400af0:       c4 e2 78 f3 cf          blsr   %edi,%eax
  400af5:       c3                      retq
  400af6:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
  400afd:       00 00 00

If I run the emulator: /tmp/qemu/x86_64-linux-user/qemu-x86_64 -cpu
Haswell ./a.out

The function prints 4096

A fast look in the code shows that
https://github.com/qemu/qemu/blob/master/target/i386/translate.c#L4028
does not really match
https://en.wikipedia.org/wiki/Bit_Manipulation_Instruction_Sets#BMI1_.28Bit_Manipulation_Instruction_Set_1.29

It appears that case 1 and case 3 are swapped. I tried to fix it, but
with no results :(. Anyway, the wiki could also be wrong.

What is sure is that the code produces different results on qemu than
on the target, which is not good


Thanks again for your help!


On Wed, Jul 12, 2017 at 6:04 AM, Richard Henderson <rth@twiddle.net> wrote:
> On 07/11/2017 11:21 AM, Richard Henderson wrote:
>>
>> I am in the process of trying to run the gcc testsuite with -mtbm,
>> with and without the patchset, to see (1) if the new insns get used
>> and (2) that they run ok.
>
>
> FWIW, make check-gcc RUNTESTFLAGS='--target_board=unix/-mtbm execute.exp'
> shows 204 failures on a host that does not support TBM, so the extension is
> being used.  A browse through exactly one of these used only bextr.  Running
> the same tests with dejagnu using qemu-x86_64 -cpu qemu64,+tbm shows zero
> failures.
>
>
> r~



-- 
Ricardo Ribalda
