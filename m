Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA8C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7334D20DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OIMLMJWR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tdsyT1E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7334D20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOZ0-0007Fw-E3
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=52301f24b=Dmitry.Fomichev@wdc.com>)
 id 1kJOXu-000694-D1; Fri, 18 Sep 2020 18:07:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=52301f24b=Dmitry.Fomichev@wdc.com>)
 id 1kJOXq-0007Gs-T4; Fri, 18 Sep 2020 18:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600466875; x=1632002875;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q+pGtVVmZDLzTDKUqePl9h5jnQmzk+Bxd8nkPmP/UKI=;
 b=OIMLMJWRXHmQfZQOetbtAM736KL10S4V+V5rdf9dLIgzWvv4WfTSRIeH
 VT0KYVhsZ9j/X6/bTFQlUOpdgjdu+ilPDtWFPZtV6fhlHZuQp3VLWeVAh
 fEpG6qKAHF11xD0QcP1YkO4kjNyn3BBanapU+WTr1myg1e2vLpg6nkYGa
 TAq1coZjOWs21cA45gHfDkXRpoow2SPv+DKGsHp1IVUeYDQURPE1r1FIj
 Q/okKuX+vAQrb0QLO2jY3IhVkw52O2NZm2WxJMvijTQz3Qd4i5QPUKxFc
 T2avReBzaRonfEIxy6Yw/6YwNwKSrsJB134V8IoX9hBsJXuUize+EKBRh g==;
IronPort-SDR: iKdE4s604Bsw7bVQJxlnITR2EqM1YDzBHh19v0vdN9NxBsY/NNK8eRTiW8TFOjZ9o4m971H/V8
 ffGvbQJZrs9KkudmleywPpWgQPaEdHnUPJFF1iRgg6P7i8s9SJC7J6ScuxbOWt0A9QeSRJu1+w
 5m3E11N82/Ni4H5H7BAunZOIb8JWkullEfZ3Ey2Y8YwDFGfUQ1JSVpaO4yd8dLIkuE4w0PeC/C
 3hTuPTADa59qxnzNMSsBhaLryYI2He7UsEWt+4/0d8SVe44aiQz2u22wt3hPr9fCNLLM8S79S7
 lu0=
X-IronPort-AV: E=Sophos;i="5.77,276,1596470400"; d="scan'208";a="147772179"
Received: from mail-bn8nam08lp2049.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
 by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2020 06:07:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiBzluAyv55MDVszzX6W76o8a3ArQLAvCtdr9alA3q+mxTH45Ro7lfLHiwdBHkSLQQScDWlOtXBErhXzlkh1SC+MZ0DnLTEtcMj/ayKG2ozS0vIIsi6gpiHUhDp9TsB2uP0XxoH1Qq/oU4adUavu7ZJxQktFeKY6yRnC235HcSwJnaLuUTmHp2Wh8/8r5zb/6veRmjk5EzWQyhFXuF7uV0uYB/FDNZy9LVGGhHPL8KZexQM62tovEoiVG/DpbOM0Kg0QFOKZRt6LWYxwhB1w7sd+dtxx1knQlflpqJ+0To4KEZqBVH5hYILP/2Kr8A6XGBqsEcTfQoN5a8XXLWG38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+pGtVVmZDLzTDKUqePl9h5jnQmzk+Bxd8nkPmP/UKI=;
 b=n2ZkazjJE8m1i2mcVNurlmqz0bqj3TS3jkcpbI/mLgrrn5Bn+urT8kVUMA7ejUzQqjaWs7/n6SITLqnt5KcFKJokdBd5twrDe6bDb2KdtjIknY/UlI3M4LNmDBnnlCqc+bc0heAjfPAJtuBpWXQUlT2fJ6pPJLdqm/EaOD48UzodRwZOiXH7VrMXlDGdfKjdWIpXaZWtwyfM47lNb8MVZvgYa0lTr+1nP6QjZ/PeNxGObojCUB84Ikc0jVC+FC8UFG/UOHVn8I6oqqh1zR7N1su/4OuCF5iBUQetID9cr/2DZcZui27pNEOHCCESOGB5L8XFuhBPu3QW1kZwnYHC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+pGtVVmZDLzTDKUqePl9h5jnQmzk+Bxd8nkPmP/UKI=;
 b=tdsyT1E/NUBs+jztTagNhaENFJC1DYnBJB6LmIMY+NTtn6VMqIhIa5rHXR/2wEqmj4ffg+dPejqFRIc/r9j/2uHUpdH94v9AK3c5slmBU9LUR39PG5cts7B/avpFIxE98popztyKZ91cHKQ4YqgiVjs4s0kNSvVoPRaxdvn2/58=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5597.namprd04.prod.outlook.com (2603:10b6:208:a0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 18 Sep
 2020 22:07:46 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 22:07:46 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v3 10/15] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v3 10/15] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWihtXQkLHJYTIaUODPI5SY2BllKlu7sEAgAALXnA=
