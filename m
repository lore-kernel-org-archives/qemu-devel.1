Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76080C3B186
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428F52168B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KN05SY/s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="MG6/XXgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428F52168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1vx7-0001lB-Bv
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 12:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1j1vwO-0000oj-Ut
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1j1vwM-0002pP-VF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:36:48 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1j1vwM-0002ow-Hn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581529006; x=1613065006;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FUym38OoqMVQBQ8ydyZKOOg3I/mfjpRRyiKKu9uopoY=;
 b=KN05SY/sydFtn7z1bmYkK7V0KNu1c1HYrQxFAeGWotzfpqsRs3Z4lXTj
 WrgldlrrmgG88T/bSD8/H94uyGXYCvzUEa/UiUwVK73wN76pjft6YJ7eU
 YhqM4rV6frzzbXfIoW5bzmQgoPH7rflpZW5srv9HVhXb5SPcls1eG6KIO 8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Feb 2020 09:36:45 -0800
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 12 Feb 2020 09:36:45 -0800
Received: from eusanexr01b.eu.qualcomm.com (10.85.0.99) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 12 Feb 2020 09:36:44 -0800
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 eusanexr01b.eu.qualcomm.com (10.85.0.99) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 12 Feb 2020 09:36:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 12 Feb 2020 09:36:42 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4197.namprd02.prod.outlook.com (20.176.251.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 17:36:41 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:36:41 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 29/66] Hexagon opcode data structures
Thread-Topic: [RFC PATCH 29/66] Hexagon opcode data structures
Thread-Index: AQHV4HP8wA2aaqNGXk2PUs5ssT63WKgVnEKAgAI4GfA=
Date: Wed, 12 Feb 2020 17:36:41 +0000
Message-ID: <BYAPR02MB4886DA16E63843D3405E37D2DE1B0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-30-git-send-email-tsimpson@quicinc.com>
 <154bb9da-0ee7-ac41-7a3e-3d0f9d5c0036@redhat.com>
