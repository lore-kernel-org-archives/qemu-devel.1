Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05420C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EE520679
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 23:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nS7nbBze";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="jwHMt9rJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EE520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB5HU-00020F-43
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 19:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5Fz-0000Jf-8A
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:55:07 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40842)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kB5Fx-0003kg-Ac
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 19:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598486105; x=1630022105;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=C1zCyyYuvv7llZHQPVXHuQNemh/6YsrSu++vF519bpw=;
 b=nS7nbBzepbkdDptN97nu0ox+i2KTBqu7lMFuT+TyGESnGtq+87o6imNF
 SpALYbJYmDzelAJjc8kuXx2ug16ZqY/jBYv85PONR/ubw9L0/Kf49hG9V
 hfUIISM/fq5CJlFTQg0qUudvEamWNWlS3esC3uEb3MkMXJVJYPqhoL0/J s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Aug 2020 16:55:04 -0700
Received: from nasanexm01c.na.qualcomm.com ([10.85.0.83])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 26 Aug 2020 16:55:04 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:52:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 Aug 2020 16:52:08 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4952.namprd02.prod.outlook.com (2603:10b6:a03:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 23:52:07 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::6ce3:79e4:9697:313e%3]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 23:52:07 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 07/34] Hexagon (target/hexagon) scalar core helpers
Thread-Topic: [RFC PATCH v3 07/34] Hexagon (target/hexagon) scalar core helpers
Thread-Index: AQHWdXdieeCqUMQfHUmE095+b2ofzKlKfA8AgABqr9A=
Date: Wed, 26 Aug 2020 23:52:07 +0000
Message-ID: <BYAPR02MB4886FDAF8FC9E3E64FDBA6DDDE540@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-8-git-send-email-tsimpson@quicinc.com>
 <7014720f-eda6-50f9-4594-8510d5745d63@linaro.org>
