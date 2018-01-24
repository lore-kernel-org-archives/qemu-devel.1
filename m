Received: from eggs.gnu.org ([2001:4830:134:3::10]:45718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1eeQG7-0003xm-PN
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 13:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1eeQG7-0008MN-0h
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 13:58:55 -0500
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:33400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1eeQG6-0008Lp-Re
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 13:58:54 -0500
Received: by mail-qt0-x233.google.com with SMTP id d8so13086701qtm.0
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 10:58:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <14dcf85d-a8e0-fc21-df46-b94fe48d1067@linaro.org>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-7-git-send-email-mjc@sifive.com>
	<f15753f1-7446-26f1-9937-f3b67d15c0a6@linaro.org>
	<CAHNT7NvcUU8D10jaq+y=B2odsD7-r0MnsZRsq2yheY_a-THSUA@mail.gmail.com>
	<14dcf85d-a8e0-fc21-df46-b94fe48d1067@linaro.org>
From: Jim Wilson <jimw@sifive.com>
Date: Wed, 24 Jan 2018 10:58:53 -0800
Message-ID: <CAFyWVabFUocnxebZxTYrVr71gbyd6PgLYfqxiAHAqSaw0=6VgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Tue, Jan 23, 2018 at 4:15 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Ok.  Now it depends on what result you care about for madd specifically.
>
> If, like x86 and Power, fmsub returns the (silenced) original input NaN, you
> want the float_muladd_* flags.
>
> If, like ARM, fmsub returns the (silenced) negated input NaN, then you do need
> to change sign externally.  If this is the case, please use float32_chs instead
> of open-coding it with xor.

The ISA spec is a little ambiguous here.  There is text that says we
multiply, optionally negate the result, and then add or subtract the
addend.  However, this is followed by a sentence that gives equations,
and for fnmsub it says -rs1*rs2+rs3.  If we assume C semantics, then
they are negating rs1 not the multiply result.  This could potentially
give a different result if rs2 is a +qNaN and rs1/rs3 are not NaNs.
qemu is implementing what the equation says, not what the text says.
The definitive source would be the Spike simulator, and it agrees with
qemu and the equations.  The ISA spec does not specify what happens
when one of the operands is a NaN, except to mention that operations
comply with the IEEE 754 2008 standard.

I think that qemu is correct here, and that you want to use float32_chs.

Although, looking at this again, I see another statement in a
different place that says:

Except when otherwise stated, if the result of a floating-point
operation is NaN, it is the canonical
NaN. The canonical NaN has a positive sign and all significand bits
clear except the MSB, a.k.a.
the quiet bit. For single-precision floating-point, this corresponds
to the pattern 0x7fc00000.

So it sounds like maybe we do want default NaN support.  It appears
that spike is using default NaNs.  Unfortunately, enabling default NaN
support causes gcc and glibc testsuite failures which complicates
upstreaming glibc support, as they won't accept it unless we get
failures below a certain number.  Also, not having hardware to compare
against makes it impossible to determine if the simulator is doing
exactly what the hardware does.  This could take a little time to sort
out.

Jim
