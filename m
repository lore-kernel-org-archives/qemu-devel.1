Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543BCC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123D220645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XusgvNw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123D220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrAk-00083z-B2
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45822)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgqQo-0007VE-Sd
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgqQn-0008TB-BZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:56:46 -0400
Received: from mail-eopbgr140093.outbound.protection.outlook.com
 ([40.107.14.93]:11502 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hgqQn-0008SB-4O; Fri, 28 Jun 2019 08:56:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=JY2dl2yDRkhXiAHvIGb3uo3xCWYPxD1e6qB6FVFbKPnObJPIsqY1Z4x2EK5xsHWphlcZInpCxFm0r9hnIQKNNt77+IqzFgdrowbbuyGoEP3J8h2H01zVMUxWprznnTTFy7HHhnyzrWAKczQY+eDc5PmsUvtDOo3lPJpHq7VRldg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG2yaSQrRJbUbeHLqPVAxMlvs9KeeCfcoBKhvbcetoI=;
 b=QwuktOEYzrFIRCww/Y4PmpZijq2Kgakl3jhqQAqpQSH8fp8toO0OwA6rWgx3cfJIeNXybDJwaiU4Apx3+X4064SkE3JSu6un0ASijG2N4Yz1aZy5c99LroLvAP7UzKjraV4phw6JJDuHrYFGvaNTwIMPTtDWugbbBzT2z2I2PwY=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG2yaSQrRJbUbeHLqPVAxMlvs9KeeCfcoBKhvbcetoI=;
 b=XusgvNw/bYNn4l6CYVb6NLdZohrFYkTK1y1WxrH49WKeEAMIF5azGOBtyXCx2dux24zGzcadZ6O1/9ECcFZntetz6TJaykF2PUbfu63hBi2U/zN9lvEoiTbaaZ6Gayiw2faDgSyjrvBgTQy4nt4O5unZIETfqFP5+KJ0qE/4LIA=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4371.eurprd08.prod.outlook.com (20.179.34.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 12:56:42 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 12:56:42 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v0 2/3] qcow2: add compression type processing
Thread-Index: AQHVLZuN7Ey1lYD5REukjsp4qtAkE6aw7L0AgAAL2QCAAA4MgA==
Date: Fri, 28 Jun 2019 12:56:42 +0000
Message-ID: <4fef0430-5a0c-36ca-eec0-a2c0ce10cb91@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
 <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
 <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
 <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::47) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79450e40-acf8-477f-b728-08d6fbc8114a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4371; 
