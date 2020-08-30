Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71380C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226982071B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TGjg6zf0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="BbjwfFHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226982071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCTA1-0007ug-6f
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 15:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCT9Q-0007UW-0o
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 15:38:04 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:34201)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCT9L-0005ps-8L
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 15:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598816279; x=1630352279;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qPiOrGSyVfNi3XhQ+XK0pKbMjZs0cnSUrW1aDFpGx1k=;
 b=TGjg6zf0lIrOZksM3RvuKAhHmsufuj+FOfcJjjWzvDs/RFO7csSinLqg
 tK3diG0GpzxFnv3zMLIDuyV2XW7EDaA005/VF2h4Ww8aY5fyLw0VJP2Ga
 HBFNCz/FuTnaXpUlAmAm6LC4yGqnwsvTjyBj3EJIVct3kq+EvGzT8UR74 c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Aug 2020 12:37:54 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 12:37:54 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 12:37:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 12:37:53 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5816.namprd02.prod.outlook.com (2603:10b6:a03:126::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Sun, 30 Aug
 2020 19:37:52 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 19:37:52 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 31/34] Hexagon (target/hexagon) translation
Thread-Topic: [RFC PATCH v3 31/34] Hexagon (target/hexagon) translation
Thread-Index: AQHWdXeN5SecGE+Nuk6bDOqR/D/IjalOczEAgAKgZ+A=
Date: Sun, 30 Aug 2020 19:37:52 +0000
Message-ID: <BYAPR02MB488647E77E043F2A20CEF007DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-32-git-send-email-tsimpson@quicinc.com>
 <00686989-8fdb-2334-d8f3-93c6301c142d@linaro.org>
