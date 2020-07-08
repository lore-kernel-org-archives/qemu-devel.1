Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD7C2065D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fNSPn8Lt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MNTGqMb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD7C2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFeA-0006ca-W1
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFdL-0005zq-Sk; Wed, 08 Jul 2020 15:21:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFdJ-0002KV-Ec; Wed, 08 Jul 2020 15:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594236089; x=1625772089;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HjU9enzYHSu205AWPgovWKEaUOqdJzMXeeahlDahVug=;
 b=fNSPn8LtKms8M4j+zA1jBfQ0OcRkTkPHnnx2E0laUS3JaB1XJu9kTaKk
 Y26bjHloKqb3E1HY8wN0Tskj+K1beJBHQoq1iQfV8H6wEwAqC7CyCVXwO
 N1RDukpYoySns4p1/T8sapxMtQxDlIY1QcFRwOqo+W9e8mmFQwsJ+4Abc
 BxSHP3iA/dsp1wCk78zCV1hM+BGn4LqieaxU5AHXIie9r6j2cG+lf+93p
 VxUo7igg4qRN6h5QuHb46vEhtxjmn5gm0NQZ964LUw8npR1mgYVUOONY+
 28b1wGmNQYO6rXXn16cfbGhVn5c5LR2+EjuOOq5GRf60879uPLon3SGfX g==;
IronPort-SDR: pfjWqmdJ2SVfyIboG1lEheoNtRRTnv2bwDluqnJiRIE/YpiLDrZEh6TLYnnVeXhnL83n40PXLh
 ttdGXru/ADVZ2hjqtu+9NDgTUBHNpW5fXWkTHm4hUE+kPvuim9NQ5aaoAb9MqYpTYCkInaNeY9
 wPkI1oHDV18gEh+YRCTPXXyu9uKU7P9YX+RBAaDHe9bg6xDHkV659FfA9/0kotrpD1wAUXhVPn
 iXfUHkwzP2jvkLBbMEX8qqpong7GpB/4ZVZywdnrThxijBqdrMEgrLpbSlxG3N8C31alDIUCgn
 e9I=
X-IronPort-AV: E=Sophos;i="5.75,328,1589212800"; d="scan'208";a="251195225"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 03:21:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll3fNwnhz0jWkucFOeroBMny2x/bQnWNOVyliFX9m4+hO05ACi8EUyENvQEBg/0Z8zoIcZgJjx/OXfvAvqw+2pWJNDq99irpnFKp9Akir8i+TTfeQ14/CsZiVZOtpYANAa7vhQGwDIu7xtnDachRjThqZxGJrFqOo2rBCMqyIj1Ghi2ptp9p2kKTm9DSbx2snAdd4YbzbfvOJ8PEKe1HJkMTNbsP9VImRBdwcoh4MgI/jxmk8WMPAo1W2mK2HlwSCqyCEjsc8ijmspMXq+0FyuezONaxF+iYrNB7FEGcn8vX2KINW4BmPzo/5fUPeArXHB52rxhQ5ODLLxNt+SJKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjU9enzYHSu205AWPgovWKEaUOqdJzMXeeahlDahVug=;
 b=ELMziicUZ7S+p1bgauVpfMlqlk/wIp8AssEK9aEfakF098lpj8UTMR7fT7ajXRZBNLxUEHIlLd39bS17rhJSznWjSdk5ph/zauE0ikpMaDp4OMq6MMnGI1dnQlIF3h3GffniNC6C91o8McPpuJmR7gkyAODHnhZKroj0Gr3lLFWG6sdkyCMg8f4PXNC99DIRRtcp5xrMcFfw2j1s082HjwBguTE8N6GEgnyJSK63+mLmNPYIG01HMhTyR+uedgdCsJhjKza/1Khi4se0K7G5QOtkTNWBEqv0DTzEJTCt8AVDsSfes+YBPu7kwGZIXGiCXHFQ2pF2bEciWml/xjiiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjU9enzYHSu205AWPgovWKEaUOqdJzMXeeahlDahVug=;
 b=MNTGqMb5POePM3tyO3Y9q92QPykbnW6++COMko9tiva4GRlJBnnJ0v97jTQBMvNEZOnsw93z4qyiwFU6Za6t3N19v3C+4E3lC26fofoLk+HtyRTJSqWN1h7hg4MPzPfa2LKFYuH1wjrTGPDSCjsnOYIGIX2xQZ00lCdaoTlLPGg=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6144.namprd04.prod.outlook.com (2603:10b6:208:e1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 19:21:23 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 19:21:23 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 03/18] hw/block/nvme: additional tracing
