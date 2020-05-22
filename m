Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BAFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC88620723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X1iIYzoF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="FMy69gPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC88620723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAoA-0002Id-3F
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1jcAnG-0001jK-03
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:45:10 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:50882)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1jcAnC-0003Ka-L8
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590165906; x=1621701906;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AcQ7Bo/7F1S5FQzHWtKL5ZBlCE9MKBQiMGO6SOUHn+o=;
 b=X1iIYzoFj+PC4T4bjJARIGlhHSJa6S6NTEj4JEoVK9RqLg8P92FBE0vN
 mIisHKBPnfJkbzmx9BfN55l0LphggRMR+pmVEXvmOCauOtS78vLdSuAw3
 B/9pji3NXAHvTi+/w7+pEKNVLWjvF+oAzQZmB16tGZ4knZ8u9JUaNVoWy s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 22 May 2020 09:45:03 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 22 May 2020 09:45:02 -0700
Received: from eusanexr01f.eu.qualcomm.com (10.85.0.101) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 May 2020 09:45:02 -0700
Received: from NASANEXM01F.na.qualcomm.com (10.85.0.32) by
 eusanexr01f.eu.qualcomm.com (10.85.0.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 May 2020 09:45:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 22 May 2020 09:45:00 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4150.namprd02.prod.outlook.com (2603:10b6:a02:f8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Fri, 22 May
 2020 16:44:59 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3594:3599:aab9:8b8e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3594:3599:aab9:8b8e%6]) with mapi id 15.20.3000.034; Fri, 22 May 2020
 16:44:59 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Alessandro Di Federico <ale.qemu@rev.ng>, "qemu-devel@nongnu.org
 Developers" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>,
 "philmd@redhat.com" <philmd@redhat.com>, "laurent@vivier.eu"
 <laurent@vivier.eu>
Subject: RE: Simplifying the Hexagon frontend
Thread-Topic: Simplifying the Hexagon frontend
Thread-Index: AQHWLVl6hGn4gIdZTk6wPE5dWvryhaiurGIggAWoNeA=
Date: Fri, 22 May 2020 16:44:58 +0000
Message-ID: <BYAPR02MB488617A43EAB8AA69203094FDEB40@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200518231508.141b524f@orange>
 <BYAPR02MB48866983EEF33E77096E8C50DEB90@BYAPR02MB4886.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB48866983EEF33E77096E8C50DEB90@BYAPR02MB4886.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rev.ng; dkim=none (message not signed)
 header.d=none;rev.ng; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 055ec63a-e43f-4872-82ba-08d7fe6f7726
