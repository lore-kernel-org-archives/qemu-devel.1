Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE375C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AA2206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bRz+czLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AA2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWavl-0001kc-P3
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 02:22:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hWaun-0001RM-6a
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hWaum-0006Cn-5y
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:21:21 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
	([40.107.8.134]:23278
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hWauj-00063A-DH; Fri, 31 May 2019 02:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=/uJnxqHl8XVmw/9mmBUZ1Hee6d5udYRV1VT8Pfxk0NE=;
	b=bRz+czLGUeK+XqqKjiFJXn/KIUUkNXIPt+VgzWEJvVBzanDtfDmOpA8ARwFOVhB8d44TEcB6WBgFTFqu50GXC4xdWe7MDPz/4OsczDtGj/VW4MPx9sm449Vc7ugvKI99Kn3lO3bj3fDimJQi7I/naK6zfqz+abRdvYRAvQGk/dw=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
	AM0PR08MB2993.eurprd08.prod.outlook.com (52.134.93.140) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Fri, 31 May 2019 06:21:14 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::1deb:8cf1:f7d2:16cf]) by
	AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::1deb:8cf1:f7d2:16cf%6]) with mapi id 15.20.1922.024;
	Fri, 31 May 2019 06:21:14 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Thread-Topic: [Qemu-block] [PATCH v4] qemu-io: add pattern file for write
	command
Thread-Index: AQHVFsFuanwd9ZC/akyAdq6XTNnnaqaExJGA
Date: Fri, 31 May 2019 06:21:13 +0000
Message-ID: <d4e62140-4b0d-a519-021a-a9bfd9b13eb9@virtuozzo.com>
References: <20190530081055.9560-1-dplotnikov@virtuozzo.com>
	<20190530082646.ltwaew7jlaybumiv@steredhat.homenet.telecomitalia.it>
