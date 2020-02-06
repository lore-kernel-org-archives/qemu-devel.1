Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A9C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7704F214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SKtcaAYw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="CIkZba9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7704F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlLh-0003iQ-Nr
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1izlKt-00024g-IG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1izlKs-0000xQ-Co
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:53:07 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:41697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1izlKr-0000qv-Qs
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581011585; x=1612547585;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/0xcHvg3IYQPrr0LPMFU0Cu8lEoXDqik7KqSyhEJazw=;
 b=SKtcaAYwSUE3LM5KH8/vPHzAzHWqhDHNL6/n9WEXPyEFdblurcs1Sya9
 prFzN7EQm30ZBDop8w2W5NpUJjJ/RoULh0vrkRPRm1WBGNTSTxgfYArd/
 SAFEvEdAewttjqP7gBoEbSWgNTai2g/mFVyIbHlaJ75s3scj0swzTBbzO w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Feb 2020 09:53:04 -0800
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 06 Feb 2020 09:53:04 -0800
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 6 Feb 2020 09:53:03 -0800
Received: from NASANEXM01E.na.qualcomm.com (10.85.0.31) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 6 Feb 2020 09:53:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Thu, 6 Feb 2020 09:53:00 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4199.namprd02.prod.outlook.com (20.176.249.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 17:52:57 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 17:52:57 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add support for a helper with 7 arguments
Thread-Topic: [PATCH] Add support for a helper with 7 arguments
Thread-Index: AQHV3HWNrLXzUmuR802n/46fb+QBo6gNrT4AgABKNoCAABLgEIAAQsYAgAAS9GA=
Date: Thu, 6 Feb 2020 17:52:57 +0000
Message-ID: <BYAPR02MB48864A309572E1347920CAF0DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <09def3cf-6833-ccf5-457e-1755a7fd0e04@twiddle.net>
 <640ffa37-a70b-dfa9-55ef-cde5c7f0dfcb@twiddle.net>
 <BYAPR02MB48863BDFCB4CB26717467579DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <3614849d-12a5-fa43-fb10-801e9648b40e@twiddle.net>
In-Reply-To: <3614849d-12a5-fa43-fb10-801e9648b40e@twiddle.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6925a390-66b5-4746-6ebc-08d7ab2d661c
x-ms-traffictypediagnostic: BYAPR02MB4199:
x-microsoft-antispam-prvs: <BYAPR02MB419947BACFFD36C621312036DE1D0@BYAPR02MB4199.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2906002)(71200400001)(8936002)(81166006)(66556008)(478600001)(33656002)(64756008)(66446008)(8676002)(81156014)(5660300002)(66476007)(55016002)(9686003)(86362001)(186003)(6506007)(66946007)(53546011)(26005)(76116006)(4326008)(7696005)(110136005)(52536014)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4199;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: isXimmEA/SRc9HcSSQJRSpjKVmqrF5wLfGJxa1XcGWDlAOMlkHT+FU3QfLQrxqPaHB75TFPmtrdt3OPovvqtJBhngFRPACbfRknNosBuEZJm1y1ESW+CHVIHinVvek3r2c1lPetluE0K98OVkbQHAVAbOInpvJjfS0qoJHjxBhKazqoVs3JOZZIGf2jimXg+tuyzkbmP2TuotAGxy9hIwou4IetzbOdart82ngSVeMhZk9pW9vtsG4GOY5h1kygFX7bsP0zDRzuEvWd6fG0e+IEkX26qZ0jOmOTYGlJFw4kvLqmUC11RUQgvCdq3vH75z57duCwikgITL8IwUYZBXNpYunkkueMXv1isHlQAaBT2inH4DafItoVJt4Lf2IrJ92P7gSNfneDRUxQE0ohKL/jE+AqhMPjE3k4YILhkeb+i2jH/yL4R3ib4Z7Tmx7BI
x-ms-exchange-antispam-messagedata: 9T6tfEDvUtOLVZyHYeIOgSbumv3fi/NfDg2IOy8qKfyrIaem8/Xh2zA2lj4G0rBGGVTzctNhlVtx9UNB7uZHZpmIClZxigHhquB/iutHh97PRO9iwDZGHJonYVJrWSGdXuJrQCDmOrT+h/s3NCjnkA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/6AmhiWzXBhgqgIpk+mWXPfi7uZ8rKAnfv1OIX23vgdWtPGY6qQgZa+RZJUSwy7kC1iyvPqTKtjGvNAjBN/AgVFTt1hqbQFHC/tKG4FfL7V2ywqIyvsCBoqgeBZqJ11+mga8AgAogEjVRJ9p69RQuH8qZ26/b59xQKcPmBbhowW2wqAyNhwI/moVoMKen1dSZFxrzmZzeBA7hpcOES24Wq1sj3DI1PHtxNOdBqZdajhNdeGMVvWdpFuBFIIC/E9SC7M2lh80Gdce1SfjC5FJujOQY7IgPSFBUsLbR9rEYprXIybGrj+yjUs4NSRwC/XWagak5f1WcYgbwachSwLOA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5qgSU8KI/l7dvCBLlVZ5lVneLx+Q7qMGagHKV8QZ1o=;
 b=PKp3/3UsKqAVa1LIJoCKiHgzezVfJayhHRYF2b5ibdNxWuRjFKhlHmfLdfrOArvbPFI02W2tY3gvoNv1s73mp955pwTyM/+VfIj9V0xz6yyjVkKCGLpd0GGeG2HkyqN7ktI5l20zochldrrsXCa8PB5wIcY/k7tc6ro1ZTnOl6e/WnUahnj0xIxNlRo+FtUDlgucWMv8Ey1nlJwC5631Jw/pmSr8H6ig+IrJNtmEsTwWNpDdy3zW63ZVeyu6CAcNiE0VA3+BKRVD0AgkctJlqWnbNbofRd54vdNLHIq+S5al/cKyoKr91sUQQt2JqpkFtsu3qVvEszJ4cDIZ7Tytow==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5qgSU8KI/l7dvCBLlVZ5lVneLx+Q7qMGagHKV8QZ1o=;
 b=CIkZba9IKS8uTHRqpta0UARqsDDyurSFhVwojI52RoL1jKtG9aaNk33jk+NNDZ+py/vlsw1rrY7JinehaaPdP2mHAww6Haj8r7tS4VPiS8AvmRFPN8xMBvTfCFPyrffmFkC0DVGRPRuA3pO8hclQmUP6SAlCxlEhvfWT/7LJPNk=
