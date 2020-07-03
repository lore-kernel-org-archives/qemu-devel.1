Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1235DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1404207D4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DZEhQPCU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G5bcwo83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1404207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9rX-00041q-35
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9q3-0001zs-Cw; Thu, 02 Jul 2020 20:45:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9q1-0006lC-6S; Thu, 02 Jul 2020 20:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737158; x=1625273158;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=02l6/MBJWpzI6U30fR3j3BSfXbpsVFBvBFnFivIJwJQ=;
 b=DZEhQPCUf9sVHcdu2Sraks1Vc8+horWpokAO+N3FmRH/NUTGA5a8SFNm
 ivcYi/eB2UkyTbH+fHk7IS6Q4hWfo9xiSnAGfl9FhUwIQ2yoRE5UQlCBh
 ZgVHfu3JqqT2rzImnBStCa+i2JS1pIkJU36zPAVIsDlRq/h/qZpPvqxyX
 lTxZttB4mZKVH5a3Jp/jnEYENBWXyQu/uJx7QB4Oit5Cy8Mea413mhSLg
 oJmd5zQUZqbe2xFSgvTCEb7U3WZKWFYuyUiBX+ZNhNYCkA779OgF69Ikv
 CS03BaWfmyLil/awmclJ5ymcIkRJK0Hsxm3C3RNPEeuyyMtdw+ldPJxDE A==;
IronPort-SDR: uUErP88QBXQxsMkAKKrHxMsFrSEDftvXHOrWgFK4RVG+t5DvNlSJmvHsKMevLrLJRQmPcgxwpk
 KGAjSGgn6/h6fYu8hUT3UumJppYufLi9Sn78mJ7j/jkStmZgrJm/m0yPRYxO96HdgmcosBWtYz
 wNcdHXoT/hChCRLtGRlbbs/eDrfMvsyLxKUnS0Jvi+qvGCZ6mUVXK5twHdNC6gNGbyJl6P2RyH
 V1UnNqEdDtPQe9cn7LofFhHgX29DZucJ+SdVzPxL2miT+YoN42QpIdKaQYG2wMZiqQK4Qq1FL3
 564=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="145864638"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:45:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW5yvULPfYJO++Ag+ZK4XcnyMLHb1g4lnulhvCHow5xB2t+6mBGm4SZ9La4RR82iZ7GB7whSvBZF/Z9+DcAKp9SCpSrb4MGQF2F8WVOYTFQHVNxU8htMnUKsMzD/3pRr/UIAVH31IdeUpf8bBTK/qAEOiRR4YQKvehusKFN3IV9KIjgk600MeKDb/6kaN6iEXld53gHIgOllm1GVmPyukbv/pOM7MM/0YtfVDZfZg6MYCvDbVx3aFNNu8m7l0k+Eoso5B4vxluJxuKIoe4O9ZvcMae5k2aWW4WNGfWhDTMGAhv2gF2WArRVdaNxXT/ae2ozQCq8eoghdPXTePOdIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02l6/MBJWpzI6U30fR3j3BSfXbpsVFBvBFnFivIJwJQ=;
 b=UQiLVfaPt+qOnuYauY9koM7aindSXHydNURYlUTcINXC69Rwvx1Mu9ZmfNJriN+lrxbG3eBagRGuQObz7abFq5qLLvhXmL4THR4vAtYipNjhTwjBLupVSnfufxvWAHUv5ZOASAZ9LBEEXZPF/cc0p88kqjavzkcvKI+KQ9wVrUQ1eSeO6Wu2DLlJ0OeK/DLJX8q1R7UMnoxK4osWCJcNk5+LweSGX4695PjXxV8m/0RhNryUq+C+A/Nr4DnGAJwyEz1OCkMjIrfjH6DCTYnPGcA3P0NBWWUBR4Je0htXe/SdBxm0ASMd/Pn52MSeur6J8PNykw4m/o+/KMCHdMF1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02l6/MBJWpzI6U30fR3j3BSfXbpsVFBvBFnFivIJwJQ=;
 b=G5bcwo83pK2oEur0aud94NB3K6hg3+IKjKoMxYVZFj2ukkCffEIXYMlIMv7qL3jaOWTlui7l0uPi6TgqVw8VrfvTpcnyfhXXyh5Mp+m/1HaEZfHnlomRbdE0iYpFlLIqIsvoeno1TDb8KR3w/gVLqyybkedD+pCOUtZ2jd7yn4w=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5566.namprd04.prod.outlook.com (2603:10b6:208:e3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 00:45:52 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:45:52 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 10/17] hw/block/nvme: fix missing endian conversion
