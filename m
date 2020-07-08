Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7982065D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HMwddKdP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RnVSDX1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7982065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFd3-0005bS-Uz
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFcQ-00057h-VE; Wed, 08 Jul 2020 15:20:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtFcO-0002Av-QA; Wed, 08 Jul 2020 15:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594236033; x=1625772033;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OZrDocIFenSMcRVNI4TpMbPSt1cffGRIXVDEbq4AQKk=;
 b=HMwddKdP2jqD6ZY+upEXlEFxlbrg356cOr2FeVXLHUhhWAYa2s2eRIoM
 91+tYqlo+w1HG1Gr8lEcNlF9rWtkYnef3nQzU4nttlWQg5LVl/WVImiaL
 7vLw7SdtOBTlieHMbz+lYNCXO8FSrw8W5b0zvgZkwqRgh6QSd+SPqZ9G1
 VgzUB3fqslUU+zYKrIPPUQfk/yu1ETjrj1PLuukwzJ2g5mLy2pz35HM9I
 FZVa0UDMVv0i00Wapv/ei2XWtuOviqC4cSa5mX7SPtfRQIZ4saIo4KpYN
 voqb74BBjo+hpxw9h5o3DIXy5JlRKXQXYt3jRoKU8D+uXPu+GoIANCtRB g==;
IronPort-SDR: 12iWexlcNbI72Bmjd6xIG1o9ShyvB7w97oaz7zh89+R9TsoKJie5EPO8Kpi1gtU76dj4+qwJnw
 4Nggl+WgyQotf0vJjPjhEO5gR9x3D2kfKlbx8W6KCLChl6N2utBq3tvEB1czUk2O5Y/0RpWkBz
 UtOXS0/uiut3py0mMO40qn1JLSAuY1eVRl2vOwx8+lnz6UouX7cfAmsL+dpQ70kUunL4fwkNOs
 +6x0BxilDYhosZfqftGNMDYZtVCPhLd9/yHKjQMphBcCSiXRbaNdHsBWRrkc983vXD/tfYu2Ef
 P/8=
X-IronPort-AV: E=Sophos;i="5.75,328,1589212800"; d="scan'208";a="146270480"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 03:20:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIiYowZrrBiE29YYA51DOgJx1hr93gMQ6Ml2sSTUW6ihbA7KMjyOS15iGB2EMoGLWtLk3JbYn1HQf/isjTmJ5OC0W0fVBWTAJ0U5Xi/ydfE167D2paFWsYBxGtS6t9vO4DeBX4wWqezdtY9cIjbMQz7L5oqBfjkpLp76J1xB4PMQXM0OMrZhvO7b3vJn7wfCvbOkqkkXgEgdBIvtN8IU6cjDEUr9jTW0JbzGCYuu1mxMYDHL+BwvmY6MNGKi8g7z4oPSbd0AUt3mykkXmiHzfXhXw4e57Dv5rfozP5qBamT4uDT20TtyWYvMfHk5czTlDzVVgptQBOulxQOrDkdZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZrDocIFenSMcRVNI4TpMbPSt1cffGRIXVDEbq4AQKk=;
 b=Jw7Xg9yNuEud6VB4XlEMGa39zDPL5VG84lS2n53hB/og8ZY5KW5GzinzxJqnmscylUwiz9i/fg6sAnbQ+qo3Kbo41xgNUxPc/8mG+Vd01xEdnoDnF42Z4hCN8GuTVcYh2dZntdaD6DvkLiPOX/JpnrOhvrVZaEngRRh9k64nEIfB6BZY2emLpzm8qUg0MbkIsSoSzKlBK2zhWoNmMT4RXrWqW5KWKcKKP7UsPNFullhzqdwEQ6dc3jKNS/uDGca5+vRr00B7MN4JiGr3ILKfOYB4JGxLr87V9JAnMFUqdiWpLFmqtZpQOm4d/pYQ3sMEaHIv+QLpfSXWIu0J8xS+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZrDocIFenSMcRVNI4TpMbPSt1cffGRIXVDEbq4AQKk=;
 b=RnVSDX1inS1d+Iz7ezDEkOm0nr2dWHrLeIhUIkDaAh+73F3U6x3sGZ165tqwKDnNOuEK8h80f+pcLcPwdCY9OABYUzEyrpql+gzJyNoabYyMtxj+pAIlpcj9vGC0wHdZWlEk5OkUEPGOzxSj5RYyYBloOybzDj6PN1utbp6R1O8=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5950.namprd04.prod.outlook.com (2603:10b6:208:a5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 19:20:28 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 19:20:28 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 02/18] hw/block/nvme: fix missing endian conversion
