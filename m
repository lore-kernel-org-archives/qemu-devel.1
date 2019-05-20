Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871E1C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416FB20815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gWFXLnaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416FB20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59619 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSd2t-0000A2-Gd
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 03:49:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSd1U-0007xo-H2
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSd1T-0000wQ-84
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:47:52 -0400
Received: from mail-eopbgr140119.outbound.protection.outlook.com
	([40.107.14.119]:34629
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hSd1P-0000tl-NC; Mon, 20 May 2019 03:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=r43h7XEhxspgjDlTMI1pTOlyLovlymkema9T8ugaZEw=;
	b=gWFXLnaj3j3TL2TpIlaiSdNcxvvjVDSU03HmCT3Edtaa/u383w1f5OSnKnaZj5ToWO3Fu9sxlJyOpIW8jxzS4l1BdqZzddj6GtKvNIXp3yPelMZClAG3A3T0KtE4AZ84MP8thzDh8ySYvjGojScP8hTqQ4wdPyjo5caE8ZNKEhI=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB3686.eurprd08.prod.outlook.com (20.178.91.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Mon, 20 May 2019 07:47:43 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Mon, 20 May 2019 07:47:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 2/2] iotests: test external snapshot with bitmap
	copying
Thread-Index: AQHVDMRByx866r1qO0izJzYzCi+V9KZwGWuAgAONp4A=
Date: Mon, 20 May 2019 07:47:43 +0000
Message-ID: <80ec2d88-4682-4204-d693-d6d8aceab92e@virtuozzo.com>
References: <20190517152111.206494-1-vsementsov@virtuozzo.com>
	<20190517152111.206494-3-vsementsov@virtuozzo.com>
	<25aed11e-8772-97c8-152b-2a8333e7253f@redhat.com>
In-Reply-To: <25aed11e-8772-97c8-152b-2a8333e7253f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0001.eurprd07.prod.outlook.com
	(2603:10a6:7:67::11) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190520104741604
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 130bc749-706a-4b93-f653-08d6dcf7712f
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3686; 
x-ms-traffictypediagnostic: AM6PR08MB3686:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB36867238CA699F52551B4DF4C1060@AM6PR08MB3686.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(71190400001)(71200400001)(52116002)(4326008)(54906003)(86362001)(76176011)(5660300002)(256004)(229853002)(99286004)(476003)(2616005)(25786009)(2501003)(486006)(446003)(53546011)(6506007)(386003)(66066001)(186003)(2201001)(31696002)(107886003)(6246003)(110136005)(102836004)(11346002)(3846002)(6116002)(305945005)(14454004)(81166006)(8676002)(81156014)(8936002)(31686004)(26005)(53936002)(7736002)(6512007)(6306002)(6486002)(6436002)(66946007)(73956011)(36756003)(64756008)(66446008)(478600001)(2906002)(316002)(68736007)(66476007)(66556008)(2004002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3686;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B0C+BIlpcUnw8yfw15mEH8JfmYyoTggqapy7ERBVQ26nvI5MLMMl2378hLieOnlr7DnHiO1v0EYW6Kkdc6MtQYhQPHOFXHRTL47yIdYoYeepLVG5EP0PtlwkhDkfkB+537c1SXO1F08Q1yhAXXiyT4M8SBAWaXXIGtNX6kkgBLCd2uI1m9Hq6SHC+KM3O0tQyDNt2iyto9Sw7uPduvLpg253/Cb+fj0oVhAa1sV5DRTEIhVtHS0hG8pOpNOvLRvzneRENcOspJhb3C4SPS8zylbCO8B3QtvXKfDCWHcD0zQJB8BjXKrTPvf3cM5lWONn68h4Cge1m56tD1pAML2/Mku5q4FLAvU1tuptds3S1OBeqsn656PP0ISCfvtVZneGYzHFKFzbiNSXaol/MiAstsXtpZ1RK7gyxmjJzNMgwoI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80C4782D365D9D4EB8F6DF8A125DC3DB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130bc749-706a-4b93-f653-08d6dcf7712f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 07:47:43.6993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3686
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.119
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: test external snapshot
 with bitmap copying
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDUuMjAxOSA0OjMxLCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gNS8xNy8xOSAx
MToyMSBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFRoaXMgdGVz
dCBzaG93cyB0aGF0IGV4dGVybmFsIHNuYXBzaG90cyBhbmQgaW5jcmVtZW50YWwgYmFja3VwcyBh
cmUNCj4+IGZyaWVuZHMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIHRlc3Rz
L3FlbXUtaW90ZXN0cy8yNTQgICAgIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NC5vdXQgfCA1MiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvZ3Jv
dXAgICB8ICAxICsNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMDUgaW5zZXJ0aW9ucygrKQ0KPj4g
ICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NA0KPj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NC5vdXQNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1NCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNTQNCj4+IG5l
dyBmaWxlIG1vZGUgMTAwNzU1DQo+PiBpbmRleCAwMDAwMDAwMDAwLi4zM2NiODBhNTEyDQo+PiAt
LS0gL2Rldi9udWxsDQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjU0DQo+PiBAQCAtMCww
ICsxLDUyIEBADQo+PiArIyEvdXNyL2Jpbi9lbnYgcHl0aG9uDQo+PiArIw0KPj4gKyMgVGVzdCBl
eHRlcm5hbCBzbmFwc2hvdCB3aXRoIGJpdG1hcCBjb3B5aW5nLg0KPj4gKyMNCj4+ICsjIENvcHly
aWdodCAoYykgMjAxOSBWaXJ0dW96em8gSW50ZXJuYXRpb25hbCBHbWJILiBBbGwgcmlnaHRzIHJl
c2VydmVkLg0KPj4gKyMNCj4+ICsjIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+PiArIyBpdCB1bmRlciB0aGUgdGVy
bXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KPj4g
KyMgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUg
TGljZW5zZSwgb3INCj4+ICsjIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQo+
PiArIw0KPj4gKyMgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQg
aXQgd2lsbCBiZSB1c2VmdWwsDQo+PiArIyBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhv
dXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KPj4gKyMgTUVSQ0hBTlRBQklMSVRZIG9y
IEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KPj4gKyMgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4+ICsjDQo+PiArIyBZb3Ug
c2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZQ0KPj4gKyMgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW0uICBJZiBub3QsIHNlZSA8aHR0cDov
L3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQo+PiArIw0KPj4gKw0KPj4gK2ltcG9ydCBpb3Rlc3Rz
DQo+PiArZnJvbSBpb3Rlc3RzIGltcG9ydCBxZW11X2ltZ19jcmVhdGUsIGZpbGVfcGF0aCwgbG9n
DQo+PiArDQo+PiArZGlzaywgdG9wID0gZmlsZV9wYXRoKCdkaXNrJywgJ3RvcCcpDQo+PiArc2l6
ZSA9IDEwMjQgKiAxMDI0DQo+PiArDQo+PiArcWVtdV9pbWdfY3JlYXRlKCctZicsIGlvdGVzdHMu
aW1nZm10LCBkaXNrLCBzdHIoc2l6ZSkpDQo+PiArDQo+PiArdm0gPSBpb3Rlc3RzLlZNKCkuYWRk
X2RyaXZlKGRpc2ssIG9wdHM9J25vZGUtbmFtZT1iYXNlJykNCj4+ICt2bS5sYXVuY2goKQ0KPj4g
Kw0KPj4gK3ZtLnFtcF9sb2coJ2Jsb2NrLWRpcnR5LWJpdG1hcC1hZGQnLCBub2RlPSdkcml2ZTAn
LCBuYW1lPSdiaXRtYXAwJykNCj4+ICsNCj4+ICt2bS5obXBfcWVtdV9pbygnZHJpdmUwJywgJ3dy
aXRlIDAgNTEySycpDQo+PiArDQo+PiArdm0ucW1wX2xvZygndHJhbnNhY3Rpb24nLCBpbmRlbnQ9
MiwgYWN0aW9ucz1bDQo+PiArICAgIHsndHlwZSc6ICdibG9ja2Rldi1zbmFwc2hvdC1zeW5jJywN
Cj4+ICsgICAgICdkYXRhJzogeydkZXZpY2UnOiAnZHJpdmUwJywgJ3NuYXBzaG90LWZpbGUnOiB0
b3AsDQo+PiArICAgICAgICAgICAgICAnc25hcHNob3Qtbm9kZS1uYW1lJzogJ3NuYXAnfX0sDQo+
PiArICAgIHsndHlwZSc6ICdibG9jay1kaXJ0eS1iaXRtYXAtYWRkJywNCj4+ICsgICAgICdkYXRh
Jzogeydub2RlJzogJ3NuYXAnLCAnbmFtZSc6ICdiaXRtYXAwJ319LA0KPj4gKyAgICB7J3R5cGUn
OiAnYmxvY2stZGlydHktYml0bWFwLW1lcmdlJywNCj4+ICsgICAgICdkYXRhJzogeydub2RlJzog
J3NuYXAnLCAndGFyZ2V0JzogJ2JpdG1hcDAnLA0KPj4gKyAgICAgICAgICAgICAgJ2JpdG1hcHMn
OiBbeydub2RlJzogJ2Jhc2UnLCAnbmFtZSc6ICdiaXRtYXAwJ31dfX0NCj4+ICtdLCBmaWx0ZXJz
PVtpb3Rlc3RzLmZpbHRlcl9xbXBfdGVzdGZpbGVzXSkNCj4+ICsNCj4+ICtyZXN1bHQgPSB2bS5x
bXAoJ3F1ZXJ5LWJsb2NrJylbJ3JldHVybiddWzBdDQo+PiArbG9nKCJxdWVyeS1ibG9jazogZGV2
aWNlID0ge30sIG5vZGUtbmFtZSA9IHt9LCBkaXJ0eS1iaXRtYXBzOiIuZm9ybWF0KA0KPj4gKyAg
ICByZXN1bHRbJ2RldmljZSddLCByZXN1bHRbJ2luc2VydGVkJ11bJ25vZGUtbmFtZSddKSkNCj4+
ICtsb2cocmVzdWx0WydkaXJ0eS1iaXRtYXBzJ10sIGluZGVudD0yKQ0KPj4gKw0KPj4gK3ZtLnNo
dXRkb3duKCkNCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMjU0Lm91dCBiL3Rl
c3RzL3FlbXUtaW90ZXN0cy8yNTQub3V0DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5k
ZXggMDAwMDAwMDAwMC4uZDczOTRjZjAwMg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdGVz
dHMvcWVtdS1pb3Rlc3RzLzI1NC5vdXQNCj4+IEBAIC0wLDAgKzEsNTIgQEANCj4+ICt7ImV4ZWN1
dGUiOiAiYmxvY2stZGlydHktYml0bWFwLWFkZCIsICJhcmd1bWVudHMiOiB7Im5hbWUiOiAiYml0
bWFwMCIsICJub2RlIjogImRyaXZlMCJ9fQ0KPj4gK3sicmV0dXJuIjoge319DQo+PiArew0KPj4g
KyAgImV4ZWN1dGUiOiAidHJhbnNhY3Rpb24iLA0KPj4gKyAgImFyZ3VtZW50cyI6IHsNCj4+ICsg
ICAgImFjdGlvbnMiOiBbDQo+PiArICAgICAgew0KPj4gKyAgICAgICAgImRhdGEiOiB7DQo+PiAr
ICAgICAgICAgICJkZXZpY2UiOiAiZHJpdmUwIiwNCj4+ICsgICAgICAgICAgInNuYXBzaG90LWZp
bGUiOiAiVEVTVF9ESVIvUElELXRvcCIsDQo+PiArICAgICAgICAgICJzbmFwc2hvdC1ub2RlLW5h
bWUiOiAic25hcCINCj4+ICsgICAgICAgIH0sDQo+PiArICAgICAgICAidHlwZSI6ICJibG9ja2Rl
di1zbmFwc2hvdC1zeW5jIg0KPj4gKyAgICAgIH0sDQo+PiArICAgICAgew0KPj4gKyAgICAgICAg
ImRhdGEiOiB7DQo+PiArICAgICAgICAgICJuYW1lIjogImJpdG1hcDAiLA0KPj4gKyAgICAgICAg
ICAibm9kZSI6ICJzbmFwIg0KPj4gKyAgICAgICAgfSwNCj4+ICsgICAgICAgICJ0eXBlIjogImJs
b2NrLWRpcnR5LWJpdG1hcC1hZGQiDQo+PiArICAgICAgfSwNCj4+ICsgICAgICB7DQo+PiArICAg
ICAgICAiZGF0YSI6IHsNCj4+ICsgICAgICAgICAgImJpdG1hcHMiOiBbDQo+PiArICAgICAgICAg
ICAgew0KPj4gKyAgICAgICAgICAgICAgIm5hbWUiOiAiYml0bWFwMCIsDQo+PiArICAgICAgICAg
ICAgICAibm9kZSI6ICJiYXNlIg0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgXSwN
Cj4+ICsgICAgICAgICAgIm5vZGUiOiAic25hcCIsDQo+PiArICAgICAgICAgICJ0YXJnZXQiOiAi
Yml0bWFwMCINCj4+ICsgICAgICAgIH0sDQo+PiArICAgICAgICAidHlwZSI6ICJibG9jay1kaXJ0
eS1iaXRtYXAtbWVyZ2UiDQo+PiArICAgICAgfQ0KPj4gKyAgICBdDQo+PiArICB9DQo+PiArfQ0K
Pj4gK3sNCj4+ICsgICJyZXR1cm4iOiB7fQ0KPj4gK30NCj4+ICtxdWVyeS1ibG9jazogZGV2aWNl
ID0gZHJpdmUwLCBub2RlLW5hbWUgPSBzbmFwLCBkaXJ0eS1iaXRtYXBzOg0KPj4gK1sNCj4+ICsg
IHsNCj4+ICsgICAgImJ1c3kiOiBmYWxzZSwNCj4+ICsgICAgImNvdW50IjogNTI0Mjg4LA0KPj4g
KyAgICAiZ3JhbnVsYXJpdHkiOiA2NTUzNiwNCj4+ICsgICAgIm5hbWUiOiAiYml0bWFwMCIsDQo+
PiArICAgICJwZXJzaXN0ZW50IjogZmFsc2UsDQo+PiArICAgICJyZWNvcmRpbmciOiB0cnVlLA0K
Pj4gKyAgICAic3RhdHVzIjogImFjdGl2ZSINCj4+ICsgIH0NCj4+ICtdDQo+PiBkaWZmIC0tZ2l0
IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+
PiBpbmRleCAwMGU0NzRhYjBhLi41NTUyZDAxNTNjIDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMvcWVt
dS1pb3Rlc3RzL2dyb3VwDQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXANCj4+IEBA
IC0yNTAsMyArMjUwLDQgQEANCj4+ICAgMjQ4IHJ3IGF1dG8gcXVpY2sNCj4+ICAgMjQ5IHJ3IGF1
dG8gcXVpY2sNCj4+ICAgMjUyIHJ3IGF1dG8gYmFja2luZyBxdWljaw0KPj4gKzI1NCBydyBhdXRv
IGJhY2tpbmcgcXVpY2sNCj4+DQo+IA0KPiBSZXZpZXdlZC1ieTogSm9obiBTbm93IDxqc25vd0By
ZWRoYXQuY29tPg0KPiANCj4gV2Ugd2lsbCBldmVudHVhbGx5IHdhbnQgc29tZXRoaW5nIG1vcmUg
cmlnb3JvdXMgaW4gdGVybXMgb2YgYSBmdWxsDQo+IHdvcmtmbG93LCBidXQgZm9yIHRoZSBwdXJw
b3NlcyBvZiB0ZXN0aW5nIGNyb3NzLW5vZGUgbWVyZ2UgSSB0aGluayB0aGlzDQo+IGRlbW9uc3Ry
YXRlcyBpdCBmaW5lLg0KPiANCj4gSSdsbCBzdGFnZSB0aGVzZSBzaG9ydGx5Lg0KPiANCg0KVGhh
bmsgeW91IQ0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

