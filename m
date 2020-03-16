Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A1AC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A92C20753
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="rtMIWa2U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="hnZmQCLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A92C20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvPK-0006bW-L6
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1jDvOT-0005ZQ-67
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1jDvOR-0005SY-UY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:27:21 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:6343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1jDvOR-0005JH-HU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1584386839; x=1615922839;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FZS+52qt7JzjjYs/9RB5UL5dYAOzHGA5pzZ9U2npiVI=;
 b=rtMIWa2UAQkvgWBl8QD53m/w0+9txCQ2k8xhSUc0lvdxVw3MRDsCNXA1
 LWegddcbbXZcML5sUPXvc3NC6RcwsdLzWb+Ku20nUIE4a3yoMYXOtd43i
 8YlCfPyLD1kqmejcl2hLoBQSYWGGe7xRQ5l+1DZU2CHrvZH/i5cOK49Mg I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Mar 2020 12:27:18 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 16 Mar 2020 12:27:17 -0700
Received: from apsanexr02f.ap.qualcomm.com (10.85.0.29) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 16 Mar 2020 12:27:17 -0700
Received: from NASANEXM01F.na.qualcomm.com (10.85.0.32) by
 apsanexr02f.ap.qualcomm.com (10.85.0.29) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 16 Mar 2020 12:27:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 16 Mar 2020 12:27:15 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB5638.namprd02.prod.outlook.com (2603:10b6:a03:9f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Mon, 16 Mar
 2020 19:27:13 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 19:27:13 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 1/4] scripts: add a script to generate syscall_nr.h
Thread-Topic: [PATCH v3 1/4] scripts: add a script to generate syscall_nr.h
Thread-Index: AQHV+3DS+Ab8fmhERUaut8JIIMz4GKhLY3UwgAAKXYCAACx3gA==
Date: Mon, 16 Mar 2020 19:27:13 +0000
Message-ID: <BYAPR02MB4886C26869025190AED87EDDDEF90@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200316085620.309769-1-laurent@vivier.eu>
 <20200316085620.309769-2-laurent@vivier.eu>
 <BYAPR02MB4886D8ECC90C0845C3BFE27FDEF90@BYAPR02MB4886.namprd02.prod.outlook.com>
 <ec9e86fe-76c2-bab0-6b08-c524e3582dba@vivier.eu>