x-ms-traffictypediagnostic: BYAPR02MB4150:
x-microsoft-antispam-prvs: <BYAPR02MB4150435CB82E0A324D46D3A9DEB40@BYAPR02MB4150.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUjSbc9mGTdeJwOrNkqqaCWaiGiSDNjh1agxh1BGdrnC0+1YsrOxW6GHzD6PnhLkzmOjWDZH5x/ej2igg2jRSrDFux+bHE/z8lwqBtdPrueqPz6jypVnJaQEQRery5crzQgU4I8gCoow5pliJIkMZfQlFf72qP0KPzuMmXzqs1kDFvUTsW+YSwklBaJdkew1ha8holzvv+GuA9kdsjd06e6L2e2g8bLzIJBaq0UX2Q+sLjOV6paIszKmQIS+Xk9lSu/cFqUK1tI6OurCRtSnIXm5ZPKYL4KiMd7dnjSobKUAwkay3f1dch3CkOBRJSz2cAR0im0WNZERwgQJGp4PxoEgFfD29d0Iy6pKa8u+KyMqPo3u2xvhWIMs/sH9M5Xx6OFLhAEyKyteAb37ieLvl41ZxQKkB/2pOrBRQ74M/Teca+D1LP1+t2fyY80T6+OuccEN8Q8n0OgOS7BBNgdQFLDOj0RkqZPXMPxEHOPvfyaadv5j1MEpM8u8UthtIRuu/0cpZw5Wd/81FCMjE0TNYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(66556008)(66476007)(8676002)(71200400001)(54906003)(2906002)(4326008)(316002)(8936002)(3480700007)(52536014)(186003)(478600001)(86362001)(55016002)(53546011)(5660300002)(110136005)(9686003)(66946007)(33656002)(26005)(64756008)(966005)(76116006)(7696005)(66446008)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: NaoDtzLt2A1JZCwBFDuylCeqyAMORHHU8BqiOzH0kQFbTmk2xYhr7gUQBWfINBWJOq9wD/oYgi+t5u53LzXTb3NRlbcalDJHxlxacMyPGEvwShBAhk5MAkfLoc/YypIFjc84Bk9y5SJWnMP4N35/Sbqna6qg7VqRszx5Y25x6n/JUXwY3HSway9AD7BgPuGEeUO7Ym84v4R+U4Um193MEoEPtuXBlu0a5vKcgLXGXkWAHjXpfVA2MgsoJsoCdXr5qI2I5H0NYOd8mTgA1aobB103Rt19mJa2Kij2GnOxDGaqP17i5h7Jd58FGvMNTqUxTsBQiWJj7JwhQ6nWnStoO4XlX4t5dZaU/NH/b+LZkRLJQVxR179lH77vqAR/ACB/7VmjdN0OZ3ezoXF4hStBNXWehEvVysj0UC2mgCohTKqXxHeQX5U6IHkKQXdE1Hg/ezompIKJIpPyS3yYNVlfpSQtgq/8lsi8ZM5aJTO25WsxkyrMJUKWNWZfdQYwr1e/
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X31nBCy0F3v8d7IU2uipnxxsxbiKBN6l3Xhp/JqMPEYo4ySb1hK0nCZlWGGu9usVftSp5f2TqcFHZEp5rJYpLR2CS/GrZvYq4a1RY152WOB6i8H371NQhOB/MGe9A8keOxng6Vp3tbLtCpyu9wQIYPgLy347pM1iqbbWkkNEewlUMyuoqi10iq9QRCFmsawfx0cXFR/tD3mg9CCAN4WpseXB84unU2vCNBJXGC8V8x6wtRBu1bbnFjayPTE68ZVTXrW0DNsSPzODPwMqRitoC/mMIfE8LoC2uUGd38ZXSNnBODNf96Kgm+g8E2lj+ya0KZuSx8PLYIE0bIWwWguPoQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tk/4KS+gDMx4NLykpmw5SHLZflyV539PwkI5b4SkHc=;
 b=iM/EIDqoeMI7xcydp9XdIFPhFs7Y7IxFhqHTxpmgaMpmB4kWYD8ciBKnMIPdVO+7xnroWgFjJ7xYEiX4TsN0cEDFzy+//wOuFZutcof8sCJl+kToxdkThDFKxiHRREQfX/FMF0chCbO32lw9Hqmx/aCXaXNBiiQNff/V0p7PbfEox114IKyMWA9MuVEDyIQQg0pVEeNpOAfTWl8mbI8/OQezthhlgQgw7HYdPCca1c3EF+Lj4AMh+oKUKU3T4ux1YrCiO2rTV70gVUWqBFSP+8KBrBtUYsr/g9hFs5Ml6/RWP72Xw5cXoyZHSEDUJXaTigfgmHvgbPG3C2ZbWdCPSA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tk/4KS+gDMx4NLykpmw5SHLZflyV539PwkI5b4SkHc=;
 b=FMy69gPisGA7mRSWsNlZjMua2B3haSuc2yBDNHmnsRvP9YEecAlDdRKOpwtialrBOHIJHJtHSl44ffdSzcZNpfXd3Ba4YcQ7b1znlWM/q4uSDeOb4NssDcKzSFukmI8XG5osU210LLq3MEaP+JO5qInw2UEaMG4blmZOhKsEYaU=
x-ms-exchange-crosstenant-network-message-id: 055ec63a-e43f-4872-82ba-08d7fe6f7726
x-ms-exchange-crosstenant-originalarrivaltime: 22 May 2020 16:44:58.7693 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: pBrKNy1qv5daSCzC07Zq5ihj4FYf0KAhcZoTXSYG9dqBE+Rda2/JO6IeyXNsvlTNYL0Q8kYRSTjf0MRYaUoOqQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4150
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 12:45:03
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

