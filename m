Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2FAC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8AB2083E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J3MhyWUu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="jKBP+em5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8AB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCUlK-0001Kj-Ek
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 17:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCUkd-0000vT-Ol
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:20:35 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:36878)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCUka-0008E0-SK
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598822432; x=1630358432;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=50VE7olqfV3a+fnpJpSSv/Rjr9yurIeHCNflChfooro=;
 b=J3MhyWUu29i8DIceocdXtPDUNgHnzRBntqqi2dPSS584UCebnjUmKyad
 HvqTlwKFsTtpPFT5I7JO4Tk03ICs+4U/N73gUOOf9+wJG5fFqFdYZvk6H
 14RJK87DZrzKFtJW53VZjNAeOLDh2aJtzHFATUwY5U619VAeyrtc5z1Q/ 8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Aug 2020 14:20:30 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 14:20:30 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 14:20:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 14:20:30 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4264.namprd02.prod.outlook.com (2603:10b6:a03:16::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Sun, 30 Aug
 2020 21:20:27 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 21:20:27 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 25/34] Hexagon (target/hexagon) macros to interface
 with the generator
Thread-Topic: [RFC PATCH v3 25/34] Hexagon (target/hexagon) macros to
 interface with the generator
Thread-Index: AQHWdXdhm789jfBkCkS7wNrLmdQQdalOUYOAgALal1CAAAm+AIAABLzA
Date: Sun, 30 Aug 2020 21:20:27 +0000
Message-ID: <BYAPR02MB488632B885ADCB5EC7B55789DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-26-git-send-email-tsimpson@quicinc.com>
 <56924ad5-7b6a-a05f-7773-e9be5cc9b9e5@linaro.org>
 <BYAPR02MB4886669B0BB9CED20CF166FCDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <343df449-d140-eac2-0b63-2a0a2172ecfd@linaro.org>