In-Reply-To: <00686989-8fdb-2334-d8f3-93c6301c142d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 631f185e-af0a-44b1-fce2-08d84d1c2fa6
x-ms-traffictypediagnostic: BYAPR02MB5816:
x-microsoft-antispam-prvs: <BYAPR02MB5816FE66A21A7008C668EC54DE500@BYAPR02MB5816.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +RnNLv1rG1RUqG9EDai7uUfWZwikQNYc/mZAVfu/NDmF/ZFiKHI1pAUG84ooH78E4o0YpuNR4jIQHCGG46auRQqwvVwYn/g+mtk/uyDrsLMtSg94QRmXb7v4rBgVshNPGbW/Lp5n2q6vDviLis+xLWtqs5JX0Fi4XyTr4knTWkcwCPAd6bdMxtAKndgD5KlKOEktq9yeCJYd049JnEqLAtAodsFqyY51Rfc6qs7zkBcJw9FIE42LIf+vgZ+LIkQkSeyToMXZIxQ7wS+BW++sfKFnwfnK0x0m4NKlENpOWsgQKnv92GQVFjUFshPeJ8QWZkOmMCzhU6+mQIsCJiEVMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(346002)(39850400004)(376002)(366004)(8676002)(86362001)(8936002)(66946007)(83380400001)(66476007)(66556008)(4326008)(76116006)(2906002)(64756008)(54906003)(71200400001)(110136005)(66446008)(6506007)(186003)(26005)(33656002)(7696005)(52536014)(53546011)(478600001)(316002)(55016002)(5660300002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: opALZG85CqbBa6xDMfeEAkcuVD7E5Qcq58kubABu/5s92qhqU5cPPiOZsvJoPu4qp73hqisyQQG1ALK+B3AE0tXp12OVha/lEeH6ZeP9FZcSpuKXO0+tLVuVY8F9QrjQXJzaHNHzu/ol8X7DBDdDIzgbM12Fo4ysrINJnvT5S1RHv3gbcnvXsFYROfTxaYPROuf4dND+W0QKd5ELn0wgCmIn3BDo7Zp9O9J/mlNJ0fJblROhXx7rmAAEYtMb0wf3gnzsWc3Hli7LNy84iVqmABDFZ89JYfPD8wYpWlIcvbgooBlY+qJNIXSQLLsUA/v5/tPoKdKAcoR+bDLttbcbwyL3H8BUK5kVfS9chyDxE4OCrMruQEQaI1jQ1s09p6lXRRd0e/Dd9yS3P2qj6qDv+p0jN4VZER/tB0CfA9HBlSoJvQwS/dP6fwdK5/PCYtjG8fWzNef3e3XHhEXih0k7X0RFbzg/Jd52JbUCD4lr1nfBf+BGkIdxEg1VENCUa+q/cMK7SUaTbgIgKg/szLfXRwv6eXLV1gFpMRjhQJDck/tHQZe89r5gzJVLu04OFy/x1oYkMvRFPqhoYcQHCqqugv8I1+nsTWkJQ3Lrl1xc6PbMvW0BBKBpXUsTmkerUFecb8lbnPui5o0GXhNRLaFc+Q==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw0liGCqA+OsOTjpjJ5+VGftKaHxzU5tc+9pBO5N2R764ENhkuSDbppk8s9Yc9nd4IvHU3VqrREIrz189lxl0Lcfo470FVcOI2t/NeARwDFKxEHejaj+cNiPcKoQnKWvs22LdnTOV4i6qJ+RmL7cNkxIXteyy1MXnNmcZ5ww5jk/TMcjEQfKZTEFQ+WPOGwpxGxX00gRK9kkaRtQ9wmgfPU9lvfofXB2MPXSfN7gOVQr6mL0+XAPjL6rs45dcPs4ZNYgUDK/M7+tiIRXjuOikg5rB968DjQE6XSOfp6WUWp09rrR31ImfPhC1Ega4YLocLW8pL/Pe0GwcLdSw7yODQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CJOeBGZFtxUfbEvbJTVA2lYASKO581nlXM5vZmFdKE=;
 b=VS6LiCceF1aIGPFtTMz05u03MH/zvpJ839K4hA+Tp8Zfv0HEgzqnmmAOAqGrcNqDaG81iuJ+FoPEcVvmYVz4to35QhUL8zRAfSHHVUAzhCH/lQC0hNr320GH15T6a61+hmizilr0AGcjwKgbaL/Z+HJNBxQKrL5qV8qsTH3EUgwIN2MJQ9msU/e+GBIr6Gc2vLyHcH/FtryGGFrsJnnBOjFMgyoBvRDtdNDbKukAkQRL5rYpgfT1QxErzwhbbhtOrfBGwuWp1qqVSTzZ3U/fekEC81aAPb+v3x9N7jV7JBRcmlOegEY0COoim/OHymvdMUZl+udq3MIgHU7cZi1HdA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CJOeBGZFtxUfbEvbJTVA2lYASKO581nlXM5vZmFdKE=;
 b=BbjwfFHrF6N3STpnapkPOiZ0TOSNLmrz843ZDbBU6x6RpJMakpUnXPj/bJBS++/V+nhop81pO8WIZ3VGt0Td7KRv3yICX88sBVkloTcPn1rzFZMM1X9yK20EsQqbfSVkGw9TAwkqnaPznhoWGQeA90NQjnU+JpEuYmvVizMFpmI=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 631f185e-af0a-44b1-fce2-08d84d1c2fa6
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 19:37:52.5032 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: CUArfcADDCwNRuYZOVMkHxINKMzIJT+5e3sPtpVmdOuN5jzmyORHTvkchcWnAXeqwyFrIjLeEnyVxX1n69UTiQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5816
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
IDI4LCAyMDIwIDg6NTAgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAzMS8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIHRyYW5zbGF0aW9uDQo+DQo+ID4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBjdHhfbG9nX3JlZ193cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0p
DQo+ID4gK3sNCj4gPiArI2lmIEhFWF9ERUJVRw0KPiA+ICsgICAgaW50IGk7DQo+ID4gKyAgICBm
b3IgKGkgPSAwOyBpIDwgY3R4LT5yZWdfbG9nX2lkeDsgaSsrKSB7DQo+ID4gKyAgICAgICAgaWYg
KGN0eC0+cmVnX2xvZ1tpXSA9PSBybnVtKSB7DQo+ID4gKyAgICAgICAgICAgIEhFWF9ERUJVR19M
T0coIldBUk5JTkc6IE11bHRpcGxlIHdyaXRlcyB0byByJWRcbiIsIHJudW0pOw0KPiA+ICsgICAg
ICAgIH0NCj4gPiArICAgIH0NCj4gPiArI2VuZGlmDQo+ID4gKyAgICBjdHgtPnJlZ19sb2dbY3R4
LT5yZWdfbG9nX2lkeF0gPSBybnVtOw0KPiA+ICsgICAgY3R4LT5yZWdfbG9nX2lkeCsrOw0KPiA+
ICt9DQo+DQo+IFdoeSBub3QganVzdCBrZWVwIGEgYml0bWFzayBvZiB0aGUgcm51bSB3cml0dGVu
Pw0KPiBEb2VzIHRoZSBvcmRlciBvZiB0aGlzIGxvZyByZWFsbHkgbWF0dGVyPw0KDQpPSw0KDQo+
ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBnZW5fc2xvdF9jYW5jZWxsZWRfY2hlY2soVENHdiBjaGVj
aywgaW50IHNsb3RfbnVtKQ0KPiA+ICt7DQo+ID4gKyAgICBUQ0d2IG1hc2sgPSB0Y2dfY29uc3Rf
dGwoMSA8PCBzbG90X251bSk7DQo+ID4gKyAgICBUQ0d2IG9uZSA9IHRjZ19jb25zdF90bCgxKTsN
Cj4gPiArICAgIFRDR3YgemVybyA9IHRjZ19jb25zdF90bCgwKTsNCj4gPiArDQo+ID4gKyAgICB0
Y2dfZ2VuX2FuZF90bChtYXNrLCBoZXhfc2xvdF9jYW5jZWxsZWQsIG1hc2spOw0KPiA+ICsgICAg
dGNnX2dlbl9tb3Zjb25kX3RsKFRDR19DT05EX05FLCBjaGVjaywgbWFzaywgemVybywgb25lLCB6
ZXJvKTsNCj4NCj4gVGhpcyBpcyBhIGJpdCBzaWxseS4gIEJldHRlciBhcw0KPg0KPiAgICAgdGNn
X2dlbl9leHRyYWN0X2kzMihjaGVjaywgaGV4X3Nsb3RfY2FuY2VsbGVkLCBzbG90X251bSwgMSk7
DQoNCk9LDQoNCj4gPiArc3RhdGljIGludCByZWFkX3BhY2tldF93b3JkcyhDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3Qgd29yZHNbXSkNCj4gPiArew0KPiA+ICsgICAgYm9vbCBmb3VuZF9lbmQg
PSBmYWxzZTsNCj4gPiArICAgIGludCBtYXhfd29yZHM7DQo+ID4gKyAgICBpbnQgbndvcmRzOw0K
PiA+ICsgICAgaW50IGk7DQo+ID4gKw0KPiA+ICsgICAgLyogTWFrZSBzdXJlIHdlIGRvbid0IGNy
b3NzIGEgcGFnZSBib3VuZGFyeSAqLw0KPiA+ICsgICAgbWF4X3dvcmRzID0gLShjdHgtPmJhc2Uu
cGNfbmV4dCB8IFRBUkdFVF9QQUdFX01BU0spIC8NCj4gc2l6ZW9mKHVpbnQzMl90KTsNCj4gPiAr
ICAgIGlmIChtYXhfd29yZHMgPCBQQUNLRVRfV09SRFNfTUFYKSB7DQo+ID4gKyAgICAgICAgLyog
TWlnaHQgY3Jvc3MgYSBwYWdlIGJvdW5kYXJ5ICovDQo+ID4gKyAgICAgICAgaWYgKGN0eC0+YmFz
ZS5udW1faW5zbnMgPT0gMSkgew0KPiA+ICsgICAgICAgICAgICAvKiBPSyBpZiBpdCdzIHRoZSBm
aXJzdCBwYWNrZXQgaW4gdGhlIFRCICovDQo+ID4gKyAgICAgICAgICAgIG1heF93b3JkcyA9IFBB
Q0tFVF9XT1JEU19NQVg7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfSBlbHNlIHsNCj4gPiAr
ICAgICAgICBtYXhfd29yZHMgPSBQQUNLRVRfV09SRFNfTUFYOw0KPiA+ICsgICAgfQ0KPiA+ICsN
Cj4gPiArICAgIG1lbXNldCh3b3JkcywgMCwgUEFDS0VUX1dPUkRTX01BWCAqIHNpemVvZih1aW50
MzJfdCkpOw0KPiA+ICsgICAgZm9yIChud29yZHMgPSAwOyAhZm91bmRfZW5kICYmIG53b3JkcyA8
IG1heF93b3JkczsgbndvcmRzKyspIHsNCj4gPiArICAgICAgICB3b3Jkc1tud29yZHNdID0gY3B1
X2xkbF9jb2RlKGVudiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgt
PmJhc2UucGNfbmV4dCArIG53b3JkcyAqIHNpemVvZih1aW50MzJfdCkpOw0KPiA+ICsgICAgICAg
IGZvdW5kX2VuZCA9IGlzX3BhY2tldF9lbmQod29yZHNbbndvcmRzXSk7DQo+ID4gKyAgICB9DQo+
ID4gKyAgICBpZiAoIWZvdW5kX2VuZCkgew0KPiA+ICsgICAgICAgIGlmIChud29yZHMgPT0gUEFD
S0VUX1dPUkRTX01BWCkgew0KPiA+ICsgICAgICAgICAgICAvKiBSZWFkIHRvbyBtYW55IHdvcmRz
IHdpdGhvdXQgZmluZGluZyB0aGUgZW5kICovDQo+ID4gKyAgICAgICAgICAgIGdlbl9leGNlcHRp
b24oSEVYX0VYQ1BfSU5WQUxJRF9QQUNLRVQpOw0KPiA+ICsgICAgICAgICAgICBjdHgtPmJhc2Uu
aXNfam1wID0gRElTQVNfTk9SRVRVUk47DQo+ID4gKyAgICAgICAgICAgIHJldHVybiAwOw0KPiA+
ICsgICAgICAgIH0NCj4gPiArICAgICAgICAvKiBDcm9zc2VzIHBhZ2UgYm91bmRhcnkgLSBkZWZl
ciB0byBuZXh0IFRCICovDQo+ID4gKyAgICAgICAgY3R4LT5iYXNlLmlzX2ptcCA9IERJU0FTX1RP
T19NQU5ZOw0KPg0KPiBUaGUgcHJvYmxlbSB3aXRoIHRoaXMgaXMgdGhhdCB0aGUgdHJhbnNsYXRv
ciBoYXMgYXNrZWQgZm9yIHRoZSBuZXh0IGluc24sIGFuZA0KPiB5b3UgaGF2bid0IHByb3ZpZGVk
IGl0Lg0KPg0KPiBPbmUgd2F5IHRvIGZpeCB0aGlzIG1pZ2h0IGJlIHRvIGRlY3JlbWVudCBjdHgt
PmJhc2UubnVtX2luc25zLCB0bw0KPiBjb21wZW5zYXRlDQo+IGZvciB0aGUgaW5jcmVtZW50IHRo
YXQgKndpbGwqIGhhcHBlbiBhZnRlciB5b3UgcmV0dXJuLg0KPg0KPiBBbm90aGVyIHdheSwgd2hp
Y2ggaW52b2x2ZXMgbGVzcyBwb2tpbmcgYWJvdXQgaW50byBpbnRlcm5hbHMgaXMgdG8gbG9vayBm
b3IgdGhlDQo+IG5leHQgcGFja2V0IG9uY2UgeW91J3ZlIGNvbXBsZXRlZCB0aGUgY3VycmVudCBw
YWNrZXQuICBUaGlzIGlzIHdoYXQgQXJtDQo+IGRvZXMNCj4gZm9yIHRodW1iMiBpbnNuczoNCj4N
Cj4gPiAgICAgaWYgKGRjLT5iYXNlLmlzX2ptcCA9PSBESVNBU19ORVhUDQo+ID4gICAgICAgICAm
JiAoZGMtPmJhc2UucGNfbmV4dCAtIGRjLT5wYWdlX3N0YXJ0ID49IFRBUkdFVF9QQUdFX1NJWkUN
Cj4gPiAgICAgICAgICAgICB8fCAoZGMtPmJhc2UucGNfbmV4dCAtIGRjLT5wYWdlX3N0YXJ0ID49
IFRBUkdFVF9QQUdFX1NJWkUgLSAzDQo+ID4gICAgICAgICAgICAgICAgICYmIGluc25fY3Jvc3Nl
c19wYWdlKGVudiwgZGMpKSkpIHsNCj4gPiAgICAgICAgIGRjLT5iYXNlLmlzX2ptcCA9IERJU0FT
X1RPT19NQU5ZOw0KPiA+ICAgICB9DQo+DQo+IEkuZS4geW91IG9ubHkgaGF2ZSB0byBkbyB0aGlz
IGZvciB0aGUgZmV3IHBhY2tldHMgdGhhdCBhcmUgbmVhciBlbm91Z2ggdG8gdGhlDQo+IGVuZCBv
ZiB0aGUgcGFnZSB0aGF0IFBBQ0tFVF9XT1JEU19NQVggY3Jvc3Nlcy4NCg0KSSdtIGFjdHVhbGx5
IGNoZWNraW5nIHR3byBjb25kaXRpb25zIGhlcmUuDQoxKSBwYWNrZXQgY3Jvc3NpbmcgYSBwYWdl
IGJvdW5kYXJ5DQoyKSByZWFkaW5nIHRvbyBtYW55IHdvcmRzIHdpdGhvdXQgZmluZGluZyB0aGUg
ZW5kIG9mIHRoZSBwYWNrZXQuDQpJIGd1ZXNzIGl0IHdvdWxkIGJlIGJldHRlciB0byBzZXBhcmF0
ZSB0aGVtLg0KDQpXaGF0IGlzIHRoZSBjb3JyZWN0IGJlaGF2aW9yIGZvciB0aGUgc2Vjb25kIGNh
c2U/ICBTaG91bGQgd2UgcmV0dXJuIGFuIGVycm9yIGNvZGUgZnJvbSBoZXJlIGFuZCBoYXZlIHRo
ZSBoaWdoZXIgbGV2ZWwgY29kZSBnZW5lcmF0ZSB0aGUgaW52YWxpZCBwYWNrZXQgZXhjZXB0aW9u
Pw0KDQo+ID4gKyAgICB0Y2dfZ2VuX21vdmlfdGwoaGV4X2dwcltIRVhfUkVHX1BDXSwgY3R4LT5i
YXNlLnBjX25leHQpOw0KPiA+ICsgICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9zbG90X2NhbmNlbGxl
ZCwgMCk7DQo+ID4gKyAgICBpZiAocGt0LT5wa3RfaGFzX2NvZikgew0KPiA+ICsgICAgICAgIHRj
Z19nZW5fbW92aV90bChoZXhfYnJhbmNoX3Rha2VuLCAwKTsNCj4gPiArICAgICAgICB0Y2dfZ2Vu
X21vdmlfdGwoaGV4X25leHRfUEMsIG5leHRfUEMpOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgdGNn
X2dlbl9tb3ZpX3RsKGhleF9wcmVkX3dyaXR0ZW4sIDApOw0KPiA+ICt9DQo+DQo+IFN1cmVseSB5
b3UgZG9uJ3QgbmVlZCB0byBhY3R1YWxseSBzZXQgUEMgZm9yIGV2ZXJ5IFBDPw0KDQpXaGF0IGRv
IG90aGVyIHRhcmdldHMgZG8/DQoNCj4gTm9yIHNldCBoZXhfc2xvdF9jYW5jZWxsZWQgaWYgdGhl
IHBhY2tldCBjb250YWlucyBub3RoaW5nIHRoYXQgY2FuIGNhbmNlbA0KPiBhbnl0aGluZy4gIE5v
ciBzZXQgaGV4X3ByZWRfd3JpdHRlbiBpZiBubyBwcmVkaWNhdGVzIGFyZSB3cml0dGVuLg0KDQpD
aGVja2luZyBmb3IgaW5zdHJ1Y3Rpb25zIHRoYXQgY2FuIGNhbmNlbCBpcyBwcmV0dHkgc3RyYWln
aHRmb3J3YXJkIGJlY2F1c2Ugd2UgaGF2ZSB0aGUgQ09OREVYRUMgYXR0cmlidXRlLiAgQ2hlY2tp
bmcgaWYgYW55IHByZWRpY2F0ZXMgYXJlIHdyaXR0ZW4gd2lsbCBiZSBtb3JlIGNvbXBsZXguICBJ
J2xsIHNjcmF0Y2ggbXkgaGVhZCBhbmQgZmlndXJlIG91dCB0aGUgY2xlYW5lc3Qgd2F5IHRvIGRv
IHRoaXMuDQoNCj4NCj4gPiArICAgIFRDR3YgY2FuY2VsbGVkID0gdGNnX3RlbXBfbG9jYWxfbmV3
KCk7DQo+ID4gKyAgICBUQ0dMYWJlbCAqbGFiZWxfZW5kID0gZ2VuX25ld19sYWJlbCgpOw0KPiA+
ICsNCj4gPiArICAgIC8qIERvbid0IGRvIGFueXRoaW5nIGlmIHRoZSBzbG90IHdhcyBjYW5jZWxs
ZWQgKi8NCj4gPiArICAgIGdlbl9zbG90X2NhbmNlbGxlZF9jaGVjayhjYW5jZWxsZWQsIHNsb3Rf
bnVtKTsNCj4gPiArICAgIHRjZ19nZW5fYnJjb25kaV90bChUQ0dfQ09ORF9ORSwgY2FuY2VsbGVk
LCAwLCBsYWJlbF9lbmQpOw0KPg0KPiBjYW5jZWxsZWQgZG9lcyBub3QgbmVlZCB0byBiZSBsb2Nh
bDsgaXQgaXMgY29uc3VtZWQgYnkgdGhlIGJyYW5jaCBhbmQgbm90DQo+IGNvbnN1bWVkIGFmdGVy
d2FyZC4gIEp1c3QgZnJlZSBpdCBoZXJlLg0KDQpPSw0KDQo+ID4gKyAgICAgICAgLyoNCj4gPiAr
ICAgICAgICAgKiBJZiB3ZSBrbm93IHRoZSB3aWR0aCBmcm9tIHRoZSBEaXNhc0NvbnRleHQsIHdl
IGNhbg0KPiA+ICsgICAgICAgICAqIGdlbmVyYXRlIG11Y2ggY2xlYW5lciBjb2RlLg0KPiA+ICsg
ICAgICAgICAqIFVuZm9ydHVuYXRlbHksIG5vdCBhbGwgaW5zdHJ1Y3Rpb25zIGV4ZWN1dGUgdGhl
IGZTVE9SRQ0KPiA+ICsgICAgICAgICAqIG1hY3JvIGR1cmluZyBjb2RlIGdlbmVyYXRpb24uICBB
bnl0aGluZyB0aGF0IHVzZXMgdGhlDQo+ID4gKyAgICAgICAgICogZ2VuZXJpYyBoZWxwZXIgd2ls
bCBoYXZlIHRoaXMgcHJvYmxlbS4gIEluc3RydWN0aW9ucw0KPiA+ICsgICAgICAgICAqIHRoYXQg
dXNlIGZXUkFQIHRvIGdlbmVyYXRlIHByb3BlciBUQ0cgY29kZSB3aWxsIGJlIE9LLg0KPiA+ICsg
ICAgICAgICAqLw0KPg0KPiBPTUcuICBIb3cgZGlzZ3VzdGluZy4NCg0KVGhlIHdvcmQgImdlbmVy
aWMiIGlzIGEgdHlwbyAtIHNob3VsZCBiZSAiZ2VuZXJhdGVkIi4gIEluIG9yZGVyIHRvIGtlZXAg
dGhpcyBzZXJpZXMgc21hbGwsIHdlJ3JlIG9ubHkgb3ZlcnJpZGluZyB0aGUgaGVscGVyIGZvciB0
aGUgbWluaW1hbCBudW1iZXIgb2YgaW5zdHJ1Y3Rpb25zLiAgT3ZlciB0aW1lLCB3ZSdsbCBvdmVy
cmlkZSBhbGwgdGhlIHN0b3JlcyBhbmQgd2UgY2FuIGVsaW1pbmF0ZSB0aGlzLg0KDQoNCj4gPiAr
ICAgICAgICAgICAgdmFsdWUgPSB0Y2dfdGVtcF9uZXcoKTsNCj4gPiArICAgICAgICAgICAgdGNn
X2dlbl9tb3ZfdGwodmFsdWUsIGhleF9zdG9yZV92YWwzMltzbG90X251bV0pOw0KPiA+ICsgICAg
ICAgICAgICB0Y2dfZ2VuX3FlbXVfc3Q4KHZhbHVlLCBhZGRyZXNzLCBjdHgtPm1lbV9pZHgpOw0K
PiA+ICsgICAgICAgICAgICB0Y2dfdGVtcF9mcmVlKHZhbHVlKTsNCj4NCj4gV2h5IGFyZSB5b3Ug
Y29weWluZyB0byBhIHRlbXBvcmFyeT8NCg0KV2lsbCBmaXguDQoNCj4gPiArICAgICAgICBkZWZh
dWx0Og0KPiA+ICsgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgKiBJZiB3ZSBnZXQg
dG8gaGVyZSwgd2UgZG9uJ3Qga25vdyB0aGUgd2lkdGggYXQNCj4gPiArICAgICAgICAgICAgICog
VENHIGdlbmVyYXRpb24gdGltZSwgd2UnbGwgZ2VuZXJhdGUgYnJhbmNoaW5nDQo+ID4gKyAgICAg
ICAgICAgICAqIGJhc2VkIG9uIHRoZSB3aWR0aCBhdCBydW50aW1lLg0KPiA+ICsgICAgICAgICAg
ICAgKi8NCj4gPiArICAgICAgICAgICAgbGFiZWxfdzIgPSBnZW5fbmV3X2xhYmVsKCk7DQo+ID4g
KyAgICAgICAgICAgIGxhYmVsX3c0ID0gZ2VuX25ld19sYWJlbCgpOw0KPiA+ICsgICAgICAgICAg
ICBsYWJlbF93OCA9IGdlbl9uZXdfbGFiZWwoKTsNCj4gPiArICAgICAgICAgICAgVENHdiB3aWR0
aCA9IHRjZ190ZW1wX2xvY2FsX25ldygpOw0KPg0KPiBZb3UgbWlnaHQgYXMgd2VsbCBtYWtlIHRo
aXMgYSBoZWxwZXIuICBUaGlzIGlzIGdvaW5nIHRvIGdlbmVyYXRlIGEgKmxvdCogb2YNCj4gY29k
ZS4NCg0KVGhpcyBpcyB0aGUgcGFydCB0aGF0IHdpbGwgZ28gYXdheSB3aGVuIHdlIG92ZXJyaWRl
IGFsbCB0aGUgc3RvcmVzLg0KDQo+ID4gK3N0YXRpYyB2b2lkIGdlbl9leGVjX2NvdW50ZXJzKHBh
Y2tldF90ICpwa3QpDQo+ID4gK3sNCj4gPiArICAgIGludCBudW1faW5zbnMgPSBwa3QtPm51bV9p
bnNuczsNCj4gPiArICAgIGludCBudW1fcmVhbF9pbnNucyA9IDA7DQo+ID4gKyAgICBpbnQgaTsN
Cj4gPiArDQo+ID4gKyAgICBmb3IgKGkgPSAwOyBpIDwgbnVtX2luc25zOyBpKyspIHsNCj4gPiAr
ICAgICAgICBpZiAoIXBrdC0+aW5zbltpXS5pc19lbmRsb29wICYmDQo+ID4gKyAgICAgICAgICAg
ICFwa3QtPmluc25baV0ucGFydDEgJiYNCj4gPiArICAgICAgICAgICAgIUdFVF9BVFRSSUIocGt0
LT5pbnNuW2ldLm9wY29kZSwgQV9JVF9OT1ApKSB7DQo+ID4gKyAgICAgICAgICAgIG51bV9yZWFs
X2luc25zKys7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHRj
Z19nZW5fYWRkaV90bChoZXhfZ3ByW0hFWF9SRUdfUUVNVV9QS1RfQ05UXSwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICBoZXhfZ3ByW0hFWF9SRUdfUUVNVV9QS1RfQ05UXSwgMSk7DQo+ID4gKyAg
ICBpZiAobnVtX3JlYWxfaW5zbnMpIHsNCj4gPiArICAgICAgICB0Y2dfZ2VuX2FkZGlfdGwoaGV4
X2dwcltIRVhfUkVHX1FFTVVfSU5TTl9DTlRdLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICBoZXhfZ3ByW0hFWF9SRUdfUUVNVV9JTlNOX0NOVF0sIG51bV9yZWFsX2luc25zKTsNCj4gPiAr
ICAgIH0NCj4NCj4gdGNnX2dlbl9hZGRpX3RsIHdpbGwgY2hlY2sgZm9yIHRoZSBpbW1lZGlhdGUg
PT0gMC4NCg0KT0ssIGdyZWF0LiAgSSBhbHNvIHNlZSB0aGF0IHRjZ19nZW5fbW92X2kzMiB3aWxs
IGNoZWNrIHRoYXQgdGhlIHNvdXJjZSBhbmQgZGVzdCBhcmUgZGlmZmVyZW50LiAgU28gbm8gVENH
IGNvZGUgd2lsbCBiZSBnZW5lcmF0ZWQuDQoNCj4gQXMgd2l0aCB1cGRhdGluZyBQQyBmb3IgZXZl
cnkgaW5zbiwgdGhpcyBpcyBnb2luZyB0byBiZSBleHBlbnNpdmUuDQo+DQo+IFlvdSBjb3VsZCBh
Y2N1bXVsYXRlIHRoZXNlIHZhbHVlcyB0aHJvdWdoIHRoZSBUQiBhbmQgdGhlbiB1cGRhdGUgdGhl
bSBhdA0KPiB0aGUNCj4gZW5kLiAgWW91J2QgbmVlZCB0byBzdG9yZSB0aGUgaW50ZXJtZWRpYXRl
IHZhbHVlcyBpbiB0aGUgc3BhY2UgbWFuYWdlZCBieQ0KPiBUQVJHRVRfSU5TTl9TVEFSVF9FWFRS
QV9XT1JEUywgc28gdGhhdCB5b3UgY2FuIHVwZGF0ZSB0aGVtIG9uIGFueQ0KPiBleGNlcHRpb25h
bA0KPiBwYXRoIG91dCBvZiB0aGUgVEIsIGluIHJlc3RvcmVfc3RhdGVfdG9fb3BjKCkuDQoNCk9L
DQoNCj4gPiArICAgIGlmIChlbmRfdGIpIHsNCj4gPiArICAgICAgICB0Y2dfZ2VuX2V4aXRfdGIo
TlVMTCwgMCk7DQo+DQo+IFRoaXMgbWlzc2VzIG91dCBvbiBjdHgtPmJhc2Uuc2luZ2xlc3RlcF9l
bmFibGVkLCBhbmQgYWxtb3N0IGNlcnRhaW5seQ0KPiBiZWxvbmdzDQo+IGluIGhleGFnb25fdHJf
dGJfc3RvcC4gIFVzZQ0KPg0KPiAjZGVmaW5lIERJU0FTX0VYSVQgIERJU0FTX1RBUkdFVF8wDQo+
DQo+IG9yIHNvbWUgb3RoZXIgYXBwcm9wcmlhdGUgbmFtaW5nLg0KDQpPSw0KDQo=

