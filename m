Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB4BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCEA21D7B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bFI4KEsV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lvRe6+Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCEA21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIx20-0005rG-7p
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=522d714e9=Dmitry.Fomichev@wdc.com>)
 id 1kIx13-0004ol-TR; Thu, 17 Sep 2020 12:44:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=522d714e9=Dmitry.Fomichev@wdc.com>)
 id 1kIx10-0002vg-M4; Thu, 17 Sep 2020 12:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600361052; x=1631897052;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=R2ji6OvlP81rSPXJu3ME1deJ8bze1YSZpwWLtATU/so=;
 b=bFI4KEsVEpcROszY5QrTIDj0S4eeW+wflPj9Ac33PAcwVlFdV58JEujh
 7qiYFyWnLctrSiB+SFI1u/X/m6+CWwzHdUe9zOeDIF88ki3LOjllEiDte
 zR2fxNGp5FZBjn01WbEHIPdp1t3AzPbUW9zU9uGMAmEkqFpjS1a6hKpMq
 4RxdpWVaFJohDZKrzjO3DkmjqCnoF3E13CswLiUhOmAt1rT/OSbk/DOvj
 uEpgtl85xJugCJCoLOir268ojqN+mEtimNhHG7luz51FC/cX6L4imlWsU
 ZU5E0Zs+VzA5YjNYaKEqdc/4WL7LJxaNvWNEMB1cEfjFT5xpJQFsgXHkZ w==;
IronPort-SDR: qZhVyP6phb6zP9lUO0d/4uS47eAbFQgTdBYCMkihdpdL42pxN2oBTyOH5XIX6DBzd0BBda0acI
 3itYpl42Z3+JUisifPRrIGuCqUtLV5lANGS+tuPAsNiBd+uySQH+NYVvf+AOa84ulCydZDCdNk
 ii8B/WcjCR3nOSiudvFU20AIqmAkgJqqAPAeN4HzUBCOLf1iaB/dnufXtOffNXexgx4zNjwziT
 RCcUmmM1yyboQDH1pInfWzOpT+jOoAFxUG0ayulxgWXXwICrxGHea+9Ko+0C3NfHAG6d/l2De7
 V3g=
