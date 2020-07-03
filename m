Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33767C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E22207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="e2Qbl/h3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E22207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNQN-0001hC-87
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jrNOv-0008Tk-Oz; Fri, 03 Jul 2020 11:14:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:61651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jrNOs-0003Xb-Ta; Fri, 03 Jul 2020 11:14:53 -0400
IronPort-SDR: /NOObGlBjXw4nibM4mKrA4DvOTDaQZTMHqEgd+fV5NorOT3IGKtco34vcovKeJORAADguo+yxg
 Oskxs25/834Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="212178762"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; d="scan'208";a="212178762"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2020 08:14:46 -0700
IronPort-SDR: QyO5J0s1LRHNI2dUd4FP6VBanbbk9ry26Icc8YNoQ3kaowH5jLOGwYot3iAtKjtbVcOXrR2K/S
 FBZK5Qi+BOZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; d="scan'208";a="482045410"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
 by fmsmga006.fm.intel.com with ESMTP; 03 Jul 2020 08:14:46 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Jul 2020 08:14:46 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX157.amr.corp.intel.com (10.22.240.23) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Jul 2020 08:14:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 3 Jul 2020 08:14:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVZgRs26NBIKi5V0w0i6XLHUsv/IjCujW9xvcse+TyNGBfcRIMj/yUwwQm6LZl6QSJx88C0/faFQfwnIAiqVXSnBVZBInLvWOdVmc8/JVLtBIVqdYpgmmAGCTqlOcO5/4HiG6PyCNXhyyOwM8LugX0uDtOvuMeEOt7YOuqeGNu0OMU9UDVFxmUsx8GU8t6y3rYf4fQSWA11OL+tG8/hpdvX2KmNRRzfo5/S8lH9I4Xb8SyPcwYxuJ6WnYcFf8u14BHqOGVTqdHHbvILHTzlMh2RHWIcg1AYRslxB6sWG9CypGl22KcmtQzSSKu1lD2sNAuKlT47TaePwllcvBNXpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/I9wytZd2Cvujic9/0SsJ+iO4EvwV3u7HUx2/4Lh/0=;
 b=P6itoESUOS5jF1VkL4mkir6GDApxXmranVW7X2QsGLiD/i9knHV6fR/actwz155khH1fAAZgjVhhz7O3EWYF5qoMHmpwj8CgAsLC75W0qD6JX4TT7avDXoY1SQ+5qyRldHfcsb/oZAdDBaExIecsshwLNMR8xqOd+G58G8AbnqwE/5qRkYUZPhgmY+Rd5tCM3aqAfKGHsaqGTiWB4NHTOX74kXjSgtY81DxCgf3phPOJURSnFWd17YEU+WZ/Ef0Ppk8K7AvrFHdKtCSgXrDW9TXO1gUvT9x/NtWeqUN+p8GZNMDCZ9sNeKeeJK60DlH97V2TC4Ul8EZGnIQKTedv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/I9wytZd2Cvujic9/0SsJ+iO4EvwV3u7HUx2/4Lh/0=;
 b=e2Qbl/h3KRdzhuVoRPwNsTOodMYo7x02yeKDLpDk8UsXI+6uwgc740YJwASAlZ+kkYoa88FkrD/6iRUTOBczFmDrqgXeKD6M3l0/gt5I57A1Zt6wyhFmbq1QHtt63dYWMizJW1df3R8oDDpO/a1DWLQYPxml/pSZCZOKXo/7vQQ=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM5PR11MB1657.namprd11.prod.outlook.com (2603:10b6:4:c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.28; Fri, 3 Jul 2020 15:14:43 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 15:14:43 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: RE: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Topic: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Index: AQHWTe3BOsAD/7AE8EK8jau5tLLWZaj1/RtQ
Date: Fri, 3 Jul 2020 15:14:43 +0000
Message-ID: <DM5PR11MB183338A161C56ABA804913A48D6A0@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
In-Reply-To: <20200629160535.3910-3-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52afeafb-3ed8-46b6-c175-08d81f63d0c7
x-ms-traffictypediagnostic: DM5PR11MB1657:
x-microsoft-antispam-prvs: <DM5PR11MB1657AF8655E99BE3CD7D8D238D6A0@DM5PR11MB1657.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTOuTYGTD/GpwCMB9MnEfJYywqMS4ny6eEO5yK7M7FoQ7dBP5oLo+u7S/ZD+cEAl/n6oxn+adExDREDBDiMWPPhhnMb/kspcUbmftKuYULxtS/k1fBgrFIzX/X5hVj+72Vf2ebxh6oNrXFMklxI7fkphb0O+g4fDaWOjkYsUkzSNZ92Hn3U6mHmgPhDlRJcrpMYn5+2ucRIPb8EOGBdJlhbjjCGeppYEQtiakgJ7+vaFXZNqV5oCH5EuP26SzXdT7lN7EOnO2h5djQSXDybphSsHENOHwvGRAAjG3eJzCakdPIrBKvI3b0RNbNinbkoee16hC3Qe+fHIHXVh9rYKMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(2906002)(8676002)(86362001)(52536014)(83380400001)(55016002)(5660300002)(9686003)(8936002)(71200400001)(186003)(53546011)(4326008)(6506007)(33656002)(6916009)(26005)(316002)(54906003)(478600001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: yjJltixEDi5dePwuxJtOn7QrxPx8zEjC0S5WAAUqSfEQhvT8sUg+lZzYe60rkdD1ampxv/5dLqmRmeB9DA1RkEkmFvDBcfTSU5mZ+zBTozrnEWI5Lrzx35SjTB4iNjeLNJKnMVfa5LHzAYUwiRv8QsZ041UDrfK3WIYAVs13If/KjZefuYCJ1RX8pygbj5u3sS63yR2Q+ZSYOeEwdgPFGXyI6+Np3qkdjNHNrEinxgc70/bxdakwsyycf2jnmcIC7nXz1p8CaP5xJTgz2i+bi6j+qcCMkmqy7LR3yqtZ7X+QTdYgsAQvbKUHuyCgxpkYFnmP6jeuZZXENDqjQrTADq+rvcCxbeektc+K7WkKLqziVrTitKKqFqqMDTk5T6sBRXPKYqb5UKJRAG7qJIs5ZssgN9GoPMLXcX0X+QjWZP/WgOVOysAWSG7t5HV3OOEiPPxTHM2j1nmtzaVHyPx8ICczki+nLuWbr+h3tXCDj3oT4d15cw7LVdvM49ZqznTr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52afeafb-3ed8-46b6-c175-08d81f63d0c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 15:14:43.4802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ig7QuPdMUq8z6CVw0kOQeJb8WvsPgDNfyVBj5dk3hUDJwNG5i0YJtvOtS6m0G/+FepCMK4qaio21njHxKBSQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1657
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=wentong.wu@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:14:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "marex@denx.de" <marex@denx.de>, "crwulff@gmail.com" <crwulff@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

HI Peter,
Could you please take a look at this patch which is following your pervious=
 suggestion?

Thanks

-----Original Message-----
From: Wu, Wentong <wentong.wu@intel.com>=20
Sent: Tuesday, June 30, 2020 12:06 AM
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org; crwulff@gmail.com; marex@denx.de; peter.maydel=
l@linaro.org; Wu, Wentong <wentong.wu@intel.com>
Subject: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl instructio=
n

wrctl instruction on nios2 target will cause checking cpu interrupt but tcg=
_handle_interrupt() will call cpu_abort() if the CPU gets an interrupt whil=
e it's not in 'can do IO'
state, so add gen_io_start around wrctl instruction. Also at the same time,=
 end the onging TB with DISAS_UPDATE.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 target/nios2/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c index 83c1=
0eb2..51347ada 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -32,6 +32,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
+#include "exec/gen-icount.h"
=20
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically *=
/
@@ -518,7 +519,11 @@ static void wrctl(DisasContext *dc, uint32_t code, uin=
t32_t flags)
     /* If interrupts were enabled using WRCTL, trigger them. */  #if !defi=
ned(CONFIG_USER_ONLY)
     if ((instr.imm5 + CR_BASE) =3D=3D CR_STATUS) {
+        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_helper_check_interrupts(dc->cpu_env);
+        dc->is_jmp =3D DISAS_UPDATE;
     }
 #endif
 }
--
2.21.3


