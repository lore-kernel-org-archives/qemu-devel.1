Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D0AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6862087E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZAgJjy5k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="eHBFUkm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6862087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu5ab-0006pJ-Ab
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iu5Zw-0006PI-80
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iu5Zu-0008RG-JW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:17:12 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:47752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iu5Zu-0008Qi-72
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1579659430; x=1611195430;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yKml2XflaFZAysmqPgWM/YP+K19wQBYzwLNH3gq+fBY=;
 b=ZAgJjy5kJSaDXKFz4jprEemHyoqji3IXuS91Bfw9BV6a0sJrLNRizojM
 VG6eJODXLPLrJ2O4fgmBlpw9CBBL6grO2kBoDyOKGEk7QTvoBMpIs1Svb
 24ObGSLM+H4ZKslv1xa/j6J9dp+x/gLpa+fTfnzwBHnLTU4P1XpFqtFGQ U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jan 2020 18:17:08 -0800
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 Jan 2020 18:17:08 -0800
Received: from NASANEXM01B.na.qualcomm.com (10.85.0.82) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 21 Jan 2020 18:17:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 21 Jan 2020 18:17:07 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4167.namprd02.prod.outlook.com (20.176.249.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 22 Jan 2020 02:17:06 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::d9c2:a411:1acc:21c4]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::d9c2:a411:1acc:21c4%5]) with mapi id 15.20.2644.026; Wed, 22 Jan 2020
 02:17:06 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 2/5] target/mips: Add support for MIPS<32|64>R6 CRC32
 ISA
Thread-Topic: [PATCH v3 2/5] target/mips: Add support for MIPS<32|64>R6 CRC32
 ISA
