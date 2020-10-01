Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA134C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 23:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C17320739
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 23:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SbqHr3hl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Z20u5ENG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C17320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO84I-0006NB-Kj
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 19:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kO839-0005x0-H6
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 19:31:47 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:39258)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kO836-00073s-S9
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 19:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601595104; x=1633131104;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SO7QtnTqnzURTGiglPusvdcBNF/sNHrhVcikbAUzve4=;
 b=SbqHr3hlnp03ELt2fLYdvZk7MaIe1IO+pmzuImlLtJ0dsTsSw+vKsUjW
 zmd3s2r/eaLuR0A0ywkeWywGVnVGxUB0yfeD8KLtUUhhoT6iGltNBkvbv
 YrFvPgZoQqEZBAe/z0p9RYdP82MIulXmFPIyztzehYVQ2tGHkfwCaU9Xf o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Oct 2020 16:31:40 -0700
X-QCInternal: smtphost
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 01 Oct 2020 16:31:40 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 1 Oct 2020 16:31:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 1 Oct 2020 16:31:40 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5816.namprd02.prod.outlook.com (2603:10b6:a03:126::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 23:31:38 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::76:5029:2fff:f10c%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 23:31:38 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v4 19/29] Hexagon (target/hexagon) generator phase 3 -
 C preprocessor for decode tree
Thread-Topic: [RFC PATCH v4 19/29] Hexagon (target/hexagon) generator phase 3
 - C preprocessor for decode tree
Thread-Index: AQHWlbziQsIG4vdqPkW/P9qWJyhf2ql/fk+AgAOvbQCAABmwwA==
Date: Thu, 1 Oct 2020 23:31:38 +0000
Message-ID: <BYAPR02MB4886E8F15567B1C753DC18CDDE300@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-20-git-send-email-tsimpson@quicinc.com>
 <a4da7010-474f-6df3-a74a-2966c44df931@amsat.org>
 <5502293e-face-7b06-3077-9c446ac6b0b9@linaro.org>
