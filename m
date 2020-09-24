Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53735C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 02:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F98B2223E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 02:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NP0r2Zfe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="lRwKQHcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F98B2223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLHSU-00067b-Ep
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 22:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kLHRT-0005hq-9Q
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 22:57:07 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:5067)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kLHRQ-0003v9-E0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 22:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1600916224; x=1632452224;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VGAPHw4iLjI93S/Ec28ZISigKMMA+AljHiHOGfLFXfA=;
 b=NP0r2ZfepplSwZMhvkzwQUOSvHwkivKipSzoXpdkHB7PufD8apPg5eG8
 yzd7HDTtmWVKPVY+Ls8F2DL/LvwGMao916Pldz5QBndzUiheakKTWz9O8
 CktNm3U0XSDvwXdMQFXl5YOmk5H+sb23jcODvxZ5TC11wOQEjRYWiir/h E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Sep 2020 19:57:02 -0700
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 23 Sep 2020 19:57:02 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Sep 2020 19:57:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 23 Sep 2020 19:57:01 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6387.namprd02.prod.outlook.com (2603:10b6:a03:1b5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 02:57:00 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3391.025; Thu, 24 Sep 2020
 02:56:59 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Topic: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Index: AQHWdXdjR65U8vNpmEiviytk7eiWcalOZgsAgAK5LuCAABqagIAAAiTQgAAjBACAASHoAIAADK2AgAAIhJCAABaEgIAAAzsAgAB3woCAAAq1sIAkG8kg
Date: Thu, 24 Sep 2020 02:56:59 +0000
Message-ID: <BYAPR02MB48865179810F9248DE1280F8DE390@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
 <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
 <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <fca34122-160d-8c13-d237-a87a917f341b@linaro.org>
 <BYAPR02MB4886D48EDC604CEEF65FDAA7DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <1cf57f2b-a2c8-6fbc-2c1c-9945a5d77dd8@linaro.org>
 <BYAPR02MB4886F055CBD52DBEE5F269AEDE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <0241f731-61de-41bc-9f58-bc43725eef74@linaro.org>
 <BYAPR02MB4886B33025BE2B65D6F5F5A8DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <f0011ef6-014c-748b-7fc1-ea0f7878c281@linaro.org>
 <BYAPR02MB488667B684F8CEC755CBFD72DE2E0@BYAPR02MB4886.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB488667B684F8CEC755CBFD72DE2E0@BYAPR02MB4886.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc5d0b2b-55d9-49f1-0ea7-08d8603581b2
x-ms-traffictypediagnostic: BY5PR02MB6387:
x-microsoft-antispam-prvs: <BY5PR02MB63878D23C9CFAE72A245DA94DE390@BY5PR02MB6387.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQu+2En6RmV2ovVuAdJfCW9CydZNN9SlUjjoWi9wJWJ4/sZS2W1c2+pMUiOzIwL1KOOZWlp47VNBGbsKI5zzZ4BHX/QMW7bfZCNI8Nlu6bTwiK2/HqOV3xhVpYkrnJyuBoBMWNQjlOByDywSWr/XLavkPQQWU4X7VRT9YviqD4QlWldShAmBSF3vrPY8K0k8aM6dAHnjCCHgK6ETPSoWlHy8dfGCAx/JJLXKh3ftRZLatudoovDf3UJ79colge0paF4OTE1QA+y++sWPnqRGkxVTw8Z3ElriZ4RJSxLonDS2cPKTMTAwRC6RexPyT0w7r0faTrmpqlEQ922ewg+faPI1z+iewgRKiBzx3X5zxtz94clo38BXuqLW0+PZZWRR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(9686003)(55016002)(26005)(186003)(66946007)(5660300002)(2906002)(316002)(52536014)(83380400001)(66476007)(86362001)(71200400001)(66446008)(66556008)(64756008)(76116006)(7696005)(33656002)(110136005)(8676002)(54906003)(478600001)(6506007)(8936002)(53546011)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uFBlsoCg4A88zW50gDvbW8+kalAccchjPh9RALkT+8sCEtRRIupJZdixKD3bEe8qWpU3ewBHru3B0SNSrgQ2+Tokk6VU6e4SKgYjPF5GjGJDZAbAYwP+yTlgGqgjILzaGHFgqGhofQMT+QgbPDDLxdHLUZYifCi9VTw2Ev3E+W5jmF6OTHaBFiM7YFQs7iCO9HQ9w1hx5VFiGpXqIO9Yb/UwV+1WI8w1rupqs+Fzxg5hQF9XzBjOUxwNBF0nUoclsiTWPEcaiWruwjD1TK2wPuZw/8VqnDCKlm3+r85ljXiUEIIMkAjO8ralApU5Tbdv4atIkGvQdGIl4upBkkCpYCsC8NQ57j0Iwjapbgj1hEYsvN1ZaK9DsqwwEvsaeBPmA8wbj9Sj1Z6hmB3QHSrne4IqCAQIg5AikipQspGJaDrnUZ3K2NX63Q8kwmPwtp7y/Dtx29jHxcDBV1AoPyk0p8rWIWCMtlkIO9wvjuR/2/unnUyhDQN2qnuxAXq8Qqy340/su5Vf/oyu4IZjnL16RB7+i/TATm0U76uvT37aUm1YYxyO1bpZmtnxlUnF00WlkPUOeUSckmVVXvI56zwoV/uaiWewX091Gt8fRUEOfPqdM2HgPsEC/FxfUpJGKLf0NjgsBDXwlQeySLauMqYUOg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IabFnVR9jf48m5au3B9OrmiFSbNIyD2hnmfsduEN9HMq0uuBGeZhj9FJchcixUrpXsdcMQf+k7GhVybW+3AzLTcPf0gafBwsEpsTyjGM7BTrFhXo0hj1HgioWzNSLmcVXJlozly7lPC31o3Xv/LPGaWKj0ysDBZvk/4hxRHkXf7wnOHHH8/NRW13teF42eOg+O/XVXTh9ddowvfQwGhBtE2QzJot7Q+fX1/dp92lfTwfCS+VZ8FmlJRjfh1j0rjT/s4YiqW4nx/efqBmb6b5BeaquTSTLnsYBE3jcy0Je1NGAqyR55ChkqWzP/GeeQJaqHxQaE4sPM6+TyhFFL0rjg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUZ06sFqhKQOxzgH/N8wrb+KpAnJhp83duBIV0C2/PI=;
 b=G7ggLiUpG+mDlsersStWdHS/7Q0Y785C6+128BBQqaqhrBrmk5HAKj7/YhuoslRKMRtj+/egcS8ErgbolbaD3juc8/P8DmK03kF5dhSvEhu0dqpOmp/TJJd/6Meexn9NGpvdNjROYotV3NluOcV2TtI6wipKwTdLpbdSx2M1HjyILhTUoLuZa0pffAe4+DYC96AQXlZb5s247/qVzAJLaxiYqXq8ZkNGxOHDHJRuAsYoGAp/CtcK/iIFs3ZGdcDLCNG2zPiFazKNZa3lsfU1XEy6ctBTFIN5cPmBh7Iu2k5zFL6Me4UnADaaYjqnGpE9yc7RuLRhs41Q1vmQsim4pQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUZ06sFqhKQOxzgH/N8wrb+KpAnJhp83duBIV0C2/PI=;
 b=lRwKQHcy/C25rHIj3dsN9ys6HnUFqtD8B9RUAPKM5Mtp/sJluCwfmdL5MU8dWDNEnc2Gx6bMkIB6JBgHlUU434M2QMPcTRsc+wdqU5lteTsSs+8lQG9kVY26K4IfE64WpnyBsywEdFbL//NwRhnG2/sz9jm5MNbzrYgVe+qHlRw=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: dc5d0b2b-55d9-49f1-0ea7-08d8603581b2
x-ms-exchange-crosstenant-originalarrivaltime: 24 Sep 2020 02:56:59.6359 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: pty0uJHXr2S9ldkArJYZauUeWMx5mgcq9MqJqQW9J/nxIOyR156+X6Y9lex3+PqhsQQzaya3Y1gOptB7A7d4bQ==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6387
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 22:36:02
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

DQoNCj4gPiBPbiA4LzMxLzIwIDQ6MTAgUE0sIFRheWxvciBTaW1wc29uIHdyb3RlOg0KPiA+ID4N
Cj4gPiA+DQo+ID4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+PiBGcm9tOiBS
aWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4gPiA+PiBT
ZW50OiBNb25kYXksIEF1Z3VzdCAzMSwgMjAyMCAxOjIwIFBNDQo+ID4gPj4gVG86IFRheWxvciBT
aW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+
ID4+IENjOiBwaGlsbWRAcmVkaGF0LmNvbTsgbGF1cmVudEB2aXZpZXIuZXU7IHJpa3Uudm9pcGlv
QGlraS5maTsNCj4gPiA+PiBhbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb207IGFsZUByZXYubmcN
Cj4gPiA+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAzMC8zNF0gSGV4YWdvbiAodGFyZ2V0
L2hleGFnb24pIFRDRyBmb3INCj4gPiA+PiBpbnN0cnVjdGlvbnMgd2l0aCBtdWx0aXBsZSBkZWZp
bml0aW9ucw0KPiA+ID4+DQo+ID4gSG8gaHVtLiAgTWF5YmUgSSdtIHRyeWluZyB0byBvdmVydGhp
bmsgdGhpcyB0b28gbXVjaCBiZWZvcmUgdGFja2xpbmcgdGhlDQo+ID4gdWx0aW1hdGUgZ29hbCBv
ZiBmdWxsIHBhcnNpbmcgb2YgdGhlIFNIT1JUQ09ERS4NCj4gPiBQZXJoYXBzIHRoZSBvbmx5IHRo
aW5nIGZvciB0aGUgc2hvcnQgdGVybSBpcyB0byBoYXZlIHRoZSBnZW5lcmF0b3IgZ3JlcA0KPiA+
IGdlbnB0ci5jIGZvciAiI2RlZmluZSBmR0VOIiwgdG8gY2hvb3NlIGJldHdlZW4gdGhlIHR3byBh
bHRlcm5hdGl2ZXM6DQo+IGlubGluZQ0KPiA+IGdlbmVyYXRpb24gb3Igb3V0LW9mLWxpbmUgaGVs
cGVyIGdlbmVyYXRpb24uDQo+DQo+IFRoYXQncyBjZXJ0YWlubHkgZG9hYmxlLiAgSXQgd2lsbCBh
bHNvIGJlIGdvb2QgdG8gaW1wbGVtZW50IHNvbWUgb2YgeW91ciBvdGhlcg0KPiBpZGVhcw0KPiAt
IEhhdmUgdGhlIGdlbmVyYXRvciBleHBhbmQgdGhlIERFQ0wvUkVBRC9XUklURS9GUkVFIG1hY3Jv
cyB3aWxsIG1ha2UNCj4gdGhlIGdlbmVyYXRlZCBjb2RlIG1vcmUgcmVhZGFibGUgYW5kIHdlIGNh
biBzcGVjaWFsaXplIHRoZW0gZm9yDQo+IHByZWRpY2F0ZWQgdnMgbm9uLXByZWRpY2F0ZWQgaW5z
dHJ1Y3Rpb25zIHdoaWNoIHdpbGwgbWFrZSB0cmFuc2xhdGlvbiBmYXN0ZXIuDQo+IC0gR2VuZXJh
dGUgdGhlIGVudGlyZSBnZW5lcmF0ZV88dGFnPiBmdW5jdGlvbiBpbnN0ZWFkIG9mIGp1c3QgdGhl
IGJvZHkgd2lsbA0KPiBtYWtlIHRoZSBnZW5lcmF0ZWQgY29kZSBtb3JlIHJlYWRhYmxlLg0KDQpJ
J3ZlIG1hZGUgdGhlc2UgY2hhbmdlcyB0byB0aGUgZ2VuZXJhdG9yLiAgSSBob3BlIHlvdSBsaWtl
IHRoZSByZXN1bHRzLiAgQXMgYW4gZXhhbXBsZSwgaGVyZSBpcyB3aGF0IHdlIGdlbmVyYXRlIGZv
ciB0aGUgYWRkIGluc3RydWN0aW9uDQoNCkRFRl9UQ0dfRlVOQyhBMl9hZGQsDQpzdGF0aWMgdm9p
ZCBnZW5lcmF0ZV9BMl9hZGQoDQogICAgICAgICAgICAgICAgQ1BVSGV4YWdvblN0YXRlICplbnYs
DQogICAgICAgICAgICAgICAgRGlzYXNDb250ZXh0ICpjdHgsDQogICAgICAgICAgICAgICAgaW5z
bl90ICppbnNuLA0KICAgICAgICAgICAgICAgIHBhY2tldF90ICpwa3QpDQp7DQogICAgVENHdiBS
ZFYgPSB0Y2dfdGVtcF9sb2NhbF9uZXcoKTsNCiAgICBjb25zdCBpbnQgUmROID0gaW5zbi0+cmVn
bm9bMF07DQogICAgVENHdiBSc1YgPSBoZXhfZ3ByW2luc24tPnJlZ25vWzFdXTsNCiAgICBUQ0d2
IFJ0ViA9IGhleF9ncHJbaW5zbi0+cmVnbm9bMl1dOw0KICAgIGdlbl9oZWxwZXJfQTJfYWRkKFJk
ViwgY3B1X2VudiwgUnNWLCBSdFYpOw0KICAgIGdlbl9sb2dfcmVnX3dyaXRlKFJkTiwgUmRWKTsN
CiAgICBjdHhfbG9nX3JlZ193cml0ZShjdHgsIFJkTik7DQogICAgdGNnX3RlbXBfZnJlZShSZFYp
Ow0KfSkNCg0KQW5kIGhlcmUgaXMgaG93IHRoZSBnZW5lcmF0ZWQgZmlsZSBnZXRzIHVzZWQgaW4g
Z2VucHRyLmMNCg0KI2RlZmluZSBERUZfVENHX0ZVTkMoVEFHLCBHRU5GTikgXA0KICAgIEdFTkZO
DQojaW5jbHVkZSAidGNnX2Z1bmNzX2dlbmVyYXRlZC5oIg0KI3VuZGVmIERFRl9UQ0dfRlVOQw0K
DQovKg0KICogTm90IGFsbCBvcGNvZGVzIGhhdmUgZ2VuZXJhdGVfPHRhZz4gZnVuY3Rpb25zLCBz
byBpbml0aWFsaXplDQogKiB0aGUgdGFibGUgZnJvbSB0aGUgdGNnX2Z1bmNzX2dlbmVyYXRlZC5o
IGZpbGUuDQogKi8NCmNvbnN0IHNlbWFudGljX2luc25fdCBvcGNvZGVfZ2VucHRyW1hYX0xBU1Rf
T1BDT0RFXSA9IHsNCiNkZWZpbmUgREVGX1RDR19GVU5DKFRBRywgR0VORk4pIFwNCiAgICBbVEFH
XSA9IGdlbmVyYXRlXyMjVEFHLA0KI2luY2x1ZGUgInRjZ19mdW5jc19nZW5lcmF0ZWQuaCINCiN1
bmRlZiBERUZfVENHX0ZVTkMNCn07DQoNCkkndmUgYWxzbyBhZGRyZXNzZWQgc2V2ZXJhbCBvZiB0
aGUgaXRlbXMgZnJvbSBSaWNoYXJkJ3MgcmV2aWV3LCBzbyBJJ2xsIHJlc3VibWl0IHRoZSBzZXJp
ZXMgb25jZSBJIGZpZ3VyZSBvdXQgaG93IHRvIGdldCAibWFrZSBjaGVjay10Y2ciIHdvcmtpbmcg
dW5kZXIgbWVzb24uDQoNClRoYW5rcywNClRheWxvcg0KDQo=

