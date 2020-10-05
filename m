Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E18220774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="tDFkYQwp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="LQ8s+G/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E18220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTdi-0007te-Cb
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kPTaP-0005ED-Ka
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:43:45 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:46099)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kPTaK-0000X7-TI
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601916216; x=1633452216;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dccUv+EgxA1+JBzZzdY4fv2KErB3dFus2Qj/bvGTDKE=;
 b=tDFkYQwpLnSpoOdaoEpGSmriK6tpu76hCjkqFihbz99g5Q28v1Se/1rs
 HeTQ8jTIeqs6JeqimvkM4ssLPcuhREbPB6pZ1idpzKyDTJCa3p/R0GMOt
 qeqs3WfKI1SiXyPs6qs/6/pfeyWTMcnoGtNJ+svlnPbgiZdcT6fLZi1m8 g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Oct 2020 09:43:33 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 05 Oct 2020 09:43:33 -0700
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Oct 2020 09:43:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 5 Oct 2020 09:43:32 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6385.namprd02.prod.outlook.com (2603:10b6:a03:1f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Mon, 5 Oct
 2020 16:43:31 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 16:43:31 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 12/21] contrib/gitdm: Add Qualcomm to the domain map
Thread-Topic: [RFC PATCH 12/21] contrib/gitdm: Add Qualcomm to the domain map
Thread-Index: AQHWmnjn87k4xPaKgU2kVSCTyKic/KmJN7Ig
Date: Mon, 5 Oct 2020 16:43:31 +0000
Message-ID: <BYAPR02MB48862625A29ADFA10F8EBED2DE0C0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-13-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-13-f4bug@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89e62b8c-c5e9-4d8d-b1ef-08d8694dcb1f
x-ms-traffictypediagnostic: BY5PR02MB6385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB638580279DA9DA295C974805DE0C0@BY5PR02MB6385.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WUZM9bqzDviZ+r8zuAK425rpuBewplK6RMcQj+bSWONUVzIyhp6wZq8qAsjYetGBdn669qydWBKZCpCy5Ah+POX6nL5LTSQIeOVRl0a+DXcOMhwukUB4Gvde500yQnS1NSNJ/XTs7Ap2wfg/7Qp66lY6USip91owg5SXCjg9nTxVZDP8CkDfnsHy5TQcRlAiuv5dcAxt/Z+HfofqHGtps6GhS1y/CzEe4toc708TUC1xL6lz9fuUQQLCZ6pmqOVW2/R7vVIQRitSScUrTHurnggnRN0F64rMsb38QO+5Sh3QycedI+VMOSDg5MFqbf5Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(55016002)(8676002)(478600001)(4744005)(8936002)(33656002)(186003)(26005)(2906002)(83380400001)(9686003)(5660300002)(54906003)(52536014)(107886003)(316002)(53546011)(110136005)(71200400001)(7696005)(66476007)(66556008)(86362001)(66446008)(64756008)(66946007)(76116006)(6506007)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: C3FzzEWodEECIaDi1eFoWxvihlnl1A6MM9bZBDR7GkaZnR6X186g47iyRhthN4E0BdwrFufHE/DgSEMq52Mucc+/it/SdnDY0tlzL02yJf5rNHHFYS3od8xIcVmSim3WAEjdI6u/jQBiFLESJayjzYAd/VBmZNcMSVOumpSpMB1oBUR2QvRJDw8W/NuLVovKQmn3sbXfS/Su3YGpBYC32rtIRw48BUOa+HJ0Qi9QhNx+rLISwZqSsbpOKrbTY/As7cOD4YQ9RaGVfG8Yhpf6BZQJ+hli+ybrGvN1+md75VogtEctROPURXokT2N7Awl0imYfRF+wDekXaFBVC1Egm+qNw4iXGtKfWrl+GcSmnQ/q/nhW5O78rosBievso+7utZbVtHfrYqXtpS6XO2xEGolwKnaTMiF6pcOYMian+Bb78fE25Xh+m2HP7Ix1JDj9eGpxAFhJjg0sXMf8+QhlS1q/nLDh4mXu/Ly7q1gLddYLyamE24+y4Fx0b8L+e7lbJS5dN2qqFqbpeiqNHlnBWC5P+DxNQN4SdlEPBNuPW4zPxAjo8lSOtq1Y+ILWO/v+/6Nu3VA4P4k60IohT41ByxQyVuqX4QYy4IoXPMCKhAKMQ9iRdXTpBnQdlufy/Tp2LJJKl9ALPgv47u0biY247g==
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh5OQLFkpFQnPbXCE8APFfbAzhzjNQCf53/AeRgjQgCqnMNCO8e5FON8MB3UVJWZptrJFRlEqF3i3ZR7mKbltSdF2mpO6FeIFuUh3dc/vg3lVJxG7VMiDGezFofL5Yzdi6lszL0mr8BJ4bM5iJFj4l7FfsE+Qtzy3D8T21rwjmST5p0o2lObxUP6XrRMmTzy/yIZIa4UhTZGPanGTp5sl7NDBiHdyF0B6xdYXwKyYb+paKSZFbf1a/Xi17v9EsqDAhA2GeUAIzw6MAais3ss+YhM/APFtCnbS8WO3AdeSP6X8dOmgIhLZ7LtDnJtpf+dx4xE0C7xgim+Lc29KdhGlA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qPPwE1GQBu/DPL7JVDMCUEuk/On5gVmdfpYYDkConA=;
 b=HjOw9efO5+LJuASE+v5JIH/J4nFVvz0yqBzO9JnlIasMgN6hFzf1K07pzO80/YIXkYgr4F5hVob6GrnPGMbUMbIZZ0D3ibbqK6kOrInTXaJmQxco0wjOFeN69RLfznl424dJj+2emSWu0dcqQacKvKiVawnyPvGuMbC/fh2mO8WTc1EayqIw5YIXQG1LKqB1kS1CaTf7MXnc4opm3xTr9XrQ1/pue0c22e43mYHH5pkGnhuEgjlXAOEv2OMaPA3Qh8VG3C1fK/o1rTk568JPWPKOEtjyIpHmAgEEVHxT8OhQBaxvGpsRxqftOu6MyERyWzhHEvFSbbQDn+ZtHnNonw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qPPwE1GQBu/DPL7JVDMCUEuk/On5gVmdfpYYDkConA=;
 b=LQ8s+G/n0KfPOV/2etPQcVUnOHOmSHNk2uImoN6WWPHs3CKyHnBMJK/p37E2e8Q+8TEkJNA0EN3HvSU0NJh7QS3BH++QK22tMVzHApjetHN6MJgglYFW+99EFByUbFiYesLpFily04CtlcRDjzzKgA9011Vh8gXj010b7Nqq71I=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 89e62b8c-c5e9-4d8d-b1ef-08d8694dcb1f
