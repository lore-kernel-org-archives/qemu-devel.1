Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1549C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEA620888
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SNbdwOHj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f4IhJOT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEA620888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsh3-0000k9-Ht
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdsg4-0008FG-UK; Wed, 27 May 2020 05:48:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdsg1-0005SY-G0; Wed, 27 May 2020 05:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590572926; x=1622108926;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1pTGeivxX7amCQ37MvYww19LJFBjZN8U2nlCnDjCpD0=;
 b=SNbdwOHjq+eLWyU4t8Us3tEgvIhPFOFVFuqKDi+Rg1umLm4CoXhcw29C
 xsMY7Q/j0bJQcVcrjWpsRrl5x0cN273paza/EA+0KKVHZB3YilubNSl56
 Lywi3R3UwxhCupIlqC7aQaNreaXLUmY5QRNuU6g8PpYC4dxbZNLgn+to7
 ZRgQVE6ay9g7YWTrKKCollucGOTmkUzxzo3BRtzULc/qR1fMQ928rAk9B
 6kHydM5dOg1NycdonfinuDpTkNHId2GDRqyy1qent+G4U9iBsdUq0xgkN
 wU2tJLwbAg21Z1TmBoCK2JH/g3F1k9YWIAr6W1VqsmooxUGztKoCy2YSb w==;
