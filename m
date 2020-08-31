Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065A5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 17:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC2E206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="t9UV5ZRu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="DsXW9mKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC2E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCo46-0006zD-Sx
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 13:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCo3V-0006a2-LD
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 13:57:21 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:60224)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1kCo3S-0002Ro-Nk
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 13:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1598896638; x=1630432638;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H1jM4Hm41eu1c4ITP2SqhxkwKsnYx1Afcm9J6Gaa7GY=;
 b=t9UV5ZRuSH0kMhIYSJpehyyzCRdGv77k4RHSGR7prQXGFiVvQEeBZE5P
 qFMbD4+0YwBWGpehSTOfcgzl08V/0bh0i/cwTNrBFSbckVFew1JTWSKml
 FYyBjejI2W5MruwS6tF43GfuQcRM6+k9GCzOYwXlCFfrG8veElZqcIFxN 4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 31 Aug 2020 10:57:16 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 31 Aug 2020 10:57:16 -0700
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 10:57:16 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 10:57:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 10:57:15 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4454.namprd02.prod.outlook.com (2603:10b6:a03:5f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Mon, 31 Aug
 2020 17:57:14 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3de8:c78c:24da:fa01%7]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 17:57:14 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH v3 00/34] Hexagon patch series
Thread-Topic: [RFC PATCH v3 00/34] Hexagon patch series
Thread-Index: AQHWdXdhC+P+V2qxTkGo6bPF07deGKlOfaQAgAKxJrCAADIWgIABHOOA
Date: Mon, 31 Aug 2020 17:57:14 +0000
Message-ID: <BYAPR02MB488699D87ED9C3ADBCF155BADE510@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <fbb5a85b-6208-1791-0d3e-7e741e674a70@linaro.org>
 <BYAPR02MB48862BC00AD7217B715EBFC7DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <78e5b8be-e7f4-a1b9-2810-e0855da23f00@linaro.org>
