Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44458C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3ECE2064C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XOWi1FPj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Y8OS9lSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3ECE2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQ3w-0000bp-8r
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iwQ3G-0008TH-12
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iwQ3E-0006Jc-Jg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:33:06 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:5393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iwQ3E-0006Fi-6U
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1580214784; x=1611750784;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dbxRXByRCGeQJ8I5/GB1F//L6BQqJb8pjk+S/TLiaio=;
 b=XOWi1FPjkuTy0uyTNgTg9zsOIgJKPr0KdXXYci3Pd+Z5+9OfAIRmbjbh
 +OU08qi9rqYxTQvq3mtEa2p1WHV4vCMwLNKdXzwSDCFNLbSUe/lZWBA1Y
 /mrxuoOKf5RTYIAIgpSXG8CN7fsFR4zOnFEu3zQooOPcojPUK2l2H1pF4 g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Jan 2020 04:33:01 -0800
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 28 Jan 2020 04:33:00 -0800
Received: from APSANEXR01E.ap.qualcomm.com (10.85.0.38) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 28 Jan 2020 04:33:00 -0800
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 APSANEXR01E.ap.qualcomm.com (10.85.0.38) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 28 Jan 2020 04:32:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 28 Jan 2020 04:32:57 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4344.namprd02.prod.outlook.com (52.135.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 12:32:55 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::d9c2:a411:1acc:21c4]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::d9c2:a411:1acc:21c4%5]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 12:32:55 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Matus Kysel <mkysel@tachyum.com>
Subject: RE: [PATCH] Handling SIGSETXID used by glibc NPTL setuid/setgid
Thread-Topic: [PATCH] Handling SIGSETXID used by glibc NPTL setuid/setgid
Thread-Index: AQHVzGRP+rlPtP6gT0uwd8Pd6VRcbKf/4USAgAAueyA=
Date: Tue, 28 Jan 2020 12:32:55 +0000
Message-ID: <BYAPR02MB4886C0D683ABE475CBC1F23BDE0A0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200116115700.127951-1-mkysel@tachyum.com>
 <CAFEAcA_pOAX=pCk0TfbwwUPHUX2YhLtxMonYVazMrGZBvPJkPw@mail.gmail.com>