IronPort-SDR: RIOlQsj4+pzW3KGdaYEwU6v77QG/d+7rYp0VLqkCxRnboXrOWDesCq2da70iWgNO6WQhzSyS50
 tKmZN2W4VdSOia9tsOrkt5ZiM1OV3ib+zzMZ6Oh6aDrSYdMYaoG/oZLLfU7+Hh6TX+tpQUChVp
 Ip07A+YCXiws+sNquchfCa6Sp6g1/jL/7xWsTHljFsCzb2phMcuJlfHaZjr2zQlq1UjkwtvWuQ
 0wLOZ/gUFVrRGyuyqrvhDx1T1cm7VUaiRBm32nHBwNgrkZEJ1BpjEKofd9Q79IKLpDbh5KZYht
 gj4=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; d="scan'208";a="140034376"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 17:48:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV8cfk1F3wV3W4fluQijJTrq+8wd7aK4caTeEPW4RVSFoIgEzJf/VcTEceqMxkCmwYxyLnMegjh1i1+NX3CsklCk6YyCYrWBKqabPH46dqa30LmyVX67S3ezLskuxZidMjv4jjKXjNPn4tYSsYT63fKSuyCzKCoZvlzCxx5HU5D6gtudpS5qoltbOdwsjx0fjoK4ILRtiooHtwBXh6HebADuGvktLZkZiPHezbPoT8AwZLB+Z6KqQiTUfpkEeiALA9OiiFsgs6bzF63MeJSOIMqQ4aPmNMXMexV9P7PHay2Gvk7yxgYfXiJuN6491jmuYwckuwVsGYsgzg6X9HBlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pTGeivxX7amCQ37MvYww19LJFBjZN8U2nlCnDjCpD0=;
 b=AZo/irEmGNDK2rfj3Q7EaAsIwAWg6LLq35AoCgC1WerU0zjJNhiPRsBkwXe85JdYvs7j4yvX+FKov8SC6tPOvcXbNlN5n34Q8swzdT7J2zeA+65TM2Ix5FAqNrt9qSg3LVz9DSU3+uDcZfhTIoMKEpiR39n9cUAWl+Rc8ycUAewQnVC0d7XFE4INzBhGq3q1Ah1NP2dvWWkvSJMWGpgJFPbZaXCFNGcZFKyuaMKLjGI4RJF37ZzMEXpS6fR7EfNlRUVy2NmXQwyQLRelLad9Mo12El4eOvRlkm9mzzUmsKZfm4KuEUaCvbsNZ16lEIBFqIXVF+TRxj4ADblIUNwpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pTGeivxX7amCQ37MvYww19LJFBjZN8U2nlCnDjCpD0=;
 b=f4IhJOT/hCQPd7kjF8LpCtT7ym8UhTFBhAfZ0h4MNmGRI2sBXwHw8mlPfT1eZFlkmyIdL251EtKJVtff4XZzGrvC449EdqHCW2yK7bfher578vN6/SSxJt+AqI7L7RSWVE794sllzWzWt8g27+Lm/l257xre7rBJGuoTCurBwV0=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (20.178.225.224) by
 DM6PR04MB5753.namprd04.prod.outlook.com (20.179.49.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Wed, 27 May 2020 09:48:39 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 09:48:39 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
Thread-Topic: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
Thread-Index: AQHWM+mvNrZ2AnW2EUiBBv/RtOst3ai7nqMAgAAQ0PA=
Date: Wed, 27 May 2020 09:48:39 +0000
Message-ID: <DM6PR04MB6201A8060078D3539BFDE3688DB10@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <20200527054226.232103-1-anup.patel@wdc.com>
 <20200527054226.232103-2-anup.patel@wdc.com>
 <20200527084554.GC2665520@redhat.com>
In-Reply-To: <20200527084554.GC2665520@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.30.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8764f61a-1dca-4740-5494-08d802232229
x-ms-traffictypediagnostic: DM6PR04MB5753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB57530AAA47E55702C50FB26D8DB10@DM6PR04MB5753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jT/xB7qcUd9yz7mjlnJnE9O1pUKuGjpqgGc5me+B8YzXWgqz/lJ27Zs5Ycsk3edtrt8ulDFb1X9AEX3nJVpx9n2FXSyWzM9ApVv6m/u7ncCqSo+JzSEl/HcKwYrmrxMjRaPZTRxaapgzUAie0XyzjS1xqX6ImubfhWd6SAkHNguOfBmOx01jiNv9/zkwzBLTJmb92zLADOtSiHduRSdOq1eRylvnyxJju56BX+Qb/18O1uIOl71C3dVqyvJxuz5qtiLMLBeR9eBPDkjv+7Rkv9jVj3YXHi579XZZrugC8jCYiiBQdqZ5SRvmzsQzuNXRKckuaKkEzgdUNgQusAmr6HE1fon5P/Hr1XrCCwbedkvECL4in2+AgDJhePZ/gBGWEmha7V0dr55bFMHk4/uBEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(33656002)(9686003)(83380400001)(316002)(86362001)(6916009)(54906003)(53546011)(8936002)(6506007)(55236004)(71200400001)(66556008)(66476007)(2906002)(66946007)(64756008)(76116006)(7696005)(26005)(66446008)(5660300002)(186003)(8676002)(4326008)(52536014)(478600001)(966005)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 8NzRAisc7cMBBS9jFPe54G8AEL7rOctjlhTrf2n47qkpjiX3Dnc/W1zecTF4aOQDr+rObZKeE+BVfpaIQTca7Ap8EaMZnoLL99XCGQMsNjpSgNln9Y9bkSNs/Ny/+PkEGzdnNG4tqcMFdtBL3GDGJQSZHrfM5bKnvx3n/D2GRaV7RytLkwdoC0EfYolHKpQXGHBMtL8qSakuakQUSaAEyHHmMI5OYtn3YEZFFknp/b6baiz7/cJkIoxLQhoDu0wjCK2JKzednrnMB8q2ctgqmUbjx+S6lhG+4CzUNDNrbaWv82a/auAw8Mz3UoOzYA+mFLYTHQXU99ZjHK5X5cNjJSyQQRdCrae8FiSGqFMHz62OgdN/1kMBa4qRtYH1hkrbfO4Lpqgq9GUbp7K0UL/4ExPlqaSQb3VjYS49M+zaj0zMCpnVbI3hL1BG5NaMtAZ+SoSvSpvAS1BlWJvo2cTyJA7aZhQ8Oykhd47ylJljJ/w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8764f61a-1dca-4740-5494-08d802232229
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 09:48:39.2210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywVydBxVewo9qgaCS2TRaBmxhlfoIVb2TUhWj5gKaqzOCDPkhz1n4LSIfqrPxIqcAaC4THkmf/XUGYP0Y+F99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5753
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:48:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU2VudDogMjcgTWF5IDIwMjAgMTQ6MTYNCj4g
VG86IEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNvbT4NCj4gQ2M6IEVkdWFyZG8gSGFia29z
dCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT47IE1hcmNlbCBBcGZlbGJhdW0NCj4gPG1hcmNlbC5hcGZl
bGJhdW1AZ21haWwuY29tPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
PjsNCj4gUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47IEFsaXN0YWlyIEZyYW5j
aXMNCj4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47IFNhZ2FyIEthcmFuZGlrYXIgPHNhZ2Fy
a0BlZWNzLmJlcmtlbGV5LmVkdT47DQo+IEF0aXNoIFBhdHJhIDxBdGlzaC5QYXRyYUB3ZGMuY29t
PjsgcWVtdS1yaXNjdkBub25nbnUub3JnOyBxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnOyBBbnVw
IFBhdGVsIDxhbnVwQGJyYWluZmF1bHQub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEv
NV0gaHc6IEFkZCBzb2NrZXRzX3NwZWNpZmllZCBmaWVsZCBpbiBDcHVUb3BvbG9neQ0KPiANCj4g
T24gV2VkLCBNYXkgMjcsIDIwMjAgYXQgMTE6MTI6MjJBTSArMDUzMCwgQW51cCBQYXRlbCB3cm90
ZToNCj4gPiBXaGVuICJzb2NrZXRzIiBzdWItb3B0aW9uIG9mICItc21wIiBvcHRpb24gaXMgbm90
IHNwZWNpZmllZCwgdGhlDQo+ID4gc21wX3BhcnNlKCkgZnVuY3Rpb24gd2lsbCBhc3N1bWUgb25l
IENQVSBwZXItc29ja2V0IGFuZCBzZXQgdGhlIG51bWJlcg0KPiA+IG9mIHNvY2tldHMgZXF1YWwg
dG8gbnVtYmVyIG9mIENQVXMuDQo+ID4NCj4gPiBUaGlzIGlzIGNvdW50ZXItaW50dWl0aXZlIGFu
ZCB3ZSBzaG91bGQgYWxsb3cgbWFjaGluZSBlbXVsYXRpb24gdG8NCj4gPiBkZWNpZGUgZGVmYXVs
dCBudW1iZXIgb2Ygc29ja2V0cyB3aGVuICJzb2NrZXRzIiBzdWItb3B0aW9uIGlzIG5vdA0KPiA+
IHNwZWNpZmllZC4NCj4gDQo+IEkgZG9uJ3QgYWdyZWUgd2l0aCB0aGlzLiAgSGF2aW5nIHRoZSBz
ZW1hbnRpY3Mgb2YgdGhlIC1zbXAgb3B0aW9uIGJlIHRoZSBzYW1lDQo+IGFjcm9zcyBhbGwgdGFy
Z2V0cy9tYWNoaW5lcyAqaXMqIGludHVpdGl2ZS4gIENoYW5naW5nIHNlbWFudGljcyBvZiAtc21w
IHBlci0NCj4gbWFjaGluZSB3aWxsIGNyZWF0ZSBhIHdvcnNlIGV4cGVyaWFuY2UgZm9yIHBlb3Bs
ZSBjb25maWd1cmluZyBRRU1VIGFzIHRoZQ0KPiBjb25maWd1cmF0aW9uIHdpbGwgbWVhbiBkaWZm
ZXJlbnQgdGhpbmdzIGRlcGVuZGluZyBvbiB0aGUgbWFjaGluZSBjaG9jZS4NCg0KT2theSB0aGVu
IHdoeSBkb24ndCB3ZSBkZWZhdWx0IHRvIHNvY2tldHM9MSBpbiBzbXBfcGFyc2UoKSB3aGVuICJz
b2NrZXRzIg0Kc3ViLW9wdGlvbnMgaXMgbm90IHNwZWNpZmllZCA/PyBUaGlzIHdpbGwgbWFrZSBp
dCB1bmlmb3JtIGFjcm9zcyBtYWNoaW5lcy4NCg0KSXMgdGhlcmUgYSByZWFzb24gdG8gYnkgZGVm
YXVsdCBoYXZlIHNvY2tldHM9bWF4X2NwdXMgPz8NCg0KUmVnYXJkcywNCkFudXANCg0KPiANCj4g
DQo+ID4gICAgICAgICAgIFRvIGFjaGlldmUgdGhpcywgd2UgYWRkIGJvb2xlYW4gZmxhZyBzb2Nr
ZXRzX3NwZWNpZmllZCBpbg0KPiA+IHN0cnVjdCBDcHVUb3BvbG9neSB3aGljaCB0ZWxscyBtYWNo
aW5lIGVtdWxhdGlvbiB3aGV0aGVyIHRoZSAic29ja2V0cyINCj4gPiBzdWItb3B0aW9uIHdhcyBz
cGVjaWZpZWQgaW4gY29tbWFuZC1saW5lLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW51cCBQ
YXRlbCA8YW51cC5wYXRlbEB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9jb3JlL21hY2hpbmUu
YyAgIHwgMiArKw0KPiA+ICBpbmNsdWRlL2h3L2JvYXJkcy5oIHwgMiArKw0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2NvcmUv
bWFjaGluZS5jIGIvaHcvY29yZS9tYWNoaW5lLmMgaW5kZXgNCj4gPiBiYjNhN2IxOGIxLi5mZDVl
ZjVhNGJiIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2NvcmUvbWFjaGluZS5jDQo+ID4gKysrIGIvaHcv
Y29yZS9tYWNoaW5lLmMNCj4gPiBAQCAtNzA2LDYgKzcwNiw4IEBAIHN0YXRpYyB2b2lkIHNtcF9w
YXJzZShNYWNoaW5lU3RhdGUgKm1zLCBRZW11T3B0cw0KPiAqb3B0cykNCj4gPiAgICAgICAgICB1
bnNpZ25lZCBjb3JlcyAgID0gcWVtdV9vcHRfZ2V0X251bWJlcihvcHRzLCAiY29yZXMiLCAwKTsN
Cj4gPiAgICAgICAgICB1bnNpZ25lZCB0aHJlYWRzID0gcWVtdV9vcHRfZ2V0X251bWJlcihvcHRz
LCAidGhyZWFkcyIsIDApOw0KPiA+DQo+ID4gKyAgICAgICAgIG1zLT5zbXAuc29ja2V0c19zcGVj
aWZpZWQgPSAoc29ja2V0cyA9PSAwKSA/IGZhbHNlIDogdHJ1ZTsNCj4gPiArDQo+ID4gICAgICAg
ICAgLyogY29tcHV0ZSBtaXNzaW5nIHZhbHVlcywgcHJlZmVyIHNvY2tldHMgb3ZlciBjb3JlcyBv
dmVyIHRocmVhZHMgKi8NCj4gPiAgICAgICAgICBpZiAoY3B1cyA9PSAwIHx8IHNvY2tldHMgPT0g
MCkgew0KPiA+ICAgICAgICAgICAgICBjb3JlcyA9IGNvcmVzID4gMCA/IGNvcmVzIDogMTsgZGlm
ZiAtLWdpdA0KPiA+IGEvaW5jbHVkZS9ody9ib2FyZHMuaCBiL2luY2x1ZGUvaHcvYm9hcmRzLmgg
aW5kZXgNCj4gPiAxODgxNWQ5YmUyLi41OWIyOGFkYTY1IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1
ZGUvaHcvYm9hcmRzLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L2JvYXJkcy5oDQo+ID4gQEAgLTI0
NCw2ICsyNDQsNyBAQCB0eXBlZGVmIHN0cnVjdCBEZXZpY2VNZW1vcnlTdGF0ZSB7DQo+ID4gICAq
IEBjb3JlczogdGhlIG51bWJlciBvZiBjb3JlcyBpbiBvbmUgcGFja2FnZQ0KPiA+ICAgKiBAdGhy
ZWFkczogdGhlIG51bWJlciBvZiB0aHJlYWRzIGluIG9uZSBjb3JlDQo+ID4gICAqIEBzb2NrZXRz
OiB0aGUgbnVtYmVyIG9mIHNvY2tldHMgb24gdGhlIG1hY2hpbmUNCj4gPiArICogQHNvY2tldHNf
c3BlY2lmaWVkOiB0aGUgbnVtYmVyIG9mIHNvY2tldHMgd2VyZSBzcGVjaWZpZWQgZm9yIHRoZQ0K
PiA+ICsgbWFjaGluZQ0KPiA+ICAgKiBAbWF4X2NwdXM6IHRoZSBtYXhpbXVtIG51bWJlciBvZiBs
b2dpY2FsIHByb2Nlc3NvcnMgb24gdGhlIG1hY2hpbmUNCj4gPiAgICovDQo+ID4gIHR5cGVkZWYg
c3RydWN0IENwdVRvcG9sb2d5IHsNCj4gPiBAQCAtMjUxLDYgKzI1Miw3IEBAIHR5cGVkZWYgc3Ry
dWN0IENwdVRvcG9sb2d5IHsNCj4gPiAgICAgIHVuc2lnbmVkIGludCBjb3JlczsNCj4gPiAgICAg
IHVuc2lnbmVkIGludCB0aHJlYWRzOw0KPiA+ICAgICAgdW5zaWduZWQgaW50IHNvY2tldHM7DQo+
ID4gKyAgICBib29sIHNvY2tldHNfc3BlY2lmaWVkOw0KPiA+ICAgICAgdW5zaWduZWQgaW50IG1h
eF9jcHVzOw0KPiA+ICB9IENwdVRvcG9sb2d5Ow0KPiA+DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4g
Pg0KPiA+DQo+IA0KPiBSZWdhcmRzLA0KPiBEYW5pZWwNCj4gLS0NCj4gfDogaHR0cHM6Ly9iZXJy
YW5nZS5jb20gICAgICAtby0gICAgaHR0cHM6Ly93d3cuZmxpY2tyLmNvbS9waG90b3MvZGJlcnJh
bmdlIDp8DQo+IHw6IGh0dHBzOi8vbGlidmlydC5vcmcgICAgICAgICAtby0gICAgICAgICAgICBo
dHRwczovL2ZzdG9wMTM4LmJlcnJhbmdlLmNvbSA6fA0KPiB8OiBodHRwczovL2VudGFuZ2xlLXBo
b3RvLm9yZyAgICAtby0gICAgaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9kYmVycmFuZ2UgOnwN
Cg0K

