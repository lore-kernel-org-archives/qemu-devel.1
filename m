Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E95C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F394C20720
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ObAFfNN9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M1P8Uqwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F394C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIG95-0000iF-SO
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIG7w-000872-Qh; Tue, 15 Sep 2020 14:56:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIG7u-0008Af-Me; Tue, 15 Sep 2020 14:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600196187; x=1631732187;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=beQknoSoyQdnwV4ciyhJE+yuAXuqWJaYll7y1KnH41U=;
 b=ObAFfNN92PL7KY07DoRScUcrjSML2hfUcpkl5e37tJoP+Pa0dLFfmqWI
 +WWLbPfI/DMlSj33Zr20hWeyeQhQMwBdd+hACAP0fDftGAA6SXj/UG+HW
 kaVKHVsOqwrcAXQok0KVimQ8YJB2NqRJa8FfVJlqS87YGNy3YPCnoOYKf
 uVHFeC0/Ipdo+SNkKwLQ8HjH4xSmNydHr2XRYEfd2aF7lAsnOmcwImfSX
 4X46sef6XoN1shoygGtcQP86Ivk+z8Q6n0iA2YoD07c1d4+0uTJb8rrLv
 jSQgdVi3YklWbxOuhIrddvGBkJG/6G0MY5sy5+XT0xf1KcfX1bMMkiLkI A==;