Thread-Topic: [PATCH v3 03/18] hw/block/nvme: additional tracing
Thread-Index: AQHWU1yUXavKtUKgq0OHvbPnlFPnYqj+EzQA
Date: Wed, 8 Jul 2020 19:21:23 +0000
Message-ID: <ccc8f66462ffa40c60cf5f11408b7099302ae7b5.camel@wdc.com>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-4-its@irrelevant.dk>
In-Reply-To: <20200706061303.246057-4-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [100.35.204.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7590b49c-1327-4459-b9cc-08d823741a13
x-ms-traffictypediagnostic: MN2PR04MB6144:
x-microsoft-antispam-prvs: <MN2PR04MB61443CB7A63ADD386F6E3899E1670@MN2PR04MB6144.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:352;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2Md7tzAOyxdXWxxfk8KtS9NUqFnpVwI2Mi5N4csuwZbBv/rx3gLlngWGTuIWaooDH7dEVd+IVPEGghbgh1zKMas8VM1Pi4aSIdHF9nTssbXxIye8/Ucmiwd6N39wC989desOBoK8+xTRGi3yVmvFrSICOqNlxTiyB0f0OBh/ej5xN4rocHZxXEB6E54GLPb0sA6+QNKnBt2bvRQyG/iL+L8scHr0l5BgfQ3Y+1x9mHcPKna1zKUemMIVsVw6TVc1WSeeiRSZxmv6IC3uqNpr/1KOKZz91YyZvgy0wPLmG2cXfZSUtVplorY5iYMVV1Bl39qhR0mP4s1bkOMOZNm2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(2906002)(110136005)(498600001)(54906003)(186003)(71200400001)(6486002)(4326008)(83380400001)(6512007)(6506007)(26005)(7416002)(8936002)(5660300002)(76116006)(66476007)(66556008)(64756008)(8676002)(86362001)(2616005)(66446008)(66946007)(36756003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: HP4+oL61+wc+MS5dfqHRKwPVQEcEupBC4i57ufT7kzgv8mDPlIVLYNFNivoiKoZVO5zL7HsgQUo0ywKneysvnweUgS8gb+6BglF4IhzzC6htyZ2Bb7SEATUKqGbe4tarxxl0oyNXWXyZ9jHW24vdgXj9VPRVY76ECfyhAvfWK7n8T/KfTZH0LKd4kmA4ZNj1qZbspS8nr5mwPuNbB4mWx1Ml1WSrjSBn6qaIvWLAqNzeqoC5Mvs2GlZSTBsWu1FagmLWrwSvmjmY61z8+bNxcO9hm6GcTtMeORj48YU9KfKUM8mvzUuKfClYqEuaK4naBJFXVuTCvcBXuelkgUZRUDuZXASFqa549WwA+fp+GTfILSqGMQB2GKiHhA3ZBKKL3av2zZj6OA/QuUGEX+HDzgeW2xob0RkBRe4vbRSm7/Ge1F7lG2YvuRvMKGDbt3DpUjyt7+pexgROikbTQU3dAdjX3XOFsFCbIS2rDDoR+/DQ/NSEPLktKsxronzvTnNE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D43054803E7F4D4594105AD5471EC2E7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7590b49c-1327-4459-b9cc-08d823741a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 19:21:23.1375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDIhXHnbmyiXOTEJ+bFjymGhuqlnFQwZDPjzEtozwVvLFFJEua0Td/4kqLjRSvVf+FXUYxXdFJPoQ91w5U4WTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6144
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=45148fd95=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:21:26
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IERtaXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWlj
aGV2QHdkYy5jb20+DQoNCj4gT24gTW9uLCAyMDIwLTA3LTA2IGF0IDA4OjEyICswMjAwLCBLbGF1
cyBKZW5zZW4gd3JvdGU6DQo+IEZyb206IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5j
b20+DQo+IA0KPiBBZGQgdmFyaW91cyBhZGRpdGlvbmFsIHRyYWNpbmcgYW5kIHN0cmVhbWxpbmUg
bnZtZV9pZGVudGlmeV9ucyBhbmQNCj4gbnZtZV9pZGVudGlmeV9uc2xpc3QgKHRoZXkgZG8gbm90
IG5lZWQgdG8gcmVwZWF0IHRoZSBjb21tYW5kLCBpdCBpcw0KPiBhbHJlYWR5IGluIHRoZSB0cmFj
ZSBuYW1lKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ft
c3VuZy5jb20+DQo+IC0tLQ0KPiAgaHcvYmxvY2svbnZtZS5jICAgICAgIHwgMzMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBody9ibG9jay90cmFjZS1ldmVudHMgfCAxMyAr
KysrKysrKysrKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2svbnZtZS5jIGIvaHcvYmxvY2sv
bnZtZS5jDQo+IGluZGV4IDc2NmNkNWIzM2JiMS4uMDllZjU0ZDc3MWM0IDEwMDY0NA0KPiAtLS0g
YS9ody9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcvYmxvY2svbnZtZS5jDQo+IEBAIC02OSw2ICs2
OSwyMCBAQA0KPiAgDQo+ICBzdGF0aWMgdm9pZCBudm1lX3Byb2Nlc3Nfc3Eodm9pZCAqb3BhcXVl
KTsNCj4gIA0KPiArc3RhdGljIHVpbnQxNl90IG52bWVfY2lkKE52bWVSZXF1ZXN0ICpyZXEpDQo+
ICt7DQo+ICsgICAgaWYgKCFyZXEpIHsNCj4gKyAgICAgICAgcmV0dXJuIDB4ZmZmZjsNCj4gKyAg
ICB9DQo+ICsNCj4gKyAgICByZXR1cm4gbGUxNl90b19jcHUocmVxLT5jcWUuY2lkKTsNCj4gK30N
Cj4gKw0KPiArc3RhdGljIHVpbnQxNl90IG52bWVfc3FpZChOdm1lUmVxdWVzdCAqcmVxKQ0KPiAr
ew0KPiArICAgIHJldHVybiBsZTE2X3RvX2NwdShyZXEtPnNxLT5zcWlkKTsNCj4gK30NCj4gKw0K
PiAgc3RhdGljIGJvb2wgbnZtZV9hZGRyX2lzX2NtYihOdm1lQ3RybCAqbiwgaHdhZGRyIGFkZHIp
DQo+ICB7DQo+ICAgICAgaHdhZGRyIGxvdyA9IG4tPmN0cmxfbWVtLmFkZHI7DQo+IEBAIC0zMzEs
NiArMzQ1LDggQEAgc3RhdGljIHZvaWQgbnZtZV9wb3N0X2NxZXModm9pZCAqb3BhcXVlKQ0KPiAg
c3RhdGljIHZvaWQgbnZtZV9lbnF1ZXVlX3JlcV9jb21wbGV0aW9uKE52bWVDUXVldWUgKmNxLCBO
dm1lUmVxdWVzdCAqcmVxKQ0KPiAgew0KPiAgICAgIGFzc2VydChjcS0+Y3FpZCA9PSByZXEtPnNx
LT5jcWlkKTsNCj4gKyAgICB0cmFjZV9wY2lfbnZtZV9lbnF1ZXVlX3JlcV9jb21wbGV0aW9uKG52
bWVfY2lkKHJlcSksIGNxLT5jcWlkLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmVxLT5zdGF0dXMpOw0KPiAgICAgIFFUQUlMUV9SRU1PVkUoJnJlcS0+c3Et
Pm91dF9yZXFfbGlzdCwgcmVxLCBlbnRyeSk7DQo+ICAgICAgUVRBSUxRX0lOU0VSVF9UQUlMKCZj
cS0+cmVxX2xpc3QsIHJlcSwgZW50cnkpOw0KPiAgICAgIHRpbWVyX21vZChjcS0+dGltZXIsIHFl
bXVfY2xvY2tfZ2V0X25zKFFFTVVfQ0xPQ0tfVklSVFVBTCkgKyA1MDApOw0KPiBAQCAtMzQzLDYg
KzM1OSw4IEBAIHN0YXRpYyB2b2lkIG52bWVfcndfY2Iodm9pZCAqb3BhcXVlLCBpbnQgcmV0KQ0K
PiAgICAgIE52bWVDdHJsICpuID0gc3EtPmN0cmw7DQo+ICAgICAgTnZtZUNRdWV1ZSAqY3EgPSBu
LT5jcVtzcS0+Y3FpZF07DQo+ICANCj4gKyAgICB0cmFjZV9wY2lfbnZtZV9yd19jYihudm1lX2Np
ZChyZXEpKTsNCj4gKw0KPiAgICAgIGlmICghcmV0KSB7DQo+ICAgICAgICAgIGJsb2NrX2FjY3Rf
ZG9uZShibGtfZ2V0X3N0YXRzKG4tPmNvbmYuYmxrKSwgJnJlcS0+YWNjdCk7DQo+ICAgICAgICAg
IHJlcS0+c3RhdHVzID0gTlZNRV9TVUNDRVNTOw0KPiBAQCAtMzc4LDYgKzM5Niw4IEBAIHN0YXRp
YyB1aW50MTZfdCBudm1lX3dyaXRlX3plcm9zKE52bWVDdHJsICpuLCBOdm1lTmFtZXNwYWNlICpu
cywgTnZtZUNtZCAqY21kLA0KPiAgICAgIHVpbnQ2NF90IG9mZnNldCA9IHNsYmEgPDwgZGF0YV9z
aGlmdDsNCj4gICAgICB1aW50MzJfdCBjb3VudCA9IG5sYiA8PCBkYXRhX3NoaWZ0Ow0KPiAgDQo+
ICsgICAgdHJhY2VfcGNpX252bWVfd3JpdGVfemVyb2VzKG52bWVfY2lkKHJlcSksIHNsYmEsIG5s
Yik7DQo+ICsNCj4gICAgICBpZiAodW5saWtlbHkoc2xiYSArIG5sYiA+IG5zLT5pZF9ucy5uc3pl
KSkgew0KPiAgICAgICAgICB0cmFjZV9wY2lfbnZtZV9lcnJfaW52YWxpZF9sYmFfcmFuZ2Uoc2xi
YSwgbmxiLCBucy0+aWRfbnMubnN6ZSk7DQo+ICAgICAgICAgIHJldHVybiBOVk1FX0xCQV9SQU5H
RSB8IE5WTUVfRE5SOw0KPiBAQCAtNDQ1LDYgKzQ2NSw4IEBAIHN0YXRpYyB1aW50MTZfdCBudm1l
X2lvX2NtZChOdm1lQ3RybCAqbiwgTnZtZUNtZCAqY21kLCBOdm1lUmVxdWVzdCAqcmVxKQ0KPiAg
ICAgIE52bWVOYW1lc3BhY2UgKm5zOw0KPiAgICAgIHVpbnQzMl90IG5zaWQgPSBsZTMyX3RvX2Nw
dShjbWQtPm5zaWQpOw0KPiAgDQo+ICsgICAgdHJhY2VfcGNpX252bWVfaW9fY21kKG52bWVfY2lk
KHJlcSksIG5zaWQsIG52bWVfc3FpZChyZXEpLCBjbWQtPm9wY29kZSk7DQo+ICsNCj4gICAgICBp
ZiAodW5saWtlbHkobnNpZCA9PSAwIHx8IG5zaWQgPiBuLT5udW1fbmFtZXNwYWNlcykpIHsNCj4g
ICAgICAgICAgdHJhY2VfcGNpX252bWVfZXJyX2ludmFsaWRfbnMobnNpZCwgbi0+bnVtX25hbWVz
cGFjZXMpOw0KPiAgICAgICAgICByZXR1cm4gTlZNRV9JTlZBTElEX05TSUQgfCBOVk1FX0ROUjsN
Cj4gQEAgLTg3Niw2ICs4OTgsOCBAQCBzdGF0aWMgdWludDE2X3QgbnZtZV9zZXRfZmVhdHVyZShO
dm1lQ3RybCAqbiwgTnZtZUNtZCAqY21kLCBOdm1lUmVxdWVzdCAqcmVxKQ0KPiAgDQo+ICBzdGF0
aWMgdWludDE2X3QgbnZtZV9hZG1pbl9jbWQoTnZtZUN0cmwgKm4sIE52bWVDbWQgKmNtZCwgTnZt
ZVJlcXVlc3QgKnJlcSkNCj4gIHsNCj4gKyAgICB0cmFjZV9wY2lfbnZtZV9hZG1pbl9jbWQobnZt
ZV9jaWQocmVxKSwgbnZtZV9zcWlkKHJlcSksIGNtZC0+b3Bjb2RlKTsNCj4gKw0KPiAgICAgIHN3
aXRjaCAoY21kLT5vcGNvZGUpIHsNCj4gICAgICBjYXNlIE5WTUVfQURNX0NNRF9ERUxFVEVfU1E6
DQo+ICAgICAgICAgIHJldHVybiBudm1lX2RlbF9zcShuLCBjbWQpOw0KPiBAQCAtMTIwNCw2ICsx
MjI4LDggQEAgc3RhdGljIHVpbnQ2NF90IG52bWVfbW1pb19yZWFkKHZvaWQgKm9wYXF1ZSwgaHdh
ZGRyIGFkZHIsIHVuc2lnbmVkIHNpemUpDQo+ICAgICAgdWludDhfdCAqcHRyID0gKHVpbnQ4X3Qg
Kikmbi0+YmFyOw0KPiAgICAgIHVpbnQ2NF90IHZhbCA9IDA7DQo+ICANCj4gKyAgICB0cmFjZV9w
Y2lfbnZtZV9tbWlvX3JlYWQoYWRkcik7DQo+ICsNCj4gICAgICBpZiAodW5saWtlbHkoYWRkciAm
IChzaXplb2YodWludDMyX3QpIC0gMSkpKSB7DQo+ICAgICAgICAgIE5WTUVfR1VFU1RfRVJSKHBj
aV9udm1lX3ViX21taW9yZF9taXNhbGlnbmVkMzIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICJNTUlPIHJlYWQgbm90IDMyLWJpdCBhbGlnbmVkLCINCj4gQEAgLTEyNzMsNiArMTI5OSw4IEBA
IHN0YXRpYyB2b2lkIG52bWVfcHJvY2Vzc19kYihOdm1lQ3RybCAqbiwgaHdhZGRyIGFkZHIsIGlu
dCB2YWwpDQo+ICAgICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAgIH0NCj4gIA0KPiArICAg
ICAgICB0cmFjZV9wY2lfbnZtZV9tbWlvX2Rvb3JiZWxsX2NxKGNxLT5jcWlkLCBuZXdfaGVhZCk7
DQo+ICsNCj4gICAgICAgICAgc3RhcnRfc3FzID0gbnZtZV9jcV9mdWxsKGNxKSA/IDEgOiAwOw0K
PiAgICAgICAgICBjcS0+aGVhZCA9IG5ld19oZWFkOw0KPiAgICAgICAgICBpZiAoc3RhcnRfc3Fz
KSB7DQo+IEBAIC0xMzExLDYgKzEzMzksOCBAQCBzdGF0aWMgdm9pZCBudm1lX3Byb2Nlc3NfZGIo
TnZtZUN0cmwgKm4sIGh3YWRkciBhZGRyLCBpbnQgdmFsKQ0KPiAgICAgICAgICAgICAgcmV0dXJu
Ow0KPiAgICAgICAgICB9DQo+ICANCj4gKyAgICAgICAgdHJhY2VfcGNpX252bWVfbW1pb19kb29y
YmVsbF9zcShzcS0+c3FpZCwgbmV3X3RhaWwpOw0KPiArDQo+ICAgICAgICAgIHNxLT50YWlsID0g
bmV3X3RhaWw7DQo+ICAgICAgICAgIHRpbWVyX21vZChzcS0+dGltZXIsIHFlbXVfY2xvY2tfZ2V0
X25zKFFFTVVfQ0xPQ0tfVklSVFVBTCkgKyA1MDApOw0KPiAgICAgIH0NCj4gQEAgLTEzMjAsNiAr
MTM1MCw5IEBAIHN0YXRpYyB2b2lkIG52bWVfbW1pb193cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRk
ciBhZGRyLCB1aW50NjRfdCBkYXRhLA0KPiAgICAgIHVuc2lnbmVkIHNpemUpDQo+ICB7DQo+ICAg
ICAgTnZtZUN0cmwgKm4gPSAoTnZtZUN0cmwgKilvcGFxdWU7DQo+ICsNCj4gKyAgICB0cmFjZV9w
Y2lfbnZtZV9tbWlvX3dyaXRlKGFkZHIsIGRhdGEpOw0KPiArDQo+ICAgICAgaWYgKGFkZHIgPCBz
aXplb2Yobi0+YmFyKSkgew0KPiAgICAgICAgICBudm1lX3dyaXRlX2JhcihuLCBhZGRyLCBkYXRh
LCBzaXplKTsNCj4gICAgICB9IGVsc2UgaWYgKGFkZHIgPj0gMHgxMDAwKSB7DQo+IGRpZmYgLS1n
aXQgYS9ody9ibG9jay90cmFjZS1ldmVudHMgYi9ody9ibG9jay90cmFjZS1ldmVudHMNCj4gaW5k
ZXggOTU4ZmNjNTUwOGQxLi5jNDBjMGQyZTRiMjggMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL3Ry
YWNlLWV2ZW50cw0KPiArKysgYi9ody9ibG9jay90cmFjZS1ldmVudHMNCj4gQEAgLTMzLDE5ICsz
MywyOCBAQCBwY2lfbnZtZV9pcnFfbXNpeCh1aW50MzJfdCB2ZWN0b3IpICJyYWlzaW5nIE1TSS1Y
IElSUSB2ZWN0b3IgJXUiDQo+ICBwY2lfbnZtZV9pcnFfcGluKHZvaWQpICJwdWxzaW5nIElSUSBw
aW4iDQo+ICBwY2lfbnZtZV9pcnFfbWFza2VkKHZvaWQpICJJUlEgaXMgbWFza2VkIg0KPiAgcGNp
X252bWVfZG1hX3JlYWQodWludDY0X3QgcHJwMSwgdWludDY0X3QgcHJwMikgIkRNQSByZWFkLCBw
cnAxPTB4JSJQUkl4NjQiIHBycDI9MHglIlBSSXg2NCIiDQo+ICtwY2lfbnZtZV9pb19jbWQodWlu
dDE2X3QgY2lkLCB1aW50MzJfdCBuc2lkLCB1aW50MTZfdCBzcWlkLCB1aW50OF90IG9wY29kZSkg
ImNpZCAlIlBSSXUxNiIgbnNpZCAlIlBSSXUzMiIgc3FpZCAlIlBSSXUxNiIgb3BjIDB4JSJQUkl4
OCIiDQo+ICtwY2lfbnZtZV9hZG1pbl9jbWQodWludDE2X3QgY2lkLCB1aW50MTZfdCBzcWlkLCB1
aW50OF90IG9wY29kZSkgImNpZCAlIlBSSXUxNiIgc3FpZCAlIlBSSXUxNiIgb3BjIDB4JSJQUkl4
OCIiDQo+ICBwY2lfbnZtZV9ydyhjb25zdCBjaGFyICp2ZXJiLCB1aW50MzJfdCBibGtfY291bnQs
IHVpbnQ2NF90IGJ5dGVfY291bnQsIHVpbnQ2NF90IGxiYSkgIiVzICUiUFJJdTMyIiBibG9ja3Mg
KCUiUFJJdTY0IiBieXRlcykgZnJvbSBMQkEgJSJQUkl1NjQiIg0KPiArcGNpX252bWVfcndfY2Io
dWludDE2X3QgY2lkKSAiY2lkICUiUFJJdTE2IiINCj4gK3BjaV9udm1lX3dyaXRlX3plcm9lcyh1
aW50MTZfdCBjaWQsIHVpbnQ2NF90IHNsYmEsIHVpbnQzMl90IG5sYikgImNpZCAlIlBSSXUxNiIg
c2xiYSAlIlBSSXU2NCIgbmxiICUiUFJJdTMyIiINCj4gIHBjaV9udm1lX2NyZWF0ZV9zcSh1aW50
NjRfdCBhZGRyLCB1aW50MTZfdCBzcWlkLCB1aW50MTZfdCBjcWlkLCB1aW50MTZfdCBxc2l6ZSwg
dWludDE2X3QgcWZsYWdzKSAiY3JlYXRlIHN1Ym1pc3Npb24gcXVldWUsIGFkZHI9MHglIlBSSXg2
NCIsIHNxaWQ9JSJQUkl1MTYiLCBjcWlkPSUiUFJJdTE2IiwgcXNpemU9JSJQUkl1MTYiLCBxZmxh
Z3M9JSJQUkl1MTYiIg0KPiAgcGNpX252bWVfY3JlYXRlX2NxKHVpbnQ2NF90IGFkZHIsIHVpbnQx
Nl90IGNxaWQsIHVpbnQxNl90IHZlY3RvciwgdWludDE2X3Qgc2l6ZSwgdWludDE2X3QgcWZsYWdz
LCBpbnQgaWVuKSAiY3JlYXRlIGNvbXBsZXRpb24gcXVldWUsIGFkZHI9MHglIlBSSXg2NCIsIGNx
aWQ9JSJQUkl1MTYiLCB2ZWN0b3I9JSJQUkl1MTYiLCBxc2l6ZT0lIlBSSXUxNiIsIHFmbGFncz0l
IlBSSXUxNiIsIGllbj0lZCINCj4gIHBjaV9udm1lX2RlbF9zcSh1aW50MTZfdCBxaWQpICJkZWxl
dGluZyBzdWJtaXNzaW9uIHF1ZXVlIHNxaWQ9JSJQUkl1MTYiIg0KPiAgcGNpX252bWVfZGVsX2Nx
KHVpbnQxNl90IGNxaWQpICJkZWxldGVkIGNvbXBsZXRpb24gcXVldWUsIGNxaWQ9JSJQUkl1MTYi
Ig0KPiAgcGNpX252bWVfaWRlbnRpZnlfY3RybCh2b2lkKSAiaWRlbnRpZnkgY29udHJvbGxlciIN
Cj4gLXBjaV9udm1lX2lkZW50aWZ5X25zKHVpbnQxNl90IG5zKSAiaWRlbnRpZnkgbmFtZXNwYWNl
LCBuc2lkPSUiUFJJdTE2IiINCj4gLXBjaV9udm1lX2lkZW50aWZ5X25zbGlzdCh1aW50MTZfdCBu
cykgImlkZW50aWZ5IG5hbWVzcGFjZSBsaXN0LCBuc2lkPSUiUFJJdTE2IiINCj4gK3BjaV9udm1l
X2lkZW50aWZ5X25zKHVpbnQzMl90IG5zKSAibnNpZCAlIlBSSXUzMiIiDQo+ICtwY2lfbnZtZV9p
ZGVudGlmeV9uc2xpc3QodWludDMyX3QgbnMpICJuc2lkICUiUFJJdTMyIiINCj4gIHBjaV9udm1l
X2dldGZlYXRfdndjYWNoZShjb25zdCBjaGFyKiByZXN1bHQpICJnZXQgZmVhdHVyZSB2b2xhdGls
ZSB3cml0ZSBjYWNoZSwgcmVzdWx0PSVzIg0KPiAgcGNpX252bWVfZ2V0ZmVhdF9udW1xKGludCBy
ZXN1bHQpICJnZXQgZmVhdHVyZSBudW1iZXIgb2YgcXVldWVzLCByZXN1bHQ9JWQiDQo+ICBwY2lf
bnZtZV9zZXRmZWF0X251bXEoaW50IHJlcWNxLCBpbnQgcmVxc3EsIGludCBnb3RjcSwgaW50IGdv
dHNxKSAicmVxdWVzdGVkIGNxX2NvdW50PSVkIHNxX2NvdW50PSVkLCByZXNwb25kaW5nIHdpdGgg
Y3FfY291bnQ9JWQgc3FfY291bnQ9JWQiDQo+ICBwY2lfbnZtZV9zZXRmZWF0X3RpbWVzdGFtcCh1
aW50NjRfdCB0cykgInNldCBmZWF0dXJlIHRpbWVzdGFtcCA9IDB4JSJQUkl4NjQiIg0KPiAgcGNp
X252bWVfZ2V0ZmVhdF90aW1lc3RhbXAodWludDY0X3QgdHMpICJnZXQgZmVhdHVyZSB0aW1lc3Rh
bXAgPSAweCUiUFJJeDY0IiINCj4gK3BjaV9udm1lX2VucXVldWVfcmVxX2NvbXBsZXRpb24odWlu
dDE2X3QgY2lkLCB1aW50MTZfdCBjcWlkLCB1aW50MTZfdCBzdGF0dXMpICJjaWQgJSJQUkl1MTYi
IGNxaWQgJSJQUkl1MTYiIHN0YXR1cyAweCUiUFJJeDE2IiINCj4gK3BjaV9udm1lX21taW9fcmVh
ZCh1aW50NjRfdCBhZGRyKSAiYWRkciAweCUiUFJJeDY0IiINCj4gK3BjaV9udm1lX21taW9fd3Jp
dGUodWludDY0X3QgYWRkciwgdWludDY0X3QgZGF0YSkgImFkZHIgMHglIlBSSXg2NCIgZGF0YSAw
eCUiUFJJeDY0IiINCj4gK3BjaV9udm1lX21taW9fZG9vcmJlbGxfY3EodWludDE2X3QgY3FpZCwg
dWludDE2X3QgbmV3X2hlYWQpICJjcWlkICUiUFJJdTE2IiBuZXdfaGVhZCAlIlBSSXUxNiIiDQo+
ICtwY2lfbnZtZV9tbWlvX2Rvb3JiZWxsX3NxKHVpbnQxNl90IHNxaWQsIHVpbnQxNl90IG5ld190
YWlsKSAiY3FpZCAlIlBSSXUxNiIgbmV3X3RhaWwgJSJQUkl1MTYiIg0KPiAgcGNpX252bWVfbW1p
b19pbnRtX3NldCh1aW50NjRfdCBkYXRhLCB1aW50NjRfdCBuZXdfbWFzaykgIndyb3RlIE1NSU8s
IGludGVycnVwdCBtYXNrIHNldCwgZGF0YT0weCUiUFJJeDY0IiwgbmV3X21hc2s9MHglIlBSSXg2
NCIiDQo+ICBwY2lfbnZtZV9tbWlvX2ludG1fY2xyKHVpbnQ2NF90IGRhdGEsIHVpbnQ2NF90IG5l
d19tYXNrKSAid3JvdGUgTU1JTywgaW50ZXJydXB0IG1hc2sgY2xyLCBkYXRhPTB4JSJQUkl4NjQi
LCBuZXdfbWFzaz0weCUiUFJJeDY0IiINCj4gIHBjaV9udm1lX21taW9fY2ZnKHVpbnQ2NF90IGRh
dGEpICJ3cm90ZSBNTUlPLCBjb25maWcgY29udHJvbGxlciBjb25maWc9MHglIlBSSXg2NCIiDQo=