In-Reply-To: <ec9e86fe-76c2-bab0-6b08-c524e3582dba@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 347457b2-6d78-4c7b-e8a7-08d7c9e0078a
x-ms-traffictypediagnostic: BYAPR02MB5638:
x-microsoft-antispam-prvs: <BYAPR02MB563856603823377215C7A649DEF90@BYAPR02MB5638.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(55016002)(52536014)(9686003)(71200400001)(8936002)(76116006)(8676002)(66946007)(66476007)(81156014)(66446008)(81166006)(66556008)(64756008)(186003)(7696005)(26005)(4326008)(2906002)(5660300002)(33656002)(54906003)(110136005)(478600001)(86362001)(316002)(66574012)(53546011)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5638;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUwjkQ3irElhefgi62tsZVS3iFrRuGTItGD4JwU2yVCGZxq1t7aihSlQUez0JTw/UXSS7NU4gD3L2dNr7U/pDAWEKEZHhyRLVspzhIEdeYGbNX6RoIJaOFzWDuK697S/kUYFW20W9lVCGCLoKKTgJRs38grP2TmFgTNbGJxHpc1FRllH99a3G4o7lfe13l3u8wVRuDg0pCnx9UTR68we7Veu5b7Be38E+rP/qh+dmDdzXugqr5hF4OV6Hq3wiSonGdsCjFenglk88AF+KCiT5d6JmCyuzoB2WuOCCX5Rqpo6V1Sjza5iYsSlRF7qsKEII/5C6WOFftEmhUV3d8P3vYzQcyAr2pk/JqmpQqvXvMPm8hHPWDK6p6Pxt3zVtDaIi4bxjt3LnjLJ3yul6WENx7uC7tpya7AfzqXx1PirISScwWG6SKw6GqosjCvwy6Vj
x-ms-exchange-antispam-messagedata: 7B6bA3IllmSH30H1Rk+KrDu6GIKqw9PjuqaPFGKFozTzrJNGzY75wgZVuV3pYNm8d9RVr830Z9aipNJT+Nmg9JyL1N+8gykQjjjdNQ6kLhALfHUk5JOTj5zAd55EzLjyRZtpg02KPTPhwbQRMqOqJw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7zgztV8lqc+DQDlM74SwNqIYoPaJK6U+gHGzdpGnGeyv2EZLiva6cbN7lk6Dw3szxrQ6dET4uS5jwQgCjEY96p+yRW8aSaEJ0xkoVcksX7YbR77qbCIE2orqcR8459vbOYWWm9whxdtT66xkdGymkbauyQYwTvfJMU4MAN61Yjba3aER1A0Qu/LBtYqksl539SJGVR8NCzBCIQcSxJe3f0g8UvPl/JRhAwlmRLc0lJ266E+yy6e5hsR2IBDt6eqtrV6Z4F/rw9H2DI/o1JBG86Ugfr2vhWtIhUFbU8mQjbh4TccZTPx46QL3DMLwvgha1k2525FDghIbqOJ2q6pDA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYxHE+HiJUVxzrxaTSRe2AGlbjUxCsqD66Ye/CIA/Y=;
 b=PaXremes830/aDQPxCtlULiQSWOEaVyAPpY7u+g21s4dITNZb4jZGi2dZ1Jg/fAnJOekgnnM/uoCkiohs7BYAlH/V+0lJbLlvXrjdMEP6r74fjzLpYujvMeCrbQbuOuu5Pu1l1Dkbl237eJY4C74SXodcamPmEhU+JITdXHXr6c+lwpcAl1EH7XGbhozSBTJWvAnLuP0ourHcsXz+Z1COpy8lRcKUa4UU/lJq8fG0fS9HjBOlIS8CGoI1Z+4Um+ZfF/27YRNx532bzyezjykmBRTTOPiR4XawtE5AOlsEfu+Vrdtys8gjGDtzPK0hlVyfRg0H6wHkoh370Er0AQyDw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYxHE+HiJUVxzrxaTSRe2AGlbjUxCsqD66Ye/CIA/Y=;
 b=hnZmQCLPuWyJJroAJ+YQE3XSAYFZCiArSWeJvsaEcYtfyLJWBFIuRv4F7jYwbma0GHeMRC1q5XfB6GHDY7Q3j/sSynHId1rel4zTvMTac8hO1NIKSWP5R0G0j4rs4iTk7kZQqjABlxL4U+DBm+WuJF/1AGgi0QLz7TiDhh+gWr8=
