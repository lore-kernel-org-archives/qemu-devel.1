Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D92C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4999120739
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f9FljYLE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="niq8b72R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4999120739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHxr-0004Uu-5U
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNHws-00043f-Jp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:53:50 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:41697)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNHwq-0005gs-4s
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601394828; x=1632930828;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Phd93rkBoEHIcuk0dgr2A/mlEADaCPUrefuyA2Y/ZZo=;
 b=f9FljYLE/XSN6V4vxAlwY/HQ4TcHvQNU8HGEbl1VoN6hsVM3a8m8RN5m
 JQFudTREHjxaZZEITT18bRqJgAOTeYoyGz5x5G/wQriqqgiZ/83tZ1OM7
 BeJmG8eSuQdztxPTJF5+H5C/mfG5f3mOHMc8fu13gX+MNbACUf2m6j9Zv E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Sep 2020 08:53:46 -0700
X-QCInternal: smtphost
Received: from nasanexm03f.na.qualcomm.com ([10.85.0.47])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 29 Sep 2020 08:53:46 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 29 Sep 2020 08:53:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 29 Sep 2020 08:53:45 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6963.namprd02.prod.outlook.com (2603:10b6:a03:236::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 15:53:43 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 15:53:42 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v4 00/29] Hexagon patch series
Thread-Topic: [RFC PATCH v4 00/29] Hexagon patch series
Thread-Index: AQHWlbze9UuGeVhliU69LxBcqNXciKl/iuoAgAA551A=
Date: Tue, 29 Sep 2020 15:53:42 +0000
Message-ID: <BYAPR02MB4886C5014B1012371DE0DCDFDE320@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <c4307aa4-f194-a02f-a4db-90b546a6024a@amsat.org>
In-Reply-To: <c4307aa4-f194-a02f-a4db-90b546a6024a@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44a24347-5a67-4cd1-55b6-08d8648fd763
x-ms-traffictypediagnostic: BY5PR02MB6963:
x-microsoft-antispam-prvs: <BY5PR02MB6963CACD99EE3B1B706FE401DE320@BY5PR02MB6963.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fExW/b4ng22DUEd2Zv1XS2PfsikPzkl32SqhrlsLW6+UV4nqALg8p3Odl7Y7nCi0PveX43thKTtgofO43jne/GSNLzQxDeDrW59mYs05z8Fo/rpTFz9EBPh03BmQ9VVuWYJv9QDs05PeX82Fu9P/HD4F9OSkz1BpFGZsgLrgTXPg0JULDU4owLK33Azg0syYGdYPIhHp8TdMeYv0qEhDs4V14ccvHttNJrKT737TZlakO2zueVi5qqZtaOIgyGsVbHrd6ClKfRE1IGEYFe5QfwRiSzNXxPXtNW6oYhs7sWY0pRz5n8SDpbsCxQg1nmPr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(366004)(376002)(39860400002)(136003)(8676002)(86362001)(110136005)(54906003)(316002)(478600001)(76116006)(66946007)(33656002)(4744005)(71200400001)(66446008)(64756008)(66556008)(66476007)(6506007)(7696005)(5660300002)(26005)(186003)(53546011)(52536014)(2906002)(4326008)(9686003)(8936002)(55016002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KDsWdZ/5wgg2JO6RmkUE+mrc/pEGaemT4FjgHa7Fp3r8fPxdZQXD4B9RFjzv9ARrNBceCH7Sm0gLivIMcp3zgyN6Y28kUga9r4eM6tj1u3V7rWTjhrLhkmkinb0X0fa8PG6Jh2y01p4l7UB1rHb1Vk33Korps3zVndxZq0oaGF2kvwuc5qcCOcnRBlfFKB45IB3sv2DyJ3HCnkebAS8KN5CZD2pOD9y4fLTVcVxTsdpZ11JgGbMXivenTCLw7RirngrjWjMb68YKlaCZxD+QdgO/w5Lx5Z5Sa7LRT9CoXVc/XYA/ggcNGfypRep4DdZqGb/baB8p8jFsn9elprRcLONWq4eTyHUimu6LvPzRC/Y5ARFXGgcnl8rvgB6moRYyk2SojZLndwOpip/MAkECq1DnIg7q5PilBEATCyUdjY+cMOi8zkMZMErkbbNVt+VdZv1ugKZGq7l4jaJWbThYGotx+uuBqrdVD01swD6FSaYs39vFkK9yDpV7JYtM0R5FeM7DGtq3Qm6LoY4HTKmwaTRf0n4EyycejLe/FoqsW3tPaMd82KPMRA6d82t+Di35CtPnyeHQYKietwvzLXNhgpqkn0aBJs55nTTA9oN4QeWPynG7LDXzylaQhUhH6okWULk7j5+CtaTtHh6eScpIdw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8LljO7f4BmEI+bTNkU4aT6eBrNDJoHRfeTe6IwudZjjMPwEuoRTqaelLaSRxJxMbwIgZFISlk19V9hPDLutvDh2M21E8Q4LuWVzYb5213Su4PT7NDXPEZSdceqT5PtK3VaqlpXkrVn/Sn7wX2+O5z5xiPqfPdvzZzGsBbMr1vma8SSlPi1ToglzTig/FQ549VrreKVOAf1l73McTT4QOt9KfMs1L4x9AqSopfg4qjTQNDa/HOYVMgADXmq13OvqfDWPsXms+Ioy1NHfM82KhgCy7TcZarCz0zrOGjUyjIBWOGOy2UVQGHl+apLuydN/bwUX9LZIJ01SRX3LaAgO3g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VafDr3se7xxT3AAkvrQm+P2zF1ZATwq/85S9UpZxzgw=;
 b=Hx+TR033v5+tm2xwhvi2gukPkhed4tsHYwOnojN5IllqoOAh5iSzF2iaYPkhbtD9uD4IjyynbuaiaBzO/lpqNv609U54279VEi2VvasUoQ1fix6MlDlyQ9eIuWWnMc/ElMb0poYE13vJ//ih+sTFeJWN6nZOx+TmGBkutcM6qDbl7TaGB+jB1go8ev4w9iieAqpEL7HzYDgQPvjtuZjmR+TSfSweSkgNlVpoJjRL0/gzNdgUYTxAeccaDVJDCb5IF6npqg+gWKMMXftHyCHAo9H0lBDp9MTWdR8DYcA9s1MxosnVSvlP6vcrKe/E2iTvA6M9q4cRdrzR6y1Z+jqMew==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VafDr3se7xxT3AAkvrQm+P2zF1ZATwq/85S9UpZxzgw=;
 b=niq8b72RoVgiK0nFq7g2lAtRpeKkCH3HESy0vxpo+cFEwa/XGFYzrYeUKFHXm8GzBSdXIRGy4w1vuHOoeQP9O+nGXAikpmaUMCXo4cm52/EyO3bDF7ENhYePZj61QUfOULg509ctKpU0/SyglS/hg+fLsuyyYuSZmPFMpk0tVYg=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 44a24347-5a67-4cd1-55b6-08d8648fd763
x-ms-exchange-crosstenant-originalarrivaltime: 29 Sep 2020 15:53:42.7938 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: ttnpcnUKHNlnh3B+IiGPPmyggd+Rx48UpIcDCI63qVCNsLDqgMu4HDpo7N7a5SxYadmxOq9zJTAtbmkhyWcDNA==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6963
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 11:53:46
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
LCAyMDIwIDY6MjIgQU0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogYWxlQHJldi5uZzsgcmlrdS52b2lwaW9A
aWtpLmZpOyByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPiBsYXVyZW50QHZpdmllci5l
dTsgYWxla3NhbmRhci5tLm1haWxAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IHY0IDAwLzI5XSBIZXhhZ29uIHBhdGNoIHNlcmllcw0KPg0KPiBjYzE6IGFsbCB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiBtYWtlOiAqKiogW01ha2VmaWxlLm5pbmphOjYzODoN
Cj4gbGlicWVtdS1oZXhhZ29uLWxpbnV4LXVzZXIuZmEucC90YXJnZXRfaGV4YWdvbl9kZWNvZGUu
Yy5vXSBFcnJvciAxDQo+DQo+ICQgZ2NjIC0tdmVyc2lvbg0KPiBnY2MgKEdDQykgMTAuMi4xIDIw
MjAwNzIzIChSZWQgSGF0IDEwLjIuMS0xKQ0KPg0KDQpUaGFua3MgZm9yIGFsbCB5b3VyIGZlZWRi
YWNrLiAgSSByZWFsbHkgYXBwcmVjaWF0ZSBpdCBhbmQgd2lsbCBtYWtlIHRoZSBjaGFuZ2VzIHlv
dSBtZW50aW9uZWQuDQoNCkknbSB1c2luZyBhbiBvbGRlciBHQ0MgdGhhdCBkb2Vzbid0IGhhdmUg
dGhlc2UgZXJyb3JzLiAgSXMgdGhpcyB0aGUgdmVyc2lvbiBvZiBHQ0MgdGhhdCBpcyByZWNvbW1l
bmRlZCAobWFuZGF0ZWQ/KSBmb3IgYnVpbGRpbmcgcWVtdT8NCg0KDQpQUyAgWW91IHdlcmUgcmln
aHQgYWJvdXQgUmljaGFyZCByZWNvbW1lbmRpbmcgY29uc3QuICBJdCdzIGFscmVhZHkgb24gbXkg
VE9ETyBsaXN0IGZyb20gaGlzIHJldmlldyDwn5iJDQoNClRoYW5rcywNClRheWxvcg0KDQo=