IronPort-SDR: wYmpNcVHdjmwq5/wKyoyNh5Vc1u8T3bRhF3nGsW6K2U9O3huKECovqlwvq3QbWZb9ZSondUgRI
 2oU/mvvSwG0nRtSA8D7UdsNliDMqhSFnCZ34iLcx+th+7GQgVJsoBCaZ6gBUSbgBX4Tm9QgkBX
 rVbleSCMNQKjI29VeLh99cs+Ll/gGmo1Xen62CZRTxqjC5JSH+TuQ7ZM2MxtzcPW+AZsaOOH9l
 Z0r2yIcYym6d1VGDB2zSELXhMPHh7Sgsuvov+uZ+7UwRkmxJD5l4qKENJbQi9QMHh7jpxrNlll
 cq0=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147459897"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 02:56:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+Qqn9s1wrlo8EUPSivKEu6TzkjckHi56fPecIFB6U9W6jCFVz2tcvWUPUi4Wi5LGZOWQ9hYaBNMlsmd4ER4uTAdUA7rHVfqguQMaexLAxBqFMV+7fyYipSdXY7QW4PzjG8ReFWWC8n+cfGhMmUiB8cwYF31piRVsl7Sc2nwjD2CWInmYCJ/G6FOfUCxPjsPtreaN6BWS0jV+Ipk6OH62DO0DlqBMRHk9s74OVglUsppy9Rnw2ZN/mxNv+LYjiIxg4qRgTLr6t59R0mV63xD1KNrU/vZZKReoYSaOc1RH4hyi7V+mHlA0mfrjIcIcm11/mfXznxCTNKqvT+xssKcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beQknoSoyQdnwV4ciyhJE+yuAXuqWJaYll7y1KnH41U=;
 b=VnwFdCo0a5gXBgSB2AXYedN7X5Z2V3uvx91rLiYXbnFZONjOjZ5Nh/HAdHHqh3QQpf+NbzB1CAVkhI76wBD1xFtmwSYEOKuhEtjpKEBw7XCjrlZQeoJGU1ukJyr3A87dFkT23M1I1/XfqIZqqRY1Q0YuWPp3kn+BJfCoYZHc01pB1NdsH1NePXJDvnFGADUJX7X19evDAixW8lT4JZ7ZhUF2JNbymDjcsmv6OLs8OH4/xUU3ogeZZPPxxANUqKON8tA0SRSgpvyO1lupX4IF8x3i2jE5IjVysizYXx8OnKtE/1SoRXvCy0QuhQZfS+ecmDk7GXZyXH1Mr5adRNbBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beQknoSoyQdnwV4ciyhJE+yuAXuqWJaYll7y1KnH41U=;
 b=M1P8Uqwmwrmo7mzffq6n4eA2Sh+1g0Aah/bFS1mrpZBK1XZmkrDbPZC0r+ekN5s105qZ7d6y/+0O9YHE0OfQ3rlM+ckl6GR6DvkTHUNTNxqN3zSLedkB0SO6McB7lo7+c4yAO1pq4MIbE/69fZz7rUIZpvFMisEva9q63v5yTRQ=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6253.namprd04.prod.outlook.com (2603:10b6:208:d9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 18:56:06 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 18:56:06 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Thread-Topic: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Thread-Index: AQHWihtL9tNHpqz1v0eii/7TyAZucKlpUd8AgAC3oNA=
Date: Tue, 15 Sep 2020 18:56:06 +0000
Message-ID: <MN2PR04MB5951ED0FD5633E8144459A28E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-2-dmitry.fomichev@wdc.com>
 <20200915073720.GB499689@apples.localdomain>
In-Reply-To: <20200915073720.GB499689@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ca316b7-e2f9-474e-328f-08d859a9008c
x-ms-traffictypediagnostic: MN2PR04MB6253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6253001627106813842C4BFCE1200@MN2PR04MB6253.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2XbFGvWoQOLz8OSFmKNmcP3AuiDok59OnIFlfybsxgqFw6nUpD7BvFaltXXc8txvqnB1KzZtwgQAZ/mgf5/SZNEkTk6yxbYEYsmwgk9jCNYihHQnt144E5CJPILgWK9kWngAs2h3k/YYEtxtxmCIdbx6e3INQ+2fo04njtA9jYOFkxP16jjZUj4lkJzXnlG5ytHfpd1zMSgEPVFUtV44jWYhVcrJiYFVeuSThtrO5I96Scz33AyJWNLC2GjnFDP9kqv6ayOwBNF6HAEmiDNs/t2QG+gqZ8L2BfJ9dnMn9BRVGs+BMznc1OrR7Qp8PtR/N8VOeQj5MSYNW3nrCZPMg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(54906003)(316002)(86362001)(7696005)(186003)(8676002)(33656002)(8936002)(83380400001)(55016002)(2906002)(52536014)(76116006)(5660300002)(9686003)(66946007)(6506007)(6916009)(66446008)(64756008)(26005)(71200400001)(53546011)(66556008)(4326008)(66476007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xqTtQ+JPsgTb+h4ijuBchHQObI4MHG0UNf37aTjsJ/rNwDd3jYQdaTcMI1i5j3fd5XQiT0XynFraSTqiwvOVEuF1Lp+ZJh1fDJ7bg72XlZ2lO0WZiuVtpqeWlMWbcpWDN8fBdWKFG2RDG6gBZqaEk+SSJ5uZG8ZY7SgwRjuESxS3+P/jWh0Yqfkw9aW28riGcYu5ty0/CDvV4IejYEr+Xk09WetxrZNFpMUAAB+mhPRNMQbxxanjXVUwjYC7HZ9UVeFkaFiNknbPwe6Fc3NO1HZMeBaoPgfakGx+3m/qm7B/qi34/q0S36uXDjVDJPqZzjjtocF4EGSCftXUaB8qIpWtpcbKk/fZrCYRk7ODhCAV9iLld/4NaTLWIM5OtaCkQKNNhMYPGihClJGvxDxvBKApV02Xvn2ObmoG4Tsg5EGn0IpYYarE6ZPDz24k0rjPhRJi9azZzxpCScOcF+HNc4TuOfyYOumRNb6dIunnUEvH0PXRopQN8Ckh7XzDBoqt+VoTy/c84BiLWJ9PubbitfiDTXV4axS36zBg9/1wfoPeDrgVub25IIBRDOg8gVDaqEc1SNwzbh90RxCCHh81fQBFAPYiTw+WHoQFxRK0KXle/N8q3GRhnRbWdFgrc0oNEAgmnNU4Nv132HCzhALc/w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca316b7-e2f9-474e-328f-08d859a9008c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 18:56:06.4839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLalwJUXq7YUTjnj99HaJabm01+TLolkPzk/33Ep/M+JW4AMILLiCnURWQ3jgCPuzprX0es9SJeE/JwqlLaKmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6253
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=520035bb9=Dmitry.Fomichev@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 14:55:38
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
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjAgMzozNyBB
TQ0KPiBUbzogRG1pdHJ5IEZvbWljaGV2IDxEbWl0cnkuRm9taWNoZXZAd2RjLmNvbT4NCj4gQ2M6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IEtsYXVzIEplbnNlbg0KPiA8ay5qZW5z
ZW5Ac2Ftc3VuZy5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgUGhpbGlwcGUN
Cj4gTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgTWF4aW0gTGV2aXRza3kNCj4g
PG1sZXZpdHNrQHJlZGhhdC5jb20+OyBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsgTmlrbGFz
IENhc3NlbA0KPiA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPjsgRGFtaWVuIExlIE1vYWwgPERhbWll
bi5MZU1vYWxAd2RjLmNvbT47DQo+IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBu
b25nbnUub3JnOyBBbGlzdGFpciBGcmFuY2lzDQo+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+
OyBNYXRpYXMgQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDAxLzE1XSBody9ibG9jay9udm1lOiBEZWZpbmUgNjQgYml0IGNxZS5yZXN1
bHQNCj4gDQo+IE9uIFNlcCAxNCAwNzoxNCwgRG1pdHJ5IEZvbWljaGV2IHdyb3RlOg0KPiA+IEZy
b206IEFqYXkgSm9zaGkgPGFqYXkuam9zaGlAd2RjLmNvbT4NCj4gPg0KPiA+IEEgbmV3IHdyaXRl
IGNvbW1hbmQsIFpvbmUgQXBwZW5kLCBpcyBhZGRlZCBhcyBhIHBhcnQgb2YgWm9uZWQNCj4gPiBO
YW1lc3BhY2UgQ29tbWFuZCBTZXQuIFVwb24gc3VjY2Vzc2Z1bCBjb21wbGV0aW9uIG9mIHRoaXMg
Y29tbWFuZCwNCj4gPiB0aGUgY29udHJvbGxlciByZXR1cm5zIHRoZSBzdGFydCBMQkEgb2YgdGhl
IHBlcmZvcm1lZCB3cml0ZSBvcGVyYXRpb24NCj4gPiBpbiBjcWUucmVzdWx0IGZpZWxkLiBUaGVy
ZWZvcmUsIHRoZSBtYXhpbXVtIHNpemUgb2YgdGhpcyB2YXJpYWJsZQ0KPiA+IG5lZWRzIHRvIGJl
IGNoYW5nZWQgZnJvbSAzMiB0byA2NCBiaXQsIGNvbnN1bWluZyB0aGUgcmVzZXJ2ZWQgMzIgYml0
DQo+ID4gZmllbGQgdGhhdCBmb2xsb3dzIHRoZSByZXN1bHQgaW4gQ1FFIHN0cnVjdC4gU2luY2Ug
dGhlIGV4aXN0aW5nDQo+ID4gY29tbWFuZHMgYXJlIGV4cGVjdGVkIHRvIHJldHVybiBhIDMyIGJp
dCBMRSB2YWx1ZSwgdHdvIHNlcGFyYXRlDQo+ID4gdmFyaWFibGVzLCByZXN1bHQzMiBhbmQgcmVz
dWx0NjQsIGFyZSBub3cga2VwdCBpbiBhIHVuaW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QWpheSBKb3NoaSA8YWpheS5qb3NoaUB3ZGMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERtaXRy
eSBGb21pY2hldiA8ZG1pdHJ5LmZvbWljaGV2QHdkYy5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEts
YXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+DQo+IA0KPiBJIGtub3cgdGhhdCBJIFIt
YidlZCB0aGlzLCBidXQgY2FuIHRoaXMgYmUgbW92ZWQgdG8gdGhlIG5hbWVzcGFjZSB0eXBlcw0K
PiBwYXRjaCwgc2luY2UgdGhhdCBpcyB0aGUgVFAgdGhhdCBjaGFuZ2VzIHRoaXMuDQoNCllvdSBw
cm9iYWJseSBtZWFudCB0aGUgWk5TIHBhdGNoIHNpbmNlIHJlc3VsdDY0IGlzIGZpcnN0IHVzZWQg
dGhlcmUgdG8gcmV0dXJuDQpaQSBzdGFydGluZyBkYXRhIExCQS4gU3VyZSwgSSBjYW4gbW92ZSB0
aGlzIHN0dWZmIHRvIHRoYXQgcGF0Y2guDQoNCj4gDQo+IEFsc28sIEkgZG9uJ3QgdGhpbmsgd2Ug
c2hvdWxkIHRvdWNoIHRoZSB0cmFjaW5nIGluIHRoZSBibG9jayBkcml2ZXINCj4gc2luY2UgaXQg
aXMgbm90IGF3YXJlIG9mIG5hbWVzcGFjZSB0eXBlcy4NCg0KT2sNCg==

