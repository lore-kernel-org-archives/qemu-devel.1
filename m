Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2104EC04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCEC20708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KaTKV1kn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="N5cZI2rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCEC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXS1-0004X0-Pk
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kQXPb-0003N8-FM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:00:56 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13189)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kQXPW-0002I1-5S
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1602169250; x=1633705250;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h4UkRNRrbyyvtSq+VguIWIYTYhDuL+7VR+lSsq1GoF8=;
 b=KaTKV1knh9MF/fq0WLe3Rqlee51D9BIHRr9n+1rGVLGxR5uQLX9TDMqn
 XFcOLNsEqFD9vKkpwZnkveFub+kAApdC+CWFJtsv/AJ13Cd5tp43N7ngE
 nbvg8t35ON5VppEnNpchPSEAxg1SOIucn6tBzVKsyzp2ziRO3vkrbkU3Z 0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Oct 2020 08:00:44 -0700
X-QCInternal: smtphost
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 08 Oct 2020 08:00:44 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Oct 2020 08:00:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 8 Oct 2020 08:00:43 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BY5PR02MB6324.namprd02.prod.outlook.com (2603:10b6:a03:1f6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 8 Oct
 2020 15:00:32 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3455.025; Thu, 8 Oct 2020
 15:00:32 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Topic: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
Thread-Index: AQHWdXdf6p/vkS3v9UGs80VPN3oP2KlOWTUAgD+1nUA=
Date: Thu, 8 Oct 2020 15:00:32 +0000
Message-ID: <BYAPR02MB4886F48B7E22A43984D78A13DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 38bee6ff-5ec1-4aed-420b-08d86b9ae79a
x-ms-traffictypediagnostic: BY5PR02MB6324:
x-microsoft-antispam-prvs: <BY5PR02MB63245DC55BC39A198581301DDE0B0@BY5PR02MB6324.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mN30AfGM1L4kbCnFj8J1BF9ZYI1ogJ2d9xX0tnTAlbBZJ1tZMulVHFUP/5UXCaFdn3eeeTnotspdz+G48eMd1DPeuhreivoKmvq2zXwhXSHf4F2QcrwXMPTFKYRoZkMhwl2S2u9gyeByehoy1CYjNf9Pc8dpvHTfeMJr0l9wAWWAHfGVH38xlDfduu2hb4A6L3tjOlqX0e0AMxDphGcNqecs0ZXXu2JwyeRA/idZ6K1rpbzF7iJyaSzDzvjQy3Pp8cnw+WTob42k0gbnS2hGi5Zzv4KfOyzjRRcFPsTuFlRxP0xvNerj5OosMFGgljhChGyWdKK5t/HfTTu4Pf/8w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(66446008)(316002)(6506007)(53546011)(186003)(71200400001)(478600001)(26005)(7696005)(66946007)(76116006)(86362001)(110136005)(54906003)(66476007)(33656002)(52536014)(5660300002)(8936002)(4326008)(55016002)(9686003)(83380400001)(2906002)(66556008)(64756008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: gXZNGpyVvtePeqdL+A9Y1NgaOJOkWh2GfOQc9WMYVy9r4L4K3qHHbGlun222Jcd8NHhrNPAAKgMCTCyE27nspzMOZiC+LlkB1VdOu3A5ZsIujoBOke+w3QRX5654/5S5h3AmRitJqn78QpgSxqad9ANLljgT3WWOFJtoWojJBU970NX+jEN/Sk8Kvrff/4Jhq+vYeioC5F5+ElZGflydK0RixbpW3rWZTyXxJ06fQPjEVcvIaJF5Vmqk0Midr1+D/yhy8qhARvf1fOHRWYEmkf+1uSnKanMz5KpurRLRV9mYR57he0KHMKPmfuru4wjRy6IlHLun33NgXhV496X1SNP1iJ+mXhZQZCJTbf8hFmdmozTtLQhaIOZCfXeF3NXpzhC+L/Zfgsg2bRrEMhauJ0Fum+bbyaIwXrXmuQx0Jzmg3hQZYOHmctqK1EeSQ7kvJPqS1UUXVCt8dmgJeB3YEkor+xYZn7C5fM+nU0lS6fCtVfgpdPJtmVqrz+jsuMAiRJSc7aYmyz2MEiYqskG16E7ecnGuVsOaq5z8lxIrT8SfZMSRxYlQZtNrgx9ko5f5JCDY6Ja5qSvV4som+YCxn6Mldp+63GJ6Nr+f+o4lL42CLjJH1EbeKTNaG204t6A6hS2P0WOUpNrQGT2hdsb2JQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNDDne+Qppw5qH360DbPyCwZwBqoYSijUfRX1HpLmgYigDwJFgvkNA3gRrT8GcdnqsB3MGRTUTFF43ZiORwIGJDbwxGgNTyBVT7XEbNCWkYP+LErY1HHqAmFWK+xezaLt8615l41MLeZkqbFzVig3F1DL8o7FBCzbni4dim+Y6ULdztAUaKaVirVwmQLqu0+jGXAgzvoXRXSQgVPkpP19xw+OHfOMoXrJorpsZ0iutBURS9l0OeARUF/G0ysopqL0pqyvJ7sNr9BEFyR2TVUJxDYRv8n2TbTeXhSq91KiINDL7eQoUwFD2HVnkhnvXoJkfZeBDYf++gwxEti6IU5vA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8XjQKril3PWizEpKnysy1FqgSn77EupH83k4n6hw7k=;
 b=OXsQg1rjJ7H/wSMflgihJ8FWeWvNIvBtvSxO/601S2ZCV1etUMhTigkUKFP+UwxUdl2qyldo045LF/dts2vEBnXO6DplwjiyMh2U6uKxCRnm8WzvF/x1iEbEZGx/4Bz4+hJ9O3lF/er5QGDCbYOW76Gp5i56Ze0xx0Ser7/CcIXek4xVbWTanC9sY/TTxICPBiDWD5CBqcdz7RQE11OYuFJ8Jt6PnyUshhGrrz3dHvXq1aodyZmPwuZ5g2hMCf3Pf4Odbi7bZKEpB4vFoz5P3LbmVcS/ERza2az8x4g8w7VhG51LvItHGF+gewtS9ubYHB2fcyRuu4ns1h9Hq22jGQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8XjQKril3PWizEpKnysy1FqgSn77EupH83k4n6hw7k=;
 b=N5cZI2rsG1JKQMeTAiutRxlyWZCUVnn/8Ivvz7uE5m17gjEfvpiAPl5187uqnYs6omkUamr/RKKmaqOhvonpEJ/oxrj65yOokphNqMDBINRQh+jBaTqu5V5nBsl+24R8WkyLH0Z4PAlCzkvAznQHiA5Z7RxpBT+Ps0UsHN6bO6Q=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 38bee6ff-5ec1-4aed-420b-08d86b9ae79a
x-ms-exchange-crosstenant-originalarrivaltime: 08 Oct 2020 15:00:32.6327 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: hags7EW0TOZ3wHKO5uYQ9TaeLaoURvo3lr93QNd9HU44u7RMTzAPqguIqrQAyDDn4t62moU8FB+FwDHqeSmnpw==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR02MB6324
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 11:00:45
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
dWN0aW9uIHNlbWFudGljcw0KPg0KPg0KPiBBaCwgc28gSSBzZWUgd2hhdCB5b3UncmUgdHJ5aW5n
IHRvIGRvIHdpdGggdGhlIG1lcmdlIHRoaW5nLCB3aGljaCBoYWQgdGhlDQo+IGhvc3QtZW5kaWFu
IHByb2JsZW1zLg0KPg0KPiBJIHRoaW5rIHRoZSBtZXJnZSBzdHVmZiBpcyBhIG1pc3Rha2UuICBJ
IHRoaW5rIHlvdSBjYW4gZ2V0IHRoZSBzZW1hbnRpY3MgdGhhdA0KPiB5b3Ugd2FudCB3aXRoDQo+
DQo+IHByb2JlX3JlYWQobGRfYWRkciwgbGRfbGVuKQ0KPiBxZW11X3N0KHN0X3ZhbHVlLCBzdF9h
ZGRyKQ0KPiBxZW11X2xkKGxkX3ZhbHVlLCBsZF9hZGRyKQ0KPg0KPiBJbiB0aGlzIHdheSwgYWxs
IGV4Y2VwdGlvbnMgYXJlIHJlY29nbml6ZWQgYmVmb3JlIHRoZSBzdG9yZSBpcyBjb21wbGV0ZSwg
dGhlDQo+IG5vcm1hbCBtZW1vcnkgb3BlcmF0aW9ucyBoYW5kbGUgYW55IHBvc3NpYmxlIG92ZXJs
YXAuDQoNCkZvbGxvd2luZyB1cCBvbiB0aGlzLi4uDQoNCjEpIFdlIGRvbid0IG5lZWQgdG8gZG8g
dGhlIHByb2JlX3JlYWQgYmVjYXVzZSB0aGUgbG9hZCBoYXMgYWxyZWFkeSBoYXBwZW5lZCBhdCB0
aGlzIHBvaW50Lg0KDQoyKSBJJ20gbm90IGZhbWlsaWFyIHdpdGggcWVtdV9zdC9xZW11X2xkLiAg
QXJlIHRoZXNlIHNob3J0aGFuZCBmb3IgdGNnX2dlbl9xZW11X3N0Ki90Y2dfZ2VuX3FlbXVfbGQq
PyAgV2UgY2FuJ3QgYWN0dWFsbHkgZG8gdGhlIHN0b3JlIGF0IHRoaXMgcG9pbnQgYmVjYXVzZSBp
dCB3b3VsZCBhbHRlciB0aGUgbWVtb3J5IGJlZm9yZSB3ZSBhcmUgc3VyZSB0aGUgcGFja2V0IHdp
bGwgY29tbWl0IChpLmUuLCB0aGVyZSBtaWdodCBiZSBzdGlsbCBiZSBhbiBleGNlcHRpb24gcmFp
c2VkIGJ5IGFub3RoZXIgaW5zdHJ1Y3Rpb24gaW4gdGhlIHBhY2tldCkuDQoNCjMpIEhvdyBpbXBv
cnRhbnQgaXMgaXQgdG8gc3VwcG9ydCBiaWcgZW5kaWFuIGhvc3RzPyAgV291bGQgaXQgYmUgT0sg
dG8gcHV0IHNvbWV0aGluZyBsaWtlIHRoaXMgdG8gZGVjbGFyZSBpdCBpc24ndCBzdXBwb3J0ZWQg
Zm9yIEhleGFnb24/DQojaWYgZGVmaW5lZChIT1NUX1dPUkRTX0JJR0VORElBTikNCiNlcnJvciBI
ZXhhZ29uIGd1ZXN0IG5vdCBzdXBwb3J0ZWQgb24gYmlnIGVuZGlhbiBob3N0DQojZW5kaWYNCg0K
NCkgSWYgdGhlIGFib3ZlIGlzIG5vdCBPSywgYXJlIHRoZSBtYWNyb3MgaW4gYnN3YXAuaCB0aGUg
Y29ycmVjdCBvbmVzIHRvIHVzZT8gIElzIHRoaXMgcHNldWRvLWNvZGUgY29ycmVjdD8NCnN0b3Jl
X3ZhbCA9IGxlMzJfdG9fY3B1KHN0b3JlX3ZhbCk7DQpsb2FkX3ZhbCA9IGxlMzJfdG9fY3B1KGxv
YWRfdmFsKTsNCjxtZXJnZSBieXRlcz4NCi8qIHN0b3JlX3ZhbCBpcyBkZWFkIHNvIG5vIG5lZWQg
dG8gY29udmVydCBiYWNrICovDQpsb2FkX3ZhbCA9IGNwdV90b19sZTMyKGxvYWRfdmFsKQ0KDQoN
ClRoYW5rcywNClRheWxvcg0KDQo=

