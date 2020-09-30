Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1574C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EBB2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c4LjDUYm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="O26lGTmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EBB2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNjZ4-000481-24
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 17:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNjYB-0003g7-Dx
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 17:22:11 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:44462)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNjY7-00029x-9l
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 17:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601500927; x=1633036927;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x/eqR4FYZRSPnr/3hRvvq+3AhWG2ZGW7yZZBwnqo+EI=;
 b=c4LjDUYmbIkCPx3bZBOrEMPgczp0OmdY7c5InGsG0CgGOZf62C8HTCcv
 AbIuX7RvZwj4vi3FnNYIko4Xq2l8NBDFXtoWimb0eM3iJoVnxx8xCSUc3
 vnpkeRJzn+/UonW83mNzKNBzjTSVTvUiNbmDk7rkDb9e0yyBiuCJ8WiOP g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Sep 2020 14:22:05 -0700
X-QCInternal: smtphost
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Sep 2020 14:22:05 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 14:22:04 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 30 Sep 2020 14:22:04 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4261.namprd02.prod.outlook.com (2603:10b6:a03:14::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 21:22:03 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 21:22:03 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v4 22/29] Hexagon (target/hexagon) macros
Thread-Topic: [RFC PATCH v4 22/29] Hexagon (target/hexagon) macros
Thread-Index: AQHWlbzfa5zrhBk+5UOGmIiOX7grkKl/jj6AgAIlQ6A=
Date: Wed, 30 Sep 2020 21:22:03 +0000
Message-ID: <BYAPR02MB4886E8D18707EAB35CF9EEE1DE330@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-23-git-send-email-tsimpson@quicinc.com>
 <36baca58-2129-7875-7a58-52454d8f2d0b@amsat.org>
In-Reply-To: <36baca58-2129-7875-7a58-52454d8f2d0b@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c83429d-6377-4f1d-e80f-08d86586e023
x-ms-traffictypediagnostic: BYAPR02MB4261:
x-microsoft-antispam-prvs: <BYAPR02MB426124F7B331D9CF70349369DE330@BYAPR02MB4261.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g76Z5/K7UW4JII6z6XmRaK4zDGxXwcWbrOSYPFekjz9TrxrAhFNudYQKb27+6sXN0+VGotKr7k1hb3YNpsHxnptA1LczF/S6C+sQINPLO5Bhy3J2RNu9ZewNrSa6WXG0Is+2WXtFF5VGf4L1XSubngvqLjkXhssWhWhPN/mTw8DdDAMNfDgH33EdxekEsS+8M7tl1LOeYdPdwcjXR7ieJ995p4L7giJQU0AZmrSWXNj1ecwm0ftG8o3Bjt74wA+cOkYF18cK+AZS6gNrTTOtkCQOTJwro9W+VFvpJPAf5odByTQMFySLl8LPV34CNcjn02Z2Wj+4CPSWGupJb5NtIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(4326008)(9686003)(2906002)(83380400001)(8936002)(55016002)(64756008)(478600001)(76116006)(8676002)(86362001)(54906003)(316002)(110136005)(186003)(52536014)(7696005)(26005)(53546011)(6506007)(5660300002)(33656002)(4744005)(66946007)(66476007)(66446008)(66556008)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KjkLN0XUtmqgH/iJtvB4yoM7f6uan9XDmNCM46g4uLZRX9oAeqDZqkryeHJRqReMj8dhOKk1pOVlyGEtMuUvItUqGgEU5TH2A4WTJsbtU5PAQSCIOgQbnBoyQYE5BNf05Y7/mg1XsiDnfIEgAF//5JSgC0XlvLZFSgIJljsGREYx28aDSWJ1JJSFlcwMAkEj89XWVO9r0UsPnPIEvxdFnO8/cmNMCvZo6KSQobybl/9Mt3Fbuxr1iq7Y6uZJ6rk8P/g/7KaZL9SQhd6AxRg4YXZqvlP9+DxB1tn6NAekT+qlwc5PnYnGQwAOJ5v0yVzb8R7Eg8tZMJmn2DhxvnleY8iYddB5hmQ0vYBC6w2S173ZJJJG8QyNQ0wI8zXFr0vnl6g+bI/KXcA+x2vaC1AJcxk35sh0hua4o3nICwcjAxSZLojFRaXPsmkPq5IPkTzwOCeLKgb5hbX7GJYrYDtX2WGnqSdb1FQ9xkOC3QU4kMdbjTZB8XevsyAWvKodk6+sCqntLf8ADrxila26BwicSysfQhv5O6P1aZwt71uh+OxQXTeT79Ux50hdTH26CE6zbtLZQPBIIWvyzard9wGtIX0CoFq9gNVoWWCao6uwddjv+9iLesGHyXBoZ385WKp0IDII5ju46VnaioiscRn6Gw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4xT/F+els+XgsQDcHNaqAD8p273mjC9jpARU6WiOVEPVhLU/AokLtOrmv0SLDyfCgMriJxFlLjzm9BsDzJ/HhvbMImYbfr5YXOqCCBPXCMDnsTfhM5QkgqvCNGQ5qfsGBZCkJdIWNVYLJZuKFJnTr4N02h9/++AfkiMB9xNur9jVkYI5FJqv/Ue5xDQRk2gJ/gY8qxKrUjZWVQCpkTDMXZsKdc7YniR4TlBkEV2yqnSoq0zUz7Pg7uq8K7zeRVNWFldursuADZ2w/VA5XKjquatjRJ8lBbkkyIvzK0SUPzpJ4Uvv+fmkMUSVWdbNndqZKmvpklhvJHgkMAN1w6+IA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj02AYCHGPDH8RCuKwjpNA6s7+v6sEOXaRzB7XimqUc=;
 b=lMQG3EkBHxxFMfBEUHLdBM+oVUb+cE8sWKVeFQXXhU3BwIcnDvAHr+j8/v+oidhHsZ9RsvelgxBk94gbXP3SvULWiC0GP37iUWlMy6Zfm5FtCOl+5DGa4l74DCcAgGUtQmdWELgsP5oXOPKQEkqTS8TncEC2d+KQeOpoJnNXzBMqsO2F37p6dQdzVlAmbTwfySm20M2WZfwKkkA7vW4Yu803IngLszcOOLQ944UoozcHU90UkDmAGWsuc6inUXAGTrF5oXock8ILw8XrtyrnEsMsMLsym+H4qkpoajHoHqFBLiqlFvxAeyVnpyKz1wScWBsr+YYK1LhjLNOyowYv0g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj02AYCHGPDH8RCuKwjpNA6s7+v6sEOXaRzB7XimqUc=;
 b=O26lGTmjF3ah+Q7g8lZDoFsnYqFbNvUSWoX60Hpdhy7QY3SC2N+s2LUcMS5NA13VQoAdLTbLROx5J6aDgexMmLYNiGrM4Qfe3Q77rmhGnurCC8d/5zVlkuOw7XvlIOcrF5PL5Ass47O32vam5F3zTDGBquoMtkNuuUVDEHA3UfQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 2c83429d-6377-4f1d-e80f-08d86586e023
