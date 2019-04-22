Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFFEC10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7321420656
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cgenLUh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7321420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38621 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIaa6-0001O9-IR
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 11:10:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaTP-0004ko-B0
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaTO-0005Uu-4D
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 11:03:11 -0400
Received: from mail-eopbgr10106.outbound.protection.outlook.com
	([40.107.1.106]:7857
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaTJ-0005Pz-MQ; Mon, 22 Apr 2019 11:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=FNW6q8l2ZvhiGpQ0hKwBuNoKdPt28FY/n0Spj5X+ZKY=;
	b=cgenLUh2BST/n7oqKJhCodJ8+n8VviHJ42CkNc0bEzEmpuZcOzO93BzwXO8t8EZNGPjFwaz+q8BUzu6XdBC6hkhEEkVLFSEGIn7Ljao8aHQp12QSSE4WcYFF47woUQTd727YpLi/zLiow1NYlZuolbXbT0qbxTykiIg9625MEfY=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3163.eurprd08.prod.outlook.com (52.134.110.149) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.16; Mon, 22 Apr 2019 15:03:01 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Mon, 22 Apr 2019 15:03:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 3/3] iotests: test big qcow2 shrink
Thread-Index: AQHU9rkKT/9yFApuFkiNZzTSsqmmgaZIObAAgAAR0IA=
Date: Mon, 22 Apr 2019 15:03:01 +0000
Message-ID: <d264e5bb-cf20-f152-d4f4-09fdb85802e3@virtuozzo.com>
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
	<20190419140557.102725-4-vsementsov@virtuozzo.com>
	<f8e6bdca-cc46-c721-4534-1741530a1215@redhat.com>
In-Reply-To: <f8e6bdca-cc46-c721-4534-1741530a1215@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0022.eurprd08.prod.outlook.com
	(2603:10a6:3:bd::32) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190422180259033
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8bc10c3-340b-4187-3290-08d6c7339d18
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3163; 
x-ms-traffictypediagnostic: DB7PR08MB3163:
x-microsoft-antispam-prvs: <DB7PR08MB3163B3679FF0854F532771C2C1220@DB7PR08MB3163.eurprd08.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(136003)(346002)(376002)(39840400004)(366004)(396003)(199004)(189003)(476003)(316002)(54906003)(110136005)(97736004)(71200400001)(71190400001)(2616005)(26005)(102836004)(76176011)(53546011)(6506007)(229853002)(6486002)(386003)(186003)(31686004)(305945005)(107886003)(2906002)(6436002)(66066001)(8676002)(31696002)(446003)(6246003)(11346002)(14454004)(68736007)(8936002)(2501003)(4326008)(3846002)(52116002)(66946007)(66476007)(66556008)(64756008)(66446008)(73956011)(81156014)(25786009)(14444005)(486006)(7736002)(256004)(5660300002)(6512007)(99286004)(53936002)(2201001)(36756003)(6116002)(86362001)(478600001)(81166006)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3163;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eOMQJ1z30WrTmA67yZDsRxFXbgPX0n9F529GaOBohykeZ6DLo3T5M+mXCMtsuKkF7YHLLUxH1bJsdnSnzZm8YeNNA41a4LHDyjAYQKSyuryUDoF0Br6VSNNlSEvelhvH2fyreYBeWl39OjD82hae9DE0nhfrUILlIwhFAeMMa/Gdf9nkYtfRB2q9bBrbFo7lY+CFI2JaNVZF3fpyDhFq7rjFwGwUfP7m67RLIzkSDby7Tg76j++Dg43oB5BEDaNIWBWrFT6Hm0pKrwuomZ6RLKzEIZf9Ih4pJpXit93s+/cnfYjGdAJ3yKHOf3TT17XNs+D9IQQsT0dzd/eqrbA68kUMH7QTBBEtkA5brnm/w4dgwdPCiMlQGGYBTMMrzBcJzqaX+2/BElxyGW42H2PNfLt92bnSmHrDNEfyLTQ5SRs=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <B4DA8555643E434CA7A78C8B59EDA7B4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bc10c3-340b-4187-3290-08d6c7339d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 15:03:01.5474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3163
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.106
Subject: Re: [Qemu-devel] [PATCH v3 3/3] iotests: test big qcow2 shrink
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
	Denis Lunev <den@virtuozzo.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422150301.h8zLApRVdqQt2nl4XAnSqfJamEApHg1hJLHHKX4nvw0@z>