Thread-Topic: [PATCH 10/17] hw/block/nvme: fix missing endian conversion
Thread-Index: AQHWTkPeyIgLxBa2MkCNpTvv1H8QOKj1ChGA
Date: Fri, 3 Jul 2020 00:45:52 +0000
Message-ID: <5421a4fe3b622ae9aa4d0776edc917b3cd42c153.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-11-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-11-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [173.70.233.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55f3528d-1185-475b-7316-08d81eea7008
x-ms-traffictypediagnostic: MN2PR04MB5566:
x-microsoft-antispam-prvs: <MN2PR04MB556631F0CBFD0120A344B309E16A0@MN2PR04MB5566.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:247;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TolH69zo+LY4TVzIUcF7JPDvwe5tdGY/gFAiom0QfaPeSEZLt+LPTkibHG1M0hz/I7CswEhEqVkTSF66Ye+PDyXSbnNmK8sEGAwPZaM7WdMGd4LC8b6GpEqJ//oSE9TOD9yLkc/eKR+TwtxwbyM86BSsaE+dWie+izqkoEK00ohvm8PDaMj5htH9sjuC70JHjpWfUSRRwDcdhRQgZMjfzB4dQhj81oR69hUrjKGsNOL8iY7UBUHR79MS4XS7d/f/6HvMJCiVOCnx8VgCtFwNrXV8pKcuzmD+ZoejgMfU9YucQGgoQbD+ZcBF2SORHPPWSdK8kFKPf84BqF/lWAqdFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(5660300002)(8936002)(4326008)(2616005)(76116006)(71200400001)(316002)(110136005)(54906003)(8676002)(6506007)(186003)(26005)(6486002)(478600001)(2906002)(64756008)(66476007)(66446008)(66556008)(6512007)(86362001)(83380400001)(66946007)(36756003)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: m2GzLy6PA3IEBHmv4us6bBCNBQshN7Dg1inDk47791l83G2kGrbeHJnRD71+HxUHAskevfELBBxOsKEwkFsTM7cgagMEV5cYHRQEL9lGyOWczcOHEz1l0j4zUasyRK8a93okxLKGINLVjro4s4nWhxW3GQXuSQRIeT/onjKq/KTzRxZfGxMBuOq00FPv7pLyKs0XX7SWd4uo4ScJmKKA6+6c02dPYQdnTgpCGXqkkL55RzYvk2mWiNjLksZMTX3xovg83qhfMVVQhCnhmWrnif0OgnxdvtRfd4nMO2QpiV9fI2Vvqoe049KL9RDUQpwiFGPZlOTD8ILXYLFoiA5+jiYkniFKfdrMjpNgNftJIyxeW7oV2Gz4QBt8DkSNO7j/xxCbXRfV7GcO7QzbbtVa6jyn1R2HUZayAMy70MTTRhNADN6p/HabdlNjjbpDpztkcjD3Og2BDOWHYUoYMJVSlB81+z6GmHf/g0X6SXbuwqQ5S0hB9h/hdbuzOuFObz+m
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <37E8EC4382514545AEA2ABCA1E4EC3FF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f3528d-1185-475b-7316-08d81eea7008
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:45:52.2288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RHjLZkntZJNCKuvPYfSWRX8EuYY/tcfrMCXIhbemrpMCsvJE1uogd5WK2LtlKH8qcihai1BsjrX8UgQFbbB8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5566
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=446c5dbe3=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 20:44:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNi0yOSBhdCAyMDoyNiArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gRml4IGEgbWlzc2luZyBjcHVfdG8gY29udmVyc2lvbi4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiAgaHcv
YmxvY2svbnZtZS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2svbnZtZS5jIGIvaHcvYmxv
Y2svbnZtZS5jDQo+IGluZGV4IGMyNTA3ZDg4MzZmZC4uZGExM2NhMWRkYjYwIDEwMDY0NA0KPiAt
LS0gYS9ody9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcvYmxvY2svbnZtZS5jDQo+IEBAIC0xMDgx
LDcgKzEwODEsNyBAQCBzdGF0aWMgdWludDE2X3QgbnZtZV9nZXRfZmVhdHVyZShOdm1lQ3RybCAq
biwgTnZtZUNtZCAqY21kLCBOdm1lUmVxdWVzdCAqcmVxKQ0KPiAgDQo+ICAgICAgICAgIGJyZWFr
Ow0KPiAgICAgIGNhc2UgTlZNRV9WT0xBVElMRV9XUklURV9DQUNIRToNCj4gLSAgICAgICAgcmVz
dWx0ID0gYmxrX2VuYWJsZV93cml0ZV9jYWNoZShuLT5jb25mLmJsayk7DQo+ICsgICAgICAgIHJl
c3VsdCA9IGNwdV90b19sZTMyKGJsa19lbmFibGVfd3JpdGVfY2FjaGUobi0+Y29uZi5ibGspKTsN
Cj4gICAgICAgICAgdHJhY2VfcGNpX252bWVfZ2V0ZmVhdF92d2NhY2hlKHJlc3VsdCA/ICJlbmFi
bGVkIiA6ICJkaXNhYmxlZCIpOw0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBjYXNlIE5WTUVf
TlVNQkVSX09GX1FVRVVFUzoNCg==