In-Reply-To: <7014720f-eda6-50f9-4594-8510d5745d63@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05bf599a-61d9-4dcf-f924-08d84a1b0a97
x-ms-traffictypediagnostic: BYAPR02MB4952:
x-microsoft-antispam-prvs: <BYAPR02MB49528E311CD901EB51FB6F9EDE540@BYAPR02MB4952.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+4RudGHYnGs34ggP5fmQrkvl06uWkP6sM/+vPhont7pWZzYDADlKfIccxzISWdoPMBXzxKoG+77QqE3yTG3SbHtp1b+8bNF1DbOkpeOrqhE+DonmtMB5dAw3If86/+n9su2NRBMj50gOovWDAkI/H1ktHpciTMPgHH486r9NsVOLcIc/Ks111NH111n6yy41fAI/Ms99ChTdB0a7XAblosDf53Hfc3hkTE+OTbZyPb8SMonYnT1Rk9AapEBqy+qLdSG5Cb15rKTI7NhpXecHP1g5u+AOF86ydxjqxdwLmJHAHqzbfu89Z6KDy0U+j0aCVl9UIuEUO285onWJ85XjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(6506007)(26005)(52536014)(71200400001)(5660300002)(83380400001)(186003)(86362001)(8936002)(53546011)(55016002)(54906003)(316002)(33656002)(9686003)(110136005)(7696005)(8676002)(64756008)(66946007)(2906002)(4326008)(66446008)(66476007)(66556008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6CrAwq2A461YVByTj0TbPJrS9A8XVqutqimE/faD2+sgT7RThZuF/DbPO+57u3Cmi3Qmp/edegSQX5nhmOaZe3eMfc3mpvF6KqxRhsC2BTNUcrrDaddEEYe6bOJRTsj9d6bQvLgiQ1EtxvR2AJYpf98c/zeCv2j0LJBRClhssmdDG0iL9iP5XNw/lt/28RN9jNK2d2/rFgKYx1vwY4X9c7otqM3ALsDigd7ox2fkWtRU3GQIAmpUTNy46Eq9ye6mJeFXz9Ut3rv1HIZn5u4Wh5lcjhwjoYRrS8vhlixI8a7SKxmJccRBpz+xHQoT3bspLxYN0nnd1GSmEedqcrFRYVo6n1uW4heQfcR43Z2Vxk0PJ8dAX8mYkMZS1/kcjEYjGbiTb3KlJVnlygUMFBJZpAbQVkTJGGaSI8FgRX/GFp384lLngKF4NtB8f35lMd9xOTimveh8gZh5P92rZsRAsnkefIydN0NJi6RhHMAQ3saqu9FDxs6CXJjBjbKsLJ9LXaONdABJbdzhaPACwskzhpI7CmsLUTuDaQBsJRQ31SFadHqHvT36IVpkuv/dni/nX70R6pYQDz/L2D6BpBjTSHqvGMxWWeLRqvURdZxTZzP+FgpQ92j2aCaDe83Qe++cpI20oJx3KZ0uKInXrvzTIA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYaoplW3LJvfWmFbsde4AUV/YCLTVfEnSXuu5e2gFESGoap8H4SEDBaNrOrf+o8W3P50MJUURl+/OwtnkxGfh0DVHRp3wAPj1sVPSNu2LWdDsS2ap4X2EIRwlSrnSvKlao1/gjO3YWAzk97iAHqNAUK78mx3ovMqtj4dk+VrcXqHvZuzMpfppCL8okWKJiX+EM+S6dYiaTPgQWRzUqDoeA0enhOuB31GvD7QTYEFy53dA1oZ9/3LRKrIw5cv4e365BCQunH4CU/PjNZeMZI2mQ3Gw2jTlv25UjuICOtQhe3+VCWCI2eODUH7c+sxphsTdkt52RKbp0puE4cKoiE72Q==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbWPtOyrY9P0mhwg/TLSognCUWMmadyzzXnLUjXMsEo=;
 b=Tt11QQYlJmmpvCzJP+OtBQr2vL5/CNx21qg5sc4BCJ5K+K1qTnn28i0ss37LuJJgkqKOlZx96GN8NoEusn3quJCBiE3y6nNdGBpoht/0uJuIXvJ6wameV6pvkHZsuKBW77eRGSKk1lEwsXq/hSLsuldZoTl1mHkjC965m0fuWocv3HSCot1VyKie9zXIynjA8HeHS6KB1aRuTe6MKG04ja4En/B+rGqcCMp4NStqkyupf10QTY3+zZ1U+c+6QNp3dQqu2SHiDWJhQKTkoRf+BK2NpmAJEq9vZ+ejK5erc60s7JKruYy4MR6zyFJYS4eHPxhutoN36lU51kjxG7DHlA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbWPtOyrY9P0mhwg/TLSognCUWMmadyzzXnLUjXMsEo=;
 b=jwHMt9rJCWc1YEH5QzeKkuAcHze77GkdGEy6tZrmy7uASO4RS0j/C4zHXxgn/29w1bgkt5gEn394CWVTf5NMYfn6HTofILeOFHtKyrXYjnn9t+rJcVk8N/HdTe/Rwzr7WLP6u5WcECpRUkjwI3j1DlwbObTumRhWVUG+U/7Y9w4=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 05bf599a-61d9-4dcf-f924-08d84a1b0a97
x-ms-exchange-crosstenant-originalarrivaltime: 26 Aug 2020 23:52:07.3170 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: mNHibXMxxWgM2d+i0htJq9yo3mZY/cVmzyZEM9nc41h/23vIVpkcubbWNG/zQDDyH4uBWV4F/KgUOuPtGLuYzA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4952
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 19:52:04
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDI2LCAyMDIwIDg6MTcgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWlj
aW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207
IGxhdXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5t
YWlsQGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAw
Ny8zNF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIHNjYWxhciBjb3JlDQo+IGhlbHBlcnMNCj4N
Cj4gPiArREVGX0hFTFBFUl8zKG1lcmdlX2luZmxpZ2h0X3N0b3JlOHUsIHM2NCwgZW52LCBzMzIs
IHM2NCkNCj4NCj4gUGxlYXNlIHVzZSBERUZfSEVMUEVSX0ZMQUdTX04gd2hlbiBwb3NzaWJsZS4N
Cg0KT0sNCg0KPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgbG9nX3ByZWRfd3JpdGUoQ1BVSGV4YWdv
blN0YXRlICplbnYsIGludCBwbnVtLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdGFyZ2V0X3Vsb25nIHZhbCkNCj4NCj4gWW91IG1pZ2h0IGJlIGJldHRlciBvZmYgbGV0
dGluZyB0aGUgY29tcGlsZXIgZGVjaWRlIGFib3V0IGlubGluaW5nLg0KDQpJc24ndCAiaW5saW5l
IiBqdXN0IGEgaGludCB0byB0aGUgY29tcGlsZXI/DQoNCj4gPiArICAgIHVuaW9uIHsNCj4gPiAr
ICAgICAgICB1aW50OF90IGJ5dGVzWzhdOw0KPiA+ICsgICAgICAgIHVpbnQzMl90IGRhdGEzMjsN
Cj4gPiArICAgICAgICB1aW50NjRfdCBkYXRhNjQ7DQo+ID4gKyAgICB9IHJldGRhdGEsIHN0b3Jl
ZGF0YTsNCj4NCj4gUmVkIGZsYWcgaGVyZS4gIFRoaXMgaXMgYXNzdW1pbmcgdGhhdCB0aGUgaG9z
dCBhbmQgdGhlIHRhcmdldCBhcmUgYm90aA0KPiBsaXR0bGUtZW5kaWFuLg0KDQpPSw0KDQo+ID4g
KyAgICBpbnQgYmlnbWFzayA9ICgoLWxvYWRfd2lkdGgpICYgKC1zdG9yZV93aWR0aCkpOw0KPiA+
ICsgICAgaWYgKChsb2FkX2FkZHIgJiBiaWdtYXNrKSAhPSAoc3RvcmVfYWRkciAmIGJpZ21hc2sp
KSB7DQo+DQo+IEh1aD8gIFRoaXMgZG9lc24ndCBkZXRlY3Qgb3ZlcmxhcC4gIENvdW50ZXIgZXhh
bXBsZToNCj4NCj4gICBsb2FkX2FkZHIgPSAwLCBsb2FkX3dpZHRoID0gNCwNCj4gICBzdG9yZV9h
ZGRyID0gMSwgc3RvcmVfd2lkdGggPSAxLg0KPg0KPiAgIGJpZ21hc2sgPSAtNCAmIC0xIC0+IC00
Lg0KPg0KPiAgICgwICYgLTQpICE9ICgxICYgLTQpIC0+IDAgIT0gMQ0KDQpPSw0KDQo+ID4gKyAg
ICB3aGlsZSAoKGkgPCBsb2FkX3dpZHRoKSAmJiAoaiA8IHN0b3JlX3dpZHRoKSkgew0KPiA+ICsg
ICAgICAgIHJldGRhdGEuYnl0ZXNbaV0gPSBzdG9yZWRhdGEuYnl0ZXNbal07DQo+ID4gKyAgICAg
ICAgaSsrOw0KPiA+ICsgICAgICAgIGorKzsNCj4gPiArICAgIH0NCj4gPiArICAgIHJldHVybiBy
ZXRkYXRhLmRhdGE2NDsNCj4NCj4gVGhpcyBtb3N0IGRlZmluaXRlbHkgcmVxdWlyZXMgaG9zdC1l
bmRpYW4gYWRqdXN0bWVudC4NCg0KT0sNCg0KPiA+ICsvKiBIZWxwZnVsIGZvciBwcmludGluZyBp
bnRlcm1lZGlhdGUgdmFsdWVzIHdpdGhpbiBpbnN0cnVjdGlvbnMgKi8NCj4gPiArdm9pZCBIRUxQ
RVIoZGVidWdfdmFsdWUpKENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQzMl90IHZhbHVlKQ0KPiA+
ICt7DQo+ID4gKyAgICBIRVhfREVCVUdfTE9HKCJ2YWx1ZSA9IDB4JXhcbiIsIHZhbHVlKTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArdm9pZCBIRUxQRVIoZGVidWdfdmFsdWVfaTY0KShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgaW50NjRfdCB2YWx1ZSkNCj4gPiArew0KPiA+ICsgICAgSEVYX0RFQlVHX0xP
RygidmFsdWVfaTY0ID0gMHglbHhcbiIsIHZhbHVlKTsNCj4gPiArfQ0KPg0KPiBJIHRoaW5rIHdl
IG5lZWQgdG8gbG9zZSBhbGwgb2YgdGhpcy4NCj4gVGhlcmUgYXJlIG90aGVyIHdheXMgdG8gZGVi
dWcgVENHLg0KDQpPSw0KDQo=