MjIuMDQuMjAxOSAxNjo1OSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNC8xOS8xOSA5OjA1IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gVGhpcyB0ZXN0IGNoZWNr
cyBidWcgaW4gcWNvdzJfcHJvY2Vzc19kaXNjYXJkcywgZml4ZWQgYnkgcHJldmlvdXMNCj4+IGNv
bW1pdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4gDQo+PiArIyBUaGlzIHRlc3Qg
Y2hlY2tzIHRoYXQgcWNvdzJfcHJvY2Vzc19kaXNjYXJkcyBkb2VzIG5vdCB0cnVuY2F0ZSBhIGRp
c2NhcmQNCj4+ICsjIHJlcXVlc3QgPiAyRy4NCj4+ICsjIFRvIHJlcHJvZHVjZSBidWcgd2UgbmVl
ZCB0byBvdmVyZmxvdyBpbnQgYnkgb25lIHNlcXVlbnRpYWwgZGlzY2FyZCwgc28gd2UNCj4+ICsj
IG5lZWQgc2l6ZSA+IDJHLCBiaWdnZXIgY2x1c3RlciBzaXplIChhcyB3aXRoIGRlZmF1bHQgNjRr
IHdlIG1heSBoYXZlIG1heGltdW0NCj4+ICsjIG9mIDUxMk0gc2VxdWVudGlhbCBkYXRhLCBjb3Jy
ZXNwb25kaW5nIHRvIG9uZSBMMSBlbnRyeSksIGFuZCB3ZSBuZWVkIHNvbWUNCj4+ICsjIGRhdGEg
b2YgdGhlIGJlZ2lubmluZyBvZiB0aGUgZGlzayBtYXBwZWQgdG8gdGhlIGVuZCBvZiBmaWxlIHRv
IHByZXZlbnQNCj4+ICsjIGJkcnZfY29fdHJ1bmNhdGUoYnMtPmZpbGUpIGNhbGwgaW4gcWNvdzJf
Y29fdHJ1bmNhdGUoKSwgd2hpY2ggbWF5IHN1Y2Nlc3MNCj4gDQo+IHMvbWF5IHN1Y2Nlc3MvbWln
aHQgc3VjY2VlZC8NCj4gDQo+PiArIyBhbnl3YXkuDQo+PiArDQo+PiArc2l6ZT0yMTAwTQ0KPj4g
K0lNR09QVFM9ImNsdXN0ZXJfc2l6ZT0xTSxwcmVhbGxvY2F0aW9uPW1ldGFkYXRhIg0KPj4gKw0K
Pj4gK19tYWtlX3Rlc3RfaW1nICRzaXplDQo+PiArJFFFTVVfSU8gLWMgJ2Rpc2NhcmQgMCAxME0n
IC1jICdkaXNjYXJkIDIwOTBNIDEwTScgXA0KPj4gKyAgICAgICAgIC1jICd3cml0ZSAyMDkwTSAx
ME0nIC1jICd3cml0ZSAwIDEwTScgIiRURVNUX0lNRyIgfCBfZmlsdGVyX3FlbXVfaW8NCj4+ICsN
Cj4+ICsjIENoZWNrIHRoYXQgb3VyIHRyaWNrIHdpdGggc3dhcHBpbmcgZmlyc3QgYW5kIGxhc3Qg
MTBNIGNodW5rcyBzdWNjZWVkZWQuDQo+PiArIyBPdGhlcndpc2UgdGVzdCB3aWxsIG1heSBwYXNz
IGV2ZW4gaWYgYmRydl9wZGlzY2FyZCgpIGZhaWxzIGluDQo+PiArIyBxY293Ml9wcm9jZXNzX2Rp
c2NhcmRzKCkNCj4+ICskUUVNVV9JTUcgbWFwICIkVEVTVF9JTUciIHwgX2ZpbHRlcl90ZXN0ZGly
DQo+PiArJFFFTVVfSU1HIGluZm8gIiRURVNUX0lNRyIgfCBncmVwIHNpemUgfCAgX2ZpbHRlcl90
ZXN0ZGlyDQo+IA0KPiBOaWNlIC0gdGhhdCdzIGEgbG90IGZhc3RlciB0aGFuIHYxISBBbmQgbWFr
ZXMgdGhlIHRlc3QgZml0IGluIHRoZSBxdWljaw0KPiBncm91cCBhZnRlciBhbGwuDQo+IA0KPj4g
Kw0KPj4gKyRRRU1VX0lNRyAtVCAncWNvdzJfcHJvY2Vzc19kaXNjYXJkc19mYWlsZWQqJyByZXNp
emUgLS1zaHJpbmsgIiRURVNUX0lNRyIgNU0NCj4gDQo+IEhvd2V2ZXIsIEknbSBxdWl0ZSBjZXJ0
YWluIHRoYXQgdHJhY2Ugb3V0cHV0IGlzIG5vdCByZWxpYWJsZSBpbiBpb3Rlc3RzLg0KPiBEZXBl
bmRpbmcgb24gY29uZmlndXJlIG9wdGlvbnMsIHRyYWNlcyBtaWdodCBub3QgYmUgZW5hYmxlZCBh
dCBhbGwsIG9yDQo+IG1pZ2h0IG5vdCBnbyB0byBzdGRlcnIuIERyb3AgdGhlIC1UICcuLi4nLiAg
RXZlbiB3aXRob3V0IHRoZSB0cmFjZSBsaW5lLA0KPiANCj4+ICsNCj4+ICskUUVNVV9JTUcgaW5m
byAiJFRFU1RfSU1HIiB8IGdyZXAgc2l6ZSB8IF9maWx0ZXJfdGVzdGRpcg0KPiANCj4gdGhpcyBz
ZWNvbmQgaW1hZ2UgaW5mbyBpcyBzdWZmaWNpZW50IHRvIHByb3ZlIHdoZXRoZXIgdGhlIHJlc2l6
ZSBoYWQgYW4NCj4gZWZmZWN0IChwb3N0LXBhdGNoKSBvciBleHBvc2VzIHRoZSBidWcgKHdpdGhv
dXQgcGF0Y2ggMi8zKS4gVGhhdCBpcywNCj4gYXBwbHlpbmcgdGhpcyBwYXRjaCBidXQgbm90IDIv
MywgSSBzZWUgdGhpcyAod2l0aCBteSBjbGVhbnVwcyB0bw0KPiBxZW11LWltZyBpbmZvIGluIHBs
YWNlLCBmcm9tIEtldmluJ3MgYmxvY2stbmV4dCBicmFuY2gpOg0KPiANCj4gKysrIC9ob21lL2Vi
bGFrZS9xZW11L3Rlc3RzL3FlbXUtaW90ZXN0cy8yNTAub3V0LmJhZAkyMDE5LTA0LTIyDQo+IDA4
OjUyOjI2LjA3Mjk2ODczMSAtMDUwMA0KPiBAQCAtMTQsOCArMTQsOSBAQA0KPiAgIHZpcnR1YWwg
c2l6ZTogMi4wNSBHaUIgKDIyMDIwMDk2MDAgYnl0ZXMpDQo+ICAgZGlzayBzaXplOiAyNCBNaUIN
Cj4gICBjbHVzdGVyX3NpemU6IDEwNDg1NzYNCj4gKzE4Mjc0QDE1NTU5NDExNDUuOTk5MTk1OnFj
b3cyX3Byb2Nlc3NfZGlzY2FyZHNfZmFpbGVkX3JlZ2lvbiBvZmZzZXQNCj4gMHg1MDAwMDAgYnl0
ZXMgMHg4MmEwMDAwMCByZXQgLTUNCj4gICBJbWFnZSByZXNpemVkLg0KPiAgIHZpcnR1YWwgc2l6
ZTogNSBNaUIgKDUyNDI4ODAgYnl0ZXMpDQo+IC1kaXNrIHNpemU6IDkuMDEgTWlCDQo+ICtkaXNr
IHNpemU6IDE5IE1pQg0KPiANCj4gd2hlcmUgdGhlIHRyYWNlIGRpZCBpbmRlZWQgc2hvdyBzaG93
IHRoYXQgd2UgaGFkIGEgYnVnLCBidXQgd2hlcmUgZXZlbg0KPiB3aXRob3V0IHRoZSB0cmFjZSwg
dGhlIGRpZmZlcmVuY2UgaW4gc2l6ZSBiZXR3ZWVuIDE5TSB3aXRoIGluY29tcGxldGUNCj4gZGlz
Y2FyZHMgdnMuIDlNIHdpdGggcGF0Y2ggMi8zIGlzIGVub3VnaCB0byBzaG93IHRoYXQgcGF0Y2gg
Mi8zIGZpeGVzIGEgYnVnLg0KPiANCj4+ICt2aXJ0dWFsIHNpemU6IDIuMUcgKDIyMDIwMDk2MDAg
Ynl0ZXMpDQo+PiArZGlzayBzaXplOiAyNE0NCj4+ICtjbHVzdGVyX3NpemU6IDEwNDg1NzYNCj4+
ICtJbWFnZSByZXNpemVkLg0KPj4gK3ZpcnR1YWwgc2l6ZTogNS4wTSAoNTI0Mjg4MCBieXRlcykN
Cj4+ICtkaXNrIHNpemU6IDkuME0NCj4+ICtjbHVzdGVyX3NpemU6IDEwNDg1NzYNCj4gDQo+IFdo
ZW4gS2V2aW4ncyBibG9jay1uZXh0IGJyYW5jaCBpcyBhcHBsaWVkLCB5b3UnbGwgbmVlZCB0aGlz
IHNxdWFzaGVkIGluOg0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNTAu
b3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1MC5vdXQNCj4gaW5kZXggMzdlMzdmMGM5ZTcuLmQx
YzFjNzE4MGI1IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjUwLm91dA0KPiAr
KysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjUwLm91dA0KPiBAQCAtMTEsMTEgKzExLDExIEBAIHdy
b3RlIDEwNDg1NzYwLzEwNDg1NzYwIGJ5dGVzIGF0IG9mZnNldCAwDQo+ICAgT2Zmc2V0ICAgICAg
ICAgIExlbmd0aCAgICAgICAgICBNYXBwZWQgdG8gICAgICAgRmlsZQ0KPiAgIDAgICAgICAgICAg
ICAgICAweGEwMDAwMCAgICAgICAgMHg4MmYwMDAwMCAgICAgIFRFU1RfRElSL3QucWNvdzINCj4g
ICAweDgyYTAwMDAwICAgICAgMHhhMDAwMDAgICAgICAgIDB4NTAwMDAwICAgICAgICBURVNUX0RJ
Ui90LnFjb3cyDQo+IC12aXJ0dWFsIHNpemU6IDIuMUcgKDIyMDIwMDk2MDAgYnl0ZXMpDQo+IC1k
aXNrIHNpemU6IDI0TQ0KPiArdmlydHVhbCBzaXplOiAyLjA1IEdpQiAoMjIwMjAwOTYwMCBieXRl
cykNCj4gK2Rpc2sgc2l6ZTogMjQgTWlCDQo+ICAgY2x1c3Rlcl9zaXplOiAxMDQ4NTc2DQo+ICAg
SW1hZ2UgcmVzaXplZC4NCj4gLXZpcnR1YWwgc2l6ZTogNS4wTSAoNTI0Mjg4MCBieXRlcykNCj4g
LWRpc2sgc2l6ZTogOS4wTQ0KPiArdmlydHVhbCBzaXplOiA1IE1pQiAoNTI0Mjg4MCBieXRlcykN
Cj4gK2Rpc2sgc2l6ZTogOS4wMSBNaUINCj4gICBjbHVzdGVyX3NpemU6IDEwNDg1NzYNCj4gICAq
KiogZG9uZQ0KPiANCj4gV2l0aCB0aGUgdXBkYXRlZCBvdXRwdXQgdG8gbWF0Y2ggY2hhbmdlcyB0
byBxZW11LWltZyBvdXRwdXQsIHRoZSBncmFtbWFyDQo+IGZpeGVzLCBhbmQgd2l0aCB0aGUgLVQg
b3B0aW9uIHJlbW92ZWQsDQo+IA0KPiBSZXZpZXdlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJl
ZGhhdC5jb20+DQo+IFRlc3RlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+
IA0KDQpUaGFuayB5b3UhDQoNCkknbGwgcmVzZW5kIHNvb24uDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

