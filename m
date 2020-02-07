Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C0DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 04:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8784322464
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 04:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aQIQZDRl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="EimzGjX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8784322464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izvY9-0007BL-Gb
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 23:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1izvXT-0006Zb-Qo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 23:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1izvXS-000603-EX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 23:46:47 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1izvXS-0005ry-0O
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 23:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581050806; x=1612586806;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ruj1/pm7ys/3IVzUqHPQ35iOpJI7IspnMvR+RK3V/ZU=;
 b=aQIQZDRlk1TfgC1dXVUSyHdlqdr9Yr6k7jpRrrWAxpx4OpKXH1wlxg6C
 QRncdbw8PUghy3d0Bpj8tQ/AUOPixBAJd3mAgl1io0bV8TfkEd4oHYX96
 kpODX2Wq+JyaZ0W4lQ+xf2KdAo+XiFvwhrqYzkp1e6yzJQQWRD8AGqdqi k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Feb 2020 20:46:39 -0800
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 06 Feb 2020 20:46:39 -0800
Received: from eusanexr01f.eu.qualcomm.com (10.85.0.101) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 6 Feb 2020 20:46:39 -0800
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 eusanexr01f.eu.qualcomm.com (10.85.0.101) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 6 Feb 2020 20:46:36 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Thu, 6 Feb 2020 20:46:36 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4581.namprd02.prod.outlook.com (52.135.237.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 04:46:35 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 04:46:35 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, Richard Henderson
 <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add support for a helper with 7 arguments
Thread-Topic: [PATCH] Add support for a helper with 7 arguments
Thread-Index: AQHV3HWNrLXzUmuR802n/46fb+QBo6gNrT4AgABKNoCAABLgEIAAQsYAgAAS9GCAAIHOgIAAPQ3g
Date: Fri, 7 Feb 2020 04:46:34 +0000
Message-ID: <BYAPR02MB488682AB2538F8EBE631EA80DE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <09def3cf-6833-ccf5-457e-1755a7fd0e04@twiddle.net>
 <640ffa37-a70b-dfa9-55ef-cde5c7f0dfcb@twiddle.net>
 <BYAPR02MB48863BDFCB4CB26717467579DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <3614849d-12a5-fa43-fb10-801e9648b40e@twiddle.net>
 <BYAPR02MB48864A309572E1347920CAF0DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <34caf794-85b7-c177-7951-d821ace5caa9@linaro.org>
In-Reply-To: <34caf794-85b7-c177-7951-d821ace5caa9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f40c55f-96f4-4fd1-e6dc-08d7ab88b5d1
x-ms-traffictypediagnostic: BYAPR02MB4581:
x-microsoft-antispam-prvs: <BYAPR02MB4581070A3E94339550261F97DE1C0@BYAPR02MB4581.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(33656002)(64756008)(86362001)(7696005)(316002)(66476007)(71200400001)(4326008)(110136005)(76116006)(66946007)(478600001)(8936002)(66446008)(8676002)(81166006)(81156014)(5660300002)(52536014)(55016002)(9686003)(2906002)(66556008)(6506007)(186003)(26005)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4581;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HihAwP1nkNhxBQN720aYp8GZVBPOwdPdhpC5jWGQYLAvZDCpqltoiw68T16NgQv/GQ3ZQBrz522JlUbvvmXchXeqm4a/gA54EthOCJE7Fvt/cSrQorcc4lnS7SRplnRixRnNGQ0t3Xn0AoNiWBi15VRlWSkqmUNfCTV3rzCYjBSgTsdsFR2Ob1fpwRJhYwvyy2v+cKUDLqnhv809rIHlfirbhFcwcQLMddVPiawJTFFq779IHvOzlzlzHX1Dv4sfJoBVVhLbckwDI5UeKY9OJCnCmwbJ0WeWePqFEBlPPi8STSCFdbu4AlOGF3CFYks5KVeg0P0B/wIbNscUm7cwBvQDSCsVdvTX/yE+VzUaKQTMvnsiTx1QYYd8jDeYx/oEVxTanzKUEWgPllWpM2rool52QHLaDhXLvOyzuoujpgrnjfs7oQ4AaGFuglv2o0jv
x-ms-exchange-antispam-messagedata: k6ujuqGshARlB+4TQbbOK/aAnIvE7Il23btsFDR/J9XVwV8JPJcw0OGIBg/FW9eHbjv/BkcOAhXHRza2igjYM4aYCEmX+xYrH/WXY0k7Fw/dH+yovt/fm6E49wCc75Ebq9UWPF8wqCIVvuiL06U54Q==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhiGHfQ+A7fXu+kFFBCvJ+2VDnd2coRcctrSl9jLpmID4Xid12GsxR+Y9VTrnCvuWbder6lthano6qcrFOLXhe+kBdq8kPAGeJoYAqGvo5x/BgYDJ2rHo09qLBBMMfVBT36ZKhOcN7h/VGiBoVOkfz6p5TIFJkrstZPVJJSNay/0XCWIAPvD9IO1QLoUnxr4/FOm5B5hODlbC+/w8UylkacvjqnfrnzeUSOZ0YfWfCuDXIT3rM2R5M9joy1sD8mS1Sp4F/wXyFzdxZUd+ROKTWKcYbVcQnRxcz+Ooy+AaWYlkFyJ+8CI9YwECLH+udo4iJpETvTDzT/pBAomlGe+DQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSXrZmcRYlFEqhpMy9Y5vOFsda7mKHrM9aaOyp6m9aI=;
 b=gY5yqtpWYDCzUdlUI8J7/lXeYb+ehwMLuOGe4ex+D1ofmLHoPvCg2jLLQ0Eek8stIM9kH75qYdiZqkfYo81p+M7nhKFOmNnqJ9BCiAa5M5mlu65Iv0W8K+Lvlqm/Qpf/gzP4FoJjXWZB9qlNu1v4wEl4pVoyvKNJlZlDFIuoNNyfI/6+j9A03hjtQJFjqnVmOVNtd0Q/7TE03HBXEh6SbJZDC75VpG6OG871ZD2zHqwAO9Jh6Gz5/OvKxNgb5JuqiqqyxPMhdRgqHRFaXVmys9JncaUX3I1tfxzNvMl1b6PmhHUOT40J41ibJsEdUcc3dU1TX1BURJwatnyWkKHIDg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSXrZmcRYlFEqhpMy9Y5vOFsda7mKHrM9aaOyp6m9aI=;
 b=EimzGjX2j+fSC/01CBhXIkQ/YbG4dc0/5IUB52tWukUOJ/NIMufkXBl64U7kWW2EKbjqiTOzRLGiGmzGikTBoBorxn+IZss1gJDKc6RwV9+JfrIAuZCx3VYzmt38phTrRxt3vGIkX57uGDQAwqf0E39SCQ3Xi3AnHZaEJ/c52m8=
x-ms-exchange-crosstenant-network-message-id: 4f40c55f-96f4-4fd1-e6dc-08d7ab88b5d1
x-ms-exchange-crosstenant-originalarrivaltime: 07 Feb 2020 04:46:34.8639 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: goDWs18by/ATAkFGEw1b3ZVzwG5hNe4VaWmkiFXqT5U6MTgLIigwdE6vVueqr81BG2KYxLbXOHrvtgqITRjLog==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4581
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJy
dWFyeSA2LCAyMDIwIDY6MjggUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IFJpY2hhcmQgSGVuZGVyc29uDQo+IDxydGhAdHdpZGRsZS5uZXQ+OyBxZW11LWRl
dmVsQG5vbmdudS5vcmcNCj4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFkZCBzdXBwb3J0IGZvciBhIGhlbHBlciB3aXRoIDcg
YXJndW1lbnRzDQo+DQo+IE9uIDIvNi8yMCA1OjUyIFBNLCBUYXlsb3IgU2ltcHNvbiB3cm90ZToN
Cj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFJp
Y2hhcmQgSGVuZGVyc29uIDxydGg3NjgwQGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIFJpY2hhcmQN
Cj4gPj4gSGVuZGVyc29uDQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA2LCAyMDIwIDk6
MzUgQU0NCj4gPj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT47IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+PiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVk
aGF0LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQWRkIHN1cHBvcnQgZm9yIGEgaGVs
cGVyIHdpdGggNyBhcmd1bWVudHMNCj4gPj4NCj4gPj4NCj4gPj4gSSB0aGluayB0aGlzIGlzIHF1
aXRlIHVnbHkuICBJIGtub3cgeW91J3ZlIGJlZW4gdGFsa2luZyBhYm91dCBhdXRvLQ0KPiBnZW5l
cmF0aW5nDQo+ID4+IGV2ZXJ5dGhpbmcgYnV0IHdlIG91Z2h0IHRvIGRvIGJldHRlciB0aGFuIHRo
aXMuDQo+ID4+DQo+ID4+IFlvdSBzaG91bGQgYmUgcGFzc2luZyB2YWx1ZXMgbm90IHJlZ25vcyBp
ZiB5b3UgY2FuIHBvc3NpYmx5IGRvIHNvLiAgWW91DQo+ID4+IHNob3VsZA0KPiA+PiBiZSBwYXNz
aW5nIGZ1bGwgdmlydHVhbCBhZGRyZXNzZXMgbm90IE4gc2VwYXJhdGUgY29tcG9uZW50cyBvZiBh
bg0KPiBhZGRyZXNzLg0KPiA+PiBQcmVkaWNhdGVzIHNob3VsZCBiZSBldmFsdWF0ZWQgZWFybGll
ciBzbyB0aGF0IHRoZSBoZWxwZXIgaXNuJ3QgZXZlbiBjYWxsZWQNCj4gaWYNCj4gPj4gaXQncyBm
YWxzZS4NCj4gPg0KPiA+IFdlIGFyZSBwYXNzaW5nIHZhbHVlcywgbm90IHJlZyBudW1iZXJzLiAg
VGhlIGdlbmVyYXRvciBkb2Vzbid0IGtub3cNCj4gYW55dGhpbmcgYWJvdXQgdGhlIHNlbWFudGlj
cyBvZiB0aGUgaW5zdHJ1Y3Rpb24uLi4NCj4NCj4gQW5kIHRoaXMsIEkgY2xhaW0sIGlzIHdyb25n
Lg0KPg0KPiBJZiB5b3UgY2FuIGdlbmVyYXRlIEMgZm9yIHRoZSBvcGVyYXRpb24gb3V0IG9mIGxp
bmUsIHRoZW4geW91IGNhbiBpbnRlcnByZXQgaXQNCj4gaW5saW5lIGFzIHdlbGwuICBPciwgbWFr
ZSBhIHJlYXNvbmFibGUgZGVjaXNpb24gYWJvdXQgd2hhdCBiaXQgdG8gYmUgb3V0IG9mDQo+IGxp
bmUgYW5kIHdoYXQgYml0IHRvIGJlIGEgaGVscGVyLg0KPg0KDQpUaGUgQyBjb2RlIGZvciB0aGUg
b3BlcmF0aW9uIGlzIG5vdCBnZW5lcmF0ZWQgLSBpdCBjb21lcyBhcyB0aGUgc2VtYW50aWNzIG9m
IHRoZSBpbnN0cnVjdGlvbi4gIFRoZSBnZW5lcmF0b3Igb25seSBrbm93cyBob3cgdG8gc2V0IHVw
IHRoZSBjYWxsIHRvIHRoZSBoZWxwZXIgYmFzZWQgb24gdGhlIHNpZ25hdHVyZSBvZiB0aGUgaW5z
dHJ1Y3Rpb24sIGFuZCBpdCBwYXN0ZXMgdGhlIEMgY29kZSBpbnRvIHRoZSBib2R5IG9mIHRoZSBo
ZWxwZXIuDQoNCj4gPiBJdCBvbmx5IGtub3dzIHdoaWNoIG9wZXJhbmRzIGFyZSByZWFkLCB3cml0
dGVuLCBvciBib3RoLiAgU28sIHRoZXJlJ3Mgbm8NCj4gd2F5DQo+ID4gdG8gY29tYmluZSB0aGUg
MyBvcGVyYW5kcyBpbnRvIGEgc2luZ2xlIGVmZmVjdGl2ZSBhZGRyZXNzIHVudGlsIHdlIGFyZQ0K
PiA+IGluc2lkZSB0aGUgaGVscGVyLiAgQWxzbywgdGhlcmUncyBubyB3YXkgdG8ga25vdyBpZiB0
aGUgaW5zdHJ1Y3Rpb24gaXMNCj4gPiBwcmVkaWNhdGVkIG9yIGlmIGl0IGp1c3QgaGFzIGEgcHJl
ZGljYXRlIGFzIGFuIG9wZXJhbmQuICBBbHNvLCB0aGVyZSBhcmUNCj4gPiBpbnN0cnVjdGlvbnMg
d2hlcmUgdGhlIHByZWRpY2F0ZSBpcyB1c2VkIGluIHRoZSBmYWxzZSBzZW5zZS4NCj4gVGhlcmUg
Y2VydGFpbmx5IGlzIGEgd2F5IHRvIGtub3cgd2hhdCB0aGUgZWZmZWN0aXZlIGFkZHJlc3MgaXMu
ICBGcm9tIHRoZQ0KPiBwc2V1ZG8tY29kZSB0aGF0IEkgYnJvd3NlZCB0b2RheSwgIkVBID0gZm9v
IiBpcyBhIGJpZyBjbHVlLg0KPg0KPiBUaGVyZSBjZXJ0YWlubHkgaXMgYSB3YXkgdG8ga25vdyBp
ZiB0aGUgaW5zdHJ1Y3Rpb24gaXMgcHJlZGljYXRlZC4gIEZyb20gdGhlDQo+IHBzZXVkby1jb2Rl
IHRoYXQgSSBicm93c2VkIHRvZGF5LA0KPg0KPiAgIGlmIChwcmVkKSB7DQo+ICAgICBvcGVyYXRp
b247DQo+ICAgfSBlbHNlIHsNCj4gICAgIE5PUDsNCj4gICB9DQo+DQoNCkkgZG9uJ3Qgc2VlIHRo
ZSB2YWx1ZSBvZiBoYXZpbmcgdGhlIGdlbmVyYXRvciBnZW5lcmF0ZSBUQ0cgZm9yIHBhcnQgb2Yg
dGhlIHNlbWFudGljcyBhbmQgdXNpbmcgYSBoZWxwZXIgZm9yIGFub3RoZXIgcGFydC4gIFdlIGFs
cmVhZHkgaGF2ZSBhIG1lY2hhbmlzbSBmb3Igb3ZlcnJpZGluZyB0aGUgZW50aXJlIGluc3RydWN0
aW9uLiAgRm9yIGluc3RydWN0aW9ucyB3aGVyZSB0aGVyZSdzIGEgcmVhc29uIG5vdCB0byB1c2Ug
dGhlIGhlbHBlciwgd2UgcmVwbGFjZSBpdCBjb21wbGV0ZWx5Lg0KDQo+IGlzIHRoZSBjbHVlLCB2
cw0KPg0KPiAgIFJkID0gbXV4KFB1LCBScywgUnQpLg0KPg0KPiBPZiBjb3Vyc2UgdGhlcmUgYXJl
IGluc25zIHdoZXJlICFQZCBpcyB1c2VkOyB0aGF0IGRvZXNuJ3QgY2hhbmdlIGFueXRoaW5nLg0K
Pg0KPiA+PiBDb21iaW5lIHRoYXQgd2l0aCAzLjMuMSBQYWNrZXQgZXhlY3V0aW9uIHNlbWFudGlj
cywgImR1YWwgc3RvcmVzLCBuZXctDQo+IHZhbHVlDQo+ID4+IHN0b3JlcywgYW5kIHNsb3QxIHN0
b3JlIHdpdGggc2xvdDAgbG9hZHMgaGF2ZSBub24tcGFyYWxsZWwgZXhlY3V0aW9uDQo+ID4+IHNl
bWFudGljcyIsIGFuZCB5b3UgbmVlZCBubyBzcGVjaWFsIGhlbHBlciBhdCBhbGw6DQo+ID4+DQo+
ID4+IGFuZHQwLCBwdiwgMQ0KPiA+PiBicmNvbmRpdDAsIDAsIG92ZXINCj4gPj4NCj4gPj4gc2hs
aXQwLCBydSwgdTINCj4gPj4gYWRkdDAsIHQwLCBycw0KPiA+PiBxZW11X3N0cnQsIHQwLCBtbXVf
aWR4LCBNT19VQg0KPiA+PiAgb3ZlcjoNCj4gPj4NCj4gPg0KPiA+IFdlIGNhbid0IGFjdHVhbGx5
IGRvIHRoZSBzdG9yZSBoZXJlLiAgV2UgaGF2ZSB0byByZWNvcmQgaXQgaW4gYSBzaWRlIGRhdGEN
Cj4gc3RydWN0dXJlIGluIHRoZSBlbnYgYW5kIHBlcmZvcm0gdGhlIHN0b3JlIHdoZW4gdGhlIHBh
Y2tldCBjb21taXRzLg0KPg0KPiBJIHRoaW5rIHRoYXQgd2UgY2FuIGRvIHRoZSBzdG9yZSBpbW1l
ZGlhdGVseSAtLSBJIGdpdmUgc3BlY2lmaWNzIGFib3ZlLiAgRG8geW91DQo+IGhhdmUgYSBjb3Vu
dGVyLWV4YW1wbGU/ICBBZG1pdHRlZGx5IEknbSBuZXcgdG8gYnJvd3NpbmcgdGhlIGFyY2hpdGVj
dHVyZSwNCj4gYnV0IEkNCj4gZG9uJ3Qgc2VlIGEgbGVnYWwgcGFja2V0IGZvciB3aGljaCB5b3Ug
Y2FuJ3QganVzdCBTdG9yZSBOb3cuDQoNCllvdSBjYW4gaGF2ZSB0d28gc3RvcmVzIGluIGEgcGFj
a2V0LCBhbmQgdGhlIHNlY29uZCBvbmUgY291bGQgZmF1bHQuICBJZiBhbnl0aGluZyBpbiB0aGUg
cGFja2V0IGZhdWx0cywgbm9uZSBvZiB0aGUgaW5zdHJ1Y3Rpb25zIGNvbW1pdC4NCg0KPg0KPiA+
IEN1cnJlbnRseSwgdGhlcmUgYXJlIGEgdG90YWwgb2YgMzUgaW5zdHJ1Y3Rpb25zIHRoYXQgbmVl
ZCBhIGhlbHBlciB3aXRoIDcNCj4gYXJndW1lbnRzLiAgMzIgb2YgdGhlbSBhcmUgcHJlZGljYXRl
ZCBzdG9yZXMsIGJ1dCB0aGVyZSBhcmUgYWxzbyAzIHZzY2F0dGVyDQo+IGluc3RydWN0aW9ucy4g
IEZvciBleGFtcGxlLA0KPiA+ICAgICBpZiAoUXM0KSB2c2NhdHRlcihSdDMyLCBNdTIsIFZ2MzIu
dykudyA9IFZ3MzINCj4NCj4gT2ssIHZzY2F0dGVyIGlzIGluZGVlZCBjb21wbGV4LiAgQnV0IEkg
c3RpbGwgY291bnQgNiBvcGVyYW5kcy4gIElzIGl0IHRoZQ0KPiAic2xvdCIgb25lIHRoYXQgeW91
J3JlIGNvbmNlcm5lZCBpcyB0aGUgN3RoPyAgSSBkb24ndCBzZWUgdGhhdCBhcyBzdHJpY3RseQ0K
PiBuZWNlc3NhcnksIHNpbmNlIHRoaXMgY2FuIG9ubHkgYmUgaW4gc2xvdCAwLg0KDQpZZXMsIHRo
ZSA3dGggb3BlcmFuZCBpcyB0aGUgc2xvdC4gIFRvZGF5LCB0aGVzZSBpbnN0cnVjdGlvbnMgY2Fu
IG9ubHkgYmUgaW4gc2xvdCAwLiAgV2UgY291bGQgaGFyZCBjb2RlIHRoYXQsIGJ1dCB3aGF0IGhh
cHBlbnMgZG93biB0aGUgcm9hZCB3aGVuIHRoZSBhcmNoaXRlY3RzIGNoYW5nZSBpdD8gIFRoYXQn
cyBhIGJhZCB0cmFkZW9mZiB0byBtYWtlIGp1c3QgdG8gYXZvaWQgYWxsb3dpbmcgNyBhcmd1bWVu
dHMgdG8gYSBoZWxwZXIuDQoNCj4NCj4NCj4gcn4NCg==

