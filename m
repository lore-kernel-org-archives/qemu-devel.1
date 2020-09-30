Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D794C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C42820759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XwW0dInb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="h6qQKXSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C42820759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNjIv-0003OV-AD
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 17:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNj0i-0004OI-Cl
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:36 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:5310)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kNj0f-0006ZA-I8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601498853; x=1633034853;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=42Ge5efPkaXPSnMOLe26ep3+T7RPN39vDhzafqasT2A=;
 b=XwW0dInb+y/UFzCco1RR2iROPt+pdj6xpfrufsA6s/ng8D5ZMZAjv+3+
 3FjZhR8jBB24MyFDWPoORak2T3Gsdn7ZZBNAvXUa2XUilkGAxuWBZfLv/
 DeYY2io41VZUWTfS867WQAmXpctd35A03Mo9oDDc7eGPRq/IFxcooKU/N I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Sep 2020 13:47:29 -0700
X-QCInternal: smtphost
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Sep 2020 13:47:29 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 13:47:28 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 30 Sep 2020 13:47:28 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5479.namprd02.prod.outlook.com (2603:10b6:a03:a5::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Wed, 30 Sep
 2020 20:47:00 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 20:47:00 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux user
 emulation
Thread-Topic: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux user
 emulation
Thread-Index: AQHWlb0HzVWcjEM2c02U1Hzjcbp8lKl+igOAgAMem5A=
Date: Wed, 30 Sep 2020 20:47:00 +0000
Message-ID: <BYAPR02MB488639031FDA8E05DA560CD5DE330@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-28-git-send-email-tsimpson@quicinc.com>
 <97b7864c-f4b2-ae8a-9ad0-d1d3c1fb309c@vivier.eu>
In-Reply-To: <97b7864c-f4b2-ae8a-9ad0-d1d3c1fb309c@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vivier.eu; dkim=none (message not signed)
 header.d=none;vivier.eu; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0881e991-6d04-4f01-6679-08d86581fac0
x-ms-traffictypediagnostic: BYAPR02MB5479:
x-microsoft-antispam-prvs: <BYAPR02MB5479F3C1692916FD070D84B8DE330@BYAPR02MB5479.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJvKEjHuiRUuq8iOIEQV9+2A7bwi10velM7FU9cVAwm5oM3qNqWxbaKMigTWr6Bu7QTwz0DCXg+G7P2izzfXn9XbcPp9Lyn8YsBh7C/xZ0sqsUTOHdf1f+716SgvkxFcMOLYHH8xf7V9US9Z68BxYw0UQKBamUz//xkSE7B79eQskWSb5qRP9C14GBcgLJsbnHQ9SJbu2HW9XHHgVJuM1My4ZxbW96GsXZe2bcsl9ZT8ZUPJ1YEmZk6V4KuQKlu5Y2BSSUQaUDdN/7psCQWQS7cW56RX9V+3UMYtcZAGqTd8uxQeKn4oNPUx4e7TmpLIg7Q6gStumwBxpcxHs6n32JRf1YVn4jUVxvRr2xp6Cqvt0sO4KcjtH6RyVZvSL3qO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(346002)(396003)(366004)(136003)(376002)(83380400001)(478600001)(110136005)(4326008)(33656002)(7696005)(2906002)(26005)(186003)(316002)(54906003)(8676002)(6506007)(53546011)(66476007)(66556008)(64756008)(66446008)(8936002)(55016002)(86362001)(66946007)(76116006)(52536014)(5660300002)(71200400001)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 0h+Sx44xVjnCq+CPPgM8Z6tU4yzh/oRDgYN8lp+0g0fDqqX7SVMBB29eXAcIHUJOGQu40qCM+0kn3HzGiHsygfIyGpONtvD6phQAbt19FrHbAsP+CX7Z5GEI+V14UUL+LeS8Hqf4W7dJ2+nYdzyRTOCHe4K//hcdb6J80SXDzEl+r11e6mG2w4hlOW/2hOsaF8gR0Qq8M45NO5O+sv3NsD5JNlSPoXvwnVInNOvKkeeAqRrlhQ/nN0eMNGuBhoUQp82PICZvxk2d2pKPMaPVrcP02eFPDbujTxowhLUhxjDu+IKnHJm8d6vgsFeeD5Sxabc15RXG4MGZniRlicg98xYaBwN7BqV/HDXTiYjBNt7QF+/VMsZHaJZcgvDBwhSDrAAnEUDq6iQZNwUrwoUuOofTIzh4l1HAHpqbnwhjbrcysTMJDI6EfFQMH9EEEvSsxwi5BEgd6K1h+NBXYlnCwjO3JzcdaelZt7jlnGMLoRhPhoLVBepCtm0/OtJS5npZuHsr0qFQXdZaRfci0SvHjlTbPceYF5N0h+H2wVt4Lny38CGIpVsH2P2AonhdbACE3gLuclkuuswZbD6k6/i3FPg23HbV4023hcyE8KhOQRdvdC9cvbWbNwcC8ZuPox0LSd+qIkOSeZStBf2QYreFVw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYReo1EzZvOwIuAhn+CQyryVYPlm6Yb9I+iUTDnu263yqZppsjbhthG+SnRaUr6t4jP2nIJzpaG68edXdSpUN7s+q+sIIsBnlNWK2A0VUqWB4aC2pe8f0H67OeBBtzAvmgQN7wYIs2VE2AwxxCO5F1EsfSWErF9QNVsUemEGrJyLFvWF6Ibml282oF2e8bsMeuC5KkRw9ZfpPGdzCCHfXGRW1kxK9oWHR+L9wIHIYAIZSyGTcv8qEu7gZoyW5G2xIkhc04NjG+yFfKaI3fAtUw/kzJgd02R/NsP+Q50MbsCVZXanKb7zhHjfYec5LBtO0FRhnX84AKnr0E7OwVdX3w==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gft0Vi/Qyb/YrRqyLJJuu2hM97rHNzqLUEyp473/8+4=;
 b=YCFfE9om/wpj4QXxlJhveSq/hPjRue5NOo9iNhlQKizlJG498AxgI4Ebup3PWr+ErwSmaA06nK0ZMKHj7l3AOeTL3p/gssnz4hpp447WRRiuCM0ArabvXU8GPjDSSneFO3X6iYIwYfJZSzdWkrVASGc9UqSJ5QzxgJRCQLHms90G+N+2B2tzDXpzw5LaRJF/mvMssdZKz/EH/vzqHm4LtWDSfpk085cXSRqc2ZEhmt/OZ2mITBseFqEsaaPCPMNwzZ/m57hqSDwsXUUdNbCCCd3AqcyGC7/tABD3jJZd6YJDbxGLW/sqaWyBF3h7V9i9UBkG6y4AEqhQw+qKZw719w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gft0Vi/Qyb/YrRqyLJJuu2hM97rHNzqLUEyp473/8+4=;
 b=h6qQKXSH/wmwB6aWurWNCDC/aenIP5kP2AG3LEyA/JQDqGnmCXgdBJGoUwFvqmh1ELWPqCc+ZtG6ZtFL3IBWOhCzH0EQ4B4QRj3yxg3ZZQTPewUU5G7LRxb/7QSIaujn52iYklPId1A5W6gfbMWA/XlV5b9mszo9soAsPkJ6Qqo=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 0881e991-6d04-4f01-6679-08d86581fac0
x-ms-exchange-crosstenant-originalarrivaltime: 30 Sep 2020 20:47:00.3046 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: cVz8hBjnD9zzdmSR/G58WugtdRUXlQeaDhgbZRBLQFmhPsB3heM/CdNU2gyKIkDKlbRWU8/yGCeo4LWmozpFHg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5479
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 16:47:30
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
Cc: "ale@rev.ng" <ale@rev.ng>, "philmd@redhat.com" <philmd@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudCBWaXZpZXIg
PGxhdXJlbnRAdml2aWVyLmV1Pg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyOCwgMjAyMCAz
OjAzIFBNDQo+IFRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+OyBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7IHBo
aWxtZEByZWRoYXQuY29tOyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2NCAyNy8y
OV0gSGV4YWdvbiAobGludXgtdXNlci9oZXhhZ29uKSBMaW51eCB1c2VyDQo+IGVtdWxhdGlvbg0K
Pg0KPiA+ICsNCj4gPiArc3lzY2FsbF9ucl9nZW5lcmF0b3JzICs9IHsNCj4gPiArICAnaGV4YWdv
bic6IGdlbmVyYXRvcihzaCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBhcmd1bWVudHM6
IFsgJ2NhdCcsICdzeXNjYWxsX25yLmgnLCAnPicsICdAT1VUUFVUQCcgXSwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgb3V0cHV0OiAnQEJBU0VOQU1FQF9uci5oJykNCj4NCj4gV2h5IGRvIHdl
IG5lZWQgdGhhdD8NCj4gVGhlIHN5c2NhbGxfbnJfZ2VuZXJhdG9ycyBpcyB1c2VkIHRvIGdlbmVy
YXRlIHN5c2NhbGxfbnIuaCBmcm9tIHN5c2NhbGwudGJsDQoNClRoZSBvdGhlciBsaW51eC11c2Vy
IHRhcmdldHMgaGF2ZSB0aGlzIGluIHRoZWlyIG1lc29uLmJ1aWxkIGZpbGVzLiAgSSdsbCByZW1v
dmUgaWYgaXQncyBub3QgbmVlZGVkLg0KDQo+DQo+ID4gK30NCj4gPiBkaWZmIC0tZ2l0IGEvbGlu
dXgtdXNlci9tZXNvbi5idWlsZCBiL2xpbnV4LXVzZXIvbWVzb24uYnVpbGQNCj4gPiBpbmRleCAy
Yjk0ZTRiLi44YjFkZmM4IDEwMDY0NA0KPiA+IC0tLSBhL2xpbnV4LXVzZXIvbWVzb24uYnVpbGQN
Cj4gPiArKysgYi9saW51eC11c2VyL21lc29uLmJ1aWxkDQo+ID4gQEAgLTIyLDYgKzIyLDcgQEAg
c3lzY2FsbF9ucl9nZW5lcmF0b3JzID0ge30NCj4gPg0KPiA+ICBzdWJkaXIoJ2FscGhhJykNCj4g
PiAgc3ViZGlyKCdhcm0nKQ0KPiA+ICtzdWJkaXIoJ2hleGFnb24nKQ0KPg0KPiBzbyB5b3UgZG9u
J3QgbmVlZCB0aGF0IGVpdGhlcg0KDQpPSw0KDQo+ID4gLSAgICBncmVwIC1lICIjZGVmaW5lIF9f
TlJfIiAtZSAiI2RlZmluZSBfX05SMzI2NCINCj4gPiArICAgIGdyZXAgLWUgIiNkZWZpbmUgX19O
Ul8iIC1lICIjZGVmaW5lIF9fTlIzMjY0IiB8IGdyZXAgLXYNCj4gX19OUl9zeXNjYWxscw0KPg0K
PiBXaHkgZG8geW91IHJlbW92ZSBfX05SX3N5c2NhbGxzPw0KDQpPbGRlciBrZXJuZWxzIGhhdmUg
YSBidW5jaCBvZg0KI3VuZGVmIF9fTlJfc3lzY2FsbHMNCiNkZWZpbmUgX19OUl9zeXNjYWxscyAg
WA0KDQpUaGUgc2NyaXB0IHJlbW92ZXMgYWxsICN1bmRlZidzIGJ1dCBsZWF2ZXMgdGhlICNkZWZp
bmUncywgc28gd2UgZ2V0IGNvbXBpbGUgZXJyb3JzLiAgVGhhdCBzeW1ib2wgaXNuJ3QgdXNlZCBi
eSBxZW11IHNvIGl0J3Mgc2FmZSB0byByZW1vdmUuDQoNCg0K

