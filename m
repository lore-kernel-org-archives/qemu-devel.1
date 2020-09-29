Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F451C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84C8207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="xPO5C+kh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Bwlz+7Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84C8207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHuE-0001jC-Or
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNHrV-0007ij-CN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:48:18 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:18398)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNHrS-0004zm-5B
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601394494; x=1632930494;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=at5p6G4WuhB566AnFW93lLMxy4p2k18sUKKfkJmmh84=;
 b=xPO5C+khIfbbzsP6JWu7eOOU9v4wJuq7TlGbpA/oFrhUrEeSEffrVOJi
 dDIrJxYJndGd4890woXwLaJj6Vg5SRYf4aTDEJc0KrFjl53KeCHU7aBC/
 EDiYn6MwmEuRp/vSDBZ5pLJ78yv8/5Yz3mVM7FhzNFt/DhPI/KTdZ1DsL c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Sep 2020 08:48:10 -0700
X-QCInternal: smtphost
Received: from nasanexm03f.na.qualcomm.com ([10.85.0.47])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 29 Sep 2020 08:48:09 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Sep 2020 08:48:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 29 Sep 2020 08:48:09 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4311.namprd02.prod.outlook.com (2603:10b6:a03:10::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Tue, 29 Sep
 2020 15:48:08 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 15:48:08 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v4 15/29] Hexagon (target/hexagon) utility functions
Thread-Topic: [RFC PATCH v4 15/29] Hexagon (target/hexagon) utility functions
Thread-Index: AQHWlbzg9MmVm4v+TE6f+8J3iXWenal/exIAgABJRHA=
Date: Tue, 29 Sep 2020 15:48:07 +0000
Message-ID: <BYAPR02MB4886F5A3CB199D81A4D14639DE320@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-16-git-send-email-tsimpson@quicinc.com>
 <7f590a42-4ab2-4945-bd9e-648ad370e711@amsat.org>
