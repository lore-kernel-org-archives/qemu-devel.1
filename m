Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0189C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0687B20759
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dok88aQB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="IYVBUB6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0687B20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9WE-0003ch-RG
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 11:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kY9QF-00054n-Oh
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:01:03 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37498)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kY9QC-0002OY-7M
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1603983660; x=1635519660;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uMAk8E8tF0P6C108WKXB6yeABaEbnT29Pc+qQNM6/Bs=;
 b=Dok88aQB9AVK52OXZXXl+NIozaGCcmWjMYkI3YdmGoZP38/tZPUKMYK0
 ulzxrx5OnyZe1HtAfkIR4zZM+0usvjP3VHr7I4vn6wQ+vujCuqlEelhm8
 kV/Q51q37xHoDmMuDYg6kYf5MQw/iX/nVyNsCz5diBaVj49kTCMmMHoVB g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Oct 2020 08:00:56 -0700
X-QCInternal: smtphost
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 29 Oct 2020 08:00:56 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Oct 2020 08:00:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 29 Oct 2020 08:00:55 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6322.namprd02.prod.outlook.com (2603:10b6:a03:1fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Thu, 29 Oct
 2020 15:00:49 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 15:00:49 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Taylor Simpson <tsimpson@quicinc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] qemu/int128: Add int128_or()
Thread-Topic: [PATCH] qemu/int128: Add int128_or()
Thread-Index: AQHWrgPhMIH3sehdXkWn4h3BL4HnyamurFPg
Date: Thu, 29 Oct 2020 15:00:48 +0000
Message-ID: <BYAPR02MB4886CD61CE47A14682ABB78EDE140@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1603983447-27303-1-git-send-email-tsimpson@quicinc.com>
In-Reply-To: <1603983447-27303-1-git-send-email-tsimpson@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: quicinc.com; dkim=none (message not signed)
 header.d=none;quicinc.com; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 287db4e5-5085-4b5b-d6b7-08d87c1b6bfe
x-ms-traffictypediagnostic: BY5PR02MB6322:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6322681951EDFE587CB8C2F9DE140@BY5PR02MB6322.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Ujsx3GFPeXfSsyOLbx+BgtIkwmJsT8wGgQzF1W8JKIAqrufZWeZiKch+0WL4Y2h3KFQEzcDm4heFWxe2eWKbe11xZ2i0UuSVQLZuncgvVwx/166ZpgFgjmV8FGvzUW6Lp0QtvEzCRWrRofPmMtlUwy3GnfbG28LcMI3Y5lJHyTljOtazCas8zrox4ix7XoRkmeYGl5BbZJ/gc++1i+pcvVAZL22tEGRbdqkdt4ynVTw3OQV19ffCVEowlDlLCFLZ/IzGhJVTG9ysW9OqM24iwKgl1pRTSceX+LMZ7AgQ/a7HOhtzG356z6PmcZOHXHw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(83380400001)(7696005)(478600001)(53546011)(6506007)(86362001)(186003)(5660300002)(26005)(4326008)(66556008)(66476007)(33656002)(66946007)(66446008)(64756008)(52536014)(71200400001)(76116006)(8676002)(55016002)(9686003)(8936002)(2906002)(110136005)(54906003)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 44ut8sDbiLv4HYbEW1LF76XbAwR2h9U8U5mwQFf+JUTM3Ux7hd1SJ262jyxOHZYnDvLBtdozzLZ9qfGTVOyFPjjXAOjschW1Be6RqUMnFuhlmBxEo53T9VFeO9KxQheQE/fbbPcFYKSn1uFt6brLyPayAPxInUFPUQJbXZPDCUqRdNGdEO0P3IxemS7lNeVLfjx0C3hqS+oknxpOxINwzwubIqp/rsvrP89bhdL5WjC9pPtPMONum8Izz+YJvlRJddXhTY1QMdqLnrXby7iew0Q4Px3hDMdBcG1Arzps68UCiO82fxkFSCZKNVyRMGwd+zx0I0yHJ+23elYInE0TgStKaO14tvYVOupRN9n3ETtMo6NHffMjLOLMY5bQcz8yBC5ImEqQgM3FV4js6j+orn8xMoVwKGjIyVo2Fj3TODieqPTqfoyGyg8HAMNafhYYRZ0sCrarXyx7RRbyvFbnUewjUwDyJwiDFE/2UmgooOD8Hc54xPTsMHW/N37N4sSUSWq71uT68PzsInk2xJx/01k9x1rUe43K7lzRx3loQakb6ILRjU93afpgyJhSsA+UbxgL9t9be0jyHk5b6MO7PeL+Wb5M5FNX9DWeG+whXhLdFKcc+yqGQTGl1LyvL9nAGIWagBzc4oJ0abFFrKwz2w==
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJoQWx253ytkqqb08kPQhliGC3Bz8Kz+5I8raz2ZxOdPfbw36/lpoLlStV6fHjHkZT/nwFpLT+NxxpTIL0iceQ5VA0dwjtG9VyjT4pK/A9PSUNunrE4h3NFOeihSwFjNAXxiMn1WLRddWobY77CfEzZWAmHu1lZz38/I67wVgTwqp9AuESH++4ZCmsMgkvVgCzHxjy6eKeLn/pT8AJ6xb3vpc+5JvQoFPusJ7AE1+Ep6FxDLdBapnvrVsMvfoP0wUKX2x2MVlWZZJ/JLajFdOgRprvPHzaHsGVbquo8ib21Exs+M1joZLyWgRrCazD7AXqyx9Bfomt1QsqnbMYVPdA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn1jkd7ctIE2GONI6x4y64hc1R/TlGUAsa7UuY90uO8=;
 b=eSEBzo/emHnCXwuE5rd9szdTKQSyDiVfxWsyMW0VrSNK4d5LCskty0ksfxEbGZHTvocfoL67m4OOexHXpVUuwX2kDazi1T0y3ZM8IzU+UOgLRBFFu+kIGdOW3zFYLz2yoyMwjVtJyYerztMV3mTzwIdQK/1zTPz3jMyLdM4R93KAFNRsWRFmDbPw102J+eDUpPD5247p2IUjOyNK47fw9WWbW4KqVA125sL6VgPiYND5C/sTmIAZLnG9cXRZ17M58zM6zn8H/S+ZZ84BS6NLlnv2GYn2vGCIEi+E3bQHX3r5otgzThC2T8owSbsVhjTW4zfIRB/ue+V3Rb1SJUFb1w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn1jkd7ctIE2GONI6x4y64hc1R/TlGUAsa7UuY90uO8=;
 b=IYVBUB6Go4rjgX1NPsm3qgVho+winckd+bXFeENvjpStW87fsN6tZH8e7vVEe2sOsdUbyfYrz5RQkfzx2W3NE0Lgm6Fa1xSADqLT9RUCJ6GyKXSmvtQs3VPAbDp5RgJfEPi0xpD554VSfxCXcJFgJFKw9sRE83rouiZ2FjOk7xU=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 287db4e5-5085-4b5b-d6b7-08d87c1b6bfe
