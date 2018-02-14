Received: from eggs.gnu.org ([2001:4830:134:3::10]:53753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1em1Ri-00006I-KT
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1em1Re-0007lJ-IK
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:06:18 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60075
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1em1Re-0007lA-BR
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:06:14 -0500
References: <7381713.AMGm5Pu749@wirbelwind>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <68661e81-c9e5-69ed-6d5c-7a86f4f84e65@ilande.co.uk>
Date: Wed, 14 Feb 2018 18:06:06 +0000
MIME-Version: 1.0
In-Reply-To: <7381713.AMGm5Pu749@wirbelwind>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] sparc crash on delayed control-transfer couples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: steven.seeger@flightsystems.net, QEMU Developers <qemu-devel@nongnu.org>

On 13/02/18 21:01, Steven Seeger wrote:

> Consider the following code:
> 
> 0x100     cmp %g5, 3
> 0x104     be 0x200
> 0x108     b 0x300
> 
> I believe this is what is described on page 55 of the sparc v8 manual as
> unpredictable behavior, where a Bicc precedes an unconditional branch.
> 
> QEMU actually crashes unless run in GDB. Single stepping will actually have a
> successful compare of %g5==3 executing from 0x300.
> 
> Without GDB, qemu crashes with unaligned access at address 2 (JUMP_PC) on the
> fetch.
> 
> I understand that this may be "bad code" and may be "unpredictable" but I
> don't think QEMU crashing is an acceptable case. :)
> 
> I am not a SPARC expert at all (only started looking at sparc assembly
> yesterday, in fact) so I am not trying to say what the correct behavior it. It
> appears that the be should be a be,a, but is not. This may be a compiler bug
> in what was used to compile this code.
> 
> It seems that our board (real hardware) will run at 0x200 and ignore the
> branch. I am attempting to modify translate.c to do just that to see how
> things go.
> 
> If anyone else has any ideas, please chime in.
> 
> Thanks to you all for what you do.

Yeah this is when it starts getting tricky... I agree that QEMU 
definitely shouldn't crash but trying to figure out what the behaviour 
should be is the hard part.

Can you tell me a bit about your real hardware and whether it matches 
the behaviour of QEMU here?


ATB,

Mark.