x-ms-exchange-crosstenant-originalarrivaltime: 05 Oct 2020 16:43:31.2536 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: m6gKZ0m5msISeQGlUoz8s7bNZqnyow/nFUO7JT7f7Ci+jVLJGGRkMOKXWcOT0m4c3gyG+KVORMrZJse3M9Fuug==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6385
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:43:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbGlwcGUubWF0aGlldS5kYXVkZUBnbWFpbC5jb20+IE9uDQo+IEJlaGFsZiBPZiBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqQ0KPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgNCwgMjAyMCAx
MjowNSBQTQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBBbGV4IEJlbm7DqWUg
PGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqQ0KPiA8ZjRi
dWdAYW1zYXQub3JnPjsgU3RlcGhlbiBMb25nIDxzdGVwbG9uZ0BxdWljaW5jLmNvbT47IFRheWxv
cg0KPiBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4NCj4gU3ViamVjdDogW1JGQyBQQVRD
SCAxMi8yMV0gY29udHJpYi9naXRkbTogQWRkIFF1YWxjb21tIHRvIHRoZSBkb21haW4NCj4gbWFw
DQo+DQo+IGRpZmYgLS1naXQgYS9jb250cmliL2dpdGRtL2RvbWFpbi1tYXAgYi9jb250cmliL2dp
dGRtL2RvbWFpbi1tYXANCj4gaW5kZXggZDdkY2E1ZWZkNC4uNDc1MjJkZmYwMiAxMDA2NDQNCj4g
LS0tIGEvY29udHJpYi9naXRkbS9kb21haW4tbWFwDQo+ICsrKyBiL2NvbnRyaWIvZ2l0ZG0vZG9t
YWluLW1hcA0KPiBAQCAtMjgsNiArMjgsNyBAQCBudXRhbml4LmNvbSAgICAgTnV0YW5peA0KPiAg
bnV2aWFpbmMuY29tICAgIE5VVklBDQo+ICBvcmFjbGUuY29tICAgICAgT3JhY2xlDQo+ICBwcm94
bW94LmNvbSAgICAgUHJveG1veA0KPiArcXVpY2luYy5jb20gICAgIFF1YWxjb21tDQoNClRoaXMg
c2hvdWxkIGJlICJRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciINCg0KVGhlbiwNClJldmlld2Vk
LWJ5IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4NCg0KDQo=