x-ms-exchange-crosstenant-originalarrivaltime: 29 Oct 2020 15:00:48.9590 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: BbvTF+nyEidKHZk9PB8JzxfAqsyjt9t28HQgpu6wJKjpL9JBKRXIHSnTxxYzugakSx4wEha6vSfNMZTDYMY/tw==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6322
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 11:00:57
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
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QXBvbG9naWVzIGZvciB0aGlzIC0gSSBzZWUgUmljaGFyZCBoYXMgdGhlIHNhbWUgcGF0Y2guDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGF5bG9yIFNpbXBzb24gPHRz
aW1wc29uQHF1aWNpbmMuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyOSwgMjAyMCA5
OjU3IEFNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IFRheWxvciBTaW1wc29u
IDx0c2ltcHNvbkBxdWljaW5jLmNvbT47IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7DQo+
IGY0YnVnQGFtc2F0Lm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIHFlbXUvaW50MTI4OiBBZGQgaW50
MTI4X29yKCkNCj4NCj4gQWRkIHRoZSBpbnQxMjhfb3IoKSBpbXBsZW1lbnRhdGlvbi4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPg0KPiBS
ZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPGY0YnVnQGFtc2F0Lm9yZz4NCj4g
LS0tDQo+ICBpbmNsdWRlL3FlbXUvaW50MTI4LmggfCAxMCArKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11
L2ludDEyOC5oIGIvaW5jbHVkZS9xZW11L2ludDEyOC5oDQo+IGluZGV4IDc2ZWE0MDUuLjUyZmMy
MzggMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvcWVtdS9pbnQxMjguaA0KPiArKysgYi9pbmNsdWRl
L3FlbXUvaW50MTI4LmgNCj4gQEAgLTU4LDYgKzU4LDExIEBAIHN0YXRpYyBpbmxpbmUgSW50MTI4
IGludDEyOF9hbmQoSW50MTI4IGEsIEludDEyOCBiKQ0KPiAgICAgIHJldHVybiBhICYgYjsNCj4g
IH0NCj4NCj4gK3N0YXRpYyBpbmxpbmUgSW50MTI4IGludDEyOF9vcihJbnQxMjggYSwgSW50MTI4
IGIpDQo+ICt7DQo+ICsgICAgcmV0dXJuIGEgfCBiOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW5s
aW5lIEludDEyOCBpbnQxMjhfcnNoaWZ0KEludDEyOCBhLCBpbnQgbikNCj4gIHsNCj4gICAgICBy
ZXR1cm4gYSA+PiBuOw0KPiBAQCAtMjA4LDYgKzIxMywxMSBAQCBzdGF0aWMgaW5saW5lIEludDEy
OCBpbnQxMjhfYW5kKEludDEyOCBhLCBJbnQxMjggYikNCj4gICAgICByZXR1cm4gKEludDEyOCkg
eyBhLmxvICYgYi5sbywgYS5oaSAmIGIuaGkgfTsNCj4gIH0NCj4NCj4gK3N0YXRpYyBpbmxpbmUg
SW50MTI4IGludDEyOF9vcihJbnQxMjggYSwgSW50MTI4IGIpDQo+ICt7DQo+ICsgICAgcmV0dXJu
IChJbnQxMjgpIHsgYS5sbyB8IGIubG8sIGEuaGkgfCBiLmhpIH07DQo+ICt9DQo+ICsNCj4gIHN0
YXRpYyBpbmxpbmUgSW50MTI4IGludDEyOF9yc2hpZnQoSW50MTI4IGEsIGludCBuKQ0KPiAgew0K
PiAgICAgIGludDY0X3QgaDsNCj4gLS0NCj4gMi43LjQNCg0K