Thread-Index: AQHV0GhsNuXgvoucMUW8chPEsoTCqaf179UA
Date: Wed, 22 Jan 2020 02:17:05 +0000
Message-ID: <BYAPR02MB48865E5EF488E5480E591D2DDE0C0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1579613937-5774-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579613937-5774-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1579613937-5774-3-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4a088ca-61b1-401e-c6f2-08d79ee12d7e
x-ms-traffictypediagnostic: BYAPR02MB4167:
x-microsoft-antispam-prvs: <BYAPR02MB41670FC4D7DC0D31B6AE658ADE0C0@BYAPR02MB4167.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(26005)(186003)(6506007)(55016002)(9686003)(33656002)(316002)(2906002)(7696005)(71200400001)(110136005)(54906003)(478600001)(5660300002)(4326008)(76116006)(52536014)(66446008)(8936002)(86362001)(81166006)(8676002)(81156014)(66946007)(66476007)(66556008)(64756008)(83133001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4167;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r6Z5MyxT0jE9ELU5paH/zLbnCR4xfJRJg+iMQx2mg6s7QfOdNb7XMu525t1cZ64/zliWQV8Oe7jDpt0F48UHddgJhRcjcaMpLpLkmcOp7g8w2H5qZrmSE9eVSYr3f7sb16OU9Y2MGcXOyZo71Cd4fNI4kyJZYdtWagpKPScQcIYaXm1bvqv7RWH686RyVyu0eUjWFLPMLJCkhGlSADETZQxZXddHiHtX71XBGM7+Y4OZWQ2QrlTleDu4IHDRr7PWPc5en4BZqSX4aiPzNC+9caPrdKsXfzu6Sm9jA/4hbC7kxDsIy5RXPJc0/ZC0xHZCB78cAQjaovNNzWYKKbr6h3VNS2yJRJjzhIf44Ae4RujqVuVmm8j5QowRRNRrNPHXSR9ZWkDC92Go4zQfMetllNS4LGBB4GEmo/MRa5XDwWE57/ZyZKi7PIz/M1rqQRTh/hR9cR6+xcmTSn2ovCsaBgPOD73KRqyyNgktre9pCefmLg3vSOGDWK6/xo4f63UH
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlmTyZdeKxGletEgWbj74tq+KYP+3uEMlGu5vujty5XHEJ0Xbqu6Q/+Xqq6SSbCSLVV//JXQ1GTUzPFwmz55etzXenAuou2MEoNMm+Dz+MY0RE0BvAJ0NKKeiUOThDqV5bSniHzZdRaFddL/bj5dqoXlLKx87BHS09ecaR5+brYFUzoZcIxH0VDuFrcaKHqAzZk22PGZhQ3uCXUtn3ekdvz1Q6uvcbtZQ1iwVyaJNFgEbrMv+Bdd8Om7Gkg32Z3hlBNphYKkc/V4mSLa7LfRj3NES1atxqrSKQhUe+ELmMWN6KzpFwlQnD5DomM9prA2zdsKLPRu+8EntbW/vq33kA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiCfj5tcMWZwmhYfZfxHCDiD63f+9gRhUE4FJRDvM9s=;
 b=bcI+BLcdJsbYrSzsaMTXrvgSn3wgTeXqGUFpKdn2bjV4L9a1JhKiwQWEwZXaFBD+V1COYhuoctPGHKJJOGMz90o/7nyIRn7rsXLc8tPMGKNY0714FDpkuBGDGsPespk6LkF41jgQBtJBPUUUS1iilI2xdBnxwtyBi8MBL50//UJtLOd3QvalXHgaiySmRKfEWRTLSgI43Wzq5nK8pGmUJkZI+Xqyepj/I+U1la2mmpgrX7qojWRURYkpk7AfzaAYIoGe505LXQo9Pq9shNr/+tQTvcazW33TosiHlhizIFtYTVpQG92nhR7VTzHp3Dn/zRTQczs8zGZx4jEW8JehTg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiCfj5tcMWZwmhYfZfxHCDiD63f+9gRhUE4FJRDvM9s=;
 b=eHBFUkm0ViLlKSoG60yPXlAs8pIU/MCbyXNAPCq57Gt/98w1b1aheGmUXX87LldwAyJcLwORPYBiLDHQHI+kEIeU/d4fDmr3JKZAG9jTrhfzPXTs4DQ2eFxLh5RAlErlB2PkhPA4FgIpyWp6IlV25/BHBxz1Av4HJLXuq2Cnt/c=
x-ms-exchange-crosstenant-network-message-id: e4a088ca-61b1-401e-c6f2-08d79ee12d7e
x-ms-exchange-crosstenant-originalarrivaltime: 22 Jan 2020 02:17:05.8651 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: BCruJ3Z2v0bIrztYA2qOS+dRp3WbUBVwkWyq5arnIDDQFxIXIhNlUW68diDNLKncUg0hoX7qT81+Dnkh+yaPBg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4167
x-originatororg: quicinc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add support for eight CRC-related MIPS<32|64>R6 instructions.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  disas/mips.c            |   8 +++
>  target/mips/helper.h    |   2 +
>  target/mips/op_helper.c |  19 ++++++++
>  target/mips/translate.c | 127
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 156 insertions(+)
>
> diff --git a/disas/mips.c b/disas/mips.c index dfefe5e..75c48b3 100644
> --- a/disas/mips.c
> +++ b/disas/mips.c
> @@ -1409,6 +1409,14 @@ const struct mips_opcode mips_builtin_opcodes[]
> =3D
>  {"dvp",        "t",     0x41600024, 0xffe0ffff, TRAP|WR_t,            0,=
 I32R6},
>  {"evp",        "",      0x41600004, 0xffffffff, TRAP,                 0,=
 I32R6},
>  {"evp",        "t",     0x41600004, 0xffe0ffff, TRAP|WR_t,            0,=
 I32R6},
> +{"crc32b",     "t,v,t", 0x7c00000f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,=
 I32R6},
> +{"crc32h",     "t,v,t", 0x7c00004f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,=
 I32R6},
> +{"crc32w",     "t,v,t", 0x7c00008f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,=
 I32R6},
> +{"crc32d",     "t,v,t", 0x7c0000cf, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,=
 I64R6},
> +{"crc32cb",    "t,v,t", 0x7c00010f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,=
 I32R6},
> +{"crc32ch",    "t,v,t", 0x7c00014f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,=
 I32R6},
> +{"crc32cw",    "t,v,t", 0x7c00018f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,=
 I32R6},
> +{"crc32cd",    "t,v,t", 0x7c0001cf, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,=
 I64R6},
>
>  /* MSA */
>  {"sll.b",   "+d,+e,+f", 0x7800000d, 0xffe0003f, WR_VD|RD_VS|RD_VT,  0,
> MSA},
> diff --git a/target/mips/helper.h b/target/mips/helper.h index
> 7b8ad74..2095330 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -40,6 +40,8 @@ DEF_HELPER_FLAGS_1(bitswap,
> TCG_CALL_NO_RWG_SE, tl, tl)  DEF_HELPER_FLAGS_1(dbitswap,
> TCG_CALL_NO_RWG_SE, tl, tl)  #endif
>
> +DEF_HELPER_3(crc32, tl, tl, tl, i32)
> +DEF_HELPER_3(crc32c, tl, tl, tl, i32)
>  DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
>
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c index
> 18fcee4..5cd396d 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -27,6 +27,8 @@
>  #include "exec/memop.h"
>  #include "sysemu/kvm.h"
>  #include "fpu/softfloat.h"
> +#include "qemu/crc32c.h"
> +#include <zlib.h>
>
>
> /**********************************************************
> *******************/
>  /* Exceptions processing helpers */
> @@ -350,6 +352,23 @@ target_ulong helper_rotx(target_ulong rs, uint32_t
> shift, uint32_t shiftx,
>      return (int64_t)(int32_t)(uint32_t)tmp5;  }
>
> +/* these crc32 functions are based on target/arm/helper-a64.c */
> +target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t

Shouldn't this be "HELPER(crc32)"?

> +sz) {
> +    uint8_t buf[8];
> +
> +    stq_le_p(buf, m);
> +    return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff); }
> +
> +target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t