x-ms-exchange-crosstenant-originalarrivaltime: 30 Sep 2020 21:22:03.1758 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: z7IZcfpnIQm5sXYyyEf5T0hGfP2wiRhlkBR3FWlQLXBcAo1iI6utqCKW3eTYnTz/L2BfOpbvj14gXAW8jYJbVA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4261
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 17:22:05
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
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxpcHBlLm1hdGhpZXUuZGF1ZGVAZ21haWwuY29tPiBPbg0KPiBCZWhhbGYg
T2YgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI5
LCAyMDIwIDY6MzQgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZzsgbGF1cmVudEB2aXZpZXIuZXU7IHJpa3Uudm9pcGlvQGlraS5maTsNCj4gYWxla3NhbmRh
ci5tLm1haWxAZ21haWwuY29tOyBhbGVAcmV2Lm5nDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IHY0IDIyLzI5XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgbWFjcm9zDQo+DQo+IE9uIDkvMjgv
MjAgNzoyOCBQTSwgVGF5bG9yIFNpbXBzb24gd3JvdGU6DQo+ID4gbWFjcm9zIHRvIGludGVyZmFj
ZSB3aXRoIHRoZSBnZW5lcmF0b3INCj4gPiBtYWNyb3MgcmVmZXJlbmNlZCBpbiBpbnN0cnVjdGlv
biBzZW1hbnRpY3MNCj4gPg0KPiA+ICsjaWZuZGVmIEhFWEFHT05fTUFDUk9TX0gNCj4gPiArI2Rl
ZmluZSBIRVhBR09OX01BQ1JPU19IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5o
Ig0KPg0KPiBQbGVhc2UgZG8gbm90IGluY2x1ZGUgInFlbXUvb3NkZXAuaCIgaW4gaGVhZGVyLg0K
Pg0KPiA+ICsjaW5jbHVkZSAicWVtdS9ob3N0LXV0aWxzLmgiDQo+DQo+ICJxZW11L2hvc3QtdXRp
bHMuaCIgZG9lc24ndCBzZWVtIHVzZWQuDQo+DQo+ID4gKyNpbmNsdWRlICJjcHUuaCINCj4gPiAr
I2luY2x1ZGUgImhleF9yZWdzLmgiDQo+ID4gKyNpbmNsdWRlICJyZWdfZmllbGRzLmgiDQo+ID4g
Kw0KPiBbLi4uXQ0KDQpUbyBjbGFyaWZ5LCBkb2VzIHRoZSAiWy4uLl0iIG1lYW4gSSBzaG91bGQg
cmVtb3ZlIGFsbCB0aGUgaW5jbHVkZXMgKGFuZCBpbmNsdWRlIHRoZW0gaW4gdGhlIC5jIGZpbGVz
IHRoYXQgaW5jbHVkZSB0aGlzIGhlYWRlciBmaWxlKT8NCg0KVGhhbmtzLA0KVGF5bG9yDQoNCg0K

