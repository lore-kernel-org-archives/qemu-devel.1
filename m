Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF43C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02056206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e1DN3Tm4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="gCegKux9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02056206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasDJ-00023P-2g
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1jasCU-0001bY-9S
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:41:50 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:57190)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1jasCQ-0005Tw-KL
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1589856106; x=1621392106;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2bYx3GkDLVfKAtT5EKWNRAotORMsFKSUXUU/qHKgUns=;
 b=e1DN3Tm4NNsjv7/cvN6KRbXp3Xs00m9EJ+rPT6jcEHaMZCwPvDXxf6t8
 0KQzOAFzYOeJrDy229oi/YuRF6v7e7c4++OJUoCIMEcFYPqiWRZjLJF1c
 Q8mYTTvaoDj2VNY3fZhQnccPYTCUpE4oVlS6I1fy2ryKP1n+e7v83/9BV c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 18 May 2020 19:41:43 -0700
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 18 May 2020 19:41:42 -0700
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 May 2020 19:41:42 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 May 2020 19:41:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 18 May 2020 19:41:38 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5624.namprd02.prod.outlook.com (2603:10b6:a03:9c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Tue, 19 May
 2020 02:41:37 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3594:3599:aab9:8b8e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3594:3599:aab9:8b8e%6]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 02:41:37 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Alessandro Di Federico <ale.qemu@rev.ng>, "qemu-devel@nongnu.org
 Developers" <qemu-devel@nongnu.org>
Subject: RE: Simplifying the Hexagon frontend
Thread-Topic: Simplifying the Hexagon frontend
Thread-Index: AQHWLVl6hGn4gIdZTk6wPE5dWvryhaiurGIg
Date: Tue, 19 May 2020 02:41:37 +0000
Message-ID: <BYAPR02MB48866983EEF33E77096E8C50DEB90@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200518231508.141b524f@orange>
In-Reply-To: <20200518231508.141b524f@orange>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rev.ng; dkim=none (message not signed)
 header.d=none;rev.ng; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b3255bb-798e-4485-68a8-08d7fb9e271b
