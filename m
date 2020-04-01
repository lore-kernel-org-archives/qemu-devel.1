Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A60FC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 00:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644BE20721
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 00:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LZCcT3Zx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="nrL6TKNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644BE20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJnzm-0007Ma-K2
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 20:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <apazos@quicinc.com>) id 1jJkjh-0008Cx-4z
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 17:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <apazos@quicinc.com>) id 1jJkjd-0000Py-Sd
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 17:17:19 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:3306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <apazos@quicinc.com>)
 id 1jJkjd-0000Mr-37; Wed, 01 Apr 2020 17:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1585775837; x=1617311837;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uQqRv8+AHp8LDXIggurEEXdpVna0Cs7JnlC1psrkBJ0=;
 b=LZCcT3Zx79Bg+ETgbbcCSCFGZTkMHh2J+zxlOWfLZPFWmsWPm072Jb3z
 jRxdPCEF359uBua46USGHxEpsmGegvg+3HwxFzKzoH4Bznj7iiZM2iWDU
 HYNmFsy2feuL4+50S4nVQD9AhzjCUYn9+08+hnzJfZtQL8uLgpA7h/n7O w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Apr 2020 14:17:13 -0700
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 01 Apr 2020 14:17:13 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Apr 2020 14:17:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 1 Apr 2020 14:17:12 -0700
Received: from BYAPR02MB5480.namprd02.prod.outlook.com (2603:10b6:a03:9a::22)
 by BYAPR02MB4069.namprd02.prod.outlook.com (2603:10b6:a02:f9::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 1 Apr
 2020 21:17:11 +0000
Received: from BYAPR02MB5480.namprd02.prod.outlook.com
 ([fe80::555e:8aa2:2160:3209]) by BYAPR02MB5480.namprd02.prod.outlook.com
 ([fe80::555e:8aa2:2160:3209%6]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 21:17:11 +0000
From: Ana Pazos <apazos@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Subject: RE: [PATCH for-5.1 00/31] target/arm: SVE2, part 1
Thread-Topic: [PATCH for-5.1 00/31] target/arm: SVE2, part 1
Thread-Index: AQHWA8OEDy/AJi7Mmk+tnRHY8nzk8qhkyy0Q
Date: Wed, 1 Apr 2020 21:17:11 +0000
Message-ID: <BYAPR02MB54804D981F1AE6E66D2D9289C9C90@BYAPR02MB5480.namprd02.prod.outlook.com>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=apazos@quicinc.com; 
x-originating-ip: [108.225.56.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac2fa92-f8f8-4911-3a2e-08d7d6820b2f
x-ms-traffictypediagnostic: BYAPR02MB4069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB40699983634A8F1726800A04C9C90@BYAPR02MB4069.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5480.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(53546011)(54906003)(8676002)(966005)(5660300002)(4326008)(66446008)(81166006)(66946007)(81156014)(7696005)(64756008)(6506007)(76116006)(66556008)(26005)(186003)(9686003)(52536014)(478600001)(107886003)(316002)(6636002)(33656002)(71200400001)(86362001)(8936002)(55016002)(110136005)(66476007)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKqysN1JE0V0Wg7eBAtVDIoyYfe7z5izi+yGx5PWdDEY5fbSmYq5rSvu8EGwHJE421fPdoKJtyyB6odxkSlY8kUft2TbF3do9EQFVflsQjt/ukiVMiayjW3rpvKz5qLI36PB7lvXnCNdbz9iX2Wzpwm1MbV/r/30PlihddCS7PxsFvobrDuWOV+xsiFsz61Bd2IMAnOpQttpXxXSod2TymIywE/scOvSOUmnfIGzA7ZEKHjrzpp+sq+ZrtesqgY1CavuK5S9UpbR0iKV6p4PIlZEsI/YXD7s7Q6jH5iZSh23HLwWoUjq+in/9ZI4z85s+0FDNifjM+oJ8LHEdwf/lGQvzKFvrFUVrnmEHyQtp1dCRtHm0Uc+MsRLq4GPdbRAgzwyNycO8Ffn7T/k7JbVtmKl0IxbT2991oTMwu1lNfI/rfhBqSjactA5zTVU6hkdrQef8T3XEwGsoaJv/WGQ2fr+IuaEN5nftxe9Gd5j3gq8o9Z/3FDsjfx6zneFiOQ5ctI+9py5Ic2hc0t5O0r2tA==
x-ms-exchange-antispam-messagedata: xhXepxm4ixxMA25/zmQfONLrj6R5LZyjJiMuLlfJILzhehVm3JCD/zodN4bVKIZAmFsqSNaZjsTJoFEYbJi9LYBNuvTFdIgBxb58ZSu4cWZHAKdss2O6V44A06bGUgv9tmEJF13V/vS8KqIWETuJRQ==
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXfY6W5pRspth3ZT8fCVJEcixd0EutopgOeEj0JWFJGuPoJDrTIkj4rb3oAFIH+J1U4ZCBu1o1NIbdZD5DYbuDXI/uNNok1/4b96+DATMnx+b1LQTffxSFrkehDoxYwzSqOy4dIO4rPwURvxJ0CP78U7lcunZNscV+dsAT3mSNaC0J1WsqQqnuNPP9LW8XJECR7q92wq2tPAtEc2JtemJ04B7I/RtnwMEInrtSux/2MraEXP+4nwLQpdrF2otrqeP/lYOSTrp9k8JwIKGLqSceRJbHWyWUmtcyYeaYlNSFiwf+ncbIPKRdrOl38c97YMKIBIMK0ghsM2S4i5Ztaj+Q==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FSS9I4WJvCX9RwajQBJDmE9iOVAFqkpsgSB8UZvWhQ=;
 b=f8cufl9c82VnksZnI81yMGYatgYHFTzHHyZcaWvbX/Tht82Dc0vGPfrLmdhoyMhEBMVRsBd52Dubv5s5IcYijEvN5afAK0CcErR2cWefFOKOJIktzUVgTQOdZCZN3pA5DQhs9dEn8Bs4Y4kwffjfTIHNa2YzjVmZqh6FmA+sr/Nghq8wffdA8jWh7yfMqcF6eNrnFub7GDigDRCM+xGvHPjC6lkV6n76wZnS4KV0rO8uhITuQPdRynsNfv2QvCn5k7UQS0iHuW8JBnf4dg5JW2QrCx0+Ss9FmqUTNGCL/5RjieykaPEQhfMdrE2bL1frPivYL3bW66LKAYggugITJg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FSS9I4WJvCX9RwajQBJDmE9iOVAFqkpsgSB8UZvWhQ=;
 b=nrL6TKNfkq4NRAckdiOunMPz1R1ME4LUfkXtvhfILm4ys2N4wrV+dGC2NH/dEBrw62ujA7e5WF7uN45bir/l+/PujSApnCeRrr8nol+b+RcpQ/z4DiiB9GXvDijIMh5OCI25HE0YM0WEroHc/Xxwdu6aouxwDSZc/9k1lUyYsAI=
x-ms-exchange-crosstenant-network-message-id: 2ac2fa92-f8f8-4911-3a2e-08d7d6820b2f
x-ms-exchange-crosstenant-originalarrivaltime: 01 Apr 2020 21:17:11.6192 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: RdTtX3gqywq/Re1WX2D4YtPLw2EiOni8AztgTA0GQNMbp+JwdJbk9BFlmU7Y4Gn78J8DHMfJi6VCnGZQ8C4cwQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4069
x-originatororg: quicinc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
X-Mailman-Approved-At: Wed, 01 Apr 2020 20:43:31 -0400
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
Cc: Raja Venkateswaran <rajav@quicinc.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Ana Pazos <apazos@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Richard,

I want to introduce you to Stephen Long. He is our new hire who started thi=
s week.

I want to know if you are available for a sync-up meeting to discuss how we=
 can cooperate with qemu sve2 support.

Thank you,
Ana.

-----Original Message-----
From: Richard Henderson <richard.henderson@linaro.org>
Sent: Thursday, March 26, 2020 4:08 PM
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org; Ana Pazos <apazos@quicinc.com>; Raja Venkateswaran=
 <rajav@quicinc.com>
Subject: [PATCH for-5.1 00/31] target/arm: SVE2, part 1

-------------------------------------------------------------------------
CAUTION: This email originated from outside of the organization.
-------------------------------------------------------------------------

Posting this for early review.  It's based on some other patch sets that I =
have posted recently that also touch SVE, listed below.  But it might just =
be easier to clone the devel tree [2].
While the branch itself will rebase frequently for development, I've also c=
reated a tag, post-sve2-20200326, for this posting.

This is mostly untested, as the most recently released Foundation Model doe=
s not support SVE2.  Some of the new instructions overlap with old fashione=
d NEON, and I can verify that those have not broken, and show that SVE2 wil=
l use the same code path.  But the predicated insns and bottom/top interlea=
ved insns are not yet RISU testable, as I have nothing to compare against.

The patches are in general arranged so that one complete group of insns are=
 added at once.  The groups within the manual [1] have so far been small-is=
h.


r~

---

[1] ISA manual: https://static.docs.arm.com/ddi0602/d/ISA_A64_xml_futureA-2=
019-12_OPT.pdf

[2] Devel tree: https://github.com/rth7680/qemu/tree/tgt-arm-sve-2

Based-on: http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D163=
610
("target/arm: sve load/store improvements")

Based-on: http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D164=
500
("target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA")

Based-on: http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D164=
048
("target/arm: Implement ARMv8.5-MemTag, system mode")

Richard Henderson (31):
  target/arm: Add ID_AA64ZFR0 fields and isar_feature_aa64_sve2
  target/arm: Implement SVE2 Integer Multiply - Unpredicated
  target/arm: Implement SVE2 integer pairwise add and accumulate long
  target/arm: Remove fp_status from helper_{recpe,rsqrte}_u32
  target/arm: Implement SVE2 integer unary operations (predicated)
  target/arm: Split out saturating/rounding shifts from neon
  target/arm: Implement SVE2 saturating/rounding bitwise shift left
    (predicated)
  target/arm: Implement SVE2 integer halving add/subtract (predicated)
  target/arm: Implement SVE2 integer pairwise arithmetic
  target/arm: Implement SVE2 saturating add/subtract (predicated)
  target/arm: Implement SVE2 integer add/subtract long
  target/arm: Implement SVE2 integer add/subtract interleaved long
  target/arm: Implement SVE2 integer add/subtract wide
  target/arm: Implement SVE2 integer multiply long
  target/arm: Implement PMULLB and PMULLT
  target/arm: Tidy SVE tszimm shift formats
  target/arm: Implement SVE2 bitwise shift left long
  target/arm: Implement SVE2 bitwise exclusive-or interleaved
  target/arm: Implement SVE2 bitwise permute
  target/arm: Implement SVE2 complex integer add
  target/arm: Implement SVE2 integer absolute difference and accumulate
    long
  target/arm: Implement SVE2 integer add/subtract long with carry
  target/arm: Create arm_gen_gvec_[us]sra
  target/arm: Create arm_gen_gvec_{u,s}{rshr,rsra}
  target/arm: Implement SVE2 bitwise shift right and accumulate
  target/arm: Create arm_gen_gvec_{sri,sli}
  target/arm: Tidy handle_vec_simd_shri
  target/arm: Implement SVE2 bitwise shift and insert
  target/arm: Vectorize SABD/UABD
  target/arm: Vectorize SABA/UABA
  target/arm: Implement SVE2 integer absolute difference and accumulate

 target/arm/cpu.h           |  31 ++
 target/arm/helper-sve.h    | 345 +++++++++++++++++
 target/arm/helper.h        |  81 +++-
 target/arm/translate-a64.h |   9 +
 target/arm/translate.h     |  24 +-
 target/arm/vec_internal.h  | 161 ++++++++
 target/arm/sve.decode      | 217 ++++++++++-
 target/arm/helper.c        |   3 +-
 target/arm/kvm64.c         |   2 +
 target/arm/neon_helper.c   | 515 ++++---------------------
 target/arm/sve_helper.c    | 757 ++++++++++++++++++++++++++++++++++---
 target/arm/translate-a64.c | 557 +++++++++++++++++++++++----  target/arm/t=
ranslate-sve.c | 557 +++++++++++++++++++++++++++
 target/arm/translate.c     | 626 ++++++++++++++++++++++--------
 target/arm/vec_helper.c    | 411 ++++++++++++++++++++
 target/arm/vfp_helper.c    |   4 +-
 16 files changed, 3532 insertions(+), 768 deletions(-)  create mode 100644=
 target/arm/vec_internal.h

--
2.20.1