Shouldn't this be "HELPER(crc32c)"?

> +sz) {
> +    uint8_t buf[8];
> +
> +    stq_le_p(buf, m);
> +    return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff); }
> +
>  #ifndef CONFIG_USER_ONLY
>
>  static inline hwaddr do_translate_address(CPUMIPSState *env, diff --git
> a/target/mips/translate.c b/target/mips/translate.c index 4bff585..1b3835=
6
> 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -451,6 +451,7 @@ enum {
>      OPC_LWE            =3D 0x2F | OPC_SPECIAL3,
>
>      /* R6 */
> +    OPC_CRC32          =3D 0x0F | OPC_SPECIAL3,
>      R6_OPC_PREF        =3D 0x35 | OPC_SPECIAL3,
>      R6_OPC_CACHE       =3D 0x25 | OPC_SPECIAL3,
>      R6_OPC_LL          =3D 0x36 | OPC_SPECIAL3,
> @@ -2547,6 +2548,7 @@ typedef struct DisasContext {
>      bool nan2008;
>      bool abs2008;
>      bool saar;
> +    bool crcp;
>  } DisasContext;
>
>  #define DISAS_STOP       DISAS_TARGET_0
> @@ -27117,11 +27119,96 @@ static void
> decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
>      }
>  }
>
> +static void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,
> +                      int crc32c)
> +{
> +    TCGv t0;
> +    TCGv t1;
> +    TCGv_i32 tsz =3D tcg_const_i32(1 << sz);
> +    uint64_t mask =3D 0;

Should be uint32_t

> +
> +    if (rd =3D=3D 0) {
> +        /* Treat as NOP. */

Need to free tsz on this path or wait to assign with t0/t1

> +        return;
> +    }
> +    t0 =3D tcg_temp_new();
> +    t1 =3D tcg_temp_new();
> +
> +    gen_load_gpr(t0, rt);
> +    gen_load_gpr(t1, rs);
> +
> +    if (sz !=3D 3) {
> +        switch (sz) {
> +        case 0:
> +            mask =3D 0xFF;
> +            break;
> +        case 1:
> +            mask =3D 0xFFFF;
> +            break;
> +        case 2:
> +            mask =3D 0xFFFFFFFF;
> +            break;
> +        }
> +        tcg_gen_andi_tl(t1, t1, mask);
> +    }
> +
> +    if (crc32c) {
> +        gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);
> +    } else {
> +        gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);
> +    }
> +
> +    tcg_temp_free(t0);
> +    tcg_temp_free(t1);
> +    tcg_temp_free_i32(tsz);
> +}
> +
> +static void gen_crc32b(DisasContext *ctx, int rd, int rs, int rt) {
> +    gen_crc32(ctx, rd, rs, rt, 0, 0);
> +}
> +
> +static void gen_crc32h(DisasContext *ctx, int rd, int rs, int rt) {
> +    gen_crc32(ctx, rd, rs, rt, 1, 0);
> +}
> +
> +static void gen_crc32w(DisasContext *ctx, int rd, int rs, int rt) {
> +    gen_crc32(ctx, rd, rs, rt, 2, 0);
> +}
> +
> +static void gen_crc32d(DisasContext *ctx, int rd, int rs, int rt) {
> +    gen_crc32(ctx, rd, rs, rt, 3, 0);
> +}
> +
> +static void gen_crc32cb(DisasContext *ctx, int rd, int rs, int rt) {
> +    gen_crc32(ctx, rd, rs, rt, 0, 1);
> +}
> +
> +static void gen_crc32ch(DisasContext *ctx, int rd, int rs, int rt) {
> +    gen_crc32(ctx, rd, rs, rt, 1, 1);
> +}
> +
> +static void gen_crc32cw(DisasContext *ctx, int rd, int rs, int rt) {
> +    gen_crc32(ctx, rd, rs, rt, 2, 1);
> +}
> +
> +static void gen_crc32cd(DisasContext *ctx, int rd, int rs, int rt) {
> +    gen_crc32(ctx, rd, rs, rt, 3, 1);
> +}
> +
>  static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
> {
>      int rs, rt, rd, sa;
>      uint32_t op1, op2;
>      int16_t imm;
> +    int sz, crc32c;
>
>      rs =3D (ctx->opcode >> 21) & 0x1f;
>      rt =3D (ctx->opcode >> 16) & 0x1f;
> @@ -27131,6 +27218,45 @@ static void
> decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
>
>      op1 =3D MASK_SPECIAL3(ctx->opcode);
>      switch (op1) {
> +    case OPC_CRC32:
> +        sz =3D extract32(ctx->opcode, 6, 2);
> +        crc32c =3D extract32(ctx->opcode, 8, 3);
> +        if (unlikely(!ctx->crcp) ||
> +            unlikely((sz =3D=3D 3) && (!(ctx->hflags & MIPS_HFLAG_64))) =
||
> +            unlikely((crc32c >=3D 2))) {
> +            generate_exception_end(ctx, EXCP_RI);
> +        }
> +        switch (sz) {
> +        case 0:
> +            if (crc32c) {
> +                gen_crc32cb(ctx, rt, rs, rt);
> +            } else {
> +                gen_crc32b(ctx, rt, rs, rt);
> +            }
> +            break;
> +        case 1:
> +            if (crc32c) {
> +                gen_crc32ch(ctx, rt, rs, rt);
> +            } else {
> +                gen_crc32h(ctx, rt, rs, rt);
> +            }
> +            break;
> +        case 2:
> +            if (crc32c) {
> +                gen_crc32cw(ctx, rt, rs, rt);
> +            } else {
> +                gen_crc32w(ctx, rt, rs, rt);
> +            }
> +            break;
> +        case 3:
> +            if (crc32c) {
> +                gen_crc32cd(ctx, rt, rs, rt);
> +            } else {
> +                gen_crc32d(ctx, rt, rs, rt);
> +            }
> +            break;
> +        }
> +        break;
>      case R6_OPC_PREF:
>          if (rt >=3D 24) {
>              /* hint codes 24-31 are reserved and signal RI */ @@ -30727,=
6
> +30853,7 @@ static void mips_tr_init_disas_context(DisasContextBase
> *dcbase, CPUState *cs)
>      ctx->mrp =3D (env->CP0_Config5 >> CP0C5_MRP) & 1;
>      ctx->nan2008 =3D (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
>      ctx->abs2008 =3D (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
> +    ctx->crcp =3D (env->CP0_Config5 >> CP0C5_CRCP) & 1;
>      restore_cpu_state(env, ctx);
>  #ifdef CONFIG_USER_ONLY
>          ctx->mem_idx =3D MIPS_HFLAG_UM;
> --
> 2.7.4
>
>