In-Reply-To: <5502293e-face-7b06-3077-9c446ac6b0b9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c109106-9f79-4bce-c6ca-08d866622524
x-ms-traffictypediagnostic: BYAPR02MB5816:
x-microsoft-antispam-prvs: <BYAPR02MB581674AF6EC77A5789D729DADE300@BYAPR02MB5816.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5xTgKeKY2r6NRlb57H+kjTdms5SxuyfbxgPqiHg/2SFPA65oHTqrOIBhlhnDCG7k0pg8GJTZeyj+eGpRJa0l/3OlOgvjSinP75ZtZ0Ut9dvRB5L6Yi1w9WjQIgS71hLXXkDOWntMJoO2FmuUuU+EmfHjtqqyjivPfPazJ+HkTIhFgEnqXPTQVWxv5sSWUXdC3c8OYlX60xhtqRg8W1l+eOGKgQVknucn7gztvqiIwGuSC9z1HyLrBAY5wT09JqNeqq/hfdXlJE4BZI3lvhfxNng8JsKk3OspzCuqSpMdhMvmK4ll6KwXelkE1nMeEw5NgW8HOjhKqskeo4w0KanjTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(136003)(346002)(396003)(376002)(366004)(55016002)(52536014)(4326008)(26005)(5660300002)(66446008)(71200400001)(316002)(110136005)(7696005)(54906003)(478600001)(83380400001)(86362001)(64756008)(66556008)(66946007)(33656002)(66476007)(76116006)(6506007)(53546011)(8676002)(186003)(8936002)(2906002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2FDvSRMRHWIeP3yeOc7vagFH2xJIgiwBV4cu692ujQknDHtP3OAyeUvAkP21BF1IQCJcyhis7x8DcPIbRJVAt3LgX/nVl7XXiF+OrS+52HZDpOcVD53eb474xbKX2Syn9PNWtSO0JlT2BTZOFqbBXGWX802rKnMCQs+nljzCkHkh6/O8WvL7NOJ00e49DOAMS5FGG6YKKojKOBXsYEVcMnItlir3qT7BGR1Sdp2zzTyWi/sJqoP/ABsVz0oFmu5ccrRqkGQGXORHThwZyKlkiBdI9DNsyc+Ed9uJB6QuBUkphWfMZTKXaqfEJCAmAjVmeC84MvbnvPqnXYyuGtELDooqBI0Z85MkUAhQoQmntjY0kBZjhhAVVC2OJwq4RqwocUdDGZUHlnmVz1uxmtbOYw4TiAiX6mQHsjc6BVtLNw0PDr3zPmXb/zYujgV1mwPV2UpuOez4JiQlLkpQfAfekEWQHPT3shqff43JhlE6ZW1kcJndTUDopSMzSzBBlYnDudkQc34BcCJmla9MGMJtIbDGPUWPfgiXQbS8tN+LNfz4DaRAxCaBvWqa1hlF8Sc4CYxdJx/sm8ERAmXnfj4ZIejl3/tPdY4BzZrydLOwbQldbRDVg16Va0D9DMhUaV46+VmNyzwJCLkAuQ2wxVn0GQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQg2XzjdpQlsXI2CZH4Bojvcg32xHGtnf6hQx/dAYEx3ql3aIn715Z5bkLPXVATSfHXcnczRCXyIciP5WclSYIEOBt23ztVe8DqBPWyfnChttMcH/QQ6TMgW1LFpsVrn1aouQZsLho6z2EbMicHe77nTYF9kGokqpL+vgl9QhMDLjnkDbFW8k7T2vUNUk9cK5hg/9ucEPYFDFzPseVF/8ytq1dNd+gvkrJIa8/9MYPZ+xTLTg7sQBjUh14lbTV2OU7VGxTt9dEWmPuW51i2KXBQECYXpQo/pLxSSfzhAUoJIwgE15s2qrTBT0UslVtdRq7jqVs4UvggiDAibWPRl7Q==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqlh9xSTQwfyL14ku9lkankIcmdd4uD6W/+e15ywoo0=;
 b=VjKQzJAD99+Wlo9JU9Omi47ZYa128v4mjY8Jf2ihNWBclpU9tVOzAkFeNFiuM+oqvuucstm+q+YJnb69jqhNzx2D4rsfoAiSl6/My55/BBpWbfBem5FJuURgkPudA0bpvHteRUWG82wbqw88/R85amhHewW2VyensjqjOAFzFhWvySiKLXTyiS9caPkA7DRXxXrqfbjzXqItqdCgNuB27ZS4i883ESfdmnVmB8Js+8P+USJaGwmKHITA/V0RIa0KJH+AxVkupXm1tE3/UaD2TpBy36/RH/yTfmaCYf0BPsuDpRqPsAgTl1WFkT1xDnCg0a9ovM3ipVBXAmuBEbIjig==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqlh9xSTQwfyL14ku9lkankIcmdd4uD6W/+e15ywoo0=;
 b=Z20u5ENGMlnP3TmWvZVyA2cG+6Id1I4a9a0qPEUYO3Y85nETJJ9DzVOIBW+YJzGuox2cdVmavs0QOOspVD3GA4np64sAPkCuYL283UCFVZpmfnQ0vqqKKM1VzR3/lOIi7+mp+Zmf2WbPoEUZywXQE4FYwJ6AEhyemXizjEYozDQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 2c109106-9f79-4bce-c6ca-08d866622524
x-ms-exchange-crosstenant-originalarrivaltime: 01 Oct 2020 23:31:38.6911 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: K/DpPjww9YOCtBRLKA86ZPKbkhBV6PLlTo013OSQQ/EcMQCn/SKBT5r+QUNWCM6v4GFldSGDMepk0fZUmx5yCQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5816
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 19:31:41
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
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3Rv
YmVyIDEsIDIwMjAgMTo1NCBQTQ0KPiBUbzogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPGY0YnVn
QGFtc2F0Lm9yZz47IFRheWxvciBTaW1wc29uDQo+IDx0c2ltcHNvbkBxdWljaW5jLmNvbT47IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogbGF1cmVudEB2aXZpZXIuZXU7IHJpa3Uudm9pcGlv
QGlraS5maTsgYWxla3NhbmRhci5tLm1haWxAZ21haWwuY29tOw0KPiBhbGVAcmV2Lm5nDQo+IFN1
YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY0IDE5LzI5XSBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikg
Z2VuZXJhdG9yDQo+IHBoYXNlIDMgLSBDIHByZXByb2Nlc3NvciBmb3IgZGVjb2RlIHRyZWUNCj4N
Cj4gPj4gK3ZvaWQgb3Bjb2RlX2luaXQodm9pZCkNCj4gPj4gK3sNCj4gPj4gKyNkZWZpbmUgUTZJ
TlNOKFRBRywgQkVILCBBVFRSSUJTLCBERVNDUiwgU0VNKSBcDQo+ID4+ICsgICBvcGNvZGVfc3lu
dGF4W1RBR10gPSBCRUg7DQo+ID4+ICsjZGVmaW5lIEVYVElOU04oVEFHLCBCRUgsIEFUVFJJQlMs
IERFU0NSLCBTRU0pIFwNCj4gPj4gKyAgIG9wY29kZV9zeW50YXhbVEFHXSA9IEJFSDsNCj4gPj4g
KyNpbmNsdWRlICJpbXBvcnRlZC9hbGxpZGVmcy5kZWYiDQo+ID4+ICsjdW5kZWYgUTZJTlNODQo+
ID4+ICsjdW5kZWYgRVhUSU5TTg0KPiA+PiArfQ0KPg0KPiBXaGF0IGlzIGl0IHRoYXQgYWJvdXQg
dGhpcyBjYXNlIHRoYXQgY2FuJ3QgYmUgaW5pdGlhbGl6ZWQgYXQgY29tcGlsZSB0aW1lPw0KDQpT
ZXZlcmFsIG9mIHRoZSBRNklOU04ncyBpbiB0aGUgaW1wb3J0ZWQgZGlyZWN0b3J5IGhhdmUgYSA7
IGFmdGVyIHRoZW0gLSBibGVoLiAgSGVyZSdzIGFuIGV4YW1wbGUuDQogICAgUTZJTlNOKEwyX2xv
YWR3X2xvY2tlZCwiUmQzMj1tZW13X2xvY2tlZChSczMyKSIsIEFUVFJJQlMoQV9MT0FELEFfUkVT
VFJJQ1RfU0xPVDBPTkxZKSwgIkxvYWQgd29yZCB3aXRoIGxvY2siLA0KICAgIHsgZkVBX1JFRyhS
c1YpOyBmTE9BRF9MT0NLRUQoMSw0LHUsRUEsUmRWKSB9KTsNClNvLCBpZiBJIGRvIHRoaXMsIHRo
ZXJlIGFyZSBzeW50YXggZXJyb3JzLg0KICAgIGNvbnN0IGNoYXIgKiBjb25zdCBvcGNvZGVfc3lu
dGF4W1hYX0xBU1RfT1BDT0RFXSA9IHsNCiAgICAjZGVmaW5lIFE2SU5TTihUQUcsIEJFSCwgQVRU
UklCUywgREVTQ1IsIFNFTSkgXA0KICAgICAgIFtUQUddID0gQkVILA0KICAgICNkZWZpbmUgRVhU
SU5TTihUQUcsIEJFSCwgQVRUUklCUywgREVTQ1IsIFNFTSkgXA0KICAgICAgIFtUQUddID0gQkVI
LA0KICAgICNpbmNsdWRlICJpbXBvcnRlZC9hbGxpZGVmcy5kZWYiDQogICAgI3VuZGVmIFE2SU5T
Tg0KICAgICN1bmRlZiBFWFRJTlNODQogICAgfTsNCg0KSSdsbCByZW1vdmUgdGhlIGV4dHJhIDsn
cyBmcm9tIHRoZSBpbXBvcnRlZCBmaWxlcyBhbmQgbWFrZSB0aGUgY2hhbmdlIGluIHRoaXMgZmls
ZS4NCg0KVGF5bG9yDQoNCg==

