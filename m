Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6235FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BFA2065D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iKBJN//k";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Vn5moNFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BFA2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFgt-0000gb-Qb
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFft-00084P-Ii; Wed, 08 Jul 2020 15:24:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFfr-0002Wi-AR; Wed, 08 Jul 2020 15:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594236247; x=1625772247;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bdR7uBl2OlWHJ8uBzV7HBZctdFEGRNlCwAttd+ey+og=;
 b=iKBJN//k+9OTSy51BtNyGT+P4PFTGyyuUhY6cWAWGyhmopD3vALDkmU8
 BcF6iOng/NMuVjOfOG5FvDx6qqtqo20MIVhz82Pzfl+41SWyAijsX4SjF
 wNQK+zXAJN1v5RYAreCRAG+yuN26x75iVhTbfUntR+MndHgvqHN7IcJCI
 4n6OvUXouSiI29Hd2agy0kD2O4XskV7ls6vrYuSJ9tIvDBY148PIMylJU
 gRAkqs2mTHEikH4LKsZ70zfV5UtAQythfcjoEqUZDDmYe0Z5HVwyVHx2h
 62E9Z2fqXvySaAc9KV/P2UDzeRP2dPlxk60YbzquD1y4kqdEX/MSziAaq Q==;
IronPort-SDR: /2lo/D3cjeQbefqPFyAfxTnaycuPZ/o89P0jA2v5XGOxExjMx4O/X+UDnWow8pT54LlriOyzXj
 MtuCMFEI1IuITT35mwmLX4QaQVDvXY17ifEzd8b7Z30VyVQW/1PWs5fwSgEqGKQ/pL5e+eOGQ6
 nbGhglwMgGXHbn9rqH2zDu/Fy/HANUBruiyTT9WnYAQu5IGCkm51rOjZrfr9OI9QsStG6VdZSE
 7Jx4S36O+br8UCTScm3Kf/Nh+17TwBhEOSwm0thUanuRGAClZSRVqbvDzBsUxDm/tmUHNCAt+M
 0rk=
X-IronPort-AV: E=Sophos;i="5.75,328,1589212800"; d="scan'208";a="146270731"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 03:24:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoFbrK23so3U2vmG6y8UfPv7WyVjwgw7iFBS4kSTzwimsYeYvhN8FjyjWEHeHTtwQ6HcuFgrv5JQl1yGeq04ouaPsMEdhGgXVLV7lf3sdJ73S01BZlqCzR/xI+xkgBLAoXEBZeoHiC8BSK/GWzNM82ovig8gaKK6uWGN7v1sd83JK4T8UEHSgvhBC5+WhhXo6a/WWWQxmFzDuH+kBZ2OVvxPOph3No/N+uyAw/kXWDqIc1i+x90rEyIbb4Cpqwvy8FPxi7aHM9exQl2n2KQU6pZ2ihkRpMCGyUUPzDNs4Ck4NuAwA2SUxPaT37IzvSjQiQG7C8dxUFZek419vKMNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdR7uBl2OlWHJ8uBzV7HBZctdFEGRNlCwAttd+ey+og=;
 b=XAnlJiFLILJ1hMSCO073DwIYqr51soOOKHtNeMjNGJChVPJrdROA/rixLXg9qVIp0iHMxUZ6slxZDMEapWqlx4q9q8++dqyUeU2dtgraWO/EHaD5jE8cWlHa1EetSJDF7K9+R2mO8CIUyISqsCXRBQkwwecoB0zPU2Tq23Qi+DH5m5eoZpeVLSD1e8byaqjhgrIzxTGw+aNEvEW44tpDZ0X5L7FUqgbGsEcVtAPyX9fjdAq+1ZuG9yH2eRLkYa7JSaki/s/lfqkOrdLIhzRjQbejIQL8j6iKNtrgEWCTKK9PS2XAgI7g3+Ti24WrcwUunBdyXlug8sT4seVIR/EBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdR7uBl2OlWHJ8uBzV7HBZctdFEGRNlCwAttd+ey+og=;
 b=Vn5moNFR+OMzYQywrj5LY5B4i3puE1HvRijGVSxqNlmsss1OvkPg/OpwqhS7jGP3rbXnN7gatm8KxudrlZPzFK3DtnXZmjcgUyeMvqEU2Tb2+Ny7pR51K2UR+87cJuPWsTYIJVp/gFOk1zuosclznulGwPtXf7ULHA63o5MwBjk=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6015.namprd04.prod.outlook.com (2603:10b6:208:d8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 19:24:03 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 19:24:03 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 05/18] hw/block/nvme: add temperature threshold feature