x-ms-traffictypediagnostic: AM0PR08MB4371:
x-microsoft-antispam-prvs: <AM0PR08MB4371A5BD8DF41A6C539003F0CFFC0@AM0PR08MB4371.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(376002)(39830400003)(136003)(199004)(189003)(25786009)(66946007)(36756003)(52116002)(316002)(53546011)(486006)(66446008)(73956011)(66476007)(68736007)(476003)(66556008)(2616005)(8676002)(256004)(2906002)(4326008)(186003)(76176011)(102836004)(11346002)(478600001)(6506007)(446003)(5660300002)(64756008)(386003)(66066001)(6436002)(229853002)(6512007)(6486002)(26005)(81166006)(8936002)(305945005)(99286004)(14454004)(31696002)(86362001)(54906003)(3846002)(6116002)(6246003)(31686004)(53936002)(6916009)(71190400001)(71200400001)(81156014)(107886003)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4371;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MKBuovSyC1E+/EvarBSxmrSxwrvAP/oNf5PZKSYOrh2I6a9pPwbe23Tr0pF77/agVJD4I1Sivibz9LdWLoabCMCuGI1ozVzA/34MUPGweB+by2czgAcRtRZM0rcB9HXCTbqbwHUrC3/ARFjmgh+/kLncuE+67NhegWtDtGo8goPLQU0K5fmAPT2qROKQtyA0uMAh1/QbnS+8sNdeAXgEY7ePi5XCgniu+F1JL2ttKNV5LuI5feQUXDYcxBQst7Qq277obkT+qNQTmKFuKcxsegAiRkG4CyiKIYGhU5JnVKmpnICfv/Ssjf6WB6KTndcO8f6vskaCTVIVQhh+I39XcRg9H0r22k6QMakoO1/DHQjLR1nAy8o1rnAvhS9j+V1ar5DydMPl6LtPf5C63dCJtmRDchIx9fmmQpD4xRDRCOc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD0E1FE7994A624AA6F5B4B705F8F07D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79450e40-acf8-477f-b728-08d6fbc8114a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 12:56:42.5521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4371
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.93
Subject: Re: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type
 processing
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LjA2LjIwMTkgMTU6MDYsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDI4LjA2LjIw
MTkgdW0gMTM6MjQgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+DQo+Pg0KPj4g
T24gMjguMDYuMjAxOSAxMzoyMywgS2V2aW4gV29sZiB3cm90ZToNCj4+PiBBbSAyOC4wNS4yMDE5
IHVtIDE2OjM3IGhhdCBEZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4+IFdpdGggdGhl
IHBhdGNoLCBxY293MiBpcyBhYmxlIHRvIHByb2Nlc3MgaW1hZ2UgY29tcHJlc3Npb24gdHlwZQ0K
Pj4+PiBkZWZpbmVkIGluIHRoZSBpbWFnZSBoZWFkZXIgYW5kIGNob29zZSB0aGUgY29ycmVzcG9u
ZGluZyBtZXRob2QNCj4+Pj4gZm9yIGNsdXN0ZXJzIGNvbXByZXNzaW5nLg0KPj4+Pg0KPj4+PiBB
bHNvLCBpdCByZXdvcmsgdGhlIGNsdXN0ZXIgY29tcHJlc3Npb24gY29kZSBmb3IgYWRkaW5nIG1v
cmUNCj4+Pj4gY29tcHJlc3Npb24gdHlwZXMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IERl
bmlzIFBsb3RuaWtvdiA8ZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4g
ICAgYmxvY2svcWNvdzIuYyB8IDEwMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLQ0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgOTIgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi5j
IGIvYmxvY2svcWNvdzIuYw0KPj4+PiBpbmRleCBjNGI1YjkzNDA4Li45MGYxNWNjM2M5IDEwMDY0
NA0KPj4+PiAtLS0gYS9ibG9jay9xY293Mi5jDQo+Pj4+ICsrKyBiL2Jsb2NrL3Fjb3cyLmMNCj4+
Pj4gQEAgLTQwMCwxMSArNDAwLDM5IEBAIHN0YXRpYyBpbnQgcWNvdzJfcmVhZF9leHRlbnNpb25z
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRfdCBzdGFydF9vZmZzZXQsDQo+Pj4+ICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPj4+PiAgICANCj4+Pj4gICAgICAgICAgICBjYXNlIFFDT1cyX0VY
VF9NQUdJQ19DT01QUkVTU0lPTl9UWVBFOg0KPj4+PiArICAgICAgICAgICAgLyogQ29tcHJlc3Np
b24gdHlwZSBhbHdheXMgZ29lcyB3aXRoIHRoZSBjb21wcmVzc2lvbiB0eXBlIGJpdCBzZXQgKi8N
Cj4+Pj4gKyAgICAgICAgICAgIGlmICghKHMtPmluY29tcGF0aWJsZV9mZWF0dXJlcyAmIFFDT1cy
X0lOQ09NUEFUX0NPTVBSRVNTSU9OX1RZUEUpKSB7DQo+Pj4+ICsgICAgICAgICAgICAgICAgZXJy
b3Jfc2V0ZyhlcnJwLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgImNvbXByZXNz
aW9uX3R5cGVfZXh0OiAiDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAiZXhwZWN0
IGNvbXByZXNzaW9uIHR5cGUgYml0IHNldCIpOw0KPj4+PiArICAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPj4+PiArICAgICAgICAgICAgfQ0KPj4+PiArDQo+Pj4+ICsgICAgICAgICAg
ICByZXQgPSBiZHJ2X3ByZWFkKGJzLT5maWxlLCBvZmZzZXQsICZzLT5jb21wcmVzc2lvbl90eXBl
LCBleHQubGVuKTsNCj4+Pj4gKyAgICAgICAgICAgIHMtPmNvbXByZXNzaW9uX3R5cGUgPSBiZTMy
X3RvX2NwdShzLT5jb21wcmVzc2lvbl90eXBlKTsNCj4+Pj4gKw0KPj4+PiArICAgICAgICAgICAg
aWYgKHJldCA8IDApIHsNCj4+Pj4gKyAgICAgICAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVy
cnAsIC1yZXQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRVJST1I6
IENvdWxkIG5vdCByZWFkIGNvbXByZXNzaW9uIHR5cGUiKTsNCj4+Pj4gKyAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPj4+PiArICAgICAgICAgICAgfQ0KPj4+PiArDQo+Pj4+ICAgICAgICAg
ICAgICAgIC8qDQo+Pj4+IC0gICAgICAgICAgICAgKiBTZXR0aW5nIGNvbXByZXNzaW9uIHR5cGUg
dG8gQkRSVlFjb3cyU3RhdGUtPmNvbXByZXNzaW9uX3R5cGUNCj4+Pj4gLSAgICAgICAgICAgICAq
IGZyb20gdGhlIGltYWdlIGhlYWRlciBpcyBnb2luZyB0byBiZSBoZXJlDQo+Pj4+ICsgICAgICAg
ICAgICAgKiBUaGUgZGVmYXVsdCBjb21wcmVzc2lvbiB0eXBlIGlzIG5vdCBhbGxvd2VkIHdoZW4g
dGhlIGV4dGVuc2lvbg0KPj4+PiArICAgICAgICAgICAgICogaXMgcHJlc2VudC4gWkxJQiBpcyB1
c2VkIGFzIHRoZSBkZWZhdWx0IGNvbXByZXNzaW9uIHR5cGUuDQo+Pj4+ICsgICAgICAgICAgICAg
KiBXaGVuIGNvbXByZXNzaW9uIHR5cGUgZXh0ZW5zaW9uIGhlYWRlciBpcyBwcmVzZW50IHRoZW4N
Cj4+Pj4gKyAgICAgICAgICAgICAqIGNvbXByZXNzaW9uX3R5cGUgc2hvdWxkIGhhdmUgYSB2YWx1
ZSBkaWZmZXJlbnQgZnJvbSB0aGUgZGVmYXVsdC4NCj4+Pj4gICAgICAgICAgICAgICAgICovDQo+
Pj4+IC0gICAgICAgICAgICAgYnJlYWs7DQo+Pj4+ICsgICAgICAgICAgICBpZiAocy0+Y29tcHJl
c3Npb25fdHlwZSA9PSBRQ09XMl9DT01QUkVTU0lPTl9UWVBFX1pMSUIpIHsNCj4+Pj4gKyAgICAg
ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiY29tcHJlc3Npb25fdHlwZV9leHQ6Ig0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgImludmFsaWQgY29tcHJlc3Npb24gdHlwZSAlZCIsDQo+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICBRQ09XMl9DT01QUkVTU0lPTl9UWVBFX1pMSUIpOw0KPj4+PiArICAgICAg
ICAgICAgfQ0KPj4+DQo+Pj4gVGhpcyBpcyBhIHJlc3RyaWN0aW9uIHRoYXQgdGhlIHNwZWMgZG9l
c24ndCBtYWtlLCBzbyBzdHJpY3RseSBzcGVha2luZw0KPj4+IHRoaXMgaW1wbGVtZW50YXRpb24g
d291bGRuJ3QgYmUgY29tcGxpYW50IHRvIHRoZSBzcGVjLg0KPj4gVGhlIGlkZWEgaXMgdGhhdCBa
TElCIHNob3VsZG4ndCBhcHBlYXIgaW4gdGhlIGNvbXByZXNzaW9uIHR5cGUNCj4+IGV4dGVuc2lv
bi4gVGhpcyBhbGxvd3MgaW1hZ2UgYmFja3dhcmQgY29tcGF0aWJpbGl0eSB3aXRoIGFuIG9sZGVy
IHFlbXUNCj4+IGlmIHpsaWIgaXMgdXNlZC4NCj4+DQo+PiBUaGVyZSBpcyBubyByZWFzb24gdG8g
c2V0IFpMSUIgaW4gdGhlIGV4dGVuc2lvbiBiZWNhdXNlIGFuIG9sZGVyIHFlbXUNCj4+IGtub3dz
IGhvdyB0byB0cmVhZCBaTElCIGNvbXByZXNzZWQgY2x1c3RlcnMuDQo+Pg0KPj4gVGhlIHJlc3Ry
aWN0aW9uIGFpbXMgdG8gZ3VhcmFudGVlIHRoYXQuDQo+Pg0KPj4gSSB0cmllZCB0byBkZXNjcmli
ZSB0aGlzIGNhc2UgaW4gdGhlIHNwZWNpZmljYXRpb246DQo+PiAuLi4NCj4+IFdoZW4gdGhlIGNv
bXByZXNzaW9uIHR5cGUgYml0IGlzIG5vdCBzZXQsIGFuZCB0aGUgY29tcHJlc3Npb24gdHlwZQ0K
Pj4gaGVhZGVyIGV4dGVuc2lvbiBpcyBhYnNlbnQsIFpMSUIgY29tcHJlc3Npb24gaXMgdXNlZCBm
b3IgY29tcHJlc3NlZA0KPj4gY2x1c3RlcnMuDQo+Pg0KPj4gUWVtdSB2ZXJzaW9ucyBvbGRlciB0
aGFuIDQuMSBjYW4gdXNlIGltYWdlcyBjcmVhdGVkIHdpdGggY29tcHJlc3Npb24NCj4+IHR5cGUg
WkxJQiB3aXRob3V0IGFueSBhZGRpdGlvbmFsIHByZXBhcmF0aW9ucyBhbmQgY2Fubm90IHVzZSBp
bWFnZXMNCj4+IGNyZWF0ZWQgd2l0aCBjb21wcmVzc2lvbiB0eXBlcyAhPSBaTElCLg0KPj4gLi4u
DQo+Pg0KPj4gRG9lcyBpdCBtYWtlcyBzZW5zZT8NCj4gDQo+IFRoaXMgdGV4dCBzYXlzIHRoYXQg
dXNpbmcgemxpYiBpbiB0aGUgZXh0ZW5zaW9uIGlzIG5vdCBuZWNlc3NhcnkgYmVjYXVzZQ0KPiBp
dCdzIHRoZSBkZWZhdWx0LiBCdXQgaXQgZG9lc24ndCBzYXkgdGhhdCB1c2luZyB6bGliIGluIHRo
ZSBleHRlbnNpb24gaXMNCj4gaWxsZWdhbC4NCj4gDQo+IEkgYWdyZWUgdGhhdCB0aGVyZSBpcyBu
byBnb29kIHJlYXNvbiB0byBjcmVhdGUgYSBjb21wcmVzc2lvbiB0eXBlDQo+IGV4dGVuc2lvbiBp
ZiB5b3UgaGF2ZSB6bGliLiBCdXQgaXMgdGhlcmUgYSBnb29kIHJlYXNvbiB0byBmb3JiaWQgaXQ/
IA0KSSB0aGluayB5ZXMsIGlmIHdlIGNyZWF0ZSBpbWFnZSB3aXRoIHRoZSBleHRlbnNpb24gc2V0
IHRvIHpsaWIgd2UgDQpwcmV2ZW50IGFuIG9sZGVyIHFlbXUgZnJvbSB1c2luZyB0aGF0IGltYWdl
LiBGdXJ0aGVybW9yZSwgdG8gYWxsb3cgb2xkZXIgDQpxZW11IHVzaW5nIHN1Y2ggaW1hZ2VzIHdl
IG5lZWQgdG8gY3JlYXRlIHNwZWNpYWwgY29udmVyc2lvbiBwcm9jZWR1cmUgDQp3aGljaCBoYXMg
dG8gcmVtb3ZlIHRoZSBleHRlbnNpb24gaGVhZGVyLg0KDQpJZiB6bGliIGlzIGEgInNwZWNpYWwg
Y29tcHJlc3Npb24gdHlwZSIgd2hpY2ggaXMgYWx3YXlzIHNldCBieSBkZWZhdWx0IA0Kd2l0aG91
dCB0aGUgZXh0ZW5zaW9uIGhlYWRlciB3ZSdsbCBnZXQgcmlkIG9mIHN1Y2ggaW1hZ2UgY29udmVy
c2lvbiANCnByb2NlZHVyZSBhbmQgYW4gb2xkZXIgcWVtdSBjb3VsZCB1c2UgaXQgImFzIGlzIg0K
DQpNaWdodCBpdCB3b3JrIGFzIGEgZ29vZCByZWFzb24/DQoNCj4gSXQNCj4gb25seSByZXF1aXJl
cyB1cyB0byBhZGQgYXJ0aWZpY2lhbCByZXN0cmljdGlvbnMgdG8gY29kZSB0aGF0IHdvdWxkIHdv
cmsNCj4gZmluZSB3aXRob3V0IHRoZW0uDQo+IA0KPiBFaXRoZXIgd2F5LCBpZiB3ZSB3YW50IHRv
IHJlamVjdCBzdWNoIGV4dGVuc2lvbnMsIHRoZSBzcGVjIG5lZWRzIHRvIHNheQ0KPiB0aGF0IGl0
J3MgaWxsZWdhbC4gQW5kIGlmIHRoZSBzcGVjIGFsbG93cyBzdWNoIGltYWdlcywgd2UgbXVzdCBh
Y2NlcHQNCj4gdGhlbS4NClllcywgaXQncyB0cnVlDQoNClRoZSBvbmx5IHJlYXNvbnMgdGhhdCB6
bGliIGNvbXByZXNzaW9uIHR5cGUgZXZlbiBleGlzdHMgaW4gdGhlIA0KZW51bWVyYXRpb24gaXMg
dG8gYXZvaWQgYW1iaWd1aXR5IGZvciB1c2Vycy4NCkZvciB0aGVtIGl0IG1heSBiZSBoYXJkIHRv
IHVuZGVyc3RhbmQgd2h5IHRoZXkgY2FuIHNldCB6c3RkIGFuZCBjYW5ub3QgDQpzZXQgemxpYiBh
cyBjb21wcmVzc2lvbiB0eXBlIGFuZCB0byByZWFsbHkgc2V0IHpsaWIgdGhleSBoYXZlIHRvIHNl
dCBubyANCmNvbXByZXNzaW9uIHR5cGUgdG8gbWFrZSB0aGUgZGVmYXVsdCB6bGliIHRvIGFwcGx5
Lg0KDQpXaGVuIGEgdXNlciBzZXQgemxpYiBhcyBjb21wcmVzc2lvbiB0eXBlIHRoZSBpbWFnZSBp
cyBjcmVhdGVkIGFzIGJlZm9yZSANCnRoZSBleHRlbnNpb24gaGVhZGVyIHdlcmUgaW50cm9kdWNl
ZC4NCg0KUmVhc29uYWJsZT8NCj4gDQo+Pj4gV2UgY2FuIGRpc2N1c3Mgd2hldGhlciB0aGUgY29k
ZSBvciB0aGUgc3BlYyBzaG91bGQgYmUgY2hhbmdlZC4gQXQgdGhlDQo+Pj4gbW9tZW50LCBJIGRv
bid0IHNlZSBhIGdvb2QgcmVhc29uIHRvIG1ha2UgdGhlIHJlc3RyaWN0aW9uDQo+Pj4NCj4+Pj4g
KyNpZmRlZiBERUJVR19FWFQNCj4+Pj4gKyAgICAgICAgICAgIHByaW50ZigiUWNvdzI6IGltYWdl
IGNvbXByZXNzaW9uIHR5cGUgJXNcbiIsIHMtPmNvbXByZXNzaW9uX3R5cGUpOw0KPj4+PiArI2Vu
ZGlmDQo+Pj4+ICsgICAgICAgICAgICBicmVhazsNCj4+Pj4gICAgDQo+Pj4+ICAgICAgICAgICAg
Y2FzZSBRQ09XMl9FWFRfTUFHSUNfREFUQV9GSUxFOg0KPj4+PiAgICAgICAgICAgIHsNCj4+Pg0K
Pj4+IFdlIHdvdWxkIHNhdmUgbW9zdCBvZiB0aGlzIGNvZGUgaWYgd2UgYWRkZWQgYSBuZXcgZmll
bGQgdG8gdGhlIGhlYWRlcg0KPj4+IGluc3RlYWQgb2YgYWRkaW5nIGEgaGVhZGVyIGV4dGVuc2lv
bi4gTm90IHNheWluZyB0aGF0IHdlIHNob3VsZA0KPj4+IGRlZmluaXRlbHkgZG8gdGhpcywgYnV0
IGxldCdzIGRpc2N1c3MgaXQgYXQgbGVhc3QuDQo+Pg0KPj4gSWYgd2UgYWRkIHRoZSBuZXcgZmll
bGQgdG8gdGhlIGhlYWRlciB3aWxsIHRoZSBvbGRlciBxZW11IGJlIGFibGUgdG8gdXNlDQo+PiBp
dC4gT3Igd2Ugd2lsbCBhZGQgdGhlIGhlYWRlciBvbmx5IGlmIG5lZWRlZCwgaS5lLiBpZiBjb21w
cmVzc2lvbl90eXBlDQo+PiAhPSB6bGliDQo+IA0KPiBJbmNyZWFzaW5nIHRoZSBoZWFkZXIgc2l6
ZSBpcyBiYWNrd2FyZHMgY29tcGF0aWJsZS4gT2xkZXIgcWVtdSB2ZXJzaW9ucw0KPiBzaG91bGQg
aGFuZGxlIHN1Y2ggaW1hZ2VzIGNvcnJlY3RseS4gVGhleSB3b3VsZCBzdG9yZSB0aGUgdW5rbm93
biBwYXJ0DQo+IG9mIHRoZSBoZWFkZXIgaW4gcy0+dW5rbm93bl9oZWFkZXJfZmllbGRzIGFuZCBr
ZWVwIGl0IHVubW9kaWZpZWQgd2hlbg0KPiB1cGRhdGluZyB0aGUgaW1hZ2UgaGVhZGVyLg0KPiAN
Cj4gV2Ugd291bGQgc3RpbGwgYWRkIHRoZSBpbmNvbXBhdGlibGUgZmVhdHVyZSBmbGFnIGZvciBu
b24temxpYiwgb2YNCj4gY291cnNlLg0Kc28sIHdlIGJhc2ljYWxseSBuZWVkIHRvIGRvIHRoZSBz
YW1lOiBzdG9yZSBjb21wcmVzc2lvbiB0eXBlIGFuZCBmb3JiaWQgDQp0byB1c2UgYmVjYXVzZSBv
ZiBmbGFnIGlmIG5vdCB6bGliLg0KDQpTb3VuZHMgbGlrZSBpdCBkb2Vzbid0IGRpZmZlciB0aGF0
IG11Y2ggZnJvbSB0aGUgZXh0ZW5zaW9uIGhlYWRlciBhcHByb2FjaC4NCg0KTWF5IGJlIEknbSBt
aXNzaW5nIHNvbWV0aGluZy4gUGxlYXNlIGNvcnJlY3QgbXkgaWYgc28uDQoNCkRlbmlzDQo+IA0K
PiBLZXZpbg0KPiANCg0KLS0gDQpCZXN0LA0KRGVuaXMNCg==