In-Reply-To: <343df449-d140-eac2-0b63-2a0a2172ecfd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44bd5392-861a-41f3-cdd5-08d84d2a8436
x-ms-traffictypediagnostic: BYAPR02MB4264:
x-microsoft-antispam-prvs: <BYAPR02MB426449D0A8CBE91B875846E5DE500@BYAPR02MB4264.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgQ5sBYa5MBBg7ynnowhLKG6DznJP4qyjAFLpDKYM7CSuaNnh+ZDtp0shyzXxQww9bjhYRJmCJ3oL1keK6s/H7gjfikpJQs3VA55E9+odeitxy2i+/LaM8pKw33nJ1Ldfp4G5CaQOIQae3cKWZQ0piPAKYnaFcpnwUAnyefBR5MoI41DzPgWif+ZZWzrINzZm0d7+DpyJbfC6ysHgg6PfAYXmDXELVL7tV4zycqD1RaZ6Jl7dnYjcqaLmofj1h9saY+mcDOR0V131HpDDB17c0n7sLvlSDEk9z7Ij6TsrqgxUlhEEpO3djlaYG3MqXs5DIM9+OBa+lQnnfGd/bE4U9xOMOd9FD3oDZKccp9Scdx+LeUupvhLlxCf/mNOQFNO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(39850400004)(136003)(366004)(346002)(7696005)(64756008)(186003)(66446008)(6506007)(26005)(53546011)(9686003)(478600001)(86362001)(2906002)(55016002)(83380400001)(4326008)(316002)(54906003)(8676002)(66476007)(76116006)(66556008)(66946007)(8936002)(71200400001)(33656002)(110136005)(52536014)(5660300002)(461764006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: lVmW0FeGxcXYe500OAizmZcbgun1qi63qjWjy8mvkaoGCQ1Qrizq/JCxcwg7gq3LBnVB64/7454BydbDDK6eYkDg36MDMFfnSJWg85X3LXV5hoErR8Z00fURAhyNIwVvuY1RWxA+Fo4IpDUSjkKbItgTrnLuxrWdbbryL58uSmNxUd9rb0F2BQS2+PxFo/EeMV6aMteDY1zHPWLQU0JExIP2oZXrtANSi6NKO3IpO2e7T37X2bL/AYyl870YWDJjSHdc4jJ+A5WqREPayl8OlzRDI+k2sZ9aZm9Ant1OAxmDwSruHbGWYF3W/Bo20iLjnJCu5mBWvQTzuT00Ne8E4Xc7LUZhp7lBruHV1WglZYNWROQgQ4wJ10XE8SPCsNjySP38QqRmvAL8flKdz/21YQ95+tkZk98sM+tsHntYai9eMkjr0u0yYlLaRtBIu9mUGy10bDTnCGudEWarnR1R1N9WWKAevVT/LNWBXQV/3UbD20M7uXRdznFg54DJE9KTGe30zohSCoISoqbcnKuOnG+7PHfxVirAYIQIZux8U5UoPwHH2xYTRSs3JJzsFbQ5oQQRczB+C+WNPsz6wuKBG01elhIDH37UiQJ8N2hQFTEI+ZTC+YAuhjYS6jlLVnWyraOj28mTrOo2diOb5E97/A==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lsu+OgM1FO6Yz0Bmwk3XCEQ/71hBLZixsLF79oo9zn1umum69C84iaFGxpq/3XwmwQsyt0r9DBpnCNCz3kFRQFDnZpIl3o2yiBK7osOOUzpTz1LdMni79C60aELOq1TiAEum+AmYRKAOLSVIaT/vDLaiKyCGIdTpoQYP6ws9cOy6ZH1k02r1acEmLRJB5/y3vtH/B1SNk+6t2RgpD8s02mucpCeP27giaiomLKgMVtW7j9ffZ1Z0KhvqYPbh/wfWJgl0G7kQxIl7R4a0kgU6EZCZxYo1oXLAneHWqZvK8DLwiSeE9Gwcg/rf02NbojHbEtlar1hk3Lm9+GgR+6vDmQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWoBz4XbtUYJS6ajFNxtbALN7KpngKjD9m0SCBYPdZ0=;
 b=T6STQmCVyYK2FM4Iqscv5C9QxYZ++DjgRExl6bYOeNaS/crkiFJCml5PaDKs6n1+HYQIAIZ8K3NymmfrQ6erQ6mThRnMqQVzcpv4qQ5eOz/7vc5y0jcCM6zd5/b3EMnhD/ciLwyKHhNpwrswr9dYTNcG9Qvfgcu2CxycIKOxVRh1e2uJ6oMGjilWTToummWeCmQ8NIfJiX0SDIBFXLq0ag5mMm4JzLePTmFKOI2CUuyGEoBFWTr7YQ0iA5YCrnx577aj36FzWhFtoDGpKdwY95yQfrJGa5i0QC9RBZr+10BDbx0gYvd9YbCf5tf0JgSWz+w46T2eimUPgda8Kup7mQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWoBz4XbtUYJS6ajFNxtbALN7KpngKjD9m0SCBYPdZ0=;
 b=jKBP+em5MWdCc2frQ/HmQq+pfdhRymL0dFVqBCOxj+vwlJEJdr7/ROYMl3xf2/xds7DU6h1Oohoi9iYUt43vFyqaN/XUUWGatl/ezcTOIK+B8b+bvGHK5h8GIjHStEPsYNm5lylp+vBRgeWc4AnJsNTNU5fnm1kvTUj2c6LiLZ4=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 44bd5392-861a-41f3-cdd5-08d84d2a8436
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 21:20:27.4045 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: XH5MB1DQQoYOp05v+eiRr6Ph1XgZQXADVXEhTQbV+HSMIhgme6oO2sTvYQcScM9Vrw+dY9QwgxWPOoE1XwXCAw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4264
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 15:37:55
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgQXVndXN0
IDMwLCAyMDIwIDI6NTkgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAyNS8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIG1hY3JvcyB0bw0KPiBpbnRlcmZhY2Ugd2l0aCB0
aGUgZ2VuZXJhdG9yDQo+DQo+IE9uIDgvMzAvMjAgMTozMCBQTSwgVGF5bG9yIFNpbXBzb24gd3Jv
dGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4gPj4g
U2VudDogRnJpZGF5LCBBdWd1c3QgMjgsIDIwMjAgNjo0OSBQTQ0KPiA+PiBUbzogVGF5bG9yIFNp
bXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4+
IENjOiBwaGlsbWRAcmVkaGF0LmNvbTsgbGF1cmVudEB2aXZpZXIuZXU7IHJpa3Uudm9pcGlvQGlr
aS5maTsNCj4gPj4gYWxla3NhbmRhci5tLm1haWxAZ21haWwuY29tOyBhbGVAcmV2Lm5nDQo+ID4+
IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYzIDI1LzM0XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdv
bikgbWFjcm9zIHRvDQo+ID4+IGludGVyZmFjZSB3aXRoIHRoZSBnZW5lcmF0b3INCj4gPj4NCj4g
Pj4gT24gOC8xOC8yMCA4OjUwIEFNLCBUYXlsb3IgU2ltcHNvbiB3cm90ZToNCj4gPj4+ICsjZGVm
aW5lIERFQ0xfUkVHKE5BTUUsIE5VTSwgWCwgT0ZGKSBcDQo+ID4+PiArICAgIFRDR3YgTkFNRSA9
IHRjZ190ZW1wX2xvY2FsX25ldygpOyBcDQo+ID4+PiArICAgIGludCBOVU0gPSBSRUdOTyhYKSAr
IE9GRg0KPiA+Pj4gKw0KPiA+Pj4gKyNkZWZpbmUgREVDTF9SRUdfV1JJVEFCTEUoTkFNRSwgTlVN
LCBYLCBPRkYpIFwNCj4gPj4+ICsgICAgVENHdiBOQU1FID0gdGNnX3RlbXBfbG9jYWxfbmV3KCk7
IFwNCj4gPj4+ICsgICAgaW50IE5VTSA9IFJFR05PKFgpICsgT0ZGOyBcDQo+ID4+PiArICAgIGRv
IHsgXA0KPiA+Pj4gKyAgICAgICAgaW50IGlzX3ByZWRpY2F0ZWQgPSBHRVRfQVRUUklCKGluc24t
Pm9wY29kZSwgQV9DT05ERVhFQyk7IFwNCj4gPj4+ICsgICAgICAgIGlmIChpc19wcmVkaWNhdGVk
ICYmICFpc19wcmVsb2FkZWQoY3R4LCBOVU0pKSB7IFwNCj4gPj4+ICsgICAgICAgICAgICB0Y2df
Z2VuX21vdl90bChoZXhfbmV3X3ZhbHVlW05VTV0sIGhleF9ncHJbTlVNXSk7IFwNCj4gPj4+ICsg
ICAgICAgIH0gXA0KPiA+Pj4gKyAgICB9IHdoaWxlICgwKQ0KPiA+Pj4gKy8qDQo+ID4+PiArICog
Rm9yIHJlYWQtb25seSB0ZW1wcywgYXZvaWQgYWxsb2NhdGluZyBhbmQgZnJlZWluZw0KPiA+Pj4g
KyAqLw0KPiA+Pj4gKyNkZWZpbmUgREVDTF9SRUdfUkVBRE9OTFkoTkFNRSwgTlVNLCBYLCBPRkYp
IFwNCj4gPj4+ICsgICAgVENHdiBOQU1FOyBcDQo+ID4+PiArICAgIGludCBOVU0gPSBSRUdOTyhY
KSArIE9GRg0KPiA+Pj4gKw0KPiA+Pj4gKyNkZWZpbmUgREVDTF9SUkVHX2QoTkFNRSwgTlVNLCBY
LCBPRkYpIFwNCj4gPj4+ICsgICAgREVDTF9SRUdfV1JJVEFCTEUoTkFNRSwgTlVNLCBYLCBPRkYp
DQo+ID4+PiArI2RlZmluZSBERUNMX1JSRUdfZShOQU1FLCBOVU0sIFgsIE9GRikgXA0KPiA+Pj4g
KyAgICBERUNMX1JFRyhOQU1FLCBOVU0sIFgsIE9GRikNCj4gPj4NCj4gPj4gSXMgdGhlcmUgYSBn
b29kIHJlYXNvbiBmb3IgYWxsIHRoZXNlIG1hY3Jvcz8NCj4gPj4gV2h5IG5vdCBqdXN0IGJha2Ug
dGhpcyBrbm93bGVkZ2UgaW50byBnZW5fdGNnX2Z1bmNzLnB5Pw0KPiA+PiBTZWVtcyBsaWtlIGl0
IHdvdWxkIGJlIGp1c3QgYSBjb3VwbGUgb2YgZnVuY3Rpb25zLi4uDQo+ID4+DQo+ID4+IEF0IHBy
ZXNlbnQsIGJvdGggdGhpcyBhbmQgdGhlIGludGVybWVkaWFyeSBmaWxlcyBhcmUgdW5yZWFkYWJs
ZS4gIE9uZSBoYXMNCj4gdG8NCj4gPj4gcGFzcyBnZW5wdHIuYyB0aHJvdWdoIC1FIGFuZCBpbmRl
bnQgdG8gc2VlIHdoYXQncyBnb2luZyBvbi4NCj4gPg0KPiA+IEkgYWRkIHRoZSByZWdpZC4uLg0K
Pg0KPiBObywgdGhhdCBkb2Vzbid0IGFuc3dlciB0aGUgcXVlc3Rpb24uDQo+DQo+IFdoeSBkb2Vz
IERFQ0xfUlJFR19kIGV0IGFsIGV4aXN0IGFzIG1hY3JvcyBhdCBhbGw/ICBXaHkgbm90IGVtaXQg
dGhlDQo+IGV4cGFuc2lvbnMNCj4gZGlyZWN0bHkgYnkgZ2VuX3RjZ19mdW5jcy5weT8NCj4NCj4g
SXQgc2VlbXMgdG8gbWUgdGhhdCBhbGwgdGhpcyBkb2VzIGlzIG9iZnVzY2F0ZSB0aGUgY29kZSwg
YWRkaW5nIG9uZSBtb3JlIGxheWVyDQo+IHRoYXQgb25lIGhhcyB0byB1bndpbmQgaW4gb3JkZXIg
dG8gdW5kZXJzdGFuZC4NCj4NCj4NCj4gcn4NCg0KVGhpcyBpcyBwYXJ0bHkgaGlzdG9yaWNhbC4g
IE15IGludGVudCB3YXMgdG8ga2VlcCB0aGUgZ2VuZXJhdG9yICBzaW1wbGUgYW5kIG1lY2hhbmlj
YWwgYW5kIHB1dCB0aGUgb3B0aW1pemF0aW9uIGFuZCBjb21wbGV4aXR5IGludG8gdGhlIG1hY3Jv
cy4gIEkgd2lsbCBjb2RlIHRoaXMgdXAgYW5kIHNlZSBpZiB3ZSB0aGluayBpdCdzIGJldHRlci4N
Cg0KDQo=