X-IronPort-AV: E=Sophos;i="5.77,271,1596470400"; d="scan'208";a="250988382"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
 by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 00:44:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjMdMHe4B3deRbcV3k5y5j3HeYmO1ta9J+Ajwz0eQaSLgmPVdLRCtlPUu7xNxIialCaOlAcOuQwiQO4rVyEC2d7KAxsJf0/kJzJDt38MG10OpAlGAlPcK4N80yFr08hy4hbQGIKguHaRJzSlW9ySwvmQ+K8HkKQRuvLYiIdHJvl5Gwgj/NG5KWT2EQdIXNyarq3NbbhdHbMoX3Pd5GffvYBwkSNb2WnyFvsWzkn7cooze/lKovNYjDb0pmiN0G4ormNKa4VvfSzzRgVvQ82r6jScRdfdfDoOXNtNur98aXEIzDc5eX/Mtm14N7P4Hjn66pyWGtuRIbFf1YMjqDRS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2ji6OvlP81rSPXJu3ME1deJ8bze1YSZpwWLtATU/so=;
 b=Hk6cS5lMBBIZz1RjWggw9ZejlWqB/hegAyQJNROufdYiPjbTD47CaPfs+a5tnXaWZWqwPvuwQpS+qmPYg5WEQPzU00HfWjCTWoNkd80tVogxlSnXyINdJEi9pvg7T1IpbziWRPiLkNCFjxuolADOwWXK7JyQCPPzRFJ5zbEVe5yLXOL3OeGd8qEZlB48Vp4azNA8rl4nDAvpc0RlX7r2cRPjUFxwWzhfFd2FCDvfHp+RfqAEwIHChUIQUHnh43zOCrzhwPXvPd52HiZcqmQdDO62sWOK/FVPmd1d1HkWTAKSJcYhxsYET9XThPxsKBKxAD1/CFgEO6pGazo8wxrqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2ji6OvlP81rSPXJu3ME1deJ8bze1YSZpwWLtATU/so=;
 b=lvRe6+Bbthgd79CCwMOqCTSLVXtgmW+IdOX1NA2f4rU1ucd3e6tQSRAdMxq2wIQA0xYQRfooVeRxZWa/c21o6CqQOocn0+6RB8EsHlRRDwnJi3ZGOr3X4gXRV3iJD+CQZGkYylO5lvlEQ+cOasJFLSuLx2MWrpzIAxkILazk7Rs=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6206.namprd04.prod.outlook.com (2603:10b6:208:e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Thu, 17 Sep
 2020 16:44:03 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 16:44:03 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin
 Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng
 <fam@euphon.net>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@redhat.com>
Subject: RE: [PATCH 1/2] file-posix: Correctly read max_segments of SG nodes
Thread-Topic: [PATCH 1/2] file-posix: Correctly read max_segments of SG nodes
Thread-Index: AQHWcDH2jTZnewzgD06q3a4ZCKJhZKltCT+AgAABr4CAAABngIAAJ5RQ
Date: Thu, 17 Sep 2020 16:44:03 +0000
Message-ID: <MN2PR04MB5951128F548F519AC0E5B9A1E13E0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
 <20200811225122.17342-2-dmitry.fomichev@wdc.com>
 <808e395e-6f99-acdb-03dc-400f6bd32311@redhat.com>
 <ea4017fe0456a9c663f943f60f4572ecf8d0fe96.camel@redhat.com>
 <9f2614db9bcf570be9c9bcb0337126bc711ef432.camel@redhat.com>
In-Reply-To: <9f2614db9bcf570be9c9bcb0337126bc711ef432.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acad757e-eac3-4c74-0b7a-08d85b28e2ce
x-ms-traffictypediagnostic: MN2PR04MB6206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6206A5238B23A32051AB479EE13E0@MN2PR04MB6206.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWMdKCvpvCO2n8NWYoTZT433EdRwlSlcWzwcTpWeeVrkTiTyHlHP25ROPu8pW+w4Wr6t5bpsf5lu2ogevBUXpX1kPQTyloXD3TUtGoDNbxT1Wi/ePY4pFGlE1TBDjaOfi+4OOT18VEgxaE+/O1uxir3AWOL6yauv2y/65YZulj5NRQVxvMxD6YLRs7n5hZ765AtlIDvMq+7Y/ufO36mSy6xWRN2RaAXZLbcF3Q65JopL8GT/+ops+KYSXpH1BPdQE19MFApasIRbmru0+j99lM8rTvTSaxXL/NhuxjPHQX7ehNg1uGd5woqa3vCnacufB2nTuqRQ7ahFKgo4zuYGWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(52536014)(8936002)(33656002)(83380400001)(5660300002)(54906003)(110136005)(9686003)(478600001)(55016002)(8676002)(86362001)(7696005)(2906002)(26005)(4326008)(71200400001)(66946007)(316002)(6506007)(53546011)(76116006)(66446008)(64756008)(66556008)(66476007)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WUQPvH5nL3drXBkl50vJETEGjObokUuKdmfR0hdKSutrFWUCPtzbQidalnGYw5PcZuYqebEKpynJoOkKVqPHBW1tIzNXwNPRbqWK4V/cXlgsF4NsDu4OeHHU5idaiTMmxO7vqQ72v8k2ihXSmOaCA+NMcfjmV4I5PN6+vZnCPZleJvT6S78Mx+CHH5NTyYRMPiQ+OrnKYIBe19+M4q1QFb0JC1LHTkxZ8BRhcxOZsmg0omkNsohx0RDeb9xRdxIDA4Xgh/a4RUMd8/QLpV647k4mPg8twXRr9cpryw9W215qpXrbR82fFgrG+eHvtGUnvGGDnhz1k0Y0gCEERwVM4qSN/teZUa0wMK9TRbYETbnIPGOQvEDcH4n7zgPhFk4MwrFzNoaGACrU09M+ndirMdaUQ5WZKHHms8ml2uivdpQRwgrR9Jbo870eDHMdvQnhcQUZqNk49OksNCNMMOaQ/dAWwMgxKGlXmsdchOqDeQ5Tym+R+EaeZxkhRMWJtkI6EP24Sdrn2PmBVr4NeVj95yvY0fvu7qnfQQt7HEFV+/U8mvF0+aEP+Un8lpaKep5a4ZfS+Ox2BwPebyuY2zJiLMDVBxO7jL+roRZa4sO3K/axkwaXLC3pWCMk+lK4kKnVzi/oW40/gkhr2EoR6f9FZA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acad757e-eac3-4c74-0b7a-08d85b28e2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 16:44:03.2740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yt3PbMD9SwY/QhAHAFMFJLcQ4BASd1J1ijGFMvQarVtn00Rwl+2bC7Oflxf+uucIh5hFOirJjxzE0B82cYmG4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6206
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=522d714e9=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 12:44:05
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXhpbSBMZXZpdHNreSA8bWxl
dml0c2tAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxNywgMjAyMCA5
OjI0IEFNDQo+IFRvOiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPjsgRG1pdHJ5IEZvbWlj
aGV2DQo+IDxEbWl0cnkuRm9taWNoZXZAd2RjLmNvbT47IEtldmluIFdvbGYgPGt3b2xmQHJlZGhh
dC5jb20+OyBQYW9sbw0KPiBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgRmFtIFpoZW5n
IDxmYW1AZXVwaG9uLm5ldD47IFBoaWxpcHBlDQo+IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVk
aGF0LmNvbT4NCj4gQ2M6IEFsaXN0YWlyIEZyYW5jaXMgPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNv
bT47IERhbWllbiBMZSBNb2FsDQo+IDxEYW1pZW4uTGVNb2FsQHdkYy5jb20+OyBxZW11LWJsb2Nr
QG5vbmdudS5vcmc7IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAxLzJdIGZpbGUtcG9zaXg6IENvcnJlY3RseSByZWFkIG1heF9zZWdtZW50cyBvZiBTRw0K
PiBub2Rlcw0KPiANCj4gT24gVGh1LCAyMDIwLTA5LTE3IGF0IDE2OjIyICswMzAwLCBNYXhpbSBM
ZXZpdHNreSB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDktMTcgYXQgMTU6MTYgKzAyMDAsIE1h
eCBSZWl0eiB3cm90ZToNCj4gPiA+IE9uIDEyLjA4LjIwIDAwOjUxLCBEbWl0cnkgRm9taWNoZXYg
d3JvdGU6DQo+ID4gPiA+IElmIHNjc2ktZ2VuZXJpYyBkcml2ZXIgaXMgaW4gdXNlLCBhbiBTRyBu
b2RlIGNhbiBiZSBzcGVjaWZpZWQgaW4NCj4gPiA+ID4gdGhlIGNvbW1hbmQgbGluZSBpbiBwbGFj
ZSBvZiBhIHJlZ3VsYXIgU0NTSSBkZXZpY2UuIEluIHRoaXMgY2FzZSwNCj4gPiA+ID4gc2dfZ2V0
X21heF9zZWdtZW50cygpIGZhaWxzIHRvIG9wZW4gbWF4X3NlZ21lbnRzIGVudHJ5IGluIHN5c2Zz
DQo+ID4gPiA+IGJlY2F1c2UgL2Rldi9zZ1ggaXMgYSBjaGFyYWN0ZXIgZGV2aWNlLiBBcyB0aGUg
cmVzdWx0LCB0aGUgbWF4aW11bQ0KPiA+ID4gPiB0cmFuc2ZlciBzaXplIGZvciB0aGUgZGV2aWNl
IG1heSBiZSBjYWxjdWxhdGVkIGluY29ycmVjdGx5LCBjYXVzaW5nDQo+ID4gPiA+IEkvTyBlcnJv
cnMgaWYgdGhlIG1heGltdW0gdHJhbnNmZXIgc2l6ZSBhdCB0aGUgZ3Vlc3QgZW5kcyB1cCB0byBi
ZQ0KPiA+ID4gPiBsYXJnZXIgY29tcGFyZWQgdG8gdGhlIGhvc3QuDQo+ID4gPiA+DQo+ID4gPiA+
IENoZWNrIHN5c3RlbSBkZXZpY2UgdHlwZSBpbiBzZ19nZXRfbWF4X3NlZ21lbnRzKCkgYW5kIHJl
YWQgdGhlDQo+ID4gPiA+IG1heF9zZWdtZW50cyB2YWx1ZSBkaWZmZXJlbnRseSBpZiBpdCBpcyBh
IGNoYXJhY3RlciBkZXZpY2UuDQo+ID4gPiA+DQo+ID4gPiA+IFJlcG9ydGVkLWJ5OiBKb2hhbm5l
cyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiA+ID4gPiBGaXhlczog
OTEwM2YxY2ViNDY2MTRiMTUwYmNiYzNjOWE0ZmJjNzJiNDdmZWRjYw0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBEbWl0cnkgRm9taWNoZXYgPGRtaXRyeS5mb21pY2hldkB3ZGMuY29tPg0KPiA+ID4g
PiAtLS0NCj4gPiA+ID4gIGJsb2NrL2ZpbGUtcG9zaXguYyB8IDU1ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMzIgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9ibG9jay9maWxlLXBvc2l4LmMgYi9ibG9jay9maWxlLXBvc2l4LmMNCj4gPiA+
ID4gaW5kZXggMDk0ZTNiMDIxMi4uZjllMjQyNGU4ZiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYmxv
Y2svZmlsZS1wb3NpeC5jDQo+ID4gPiA+ICsrKyBiL2Jsb2NrL2ZpbGUtcG9zaXguYw0KPiA+ID4g
PiBAQCAtMTEwOCw2ICsxMTA4LDcgQEAgc3RhdGljIGludCBzZ19nZXRfbWF4X3NlZ21lbnRzKGlu
dCBmZCkNCj4gPiA+ID4gICAgICBpbnQgcmV0Ow0KPiA+ID4gPiAgICAgIGludCBzeXNmZCA9IC0x
Ow0KPiA+ID4gPiAgICAgIGxvbmcgbWF4X3NlZ21lbnRzOw0KPiA+ID4gPiArICAgIHVuc2lnbmVk
IGludCBtYXhfc2VnczsNCj4gPiA+ID4gICAgICBzdHJ1Y3Qgc3RhdCBzdDsNCj4gPiA+ID4NCj4g
PiA+ID4gICAgICBpZiAoZnN0YXQoZmQsICZzdCkpIHsNCj4gPiA+ID4gQEAgLTExMTUsMzAgKzEx
MTYsMzggQEAgc3RhdGljIGludCBzZ19nZXRfbWF4X3NlZ21lbnRzKGludCBmZCkNCj4gPiA+ID4g
ICAgICAgICAgZ290byBvdXQ7DQo+ID4gPiA+ICAgICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAtICAg
IHN5c2ZzcGF0aCA9DQo+IGdfc3RyZHVwX3ByaW50ZigiL3N5cy9kZXYvYmxvY2svJXU6JXUvcXVl
dWUvbWF4X3NlZ21lbnRzIiwNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbWFqb3Ioc3Quc3RfcmRldiksIG1pbm9yKHN0LnN0X3JkZXYpKTsNCj4gPiA+ID4gLSAgICBz
eXNmZCA9IG9wZW4oc3lzZnNwYXRoLCBPX1JET05MWSk7DQo+ID4gPiA+IC0gICAgaWYgKHN5c2Zk
ID09IC0xKSB7DQo+ID4gPiA+IC0gICAgICAgIHJldCA9IC1lcnJubzsNCj4gPiA+ID4gLSAgICAg
ICAgZ290byBvdXQ7DQo+ID4gPiA+ICsgICAgaWYgKFNfSVNCTEsoc3Quc3RfbW9kZSkpIHsNCj4g
PiA+ID4gKyAgICAgICAgc3lzZnNwYXRoID0NCj4gZ19zdHJkdXBfcHJpbnRmKCIvc3lzL2Rldi9i
bG9jay8ldToldS9xdWV1ZS9tYXhfc2VnbWVudHMiLA0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbWFqb3Ioc3Quc3RfcmRldiksIG1pbm9yKHN0LnN0X3JkZXYp
KTsNCj4gPiA+DQo+ID4gPiBTb3VuZHMgcmVhc29uYWJsZSwgYnV0IHRoaXMgZnVuY3Rpb24gaXMg
KG5hdHVyYWxseSkgb25seSBjYWxsZWQgaWYNCj4gPiA+IGJzLT5zZyBpcyB0cnVlLCB3aGljaCBp
cyBzZXQgYnkgaGRldl9pc19zZygpLCB3aGljaCByZXR1cm5zIHRydWUgb25seSBpZg0KPiA+ID4g
dGhlIGRldmljZSBmaWxlIGlzIGEgY2hhcmFjdGVyIGRldmljZS4NCj4gPiA+DQo+ID4gPiBTbyBp
cyB0aGlzIHBhdGggZXZlciB0YWtlbiwgb3IgY2FuIHdlIGp1c3QgcmVwbGFjZSBpdCBhbGwgd2l0
aCB0aGUgaW9jdGw/DQo+ID4gPg0KPiA+ID4gKEJlZm9yZSA4NjdlY2NmZWQ4NCwgdGhpcyBmdW5j
dGlvbiB3YXMgdXNlZCBmb3IgYWxsIGhvc3QgZGV2aWNlcywgd2hpY2gNCj4gPiA+IG1pZ2h0IGV4
cGxhaW4gd2h5IHRoZSBjb2RlIGV2ZW4gZXhpc3RzLikNCj4gPiA+DQo+ID4gPiBNYXgNCj4gPg0K
PiA+IEkgaGF2ZSBhbm90aGVyIHByb3Bvc2FsIHdoaWNoIEkgYW0gY3VycmVudGx5IGV2YWx1YXRp
bmcuDQo+ID4NCj4gPiBIb3cgYWJvdXQgd2UgZHJvcCBhbGwgdGhlIFNHX0lPIGxpbWl0cyBjb2Rl
IGFsbHRvZ2hlciBmcm9tIHRoZSByYXcgZHJpdmVyLA0KPiBhbmQNCj4gPiBpbnN0ZWFkIGp1c3Qg
bGV0IHRoZSBzY3NpIGRyaXZlcnMgKHNjc2ktYmxvY2sgYW5kIHNjc2ktZ2VuZXJpYykgcXVlcnkN
Cj4gPiB0aGUgZGV2aWNlIGRpcmVjdGx5LCBzaW5jZSBJIGRvbid0IHRoaW5rIHRoYXQgdGhlIGtl
cm5lbCAoSSB3aWxsIGRvdWJsZSBjaGVjaw0KPiB0aGlzKT8NCj4gDQo+IEkgaGl0IHNlbmQgdG9v
IHNvb24uIEkgbWVhbiBJIGRvbid0IHRoaW5rIHRoYXQgdGhlIGtlcm5lbCBpbXBvc2VzIGl0cyBv
d24gbGltaXRzDQo+IG9uIFNHX0lPLg0KPiANCg0KV2hlbiBJIHdhcyBtYWtpbmcgdGhlIGZpeCwg
SSBoYWQgYSBmZWVsaW5nIHRoYXQgdGhpcyBjb2RlIHNob3VsZCBiZSBtb3ZlZA0Kc29tZXBsYWNl
IGVsc2Ugd2hlcmUgaXQgY291bGQgYmUgY2FsbGVkIGJvdGggZm9yIGJsb2NrIGRldmljZXMgYW5k
IHNnIG5vZGVzLA0KYnV0IHRoYXQgd291bGQgbWFrZSB0aGUgcGF0Y2ggbW9yZSBpbnRydXNpdmUu
DQoNCk1heGltLCBsb29rcyBsaWtlIHlvdSBhcmUgb24gdG9wIG9mIHRoaXMgcHJvYmxlbSBhbmQg
eW91ciBhcHByb2FjaCBzb3VuZHMNCnNlbnNpYmxlIHRvbyBtZS4gSnVzdCBGWUksIGl0IGlzIGFs
c28gcG9zc2libGUgdG8gYXZvaWQgdXNpbmcgU0dfR0VUX1NHX1RBQkxFU0laRQ0KaW9jdGwgYW5k
IHJlbHkgZW50aXJlbHkgb24gc3lzZnMsIGJ1dCB0aGUgY29kZSBnZXRzIGEgYml0IG1vcmUgY29t
cGxpY2F0ZWQgKHNlZSBiZWxvdykNCg0KQ2hlZXJzLA0KRG1pdHJ5DQoNCi0tLSBhL2Jsb2NrL2Zp
bGUtcG9zaXguYw0KKysrIGIvYmxvY2svZmlsZS1wb3NpeC5jDQpAQCAtMTExMCw2ICsxMTEwLDgg
QEAgc3RhdGljIGludCBzZ19nZXRfbWF4X3NlZ21lbnRzKGludCBmZCkNCiAgICAgY2hhciBidWZb
MzJdOw0KICAgICBjb25zdCBjaGFyICplbmQ7DQogICAgIGNoYXIgKnN5c2ZzcGF0aCA9IE5VTEw7
DQorICAgIHN0cnVjdCBkaXJlbnQgKmJsa2RldiA9IE5VTEw7DQorICAgIERJUiAqZGlyID0gTlVM
TDsNCiAgICAgaW50IHJldDsNCiAgICAgaW50IHN5c2ZkID0gLTE7DQogICAgIGxvbmcgbWF4X3Nl
Z21lbnRzOw0KQEAgLTExMjAsOCArMTEyMiwzMCBAQCBzdGF0aWMgaW50IHNnX2dldF9tYXhfc2Vn
bWVudHMoaW50IGZkKQ0KICAgICAgICAgZ290byBvdXQ7DQogICAgIH0NCiANCi0gICAgc3lzZnNw
YXRoID0gZ19zdHJkdXBfcHJpbnRmKCIvc3lzL2Rldi9ibG9jay8ldToldS9xdWV1ZS9tYXhfc2Vn
bWVudHMiLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFqb3Ioc3Quc3RfcmRl
diksIG1pbm9yKHN0LnN0X3JkZXYpKTsNCisgICAgaWYgKFNfSVNCTEsoc3Quc3RfbW9kZSkpIHsN
CisgICAgICAgIHN5c2ZzcGF0aCA9IGdfc3RyZHVwX3ByaW50ZigiL3N5cy9kZXYvYmxvY2svJXU6
JXUvcXVldWUvbWF4X3NlZ21lbnRzIiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBtYWpvcihzdC5zdF9yZGV2KSwgbWlub3Ioc3Quc3RfcmRldikpOw0KKyAgICB9IGVsc2Ug
ew0KKyAgICAgICAgc3lzZnNwYXRoID0gZ19zdHJkdXBfcHJpbnRmKCIvc3lzL2Rldi9jaGFyLyV1
OiV1L2RldmljZS9ibG9jayIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bWFqb3Ioc3Quc3RfcmRldiksIG1pbm9yKHN0LnN0X3JkZXYpKTsNCisgICAgICAgIGRpciA9IG9w
ZW5kaXIoc3lzZnNwYXRoKTsNCisgICAgICAgIGlmICghZGlyKSB7DQorICAgICAgICAgICAgcmV0
ID0gLWVycm5vOw0KKyAgICAgICAgICAgIGdvdG8gb3V0Ow0KKyAgICAgICAgfQ0KKyAgICAgICAg
ZG8gew0KKyAgICAgICAgICAgIGJsa2RldiA9IHJlYWRkaXIoZGlyKTsNCisgICAgICAgICAgICBp
ZiAoIWJsa2Rldikgew0KKyAgICAgICAgICAgICAgICByZXQgPSAtZXJybm87DQorICAgICAgICAg
ICAgICAgIGNsb3NlZGlyKGRpcik7DQorICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KKyAgICAg
ICAgICAgIH0NCisgICAgICAgIH0gd2hpbGUgKCpibGtkZXYtPmRfbmFtZSA9PSAnLicpOw0KKyAg
ICAgICAgZ19mcmVlKHN5c2ZzcGF0aCk7DQorICAgICAgICBzeXNmc3BhdGggPSBnX3N0cmR1cF9w
cmludGYoIi9zeXMvYmxvY2svJXMvcXVldWUvbWF4X3NlZ21lbnRzIiwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBibGtkZXYtPmRfbmFtZSk7DQorICAgICAgICBjbG9zZWRp
cihkaXIpOw0KKyAgICB9DQogICAgIHN5c2ZkID0gb3BlbihzeXNmc3BhdGgsIE9fUkRPTkxZKTsN
CiAgICAgaWYgKHN5c2ZkID09IC0xKSB7DQogICAgICAgICByZXQgPSAtZXJybm87DQoNCj4gQmVz
dCByZWdhcmRzLA0KPiAJTWF4aW0gTGV2aXRza3kNCj4gPg0KPiA+DQo+ID4gQmVzdCByZWdhcmRz
LA0KPiA+IAlNYXhpbSBMZXZpdHNreQ0KPiA+DQo+ID4NCj4gDQoNCg==