In-Reply-To: <78e5b8be-e7f4-a1b9-2810-e0855da23f00@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [76.120.51.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef7d56a6-972d-4468-b244-08d84dd74b25
x-ms-traffictypediagnostic: BYAPR02MB4454:
x-microsoft-antispam-prvs: <BYAPR02MB44541EA52A7491F955A777ECDE510@BYAPR02MB4454.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QHIZwi74dVQbAT17MybSSzewm8iDh8Qv+xtXgEde+7HMGano2bybipphzdxE9KtrEPn76GwyzIJu4f0OztWu27+b0aGAQ/InuRUwCe6WZ75G3tLEVZOEXvVfm2ge0SnfN+kOLgCq0dDPjrWEKoKYdjx8NsmN54QQkLvqGsrpfMoP+7Qm9lSk33Xfi6GstFrsx/9RZOBz3ISfOsJ5NQOSgzbwqOBblOOe2MSskgVlvQSzoGaUXAmVaz34octUgJSPvLcMalcknSPcZXPCmLVNhTRI0TCqSYYnTwDYMAK6asyV0mwuMdSstYLJJAJ1aUAs3Jdtp8FPb74aqq0RHwWug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(33656002)(4326008)(186003)(55016002)(7696005)(76116006)(8676002)(53546011)(26005)(66476007)(66556008)(6506007)(5660300002)(86362001)(64756008)(66446008)(52536014)(66946007)(8936002)(71200400001)(9686003)(2906002)(316002)(110136005)(478600001)(54906003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: RNGcbKlcf3LMjPWPAZtnPJZekXA+TvcBQQZHUq+1zk9vsYCyppXAuBxDiVb1/gjKxRPqgdbqPi9JU7zfT5xqOs4GB3h34pOoSI85KyJbkFfgCw3wQ7AelBwzB+UWctCcjbcGzycBWHb2mjJdDlyKPxMQZ3uPse0+WR2ULIiaxP1EKvgHULeKaAf/qYCBMBEfh8RGnAx0aGLagyJAMcGkCnfltY5o+cOLiHNb7+ex5kns9gVjrT71NFR/7yy87pGDdpbm86qFDHDFXiP0x8IE+COndDMLsrGOJ4HRRbiymXIlB7NCUEP7w0kYUceB8fpR23x7oYu2FBKP0ZZGhO7MHNrWksiddBqFd1GMoKV//Nbrdv/q9ZEd4QJIvvYIh9vhB/amXrmE73i7VX879QrCoXVxxLkJvAfp/4kTI4yiZtxdVSoyTO78/u98n7qSa8wqrF1EOIxFv2XXbEmmINm89TaYnulhmHPGpwJwWDLg11DbK6b2R5GMtlIhlaFbDJSnhecql18NOEmYskAHE1hqsSreVY5HcLRNe3aYHCTbv5gSDMFS94V81Nnv08ESfUdxksZ3GZrBexWZZeZrKydYD4CF/9/W2DGGSnr+a8x2afPbZcKeHhshDBxARP9NdwAX91crDEYiT213ye3sX7QSjQ==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE+LnKtFEZvg3HIzeWCHW86RKLNPWOC7cZ/42fUNmju+RwCUA9m1aJsyn605Sb6Hf/YH3nAywN2TZdCnGtwx+cz4/2kpcLzAjKDsUzLZm9JfOSlOqtgux7qhi28fGRXF5eC0W5RcrT9sT/ioa3BDwg/YJIcuexyhwHsPNN92W09I3JXvK6gYfqA4sGmxkob/1QqT97RM/YbxmJyo2+IEBnKMXrVIFnlLIfCHdyUgxXHAqqXIu47sucHUwCZSAtsTUC14HmJPlDJ9CbnCYlBvPnNNrNErwyKC8AB2XY2EzrWvnELE0+XN5W4G2meHi45HGYr/iHRSMuI049ybWBOAog==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSCY6O9ghP4lJ3sX7AB8v4zw+e6/3+J+Z3TlpBri5Fk=;
 b=dwzGQ1zK7K3VR2YhOV1pqXmlOgC8kDfwxPHGVusKw4a2+cuZ6uVZ46SnaP0PajBB6zTg+CmupfQ85DcU4H/8KxvVMP7F11wUznfmNWOMQhH2ikyWb0c7BiDzo+TikzVm2V+VhxCa8HhQoNMTt6a8dVZMXYw8H4k+ss22ymMSKC3TY0pw+FQG/Mn0tHWXwRihcYw6MRIjeg2+oYHefNN3zOyFJb+xKsZFVvkEE1g1H12Ih0B2dX3Beku9YQVQuxqNfMhGtvNiP7XbU9zVZMwB1UuRqfB8KFryXLVy1/aUjCG+dGbFcEZtEUlFqdkdLZfpTgYjFx5kRvzrILyb/iC3Zw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSCY6O9ghP4lJ3sX7AB8v4zw+e6/3+J+Z3TlpBri5Fk=;
 b=DsXW9mKLlwF7z2p5kau6DSCDn6p4uM56CLyn/VZ4kkQG7/fa6EbPheJH0YHUh8lPb1yJv4aIBde7MWJ1b7E7E/l8aW5Y7l6OoXJv5Ld7PHcC3xuGWPVO49EanFmAtARaJkyLfervswYQ+EbcVUX7BNQUJ7nTxKuxuATZM3BfiMI=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR02MB4886.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: ef7d56a6-972d-4468-b244-08d84dd74b25
x-ms-exchange-crosstenant-originalarrivaltime: 31 Aug 2020 17:57:14.5315 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: p9//9fFk12AZvOpT8VQEz9/mqWjqn40Uer/vt1273fhuW6ctR+4YpEyrf67sOZ1gCo6GrbQGr97SYPtRgC9jSg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4454
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 13:08:37
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgSGVuZGVyc29u
IDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBTdW5kYXksIEF1Z3VzdCAz
MCwgMjAyMCA1OjMzIFBNDQo+IFRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5j
b20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBoaWxtZEByZWRoYXQuY29tOyBsYXVy
ZW50QHZpdmllci5ldTsgcmlrdS52b2lwaW9AaWtpLmZpOw0KPiBhbGVrc2FuZGFyLm0ubWFpbEBn
bWFpbC5jb207IGFsZUByZXYubmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDAvMzRd
IEhleGFnb24gcGF0Y2ggc2VyaWVzDQo+DQo+IEkgZG9uJ3QgbWluZCBpbnRlcm1lZGlhdGUgdXBk
YXRlcy4gIEp1c3Qga2VlcCBhIGxpc3QgaW4gdGhlIGNvdmVyIGxldHRlciBvZiB0aGUNCj4gdGhp
bmdzIHRoYXQgYXJlIHN0aWxsIG9uIHRoZSB0by1kbyBsaXN0LCBhbmQgSSdsbCBub3QgZm9jdXMg
b24gdGhvc2UuDQo+DQo+IFdlIGNvdWxkIGFsc28gdGFsayBhYm91dCB3aGF0IHBvcnRpb25zIG9m
IHRoZSB0by1kbyBsaXN0IGFyZSBibG9ja2VyLCBhbmQgd2hhdA0KPiBjYW4gYmUgZG9uZSB2aWEg
bm9ybWFsIGRldmVsb3BtZW50LiAgQmVjYXVzZSBuZWl0aGVyIHlvdSBub3IgSSB3YW50IHRvDQo+
IGNhcnJ5DQo+IGFyb3VuZCB0aGlzIGh1Z2UgcGF0Y2ggc2V0IGZvcmV2ZXIuDQoNCk9LLCBoZXJl
J3MgdGhlIGxpc3Qgb2YgaXRlbXMuICBMZXQgbWUga25vdyBpZiBJIG1pc3NlZCBhbnl0aGluZy4g
IEknbGwgaW5kaWNhdGUgd2hpY2ggb25lcyBjYW4gYmUgZG9uZSBxdWlja2x5IGFuZCB3aGljaCBv
bmVzIHdvdWxkIHRha2UgbW9yZSB0aW1lLiAgSSBhZGRlZCBhIGNvbHVtbiBmb3IgYmxvY2tlciBp
ZiB5b3Ugb3IgYW55b25lIGVsc2UgaGFzIGlucHV0IG9uIHRoYXQuDQoNClBhdGNoSXRlbUVmZm9y
dEJsb2NrZXINClVzZSBxZW11IHNvZnRmbG9hdD8/WWVzDQpVc2UgcWVtdSBkZWNvZGV0cmVlLnB5
Pz8NClNldmVyYWxVc2UgY29uc3Qgd2hlbiBhcHByb3ByaWF0ZXNtYWxsDQpTZXZlcmFsUmVtb3Zl
IGFueXRoaW5nIGFmdGVyIGdfYXNzZXJ0X25vdF9yZWFjaGVkc21hbGwNClNldmVyYWxGaXggbG9n
X3N0b3JlMzIvNjQgYWRkL3JlbW92ZS9hZGQgaW4gcGF0Y2ggc2VyaWVzc21hbGwNClNldmVyYWxG
b2xsb3cgbmFtaW5nIGd1aWRlbGluZXMgZm9yIHN0cnVjdHMgYW5kIGVudW1zc21hbGwNCjA0TW92
ZSBkZWNscyB0byBjcHUtcGFyYW0uaHNtYWxsDQowNFJlbW92ZSBDT05GSUdfVVNFUl9PTkxZIGlm
ZGVmJ3NzbWFsbA0KMDRSZW1vdmUgREVCVUdfSEVYQUdPTnNtYWxsDQowNFJlbW92ZSBzdGFjayBw
b2ludGVyIG1vZGlmaWNhdGlvbiBoYWNrLCB1c2UgcWVtdSBtZWNoYW5pc21zbWFsbA0KMDRBZGQg
cHJvcGVydHkgeC1sbGRiLWNvbXBhdCB0byBjb250cm9sIG91dHB1dCBpbiBsb2dzbWFsbA0KMDZJ
bmNsdWRlIGluc3RydWN0aW9uIGFuZCByYXcgYnl0ZXMgaW4gZGlzYXNzZW1ibHlzbWFsbA0KMDdV
c2UgREVGX0hFTFBFUl9GTEFHU3NtYWxsDQowNywgMjZFbmRpYW5uZXNzIG9mIG1lcmdlX2J5dGVz
c21hbGwNCjA3Rml4IG92ZXJsYXAgdGVzdHNtYWxsDQowN1JlbW92ZSBIRUxQRVIoZGVidWdfdmFs
dWUpL0hFTFBFUihkZWJ1Z192YWx1ZV9pNjQpc21hbGwNCjA5SW5jbHVkZSAicWVtdS9vc2RlcC5o
IiBpbnN0ZWFkIG9mIDxzdGRpbnQuaD5zbWFsbA0KMTAgKGFuZCBvdGhlcnMpU3RpY2sgd2l0aCBz
dGRpbnQuaCB0eXBlcyBleGNlcHQgaW4gaW1wb3J0ZWQgZmlsZXNzbWFsbA0KMTFSZW1vdmUgZGVz
Y3JpcHRpb24gZnJvbSByZWcgZmllbGQgZGVmaW5pdGlvbnNzbWFsbA0KMTNNb3ZlIHJlZ21hcC5o
IGludG8gZGVjb2RlLmNzbWFsbA0KMTQsIDI3VXNlIGJpdCBtYXNrIGluc3RlYWQgb2Ygc3RyaW5n
cyBpbiBkZWNvZGluZ3NtYWxsDQoxNEFkZCBjb21tZW50cyB0byBkZWNvZGVyc21hbGwNCjE2VXNl
IHFlbXUvaW50MTI4LmhtZWRpdW0NCjE3U3F1YXNoIHBhdGNoZXMgZGVhbGluZyB3aXRoIGltcG9y
dGVkIGZpbGVzc21hbGwNCjI0VXNlIHFlbXUvYml0b3BzLmggZm9yIGluc3RydWN0aW9uIGF0dHJp
YnV0ZXNzbWFsbA0KMjRGaXggaW5pdGlhbGl6YXRpb24gb2Ygb3Bjb2RlX3Nob3J0X3NlbWFudGlj
c3NtYWxsDQoyNENoYW5nZSBpZiAocCA9PSBOVUxMKSB7IGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7
IH0gdG8gYXNzZXJ0KHAgIT0gTlVMTClzbWFsbA0KMjVFeHBhbmQgREVDTC9SRUFEL1dSSVRFL0ZS
RUUgbWFjcm9zIGludG8gZ2VuZXJhdGVkIGNvZGVzbWFsbA0KMjZSZXdyaXRlIGZJTlNFUlQqLCBm
RVhUUkFDVCosIGY/WFROIG1hY3Jvc3NtYWxsDQoyNkludmVzdGlnYXRlIGZSTkQgbWFjcm9zbWFs
bA0KMjZDaGFuZ2UgUkVHID0gUkVHIHRvIChWT0lEKVJFRyB0byBzdXBwcmVzcyBjb21waWxlciB3
YXJuaW5nc21hbGwNCjI3UmVtb3ZlIG11bHRpcGxlIGluY2x1ZGVzIG9mIGltcG9ydGVkL2ljbGFz
cy5kZWZzbWFsbA0KMjhNb3ZlIGdlbnB0cl9oZWxwZXJzLmggaW50byBnZW5wdHIuY3NtYWxsDQoy
OFJlbW92ZSB1bm5lZWRlZCB0ZW1wc3NtYWxsDQoyOFVzZSB0Y2dfZ2VuX2RlcG9zaXRfdGwgYW5k
IHRjZ19nZW5fZXh0cmFjdF90bCB3aGVuIGRlYWxpbmcgd2l0aCBwM18wc21hbGwNCjI5U2l6ZSBv
cGNvZGVfZ2VucHRyW10gcHJvcGVybHkgYW5kIGluaXRpYWxpemUgd2l0aCBbVEFHXSA9IGdlbmVy
YXRlXyMjVEFHc21hbGwNCjMwRG9uJ3QgZ2VuZXJhdGUgaGVscGVycyBmb3IgaW5zdHJ1Y3Rpb25z
IHRoYXQgYXJlIG92ZXJyaWRkZW5zbWFsbA0KRG9uJ3QgaW5jbHVkZSAiZ2VuX3RjZy5oIiBpbiBo
ZWxwZXIuaA0KMzFVc2UgYml0bWFzayBmb3IgY3R4LT5yZWdfbG9nIGluc3RlYWQgb2YgYW4gYXJy
YXlzbWFsbA0KMzFVc2UgdGNnX2dlbl9leHRyYWN0X2kzMiBmb3IgZ2VuX3Nsb3RfY2FuY2VsbGVk
X2NoZWNrc21hbGwNCjMxUHJvcGVybHkgZGVhbCB3aXRoIHJlYWRpbmcgaW5zdHJ1Y3Rpb25zIGFj
cm9zcyBhIHBhZ2UgYm91bmRhcnkgYW5kIHRvb21lZGl1bQ0KbWFueSBpbnN0cnVjdGlvbnMgYmVm
b3JlIGZpbmRpbmcgZW5kLW9mLXBhY2tldA0KMzFEb24ndCBzZXQgUEMgYXQgdGhlIGJlZ2lubmlu
ZyBvZiBldmVyeSBwYWNrZXRtZWRpdW0NCjMxRG9uJ3Qgc2V0IHNsb3RfY2FuY2VsbGVkIHVubGVz
cyBuZWVkZWRzbWFsbA0KMzFEb24ndCBzZXQgaGV4X3ByZWRfd3JpdHRlbiB1bmxlc3MgbmVlZGVk
bWVkaXVtDQozMUNoYW5nZSBjYW5jZWxsZWQgdmFyaWFibGUgdG8gbm90IGxvY2Fsc21hbGwNCjMx
UmVtb3ZlIHVubmVjZXNzYXJ5IHRlbXBzbWFsbA0KMzFMZXQgdGNnX2dlbl9hZGRpX3RsIGNoZWNr
IGZvciB6ZXJvc21hbGwNCjMxTW92ZSBnZW5fZXhlY19jb3VudGVycyB0byBlbmQgb2YgVEIgaW5z
dGVhZCBvZiBldmVyeSBwYWNrZXRtZWRpdW0NCjMxTW92ZSBlbmQgb2YgVEIgaGFuZGxpbmcgdG8g
aGV4YWdvbl90cl90Yl9zdG9wc21hbGwNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQo=