SSBtYWRlIHRoZSBjaGFuZ2UgZGlzY3Vzc2VkIGJlbG93Lg0KDQo+ICNpZmRlZiBmR0VOX1RDR188
dGFnPg0KPiAgICAgZkdFTl9UQ0dfPHRhZz4oPHNob3J0Y29kZT4pOw0KPiAjZWxzZQ0KPiAgICAg
Z2VuX2hlbHBlcl88dGFnPig8Z2VuZXJhdGVkIGFyZ3M+KTsNCj4gI2VuZGlmDQoNCkluIGFkZGl0
aW9uLCBoZXJlJ3MgYSBsaXN0IG9mIGNoYW5nZXMgc2luY2UgSSBzdWJtaXR0ZWQgdjIgb2YgdGhl
IHBhdGNoIHNlcmllcw0KLSBVc2UgTGF1cmVudCdzIGdlbnN5c2NhbGwuc2ggc2NyaXB0IHRvIGdl
bmVyYXRlIGxpbnV4LXVzZXIvaGV4YWdvbi9zeXNjYWxsX25yLmgNCi0gSGFuZGxlIG1lbV9ub3No
dWYNCi0gSGVscGVyIG92ZXJyaWRlcyBmb3IgYWxsIHN0b3JlIChhbmQgcHJlZGljYXRlZCBzdG9y
ZSkgaW5zdHJ1Y3Rpb25zDQotIFJlbW92ZSAiUnNWID0gUnNWIiBwZXIgcmV2aWV3IGZlZWRiYWNr
DQotIEZpeCBidWcgaW4gR1AgcmVsYXRpdmUgYWRkcmVzc2luZyBtb2RlDQotIEZpeCBidWdzIGlu
IDY0LWJpdCBhZGQvc3ViIHdpdGggY2FycnkNCi0gU2ltcGxpZnkgaW5jbHVkZSBmaWxlIHN0cnVj
dHVyZQ0KLSBGaXggdmhpc3QgaW5zdHJ1Y3Rpb25zDQotIEFkZCBkaXJlY3RlZCB0ZXN0cyBpbiA8
cWVtdT4vdGVzdHMvdGNnL2hleGFnb24NCi0gQ2hhbmdlIGZXUkFQXyogbWFjcm9zIHRvIGZHRU5f
VENHXyoNCg0KQXJlIHRoZXJlIG90aGVyIGNoYW5nZXMgSSBzaG91bGQgbWFrZSBiZWZvcmUgc3Vi
bWl0dGluZyB2MyBvZiB0aGUgcGF0Y2ggc2VyaWVzPw0KDQpNdWNoIGFwcHJlY2lhdGVkLA0KVGF5
bG9yDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRheWxvciBT
aW1wc29uDQo+IFNlbnQ6IE1vbmRheSwgTWF5IDE4LCAyMDIwIDk6NDIgUE0NCj4gVG86IEFsZXNz
YW5kcm8gRGkgRmVkZXJpY28gPGFsZS5xZW11QHJldi5uZz47IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zw0KPiBEZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBOaWNjb2zDsiBJ
enpvIDxuaXp6b0ByZXYubmc+OyBCcmlhbiBDYWluIDxiY2FpbkBjb2RlYXVyb3JhLm9yZz4NCj4g
U3ViamVjdDogUkU6IFNpbXBsaWZ5aW5nIHRoZSBIZXhhZ29uIGZyb250ZW5kDQo+DQo+DQo+DQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBBbGVzc2FuZHJvIERpIEZl
ZGVyaWNvIDxhbGUucWVtdUByZXYubmc+DQo+ID4gU2VudDogTW9uZGF5LCBNYXkgMTgsIDIwMjAg
NDoxNSBQTQ0KPiA+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcgRGV2ZWxvcGVycyA8cWVtdS1k
ZXZlbEBub25nbnUub3JnPg0KPiA+IENjOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2lu
Yy5jb20+OyBOaWNjb2zDsiBJenpvIDxuaXp6b0ByZXYubmc+Ow0KPiA+IEJyaWFuIENhaW4gPGJj
YWluQGNvZGVhdXJvcmEub3JnPg0KPiA+IFN1YmplY3Q6IFNpbXBsaWZ5aW5nIHRoZSBIZXhhZ29u
IGZyb250ZW5kDQo+ID4NCj4gPiBIaSwgdGhpcyBlLW1haWwgaXMgaW50ZW5kZWQgdG8gYm9vdHN0
cmFwIGEgcHVibGljIGRpc2N1c3Npb24gb24gaG93IHRvDQo+ID4gaW1wcm92ZSB0aGUgSGV4YWdv
biBmcm9udGVuZCBpbXBsZW1lbnRhdGlvbi4gQXQgcmV2Lm5nLCBOaWNjb2zDsiBhbmQgSSwNCj4g
PiBkZXZlbG9wZWQgYW4gSGV4YWdvbiBmcm9udGVuZCwgYW5kIHdlJ3JlIChmaW5hbGx5ISkgam9p
bmluZyBmb3JjZXMgd2l0aA0KPiA+IHRoZSBRdUlDIGd1eXMgdG8gbWVyZ2Ugb3VyIGVmZm9ydHMg
KGRpZCB5b3Ugc2VlIG91ciB0YWxrIFsxXT8pLg0KPiA+DQo+ID4gVGhlIHN0YXR1cyBpcyBhcyBm
b2xsb3dzOg0KPiA+DQo+ID4gKiBRdUlDIGhhcyBpdHMgb3duIGZ1bGx5IHdvcmtpbmcgaW1wbGVt
ZW50YXRpb24gdGhhdCBoYXMgYmVlbiBzdWJtaXR0ZWQNCj4gPiAgIGZvciByZXZpZXcuDQo+ID4g
KiBXZSdyZSB3b3JraW5nIHRvIGludGVncmF0ZSBpbiB0aGVpciBpbXBsZW1lbnRhdGlvbiBvdXIg
bWVjaGFuaXNtIHRvDQo+ID4gICBhdXRvbWF0aWNhbGx5IGdlbmVyYXRlIGNvZGUgdG8gZ2VuZXJh
dGUgdGlueSBjb2RlLiBCdXQgdGhpcyB3aWxsIHRha2UNCj4gPiAgIHNvbWUgbW9yZSB3b3JrLg0K
PiA+DQo+ID4gSW4gdGhlIGZvbGxvd2luZywgc29tZSBpbml0aWFsIGNvbnNpZGVyYXRpb25zIG9u
IGhvdyB0aGUgbGF0ZXN0DQo+ID4gcGF0Y2hzZXQgY291bGQgYmUgc2ltcGxpZmllZC4NCj4gPg0K
PiA+IEhlcmUgeW91IGNhbiBmaW5kIGEgZ3JhcGggSSd2ZSBwdXQgdG9nZXRoZXIgb2YgdGhlIGJ1
aWxkIHByb2Nlc3M6DQo+ID4NCj4gPiAgICAgaHR0cHM6Ly9yZXYubmcvZG93bmxvYWRzL3FlbXUt
aGV4YWdvbi90ZW1wb3JhcnkvZ3JhcGguc3ZnDQo+ID4gICAgIGh0dHBzOi8vcmV2Lm5nL2Rvd25s
b2Fkcy9xZW11LWhleGFnb24vdGVtcG9yYXJ5L2dyYXBoLmRvdA0KPiA+DQo+ID4gQ29sb3JzIGlu
ZGljYXRlIGxhbmd1YWdlLg0KPiA+IE92YWwgbm9kZXMgYXJlIGdlbmVyYXRlZC4NCj4gPiBSZWN0
YW5nbGVzIGFyZSBoYW5kLXdyaXR0ZW4uDQo+ID4NCj4gPiBUYXlsb3IsIEkgdGhpbmsgc29tZSBz
aW1wbGlmaWNhdGlvbnMgY2FuIGJlIG1hZGUgdG8gdGhlIHByb2Nlc3MgaW4gb3JkZXINCj4gPiB0
byBlYXNlIHRoZSByZXZpZXcgcHJvY2Vzcy4NCj4gPg0KPiA+ICogQXMgZmFyIGFzIEkgdW5kZXJz
dGFuZCwgZnJvbSBoZSAiU291cmNlIG9mIFRydXRoIiBzZXQgb2YgZmlsZXMNCj4gPiAgIChgYWx1
LmlkZWZgLCBgZW5jb2RlX3BwLmRlZmAuLi4pLCB0aHJvdWdoIGBnZW5fc2VtYW50aWNzYCwgeW91
DQo+ID4gICBnZW5lcmF0ZSBgc2VtYW50aWNzX2dlbmVyYXRlZC5weWluY2AsIHdoaWNoIGlzIHRo
ZW4gaW5jbHVkZWQgYnkNCj4gPiAgIGBkb19xZW11LnB5YCBzY3JpcHQsIHdoaWNoIGRvZXMgdGhl
IHJlYWwgam9iLg0KPiA+DQo+ID4gICBJIHdvdWxkIHN1Z2dlc3QgdG8ga2VlcCBgZ2VuX3NlbWFu
dGljc2AgYW5kIGFsbCBpdHMgaW5wdXRzDQo+ID4gICBvdXQtb2YtdHJlZS4gSXQgaW5jcmVhc2Vz
IGNvbXBsZXhpdHkgaW4gYSBub24tbmVnbGlnaWJsZSB3YXksIHdoaWxlDQo+ID4gICBicmluZ2lu
ZyBhIHJlZHVjZWQgYmVuZWZpdCBpbiB0ZXJtcyBvZiBhdXRvbWF0aW9uLg0KPg0KPiBJJ20gbm90
IGEgbGF3eWVyLCBidXQgSSBiZWxpZXZlIHRoZSBvcmlnaW5hbCBzb3VyY2VzIGFyZSByZXF1aXJl
ZCB0byBjb25mb3JtIHRvDQo+IHRoZSBsaWNlbnNlLg0KPg0KPiA+DQo+ID4gICBJJ2Qgc3VnZ2Vz
dCByZXBsYWNlIGBnZW5fc2VtYW50aWNzYCdzIG91dHB1dA0KPiA+ICAgKGBzZW1hbnRpY3NfZ2Vu
ZXJhdGVkLnB5aW5jYCkgd2l0aCBhIGh1bWFuIHJlYWRhYmxlIEpTT04gZmlsZSB0aGF0DQo+ID4g
ICBjb3VsZCBiZSBtYW5pcHVsYXRlZCBieSBoYW5kIGFuZCBpcyB0aGVuIHBhcnNlZCBieSBgZG9f
cWVtdS5weWAuIEkNCj4gPiAgIHRoaW5rIEpTT04gaXMgbW9yZSBhcHByb3ByaWF0ZSB0aGFuIGdl
bmVyYXRpbmcgZXhlY3V0YWJsZSBweXRob24gY29kZQ0KPiA+ICAgdGhhdCBpcyB0aGVuIGltcG9y
dGVkLg0KPg0KPiBJJ20gbm90IG1hcnJpZWQgdG8gcHl0aG9uLCBidXQgd2UgbmVlZCBzb21ldGhp
bmcgdGhhdCBpcyBleGVjdXRhYmxlLiAgVGhlDQo+IHB5dGhvbiBjb2RlIGxvb2tzIGF0IHRoZSBz
ZW1hbnRpY3Mgb2YgZWFjaCBpbnN0cnVjdGlvbiB0byBkZXRlcm1pbmUgdGhlDQo+IG51bWJlciBh
bmQgdHlwZXMgb2YgdGhlIGhlbHBlciBhcmd1bWVudHMuICBJdCBhbHNvIGxvb2tzIGF0IHNvbWUg
b2YgdGhlDQo+IGF0dHJpYnV0ZXMgdG8gZGVjaWRlIGlmIGNlcnRhaW4gdGhpbmdzIGFyZSBuZWVk
ZWQgKGUuZy4sIEZQT1BfU1RBUlQpIGFuZCBpdA0KPiBzY2FucyB0aGUgc2VtYW50aWNzIChzZWUg
bmVlZF9wYXJ0MSBhbmQgbmVlZF9lYV9mdW5jdGlvbnMgaW4NCj4gZG9fcWVtdS5weSkuDQo+DQo+
ID4NCj4gPiAqIEkgc3VnZ2VzdCB0byBzd2l0Y2ggdG8gdGhlIGRlY29kaW5nIGFwcHJvYWNoIGRl
dmVsb3BlZCBieSBSaWNoYXJkLg0KPiA+ICAgVGhhdCB3b3VsZCBzaW1wbGlmeSB0aGUgYnVpbGQg
cHJvY2VzcyBhbmQgcmVkdWNlIHRoZSBjb2RlIHRoYXQgaGFzIHRvDQo+ID4gICBiZSByZXZpZXdl
ZC4NCj4gPiAgIEknbSBub3QgMTAwJSBvZiB0aGUgZWZmb3J0IHJlcXVpcmVkIHRvIGRvIHRoaXMs
IG1heWJlIFJpY2hhcmQgY2FuDQo+ID4gICB3ZWlnaCBvbiB0aGlzLg0KPiA+DQo+DQo+IEkgYWdy
ZWUgaW4gcHJpbmNpcGFsLCBidXQgSSBoYXZlbid0IGxvb2tlZCBpbnRvIGl0LiAgT25lIHRoaW5n
IHRvIGNvbnNpZGVyIGlzIHRoYXQNCj4gd2UnbGwgbmVlZCB0byByZW9yZGVyIHRoZSBpbnN0cnVj
dGlvbnMgaW4gYSBwYWNrZXQgc28gdGhhdCAubmV3IHByb2R1Y2VyDQo+IGluc3RydWN0aW9ucyBh
cmUgYWhlYWQgb2YgdGhlIGNvbnN1bWVyLg0KPg0KPiA+ICogVGhlIGN1cnJlbnQgaW1wbGVtZW50
YXRpb24gY2FuIGdlbmVyYXRlIGEgaGVscGVyIGZ1bmN0aW9uIGZvciBlYWNoDQo+ID4gICBIZXhh
Z29uIGluc3RydWN0aW9uIGFuZCwgZm9yIGEgc3Vic2V0IG9mIGluc3RydWN0aW9ucywgaXQgaGFz
IGFuDQo+ID4gICAib3ZlcnJpZGUiIG1lY2hhbmlzbSB0byBkaXJlY3RseSBnZW5lcmF0ZSB0aW55
IGNvZGUgaW5zdHJ1Y3Rpb25zDQo+ID4gICBjb3JyZXNwb25kaW5nIHRvIHRoZSBzZW1hbnRpY3Mg
b2YgdGhlIG9yaWdpbmFsIGluc3RydWN0aW9uIChpLmUuLA0KPiA+ICAgd2l0aG91dCB1c2luZyBo
ZWxwZXJzKS4NCj4gPg0KPiA+ICAgVGhpcyBvdmVycmlkZSBtZWNoYW5pc20gaXMgaW1wbGVtZW50
ZWQgd2l0aCB0aGUgYGZXUkFQYCBtYWNyb3MuIFRoZXkNCj4gPiAgIGhhdmUgYmVuZWZpdHMsIGJ1
dCB0aGV5IGFyZSBxdWl0ZSBjb252b2x1dGVkLiBXZSBzaG91bGQgc3RyaXZlIHRvDQo+ID4gICBt
aW5pbWl6ZSB0aGUgbnVtYmVyIG9mIG1hY3JvcyBhbmQgYWx0ZXJuYXRpdmUgbWFjcm8gaW1wbGVt
ZW50YXRpb25zDQo+ID4gICB0byB3aGF0J3Mgc3RyaWN0bHkgbmVjZXNzYXJ5IGluIG9yZGVyIHRv
IGdlbmVyYXRlIGFzIG11Y2ggY29kZSBhcyB3ZQ0KPiA+ICAgY2FuIGZyb20gdGhlICJTb3VyY2Ug
b2YgVHJ1dGgiLCBidXQgbm8gbW9yZSB0aGFuIHRoYXQuDQo+ID4NCj4NCj4gSSB0aGluayB0aGUg
cHJvYmxlbSBpcyB0aGF0IGZXUkFQIGlzIGEgcHJldHR5IGdlbmVyaWMgbmFtZSBhbmQgaXQgc2Vy
dmVzDQo+IG11bHRpcGxlIHB1cnBvc2VzLiAgSSdsbCBjaGFuZ2UgaXQgdG8gYSBzaW5nbGUgcHVy
cG9zZS4gIEVhY2ggaW5zdHJ1Y3Rpb24gd2lsbA0KPiBjaGVjayBmb3IgZkdFTl9UQ0dfPHRhZz4u
ICBJZiB0aGlzIG1hY3JvIGlzIGRlZmluZWQsIHdlIHdvbid0IGNyZWF0ZSBhDQo+IGhlbHBlciwg
YW5kIHdlJ2xsIGV4ZWN1dGUgdGhlIEdFTl9UQ0cgbWFjcm8gaW5zdGVhZC4gIFRoZSBnZW5lcmF0
b3Igd2lsbA0KPiBnZW50ZXJhdGU6DQo+DQo+ICNpZmRlZiBmR0VOX1RDR188dGFnPg0KPiAgICAg
ZkdFTl9UQ0dfPHRhZz4oPHNob3J0Y29kZT4pOw0KPiAjZWxzZQ0KPiAgICAgZ2VuX2hlbHBlcl88
dGFnPig8Z2VuZXJhdGVkIGFyZ3M+KTsNCj4gI2VuZGlmDQo+DQo+IFRoaXMgd2lsbCBhbHNvIGxl
dCB1cyBnZXQgcmlkIG9mIHRoZSBxZW11X3dyYXBfZ2VuZXJhdGVkLmggZmlsZS4NCj4NCj4gSSds
bCBpbmNsdWRlIHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggc2VyaWVzLg0K
Pg0KPg0KPg0KPiA+ICAgQXMgYSBzaW1wbGVyIG92ZXJyaWRlIG1lY2hhbmlzbSwgd2UgY291bGQg
dXNlIHdlYWsgZnVuY3Rpb25zLiBCdXQgSQ0KPiA+ICAgdGhpbmsgdGhhdCwgZm9yIHNpbXBsaWNp
dHksIHdlIHNob3VsZCB0cnkgdG8gZ2V0IGluIHRyZWUgYSBzaW1wbGVyDQo+ID4gICB2ZXJzaW9u
IG9mIHRoZSBmcm9udGVuZCB0aGF0IHJlbGllcyBleGNsdXNpdmVseSBvbiBoZWxwZXIgZnVuY3Rp
b25zLg0KPiA+ICAgSXQgd29uJ3QgaGF2ZSBvcHRpbWFsIHBlcmZvcm1hbmNlcywgYnV0IGl0IHdp
bGwgYmUgZnVsbHkgZnVuY3Rpb25hbC4NCj4NCj4gSWYgaXQgbWFrZXMgdGhlIHJldmlldyBtb3Jl
IHN0cmFpZ2h0Zm9yd2FyZCwgSSBjYW4gcmVtb3ZlIHRoZSBvdmVycmlkZXMgZnJvbQ0KPiB0aGUg
cGF0Y2ggc2VyaWVzLiAgQWxzbywgdGhlIHNlcmllcyBoYXMgYSBkZWZpbml0ZSBwb2ludCB3aGVy
ZSB0aGUgc2NhbGFyIGNvcmUgaXMNCj4gZnVsbHkgaW1wbGVtZW50ZWQsIGFuZCB0aGUgcmVtYWlu
aW5nIHBhdGNoZXMgaW4gdGhlIHNlcmllcyBhZGQgdGhlIEhWWA0KPiB2ZWN0b3IgY29wcm9jZXNz
b3IuDQo+DQo+IFdvdWxkIHRoZXNlIGNoYW5nZXMgbWFrZSBpdCBlYXNpZXIgZm9yIHRoZSBjb21t
dW5pdHkgdG8gcmV2aWV3Pw0KPg0KPg0KPiA+DQo+ID4gICBMYXRlciBvbiwgb25jZSBvdXIgd29y
ayBmb3IgYXV0b21hdGljYWxseSBnZW5lcmF0aW5nIGZ1bmN0aW9ucw0KPiA+ICAgZ2VuZXJhdGlu
ZyB0aW55IGNvZGUgaXMgbWF0dXJlIGVub3VnaCwgd2UgY2FuIGV4dGVuZCB0aGUgZXhpc3RpbmcN
Cj4gPiAgIGltcGxlbWVudGF0aW9uIHdpdGggYW4gYXBwcm9wcmlhdGUgb3ZlcnJpZGUgc3lzdGVt
Lg0KPiA+DQo+ID4gSW4gdGhlIG1lYW50aW1lLCB3ZSdyZSBzZXR0aW5nIHVwIGEgRG9ja2VyZmls
ZSBiYXNlZCBvbiBEZWJpYW4gMTANCj4gPiBwcm92aWRpbmcgYSBtaW5pbWFsIEMgdG9vbGNoYWlu
IHRoYXQgd2UgY2FuIHVzZSB0byBhdXRvbWF0ZSB0ZXN0aW5nLg0KPiA+DQo+ID4gRmVlZGJhY2sg
aXMgbW9yZSB0aGFuIHdlbGNvbWUuDQo+ID4NCj4gPiAtLQ0KPiA+IEFsZXNzYW5kcm8gRGkgRmVk
ZXJpY28NCj4gPiByZXYubmcNCj4gPg0KPiA+IFsxXSBodHRwczovL3d3dy55b3V0dWJlLmNvbS93
YXRjaD92PTNFcG5UWUJPWENJDQo=

