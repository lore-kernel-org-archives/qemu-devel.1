Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F1AC282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3BA20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L/TDZ4bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3BA20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGpH-0008UJ-1H
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46618)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGmY-00079L-4S
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGmR-0001ZC-Ih
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:39:57 -0400
Received: from mail-eopbgr40119.outbound.protection.outlook.com
 ([40.107.4.119]:18737 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1haGmJ-0001L3-7y; Mon, 10 Jun 2019 05:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGB8EMFPX8g4aBbziTTT/yRg3h7qu1EBsFiAARyvS9o=;
 b=L/TDZ4bjQVVGVYV0azN4ozZUL3dFKYT2GyM1ARQ2M4jEF3ma7edEpe8cnheRqOIZpMK5FwP/nBwJx+w2AdQ4bZ2ALf1UnCGmvk39V49l90DyiB1G44vA2kHSlzVwajn/Q54VhHvxMEvoc33IKutW6eIBz3pGsqLcOYJ/+GQqDQc=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3316.eurprd08.prod.outlook.com (52.134.94.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Mon, 10 Jun 2019 09:39:35 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 09:39:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/4] qapi: implement
 block-dirty-bitmap-remove transaction action
Thread-Index: AQHVGgPxBflgMIpOekuuewDr06rGaaaQ1NkAgAPX7wA=
Date: Mon, 10 Jun 2019 09:39:34 +0000
Message-ID: <ebf32e4b-329c-a029-1d0a-7b00d6e36a89@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
 <20190603120005.37394-4-vsementsov@virtuozzo.com>
 <3a4fc82e-1f23-1843-ab4e-7a16a6bd634d@redhat.com>
In-Reply-To: <3a4fc82e-1f23-1843-ab4e-7a16a6bd634d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::32) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190610123932459
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f7567e5-8cfe-4512-8b29-08d6ed878c0d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3316; 
x-ms-traffictypediagnostic: AM0PR08MB3316:
x-microsoft-antispam-prvs: <AM0PR08MB331668F7A21E493DB2F85DF5C1130@AM0PR08MB3316.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(31696002)(2616005)(256004)(486006)(14444005)(446003)(8676002)(81166006)(186003)(36756003)(316002)(26005)(81156014)(53936002)(6246003)(5660300002)(68736007)(107886003)(110136005)(476003)(478600001)(11346002)(66066001)(386003)(2201001)(2906002)(54906003)(86362001)(6506007)(53546011)(102836004)(76176011)(3846002)(52116002)(229853002)(6116002)(25786009)(8936002)(99286004)(4326008)(6512007)(73956011)(66946007)(66446008)(64756008)(66556008)(66476007)(6436002)(2501003)(14454004)(71200400001)(31686004)(7736002)(305945005)(71190400001)(6486002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3316;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VSx+ComYsfGVNvo30SRReZYDip8rCy+KIdUQK2tYn8VIIrulrAxM3Jfgu0xv8pM6r8TAkn0dr4SDHCtz/Gv1yDekcJw4biIfqANPmIqWjLoFWUbWZZ0dyqhTUVwjZU/pYhibi25YcWrWSeQrBWdeRlcApnHTyuT5L1wRapAPN2sJnFN+wiCdoOlud3pUjshpnrmbaDOoPyO95WwxJXFNMLq95kIubZ+yPOb3z/I3+HTir559yXxe9cfo+yqk1qGFchTbjEFT7OLTlqtiXMIcxLzT42lRfv6FnhvgrPf7vGpJUyG7KmJH0wczYnuqSSKL8/lE7DgGgHTmbwq7hKEuUKztnd45XLnS/Znwaj0L8YfiZUPlGBGjyZCPmRuf2GpefXpppTArUbLhwXZLQ6zdtaG/YQJpo/881nw9MHvioxw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF0BB156E80A134C94BD1E0344AAE7B6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7567e5-8cfe-4512-8b29-08d6ed878c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 09:39:34.9247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3316
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.119
Subject: Re: [Qemu-devel] [PATCH 3/4] qapi: implement
 block-dirty-bitmap-remove transaction action
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMDYuMjAxOSAxOjU3LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gNi8zLzE5IDg6
MDAgQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBJdCBpcyB1c2Vk
IHRvIGRvIHRyYW5zYWN0aW9uYWwgbW92ZW1lbnQgb2YgdGhlIGJpdG1hcCAod2hpY2ggaXMNCj4+
IHBvc3NpYmxlIGluIGNvbmp1bmN0aW9uIHdpdGggbWVyZ2UgY29tbWFuZCkuIFRyYW5zYWN0aW9u
YWwgYml0bWFwDQo+PiBtb3ZlbWVudCBpcyBuZWVkZWQgaW4gc2NlbmFyaW9zIHdpdGggZXh0ZXJu
YWwgc25hcHNob3QsIHdoZW4gd2UgZG9uJ3QNCj4+IHdhbnQgdG8gbGVhdmUgY29weSBvZiB0aGUg
Yml0bWFwIGluIHRoZSBiYXNlIGltYWdlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0K
Pj4gICBxYXBpL3RyYW5zYWN0aW9uLmpzb24gfCAgMiArKw0KPj4gICBibG9ja2Rldi5jICAgICAg
ICAgICAgfCA3NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvcWFwaS90cmFuc2FjdGlvbi5qc29uIGIvcWFwaS90cmFuc2FjdGlv
bi5qc29uDQo+PiBpbmRleCA5NWVkYjc4MjI3Li5kYTk1YjgwNGFhIDEwMDY0NA0KPj4gLS0tIGEv
cWFwaS90cmFuc2FjdGlvbi5qc29uDQo+PiArKysgYi9xYXBpL3RyYW5zYWN0aW9uLmpzb24NCj4+
IEBAIC00NSw2ICs0NSw3IEBADQo+PiAgICMNCj4+ICAgIyAtIEBhYm9ydDogc2luY2UgMS42DQo+
PiAgICMgLSBAYmxvY2stZGlydHktYml0bWFwLWFkZDogc2luY2UgMi41DQo+PiArIyAtIEBibG9j
ay1kaXJ0eS1iaXRtYXAtcmVtb3ZlOiBzaW5jZSA0LjENCj4+ICAgIyAtIEBibG9jay1kaXJ0eS1i
aXRtYXAtY2xlYXI6IHNpbmNlIDIuNQ0KPj4gICAjIC0gQGJsb2NrLWRpcnR5LWJpdG1hcC1lbmFi
bGU6IHNpbmNlIDQuMA0KPj4gICAjIC0gQGJsb2NrLWRpcnR5LWJpdG1hcC1kaXNhYmxlOiBzaW5j
ZSA0LjANCj4+IEBAIC02MSw2ICs2Miw3IEBADQo+PiAgICAgJ2RhdGEnOiB7DQo+PiAgICAgICAg
ICAnYWJvcnQnOiAnQWJvcnQnLA0KPj4gICAgICAgICAgJ2Jsb2NrLWRpcnR5LWJpdG1hcC1hZGQn
OiAnQmxvY2tEaXJ0eUJpdG1hcEFkZCcsDQo+PiArICAgICAgICdibG9jay1kaXJ0eS1iaXRtYXAt
cmVtb3ZlJzogJ0Jsb2NrRGlydHlCaXRtYXAnLA0KPj4gICAgICAgICAgJ2Jsb2NrLWRpcnR5LWJp
dG1hcC1jbGVhcic6ICdCbG9ja0RpcnR5Qml0bWFwJywNCj4+ICAgICAgICAgICdibG9jay1kaXJ0
eS1iaXRtYXAtZW5hYmxlJzogJ0Jsb2NrRGlydHlCaXRtYXAnLA0KPj4gICAgICAgICAgJ2Jsb2Nr
LWRpcnR5LWJpdG1hcC1kaXNhYmxlJzogJ0Jsb2NrRGlydHlCaXRtYXAnLA0KPj4gZGlmZiAtLWdp
dCBhL2Jsb2NrZGV2LmMgYi9ibG9ja2Rldi5jDQo+PiBpbmRleCA1YjNlZWYwZDNlLi4wZDlhYTdm
MGExIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2tkZXYuYw0KPj4gKysrIGIvYmxvY2tkZXYuYw0KPj4g
QEAgLTIxMzUsNiArMjEzNSw0NiBAQCBzdGF0aWMgdm9pZCBibG9ja19kaXJ0eV9iaXRtYXBfbWVy
Z2VfcHJlcGFyZShCbGtBY3Rpb25TdGF0ZSAqY29tbW9uLA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJwKTsNCj4+ICAgfQ0KPj4gICANCj4+
ICtzdGF0aWMgQmRydkRpcnR5Qml0bWFwICpkb19ibG9ja19kaXJ0eV9iaXRtYXBfcmVtb3ZlKA0K
Pj4gKyAgICAgICAgY29uc3QgY2hhciAqbm9kZSwgY29uc3QgY2hhciAqbmFtZSwgYm9vbCByZWxl
YXNlLA0KPj4gKyAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqKmJpdG1hcF9icywgRXJyb3IgKipl
cnJwKTsNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBibG9ja19kaXJ0eV9iaXRtYXBfcmVtb3ZlX3By
ZXBhcmUoQmxrQWN0aW9uU3RhdGUgKmNvbW1vbiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgQmxv
Y2tEaXJ0eUJpdG1hcCAqYWN0aW9uOw0KPj4gKyAgICBCbG9ja0RpcnR5Qml0bWFwU3RhdGUgKnN0
YXRlID0gRE9fVVBDQVNUKEJsb2NrRGlydHlCaXRtYXBTdGF0ZSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21tb24sIGNvbW1vbik7DQo+PiArDQo+
PiArICAgIGlmIChhY3Rpb25fY2hlY2tfY29tcGxldGlvbl9tb2RlKGNvbW1vbiwgZXJycCkgPCAw
KSB7DQo+PiArICAgICAgICByZXR1cm47DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgYWN0aW9u
ID0gY29tbW9uLT5hY3Rpb24tPnUuYmxvY2tfZGlydHlfYml0bWFwX3JlbW92ZS5kYXRhOw0KPj4g
Kw0KPj4gKyAgICBzdGF0ZS0+Yml0bWFwID0gZG9fYmxvY2tfZGlydHlfYml0bWFwX3JlbW92ZShh
Y3Rpb24tPm5vZGUsIGFjdGlvbi0+bmFtZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmFsc2UsICZzdGF0ZS0+YnMsIGVycnApOw0KPj4gKyAg
ICBpZiAoc3RhdGUtPmJpdG1hcCkgew0KPj4gKyAgICAgICAgYmRydl9kaXJ0eV9iaXRtYXBfaGlk
ZShzdGF0ZS0+Yml0bWFwKTsNCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9p
ZCBibG9ja19kaXJ0eV9iaXRtYXBfcmVtb3ZlX2Fib3J0KEJsa0FjdGlvblN0YXRlICpjb21tb24p
DQo+PiArew0KPj4gKyAgICBCbG9ja0RpcnR5Qml0bWFwU3RhdGUgKnN0YXRlID0gRE9fVVBDQVNU
KEJsb2NrRGlydHlCaXRtYXBTdGF0ZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb21tb24sIGNvbW1vbik7DQo+PiArDQo+PiArICAgIGJkcnZfZGly
dHlfYml0bWFwX3VuaGlkZShzdGF0ZS0+Yml0bWFwKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGlj
IHZvaWQgYmxvY2tfZGlydHlfYml0bWFwX3JlbW92ZV9jb21taXQoQmxrQWN0aW9uU3RhdGUgKmNv
bW1vbikNCj4+ICt7DQo+PiArICAgIEJsb2NrRGlydHlCaXRtYXBTdGF0ZSAqc3RhdGUgPSBET19V
UENBU1QoQmxvY2tEaXJ0eUJpdG1hcFN0YXRlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbW1vbiwgY29tbW9uKTsNCj4+ICsNCj4+ICsgICAgYmRy
dl9yZWxlYXNlX2RpcnR5X2JpdG1hcChzdGF0ZS0+YnMsIHN0YXRlLT5iaXRtYXApOw0KPj4gK30N
Cj4+ICsNCj4+ICAgc3RhdGljIHZvaWQgYWJvcnRfcHJlcGFyZShCbGtBY3Rpb25TdGF0ZSAqY29t
bW9uLCBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+ICAgICAgIGVycm9yX3NldGcoZXJycCwgIlRy
YW5zYWN0aW9uIGFib3J0ZWQgdXNpbmcgQWJvcnQgYWN0aW9uIik7DQo+PiBAQCAtMjIxMiw2ICsy
MjUyLDEyIEBAIHN0YXRpYyBjb25zdCBCbGtBY3Rpb25PcHMgYWN0aW9uc1tdID0gew0KPj4gICAg
ICAgICAgIC5jb21taXQgPSBibG9ja19kaXJ0eV9iaXRtYXBfZnJlZV9iYWNrdXAsDQo+PiAgICAg
ICAgICAgLmFib3J0ID0gYmxvY2tfZGlydHlfYml0bWFwX3Jlc3RvcmUsDQo+PiAgICAgICB9LA0K
Pj4gKyAgICBbVFJBTlNBQ1RJT05fQUNUSU9OX0tJTkRfQkxPQ0tfRElSVFlfQklUTUFQX1JFTU9W
RV0gPSB7DQo+PiArICAgICAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihCbG9ja0RpcnR5Qml0
bWFwU3RhdGUpLA0KPj4gKyAgICAgICAgLnByZXBhcmUgPSBibG9ja19kaXJ0eV9iaXRtYXBfcmVt
b3ZlX3ByZXBhcmUsDQo+PiArICAgICAgICAuY29tbWl0ID0gYmxvY2tfZGlydHlfYml0bWFwX3Jl
bW92ZV9jb21taXQsDQo+PiArICAgICAgICAuYWJvcnQgPSBibG9ja19kaXJ0eV9iaXRtYXBfcmVt
b3ZlX2Fib3J0LA0KPj4gKyAgICB9LA0KPj4gICAgICAgLyogV2hlcmUgYXJlIHRyYW5zYWN0aW9u
cyBmb3IgTUlSUk9SLCBDT01NSVQgYW5kIFNUUkVBTT8NCj4+ICAgICAgICAqIEFsdGhvdWdoIHRo
ZXNlIGJsb2Nram9icyB1c2UgdHJhbnNhY3Rpb24gY2FsbGJhY2tzIGxpa2UgdGhlIGJhY2t1cCBq
b2IsDQo+PiAgICAgICAgKiB0aGVzZSBqb2JzIGRvIG5vdCBuZWNlc3NhcmlseSBhZGhlcmUgdG8g
dHJhbnNhY3Rpb24gc2VtYW50aWNzLg0KPj4gQEAgLTI4NzAsMjAgKzI5MTYsMjEgQEAgdm9pZCBx
bXBfYmxvY2tfZGlydHlfYml0bWFwX2FkZChjb25zdCBjaGFyICpub2RlLCBjb25zdCBjaGFyICpu
YW1lLA0KPj4gICAgICAgYmRydl9kaXJ0eV9iaXRtYXBfc2V0X3BlcnNpc3RlbmNlKGJpdG1hcCwg
cGVyc2lzdGVudCk7DQo+PiAgIH0NCj4+ICAgDQo+PiAtdm9pZCBxbXBfYmxvY2tfZGlydHlfYml0
bWFwX3JlbW92ZShjb25zdCBjaGFyICpub2RlLCBjb25zdCBjaGFyICpuYW1lLA0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3N0YXRpYyBC
ZHJ2RGlydHlCaXRtYXAgKmRvX2Jsb2NrX2RpcnR5X2JpdG1hcF9yZW1vdmUoDQo+PiArICAgICAg
ICBjb25zdCBjaGFyICpub2RlLCBjb25zdCBjaGFyICpuYW1lLCBib29sIHJlbGVhc2UsDQo+PiAr
ICAgICAgICBCbG9ja0RyaXZlclN0YXRlICoqYml0bWFwX2JzLCBFcnJvciAqKmVycnApDQo+IA0K
PiBIbSwgd2h5IGRvZXMgdGhlIGhpZGUgZmVhdHVyZSBuZWVkIHRvIGNvcHkgdGhlIHBlcnNpc3Rl
bnQgYml0IHdoZW4gd2UncmUNCj4gcmVtb3ZpbmcgaXQgaGVyZSBhbnl3YXk/DQo+IA0KPiBJZiBy
ZWxlYXNlIGlzIGZhbHNlLCB3ZSBzdGlsbCBjYWxsIGJkcnZfcmVtb3ZlX3BlcnNpc3RlbnRfZGly
dHlfYml0bWFwLA0KPiB5ZWFoPw0KPiANCj4gQW5kIHdoZW4gd2UgZ28gdG8gdW5kbyBpdCwgd2Ug
d29uJ3QgaGF2ZSB1bmRvbmUgdGhlIHBlcnNpc3RlbnQgcmVtb3ZhbCwNCj4gcmlnaHQ/DQoNCkht
LCBnb29kIHF1ZXN0aW9uLiBJIHJlbWVtYmVyIHRoZXJlIHdhcyBiYWQgdGhpbmcgb24gc3Rvcmlu
ZyBwZXJzaXN0ZW50IGJpdG1hcCwNCmFzIHRoaXMgY29kZSBpcyBub3QgcHJlcGFyZWQgZm9yIHVu
bmFtZWQgcGVyc2lzdGVudCBiaXRtYXBzLiBBaGEsIEkgd2FzIHdyb25nIGluDQpteSBwcmV2aW91
cyBhbnN3ZXIsIGl0IGlzIHZhbGlkIHRvIGdvIHRvIHN0b3JpbmcgZHVyaW5nIHRyYW5zYWN0aW9u
LCBhbmQgdGhpcyBpcw0KZXhhY3RseSByZW9wZW4gdG8gUk8uIFNvIHdlIG11c3QgZHJvcCBwZXJz
aXN0ZW5jZS4NCg0KPiANCj4+ICAgew0KPj4gICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnM7DQo+
PiAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcDsNCj4+ICAgDQo+PiAgICAgICBiaXRtYXAg
PSBibG9ja19kaXJ0eV9iaXRtYXBfbG9va3VwKG5vZGUsIG5hbWUsICZicywgZXJycCk7DQo+PiAg
ICAgICBpZiAoIWJpdG1hcCB8fCAhYnMpIHsNCj4+IC0gICAgICAgIHJldHVybjsNCj4+ICsgICAg
ICAgIHJldHVybiBOVUxMOw0KPj4gICAgICAgfQ0KPj4gICANCj4+ICAgICAgIGlmIChiZHJ2X2Rp
cnR5X2JpdG1hcF9jaGVjayhiaXRtYXAsIEJEUlZfQklUTUFQX0JVU1kgfCBCRFJWX0JJVE1BUF9S
TywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJwKSkgew0KPj4gLSAg
ICAgICAgcmV0dXJuOw0KPj4gKyAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiAgICAgICB9DQo+PiAg
IA0KPj4gICAgICAgaWYgKGJkcnZfZGlydHlfYml0bWFwX2dldF9wZXJzaXN0ZW5jZShiaXRtYXAp
KSB7DQo+PiBAQCAtMjg5MywxMyArMjk0MCwyOCBAQCB2b2lkIHFtcF9ibG9ja19kaXJ0eV9iaXRt
YXBfcmVtb3ZlKGNvbnN0IGNoYXIgKm5vZGUsIGNvbnN0IGNoYXIgKm5hbWUsDQo+PiAgICAgICAg
ICAgYWlvX2NvbnRleHRfYWNxdWlyZShhaW9fY29udGV4dCk7DQo+PiAgICAgICAgICAgYmRydl9y
ZW1vdmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXAoYnMsIG5hbWUsICZsb2NhbF9lcnIpOw0KPj4g
ICAgICAgICAgIGFpb19jb250ZXh0X3JlbGVhc2UoYWlvX2NvbnRleHQpOw0KPj4gKw0KPj4gICAg
ICAgICAgIGlmIChsb2NhbF9lcnIgIT0gTlVMTCkgew0KPj4gICAgICAgICAgICAgICBlcnJvcl9w
cm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsNCj4+IC0gICAgICAgICAgICByZXR1cm47DQo+PiAr
ICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiAgICAgICAgICAgfQ0KPj4gICAgICAgfQ0KPj4g
ICANCj4+IC0gICAgYmRydl9yZWxlYXNlX2RpcnR5X2JpdG1hcChicywgYml0bWFwKTsNCj4+ICsg
ICAgaWYgKHJlbGVhc2UpIHsNCj4+ICsgICAgICAgIGJkcnZfcmVsZWFzZV9kaXJ0eV9iaXRtYXAo
YnMsIGJpdG1hcCk7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaWYgKGJpdG1hcF9icykgew0K
Pj4gKyAgICAgICAgKmJpdG1hcF9icyA9IGJzOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJl
dHVybiBiaXRtYXA7DQo+PiArfQ0KPj4gKw0KPj4gK3ZvaWQgcW1wX2Jsb2NrX2RpcnR5X2JpdG1h
cF9yZW1vdmUoY29uc3QgY2hhciAqbm9kZSwgY29uc3QgY2hhciAqbmFtZSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAg
IGRvX2Jsb2NrX2RpcnR5X2JpdG1hcF9yZW1vdmUobm9kZSwgbmFtZSwgdHJ1ZSwgTlVMTCwgZXJy
cCk7DQo+PiAgIH0NCj4+ICAgDQo+PiAgIC8qKg0KPj4NCj4gDQo+IFNlZW1zIGFib3V0IHJpZ2h0
IG90aGVyd2lzZSwgdGhvdWdoIQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=

