Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C975C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD0120656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="JN+oGMoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD0120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfmc4-00008s-2y
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46796)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hfmXD-0006eF-IH
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hfmXB-00047V-Rx
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:34:59 -0400
Received: from mail-eopbgr710093.outbound.protection.outlook.com
 ([40.107.71.93]:42210 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hfmXB-00041h-C1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLVg4pmJWwlhgdYnMjCL4bseAFsp2RzG5NiQaxyTfls=;
 b=JN+oGMoeWxjC4jvDf+GOxMYHE3HA5IaGFSS3IFVxSotyqPG+/smf+BOnGpRuWJhfuOZ22BrHsHO8KEh2+5gS9KMj343DkR6yD42L1JlqfA9Gcq+bL2nwdwqwXv0ospV0dz+/gx3vGScv2BOylXVQlksHGOt9IdUxgkZfUuiyTFU=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0395.namprd22.prod.outlook.com (10.173.175.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 14:34:50 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 14:34:50 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 1/2] dma/rc4030: Fix off-by-one error in specified memory
 region size
Thread-Index: AQHVK2IlIJh4xRxCNUKQiCCvE3Nxlqasbzz7
Date: Tue, 25 Jun 2019 14:34:49 +0000
Message-ID: <DM5PR22MB1658932B6874A4143E937CEDD2E30@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1561472838-32272-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <1561472838-32272-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1561472838-32272-2-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5137173f-bd9e-4d04-5224-08d6f97a477a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM5PR22MB0395; 
x-ms-traffictypediagnostic: DM5PR22MB0395:
x-microsoft-antispam-prvs: <DM5PR22MB0395F48D3586291A5068BBB9D2E30@DM5PR22MB0395.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:287;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(396003)(376002)(39850400004)(189003)(199004)(316002)(4326008)(8936002)(66556008)(81166006)(81156014)(8676002)(86362001)(110136005)(66066001)(229853002)(99286004)(6606003)(19627405001)(71200400001)(478600001)(74316002)(71190400001)(14454004)(2501003)(68736007)(14444005)(73956011)(7696005)(3846002)(186003)(6116002)(25786009)(54906003)(33656002)(446003)(6246003)(476003)(7736002)(55016002)(52536014)(5660300002)(26005)(55236004)(102836004)(2906002)(54896002)(76176011)(66476007)(486006)(6506007)(53936002)(6436002)(76116006)(9686003)(53546011)(91956017)(64756008)(66946007)(66446008)(11346002)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0395;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XDdWH1NvqA1TAO+bPbElxiGqQXwq9e0UWaSYIrkfL2n1glYpW5p9+UdnawSLDdWvL2uvjwzW9/6vGY56JI48DGiVMgxFH65DZgV50otio4NEYeUzjR5nzTeZJuQXfwz2r6FBEvxE5xS63y60AYhpW9nw0JSin1WCkm+2CYQM5ogCO2TT/6esxq/+8SCiiPlnOFQVzMU4Z7WjjV51NDgiQ2d/voeOrzxMRUWy9s1ObtfzlH28Frd+XiI1odHVdzRMvWHoAMRY3XrW9ByvSHBhfgLav5g+o8EdGxXtApr5XpzsiOFOnZY49NBAyGwZIyl0wDzy03ROJoam5SRa/MUNNS6Fq4dWCX6jkUKO0rqX5xhvxFMcPBE1d3ErUnmd6JzYgU35g4+n95uFTchw1VP9n+Bli0LtiupP/FZ1VNKnP+M=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5137173f-bd9e-4d04-5224-08d6f97a477a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 14:34:49.9029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0395
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.93
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/2] dma/rc4030: Fix off-by-one error in
 specified memory region size
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
Cc: "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Tuesday, June 25, 2019 4:27 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; Aleksandar Rikalo; hpoussin@reactos.org; f4bug@a=
msat.org
> Subject: [PATCH 1/2] dma/rc4030: Fix off-by-one error in specified memory=
 region size
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The size is one byte less than it should be:
>
> address-space: rc4030-dma
>   0000000000000000-00000000fffffffe (prio 0, i/o): rc4030.dma
>
> rc4030 is used in MIPS Jazz board context.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/dma/rc4030.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 6ccafec..88ff271 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -23,6 +23,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/mips/mips.h"
>  #include "hw/sysbus.h"
> @@ -678,7 +679,7 @@ static void rc4030_realize(DeviceState *dev, Error **=
errp)
>
>      memory_region_init_iommu(&s->dma_mr, sizeof(s->dma_mr),
>                               TYPE_RC4030_IOMMU_MEMORY_REGION,
> -                             o, "rc4030.dma", UINT32_MAX);
> +                             o, "rc4030.dma", 4 * GiB);
>      address_space_init(&s->dma_as, MEMORY_REGION(&s->dma_mr), "rc4030-dm=
a");
>  }
>
> --
> 2.7.4

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

