Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE712075A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y+5kIa0B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Y5UkFDyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE712075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je2To-000225-1b
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1je2TC-0001cW-5r
 for qemu-devel@nongnu.org; Wed, 27 May 2020 16:16:10 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:31520)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1je2T8-00070s-1H
 for qemu-devel@nongnu.org; Wed, 27 May 2020 16:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590610566; x=1622146566;
 h=from:to:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version:subject;
 bh=9yBpgiiaTVxUHBHeSayHwgam7iiWVNulLwimXFsN62E=;
 b=Y+5kIa0B/+UBFubNem0/rllz5IPMdcYFq/DLyvSLEqrBZ7wqtkPG3t9K
 BVfOL1FcKO0huRp8HC8uts9EOJZDr4DsS4GXJPMQBIZgRPBDKUkH8Bnmq
 qI8GXMRNW+hicGoAIUBTLS3wVknAbCCAis7eA6sSlgkHHzpyE2jVCWAfG o=;
Subject: RE: linux-user - time64 question
Thread-Topic: linux-user - time64 question
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 27 May 2020 13:16:02 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 May 2020 13:16:01 -0700
Received: from eusanexr01e.eu.qualcomm.com (10.85.0.100) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 May 2020 13:16:01 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 eusanexr01e.eu.qualcomm.com (10.85.0.100) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 May 2020 13:15:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 27 May 2020 13:15:59 -0700
Received: from BYAPR02MB5509.namprd02.prod.outlook.com (2603:10b6:a03:9e::31)
 by BYAPR02MB4215.namprd02.prod.outlook.com (2603:10b6:a02:f4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 20:15:58 +0000
Received: from BYAPR02MB5509.namprd02.prod.outlook.com
 ([fe80::459c:3947:2383:4703]) by BYAPR02MB5509.namprd02.prod.outlook.com
 ([fe80::459c:3947:2383:4703%6]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:15:58 +0000
From: Sid Manning <sidneym@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Index: AdYjIth2hlNzOf24Tf+fzAKlcfmaBARIESqAAAcw5aA=
Date: Wed, 27 May 2020 20:15:57 +0000
Message-ID: <BYAPR02MB5509F868888BDF31FA28406CBEB10@BYAPR02MB5509.namprd02.prod.outlook.com>
References: <BYAPR02MB55094915935E2B24286CB519BEA70@BYAPR02MB5509.namprd02.prod.outlook.com>
 <4f339841-ace9-9499-64f1-6586c9f25690@vivier.eu>
In-Reply-To: <4f339841-ace9-9499-64f1-6586c9f25690@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vivier.eu; dkim=none (message not signed)
 header.d=none;vivier.eu; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [24.28.107.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47732341-6ac3-4f41-580d-08d8027ac4ac
x-ms-traffictypediagnostic: BYAPR02MB4215:
x-microsoft-antispam-prvs: <BYAPR02MB4215574B14D05513F807AD1DBEB10@BYAPR02MB4215.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fptoTXAljKi/U/KplLg4zdnNWZVssf4t8rbZaOC6oSpsM9M0R6nsDSFGPNHe4IpbBXuxiimadG40EHht4qTyBQ42ejUI1zipdPAu/RTM1H3wilVfk7xpKSaKZNpRwD8xzseQluZzvjEDzvka0V230CX/KG/PsxWqysPbDlZdm6N55jebwyduLXHsLN84UYM2IAGY6GE3ecor2MR7m6FU71Kl6mnBBaGaJiozLkwzUDgTwIITSlh1WcZd8syM8SIWiXd8JDVM1bi9MsflTI5vBYm7cHZIHpv2/6Fu/rJAr1sz2uCEhJ3sw56l7y/sFu3rQCK548FQetpxy8bbX5e8nw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5509.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39860400002)(376002)(346002)(366004)(136003)(110136005)(33656002)(86362001)(66574014)(53546011)(6506007)(8676002)(9686003)(7696005)(26005)(55016002)(8936002)(83380400001)(71200400001)(186003)(2906002)(52536014)(66446008)(316002)(5660300002)(66556008)(76116006)(64756008)(478600001)(66476007)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: d2xgP3iUk/OJRLxpLu/iZcoVRn81nIV6yf2NoRu/IVgolyLoSMdW31uZWKA4VZz4yuLZAW45rfiNEKSs+9QpsQg/FzBVG9jO+znb2M/Qk9hChtDwacof6G/O3NTQC/DXvoMXbPwNHWCUjBHxNrFnQ8aer/393lO1MCcYei4Yqpb305Hh63OubGcCGTh3UFFeNObQBgv4qjC2CZaTgOxy32jSAiImvaQ5o45Rsz1Ktu40XHO35tGXDwirA1Yn/OeqXgoUDYjt4FNJk7873Y0+6l5RwdKMfwdwGJ9Ft7803fuz8ISptj5ObKW8G+dCQXjYEki+z72tvFpqcdDKP+l9l3rTV/c53V72UCIwYujtnDJxE12vC64BRPgx/Brv9CPczEQAx9NosKttm5zJAOLSZHPk58ZPdZZucibnYizkbbxyuF3sXzxqA6HmpwZ5aDBZ/CWnSHeDHHjK8OsuuLjMdMZV/F0VBWs5K5wr6PQ779I=
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8YsTWmKeg42vJKMG3k/wqSyA602Klm7VWtxq/koWpwYsniaUTkQDnjOBpvjB5n1Y8Kpzc/gZfAMr3GUtCt1YbikdwxAlp+Klw+D97ancSvj/ZSmPOsxY5nuiirp8ZfJw6m8pJcJ3FvnC8TCJ+P9ElWm+PdxXVsrUSH8XwVkFm+CYvIG/G/x/0zqbQLZ+Q5j9UqIakP/SWeVLDR7dJW4yxWa38v+8LKNl6RgNOPPpvZLywpGKz/EIFAf4OmMDECE6Bues8r1TxhTWtBhx6r3hTP8dB/6mTsGvh4Qvf1LL1tObknNg4150b5AjrWS1K/YooyuwYlg/fQ9uD1o2SbsWw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNESkdTQXzFiYrHuwizh7LMuZTWDLgc17rEk3nYeUf8=;
 b=EBIppgJII+PlGwWQsQ8hDcrV+QxGTtbT7mnOD2VV0XFQEASI+tvZfM1+vwlA35279SnZ+fsZqPY2JBuSXXTQC1/mWfRjH+ouoq1rwr3ARyynPbdFjyHugG6bl12GxywCvLfsqLhWuvC2sN0n7fNozVzCdQQ5WVAoJP6DbpAvdOVFC+3QWe87aUA/mstlAFtdCvLlT2qZiu4MLu4gDRZozW0tJnM5xM/z4E1fMMFGjQh71E5kvVjaHLyaCMTVxRqv3TXUVAeyuHInCq2thHyx6YL3G15RCLXKOx6Rk7RSP6tKox9i0KPYyCFBPGYTOjRAgflC1NMKXJpR0rDZ7MetlQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNESkdTQXzFiYrHuwizh7LMuZTWDLgc17rEk3nYeUf8=;
 b=Y5UkFDyWuZhBh5TqSpHM3fsrH6cCso418d7SorRcYQ6FesVoPZeDp7mxhqzYwjWZmZDZnHr6FMMG0k4EJEGjgyJ+iLMrFWLERLTmrPGU5zXf/QbomNlLeTsjCNQI29h9/ZW0uI6aA516FlNwyFLH11joYCXDeZnVP4iSebqWRhM=
x-ms-exchange-crosstenant-network-message-id: 47732341-6ac3-4f41-580d-08d8027ac4ac
x-ms-exchange-crosstenant-originalarrivaltime: 27 May 2020 20:15:58.0840 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: yNff1TcJJtmFkTc7oUiqMszRkbZR/I9aEIB2JsM3CmXXsEhX1aLo5SVgNrY89k/ehGVDvEa7eI49U79/MoaAwg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4215
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=sidneym@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 16:16:02
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXVyZW50IFZpdmllciA8bGF1
cmVudEB2aXZpZXIuZXU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI3LCAyMDIwIDExOjIzIEFN
DQo+IFRvOiBTaWQgTWFubmluZyA8c2lkbmV5bUBxdWljaW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogbGludXgtdXNlciAtIHRpbWU2NCBxdWVzdGlv
bg0KPg0KPiBMZSAwNS8wNS8yMDIwIMOgIDIzOjM4LCBTaWQgTWFubmluZyBhIMOpY3JpdCA6DQo+
ID4gSeKAmW0gbG9va2luZyBhdCBhIHRlc3RjYXNlIGZhaWx1cmUgd2hlbiBteSB0YXJnZXQgdXNl
cyA2NGJpdCB0aW1lIGluDQo+ID4gbXNnLmggKHN0cnVjdCBtc3FpZF9kcykuICBJ4oCZdmUgYmVl
biBhYmxlIHRvIGdldCBhcm91bmQgdGhpcyBidXQNCj4gPiBjaGFuZ2luZyB0YXJnZXRfbXNxaWRf
ZHMgbGlrZSBzbzoNCj4gPg0KPiA+DQo+ID4gQEAgLTM5MDAsMTggKzM5MDEsOSBAQCBzdGF0aWMg
aW5saW5lIGFiaV9sb25nIGRvX3NlbW9wKGludCBzZW1pZCwNCj4gPiBhYmlfbG9uZyBwdHIsIHVu
c2lnbmVkIG5zb3BzKQ0KPiA+ICBzdHJ1Y3QgdGFyZ2V0X21zcWlkX2RzDQo+ID4gIHsNCj4gPiAg
ICAgIHN0cnVjdCB0YXJnZXRfaXBjX3Blcm0gbXNnX3Blcm07DQo+ID4gLSAgICBhYmlfdWxvbmcg
bXNnX3N0aW1lOw0KPiA+IC0jaWYgVEFSR0VUX0FCSV9CSVRTID09IDMyDQo+ID4gLSAgICBhYmlf
dWxvbmcgX191bnVzZWQxOw0KPiA+IC0jZW5kaWYNCj4gPiAtICAgIGFiaV91bG9uZyBtc2dfcnRp
bWU7DQo+ID4gLSNpZiBUQVJHRVRfQUJJX0JJVFMgPT0gMzINCj4gPiAtICAgIGFiaV91bG9uZyBf
X3VudXNlZDI7DQo+ID4gLSNlbmRpZg0KPiA+IC0gICAgYWJpX3Vsb25nIG1zZ19jdGltZTsNCj4g
PiAtI2lmIFRBUkdFVF9BQklfQklUUyA9PSAzMg0KPiA+IC0gICAgYWJpX3Vsb25nIF9fdW51c2Vk
MzsNCj4gPiAtI2VuZGlmDQo+ID4gKyAgICBhYmlfdWxsb25nIG1zZ19zdGltZTsNCj4gPiArICAg
IGFiaV91bGxvbmcgbXNnX3J0aW1lOw0KPiA+ICsgICAgYWJpX3VsbG9uZyBtc2dfY3RpbWU7DQo+
ID4gICAgICBhYmlfdWxvbmcgX19tc2dfY2J5dGVzOw0KPiA+ICAgICAgYWJpX3Vsb25nIG1zZ19x
bnVtOw0KPiA+ICAgICAgYWJpX3Vsb25nIG1zZ19xYnl0ZXM7DQo+ID4NCj4gPiBJdCBzZWVtcyBs
aWtlIGVpdGhlciBzaG91bGQgaGF2ZSB3b3JrZWQgYnV0IEkgZ2V0IGdhcmJhZ2UgYmFjayBpbiBz
b21lDQo+ID4gb2YgdGhlIGVsZW1lbnRzIGJlbG93IG1zZ190aW1lIGZpZWxkcyB3aXRob3V0IHRo
ZSBjaGFuZ2UuDQo+ID4NCj4gPiBJZiB0aW1lX3QgaXMgNjRiaXRzIHRoZW4gaXQgc2VlbXMgbGlr
ZSBzdGltZS9ydGltZS9jdGltZSBzaG91bGQgYmUNCj4gPiBhYmlfdWxsb25nLg0KPiA+DQo+ID4g
TXkgdGFyZ2V0IGlzIEhleGFnb24gYW5kIHRoZSBUQVJHRVRfQUJJX0JJVFMgaXMgMzIuDQo+DQo+
IFRoZSBzdHJ1Y3R1cmUgaGFzIGJlZW4gY2hhbmdlZCBpbnRvIHRoZSBrZXJuZWwgZm9yIHRoZSB5
MjAzOCBhbmQgdGhlIGNoYW5nZQ0KPiBoYXMgbm90IGJlZW4gcmVmbGVjdGVkIGludG8gcWVtdSAo
YW5kIGl0IG5lZWRzKS4NCg0KVGhhbmtzIGZvciB0aGUgaW5mby4gIEl0IHdhcyBhbHNvIHBvaW50
ZWQgb3V0IHRvIG1lIHRoYXQgbXkgQy1saWJyYXJ5IHdhcyBtaXNzaW5nICBhICNkZWZpbmUsICNk
ZWZpbmUgSVBDX1NUQVQgMHgxMDINClRoaXMgY2F1c2VkIHRoZSBsaWJyYXJ5IG5vdCB0byByZWNv
Z25pemUgNjQtYml0IHRpbWUgaW4gc29tZSBpbnN0YW5jZXMuDQoNCg0KPg0KPiBTZWUga2VybmVs
IGNvbW1pdDoNCj4NCj4gYzJhYjk3NWMzMGYwICgieTIwMzg6IGlwYzogUmVwb3J0IGxvbmcgdGlt
ZXMgdG8gdXNlciBzcGFjZSIpDQo+DQo+IFRoYW5rcywNCj4gTGF1cmVudA0K