Thread-Topic: [PATCH v3 02/18] hw/block/nvme: fix missing endian conversion
Thread-Index: AQHWU1yLG3jTuqXnZEeV8kQvg/QcNKj+EvEA
Date: Wed, 8 Jul 2020 19:20:27 +0000
Message-ID: <8c0806e57999aec334fa59bf608fc32e9874e438.camel@wdc.com>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-3-its@irrelevant.dk>
In-Reply-To: <20200706061303.246057-3-its@irrelevant.dk>
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
x-ms-office365-filtering-correlation-id: b8b914c6-b520-473e-f372-08d82373f930
x-ms-traffictypediagnostic: MN2PR04MB5950:
x-microsoft-antispam-prvs: <MN2PR04MB595093D252ECC603CB6AAA50E1670@MN2PR04MB5950.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:247;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEIG94gPms5ONvyCtZ+rn+pDGgFkFEF/KKMK39O8Pc2qrl2fEQ4iQKyRNMr9SiYJP3Qz2bZfHNzUD56LoQwfWYILv0EOOh1d54/m7vog5plzAM+TwKVnGCK9ijGy0dtl92kCg8SuyUaC47pZ2I/Pfm+IvM50y5g74sPvTcJHL1bbtDWugMcPNyMd167QfCvuvcff2/z5VGHdbCou8g9ykVWyqTwMZ9hHZodH6JhR2jxbAAXBWjIF8hWV30+HZNANn3nOIcI+9vCEzq1BMcyIiQcKgeF9S0HPFdi/FwDRpYb9uFvKA2OxBoZAyhB0X9cfCv2fdcfbedQTNY0aawAosw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(76116006)(6486002)(2616005)(83380400001)(6512007)(36756003)(316002)(110136005)(26005)(7416002)(54906003)(186003)(4326008)(2906002)(8676002)(66946007)(5660300002)(71200400001)(478600001)(6506007)(66556008)(8936002)(86362001)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: CzEQ9ak47+j60LmVmb7B5pJG+Dpz6HhZBkK7jh51rrDiAb/cRIRD+LduGpGeEB9G/7lnZV0XXXf3jS1CfO2LUlSKynGbs3xXWi5nB425AgWkx88IsGbZkdjxTRgkvD4jGFCNDjH3X2ZYh4Bihuhsau2vB9nTTxaEn+6jQvGFq0FigkSSvdKQF5raVw+GDNDf9JwO743uRDUzTGpieM5K2JsIvid2buTznpXF+5bWdzf5W82nHlIbpm48CIrRm3At51TgjhV7Jvcp5pqCq/dplD+QeSJxcqkf+LVDqWSBVzxpiAKnqIsaUb6xqE0Pf9S2hVYX6k3Owv+iq9f+RmuIaPfA7aHFqjfQl4didhW9SZ5+kPq0/BXy/gIgpVFazL6xFa5P4sROBdOSDVrFrIh4wmLy+fMayQ95NdW7jzWqeCuGNCpURhgyiorMzoxjn+IHIk6jkEumLT4a669iL8cBO3Z34/oDTxngoOE3eFks+5rE91M/dD+lgE+EKPmOfN30
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B369D4A8FAB5E649A1DA53C400C401A1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b914c6-b520-473e-f372-08d82373f930
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 19:20:27.9392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjSLKChtaiW2TGECdK8TGkkEq38/ppsUzvVNU5u4n8KWMaP/4wlOALp7IjPEvrOA6Ekqn3oVNJ+sjgBGqsIKsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5950
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
aGV2QHdkYy5jb20+DQoNCj4gT24gTW9uLCAyMDIwLTA3LTA2IGF0IDA4OjEyICswMjAwLCBLbGF1
cyBKZW5zZW4gd3JvdGU6DQo+IEZyb206IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5j
b20+DQo+IA0KPiBGaXggYSBtaXNzaW5nIGNwdV90byBjb252ZXJzaW9uIGJ5IG1vdmluZyBjb252
ZXJzaW9uIHRvIGp1c3QgYmVmb3JlDQo+IHJldHVybmluZyBpbnN0ZWFkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4NCj4gU3VnZ2VzdGVk
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+DQo+IC0tLQ0K
PiAgaHcvYmxvY2svbnZtZS5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2svbnZt
ZS5jIGIvaHcvYmxvY2svbnZtZS5jDQo+IGluZGV4IDcxYjM4OGFhMGUyMC4uNzY2Y2Q1YjMzYmIx
IDEwMDY0NA0KPiAtLS0gYS9ody9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcvYmxvY2svbnZtZS5j
DQo+IEBAIC04MTUsOCArODE1LDggQEAgc3RhdGljIHVpbnQxNl90IG52bWVfZ2V0X2ZlYXR1cmUo
TnZtZUN0cmwgKm4sIE52bWVDbWQgKmNtZCwgTnZtZVJlcXVlc3QgKnJlcSkNCj4gICAgICAgICAg
dHJhY2VfcGNpX252bWVfZ2V0ZmVhdF92d2NhY2hlKHJlc3VsdCA/ICJlbmFibGVkIiA6ICJkaXNh
YmxlZCIpOw0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBjYXNlIE5WTUVfTlVNQkVSX09GX1FV
RVVFUzoNCj4gLSAgICAgICAgcmVzdWx0ID0gY3B1X3RvX2xlMzIoKG4tPnBhcmFtcy5tYXhfaW9x
cGFpcnMgLSAxKSB8DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICgobi0+cGFyYW1z
Lm1heF9pb3FwYWlycyAtIDEpIDw8IDE2KSk7DQo+ICsgICAgICAgIHJlc3VsdCA9IChuLT5wYXJh
bXMubWF4X2lvcXBhaXJzIC0gMSkgfA0KPiArICAgICAgICAgICAgKChuLT5wYXJhbXMubWF4X2lv
cXBhaXJzIC0gMSkgPDwgMTYpOw0KPiAgICAgICAgICB0cmFjZV9wY2lfbnZtZV9nZXRmZWF0X251
bXEocmVzdWx0KTsNCj4gICAgICAgICAgYnJlYWs7DQo+ICAgICAgY2FzZSBOVk1FX1RJTUVTVEFN
UDoNCj4gQEAgLTgyNiw3ICs4MjYsNyBAQCBzdGF0aWMgdWludDE2X3QgbnZtZV9nZXRfZmVhdHVy
ZShOdm1lQ3RybCAqbiwgTnZtZUNtZCAqY21kLCBOdm1lUmVxdWVzdCAqcmVxKQ0KPiAgICAgICAg
ICByZXR1cm4gTlZNRV9JTlZBTElEX0ZJRUxEIHwgTlZNRV9ETlI7DQo+ICAgICAgfQ0KPiAgDQo+
IC0gICAgcmVxLT5jcWUucmVzdWx0ID0gcmVzdWx0Ow0KPiArICAgIHJlcS0+Y3FlLnJlc3VsdCA9
IGNwdV90b19sZTMyKHJlc3VsdCk7DQo+ICAgICAgcmV0dXJuIE5WTUVfU1VDQ0VTUzsNCj4gIH0N
Cj4gIA0K

