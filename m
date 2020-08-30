Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD50C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C48420738
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T//lBlhV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="kEZC2fx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C48420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCUv2-0002w3-FO
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 17:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCUu3-0002Rm-OA
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:30:19 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:17142)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCUu1-0000kl-UN
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598823017; x=1630359017;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KY1yrzWSGbryk8NNqUBxVc0Fvv2ffC4e76j0R343yiU=;
 b=T//lBlhVrlo0/M9JJLFu3E7YqA3Xy1e5OeO6CO7bxf1vsNHrZRUOyJ/y
 PpxNus3n+Vnfyep44pNBfO2/hHJx0cd54PVtuZlIdzQKm675a/j5QuQ5b
 sYgLhkl7ke+zEnIzUS3SpmuFHE+hqrHujGB83ZtQYfr64DbKhpzTxxHv8 k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Aug 2020 14:30:16 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Aug 2020 14:30:16 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Aug 2020 14:30:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 30 Aug 2020 14:30:15 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4008.namprd02.prod.outlook.com (2603:10b6:a02:f0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Sun, 30 Aug
 2020 21:30:13 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Sun, 30 Aug 2020
 21:30:13 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Topic: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
Thread-Index: AQHWdXdjR65U8vNpmEiviytk7eiWcalOZgsAgAK5LuCAABqagIAAAiTQ
Date: Sun, 30 Aug 2020 21:30:13 +0000
Message-ID: <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
 <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
In-Reply-To: <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0137ad02-fc2b-424b-393a-08d84d2be19c
x-ms-traffictypediagnostic: BYAPR02MB4008:
x-microsoft-antispam-prvs: <BYAPR02MB400888A3BF7CD473E2AAC025DE500@BYAPR02MB4008.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oVWs3byAIgTNV8yyxFXyOIxl5CRCEnvBXfvKPGhattGWZFMP+TpTd2i0J6FDYqRK+TFLex8nUDiYIg1wC2RKA52f54sSii4Ncf/38ueDQGTYYAb3W00X6qDIADEGomkG+jSE3vdEMZrmeucOMIU8Cyrf4Sj22zPiYgYO/Tk8GGlgUdYoRmp+HDQ2l7QfHsA+vLZwXXpjQ1ZtoSJ5nE9LDrmnvRjJAmcFE5l61Z0qiZNVHrMm/AizKiFg5oUawxABbGiYVhb0h6N/XgZnhF1vgnNFfkhn9iN1mSxYZ9wJEGU/mW9f+sw7fvr72rNyrdE4pm4FF7yBHovuJy+ta8QNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(39850400004)(366004)(376002)(346002)(110136005)(7696005)(5660300002)(52536014)(86362001)(186003)(66556008)(66476007)(66446008)(316002)(76116006)(64756008)(9686003)(66946007)(2906002)(54906003)(55016002)(6506007)(4326008)(33656002)(8676002)(83380400001)(26005)(8936002)(478600001)(71200400001)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /l1a6TT1SXuV1bhMCsvGZ6y9nuxCzotaQ5U2oYwbS1GlBwVnRvNUy3dZHHRkXyAnUyyd0aFbpsjwo997jekn0qlTeuG8iF2ZeFDGf2H33dbijdknM1ai9CLr6sWLvKVNsLUlh3cD7vfi0ME0IJvZzeg8RirSZd40QA1y6TIAK5EKNHK0mJaW/Zfir1tiOmVL6FbA732YVJokUT07gzJtpY0lm57pLfNBJvfYzN7mzIbu520ikiuhGGREa1HLoocMKSPUUWQqRNxMkEq4Zm2up/NCMAAeXh6LZAZVUnkiiZlRchKkb1N+KJDjVTlI0rSTgPsSoycrDRjMtCz3rCNSX5XJJ0CWJDXxDTYjvfE+pFLY+cqen9gutF6DHvdivqaiVSZ6nTWFzCcXgmx3IUTxKAG4I5/TqYOcISSDHi5LBmeE+LG9co0ECF6Bhm9ofMaqIrJyYvrimMwTeUFvwJ4KX0Jbh4LiAFCON97jI6Abpdl+KCrRKnMP6huVLZxaOFKWOzQYLHWPXji1PVNSI+C4jv9P1rRXV5xBRGqDFBR0VsGRbAVd3o1Mg7CyLth6Bwus5P8CQel9qpvnrYvpT4JDXT2sSPufaFB4HlpN3LOyCkQ4E60IcIxtXUTHEIIjTi/WTr2TQG1C+mdhxKj7SqNsIw==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COMFf+JlDWNGc5f5vqOjXMhqib70AblZm0avLDnjSeX8TwDlccNumHHCcl9m8RM7Orb2boJzlNYhKzl22sjDZ3qeB9cjOdatGvkOwr44/pvISeY3htCwv1Gn9zGLYIsKS+4nIapsI+kic2hon8IIFntN2zAxZHNPL+Oz7272M688zQG+2J7qXzCj1WjPiQx8ws9//jNbd9CI6aMOYWQ40S0rVWv4+NS770RoGBtOp4ntW/rbgRM23oNhh6VzZF+RGzFX1upMwMPYhZVcB6h/X4TxgjvpkQZ19lwlprg/ZdPDphTdK5P3uohVq0q+alpROKAg7WuUGnHjICL9tf2uBw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meEqOjbb/AFIhS5IPK38JkWMKYR7DGUnW7yR9vzEpFQ=;
 b=cL0IXqXfXb9vCt2lFYAgduCT4hr3RAeAWXO5+oq+itAED8neyJRrWfYK4O27qbDzCZBGY5XDq/BNFutVIXiXS6GcXYeMS/bLR2CsrMygYyTLttkSz0kbEnxTOQ80twLzNvDM9EoiBIXJLcMKYJe/JV73oOXh9EnsGfjFbIzaxbjFCBVfpq63G+g+66sJmteRMNKVxEyDrHfeRVF60PXMTaW2cQOPUjdifRE6/KW4tbWdXP1KyNvjaqNdpkqHSXoDGnfFTF4bBf9xRUYQo7DF0kmB5mlPo4kRdpGEPjT/MFs7E7Wg5SYpYo+5Q+J6B6CiBfR8iXBYWCw5xoefv2pTew==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meEqOjbb/AFIhS5IPK38JkWMKYR7DGUnW7yR9vzEpFQ=;
 b=kEZC2fx5QHyl0uRvg+HdR7g8B/q5d22eeetTyTjkrOcnhr1k/nqvZSq7cq4zVTT/HpG3mY8cyzzqSwfTWCapiKq/fzG/p2XjUVN0AATvY3UhoAeJHC3xFf+zGs3RhYQPxxJ/9NHT5B5uZSXoXMgkpvbDA+5DTodmHed01N2gjAQ=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 0137ad02-fc2b-424b-393a-08d84d2be19c
x-ms-exchange-crosstenant-originalarrivaltime: 30 Aug 2020 21:30:13.5510 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: z2p0jg87ttLYyhyvJ6iSQdHUGRdtQ+4Vz5GhXkzpVi6Gdx608a/+IFfb/T2mm6ZmTw4nAFJWg36OMxaIpKnlTg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4008
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 15:37:55
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
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgQXVndXN0
IDMwLCAyMDIwIDM6MTMgUE0NCj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGhpbG1kQHJlZGhhdC5jb207IGxh
dXJlbnRAdml2aWVyLmV1OyByaWt1LnZvaXBpb0Bpa2kuZmk7DQo+IGFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbTsgYWxlQHJldi5uZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAzMC8z
NF0gSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFRDRyBmb3INCj4gaW5zdHJ1Y3Rpb25zIHdpdGgg
bXVsdGlwbGUgZGVmaW5pdGlvbnMNCj4NCj4gT24gOC8zMC8yMCAxMjo0OCBQTSwgVGF5bG9yIFNp
bXBzb24gd3JvdGU6DQo+ID4gSSdsbCBhZGQgdGhlIGZvbGxvd2luZyBjb21tZW50IHRvIGluZGlj
YXRlIHdoYXQncyBnb2luZyBvbg0KPiA+DQo+ID4gLyoNCj4gPiAgICogRWFjaCBvZiB0aGUgZ2Vu
ZXJhdGVkIGhlbHBlcnMgaXMgd3JhcHBlZCB3aXRoICNpZm5kZWYNCj4gZkdFTl9UQ0dfPHRhZz4u
DQo+ID4gICAqIEZvciBleGFtcGxlDQo+ID4gICAgKiAgICAgI2lmbmRlZiBmR0VOX1RDR19BMl9h
ZGQNCj4gPiAgICAqICAgICBERUZfSEVMUEVSXzMoQTJfYWRkLCBzMzIsIGVudiwgczMyLCBzMzIp
DQo+ID4gICAgKiAgICAgI2VuZGlmDQo+ID4gICAqIFdlIGluY2x1ZGUgZ2VuX3RjZy5oIGhlcmUg
dG8gcHJvdmlkZSBkZWZpbml0aW9ucyBvZiBmR0VOX1RDRyBmb3IgYW55DQo+IGluc3RydWN0aW9u
cyB0aGF0DQo+ID4gICAqIGFyZSBvdmVycmlkZGVuLg0KPiA+ICAgKg0KPiA+ICAgKiBUaGlzIHBy
ZXZlbnRzIHVudXNlZCBoZWxwZXJzIGZyb20gdGFraW5nIHVwIHNwYWNlIGluIHRoZSBleGVjdXRh
YmxlLg0KPiA+ICAgKi8NCj4NCj4gQWgsIGh1bS4gIFdlbGwuDQo+DQo+IEhvdyBhYm91dCB3ZSBm
aWd1cmUgb3V0IGEgd2F5IHRvIGNvbW11bmljYXRlIHRvIHRoZSBnZW5lcmF0b3Igc2NyaXB0cw0K
PiB3aGljaA0KPiBmdW5jdGlvbnMgaGF2ZSBiZWVuIGltcGxlbWVudGVkICJkaXJlY3RseSIsIGFu
ZCBkb24ndCBuZWVkIHRvIGJlDQo+IGdlbmVyYXRlZCBhdCBhbGw/DQo+DQo+IEkgZG9uJ3Qgc2Vl
IHdoeSB3ZSBoYXZlIHRvIHdhaXQgdW50aWwgdGhlIGMgcHJlcHJvY2Vzc29yIHRvIHJlbW92ZSB0
aGlzDQo+IHVudXNlZA0KPiBjb2RlLCBhbmQgdGhlIGxlc3Mgd2UgaGF2ZSBvZiBpdCwgdGhlIGJl
dHRlci4NCj4NCg0KQSBmZXcgcmVhc29ucw0KLSBNYWtlcyBpdCBlYXN5IHRvIG92ZXJyaWRlIGlu
c3RydWN0aW9uIGhlbHBlcnMuICBBbGwgb25lIGhhcyB0byBkbyBpcyAjZGVmaW5lIGZHRU5fVENH
Xzx0YWc+Lg0KLSBXaGVuIGRlYnVnZ2luZyB0aGUgb3ZlcnJpZGUsIHNvbWV0aW1lcyB5b3Ugd2Fu
dCB0byBxdWlja2x5IHJldmVydCBiYWNrIHRvIHRoZSBoZWxwZXIuICBPciBpZiB5b3UndmUgd3Jp
dHRlbiBhIGJ1bmNoIG9mIG92ZXJyaWRlcyBpbiBvbmUgc2hvdCBhbmQgdGhlbiBmaW5kIHRoYXQg
YSB0ZXN0IGNhc2UgaXMgZmFpbGluZywgeW91IGNhbiBiaW5hcnkgc2VhcmNoIHdoaWNoIG9uZSB0
byB0dXJuIG9mZiBhbmQgZ2V0IHRoZSB0ZXN0IHRvIHBhc3MuICBUaGlzIGlzIHRoZSBvbmUgd2l0
aCB0aGUgYnVnIHRvIGZpeC4NCi0gUmVkdWNlcyB0aW1lIGZvciBhbiBpbmNyZW1lbnRhbCBidWls
ZC4gIFdoZW4gd2UgYWRkIG9yIGRlbGV0ZSBhbiBvdmVycmlkZSwgd2UgZG9uJ3QgaGF2ZSB0byBy
ZS1ydW4gdGhlIGdlbmVyYXRvci4NCg==

