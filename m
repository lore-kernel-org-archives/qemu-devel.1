Received: from eggs.gnu.org ([2001:4830:134:3::10]:43598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flZE6-0008CC-FE
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flZE2-0002bl-DO
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:30:38 -0400
Received: from mail-eopbgr730095.outbound.protection.outlook.com
	([40.107.73.95]:60285
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flZE2-0002aK-0o
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:30:34 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 3 Aug 2018 12:30:30 +0000
Message-ID: <SN6PR08MB487923A11669FB76F80797CFC6230@SN6PR08MB4879.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
	<1533219424-7627-24-git-send-email-stefan.markovic@rt-rk.com>,
	<1a3c354d-4cdf-935a-2d6b-aa4fbc2bf100@linaro.org>
In-Reply-To: <1a3c354d-4cdf-935a-2d6b-aa4fbc2bf100@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 23/77] target/mips: Add emulation of
 nanoMIPS 16-bit load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

Also,

wrong indentation of the block that follows these lines:

> +            case NM_P_LS_WM:
> +            case NM_P_LS_UAWM:


________________________________________
From: Richard Henderson <richard.henderson@linaro.org>
Sent: Thursday, August 2, 2018 7:39:27 PM
To: Stefan Markovic; qemu-devel@nongnu.org
Cc: laurent@vivier.eu; riku.voipio@iki.fi; philippe.mathieu.daude@gmail.com=
; aurelien@aurel32.net; Aleksandar Markovic; Stefan Markovic; Petar Jovanov=
ic; Paul Burton; Aleksandar Rikalo
Subject: Re: [PATCH v6 23/77] target/mips: Add emulation of nanoMIPS 16-bit=
 load and store instructions

On 08/02/2018 10:16 AM, Stefan Markovic wrote:
>      case NM_P16_LB:
> +        switch (extract32(ctx->opcode, 2, 2)) {
> +        case NM_LB16:
> +            offset =3D extract32(ctx->opcode, 0, 2);
> +            gen_ld(ctx, OPC_LB, rt, rs, offset);
> +            break;
> +        case NM_SB16:
> +            offset =3D decode_gpr_gpr3_src_store(
> +                         NANOMIPS_EXTRACT_RD(ctx->opcode));
> +            gen_st(ctx, OPC_SB, rt, rs, offset);

That looks wrong.  I think you want

    rt =3D decode_gpr_gpr3_src_store(...);
    offset =3D extract32(ctx->opcode, 0, 2);

here.

>      case NM_P16_LH:
> +        switch ((extract32(ctx->opcode, 3, 1) << 1) | (ctx->opcode & 1))=
 {
> +        case NM_LH16:
> +            offset =3D extract32(ctx->opcode, 1, 2) << 1;
> +            gen_ld(ctx, OPC_LH, rt, rs, offset);
> +            break;
> +        case NM_SH16:
> +            offset =3D decode_gpr_gpr3_src_store(
> +                         NANOMIPS_EXTRACT_RD(ctx->opcode));
> +            gen_st(ctx, OPC_SH, rt, rs, offset);

Similarly.


r~