In-Reply-To: <7f590a42-4ab2-4945-bd9e-648ad370e711@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e76f337a-1937-4048-26f6-08d8648f0fd7
x-ms-traffictypediagnostic: BYAPR02MB4311:
x-microsoft-antispam-prvs: <BYAPR02MB4311EA0CB2A42570A6E4E857DE320@BYAPR02MB4311.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: frQWfjgv5/ek+fQUZn/WTZFj5F0A4VdMKDqfwUqECY9CuH2PpUZyjgg3cQyoH9764nwVbgT5jEvDgJd0K9tMiWK6u9gxllQMr4DQGkTIVghU7/r5WPRS7f/c5AoXSq+OSHP6KmKWO0gm22tVNAniznMxSyXCwnXqLzq2c666RXefXi9Mo9yRICr2B6ZF7qaf+f7WqB19XEsvrm8Nhah6fmbgnuOUQBt0OdN3JU1OwGZk9HWoOUcFdvoLKlHjHPdn8WVI+0ec0SuewNalLW7vuqSDWmqt6sS4iksOwvk4ZjgvN8RwHRcG/f9JMrM+ny9LBy0eScP/kSqqW6zQqFdwKvGyxFdzE+OgQ7hu6rfetKwrEsVKt9Jjfkctq/rLrUsp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(366004)(346002)(376002)(39860400002)(4326008)(52536014)(2906002)(9686003)(66476007)(66556008)(64756008)(55016002)(76116006)(66946007)(86362001)(66446008)(478600001)(83380400001)(186003)(71200400001)(33656002)(26005)(8676002)(8936002)(110136005)(54906003)(53546011)(6506007)(7696005)(316002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zZ3FXC8Prk/mJ3mShaGykXU23txnLiGzdLSc4Y/p30A2ei9phbMJE0ZQKu2WnBnFnS3RINId7drI0OAp8YZr2LjWjzCqbCqTHnGZ2wySPRU4YNb4bRudriZnih2oJsPyx5UC/ipP/e6v4TDuo5E7Bo+5hiE0uJRVDRbmrKLJmDJ4sEqBrsi0WAO70rLHKMhE70RyFMjlH+qDBC0+wDPzsY5MOCGH24kaIs7uqZNE+zgyzN15G8gZQhZD3hJymb1i8yMPIuov/fuuMpC0APF278Z+5g1YbEsYp4HPKOewaG/NCL9SPFoRngZz59s4f1k1xvezpuzugbu5wzDqO2btGnOee4LAp9kwY2H89SX1f4rLLu0ESoLEywMj7tqUSKVfgPoyCejs0OOAZV8/ZKMbmJPSi1QXlIdXkK8kAb6T/2CLVNvZkXdeKklDn4toT6bDtgeAjvzDa1x2eWGRfOG2ePpBq2QN0PwruDqxbGBA6O7aOMIZpnX4RwA+7GxAnAgHBWszYUqYVHlLvs4EmQvQxp12HU+xvpj+vpZRsBNc85ewLvASeg0a/yXdDRgLc4tt6gSt5U+6feWv17kNi/YUuc4yonlbipM6apa+whBUzi5OWKYD5OX8hV7mUB+G7e9bBTrc7soLAoabbgAhni1mXA==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFjaqjTFY0bI9tjp6sm1rSNFMvpgClsa0SOA2TbMf22cC7w4OiP2LjhkWf2LAug6vjj9n6z86gTbR2D+A7uC+vRqXOhWQFySdMpTuIdvzYS1XVDWfin5J9qRmrTfFaOhxOjMCxtb/UDEqucZeR+Pd5Qpg4qobI5i2Vym4JzzLR6uVry34/9Yi+HZqsUUw5PaDsFlwcIozziGfPBf4JBn0tR5yyVitvTHu7+vVQDlzV1H3JRkOFk+zQgAVN8bI3nL6FdQXQnZL5UXkvMMN8kAYWPg8Ml3snm68X/+c5J9H3JUuUea3IF1xTkUPq8p7f1QYsYWlWmDAr7qFSY1crXEiw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG067AZk2SGjL1ViOSj7Fslo4BJr9ZYMXY8qLlOE/Z0=;
 b=gZFw976Pr8zCGlAEafPfvnwB7qyHCCHxJmRErdgQAlHFMxHqW94LMFMQkSeA2+mtI1v0t+cErBRjxEG+9kD9f81p8SQavhxl1xqSwwAwdPQzQ+FkyxLZaH8+DayCY3uo1HjI/8PgCAmkoiaw0aLiqBShNAtuOAH6mAv0FKoOjuGMtxzQv6XUtUa6pKtKrt4rejCvmgC9zMMTx6TVIigQOnBsu5/dAxo+VTrJxVz7r0Vk5jYHc6sqAR3qoABnZEWVQA5CbII4P00VAu07HB5B1Di4H8r2jF1k1islIU0x7wSY+Ilhy7Mj3GH/9iC09VtNF7+E6RxPvn7dxfB4l7mxMA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG067AZk2SGjL1ViOSj7Fslo4BJr9ZYMXY8qLlOE/Z0=;
 b=Bwlz+7WhQLxk10iuMCXqfmun9bUKrn03hVy5z7x0ATywbrnRIC5rQEpqqpFEx7BT1RXGXwSIqpfQsm29jQT/BGzLuvfjCA8BHYV98p9WUbWBrK04l4ArtI6LFUWnM+DVfELnF+Ej5SIKalac7BZhyWYwuMoQlHTqsdFQov1ehqI=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: e76f337a-1937-4048-26f6-08d8648f0fd7
x-ms-exchange-crosstenant-originalarrivaltime: 29 Sep 2020 15:48:08.0605 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: /Ie+h6Gtb/rE0P47KwZo4qf+mRx0xLqfRTAEA8uug3T6bpbGZ9AdGx1UnZQOEzJzPkBe3/08fqzeWY9bEpJxAw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4311
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 11:48:10
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

T0sNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbGlwcGUubWF0aGlldS5kYXVkZUBnbWFpbC5jb20+IE9uDQo+IEJlaGFs
ZiBPZiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqQ0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIg
MjksIDIwMjAgNToyNiBBTQ0KPiBUbzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMu
Y29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiByaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnOyBsYXVyZW50QHZpdmllci5ldTsgcmlrdS52b2lwaW9AaWtpLmZpOw0KPiBhbGVrc2Fu
ZGFyLm0ubWFpbEBnbWFpbC5jb207IGFsZUByZXYubmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFU
Q0ggdjQgMTUvMjldIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSB1dGlsaXR5IGZ1bmN0aW9ucw0K
Pg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBm
cm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPg0K
PiBPbiA5LzI4LzIwIDc6MjggUE0sIFRheWxvciBTaW1wc29uIHdyb3RlOg0KPiA+IFV0aWxpdHkg
ZnVuY3Rpb25zIGNhbGxlZCBieSB2YXJpb3VzIGluc3RydWN0aW9ucw0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPg0KPiA+IC0tLQ0K
PiA+ICB0YXJnZXQvaGV4YWdvbi9hcmNoLmggICAgIHwgIDQyICsrKw0KPiA+ICB0YXJnZXQvaGV4
YWdvbi9jb252X2VtdS5oIHwgIDUwICsrKw0KPiA+ICB0YXJnZXQvaGV4YWdvbi9mbWFfZW11Lmgg
IHwgIDI3ICsrDQo+ID4gIHRhcmdldC9oZXhhZ29uL2FyY2guYyAgICAgfCAzNTQgKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIHRhcmdldC9oZXhhZ29uL2NvbnZfZW11LmMgfCAzNjkgKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICB0YXJnZXQvaGV4YWdvbi9mbWFfZW11LmMgIHwgNzc3DQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgNiBm
aWxlcyBjaGFuZ2VkLCAxNjE5IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IHRhcmdldC9oZXhhZ29uL2FyY2guaA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hl
eGFnb24vY29udl9lbXUuaA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24v
Zm1hX2VtdS5oDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9hcmNoLmMN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2NvbnZfZW11LmMNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2ZtYV9lbXUuYw0KPg0KPiBTb3JyeSBi
dXQgSSBsb3N0IGZvY3VzIGluIHRoZSBtaWRkbGUgb2YgY29udl9lbXUuYywNCj4gYWZ0ZXIgcmV2
aWV3aW5nIGFyY2guYy4NCj4NCj4gU3VnZ2VzdGlvbiB0byBlYXNlIHJldmlldywgc3BsaXQgaW4g
MyBkaWdlc3RpYmxlIHBhdGNoZXM6DQo+DQo+IDE6DQo+IHRhcmdldC9oZXhhZ29uL2FyY2guaA0K
PiB0YXJnZXQvaGV4YWdvbi9hcmNoLmMNCj4NCj4gMjoNCj4gdGFyZ2V0L2hleGFnb24vY29udl9l
bXUuaA0KPiB0YXJnZXQvaGV4YWdvbi9jb252X2VtdS5jDQo+DQo+IDM6DQo+IHRhcmdldC9oZXhh
Z29uL2ZtYV9lbXUuaA0KPiB0YXJnZXQvaGV4YWdvbi9mbWFfZW11LmMNCj4NCj4gVGhhbmtzLA0K
Pg0KPiBQaGlsLg0K