In-Reply-To: <20190530082646.ltwaew7jlaybumiv@steredhat.homenet.telecomitalia.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0027.eurprd02.prod.outlook.com
	(2603:10a6:3:e4::13) To AM0PR08MB3745.eurprd08.prod.outlook.com
	(2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4a7e135-1081-4ccf-d235-08d6e5902e65
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB2993; 
x-ms-traffictypediagnostic: AM0PR08MB2993:
x-microsoft-antispam-prvs: <AM0PR08MB299351AB62CBDA1C9235F02FCF190@AM0PR08MB2993.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(39850400004)(396003)(136003)(366004)(376002)(199004)(189003)(3846002)(6116002)(6246003)(107886003)(5660300002)(53936002)(6512007)(446003)(68736007)(25786009)(6486002)(6916009)(316002)(6436002)(305945005)(2906002)(4326008)(7736002)(8936002)(54906003)(81156014)(186003)(66946007)(14454004)(8676002)(256004)(53546011)(6506007)(81166006)(86362001)(476003)(36756003)(31696002)(2616005)(66066001)(386003)(486006)(64756008)(31686004)(66446008)(71200400001)(76176011)(73956011)(71190400001)(102836004)(52116002)(11346002)(229853002)(99286004)(478600001)(66476007)(66556008)(26005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2993;
	H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RRsiK60ZfZJ1ZiuNmFfW0rraDG+2gSFo/qGPyG20wmDbLnDFudl+V01qe63fWzpoaM/dwLylz/tUAuVe33A7AvjRv408LoNWvmF0inZx6RRSkrH++VMAdwhhiVupm2JvgSmkt8VvL+ElE5lDFYqIw0GL9Y+XqXWrJmGWuBmkDrWwVQSC0LOKy76lgwlivEb6OMnx+8KsUUMi+OuBtfdZgrCGEVrRPs+03Vg2IPv99IiESs7PFc5IIixzPiNo7qiCD4ZigrogwaJeFDCRKyoljHOgN+bJcCuLFvm7O+H+NbGAh67cLdBCmenYreh5hp5RWOb8AUCmqqa3Qu4brBPGTbE6US5yGl+ihKXrs8A0MWopD7nNy6R4rA03jAiJb6KR1WrxUWticXtcuexEoWECeVLM9t57VgzPWgex15NfU8I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA4542CAAF26FC4E8E6FDE9340912017@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7e135-1081-4ccf-d235-08d6e5902e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 06:21:13.9188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2993
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.134
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4] qemu-io: add pattern file
 for write command
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDMwLjA1LjIwMTkgMTE6MjYsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToNCj4gT24g
VGh1LCBNYXkgMzAsIDIwMTkgYXQgMTE6MTA6NTVBTSArMDMwMCwgRGVuaXMgUGxvdG5pa292IHdy
b3RlOg0KPj4gVGhlIHBhdGNoIGFsbG93cyB0byBwcm92aWRlIGEgcGF0dGVybiBmaWxlIGZvciB3
cml0ZQ0KPj4gY29tbWFuZC4gVGhlcmUgd2FzIG5vIHNpbWlsYXIgYWJpbGl0eSBiZWZvcmUuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6
by5jb20+DQo+PiAtLS0NCj4gDQo+IEhpIERlbmlzLA0KPiBmb3IgbmV4dCB2ZXJzaW9ucyBJIHN1
Z2dlc3QgdG8gZGVzY3JpYmUgaGVyZSwgYWZ0ZXIgdGhlIC0tLSwgdGhlIGNoYW5nZXMNCj4gd2l0
aCBwcmV2aW91cyB2ZXJzaW9ucy4gSW4gdGhpcyB3YXkgdGhlIHJldmlldyBzaG91bGQgYmUgZWFz
aWVyLg0KLS0tDQpTdXJlDQo+IA0KPj4gICBxZW11LWlvLWNtZHMuYyB8IDgxICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFu
Z2VkLCA3NSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9xZW11LWlvLWNtZHMuYyBiL3FlbXUtaW8tY21kcy5jDQo+PiBpbmRleCAwOTc1MGEyM2NlLi4x
YzZhNWU0ZmFmIDEwMDY0NA0KPj4gLS0tIGEvcWVtdS1pby1jbWRzLmMNCj4+ICsrKyBiL3FlbXUt
aW8tY21kcy5jDQo+PiBAQCAtMjEsNiArMjEsNyBAQA0KPj4gICAjaW5jbHVkZSAicWVtdS9vcHRp
b24uaCINCj4+ICAgI2luY2x1ZGUgInFlbXUvdGltZXIuaCINCj4+ICAgI2luY2x1ZGUgInFlbXUv
Y3V0aWxzLmgiDQo+PiArI2luY2x1ZGUgInN0cmluZy5oIg0KPj4gICANCj4+ICAgI2RlZmluZSBD
TURfTk9GSUxFX09LICAgMHgwMQ0KPj4gICANCj4+IEBAIC0zNDMsNiArMzQ0LDYxIEBAIHN0YXRp
YyB2b2lkICpxZW11X2lvX2FsbG9jKEJsb2NrQmFja2VuZCAqYmxrLCBzaXplX3QgbGVuLCBpbnQg
cGF0dGVybikNCj4+ICAgICAgIHJldHVybiBidWY7DQo+PiAgIH0NCj4+ICAgDQo+PiArc3RhdGlj
IHZvaWQgKnFlbXVfaW9fYWxsb2NfZnJvbV9maWxlKEJsb2NrQmFja2VuZCAqYmxrLCBzaXplX3Qg
bGVuLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaGFyICpmaWxl
X25hbWUpDQo+PiArew0KPj4gKyAgICBjaGFyICpidWYsICpidWZfcG9zOw0KPj4gKyAgICBGSUxF
ICpmID0gZm9wZW4oZmlsZV9uYW1lLCAiciIpOw0KPj4gKyAgICBpbnQgbDsNCj4+ICsNCj4+ICsg
ICAgaWYgKCFmKSB7DQo+PiArICAgICAgICBwcmludGYoIiclcyc6ICVzXG4iLCBmaWxlX25hbWUs
IHN0cmVycm9yKGVycm5vKSk7DQo+PiArICAgICAgICByZXR1cm4gTlVMTDsNCj4+ICsgICAgfQ0K
Pj4gKw0KPj4gKyAgICBpZiAocWVtdWlvX21pc2FsaWduKSB7DQo+PiArICAgICAgICBsZW4gKz0g
TUlTQUxJR05fT0ZGU0VUOw0KPj4gKyAgICB9DQo+PiArICAgIGJ1ZiA9IGJsa19ibG9ja2FsaWdu
KGJsaywgbGVuKTsNCj4+ICsgICAgbWVtc2V0KGJ1ZiwgMCwgbGVuKTsNCj4+ICsNCj4+ICsgICAg
YnVmX3BvcyA9IGJ1ZjsNCj4+ICsNCj4+ICsgICAgd2hpbGUgKGxlbiA+IDApIHsNCj4+ICsgICAg
ICAgIGwgPSBmcmVhZChidWZfcG9zLCBzaXplb2YoY2hhciksIGxlbiwgZik7DQo+PiArDQo+PiAr
ICAgICAgICBpZiAoZmVvZihmKSkgew0KPj4gKyAgICAgICAgICAgIHJld2luZChmKTsNCj4+ICsg
ICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgIGlmIChmZXJyb3IoZikpIHsNCj4+ICsgICAgICAg
ICAgICBwcmludGYoIiclcyc6ICVzXG4iLCBmaWxlX25hbWUsIHN0cmVycm9yKGVycm5vKSk7DQo+
PiArICAgICAgICAgICAgZ290byBlcnJvcjsNCj4+ICsgICAgICAgIH0NCj4+ICsNCj4+ICsgICAg
ICAgIGlmIChsID09IDApIHsNCj4+ICsgICAgICAgICAgICBwcmludGYoIiclcycgaXMgZW1wdHlc
biIsIGZpbGVfbmFtZSk7DQo+PiArICAgICAgICAgICAgZ290byBlcnJvcjsNCj4+ICsgICAgICAg
IH0NCj4gDQo+IENvdWxkIGl0IGhhcHBlbiB0aGF0IHdlIHJlYWQgc29tZSBieXRlcywgdGhhbiB3
ZSByZWFjaGVkIHRoZSBFT0YsIHNvIHdlIG1hZGUNCj4gdGhlIHJld2luZCgpIGFuZCBmcmVhZCgp
IHJldHVybnMgMD8NCj4gSWYgdGhhdCBjYW4gaGFwcGVuLCBtYXliZSB3ZSBzaG91bGQgY2hhbmdl
IGl0IGluIHRoaXMgd2F5Og0KPiANCj4gICAgICAgICAgaWYgKGwgPT0gMCAmJiBidWZfcG9zID09
IGJ1Zikgew0KPiAgICAgICAgICAgICAgcHJpbnRmKCInJXMnIGlzIGVtcHR5XG4iLCBmaWxlX25h
bWUpOw0KPiAgICAgICAgICAgICAgZ290byBlcnJvcjsNCj4gICAgICAgICAgfQ0KVGhpcyBzaG91
bGRuJ3QgaGFwcGVuLiBUbyBnZXQgdGhhdCBzaXR1YXRpb24gd2UgbmVlZCB0byByZWFkIGV4YWN0
bHkgdGhlIA0KZmlsZSBsZW5ndGggKGZyb20gdGhlIGN1cnJlbnQgcG9zaXRpb24gdG8gdGhlIGVu
ZCkgb24gdGhlIGZpcnN0IHN0ZXAsIA0KdGhlbiByZXdpbmQsIHJlYWQgYWdhaW4gYW5kIGluIHRo
YXQgY2FzZSBnZXQgbCA9PSAwIGFuZCBmZW9mID09IHRydWUuIA0KQnV0IHJlYWRpbmcgdGhlIGV4
YWN0IGxlbmd0aCBtZWFucyB0aGF0IHdlIGFza2VkIGZvciB0aGF0IHNpemUsIHNvIHRoZSANCmJ1
ZmZlciBpcyBmdWxseSBwb3B1bGF0ZWQsIHRodXMgbGVuID09IDAgYW5kIHdlIGxlYXZlIHRoZSBs
b29wLg0KDQpTbywgbCA9PSAwIGlzIG9ubHkgd2hlbiB3ZSByZWFkIGFuIGVtcHR5IGZpbGUgb24g
dGhlIGZpcnN0IGl0ZXJhdGlvbi4NCg0KDQo+IA0KPiBUaGFua3MsDQo+IFN0ZWZhbm8NCj4gDQoN
Ci0tIA0KQmVzdCwNCkRlbmlzDQo=