x-ms-exchange-crosstenant-network-message-id: 6925a390-66b5-4746-6ebc-08d7ab2d661c
x-ms-exchange-crosstenant-originalarrivaltime: 06 Feb 2020 17:52:57.0322 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: h6QYjfO3n02OXoYVKkC/6/FX+/hFFZLl3XubaVeb6SI6dkR/kIdA8jJFMOmVYTpWoP2GIXYctkV3Jj0HaPTQLw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4199
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJ0aDc2ODBAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgUmljaGFyZA0KPiBIZW5kZXJzb24N
Cj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYsIDIwMjAgOTozNSBBTQ0KPiBUbzogVGF5bG9y
IFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+
IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBBZGQgc3VwcG9ydCBmb3IgYSBoZWxwZXIgd2l0aCA3IGFyZ3VtZW50cw0KPg0KPg0K
PiBJIHRoaW5rIHRoaXMgaXMgcXVpdGUgdWdseS4gIEkga25vdyB5b3UndmUgYmVlbiB0YWxraW5n
IGFib3V0IGF1dG8tZ2VuZXJhdGluZw0KPiBldmVyeXRoaW5nIGJ1dCB3ZSBvdWdodCB0byBkbyBi
ZXR0ZXIgdGhhbiB0aGlzLg0KPg0KPiBZb3Ugc2hvdWxkIGJlIHBhc3NpbmcgdmFsdWVzIG5vdCBy
ZWdub3MgaWYgeW91IGNhbiBwb3NzaWJseSBkbyBzby4gIFlvdQ0KPiBzaG91bGQNCj4gYmUgcGFz
c2luZyBmdWxsIHZpcnR1YWwgYWRkcmVzc2VzIG5vdCBOIHNlcGFyYXRlIGNvbXBvbmVudHMgb2Yg
YW4gYWRkcmVzcy4NCj4gUHJlZGljYXRlcyBzaG91bGQgYmUgZXZhbHVhdGVkIGVhcmxpZXIgc28g
dGhhdCB0aGUgaGVscGVyIGlzbid0IGV2ZW4gY2FsbGVkIGlmDQo+IGl0J3MgZmFsc2UuDQoNCldl
IGFyZSBwYXNzaW5nIHZhbHVlcywgbm90IHJlZyBudW1iZXJzLiAgVGhlIGdlbmVyYXRvciBkb2Vz
bid0IGtub3cgYW55dGhpbmcgYWJvdXQgdGhlIHNlbWFudGljcyBvZiB0aGUgaW5zdHJ1Y3Rpb24u
ICBJdCBvbmx5IGtub3dzIHdoaWNoIG9wZXJhbmRzIGFyZSByZWFkLCB3cml0dGVuLCBvciBib3Ro
LiAgU28sIHRoZXJlJ3Mgbm8gd2F5IHRvIGNvbWJpbmUgdGhlIDMgb3BlcmFuZHMgaW50byBhIHNp
bmdsZSBlZmZlY3RpdmUgYWRkcmVzcyB1bnRpbCB3ZSBhcmUgaW5zaWRlIHRoZSBoZWxwZXIuICBB
bHNvLCB0aGVyZSdzIG5vIHdheSB0byBrbm93IGlmIHRoZSBpbnN0cnVjdGlvbiBpcyBwcmVkaWNh
dGVkIG9yIGlmIGl0IGp1c3QgaGFzIGEgcHJlZGljYXRlIGFzIGFuIG9wZXJhbmQuICBBbHNvLCB0
aGVyZSBhcmUgaW5zdHJ1Y3Rpb25zIHdoZXJlIHRoZSBwcmVkaWNhdGUgaXMgdXNlZCBpbiB0aGUg
ZmFsc2Ugc2Vuc2UuDQoNCj4NCj4gQ29tYmluZSB0aGF0IHdpdGggMy4zLjEgUGFja2V0IGV4ZWN1
dGlvbiBzZW1hbnRpY3MsICJkdWFsIHN0b3JlcywgbmV3LXZhbHVlDQo+IHN0b3JlcywgYW5kIHNs
b3QxIHN0b3JlIHdpdGggc2xvdDAgbG9hZHMgaGF2ZSBub24tcGFyYWxsZWwgZXhlY3V0aW9uDQo+
IHNlbWFudGljcyIsIGFuZCB5b3UgbmVlZCBubyBzcGVjaWFsIGhlbHBlciBhdCBhbGw6DQo+DQo+
IGFuZHQwLCBwdiwgMQ0KPiBicmNvbmRpdDAsIDAsIG92ZXINCj4NCj4gc2hsaXQwLCBydSwgdTIN
Cj4gYWRkdDAsIHQwLCBycw0KPiBxZW11X3N0cnQsIHQwLCBtbXVfaWR4LCBNT19VQg0KPiAgb3Zl
cjoNCj4NCg0KV2UgY2FuJ3QgYWN0dWFsbHkgZG8gdGhlIHN0b3JlIGhlcmUuICBXZSBoYXZlIHRv
IHJlY29yZCBpdCBpbiBhIHNpZGUgZGF0YSBzdHJ1Y3R1cmUgaW4gdGhlIGVudiBhbmQgcGVyZm9y
bSB0aGUgc3RvcmUgd2hlbiB0aGUgcGFja2V0IGNvbW1pdHMuDQoNClRoZXJlIGlzIGEgbWVjaGFu
aXNtIHRvIG92ZXJyaWRlIHRoZSBjYWxsIHRvIHRoZSBoZWxwZXIgKGZXUkFQXzx0YWc+KS4gIElm
IHdlIGRpZCBvdmVycmlkZSB0aGlzIGluc3RydWN0aW9uLCB0aGUgVENHIHdvdWxkIGJlIHNpbWls
YXIgdG8gd2hhdCB5b3UgaGF2ZS4gIEhvd2V2ZXIsIGFsbCBpbnN0cnVjdGlvbnMgc3RpbGwgZ2V0
IGEgaGVscGVyIGJlY2F1c2UgdGhlIGdlbmVyYXRvciBkb2Vzbid0IGtub3cgd2hpY2ggaW5zdHJ1
Y3Rpb25zIGFyZSBvdmVycmlkZGVuLg0KDQpDdXJyZW50bHksIHRoZXJlIGFyZSBhIHRvdGFsIG9m
IDM1IGluc3RydWN0aW9ucyB0aGF0IG5lZWQgYSBoZWxwZXIgd2l0aCA3IGFyZ3VtZW50cy4gIDMy
IG9mIHRoZW0gYXJlIHByZWRpY2F0ZWQgc3RvcmVzLCBidXQgdGhlcmUgYXJlIGFsc28gMyB2c2Nh
dHRlciBpbnN0cnVjdGlvbnMuICBGb3IgZXhhbXBsZSwNCiAgICBpZiAoUXM0KSB2c2NhdHRlcihS
dDMyLCBNdTIsIFZ2MzIudykudyA9IFZ3MzINCkluIHRoaXMgY2FzZSwgdGhlIHByZWRpY2F0ZSBp
cyBhIHZlY3RvciB1c2VkIGFzIGEgbWFzayBmb3IgZWFjaCBlbGVtZW50IG9mIHRoZSBzdG9yZS4g
IEV2ZW4gaWYgd2Ugd2VyZW4ndCB1c2luZyBhIGdlbmVyYXRvciwgSSB3b3VsZCBkbyBhIGhlbHBl
ciBmb3IgdGhlc2UgYmVjYXVzZSBvZiB0aGVpciBjb21wbGV4aXR5Lg0KDQo+IEJ1dCBzdXBwb3Nl
IHRoaXMgd2VyZSBzb21ldGhpbmcgbW9yZSBjb21wbGljYXRlZCB0aGFuIGEgYmFyZSBzdG9yZSwg
YW5kDQo+IHRoZQ0KPiBwb2ludCBzdGlsbCBzdGFuZHMgYWJvdXQgcHJlLWNvbXB1dGluZyBmdWxs
IGFkZHJlc3Nlcy4NCj4NCj4NCj4gcn4NCg==

