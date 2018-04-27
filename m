Received: from eggs.gnu.org ([2001:4830:134:3::10]:44155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2SF-0004th-Ks
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2SE-00049I-NC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:26:23 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:40522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC2SE-00048a-ID
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:26:22 -0400
Received: by mail-oi0-x22d.google.com with SMTP id c203-v6so1399204oib.7
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 05:26:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-5-git-send-email-mjc@sifive.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-5-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 13:26:01 +0100
Message-ID: <CAFEAcA8sadsm3SkoZLVk0qWWxfnGAHFbofpxV08QxVpyjZTZkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 04/23] RISC-V Disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 2 March 2018 at 13:51, Michael Clark <mjc@sifive.com> wrote:
> The RISC-V disassembler has no dependencies outside of the 'disas'
> directory so it can be applied independently. The majority of the
> disassembler is machine-generated from instruction set metadata:
>
> - https://github.com/michaeljclark/riscv-meta

> +        case 5:
> +            if (isa == rv128) {
> +                op = rv_op_c_sqsp;
> +            } else {
> +                op = rv_op_c_fsdsp; break;
> +            }
> +        case 6: op = rv_op_c_swsp; break;

Coverity (CID1390575) points out that for the
case 5 / isa == rv128 codepath, we set op, and
then fall through into case 6 which overwrites it.

Is there a missing "break" statement here? (If the
fallthrough is deliberate it should be marked with a
/* fallthrough */ comment.)

thanks
-- PMM
