Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C110C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88B720578
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 20:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W0XmSW/R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="l41J1As7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88B720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCTsP-0004mT-RS
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 16:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTrh-0004L8-O7
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:23:49 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:41139)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTre-0002GC-QO
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 16:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598819026; x=1630355026;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ydubWCAjVHNwPtIm7Z0cSAKBvcc8KLaK7u4NcuTZ/ks=;
 b=W0XmSW/R5lFuClyb29zC6mSwVmqXFvNYpSVkiniix4tf4d++oWdLzV2+
 2QlHDR79VnjHp4G82voxVWRiwAi0vdSWpjzrRDUTE5UIKiW8+ZP+rS2S/
 1mjSxbQM8o4GvLY/EGVwffGcvF26tqZgIn3xs1APDTpKFuVoUF6Mqnls/ 8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Aug 2020 13:23:24 -0700
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 13:23:23 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 13:23:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 13:23:22 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5160.namprd02.prod.outlook.com (2603:10b6:a03:70::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Sun, 30 Aug
 2020 20:23:20 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 20:23:20 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Topic: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Index: AQHWdXdf6p/vkS3v9UGs80VPN3oP2KlOWTUAgALNmUA=
Date: Sun, 30 Aug 2020 20:23:20 +0000
Message-ID: <BYAPR02MB4886F42C26BAEEC5CF00D0AADE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
 <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
In-Reply-To: <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e6ccd9e-2415-4d8d-fe1d-08d84d228964
x-ms-traffictypediagnostic: BYAPR02MB5160:
x-microsoft-antispam-prvs: <BYAPR02MB516082E56354529F88EAF8B2DE500@BYAPR02MB5160.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qhwfi2tGB7wOcO8CSbTG/OFKG5vGhso7m4ddui5Yt0s3bchU0oCa+/4ER1NkDNN3CJof/4e4qgXPTt36WiyXzVR1fNVL8QLEg0a8uXV2pJ0wE7oaR7F+fXgRLvHaUiaUkErzw7cm9r9XEoD65SgOg9LTR9IaQyvgEz46SSjW6TlBqpd00dm81lZT/GLSoaHxyrmmuuRky4kEo5C7h088esGK4r7zONlMNCEfApwURrrn7NfuYqYyvKMvsK9kv5u9dqiO0LWpgFL+ZWK4Ywvdr0lROKnMQJRaU1rbfY4zibRhyJXU1fpLoG4fdNrj2/X5De3ZUJTI4VlBgTdDf4dmWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39850400004)(396003)(376002)(346002)(136003)(366004)(76116006)(9686003)(26005)(66556008)(4326008)(5660300002)(52536014)(86362001)(55016002)(8676002)(186003)(8936002)(64756008)(66476007)(66446008)(33656002)(316002)(66946007)(2906002)(83380400001)(7696005)(110136005)(54906003)(53546011)(71200400001)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9prvr5j7GywY//w9UGt5O781BC+ynA5KH4yGptvG4YI+WdmaIPxQEpi9rR7z9xResRRRe9G40c7laQrT15FK0nQxMcErEYzfoqIBColf4T+L5ztd7y7kTHx3+Z+OiFGXoaoPnJsiLlmhqA2QXQb9IDAJzTN3CP53Tul4C4va1H31yY0m57cgSqFEGDwlc6t005soRs1ASF8nUUSjC13tSrQQh8/cMIlFtn4bwsJsGNdJNz/zD/lA9kLA5pODkehmASHwvwb4KUnfuCVzY5ht4OQvqosLsVtlotN23E1prbTRb4e7ebHwLQ2jXItCVwfM8dTDWs6RhwWuTbunI0V+njiRkBorjXqyz5XJZjtSIhtOAgUzrNMtwIx94mlAk0PpPoRTAprgo3TjWigCOqmNtTEe1CnahtGk95uBulncU1KFdjnVmEc51u6eHgal7kAOYIV/HXII9kYsp9PGDxomB/jMUQAL1jiRHU5c3XgV+rnSu6HuKpPTayJRK7NnJwXHIWETz9iAAng0eiAHbJgOiMuCQViQ4gBaJm7JgygpEgm1SP5ev6mZuUvfYu3cVKet+8wW2GID2QAsM9ENPoPB6/K/LZkTNjnTEDDTXLiQTYPALdeFsA5gu+LEoT7KQUjOGLrnO5BM3IjODxlEAd5ETw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLda7ulFGRa8Cf0IyW1RWX4Yx68kbEKq97E/k/1PNf8+G1756PAsvKrEHyDTU+nZt//8Yfa6aaacXEOPcbmcrixavY7SV+Bta93K9cAzidIGH9UIhmIBL6Nj8Ie6Th4c9kn3PykB5UzGwZeI0FR5F+HEivdeDgjxaBxpQrs8pgoqInJ6UhOPRA/llcqUgZ91dFaTtdXk1lEvgVWSXBlUrJwZE46NNS3Mg1Y7r/+IqdT0QQunIaqkytoUldKjEv7g7SKVpo0BV9oYJmq38ZMJ3HZZP7+mmMNePZ5du2ODdfMwa71Su1QYeMecPp4trrdVbmAeqrpPm4Q/vhPPwBpppA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcNePQyDYfJp1x5TJDGAn5Kl7Ciu8jpw1d1fuK5+My4=;
 b=br3V3lohwXIvNjm/ZXNDAbAFEYj2UUGOLy+H/KC77Yt7Ve7YDlHiP1h8Rj5B6AMaO82AYSvxq6H6SUCAPA0ox7fAmvC1upRZT+EG3DAQEMhd+NkB8YoBLdwKbvcWGMoayLtub1iXjP4HRESZq/5xC9vpO89A7QgNe60SaUbRp3Uyk3n4qY85ULgMeBHwx1fTkGIG9x8TE+YkckwnV1i03RuAa1NckVoiy3VCUAXZ2ogiz7CSBwvGfEwRWspIEH4E/X+Ho+5dop8UNHET05sc9qznU2ROslxtwdjX6OZyr7sO/SPrWz2wl6p0X+Zh3QiUSaQmK655YiEeiXHMdmgJuQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcNePQyDYfJp1x5TJDGAn5Kl7Ciu8jpw1d1fuK5+My4=;
 b=l41J1As7nJmWNWFH/f91NxEyGQqBGHWE48J9F+g5uHOyDknYLzno/40kLhcsq3p4VgNNr66kzD+qLHL/lDFk+AgbcpLFy81+Bbknscsc3EQx4q8NY7l19lf0hfpJ9XTqB1Z7pW2+MlyIpD9IF6lXP9yyIspmPCWNa1ey3BEiiKM=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 8e6ccd9e-2415-4d8d-fe1d-08d84d228964
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 20:23:20.0720 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: uikoidGkXiMjP9bVlih0ArsLZS/GpVMGoHOxxuYxCkn1f/v5liSLSl8dyuwFUIZyZXOkk8YrIkPeS19ni9SZqQ==
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
IDI4LCAyMDIwIDc6MTcgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAyNi8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIG1hY3Jvcw0KPiByZWZlcmVuY2VkIGluIGluc3Ry
dWN0aW9uIHNlbWFudGljcw0KPg0KPiBPbiA4LzE4LzIwIDg6NTAgQU0sIFRheWxvciBTaW1wc29u
IHdyb3RlOg0KPiA+ICsgKiBGb3IgcWVtdSwgd2UgbG9vayBmb3IgYSBsb2FkIGluIHNsb3QgMCB3
aGVuIHRoZXJlIGlzICBhIHN0b3JlIGluIHNsb3QgMQ0KPiA+ICsgKiBpbiB0aGUgc2FtZSBwYWNr
ZXQuICBXaGVuIHdlIHNlZSB0aGlzLCB3ZSBjYWxsIGEgaGVscGVyIHRoYXQgbWVyZ2VzIHRoZQ0K
PiA+ICsgKiBieXRlcyBmcm9tIHRoZSBzdG9yZSBidWZmZXIgd2l0aCB0aGUgdmFsdWUgbG9hZGVk
IGZyb20gbWVtb3J5Lg0KPiA+ICsgKi8NCj4gPiArI2RlZmluZSBDSEVDS19OT1NIVUYoRFNULCBW
QSwgU1osIFNJR04pIFwNCj4gPiArICAgIGRvIHsgXA0KPiA+ICsgICAgICAgIGlmIChpbnNuLT5z
bG90ID09IDAgJiYgcGt0LT5wa3RfaGFzX3N0b3JlX3MxKSB7IFwNCj4gPiArICAgICAgICAgICAg
Z2VuX2hlbHBlcl9tZXJnZV9pbmZsaWdodF9zdG9yZSMjU1ojI1NJR04oRFNULCBjcHVfZW52LCBW
QSwNCj4gRFNUKTsgXA0KPiA+ICsgICAgICAgIH0gXA0KPiA+ICsgICAgfSB3aGlsZSAoMCkNCj4N
Cj4gQWgsIHNvIEkgc2VlIHdoYXQgeW91J3JlIHRyeWluZyB0byBkbyB3aXRoIHRoZSBtZXJnZSB0
aGluZywgd2hpY2ggaGFkIHRoZQ0KPiBob3N0LWVuZGlhbiBwcm9ibGVtcy4NCj4NCj4gSSB0aGlu
ayB0aGUgbWVyZ2Ugc3R1ZmYgaXMgYSBtaXN0YWtlLiAgSSB0aGluayB5b3UgY2FuIGdldCB0aGUg
c2VtYW50aWNzIHRoYXQNCj4geW91IHdhbnQgd2l0aA0KPg0KPiBwcm9iZV9yZWFkKGxkX2FkZHIs
IGxkX2xlbikNCj4gcWVtdV9zdChzdF92YWx1ZSwgc3RfYWRkcikNCj4gcWVtdV9sZChsZF92YWx1
ZSwgbGRfYWRkcikNCj4NCj4gSW4gdGhpcyB3YXksIGFsbCBleGNlcHRpb25zIGFyZSByZWNvZ25p
emVkIGJlZm9yZSB0aGUgc3RvcmUgaXMgY29tcGxldGUsIHRoZQ0KPiBub3JtYWwgbWVtb3J5IG9w
ZXJhdGlvbnMgaGFuZGxlIGFueSBwb3NzaWJsZSBvdmVybGFwLg0KDQpTbywgZG8gdGhpcyBpbnNp
ZGUgdGhlIGhlbHBlcj8gIE9yIGlzIHRoZXJlIGEgd2F5IHRvIGdlbmVyYXRlIFRDRyBjb2RlPw0K
DQo+DQo+ID4gKyNkZWZpbmUgZklOU0VSVF9CSVRTKFJFRywgV0lEVEgsIE9GRlNFVCwgSU5WQUwp
IFwNCj4gPiArICAgIGRvIHsgXA0KPiA+ICsgICAgICAgIFJFRyA9ICgoUkVHKSAmIH4oKChmQ09O
U1RMTCgxKSA8PCAoV0lEVEgpKSAtIDEpIDw8IChPRkZTRVQpKSkgfCBcDQo+ID4gKyAgICAgICAg
ICAgKCgoSU5WQUwpICYgKChmQ09OU1RMTCgxKSA8PCAoV0lEVEgpKSAtIDEpKSA8PCAoT0ZGU0VU
KSk7IFwNCj4gPiArICAgIH0gd2hpbGUgKDApDQo+DQo+IHJlZyA9IGRlcG9zaXQzMihyZWcsIG9m
ZnNldCwgd2lkdGgsIGludmFsKQ0KDQpPSw0KDQo+ID4gKyNkZWZpbmUgZkVYVFJBQ1RVX0JJVFMo
SU5SRUcsIFdJRFRILCBPRkZTRVQpIFwNCj4gPiArICAgIChmWlhUTihXSURUSCwgMzIsIChJTlJF
RyA+PiBPRkZTRVQpKSkNCj4gPiArI2RlZmluZSBmRVhUUkFDVFVfQklESVIoSU5SRUcsIFdJRFRI
LCBPRkZTRVQpIFwNCj4gPiArICAgIChmWlhUTihXSURUSCwgMzIsIGZCSURJUl9MU0hJRlRSKChJ
TlJFRyksIChPRkZTRVQpLCA0XzgpKSkNCj4gPiArI2RlZmluZSBmRVhUUkFDVFVfUkFOR0UoSU5S
RUcsIEhJQklULCBMT1dCSVQpIFwNCj4gPiArICAgIChmWlhUTigoSElCSVQgLSBMT1dCSVQgKyAx
KSwgMzIsIChJTlJFRyA+PiBMT1dCSVQpKSkNCj4NCj4gZXh0cmFjdDMyKGlucmVnLCBvZmZzZXQs
IHdpZHRoKQ0KDQpPSw0KDQo+ID4gKyNkZWZpbmUgZlpYVE4oTiwgTSwgVkFMKSAoKFZBTCkgJiAo
KDFMTCA8PCAoTikpIC0gMSkpDQo+DQo+IGV4dHJhY3QzMihWQUwsIDAsIG4pDQoNCk9LDQoNCj4g
PiArI2RlZmluZSBmU1hUTihOLCBNLCBWQUwpIFwNCj4gPiArICAgICgoZlpYVE4oTiwgTSwgVkFM
KSBeICgxTEwgPDwgKChOKSAtIDEpKSkgLSAoMUxMIDw8ICgoTikgLSAxKSkpDQo+DQo+IHNleHRy
YWN0MzIodmFsLCAwLCBuKQ0KDQpPSw0KDQo+ID4gKyNkZWZpbmUgZlJORChBKSAoKChBKSArIDEp
ID4+IDEpDQo+DQo+IERvZXMgQSBoYXZlIGEgdHlwZSB0aGF0IHdvbid0IG92ZXJmbG93Pw0KPiBG
b3IgQXJtIHdlIHdyaXRlIHRoaXMgYXMNCj4NCj4gICAgIChBID4+IDEpICsgKEEgJiAxKQ0KDQpX
aWxsIGludmVzdGlnYXRlDQoNCj4gPiArI2RlZmluZSBmRENGRVRDSChSRUcpIGRvIHsgUkVHID0g
UkVHOyB9IHdoaWxlICgwKSAvKiBOb3RoaW5nIHRvIGRvIGluDQo+IHFlbXUgKi8NCj4gPiArI2Rl
ZmluZSBmSUNJTlZBKFJFRykgZG8geyBSRUcgPSBSRUc7IH0gd2hpbGUgKDApIC8qIE5vdGhpbmcg
dG8gZG8gaW4NCj4gcWVtdSAqLw0KPiA+ICsjZGVmaW5lIGZMMkZFVENIKEFERFIsIEhFSUdIVCwg
V0lEVEgsIFNUUklERSwgRkxBR1MpDQo+ID4gKyNkZWZpbmUgZkRDQ0xFQU5BKFJFRykgZG8geyBS
RUcgPSBSRUc7IH0gd2hpbGUgKDApIC8qIE5vdGhpbmcgdG8gZG8gaW4NCj4gcWVtdSAqLw0KPiA+
ICsjZGVmaW5lIGZEQ0NMRUFOSU5WQShSRUcpIFwNCj4gPiArICAgIGRvIHsgUkVHID0gUkVHOyB9
IHdoaWxlICgwKSAvKiBOb3RoaW5nIHRvIGRvIGluIHFlbXUgKi8NCj4NCj4gSXMgdGhpcyAiUj1S
IiB0aGluZyB0cnlpbmcgdG8gYXZvaWQgYSBjb21waWxlciB3YXJuaW5nPw0KPiBQZXJoYXBzICIo
dm9pZClSIiB3b3VsZCBiZSBzdWZmaWNpZW50IHRvIGF2b2lkIHRoYXQ/DQoNClllcywgaXQgYXZv
aWRzIGEgY29tcGlsZXIgd2FybmluZy4gIFdpbGwgY2hhbmdlIHRvICh2b2lkKQ0KDQo+ID4gLXN0
YXRpYyBpbmxpbmUgdm9pZCBsb2dfc3RvcmUzMihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0
X3Vsb25nIGFkZHIsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0YXJnZXRf
dWxvbmcgdmFsLCBpbnQgd2lkdGgsIGludCBzbG90KQ0KPiA+IC17DQo+ID4gLSAgICBIRVhfREVC
VUdfTE9HKCJsb2dfc3RvcmUlZCgweCIgVEFSR0VUX0ZNVF9seCAiLCAiDQo+IFRBUkdFVF9GTVRf
bGQNCj4gPiAtICAgICAgICAgICAgICAgICAgIiBbMHgiIFRBUkdFVF9GTVRfbHggIl0pXG4iLA0K
PiA+IC0gICAgICAgICAgICAgICAgICB3aWR0aCwgYWRkciwgdmFsLCB2YWwpOw0KPiA+IC0gICAg
ZW52LT5tZW1fbG9nX3N0b3Jlc1tzbG90XS52YSA9IGFkZHI7DQo+ID4gLSAgICBlbnYtPm1lbV9s
b2dfc3RvcmVzW3Nsb3RdLndpZHRoID0gd2lkdGg7DQo+ID4gLSAgICBlbnYtPm1lbV9sb2dfc3Rv
cmVzW3Nsb3RdLmRhdGEzMiA9IHZhbDsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAtc3RhdGljIGlubGlu
ZSB2b2lkIGxvZ19zdG9yZTY0KENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcgYWRk
ciwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0X3QgdmFsLCBpbnQg
d2lkdGgsIGludCBzbG90KQ0KPiA+IC17DQo+ID4gLSAgICBIRVhfREVCVUdfTE9HKCJsb2dfc3Rv
cmUlZCgweCIgVEFSR0VUX0ZNVF9seCAiLCAlbGQgWzB4JWx4XSlcbiIsDQo+ID4gLSAgICAgICAg
ICAgICAgICAgICB3aWR0aCwgYWRkciwgdmFsLCB2YWwpOw0KPiA+IC0gICAgZW52LT5tZW1fbG9n
X3N0b3Jlc1tzbG90XS52YSA9IGFkZHI7DQo+ID4gLSAgICBlbnYtPm1lbV9sb2dfc3RvcmVzW3Ns
b3RdLndpZHRoID0gd2lkdGg7DQo+ID4gLSAgICBlbnYtPm1lbV9sb2dfc3RvcmVzW3Nsb3RdLmRh
dGE2NCA9IHZhbDsNCj4gPiAtfQ0KPiA+IC0NCj4NCj4gRm9sZCB0aGlzIGJhY2sgdG8gd2hlcmV2
ZXIgaXQgY2FtZSBmcm9tLiAgQ2xlYXJseSBubyBuZWVkIHRvIGludHJvZHVjZSBpdCBpbg0KPiB0
aGUgZmlyc3QgcGxhY2UuDQoNClRoZXNlIGFyZSBpbnZva2VkIGJ5IHRoZSBNRU1fU1RPUkUgbWFj
cm9zLiAgQXJlIHlvdSBzYXlpbmcgdG8gcHV0IHRoaXMgY29kZSB0aGVyZT8NCg0KDQo=