In-Reply-To: <CAFEAcA_pOAX=pCk0TfbwwUPHUX2YhLtxMonYVazMrGZBvPJkPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [103.229.18.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db0cf378-ba37-42e8-d868-08d7a3ee3367
x-ms-traffictypediagnostic: BYAPR02MB4344:
x-microsoft-antispam-prvs: <BYAPR02MB43442A5116F473CF694E3D51DE0A0@BYAPR02MB4344.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(189003)(66946007)(8936002)(54906003)(110136005)(478600001)(966005)(9686003)(8676002)(76116006)(55016002)(316002)(52536014)(26005)(86362001)(71200400001)(81156014)(4326008)(81166006)(66556008)(66476007)(53546011)(6506007)(5660300002)(7696005)(66446008)(64756008)(33656002)(186003)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4344;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hgnrgn+Sy+XOoGbSiF92oWRvi5aHqgd4jToNGls/u08Lhb234/udo6XPfy2+TmJ/ps8IvkiP9U+d3QxHIruEpnR/96jN1N0q+AbZFM7iVCDfZIpDqeM+wtFVNU5MQcvicMIZkCz25JUxSNkL7rPsNEYWXvg9AZOIH/OpTnl0048iGuHtRUO0CntP/g2pZZFMLFHRgPq1JWKpgJ0gJ9l9CMdJ29jW07OVxQAR9cXK/0lIxX2UJpZDIe76aC64j5liEBmRV1NN3Kxw3ErsrKZrPDTjJVSaSo7yhrasBmoIbbHLyn3Pl7iDfNspUquFkCKo0RsIXdpqchDRBHCsp947YuqWWBaf9UX39pPLJTzU/bpCbVAcyi7IGx0KnEiYxmtvGNZYFVHMA8lzz/IFrk7Ze+0Wo0sc1g8gTMs/TULSa8GPdCOvtyHBLQfEZf9gQohBFlW1XUlwCJp2NEBnqJpREfyAWgO01L8AqeD+sQoHW6G/oZr2dVRVLmtHhWujRY7oDR6Fl5HJykaHNb0LBgb2nQ==
x-ms-exchange-antispam-messagedata: eZcCWyhFfSVkFa6RSDpK2zrVlu8L8TCCpaIeZGUhEq0XyM6QTj/7A8lrZa4HnBbHqOj2pQ0mwXYae2dP6PokG758/IrZL3HymegtOPYEJTEIsoKkAyWVX2WeG3tMfPZiCizgJwiCCJqLlSJFW5U2Zg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRwl8JZ5RT3YMGF+v0hjecdIl/Q5xcBwWSI2bmdOcaBmCO8MeFgeusLxPm/ykkvTcFUM3m4bHiTYky7vKNQ19Y8fT+ZCBAvsGe+6qh2hKu/FRrymzZ5xImNhvmnII3Fs6WvCQC7acow0svfVXssvuDXG3Qk3vNVoM1o/RNvXy7YiuzhLrIR0m0Tld8EAQH48ddnjFm26c4L3qIxoVjdnkBIYzan8UIrCWkoiqa115tY+Jps6zgDz/Wi0BCuwPUCy4kZU0Ol/flsQx3hIugoHlfPOWWa1wrRnDwY20v1m8ht8kKjZZfuZpXsydI8EJzHTzYYJXgSdUK6Tx95/T01AQQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLKm/IkI2ihz5LRPV5gafZyw0VzlADkhgKzn/TRp0Y4=;
 b=Uhmt3HGNqFGHSwc7iMvNKYFJvcyZ0NQLXWOPoXZESj2To46AixDBbiAU5OPaUoyYd1+BGErCC2QQAnEBqbOG3EuaihWJj4UEOGDSEu8bD0HLQbjqlv2AocCp8YjfcStEqaxzY9et6P9LRqNKJ4q7NwfG529x0k3A7Vd0LBR1Ng3r0E4L9A2WxM2aqKOIyGbAnjZ4cziux/7A7kZDast/l86cy4YdrVVpJUdDwYzQRBlRawKCCcBTMzNF1IwAcvtISlHUx7OdXlyiQ/XWhhgNtesC/2acQJUx/CJ7oHpM5tqnPTofRQA8suk/Ie7M9buKEvZot1wfCAGPE8sXm0MWdA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLKm/IkI2ihz5LRPV5gafZyw0VzlADkhgKzn/TRp0Y4=;
 b=Y8OS9lSUBjTstMWCGZkyr8GIfzXihC53/uP30gN52uJ++9q6rAXXVbkfXrUap0YO3AUAJ61UlJmWfIckOxERxtRQD6+1BKeCtf5VaN1btLni9ykQaywWnflokoUn0TKqB6kEUDbQzd0CF+aWNYtenP6kp71VvD4bpol29YliVhc=
x-ms-exchange-crosstenant-network-message-id: db0cf378-ba37-42e8-d868-08d7a3ee3367
x-ms-exchange-crosstenant-originalarrivaltime: 28 Jan 2020 12:32:55.3793 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: FPAN5WsvZpXwWOgQhFAWSdTFgF2X8lXKuqLQPlRN27Q8rXgMiP9lPD6DsF5UmbuzOh50nhbC96vzAyYOoZvZLQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4344
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSBwcm9wb3NlZCBhIHNpbWlsYXIgcGF0Y2ggZ3VhcmRlZCBieSAjaWZkZWYgVEFSR0VUX0hFWEFH
T04uICBJIHVuZGVyc3RhbmQgd2UgZG9uJ3Qgd2FudCB0byBicmVhayB0aGluZ3MgdGhhdCBhcmUg
d29ya2luZywgYW5kIHdlIGRvbid0IHdhbnQgdG8gb3BlbiB0aGUgZG9vciBmb3IgYSBidW5jaCBv
ZiAjaWZkZWYncyBoZXJlLiAgSG93ZXZlciwgbW9yZSB0aGFuIG9uZSBzY2VuYXJpbyBuZWVkcyB0
aGlzIGNhcGFiaWxpdHkuDQoNCldvdWxkIGEgc3VpdGFibGUgY29tcHJvbWlzZSBiZSB0byBwcm92
aWRlIGEgaG9vayBpbiBsaW51eC11c2VyL3NpZ25hbC5jIGZvciB0aGUgdGFyZ2V0IHRvIHB1dCBp
biB0aGUgY2hhbmdlcyB0aGV5IG5lZWQ/DQoNCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFn
b24vdGFyZ2V0X3NpZ25hbC5oIGIvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9zaWduYWwuaA0K
aW5kZXggYWU1MmZmNS4uZjgyZjhjMSAxMDA2NDQNCi0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi90
YXJnZXRfc2lnbmFsLmgNCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfc2lnbmFsLmgN
CkBAIC0zMSw0ICszMSwxNSBAQCB0eXBlZGVmIHN0cnVjdCB0YXJnZXRfc2lnYWx0c3RhY2sgew0K
DQogI2luY2x1ZGUgIi4uL2dlbmVyaWMvc2lnbmFsLmgiDQoNCisgICAgLyoNCisgICAgICogSGV4
YWdvbiB1c2VzIHRoZSBzYW1lIHNpZ25hbCBmb3IgcHRocmVhZCBjYW5jZWwgYXMgdGhlIGhvc3Qg
cHRocmVhZHMsDQorICAgICAqIHNvIGNhbm5vdCBiZSBvdmVycmlkZGVuLg0KKyAgICAgKiBUaGVy
ZWZvcmUsIHdlIG1hcCBIZXhhZ29uIHNpZ25hbCB0byBhIGRpZmZlcmVudCBob3N0IHNpZ25hbC4N
CisgICAgICovDQorI2RlZmluZSBTSUdOQUxfTU9EUyBcDQorICAgIFtfX1NJR1JUTUlOICsgMV0g
PSBfX1NJR1JUTUFYIC0gMSwgXA0KKyAgICBbX19TSUdSVE1BWCAtIDFdID0gX19TSUdSVE1JTiAr
IDEsDQorDQorDQorDQogI2VuZGlmIC8qIFRBUkdFVF9TSUdOQUxfSCAqLw0KZGlmZiAtLWdpdCBh
L2xpbnV4LXVzZXIvc2lnbmFsLmMgYi9saW51eC11c2VyL3NpZ25hbC5jDQppbmRleCA1Y2E2ZDYy
Li5lYmNhNzcwIDEwMDY0NA0KLS0tIGEvbGludXgtdXNlci9zaWduYWwuYw0KKysrIGIvbGludXgt
dXNlci9zaWduYWwuYw0KQEAgLTI0LDYgKzI0LDcgQEANCiAjaW5jbHVkZSAicWVtdS5oIg0KICNp
bmNsdWRlICJ0cmFjZS5oIg0KICNpbmNsdWRlICJzaWduYWwtY29tbW9uLmgiDQorI2luY2x1ZGUg
InRhcmdldF9zaWduYWwuaCINCg0KIHN0YXRpYyBzdHJ1Y3QgdGFyZ2V0X3NpZ2FjdGlvbiBzaWdh
Y3RfdGFibGVbVEFSR0VUX05TSUddOw0KDQpAQCAtNzIsNiArNzMsOSBAQCBzdGF0aWMgdWludDhf
dCBob3N0X3RvX3RhcmdldF9zaWduYWxfdGFibGVbX05TSUddID0gew0KICAgICAgICBvdmVyIGEg
c2luZ2xlIGhvc3Qgc2lnbmFsLiAgKi8NCiAgICAgW19fU0lHUlRNSU5dID0gX19TSUdSVE1BWCwN
CiAgICAgW19fU0lHUlRNQVhdID0gX19TSUdSVE1JTiwNCisjaWZkZWYgU0lHTkFMX01PRFMNCisg
ICAgU0lHTkFMX01PRFMNCisjZW5kaWYNCiB9Ow0KIHN0YXRpYyB1aW50OF90IHRhcmdldF90b19o
b3N0X3NpZ25hbF90YWJsZVtfTlNJR107DQoNCg0KVGF5bG9yDQoNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBRZW11LWRldmVsIDxxZW11LWRldmVsLQ0KPiBib3VuY2Vz
K3RzaW1wc29uPXF1aWNpbmMuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZiBQZXRlciBNYXlk
ZWxsDQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjgsIDIwMjAgMzoyNyBBTQ0KPiBUbzogTWF0
dXMgS3lzZWwgPG1reXNlbEB0YWNoeXVtLmNvbT4NCj4gQ2M6IFJpa3UgVm9pcGlvIDxyaWt1LnZv
aXBpb0Bpa2kuZmk+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS0NCj4gZGV2
ZWxAbm9uZ251Lm9yZz47IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gSGFuZGxpbmcgU0lHU0VUWElEIHVzZWQgYnkgZ2xpYmMgTlBUTCBz
ZXR1aWQvc2V0Z2lkDQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gQ0FVVElPTjogVGhpcyBlbWFp
bCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLg0KPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+DQo+IE9uIFRodSwgMTYgSmFuIDIwMjAgYXQgMTE6NTgsIE1hdHVzIEt5c2Vs
IDxta3lzZWxAdGFjaHl1bS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVXNlZCBzYW1lIHN0eWxlIHRv
IGhhbmRsZSBhbm90aGVyIGdsaWJjIHJlc2VydmVkIHNpZ25hbCBTSUdTRVRYSUQNCj4gPiAoMzMp
LCB0aGF0IGlzIHVzZWQgYnkgZ2xpYmMgTlBUTCBzZXR1aWQvc2V0Z2lkIGZ1bmN0aW9ucy4gVGhp
cyBzaG91bGQNCj4gPiBmaXggcHJvYmxlbXMgd2l0aCBhcHBsaWNhdGlvbiB1c2luZyB0aG9zZSBm
dW5jdGlvbnMgYW5kIGZhaWxpbmcgd2l0aA0KPiA+IGVycm9yICJxZW11OmhhbmRsZV9jcHVfc2ln
bmFsIHJlY2VpdmVkIHNpZ25hbCBvdXRzaWRlIHZDUFUgY29udGV4dCIuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXR1cyBLeXNlbCA8bWt5c2VsQHRhY2h5dW0uY29tPg0KPiA+IC0tLQ0KPiA+
ICBsaW51eC11c2VyL3NpZ25hbC5jIHwgMTMgKysrKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2xpbnV4LXVzZXIvc2lnbmFsLmMgYi9saW51eC11c2VyL3NpZ25hbC5jIGluZGV4DQo+ID4g
MDEyOGJkZTRkMi4uYzU5MjIxZmQwYSAxMDA2NDQNCj4gPiAtLS0gYS9saW51eC11c2VyL3NpZ25h
bC5jDQo+ID4gKysrIGIvbGludXgtdXNlci9zaWduYWwuYw0KPiA+IEBAIC02NiwxMSArNjYsMTYg
QEAgc3RhdGljIHVpbnQ4X3QgaG9zdF90b190YXJnZXRfc2lnbmFsX3RhYmxlW19OU0lHXSA9DQo+
IHsNCj4gPiAgICAgIFtTSUdQV1JdID0gVEFSR0VUX1NJR1BXUiwNCj4gPiAgICAgIFtTSUdTWVNd
ID0gVEFSR0VUX1NJR1NZUywNCj4gPiAgICAgIC8qIG5leHQgc2lnbmFscyBzdGF5IHRoZSBzYW1l
ICovDQo+ID4gLSAgICAvKiBOYXN0eSBoYWNrOiBSZXZlcnNlIFNJR1JUTUlOIGFuZCBTSUdSVE1B
WCB0byBhdm9pZCBvdmVybGFwIHdpdGgNCj4gPiAtICAgICAgIGhvc3QgbGlicHRocmVhZCBzaWdu
YWxzLiAgVGhpcyBhc3N1bWVzIG5vIG9uZSBhY3R1YWxseSB1c2VzIFNJR1JUTUFYIDotDQo+IC8N
Cj4gPiAtICAgICAgIFRvIGZpeCB0aGlzIHByb3Blcmx5IHdlIG5lZWQgdG8gZG8gbWFudWFsIHNp
Z25hbCBkZWxpdmVyeSBtdWx0aXBsZXhlZA0KPiA+IC0gICAgICAgb3ZlciBhIHNpbmdsZSBob3N0
IHNpZ25hbC4gICovDQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogTmFzdHkgaGFjazogU3dhcCBT
SUdSVE1JTiBhbmQgU0lHUlRNSU4gKyAxIHdpdGggU0lHUlRNQVggYW5kDQo+IFNJR1JUTUFYIC0g
MQ0KPiA+ICsgICAgICogdG8gYXZvaWQgb3ZlcmxhcCB3aXRoIGhvc3QgbGlicHRocmVhZCAoTlBU
TCBnbGliYykgc2lnbmFscy4NCj4gPiArICAgICAqIFRoaXMgYXNzdW1lcyBubyBvbmUgYWN0dWFs
bHkgdXNlcyBTSUdSVE1BWCBhbmQgU0lHUlRNQVggLSAxIDotLw0KPiA+ICsgICAgICogVG8gZml4
IHRoaXMgcHJvcGVybHkgd2UgbmVlZCB0byBkbyBtYW51YWwgc2lnbmFsIGRlbGl2ZXJ5IG11bHRp
cGxleGVkDQo+ID4gKyAgICAgKiBvdmVyIGEgc2luZ2xlIGhvc3Qgc2lnbmFsLg0KPiA+ICsgICAg
ICovDQo+ID4gICAgICBbX19TSUdSVE1JTl0gPSBfX1NJR1JUTUFYLA0KPiA+ICsgICAgW19fU0lH
UlRNSU4gKyAxXSA9IF9fU0lHUlRNQVggLSAxLA0KPiA+ICsgICAgW19fU0lHUlRNQVggLSAxXSA9
IF9fU0lHUlRNSU4gKyAxLA0KPiA+ICAgICAgW19fU0lHUlRNQVhdID0gX19TSUdSVE1JTiwNCj4g
PiAgfTsNCj4gPiAgc3RhdGljIHVpbnQ4X3QgdGFyZ2V0X3RvX2hvc3Rfc2lnbmFsX3RhYmxlW19O
U0lHXTsNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPg0KPiBUaGlzIGlzIGEgbG9uZy1zdGFuZGluZyBr
bm93biBwcm9ibGVtLCBidXQgZG9pbmcgdGhpcyBpcyBsaWtlbHkgdG8gYnJlYWsNCj4gY3VycmVu
dGx5LXdvcmtpbmcgZ3Vlc3QgYmluYXJpZXMgKG5vdGFibHkgdGhpbmdzIHdyaXR0ZW4gaW4gR28p
LiBTZWUgZm9yDQo+IGV4YW1wbGUgdGhlIGRpc2N1c3Npb24gb24gdGhpcyB0aHJlYWQ6DQo+IGh0
dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTA4L21zZzAz
ODA0Lmh0bWwNCj4NCj4gdGhhbmtzDQo+IC0tIFBNTQ0KDQo=