Date: Fri, 18 Sep 2020 22:07:46 +0000
Message-ID: <MN2PR04MB5951AFB6797A72784034181DE13F0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-11-dmitry.fomichev@wdc.com>
 <20200918212008.GA581752@apples.localdomain>
In-Reply-To: <20200918212008.GA581752@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21f03183-90cb-47df-4920-08d85c1f4652
x-ms-traffictypediagnostic: MN2PR04MB5597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5597385C7698B261939A9BBDE13F0@MN2PR04MB5597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkJys3yEdcKi+EfTssO2vC5Cc4ihGg7EgbU/FNXWWnuHul/VbuY+casDGcUAEmGRWc832Uucowxl4QoMYg57WJAYgkf7Sn+fE6/ygtc1quzgUF/kWynewaAtGlS8FLV6Bqp135SgKR6yG5sPQT23Yv24dGzY2GHGiUIKqzV0UoJiR40sf1C/rbxd/toek7ZwqOJ1O4ei4cjlK3yyQDR8NJL0dM5WeljCpQBp2mRBhTCwUr4LFwzF3IlVGjbMRVAxxPkNLZ7EoHGJb40EE3a5uK99I4xCG0/AvbkpgvsXfP/v7/PAhCbgV0iMMmfcjZ4nyhSw/yEaPSXQ2yPDxJxqGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(66476007)(66446008)(66946007)(8676002)(86362001)(66556008)(64756008)(186003)(52536014)(8936002)(76116006)(4326008)(53546011)(6506007)(33656002)(26005)(9686003)(7696005)(55016002)(316002)(71200400001)(54906003)(478600001)(6916009)(5660300002)(2906002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: VVxv48v+DEm2Nxox500PZxoHdsUQNPUTNitO5thoH2x2ZU0yuZeHV9qXBpzY8q+4kOC5aw4moJBAEPT/BIrNmX52ruLxAKtDb/b1UZqSUchBjmabM6xu3F8zlcz51KyleIJhaUpIMkmhKi2NB8ZHATKrEBWPyU6CuYcNdZps3+POBGfWtTgYHXCPbHRwJZIAFvOa6TUKJlTGzhkWXZ5JN+BRkcDuzm+TzyQacZI/WCdOx4PNik3LJ42RNpwrCzSAIbhZWcnXPXHvD9hUtH8dXDHNSBjOU0MqpmsSKXMQJwi+v2v8wW6e9S5lfyTCRUEdsXM+38d13X/Ias5ezfnVmrWSDaURgRBuwzY7Pv/5cnlJpYqolR3OOAWiz7XT75fcixPvFjR7FrQJ9bU0hqrBMmdjbzgI6q2ULThJFAw8Cqlt+dAgXjHibEKpd9YvRzHgMOtgKAj95V3kGHTQVNYREBKXWr5N5oEdhjj5aPy0m/ODAZViOiF1VbpqsyynjBoOTbsDz/d9jHWITsbw3SW/ess3/y8SrxVgPMDWgP6MdWhtU098kupSmWVH/Y8h43lBT0saWvbpEKkzGbY/H5rTCggmYqacbpl327Zoh6OWG4aHPKzTtqNPIwRaNXjuhdrTUWbcmAwwpr7d84JVRjh7Rw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f03183-90cb-47df-4920-08d85c1f4652
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 22:07:46.4225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bU8EbVUX+JobjcflFrlIHmWYE+2Zu88ipxN4ZMhtbcqOZe/tUTROiyKNqQlrI2/8o6h1WKGy0d+fgeeIbQTNWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5597
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=52301f24b=Dmitry.Fomichev@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 18:07:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGl0c0Bp
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxOCwgMjAyMCA1OjIwIFBN
DQo+IFRvOiBEbWl0cnkgRm9taWNoZXYgPERtaXRyeS5Gb21pY2hldkB3ZGMuY29tPg0KPiBDYzog
S2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgS2xhdXMgSmVuc2VuDQo+IDxrLmplbnNl
bkBzYW1zdW5nLmNvbT47IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+OyBQaGlsaXBwZQ0K
PiBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+OyBNYXhpbSBMZXZpdHNreQ0KPiA8
bWxldml0c2tAcmVkaGF0LmNvbT47IEZhbSBaaGVuZyA8ZmFtQGV1cGhvbi5uZXQ+OyBOaWtsYXMg
Q2Fzc2VsDQo+IDxOaWtsYXMuQ2Fzc2VsQHdkYy5jb20+OyBEYW1pZW4gTGUgTW9hbCA8RGFtaWVu
LkxlTW9hbEB3ZGMuY29tPjsNCj4gcWVtdS1ibG9ja0Bub25nbnUub3JnOyBxZW11LWRldmVsQG5v
bmdudS5vcmc7IEFsaXN0YWlyIEZyYW5jaXMNCj4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47
IE1hdGlhcyBCam9ybGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMTAvMTVdIGh3L2Jsb2NrL252bWU6IFN1cHBvcnQgWm9uZWQgTmFtZXNwYWNl
DQo+IENvbW1hbmQgU2V0DQo+IA0KPiBPbiBTZXAgMTQgMDc6MTQsIERtaXRyeSBGb21pY2hldiB3
cm90ZToNCj4gPiBUaGUgZW11bGF0aW9uIGNvZGUgaGFzIGJlZW4gY2hhbmdlZCB0byBhZHZlcnRp
c2UgTlZNIENvbW1hbmQgU2V0DQo+IHdoZW4NCj4gPiAiem9uZWQiIGRldmljZSBwcm9wZXJ0eSBp
cyBub3Qgc2V0IChkZWZhdWx0KSBhbmQgWm9uZWQgTmFtZXNwYWNlDQo+ID4gQ29tbWFuZCBTZXQg
b3RoZXJ3aXNlLg0KPiA+DQo+ID4gSGFuZGxlcnMgZm9yIHRocmVlIG5ldyBOVk1lIGNvbW1hbmRz
IGludHJvZHVjZWQgaW4gWm9uZWQgTmFtZXNwYWNlDQo+ID4gQ29tbWFuZCBTZXQgc3BlY2lmaWNh
dGlvbiBhcmUgYWRkZWQsIG5hbWVseSBmb3IgWm9uZSBNYW5hZ2VtZW50DQo+ID4gUmVjZWl2ZSwg
Wm9uZSBNYW5hZ2VtZW50IFNlbmQgYW5kIFpvbmUgQXBwZW5kLg0KPiA+DQo+ID4gRGV2aWNlIGlu
aXRpYWxpemF0aW9uIGNvZGUgaGFzIGJlZW4gZXh0ZW5kZWQgdG8gY3JlYXRlIGEgcHJvcGVyDQo+
ID4gY29uZmlndXJhdGlvbiBmb3Igem9uZWQgb3BlcmF0aW9uIHVzaW5nIGRldmljZSBwcm9wZXJ0
aWVzLg0KPiA+DQo+ID4gUmVhZC9Xcml0ZSBjb21tYW5kIGhhbmRsZXIgaXMgbW9kaWZpZWQgdG8g
b25seSBhbGxvdyB3cml0ZXMgYXQgdGhlDQo+ID4gd3JpdGUgcG9pbnRlciBpZiB0aGUgbmFtZXNw
YWNlIGlzIHpvbmVkLiBGb3IgWm9uZSBBcHBlbmQgY29tbWFuZCwNCj4gPiB3cml0ZXMgaW1wbGlj
aXRseSBoYXBwZW4gYXQgdGhlIHdyaXRlIHBvaW50ZXIgYW5kIHRoZSBzdGFydGluZyB3cml0ZQ0K
PiA+IHBvaW50ZXIgdmFsdWUgaXMgcmV0dXJuZWQgYXMgdGhlIHJlc3VsdCBvZiB0aGUgY29tbWFu
ZC4gV3JpdGUgWmVyb2VzDQo+ID4gaGFuZGxlciBpcyBtb2RpZmllZCB0byBhZGQgem9uZWQgY2hl
Y2tzIHRoYXQgYXJlIGlkZW50aWNhbCB0byB0aG9zZQ0KPiA+IGRvbmUgYXMgYSBwYXJ0IG9mIFdy
aXRlIGZsb3cuDQo+ID4NCj4gPiBUaGUgY29kZSB0byBzdXBwb3J0IGZvciBab25lIERlc2NyaXB0
b3IgRXh0ZW5zaW9ucyBpcyBub3QgaW5jbHVkZWQgaW4NCj4gPiB0aGlzIGNvbW1pdCBhbmQgWkRF
UyAwIGlzIGFsd2F5cyByZXBvcnRlZC4gQSBsYXRlciBjb21taXQgaW4gdGhpcw0KPiA+IHNlcmll
cyB3aWxsIGFkZCBaREUgc3VwcG9ydC4NCj4gPg0KPiA+IFRoaXMgY29tbWl0IGRvZXNuJ3QgeWV0
IGluY2x1ZGUgY2hlY2tzIGZvciBhY3RpdmUgYW5kIG9wZW4gem9uZQ0KPiA+IGxpbWl0cy4gSXQg
aXMgYXNzdW1lZCB0aGF0IHRoZXJlIGFyZSBubyBsaW1pdHMgb24gZWl0aGVyIGFjdGl2ZSBvcg0K
PiA+IG9wZW4gem9uZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWtsYXMgQ2Fzc2VsIDxu
aWtsYXMuY2Fzc2VsQHdkYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFucyBIb2xtYmVyZyA8
aGFucy5ob2xtYmVyZ0B3ZGMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFqYXkgSm9zaGkgPGFq
YXkuam9zaGlAd2RjLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdGlhcyBC
am9ybGluZyA8bWF0aWFzLmJqb3JsaW5nQHdkYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXJh
dmluZCBSYW1lc2ggPGFyYXZpbmQucmFtZXNoQHdkYy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
U2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBZGFtIE1hbnphbmFyZXMgPGFkYW0ubWFuemFuYXJlc0B3ZGMuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWljaGV2QHdkYy5j
b20+DQo+ID4gLS0tDQo+ID4gIGh3L2Jsb2NrL252bWUuYyB8IDk2OA0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDkzOSBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9ody9ibG9jay9udm1lLmMgYi9ody9ibG9jay9udm1lLmMNCj4gPiBpbmRleCBjNzQwY2JjZjFm
Li4wYmY3NDcxODE1IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2Jsb2NrL252bWUuYw0KPiA+ICsrKyBi
L2h3L2Jsb2NrL252bWUuYw0KPiA+IEBAIC03MDksMTEgKzk2NSw3NyBAQCBzdGF0aWMgdWludDE2
X3QgbnZtZV9ydyhOdm1lQ3RybCAqbiwNCj4gTnZtZVJlcXVlc3QgKnJlcSkNCj4gPiAgICAgICAg
ICByZXR1cm4gc3RhdHVzOw0KPiA+ICAgICAgfQ0KPiA+DQo+ID4gKyAgICBpZiAobi0+cGFyYW1z
LnpvbmVkKSB7DQo+ID4gKyAgICAgICAgem9uZV9pZHggPSBudm1lX3pvbmVfaWR4KG4sIHNsYmEp
Ow0KPiA+ICsgICAgICAgIGFzc2VydCh6b25lX2lkeCA8IG4tPm51bV96b25lcyk7DQo+ID4gKyAg
ICAgICAgem9uZSA9ICZucy0+em9uZV9hcnJheVt6b25lX2lkeF07DQo+ID4gKw0KPiA+ICsgICAg
ICAgIGlmIChpc193cml0ZSkgew0KPiA+ICsgICAgICAgICAgICBzdGF0dXMgPSBudm1lX2NoZWNr
X3pvbmVfd3JpdGUoem9uZSwgc2xiYSwgbmxiKTsNCj4gPiArICAgICAgICAgICAgaWYgKHN0YXR1
cyAhPSBOVk1FX1NVQ0NFU1MpIHsNCj4gPiArICAgICAgICAgICAgICAgIHRyYWNlX3BjaV9udm1l
X2Vycl96b25lX3dyaXRlX25vdF9vayhzbGJhLCBubGIsIHN0YXR1cyk7DQo+ID4gKyAgICAgICAg
ICAgICAgICByZXR1cm4gc3RhdHVzIHwgTlZNRV9ETlI7DQo+ID4gKyAgICAgICAgICAgIH0NCj4g
PiArDQo+ID4gKyAgICAgICAgICAgIGFzc2VydChudm1lX3dwX2lzX3ZhbGlkKHpvbmUpKTsNCj4g
PiArICAgICAgICAgICAgaWYgKGFwcGVuZCkgew0KPiA+ICsgICAgICAgICAgICAgICAgaWYgKHVu
bGlrZWx5KHNsYmEgIT0gem9uZS0+ZC56c2xiYSkpIHsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICB0cmFjZV9wY2lfbnZtZV9lcnJfYXBwZW5kX25vdF9hdF9zdGFydChzbGJhLCB6b25lLQ0KPiA+
ZC56c2xiYSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE5WTUVfWk9ORV9JTlZB
TElEX1dSSVRFIHwgTlZNRV9ETlI7DQo+ID4gKyAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAg
ICAgICAgICAgICBpZiAoZGF0YV9zaXplID4gKG4tPnBhZ2Vfc2l6ZSA8PCBuLT56YXNsKSkgew0K
PiA+ICsgICAgICAgICAgICAgICAgICAgIHRyYWNlX3BjaV9udm1lX2Vycl9hcHBlbmRfdG9vX2xh
cmdlKHNsYmEsIG5sYiwgbi0+emFzbCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IE5WTUVfSU5WQUxJRF9GSUVMRCB8IE5WTUVfRE5SOw0KPiA+ICsgICAgICAgICAgICAgICAgfQ0K
PiA+ICsgICAgICAgICAgICAgICAgc2xiYSA9IHpvbmUtPmQud3A7DQo+IA0KPiBZb3VyIGFwcGVu
ZCBpcyBicm9rZW4uDQo+IA0KPiBTaW5jZSB5b3UgbW92ZWQgdGhlIHdyaXRlIHBvaW50ZXIgdXBk
YXRlIHRvIHBvc3QgYWlvIGNvbXBsZXRpb24gKHdoaWNoIEkNCj4gdG90YWxseSBhZ3JlZSB3aXRo
KSwgeW91IGFyZSBub3cgYXNzaWduaW5nIHRoZSBzYW1lIFNMQkEgdG8gYWxsIGFwcGVuZHMNCj4g
dGhhdCBhcmUgaW4gcXVldWUgd2hlbiBudm1lX3Byb2Nlc3Nfc3EgaXMgaW52b2tlZC4NCg0KWWVz
LCB0aGVzZSBuZXdlciBjaGFuZ2VzIHRvIHVwZGF0ZSB0aGUgV1AgaW4gYWlvIGNhbGxiYWNrIHR1
cm5lZCBvdXQgdG8gYmUgYnVnZ3kuDQpXaWxsIGZpeCB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24u
IA0K