x-ms-traffictypediagnostic: BYAPR02MB5624:
x-microsoft-antispam-prvs: <BYAPR02MB5624350AA4A236F9A325185CDEB90@BYAPR02MB5624.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1owKGLdt5LTy216P8cOieBsFjLDCH9zjjTB71K9DeOT9u5jV7A2TdyfSTuhKgj58AQcLZp7GlfbhXIy301DhZUdbwHwFHJc54CWgbbjO/Cfy1jkJIJk1xQtp11BxcugBFktlL2zBIzAoI2zrGUXhB/oDPUxl4mnCZmvhZWplzpCN3wNgyiSYI7AdxiyVMyPK3YaZr/svEjwgnQ66J+QxkJnH/aoAWlgjDlxnvkqHdpz0dJowhdaEwr5osExPQP7BaCSbo7pDOVs65g/DpPjvO5hKgtVf2NmHWdKemLTEL07Qimq00rGJMvr/y3VpbkhPBYOl2/o0w/gT4cEzHePvRaQmksw5l5EElRlOpAfEv2G3/0BwGsvqM/THcCMyU3UYzS1mB7VWhQ0jb3qS+l6njfIMiHEGljRans+Uyx0YIQbs0nnp5RCduj0+F4XxQ+pamk5A+bvrcfQT+811edWsDSHnUf+TAD3U0BG7KvPQZ2BShWlvzCiF4GiVWD90UgcZYOcPwGViT/A8x6yKd8c8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(66946007)(33656002)(316002)(54906003)(110136005)(55016002)(9686003)(4326008)(2906002)(478600001)(3480700007)(966005)(52536014)(186003)(26005)(66556008)(76116006)(64756008)(66446008)(71200400001)(66476007)(6506007)(53546011)(7696005)(8936002)(5660300002)(86362001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: tuAN/8US3yggjbUjUHtXQHIx1NtoIwJIsWCELH4JbBASggybjFyUA/I9kFGR6R4ZlJ6ej3HtW1drNwbkP45iBoNVilXubdG8goXxI2HlqZRhRIReGMtu7XPgSGuZ0GEvNo/hWA4Z0LkUkZ3P/xBBe+YdRZXeLVJgKa1OmKxxesawqA6PjZ3H16CUecho8PCtCo1e+IueGSnCaCKLhuWiVD7GnWcRomIxixDMrlzEohofF7ITeYlkhVmbG+i7O/LmhqltPSBeZEv4xbAlF1aeHu9OyeK4iIuAcjCgo5YYFGV27P/FD9No8nJ7hpcbb5Rd3iaPIjp4N+WbEhsHkHTAgdpyvLkSML05hWaCUJFDXqt7MUKBATuYuHbl+gOOLbLPZO+s7FVQvdKL6LRQMA+xKY+mcnZUyJLDP5Xi6Sso03HgUbmEwZD4ezBdVgr60ImMW6B6re8Gx47mJP5iwmSMUzuitdV/zrt2VFSkLkSMFT0x+cscKwvRJF0rA1/QpdVG
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw8EwZeT4VzNf4ikoDKNsKjGPQYA6xgTjNzpPG/1JKw7J4JSfNBBz8JtVCv2FgAMqgUCSNkvjVUiChd2Yp80wF4CttfqLblWyYW7ClInEcDXPnfMlBRJJEcxyudOfvOKMWXQICCbCNVy6G7qY7D1Tsy3dKUu8gc44vdYffqyscGcIUKNakECtO3niVx8J/AEqcih+d3WYtBarPTwlQGdCEaCQI7nQ+3fI1vGAMSb9PNezZ+1o4gLTWlA9GRouS5LHt4FcrIZouTCDrwYKNsTuq0qPsj3b+j6HogUnnr/oBpWMxFy9lEyqGVD4NghNaP3xxQc5qVHw6SIHOtxl+KWEQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PysBEnImGxoubOvXlzdOT11nAiV/1fDZYTPv3Ik+/Yw=;
 b=bRRLoK2BrIOWVxgWIVr7M8U/80Y0Iw1dJutKHjecqv+h21pqKvf/P8SEudCD2siIciwrI1af7qlliKmnfG25Yx0qMBaSr8sMn/5Pjg7hsjH1WPRR33+/BORZa05f4XLj5VlnTsxjl1F+RHvcsCbuf8FClG7WKKps8p6m9SoTxoP8OlQ6qYKDN5ASCICG/EO0pqh1uges29aWkBSNZUfJFrr5MiV5J1VVY884E045fwEi/TWbAR6HLiFiAZ8ySqP+xcW0h4MeGaZTmesvIuadyh/Nfq9Q+vjMETRYVKjHcobk01hr+CjANna6KH1Y5pTkVUHO8ue4aGX81F0wvLjpdg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PysBEnImGxoubOvXlzdOT11nAiV/1fDZYTPv3Ik+/Yw=;
 b=gCegKux9BfTy2iEmc5idXUECl2SCwHb9iJOr86iidSqO0+dSCd+fGzazZ69lPydB4ngql9gw8gIgCaf6v9LbJi7KsKd9qwn/0D3E9YEgFx2lU+dz8Ig1qFptoWFpv8jC/44gTm7ouY+jeWOTWfxSc+JPnGussTdKxU9yjoEH4pU=
x-ms-exchange-crosstenant-network-message-id: 1b3255bb-798e-4485-68a8-08d7fb9e271b
x-ms-exchange-crosstenant-originalarrivaltime: 19 May 2020 02:41:37.4497 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: bViyUhZU7gK0RyitU7XnUXkjZqtuEkXLeGQGNm6Zw5C6jSR8QmNO9F1VipfuAW8EC+aT9IUdag/Ar1kSRlbMXQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5624
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 22:41:43
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?utf-8?B?TmljY29sw7IgSXp6bw==?= <nizzo@rev.ng>,
 Brian Cain <bcain@codeaurora.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxlc3NhbmRybyBEaSBG
ZWRlcmljbyA8YWxlLnFlbXVAcmV2Lm5nPg0KPiBTZW50OiBNb25kYXksIE1heSAxOCwgMjAyMCA0
OjE1IFBNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcgRGV2ZWxvcGVycyA8cWVtdS1kZXZl
bEBub25nbnUub3JnPg0KPiBDYzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29t
PjsgTmljY29sw7IgSXp6byA8bml6em9AcmV2Lm5nPjsNCj4gQnJpYW4gQ2FpbiA8YmNhaW5AY29k
ZWF1cm9yYS5vcmc+DQo+IFN1YmplY3Q6IFNpbXBsaWZ5aW5nIHRoZSBIZXhhZ29uIGZyb250ZW5k
DQo+DQo+IEhpLCB0aGlzIGUtbWFpbCBpcyBpbnRlbmRlZCB0byBib290c3RyYXAgYSBwdWJsaWMg
ZGlzY3Vzc2lvbiBvbiBob3cgdG8NCj4gaW1wcm92ZSB0aGUgSGV4YWdvbiBmcm9udGVuZCBpbXBs
ZW1lbnRhdGlvbi4gQXQgcmV2Lm5nLCBOaWNjb2zDsiBhbmQgSSwNCj4gZGV2ZWxvcGVkIGFuIEhl
eGFnb24gZnJvbnRlbmQsIGFuZCB3ZSdyZSAoZmluYWxseSEpIGpvaW5pbmcgZm9yY2VzIHdpdGgN
Cj4gdGhlIFF1SUMgZ3V5cyB0byBtZXJnZSBvdXIgZWZmb3J0cyAoZGlkIHlvdSBzZWUgb3VyIHRh
bGsgWzFdPykuDQo+DQo+IFRoZSBzdGF0dXMgaXMgYXMgZm9sbG93czoNCj4NCj4gKiBRdUlDIGhh
cyBpdHMgb3duIGZ1bGx5IHdvcmtpbmcgaW1wbGVtZW50YXRpb24gdGhhdCBoYXMgYmVlbiBzdWJt
aXR0ZWQNCj4gICBmb3IgcmV2aWV3Lg0KPiAqIFdlJ3JlIHdvcmtpbmcgdG8gaW50ZWdyYXRlIGlu
IHRoZWlyIGltcGxlbWVudGF0aW9uIG91ciBtZWNoYW5pc20gdG8NCj4gICBhdXRvbWF0aWNhbGx5
IGdlbmVyYXRlIGNvZGUgdG8gZ2VuZXJhdGUgdGlueSBjb2RlLiBCdXQgdGhpcyB3aWxsIHRha2UN
Cj4gICBzb21lIG1vcmUgd29yay4NCj4NCj4gSW4gdGhlIGZvbGxvd2luZywgc29tZSBpbml0aWFs
IGNvbnNpZGVyYXRpb25zIG9uIGhvdyB0aGUgbGF0ZXN0DQo+IHBhdGNoc2V0IGNvdWxkIGJlIHNp
bXBsaWZpZWQuDQo+DQo+IEhlcmUgeW91IGNhbiBmaW5kIGEgZ3JhcGggSSd2ZSBwdXQgdG9nZXRo
ZXIgb2YgdGhlIGJ1aWxkIHByb2Nlc3M6DQo+DQo+ICAgICBodHRwczovL3Jldi5uZy9kb3dubG9h
ZHMvcWVtdS1oZXhhZ29uL3RlbXBvcmFyeS9ncmFwaC5zdmcNCj4gICAgIGh0dHBzOi8vcmV2Lm5n
L2Rvd25sb2Fkcy9xZW11LWhleGFnb24vdGVtcG9yYXJ5L2dyYXBoLmRvdA0KPg0KPiBDb2xvcnMg
aW5kaWNhdGUgbGFuZ3VhZ2UuDQo+IE92YWwgbm9kZXMgYXJlIGdlbmVyYXRlZC4NCj4gUmVjdGFu
Z2xlcyBhcmUgaGFuZC13cml0dGVuLg0KPg0KPiBUYXlsb3IsIEkgdGhpbmsgc29tZSBzaW1wbGlm
aWNhdGlvbnMgY2FuIGJlIG1hZGUgdG8gdGhlIHByb2Nlc3MgaW4gb3JkZXINCj4gdG8gZWFzZSB0
aGUgcmV2aWV3IHByb2Nlc3MuDQo+DQo+ICogQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCwgZnJvbSBo
ZSAiU291cmNlIG9mIFRydXRoIiBzZXQgb2YgZmlsZXMNCj4gICAoYGFsdS5pZGVmYCwgYGVuY29k
ZV9wcC5kZWZgLi4uKSwgdGhyb3VnaCBgZ2VuX3NlbWFudGljc2AsIHlvdQ0KPiAgIGdlbmVyYXRl
IGBzZW1hbnRpY3NfZ2VuZXJhdGVkLnB5aW5jYCwgd2hpY2ggaXMgdGhlbiBpbmNsdWRlZCBieQ0K
PiAgIGBkb19xZW11LnB5YCBzY3JpcHQsIHdoaWNoIGRvZXMgdGhlIHJlYWwgam9iLg0KPg0KPiAg
IEkgd291bGQgc3VnZ2VzdCB0byBrZWVwIGBnZW5fc2VtYW50aWNzYCBhbmQgYWxsIGl0cyBpbnB1
dHMNCj4gICBvdXQtb2YtdHJlZS4gSXQgaW5jcmVhc2VzIGNvbXBsZXhpdHkgaW4gYSBub24tbmVn
bGlnaWJsZSB3YXksIHdoaWxlDQo+ICAgYnJpbmdpbmcgYSByZWR1Y2VkIGJlbmVmaXQgaW4gdGVy
bXMgb2YgYXV0b21hdGlvbi4NCg0KSSdtIG5vdCBhIGxhd3llciwgYnV0IEkgYmVsaWV2ZSB0aGUg
b3JpZ2luYWwgc291cmNlcyBhcmUgcmVxdWlyZWQgdG8gY29uZm9ybSB0byB0aGUgbGljZW5zZS4N
Cg0KPg0KPiAgIEknZCBzdWdnZXN0IHJlcGxhY2UgYGdlbl9zZW1hbnRpY3NgJ3Mgb3V0cHV0DQo+
ICAgKGBzZW1hbnRpY3NfZ2VuZXJhdGVkLnB5aW5jYCkgd2l0aCBhIGh1bWFuIHJlYWRhYmxlIEpT
T04gZmlsZSB0aGF0DQo+ICAgY291bGQgYmUgbWFuaXB1bGF0ZWQgYnkgaGFuZCBhbmQgaXMgdGhl
biBwYXJzZWQgYnkgYGRvX3FlbXUucHlgLiBJDQo+ICAgdGhpbmsgSlNPTiBpcyBtb3JlIGFwcHJv
cHJpYXRlIHRoYW4gZ2VuZXJhdGluZyBleGVjdXRhYmxlIHB5dGhvbiBjb2RlDQo+ICAgdGhhdCBp
cyB0aGVuIGltcG9ydGVkLg0KDQpJJ20gbm90IG1hcnJpZWQgdG8gcHl0aG9uLCBidXQgd2UgbmVl
ZCBzb21ldGhpbmcgdGhhdCBpcyBleGVjdXRhYmxlLiAgVGhlIHB5dGhvbiBjb2RlIGxvb2tzIGF0
IHRoZSBzZW1hbnRpY3Mgb2YgZWFjaCBpbnN0cnVjdGlvbiB0byBkZXRlcm1pbmUgdGhlIG51bWJl
ciBhbmQgdHlwZXMgb2YgdGhlIGhlbHBlciBhcmd1bWVudHMuICBJdCBhbHNvIGxvb2tzIGF0IHNv
bWUgb2YgdGhlIGF0dHJpYnV0ZXMgdG8gZGVjaWRlIGlmIGNlcnRhaW4gdGhpbmdzIGFyZSBuZWVk
ZWQgKGUuZy4sIEZQT1BfU1RBUlQpIGFuZCBpdCBzY2FucyB0aGUgc2VtYW50aWNzIChzZWUgbmVl
ZF9wYXJ0MSBhbmQgbmVlZF9lYV9mdW5jdGlvbnMgaW4gZG9fcWVtdS5weSkuDQoNCj4NCj4gKiBJ
IHN1Z2dlc3QgdG8gc3dpdGNoIHRvIHRoZSBkZWNvZGluZyBhcHByb2FjaCBkZXZlbG9wZWQgYnkg
UmljaGFyZC4NCj4gICBUaGF0IHdvdWxkIHNpbXBsaWZ5IHRoZSBidWlsZCBwcm9jZXNzIGFuZCBy
ZWR1Y2UgdGhlIGNvZGUgdGhhdCBoYXMgdG8NCj4gICBiZSByZXZpZXdlZC4NCj4gICBJJ20gbm90
IDEwMCUgb2YgdGhlIGVmZm9ydCByZXF1aXJlZCB0byBkbyB0aGlzLCBtYXliZSBSaWNoYXJkIGNh
bg0KPiAgIHdlaWdoIG9uIHRoaXMuDQo+DQoNCkkgYWdyZWUgaW4gcHJpbmNpcGFsLCBidXQgSSBo
YXZlbid0IGxvb2tlZCBpbnRvIGl0LiAgT25lIHRoaW5nIHRvIGNvbnNpZGVyIGlzIHRoYXQgd2Un
bGwgbmVlZCB0byByZW9yZGVyIHRoZSBpbnN0cnVjdGlvbnMgaW4gYSBwYWNrZXQgc28gdGhhdCAu
bmV3IHByb2R1Y2VyIGluc3RydWN0aW9ucyBhcmUgYWhlYWQgb2YgdGhlIGNvbnN1bWVyLg0KDQo+
ICogVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gY2FuIGdlbmVyYXRlIGEgaGVscGVyIGZ1bmN0
aW9uIGZvciBlYWNoDQo+ICAgSGV4YWdvbiBpbnN0cnVjdGlvbiBhbmQsIGZvciBhIHN1YnNldCBv
ZiBpbnN0cnVjdGlvbnMsIGl0IGhhcyBhbg0KPiAgICJvdmVycmlkZSIgbWVjaGFuaXNtIHRvIGRp
cmVjdGx5IGdlbmVyYXRlIHRpbnkgY29kZSBpbnN0cnVjdGlvbnMNCj4gICBjb3JyZXNwb25kaW5n
IHRvIHRoZSBzZW1hbnRpY3Mgb2YgdGhlIG9yaWdpbmFsIGluc3RydWN0aW9uIChpLmUuLA0KPiAg
IHdpdGhvdXQgdXNpbmcgaGVscGVycykuDQo+DQo+ICAgVGhpcyBvdmVycmlkZSBtZWNoYW5pc20g
aXMgaW1wbGVtZW50ZWQgd2l0aCB0aGUgYGZXUkFQYCBtYWNyb3MuIFRoZXkNCj4gICBoYXZlIGJl
bmVmaXRzLCBidXQgdGhleSBhcmUgcXVpdGUgY29udm9sdXRlZC4gV2Ugc2hvdWxkIHN0cml2ZSB0
bw0KPiAgIG1pbmltaXplIHRoZSBudW1iZXIgb2YgbWFjcm9zIGFuZCBhbHRlcm5hdGl2ZSBtYWNy
byBpbXBsZW1lbnRhdGlvbnMNCj4gICB0byB3aGF0J3Mgc3RyaWN0bHkgbmVjZXNzYXJ5IGluIG9y
ZGVyIHRvIGdlbmVyYXRlIGFzIG11Y2ggY29kZSBhcyB3ZQ0KPiAgIGNhbiBmcm9tIHRoZSAiU291
cmNlIG9mIFRydXRoIiwgYnV0IG5vIG1vcmUgdGhhbiB0aGF0Lg0KPg0KDQpJIHRoaW5rIHRoZSBw
cm9ibGVtIGlzIHRoYXQgZldSQVAgaXMgYSBwcmV0dHkgZ2VuZXJpYyBuYW1lIGFuZCBpdCBzZXJ2
ZXMgbXVsdGlwbGUgcHVycG9zZXMuICBJJ2xsIGNoYW5nZSBpdCB0byBhIHNpbmdsZSBwdXJwb3Nl
LiAgRWFjaCBpbnN0cnVjdGlvbiB3aWxsIGNoZWNrIGZvciBmR0VOX1RDR188dGFnPi4gIElmIHRo
aXMgbWFjcm8gaXMgZGVmaW5lZCwgd2Ugd29uJ3QgY3JlYXRlIGEgaGVscGVyLCBhbmQgd2UnbGwg
ZXhlY3V0ZSB0aGUgR0VOX1RDRyBtYWNybyBpbnN0ZWFkLiAgVGhlIGdlbmVyYXRvciB3aWxsIGdl
bnRlcmF0ZToNCg0KI2lmZGVmIGZHRU5fVENHXzx0YWc+DQogICAgZkdFTl9UQ0dfPHRhZz4oPHNo
b3J0Y29kZT4pOw0KI2Vsc2UNCiAgICBnZW5faGVscGVyXzx0YWc+KDxnZW5lcmF0ZWQgYXJncz4p
Ow0KI2VuZGlmDQoNClRoaXMgd2lsbCBhbHNvIGxldCB1cyBnZXQgcmlkIG9mIHRoZSBxZW11X3dy
YXBfZ2VuZXJhdGVkLmggZmlsZS4NCg0KSSdsbCBpbmNsdWRlIHRoaXMgaW4gdGhlIG5leHQgdmVy
c2lvbiBvZiB0aGUgcGF0Y2ggc2VyaWVzLg0KDQoNCg0KPiAgIEFzIGEgc2ltcGxlciBvdmVycmlk
ZSBtZWNoYW5pc20sIHdlIGNvdWxkIHVzZSB3ZWFrIGZ1bmN0aW9ucy4gQnV0IEkNCj4gICB0aGlu
ayB0aGF0LCBmb3Igc2ltcGxpY2l0eSwgd2Ugc2hvdWxkIHRyeSB0byBnZXQgaW4gdHJlZSBhIHNp
bXBsZXINCj4gICB2ZXJzaW9uIG9mIHRoZSBmcm9udGVuZCB0aGF0IHJlbGllcyBleGNsdXNpdmVs
eSBvbiBoZWxwZXIgZnVuY3Rpb25zLg0KPiAgIEl0IHdvbid0IGhhdmUgb3B0aW1hbCBwZXJmb3Jt
YW5jZXMsIGJ1dCBpdCB3aWxsIGJlIGZ1bGx5IGZ1bmN0aW9uYWwuDQoNCklmIGl0IG1ha2VzIHRo
ZSByZXZpZXcgbW9yZSBzdHJhaWdodGZvcndhcmQsIEkgY2FuIHJlbW92ZSB0aGUgb3ZlcnJpZGVz
IGZyb20gdGhlIHBhdGNoIHNlcmllcy4gIEFsc28sIHRoZSBzZXJpZXMgaGFzIGEgZGVmaW5pdGUg
cG9pbnQgd2hlcmUgdGhlIHNjYWxhciBjb3JlIGlzIGZ1bGx5IGltcGxlbWVudGVkLCBhbmQgdGhl
IHJlbWFpbmluZyBwYXRjaGVzIGluIHRoZSBzZXJpZXMgYWRkIHRoZSBIVlggdmVjdG9yIGNvcHJv
Y2Vzc29yLg0KDQpXb3VsZCB0aGVzZSBjaGFuZ2VzIG1ha2UgaXQgZWFzaWVyIGZvciB0aGUgY29t
bXVuaXR5IHRvIHJldmlldz8NCg0KDQo+DQo+ICAgTGF0ZXIgb24sIG9uY2Ugb3VyIHdvcmsgZm9y
IGF1dG9tYXRpY2FsbHkgZ2VuZXJhdGluZyBmdW5jdGlvbnMNCj4gICBnZW5lcmF0aW5nIHRpbnkg
Y29kZSBpcyBtYXR1cmUgZW5vdWdoLCB3ZSBjYW4gZXh0ZW5kIHRoZSBleGlzdGluZw0KPiAgIGlt
cGxlbWVudGF0aW9uIHdpdGggYW4gYXBwcm9wcmlhdGUgb3ZlcnJpZGUgc3lzdGVtLg0KPg0KPiBJ
biB0aGUgbWVhbnRpbWUsIHdlJ3JlIHNldHRpbmcgdXAgYSBEb2NrZXJmaWxlIGJhc2VkIG9uIERl
YmlhbiAxMA0KPiBwcm92aWRpbmcgYSBtaW5pbWFsIEMgdG9vbGNoYWluIHRoYXQgd2UgY2FuIHVz
ZSB0byBhdXRvbWF0ZSB0ZXN0aW5nLg0KPg0KPiBGZWVkYmFjayBpcyBtb3JlIHRoYW4gd2VsY29t
ZS4NCj4NCj4gLS0NCj4gQWxlc3NhbmRybyBEaSBGZWRlcmljbw0KPiByZXYubmcNCj4NCj4gWzFd
IGh0dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9M0VwblRZQk9YQ0kNCg==

