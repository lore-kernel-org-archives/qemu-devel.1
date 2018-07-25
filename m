Received: from eggs.gnu.org ([2001:4830:134:3::10]:34159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiLzk-0000VQ-7h
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiLzh-00076k-9B
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:46:32 -0400
Received: from mail-by2nam05on0725.outbound.protection.outlook.com
	([2a01:111:f400:fe52::725]:35500
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fiLzg-000763-UG
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:46:29 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 25 Jul 2018 15:46:04 +0000
Message-ID: <BN7PR08MB48688FA533AD07279FC51B7CC6540@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-19-git-send-email-stefan.markovic@rt-rk.com>,
	<17945e3f-9caf-b153-4c45-56d005f27a72@linaro.org>
In-Reply-To: <17945e3f-9caf-b153-4c45-56d005f27a72@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 18/40] target/mips: Add emulation of
 nanoMIPS 32-bit load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hello, Richard. Sorry for bothering you. One more question.

> On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> > +        case NM_ADDIUGP_B:
> > +            gen_arith_imm(ctx, OPC_ADDIU, rt, 28, u);
> > +            break;
>
> Use gen_op_addr_add, since behaves_like('DADDIU[GP.B]').

Did you perhaps mean an implementation similar to this would be appropriate=
:

case NM_ADDIUGP_B:
    if (rt !=3D 0) {=20
        uint32_t offset =3D extract32(ctx->opcode, 0, 18);=20
        if (offset =3D=3D 0) {=20
            gen_load_gpr(cpu_gpr[rt], 28);=20
        } else {=20
            TCGv t0;=20
            t0 =3D tcg_temp_new();=20
            tcg_gen_movi_tl(t0, offset);=20
            gen_op_addr_add(ctx, cpu_gpr[rt], cpu_gpr[28], t0);=20
            tcg_temp_free(t0);=20
        }=20
    }
    break;

(this is like NM_ADDIUGP_W implementation)

Aleksandar M.