Thread-Topic: [PATCH v3 05/18] hw/block/nvme: add temperature threshold feature
Thread-Index: AQHWU1yNu09XZlRrpUSMKut2JwAYhKj+E/MA
Date: Wed, 8 Jul 2020 19:24:03 +0000
Message-ID: <975a1d7112a2485cef0fdbb1e6e715b3f0b254ef.camel@wdc.com>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-6-its@irrelevant.dk>
In-Reply-To: <20200706061303.246057-6-its@irrelevant.dk>
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
x-ms-office365-filtering-correlation-id: 568c7954-e6fc-4ab8-ac27-08d823747995
x-ms-traffictypediagnostic: MN2PR04MB6015:
x-microsoft-antispam-prvs: <MN2PR04MB6015609ADEA75C0BBD20463CE1670@MN2PR04MB6015.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xiLIXN/DyevIyHaGpHdNAipX53TsPkvlE7PpuLomTc3YZQjo7R3HN5bcDkUrS17QOuenenYIyZGHbHYNyQV20BIQS5EyDUAgrBxOCvKsAIEfPbh4aCtW2X+4xaOT0+nvFKhRPIIbHgAlqqpoETN7VMU4/9tojXaFYeV+O1enm18UNIptJQybddI0ea7HuHoBZC6jpCMQNuPVD3hRA7jyhUwAaIxgW0CaYf+AnXIPh4oNMeK9Q68CjU8XdsbyT2OQiWhpoRNS19kh12VcmJL0v2R5xV3SmwG8G3Cpu1neaSv8gjDPDi/jW8fwGSVtR2poqPjG7eyZAZ/fAPV4Z/bqEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(4326008)(7416002)(6512007)(54906003)(110136005)(316002)(26005)(478600001)(66556008)(76116006)(66946007)(66476007)(64756008)(66446008)(6506007)(71200400001)(36756003)(186003)(5660300002)(8936002)(86362001)(2906002)(6486002)(8676002)(83380400001)(2616005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vWVDhidsUQfwIy/8Rowg4TIuT41pq5fvwUSVRsO5ZCPOfxgQmvu0u4vH1KT+QW5izeCfApwqaJGog+lywiHX3mj0PIYoL+xcM02JlDi4LTiZaXL7RoYbPGTG+/ikwZlWq56CowAJUXWkBNPUEkGBCor11xoHz9cBVkic0vca+tugaiK4r6oL7tgsoutvq5nsxegCgRIfa6g9yeyoUcza7BKuQgcsEQL2G+zYUfnRecmksLuDfmFo7XpKC5sMfZLiRN7a5Ai/wEBeRn5Bsiql23ns/3EK+gnn8tHEdKKOWnGR1GxrO0XYSCLVBNp0pS9ziIhkhtW37ag8Niaiym4/QAp0c9o1reTFPTbMAfIICPwdXKJrbAMAleXqkc769EkJMY+LW+tEMkkHGS7hmVvhfN1/a1jLdmYttoXU91uqwLjytSlhR3/0Ph/dAlxMJkNNHXV3tgjgWiMzGEJocQZd4J2fWq0l/HEeYI7mUZk8MsFm/tKmeM2ymXxshc8Q5w/g
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F63A452227D2324AAA8C5C15251597FE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568c7954-e6fc-4ab8-ac27-08d823747995
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 19:24:03.3537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Evr7rqix73cQ1v1hVEYYOlF374cXDKwzSCif+NrnTNkgg5ALJngLpHMvzSY+0GKRlm42yew6C0F2cjex2FhWrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6015
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=45148fd95=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:20:30
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
aGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0wNy0wNiBhdCAwODoxMiArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29t
Pg0KPiANCj4gSXQgbWlnaHQgc2VlbSB3ZWlyZCB0byBpbXBsZW1lbnQgdGhpcyBmZWF0dXJlIGZv
ciBhbiBlbXVsYXRlZCBkZXZpY2UsDQo+IGJ1dCBpdCBpcyBtYW5kYXRvcnkgdG8gc3VwcG9ydCBh
bmQgdGhlIGZlYXR1cmUgaXMgdXNlZnVsIGZvciB0ZXN0aW5nDQo+IGFzeW5jaHJvbm91cyBldmVu
dCByZXF1ZXN0IHN1cHBvcnQsIHdoaWNoIHdpbGwgYmUgYWRkZWQgaW4gYSBsYXRlcg0KPiBwYXRj
aC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5j
b20+DQo+IEFja2VkLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IFJldmll
d2VkLWJ5OiBNYXhpbSBMZXZpdHNreSA8bWxldml0c2tAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBo
dy9ibG9jay9udm1lLmMgICAgICB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ICBody9ibG9jay9udm1lLmggICAgICB8ICAxICsNCj4gIGluY2x1ZGUv
YmxvY2svbnZtZS5oIHwgIDUgKysrKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL252bWUuYyBi
L2h3L2Jsb2NrL252bWUuYw0KPiBpbmRleCA0MTVkM2IwMzY4OTcuLmEzMzBjY2Y5MTYyMCAxMDA2
NDQNCj4gLS0tIGEvaHcvYmxvY2svbnZtZS5jDQo+ICsrKyBiL2h3L2Jsb2NrL252bWUuYw0KPiBA
QCAtNTksNiArNTksOSBAQA0KPiAgI2RlZmluZSBOVk1FX0RCX1NJWkUgIDQNCj4gICNkZWZpbmUg
TlZNRV9DTUJfQklSIDINCj4gICNkZWZpbmUgTlZNRV9QTVJfQklSIDINCj4gKyNkZWZpbmUgTlZN
RV9URU1QRVJBVFVSRSAweDE0Mw0KPiArI2RlZmluZSBOVk1FX1RFTVBFUkFUVVJFX1dBUk5JTkcg
MHgxNTcNCj4gKyNkZWZpbmUgTlZNRV9URU1QRVJBVFVSRV9DUklUSUNBTCAweDE3NQ0KPiAgDQo+
ICAjZGVmaW5lIE5WTUVfR1VFU1RfRVJSKHRyYWNlLCBmbXQsIC4uLikgXA0KPiAgICAgIGRvIHsg
XA0KPiBAQCAtODQxLDkgKzg0NCwzMSBAQCBzdGF0aWMgdWludDE2X3QgbnZtZV9nZXRfZmVhdHVy
ZV90aW1lc3RhbXAoTnZtZUN0cmwgKm4sIE52bWVDbWQgKmNtZCkNCj4gIHN0YXRpYyB1aW50MTZf
dCBudm1lX2dldF9mZWF0dXJlKE52bWVDdHJsICpuLCBOdm1lQ21kICpjbWQsIE52bWVSZXF1ZXN0
ICpyZXEpDQo+ICB7DQo+ICAgICAgdWludDMyX3QgZHcxMCA9IGxlMzJfdG9fY3B1KGNtZC0+Y2R3
MTApOw0KPiArICAgIHVpbnQzMl90IGR3MTEgPSBsZTMyX3RvX2NwdShjbWQtPmNkdzExKTsNCj4g
ICAgICB1aW50MzJfdCByZXN1bHQ7DQo+ICANCj4gICAgICBzd2l0Y2ggKGR3MTApIHsNCj4gKyAg
ICBjYXNlIE5WTUVfVEVNUEVSQVRVUkVfVEhSRVNIT0xEOg0KPiArICAgICAgICByZXN1bHQgPSAw
Ow0KPiArDQo+ICsgICAgICAgIC8qDQo+ICsgICAgICAgICAqIFRoZSBjb250cm9sbGVyIG9ubHkg
aW1wbGVtZW50cyB0aGUgQ29tcG9zaXRlIFRlbXBlcmF0dXJlIHNlbnNvciwgc28NCj4gKyAgICAg
ICAgICogcmV0dXJuIDAgZm9yIGFsbCBvdGhlciBzZW5zb3JzLg0KPiArICAgICAgICAgKi8NCj4g
KyAgICAgICAgaWYgKE5WTUVfVEVNUF9UTVBTRUwoZHcxMSkgIT0gTlZNRV9URU1QX1RNUFNFTF9D
T01QT1NJVEUpIHsNCj4gKyAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgICB9DQo+ICsNCj4g
KyAgICAgICAgc3dpdGNoIChOVk1FX1RFTVBfVEhTRUwoZHcxMSkpIHsNCj4gKyAgICAgICAgY2Fz
ZSBOVk1FX1RFTVBfVEhTRUxfT1ZFUjoNCj4gKyAgICAgICAgICAgIHJlc3VsdCA9IG4tPmZlYXR1
cmVzLnRlbXBfdGhyZXNoX2hpOw0KPiArICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgIGNh
c2UgTlZNRV9URU1QX1RIU0VMX1VOREVSOg0KPiArICAgICAgICAgICAgcmVzdWx0ID0gbi0+ZmVh
dHVyZXMudGVtcF90aHJlc2hfbG93Ow0KPiArICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAg
IH0NCj4gKw0KPiArICAgICAgICBicmVhazsNCj4gICAgICBjYXNlIE5WTUVfVk9MQVRJTEVfV1JJ
VEVfQ0FDSEU6DQo+ICAgICAgICAgIHJlc3VsdCA9IGJsa19lbmFibGVfd3JpdGVfY2FjaGUobi0+
Y29uZi5ibGspOw0KPiAgICAgICAgICB0cmFjZV9wY2lfbnZtZV9nZXRmZWF0X3Z3Y2FjaGUocmVz
dWx0ID8gImVuYWJsZWQiIDogImRpc2FibGVkIik7DQo+IEBAIC04ODgsNiArOTEzLDIzIEBAIHN0
YXRpYyB1aW50MTZfdCBudm1lX3NldF9mZWF0dXJlKE52bWVDdHJsICpuLCBOdm1lQ21kICpjbWQs
IE52bWVSZXF1ZXN0ICpyZXEpDQo+ICAgICAgdWludDMyX3QgZHcxMSA9IGxlMzJfdG9fY3B1KGNt
ZC0+Y2R3MTEpOw0KPiAgDQo+ICAgICAgc3dpdGNoIChkdzEwKSB7DQo+ICsgICAgY2FzZSBOVk1F
X1RFTVBFUkFUVVJFX1RIUkVTSE9MRDoNCj4gKyAgICAgICAgaWYgKE5WTUVfVEVNUF9UTVBTRUwo
ZHcxMSkgIT0gTlZNRV9URU1QX1RNUFNFTF9DT01QT1NJVEUpIHsNCj4gKyAgICAgICAgICAgIGJy
ZWFrOw0KPiArICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgc3dpdGNoIChOVk1FX1RFTVBfVEhT
RUwoZHcxMSkpIHsNCj4gKyAgICAgICAgY2FzZSBOVk1FX1RFTVBfVEhTRUxfT1ZFUjoNCj4gKyAg
ICAgICAgICAgIG4tPmZlYXR1cmVzLnRlbXBfdGhyZXNoX2hpID0gTlZNRV9URU1QX1RNUFRIKGR3
MTEpOw0KPiArICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgIGNhc2UgTlZNRV9URU1QX1RI
U0VMX1VOREVSOg0KPiArICAgICAgICAgICAgbi0+ZmVhdHVyZXMudGVtcF90aHJlc2hfbG93ID0g
TlZNRV9URU1QX1RNUFRIKGR3MTEpOw0KPiArICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAg
IGRlZmF1bHQ6DQo+ICsgICAgICAgICAgICByZXR1cm4gTlZNRV9JTlZBTElEX0ZJRUxEIHwgTlZN
RV9ETlI7DQo+ICsgICAgICAgIH0NCj4gKw0KPiArICAgICAgICBicmVhazsNCj4gICAgICBjYXNl
IE5WTUVfVk9MQVRJTEVfV1JJVEVfQ0FDSEU6DQo+ICAgICAgICAgIGJsa19zZXRfZW5hYmxlX3dy
aXRlX2NhY2hlKG4tPmNvbmYuYmxrLCBkdzExICYgMSk7DQo+ICAgICAgICAgIGJyZWFrOw0KPiBA
QCAtMTQ2OCw2ICsxNTEwLDcgQEAgc3RhdGljIHZvaWQgbnZtZV9pbml0X3N0YXRlKE52bWVDdHJs
ICpuKQ0KPiAgICAgIG4tPm5hbWVzcGFjZXMgPSBnX25ldzAoTnZtZU5hbWVzcGFjZSwgbi0+bnVt
X25hbWVzcGFjZXMpOw0KPiAgICAgIG4tPnNxID0gZ19uZXcwKE52bWVTUXVldWUgKiwgbi0+cGFy
YW1zLm1heF9pb3FwYWlycyArIDEpOw0KPiAgICAgIG4tPmNxID0gZ19uZXcwKE52bWVDUXVldWUg
Kiwgbi0+cGFyYW1zLm1heF9pb3FwYWlycyArIDEpOw0KPiArICAgIG4tPmZlYXR1cmVzLnRlbXBf
dGhyZXNoX2hpID0gTlZNRV9URU1QRVJBVFVSRV9XQVJOSU5HOw0KPiAgfQ0KPiAgDQo+ICBzdGF0
aWMgdm9pZCBudm1lX2luaXRfYmxrKE52bWVDdHJsICpuLCBFcnJvciAqKmVycnApDQo+IEBAIC0x
NjI1LDYgKzE2NjgsMTEgQEAgc3RhdGljIHZvaWQgbnZtZV9pbml0X2N0cmwoTnZtZUN0cmwgKm4s
IFBDSURldmljZSAqcGNpX2RldikNCj4gICAgICBpZC0+YWNsID0gMzsNCj4gICAgICBpZC0+ZnJt
dyA9IDcgPDwgMTsNCj4gICAgICBpZC0+bHBhID0gMSA8PCAwOw0KPiArDQo+ICsgICAgLyogcmVj
b21tZW5kZWQgZGVmYXVsdCB2YWx1ZSAofjcwIEMpICovDQo+ICsgICAgaWQtPndjdGVtcCA9IGNw
dV90b19sZTE2KE5WTUVfVEVNUEVSQVRVUkVfV0FSTklORyk7DQo+ICsgICAgaWQtPmNjdGVtcCA9
IGNwdV90b19sZTE2KE5WTUVfVEVNUEVSQVRVUkVfQ1JJVElDQUwpOw0KPiArDQo+ICAgICAgaWQt
PnNxZXMgPSAoMHg2IDw8IDQpIHwgMHg2Ow0KPiAgICAgIGlkLT5jcWVzID0gKDB4NCA8PCA0KSB8
IDB4NDsNCj4gICAgICBpZC0+bm4gPSBjcHVfdG9fbGUzMihuLT5udW1fbmFtZXNwYWNlcyk7DQo+
IGRpZmYgLS1naXQgYS9ody9ibG9jay9udm1lLmggYi9ody9ibG9jay9udm1lLmgNCj4gaW5kZXgg
MWQzMGMwYmNhMjgzLi5lM2EyYzkwN2UyMTAgMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL252bWUu
aA0KPiArKysgYi9ody9ibG9jay9udm1lLmgNCj4gQEAgLTEwNyw2ICsxMDcsNyBAQCB0eXBlZGVm
IHN0cnVjdCBOdm1lQ3RybCB7DQo+ICAgICAgTnZtZVNRdWV1ZSAgICAgIGFkbWluX3NxOw0KPiAg
ICAgIE52bWVDUXVldWUgICAgICBhZG1pbl9jcTsNCj4gICAgICBOdm1lSWRDdHJsICAgICAgaWRf
Y3RybDsNCj4gKyAgICBOdm1lRmVhdHVyZVZhbCAgZmVhdHVyZXM7DQo+ICB9IE52bWVDdHJsOw0K
PiAgDQo+ICAvKiBjYWxjdWxhdGUgdGhlIG51bWJlciBvZiBMQkFzIHRoYXQgdGhlIG5hbWVzcGFj
ZSBjYW4gYWNjb21vZGF0ZSAqLw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9udm1lLmgg
Yi9pbmNsdWRlL2Jsb2NrL252bWUuaA0KPiBpbmRleCAyYTgwZDJhN2VkODkuLmQyYzQ1NzY5NWIz
OCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ibG9jay9udm1lLmgNCj4gKysrIGIvaW5jbHVkZS9i
bG9jay9udm1lLmgNCj4gQEAgLTg2MCw3ICs4NjAsMTAgQEAgZW51bSBOdm1lSWRDdHJsT25jcyB7
DQo+ICB0eXBlZGVmIHN0cnVjdCBOdm1lRmVhdHVyZVZhbCB7DQo+ICAgICAgdWludDMyX3QgICAg
YXJiaXRyYXRpb247DQo+ICAgICAgdWludDMyX3QgICAgcG93ZXJfbWdtdDsNCj4gLSAgICB1aW50
MzJfdCAgICB0ZW1wX3RocmVzaDsNCj4gKyAgICBzdHJ1Y3Qgew0KPiArICAgICAgICB1aW50MTZf
dCB0ZW1wX3RocmVzaF9oaTsNCj4gKyAgICAgICAgdWludDE2X3QgdGVtcF90aHJlc2hfbG93Ow0K
PiArICAgIH07DQo+ICAgICAgdWludDMyX3QgICAgZXJyX3JlYzsNCj4gICAgICB1aW50MzJfdCAg
ICB2b2xhdGlsZV93YzsNCj4gICAgICB1aW50MzJfdCAgICBudW1fcXVldWVzOw0K

