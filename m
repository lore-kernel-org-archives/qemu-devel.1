Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA91FC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D22920757
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ccjA/xj9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="B58/dac6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D22920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCTzl-00083N-OK
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 16:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTyO-00079C-96
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:30:44 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:60111)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTyL-0003Fe-4a
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598819441; x=1630355441;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=myk7C7u9/JeCHsedCrH2ejT2elj1HGHidFTGZgwrRc8=;
 b=ccjA/xj9dIDXlx7dGcGEJ7WxZULV1E/0bPTQmIY5trhdFMQJn8cukE1F
 Mn0r4QRGaYxl6IrfhqrNhF7/L7Z7UMTqblq1qis7Dhp+P8ATVeQt7Rf9i
 v3+xZ5z5TY8Vgxw9khXjncH7im18KMZGbQ1Gwy2CFExF2MW/npaKa/K2f M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Aug 2020 13:30:39 -0700
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 13:30:38 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 13:30:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 13:30:38 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5160.namprd02.prod.outlook.com (2603:10b6:a03:70::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Sun, 30 Aug
 2020 20:30:37 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 20:30:36 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 25/34] Hexagon (target/hexagon) macros to interface
 with the generator
Thread-Topic: [RFC PATCH v3 25/34] Hexagon (target/hexagon) macros to
 interface with the generator
Thread-Index: AQHWdXdhm789jfBkCkS7wNrLmdQQdalOUYOAgALal1A=
Date: Sun, 30 Aug 2020 20:30:36 +0000
Message-ID: <BYAPR02MB4886669B0BB9CED20CF166FCDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-26-git-send-email-tsimpson@quicinc.com>
 <56924ad5-7b6a-a05f-7773-e9be5cc9b9e5@linaro.org>