x-ms-exchange-crosstenant-network-message-id: 347457b2-6d78-4c7b-e8a7-08d7c9e0078a
x-ms-exchange-crosstenant-originalarrivaltime: 16 Mar 2020 19:27:13.1026 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: M/QvbDHsNXHpsN4yJIyywDp7Kmls2opgQqs16xzoQqy7ZuTdN5llyTk7j9vXEplPKCQEKmivAxiR/SkMnOZhCg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5638
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gTGUgMTYvMDMvMjAyMCDDoCAxNzoyMSwgVGF5bG9yIFNpbXBzb24gYSDDqWNyaXQgOg0K
PiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTGF1
cmVudCBWaXZpZXIgPGxhdXJlbnRAdml2aWVyLmV1Pg0KPiA+PiBTZW50OiBNb25kYXksIE1hcmNo
IDE2LCAyMDIwIDM6NTYgQU0NCj4gPj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+PiBD
YzogTGF1cmVudCBWaXZpZXIgPGxhdXJlbnRAdml2aWVyLmV1PjsgUmljaGFyZCBIZW5kZXJzb24N
Cj4gPj4gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBSaWt1IFZvaXBpbyA8cmlrdS52
b2lwaW9AaWtpLmZpPjsgVGF5bG9yDQo+ID4+IFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29t
PjsgQWxpc3RhaXIgRnJhbmNpcw0KPiA+PiA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPiA+
PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMS80XSBzY3JpcHRzOiBhZGQgYSBzY3JpcHQgdG8gZ2VuZXJh
dGUgc3lzY2FsbF9uci5oDQo+ID4+DQo+ID4+IFRoaXMgc2NyaXB0IGlzIG5lZWRlZCBmb3IgdGFy
Z2V0cyBiYXNlZCBvbiBhc20tZ2VuZXJpYyBzeXNjYWxsIG51bWJlcnMNCj4gPj4gZ2VuZXJhdGlv
bg0KPiA+Pg0KPiA+PiArDQo+ID4+ICtmaWx0ZXJfZGVmaW5lcygpDQo+ID4+ICt7DQo+ID4+ICsg
ICAgZ3JlcCAtZSAiI2RlZmluZSBfX05SXyIgLWUgIiNkZWZpbmUgX19OUjMyNjQiDQo+ID4NCj4g
PiBGb3IgSGV4YWdvbiwgd2UncmUgc3RpbGwgcnVubmluZyBhIDQuOSBrZXJuZWwuICBXaGVuIEkg
dHJpZWQgb3V0IHRoaXMgc2NyaXB0IG9uDQo+IHRoYXQgY29kZSBiYXNlLCB0aGVyZSBhcmUgYSBo
YW5kZnVsIG9mIHRoZXNlDQo+ID4gICAgICN1bmRlZiBfX05SX3N5c2NhbGxzDQo+ID4gICAgICNk
ZWZpbmUgX19OUl9zeXNjYWxscyAyOTENCj4gPiBUaGlzIHdvcmtzIGZpbmUgd2l0aCBub3JtYWwg
QyBwcmVwcm9jZXNzaW5nLCBhbmQgdGhlIGxhc3Qgb25lIHdpbnMuDQo+IEhvd2V2ZXIsIHdoZW4g
dGhlICN1bmRlZidzIGFyZSBmaWx0ZXJlZCBvdXQsIGl0IGxlYXNlIHRvIGJ1aWxkIGVycm9ycyBm
cm9tDQo+IG11bHRpcGxlICNkZWZpbmUncyBvZiBUQVJHRVRfTlJfc3lzY2FsbHMuICBBRkFJSywg
cWVtdSBkb2Vzbid0IHVzZSB0aGlzLCBzbw0KPiBpdCBzaG91bGQgYmUgT0sgdG8gZmlsdGVyIG91
dC4gIFNvLCBJIGNoYW5nZWQgdGhlIGFib3ZlIGxpbmUgdG8NCj4gPiAgICAgZ3JlcCAtZSAiI2Rl
ZmluZSBfX05SXyIgLWUgIiNkZWZpbmUgX19OUjMyNjQiIHwgZ3JlcCAtdg0KPiAiX19OUl9zeXNj
YWxscyINCj4gPg0KPiA+IElmIHlvdSdyZSBPSyBpbmNvcnBvcmF0aW5nIHRoYXQgbm93LCBncmVh
dCEgIE90aGVyd2lzZSwgSSdsbCBhZGQgaXQgdG8gdGhlDQo+IEhleGFnb24gUkZDIHBhdGNoIHNl
cmllcyB1bnRpbCB3ZSBnZXQgdG8gYSBuZXdlciBrZXJuZWwuDQo+DQo+IFNvcnJ5LCBJJ3ZlIGp1
c3Qgc2VudCB0aGUgcHVsbC1yZXF1ZXN0Lg0KPg0KPiBBZGQgaXQgdG8geW91ciBSRkMsIHBsZWFz
ZS4NCg0KU3VyZS4NCg0KPg0KPiBJdCdzIHdoeSB0aGlzIHNjcmlwdCBpcyBvbmx5IGFuIGhlbHBl
ciwgc28gaXQgbWVhbnMgb25jZSB0aGUgZmlsZSBpcw0KPiBnZW5lcmF0ZWQgaXQgY2FuIGJlIGVk
aXRlZCBiZWZvcmUgYmVpbmcgY29tbWl0dGVkLg0KDQpPaCwgSSB0aG91Z2h0IHRoZSBnb2FsIHdh
cyB0byBoYXZlIHRoZW0gYWxsIGdlbmVyYXRlZC4gIFRoYXQncyB3aHkgSSBzdWdnZXN0ZWQgZ2Vu
ZXJhdGluZyB0aGUgIkRvIG5vdCBtb2RpZnkiIGNvbW1lbnQuDQoNCj4NCj4gVGhhbmtzLA0KPiBM
YXVyZW50DQo=

