Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0742DC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BFB20757
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MIRu2rOz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="eoN+RXTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BFB20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCTJm-0002LR-TJ
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 15:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTJA-0001vS-Li
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 15:48:08 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:9453)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCTJ7-0006y4-NQ
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 15:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598816885; x=1630352885;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j+PDewF0d9yd8W1ntjwvBPjqSabP27BH4QoBzSGAWeE=;
 b=MIRu2rOzmSuM6we2O00CiN6BrG80Iw/e7lYb8F12PB/ymRklJaL2C3os
 18d0vuynCjmHKOwCoXPUIZOq+Ah2RaZ3XSHJmZkKjwYfZYnit+O6jnVSI
 V8ZlzXehfjszReKANaqnZ/hvB6inTKUkpDBg1MT6y2i0jUiwGBfI7xJJ5 o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Aug 2020 12:48:03 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 12:48:03 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 12:48:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 12:48:02 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5925.namprd02.prod.outlook.com (2603:10b6:a03:125::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Sun, 30 Aug
 2020 19:48:01 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 19:48:01 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Topic: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Index: AQHWdXdjR65U8vNpmEiviytk7eiWcalOZgsAgAK5LuA=
Date: Sun, 30 Aug 2020 19:48:01 +0000
Message-ID: <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
In-Reply-To: <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16960d15-21e6-4b85-2b13-08d84d1d9a94
x-ms-traffictypediagnostic: BYAPR02MB5925:
x-microsoft-antispam-prvs: <BYAPR02MB5925384BEAE506CF3A655E97DE500@BYAPR02MB5925.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvsYgai1rTuVZsDNPA4/WXIi6oKRMQ1Th8SoRf0gipBLt8PUZ6hemfN4r1Zb9plJo1z7ZfYtpHO7yzPCaAODdmrV2dOQEIM8hxj/06KRImqOFSpn5/XK0lEBcTHU1OffOMM9vZYYhd4KqeS4RawQ+RsSyNU/H5zdfyim3OCe09QTTDR4UBHinhGECU6wnRAiO58eVqWYB1dLauaKuU0+5c6NuX6GBB/5mmgyt5Rf+cOHKwFzDjF/0VO6cgoB6k7bAI1FIjooGhJTxv+Q5SaHg+8yagoymcG7YNCAsE/shX0vB2ErNBBUMxnHTxmuLU4qcAykuMiFfQjOMll/wiUq3Ox1vDOKO2xT2/Jg1na4cGZOyQWMSk4DKij6KG0c3owXhXbBOgDODqYQBnXpi75v9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39850400004)(396003)(136003)(366004)(346002)(376002)(110136005)(4326008)(478600001)(54906003)(52536014)(86362001)(316002)(4744005)(5660300002)(2906002)(6506007)(7696005)(8676002)(26005)(83380400001)(66556008)(64756008)(66446008)(9686003)(71200400001)(66476007)(53546011)(55016002)(8936002)(66946007)(186003)(76116006)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zjiZLpGMcyNp7jIiObojP5fAWG6HPOmjQNjx54xVE+X2izfAWYPmMgdGVSQHW6vC5gv6v35BTk8g21eUrGSM7Clw0G7UpKn8WRuLxMwBxh2OgE7ajXut7LNV2sYMEWG40K8QxYio+KPuNo5HF1NTlgSt7vPXtn6M+FYpcXOcsWD7kQJXclQdwiX7khABLRQOWKoAY4ekEeAVJsuhDYGcjW2pboKydgdZs7FtzqvAybpVQ7vdhPpkXuK73dm0zJGb3VkQk7nK5F0wIFOig7qVsH5cXgPvgNcWOogUKIbSIXtN4nehl1krXX2fsPPuSe8joR+xj+cZmZAECakkrkOYSDj1/u7fGmTtt2hgCwE5e1WzOwHmTev7JjCErGitpa+tVDFmfy0WYrM41v4Utec5aW/0cKkHJrgNRYbzrcy/SqnL260z0j9Zocdw5K8vMVicexajuX6Dy6t9oxaTFkDmvYAt8ptNQsVMFOOiH4NVr/C1knMDueCa9L799YYtmEyBtVyL1Cvj0kY56/JVrx4jIR4DEXivP6bXLkSO7j2zucqQaKVUTprCQb0ZU1nD7nePAYWmwNiJvPBU83LCezPY+0yNgNJTTwzW+T1puSepbrbBGu1wHQy9mVEb6xt+t9RDbRcZoixaMhH6KHC7Gpwk3g==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPcswC7l8trqccN9Hto85cfTfch1cM8eZSI6fl/RUSc/XzBs9p5w/8GNU4KPDlqvv+PaYtuHMxJHZBaSwM3wLqWfvvX2l4zdU1G1CChze4Cj7q/zZvCZ79FIWVpgY1vValoAjaLtDd6JKtOkDxRbbbGMEoFX3+NVFUrb+K9UJTDh0QgLhNrnMHU1Dn08PyS0e7d5ACSFA1hU51fx0MKHEIZRLLur1+EY6I3t0B+Kc13BLKo306ag0GZEiHu/Oy8anQNsEnDRBRbeGlSoIubxxwYlHJ/QaFl54dv3heksqDuM1Z6F7CMDysr3V+SbaRdijNAFHoABcNI1S6IDjljPbA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpX7oqgt49rt/EmXXAuDB5QKeRbGNEws1gZcnyoNSKw=;
 b=joaFCSmpoLn4tF0E0JzkBj300ovHu7d95BPG8PqGXAJCcoP+gbTrJS8fTe+ut7r0ot3HwGOTYe+2Mgf3NXB6OIpf4/j1YwaiboDa7tgHFYCy3yJuk12PLlMoI9RzlH7a+ZU5JbRYALQqqBUbfPf7Yei3o3tlQqpt84lojciMAMwqVBfxtObqztnQ+KucyK3piQFIIMf+njC5lDHwn+LZcz5HgDT++rfhLNai4lisW8Hr5lL06nk9LgTI5npWBPmpQJ8IM6Z/jEVl19pkO1c1IOhCsghfloZWt2Tl/tpjnjvGfKt63qX12cW6LLWC3t1kq+EdgU/5m2GFUk74gjV7uA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpX7oqgt49rt/EmXXAuDB5QKeRbGNEws1gZcnyoNSKw=;
 b=eoN+RXTVR1aDSMo5rI8sHl7TEo2LEHDsS9e8IuxLI+nLAhB7DeriPz5/JAMoqxvgH0oDX1b2/kTizwwm44mkmeTtYx2yLHyuPANOvFzUqcUYqevvjypMxrx2WECwB222wYJAgcwDIcMQHFL+cPPeHVPlu7JD6QYNcDTFf0U8cuE=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 16960d15-21e6-4b85-2b13-08d84d1d9a94
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 19:48:01.4817 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: rOQ0lproynYO546xV+CkZqDG5A4eyWZMTcj0T+c6vd0d5HWIBxhjlfSsZG6oZ4QuA0INNGMDbvN7L9K3Z/nxXw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5925
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 15:48:04
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
IDI4LCAyMDIwIDg6MDMgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAzMC8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFRDRyBmb3INCj4gaW5zdHJ1Y3Rpb25zIHdpdGgg
bXVsdGlwbGUgZGVmaW5pdGlvbnMNCj4NCj4gT24gOC8xOC8yMCA4OjUwIEFNLCBUYXlsb3IgU2lt
cHNvbiB3cm90ZToNCj4gPiArKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaA0KPiA+IEBAIC0x
NSw2ICsxNSw4IEBADQo+ID4gICAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCBz
ZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0KPiA+ICAgKi8NCj4gPg0KPiA+ICsj
aW5jbHVkZSAiZ2VuX3RjZy5oIg0KPg0KPiBXaHkgd291bGQgeW91IG5lZWQgdGhpcyBoZXJlPyAg
RGVmaW5pdGVseSBsb29rcyB3cm9uZy4NCg0KSSdsbCBhZGQgdGhlIGZvbGxvd2luZyBjb21tZW50
IHRvIGluZGljYXRlIHdoYXQncyBnb2luZyBvbg0KDQovKg0KICAqIEVhY2ggb2YgdGhlIGdlbmVy
YXRlZCBoZWxwZXJzIGlzIHdyYXBwZWQgd2l0aCAjaWZuZGVmIGZHRU5fVENHXzx0YWc+Lg0KICAq
IEZvciBleGFtcGxlDQogICAqICAgICAjaWZuZGVmIGZHRU5fVENHX0EyX2FkZA0KICAgKiAgICAg
REVGX0hFTFBFUl8zKEEyX2FkZCwgczMyLCBlbnYsIHMzMiwgczMyKQ0KICAgKiAgICAgI2VuZGlm
DQogICogV2UgaW5jbHVkZSBnZW5fdGNnLmggaGVyZSB0byBwcm92aWRlIGRlZmluaXRpb25zIG9m
IGZHRU5fVENHIGZvciBhbnkgaW5zdHJ1Y3Rpb25zIHRoYXQNCiAgKiBhcmUgb3ZlcnJpZGRlbi4N
CiAgKg0KICAqIFRoaXMgcHJldmVudHMgdW51c2VkIGhlbHBlcnMgZnJvbSB0YWtpbmcgdXAgc3Bh
Y2UgaW4gdGhlIGV4ZWN1dGFibGUuDQogICovDQo=