In-Reply-To: <154bb9da-0ee7-ac41-7a3e-3d0f9d5c0036@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e7029d8-603d-4a96-ba9c-08d7afe21f14
x-ms-traffictypediagnostic: BYAPR02MB4197:
x-microsoft-antispam-prvs: <BYAPR02MB419774C315A42F33684A83D9DE1B0@BYAPR02MB4197.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(199004)(189003)(110136005)(4326008)(86362001)(52536014)(55016002)(54906003)(26005)(9686003)(7696005)(6506007)(53546011)(8676002)(8936002)(186003)(81166006)(33656002)(81156014)(2906002)(71200400001)(498600001)(66446008)(66946007)(76116006)(66476007)(5660300002)(66556008)(64756008)(4744005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4197;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixGE6mQ7XICKMppBf8P8iKD+/3sQam7hWWqut80BUlIKQ/SbayIK3C0FyfmYQB2ROpW5R5lukveWVM1Xf5uyqoC1J0DJreKqVBPSRF4aGhtuKMvCgFkov1lhpojPQHyiVJCjllqIooLXquklz8Qgr6oKUIPZnMqh3CKb/ZRBwo0mjq0vRRKueKT8aDg5f3ShcKbOv8Flg4oeQsHfP62ysW+5wKeIR2D9XG24/qxkSXqnAE48Z2B70iTLwpRPo48r3andpctSD8YwQwQCoNLabPkpOrJt2xgXA0Bmcj/YAZp0Q6SPmTXqHNCiSMyPC2JQKaoA5fQvkAB4eKT2WMk5gpWSX0i8Ma4Tbr4Lz1Z4cEIvGfrdqXuRjxrrfAOc92Yfn3QKlcBW5KrXHh/u9X85CRvOz7aQ+kN3R2AvHH8/B/j0RPj9NPLIygq68xd4/3vZ
x-ms-exchange-antispam-messagedata: y+0Nyt+KlVnFMo1X5Ozd8uRYzVSMf+UoXdENwaoE7/iS+sxzbB3Q4vhhmL+OkDKwLNPBK8oliv07bDF8p0HWMSxE3oTbpFGJwwC99MQuvncLtwp73GThEE6lni9YyvnwOp0kEEhLBTBYtyNQ7r8mnw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIEsNXD21oxPmbaEbkIyC63dwuypa9NGyCZIIF3h52/p1HSZxdM0d0TzE34dUzaU45bXTCQ3A/cjtalrhLw2MErbvYntxEiEBVBdhMDn/iht0pj29uO47uXI1HI4AGjkG3pC52dFUXC7H1W804j2MJqtAOmJQ3T2Gen6tM5CBf2cDI6GERJwrELaTr3Cj33H8hWp2IeAZ4nlrCMAlcslskoGl+s5wfuiKIFzq/KtdbkmlplutvPRuwUm7K1WMFRriaFtNKzTeAbAUw5dvxrCWNHgxfTScNveyK1OV+Fkz6wOsXQRif46CYuvt66/oH3ElVW5ZwgTAX4W6dpn6uwJgg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAJMKNOM9b+7xhB0e3F/EukOrLoJHaoFaSBp68dhO8g=;
 b=D3OFdA0j9l/vqug0lxpocpecvd4HRefNHoexOwaUW/Snimcb1O/onIVXeKqaEJmituonZlRf/C47ueCxysnCg8hd3gi7+RbpAYjql8nfuvnMP4Rzp/Kc2dIeNnGQIgp3NYNvvqKvc07CT/u2AIcOJEQeMpy8m+C8dMKMsMcNxpRx71auqg4BR7ZXDRze01jDiWxrG+h8SwogP8jJkyRSsu8LInAHF79COGsliCg0trvRB1d7b1U8yXeFPjog0Vky5Aw984lgvu39hEtx6D7KuwFAVsafGlxZA3ql7bNlbxMeosFiTdG+PTf78rOMwgA4kFRN6sUV2vQNBRf6Gw4krQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAJMKNOM9b+7xhB0e3F/EukOrLoJHaoFaSBp68dhO8g=;
 b=MG6/XXgSuzgtUGI3xj33qzRXR4dqPUZngwYDLN+gl8IxFAPNTGupyia/9wLf/LPkEITyDeUSRWZ8NgLTTH5UcFuPW2lYC28wpHRmWACXdbX95qy6ZwTrkySuZ4ojzPckcUJiO0bhi+fyVj3vpWzLkDSQkX5ReYggp3ikhWIHJhU=
x-ms-exchange-crosstenant-network-message-id: 1e7029d8-603d-4a96-ba9c-08d7afe21f14
x-ms-exchange-crosstenant-originalarrivaltime: 12 Feb 2020 17:36:41.2797 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: VtavwT7gLkjOHUkYiFeqos0/JyhM0dkYa23pgt8l52St3Rmj+yV3dzoM5OlJn7zhsBjUMh1Uy3u4MSjkQFAhRA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4197
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDExLCAy
MDIwIDE6NDEgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT47
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
ZzsgbGF1cmVudEB2aXZpZXIuZXU7IHJpa3Uudm9pcGlvQGlraS5maTsNCj4gYWxla3NhbmRhci5t
Lm1haWxAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDI5LzY2XSBIZXhhZ29u
IG9wY29kZSBkYXRhIHN0cnVjdHVyZXMNCj4NCj4gPiArI2lmbmRlZiBPUENPREVTX0gNCj4NCj4g
SEVYQUdPTl9PUENPREVTX0gNCj4NCj4gSSB3b25kZXIgaWYgaXQgd291bGQgZWFzZSByZXZpZXcg
dG8gc3BsaXQgdGhpcyBwYXRjaCBpbiAyLCBrZWVwIHRoZSBDDQo+IGhlcmUsIGJ1dCBwcm92aWRl
IG9wY29kZXMuaCBpbiBhbiBlYXJsaWVyIHBhdGNoLg0KDQpXb3VsZG4ndCB1c2luZyBzY3JpcHRz
L2dpdC5vcmRlcmZpbGUgc29sdmUgdGhpcyBqdXN0IGFzIHdlbGw/ICBJdCB3aWxsIHB1dCBvcGNv
ZGVzLmggYWhlYWQgb2Ygb3Bjb2Rlcy5jIGluIHRoaXMgcGF0Y2guDQoNCj4NCj4gPiArI2RlZmlu
ZSBPUENPREVTX0gNCj4gPiArDQo=