In-Reply-To: <56924ad5-7b6a-a05f-7773-e9be5cc9b9e5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90f06fe0-3e55-484c-3781-08d84d238dac
x-ms-traffictypediagnostic: BYAPR02MB5160:
x-microsoft-antispam-prvs: <BYAPR02MB5160A336DA92FBED6E3405F3DE500@BYAPR02MB5160.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPmyR3+nBUvhGcBtvAOjKVUGzdauYsBHalzzVY/w/mc0mgOSD+ObGdIUa4CDWR304u/E027gcBwmx3dDn/oHoNG8a1YATykeFeGocQQ4W5lxJynhiiq5oxy5D6uLz5cmUxP4EfmEqPP+nLvxais4fIV7SN/bqpKDWFvppBgwiYss9kZDfhMOUKvcnFdr/kqF1coRfBcBxmyeE7MV/E498b5xk2VOhMdeuV/FTqcSqB4+zqsXiMPoQ4IaAMVvG6EaKaMlvjS5fDBZ+z1lZDoN07BLhjZdpdnStXOl8BSeTkQwUFKWD/2d48jsJMtbci5smCpgnA3WReLxgcwBiJivtLc+klOQhZ+YqGxffwfNgrdCiwNVxalhNqUq9W+qoanI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(66946007)(316002)(83380400001)(2906002)(33656002)(53546011)(71200400001)(6506007)(478600001)(110136005)(7696005)(54906003)(4326008)(5660300002)(76116006)(66556008)(9686003)(26005)(55016002)(8676002)(64756008)(66476007)(66446008)(186003)(8936002)(52536014)(86362001)(461764006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8eOZOro6YxFIlmXG1jnPbEnAdu98/PIZKyGTXbnWO+RF0evRNXJnOvEd2ZlIO7j5qKHRfaxTJtl+1zoUhMEfgPdlzP+AbPQU1NjFqWDK3r83ki9vgQmlpBIYz9HZXL/IaZQWiv7qcJ6tgfcLeLy3JCe7t0MuWhGnwwQF3zLsRrkJ/zwMfuPVdzyxuqrpluDOweelrJPAniPIfsc5VEspsaRhqRnv4XemCQjp8l6kZPmwuOWglrUwkP8emgljyq7FXuF/00StmuggLtCU1XD6iKKhgh/tZx8wVk+wm+tqwhFHdXWmYHbklG91x+RB87NBJe0iVG35hYrMnKYhDRji19RERXjdYvE5MwQ0AJMfr2Gzo6OjJQWp1TAF1aJmXdFehwhBmxY1YpDj74bHF71uOneK87uMoNpz41AE0Kw7sFhJhyZBYLT0oDWZgRSvWtyr5r0qVzPIgAEqFAupCYy2K3a+SrKXDwITSUzrUWm9LR4LM/VUAakFMkcQAceH4SGVSGEJIA1vycBDo46gJULnW/h/sTHXKBQGJ7YlRLlx9sqc95rnGrwAKPotssyXM7fztwazAJJ1Z7zMPek0OgJJUqYMIOKZcDJmPgpHYjfVIsvGQgQNVQJRyC82n/xPXPVXu/ijtshbvyG9KNPhzKtOQg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyX8lhwhI1n7qGwe+bjjravptz+dPsrmC67bqNfQNkXgnfAXpCHKvbiFiui2DWSowothggLtlbA7VV3/3ksS0IWVC6Bm17z8SC4qRuayL7w4M5SPIzKfKw4WMRWaDthI//WhgqBHhHhCNNbRx2aONW4om5U06aXxBXc2TjlDxQQFqK0YYoQagLW72qWf6ctsGj6CpSMF+SNR+qavo3fVJhNunE05O/eOvn6EshNTz6ms66NFyN3GkEs1hoKlGXHlUiV6jgIBUR52GOTLf87NPxhob6TdbNI9Y23NBxLi/A+Pptno573+KiPXFaBnI7I3EGIFPlJ5UCdGyXFcO1+QjQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIfaK+6C6AA6xpqsXgb5QzD222GzkuAmwpLOEc8j4/g=;
 b=mvI9x63HU/LbC8MJT7hPRCZF34W0OboF1VvjJwn8edcm9TgjS+RoN6x/+5sqL9h5+omJfGDXYoKNa2ls4oooQUOrddxPpcYa/cWtR+7qNmsrFsylNNEwJX4DsgRLjtm//dZMuqN9wdnvrH/DC6kOkFsSoo1eSpXdhpPUCYEB30kIzHkQz59hEn0GXlsLxzGuBDBdcBsgeVlbcOD+A1Hz3/cpx9auyqU3claOyIIr8EKG4x1JvtSCka9fyCJJ1d5fACsASxIdF+bJlpBvRlXNivgJqN3MUXuOisZiLBfG9+BmcFAsNmt+/Ue9086j9AlVUrnNrL7Yfpoxja19+C6G8Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIfaK+6C6AA6xpqsXgb5QzD222GzkuAmwpLOEc8j4/g=;
 b=B58/dac6DyxJloFJe6c9CboUuk4Cdb5DvnuiuNcm8p57MJfHfWLd71i46NHshIAsOc6an2mMePlD4fDldZAXrVSQZwNZaqOQ1eiEHDMNrYmPdhlg95nGHAGMC+rlWkaa+EOfB45a19YCQteFj12ACqNdH1EL3qbwB7TK3TlvfvM=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 90f06fe0-3e55-484c-3781-08d84d238dac
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 20:30:36.7314 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 0cOT+yQy6dwrmS6nThRE7e2y+1E1HUmzccFuAEwpx+XOaTgI9yyL9SC2WA2KZpLu4YZfOwYBWJvJvLf9WE1oEQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5160
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0
IDI4LCAyMDIwIDY6NDkgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAyNS8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIG1hY3JvcyB0bw0KPiBpbnRlcmZhY2Ugd2l0aCB0
aGUgZ2VuZXJhdG9yDQo+DQo+IE9uIDgvMTgvMjAgODo1MCBBTSwgVGF5bG9yIFNpbXBzb24gd3Jv
dGU6DQo+ID4gKyNkZWZpbmUgREVDTF9SRUcoTkFNRSwgTlVNLCBYLCBPRkYpIFwNCj4gPiArICAg
IFRDR3YgTkFNRSA9IHRjZ190ZW1wX2xvY2FsX25ldygpOyBcDQo+ID4gKyAgICBpbnQgTlVNID0g
UkVHTk8oWCkgKyBPRkYNCj4gPiArDQo+ID4gKyNkZWZpbmUgREVDTF9SRUdfV1JJVEFCTEUoTkFN
RSwgTlVNLCBYLCBPRkYpIFwNCj4gPiArICAgIFRDR3YgTkFNRSA9IHRjZ190ZW1wX2xvY2FsX25l
dygpOyBcDQo+ID4gKyAgICBpbnQgTlVNID0gUkVHTk8oWCkgKyBPRkY7IFwNCj4gPiArICAgIGRv
IHsgXA0KPiA+ICsgICAgICAgIGludCBpc19wcmVkaWNhdGVkID0gR0VUX0FUVFJJQihpbnNuLT5v
cGNvZGUsIEFfQ09OREVYRUMpOyBcDQo+ID4gKyAgICAgICAgaWYgKGlzX3ByZWRpY2F0ZWQgJiYg
IWlzX3ByZWxvYWRlZChjdHgsIE5VTSkpIHsgXA0KPiA+ICsgICAgICAgICAgICB0Y2dfZ2VuX21v
dl90bChoZXhfbmV3X3ZhbHVlW05VTV0sIGhleF9ncHJbTlVNXSk7IFwNCj4gPiArICAgICAgICB9
IFwNCj4gPiArICAgIH0gd2hpbGUgKDApDQo+ID4gKy8qDQo+ID4gKyAqIEZvciByZWFkLW9ubHkg
dGVtcHMsIGF2b2lkIGFsbG9jYXRpbmcgYW5kIGZyZWVpbmcNCj4gPiArICovDQo+ID4gKyNkZWZp
bmUgREVDTF9SRUdfUkVBRE9OTFkoTkFNRSwgTlVNLCBYLCBPRkYpIFwNCj4gPiArICAgIFRDR3Yg
TkFNRTsgXA0KPiA+ICsgICAgaW50IE5VTSA9IFJFR05PKFgpICsgT0ZGDQo+ID4gKw0KPiA+ICsj
ZGVmaW5lIERFQ0xfUlJFR19kKE5BTUUsIE5VTSwgWCwgT0ZGKSBcDQo+ID4gKyAgICBERUNMX1JF
R19XUklUQUJMRShOQU1FLCBOVU0sIFgsIE9GRikNCj4gPiArI2RlZmluZSBERUNMX1JSRUdfZShO
QU1FLCBOVU0sIFgsIE9GRikgXA0KPiA+ICsgICAgREVDTF9SRUcoTkFNRSwgTlVNLCBYLCBPRkYp
DQo+DQo+IElzIHRoZXJlIGEgZ29vZCByZWFzb24gZm9yIGFsbCB0aGVzZSBtYWNyb3M/DQo+IFdo
eSBub3QganVzdCBiYWtlIHRoaXMga25vd2xlZGdlIGludG8gZ2VuX3RjZ19mdW5jcy5weT8NCj4g
U2VlbXMgbGlrZSBpdCB3b3VsZCBiZSBqdXN0IGEgY291cGxlIG9mIGZ1bmN0aW9ucy4uLg0KPg0K
PiBBdCBwcmVzZW50LCBib3RoIHRoaXMgYW5kIHRoZSBpbnRlcm1lZGlhcnkgZmlsZXMgYXJlIHVu
cmVhZGFibGUuICBPbmUgaGFzIHRvDQo+IHBhc3MgZ2VucHRyLmMgdGhyb3VnaCAtRSBhbmQgaW5k
ZW50IHRvIHNlZSB3aGF0J3MgZ29pbmcgb24uDQoNCkkgYWRkIHRoZSByZWdpZCAoc2VlIGNvbW1l
bnQgaW4gaGV4X2NvbW1vbi5weSkgaW4gb3JkZXIgdG8gcmVkdWNlIHRoZSBudW1iZXIgb2YgVENH
diB0ZW1wcyBhbmQgVENHIGNvZGUgd2UgZ2VuZXJhdGUuICBJIG9yaWdpbmFsbHkgaGFkIGEgc2lu
Z2xlIERFRi9SRUFEL1dSSVRFL0ZSRUUgc2V0LiAgV2Ugd291bGQgYWx3YXlzIGNyZWF0ZSBhIFRD
R3YgYW5kIGNvcHkgdG8vZnJvbSB0aGUgdGVtcC4gIEluIHJlYWQtb25seSBjYXNlcywgd2UgZG9u
J3QgbmVlZCBhIHRlbXAgLSB3ZSBqdXN0IHBvaW50IHRvIHRoZSBzb3VyY2UuICBGb3Igd3JpdGUt
b25seSwgd2UgYXNzaWduIGRpcmVjdGx5IHRvIHRoZSBuZXdfdmFsdWUuICBGb3IgcmVhZC13cml0
ZSwgd2UgYWN0dWFsbHkgbmVlZCB0aGUgdGVtcC4NCg==

