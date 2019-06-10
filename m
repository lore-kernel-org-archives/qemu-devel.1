Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B54EC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D68620859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PK4VbqOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D68620859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haJsg-0006W1-Nw
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 08:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37227)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1haJps-0004JU-9A
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1haJbG-00049p-Iv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:40:39 -0400
Received: from mail-eopbgr50109.outbound.protection.outlook.com
 ([40.107.5.109]:8716 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1haJbE-00045l-U1; Mon, 10 Jun 2019 08:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S69Nm21iPErbVR5yfqfKIASXF8W1b2eV9/NRijtNx7k=;
 b=PK4VbqOV6gnQqCTYPOuCvvBtl/u8fG+y5BswEPzmK9kbB7butkjLkkinbyoU2ky/dAkxpTC2ev+NArV5i6atdk0xVO3xhW3c7XeoFTHBT0Ad6zYRwS2/ZV6ZD6uefe0qnUMF8c8fxnbzIYK5lKvnM7RhRgy/x4rRPVp0I3Kjrgs=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4226.eurprd08.prod.outlook.com (20.179.36.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Mon, 10 Jun 2019 12:40:26 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::d5c1:9518:28cb:4489]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::d5c1:9518:28cb:4489%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 12:40:26 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v5] qemu-io: add pattern file for write
 command
Thread-Index: AQHVF4UioPR1fRFQnkqQBC16lGSy/aaFV94AgA+Mb4A=
Date: Mon, 10 Jun 2019 12:40:26 +0000
Message-ID: <009df0c2-7d2b-1d3d-c7ae-3a9c2f569dfc@virtuozzo.com>
References: <20190531074620.24934-1-dplotnikov@virtuozzo.com>
 <d2498589-e866-475c-13dd-fe9ce35b914b@redhat.com>
In-Reply-To: <d2498589-e866-475c-13dd-fe9ce35b914b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0147.eurprd05.prod.outlook.com
 (2603:10a6:7:28::34) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b5b08ab-f786-4e29-8733-08d6eda0cfe8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4226; 
x-ms-traffictypediagnostic: AM0PR08MB4226:
x-microsoft-antispam-prvs: <AM0PR08MB42266A7E6685750DFF37E8E4CF130@AM0PR08MB4226.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(186003)(64756008)(6486002)(66476007)(53936002)(66066001)(8936002)(66556008)(478600001)(229853002)(6512007)(66946007)(73956011)(66446008)(476003)(6436002)(68736007)(11346002)(6246003)(2616005)(446003)(25786009)(2501003)(14454004)(486006)(107886003)(2201001)(4326008)(6116002)(2906002)(71200400001)(7736002)(36756003)(5660300002)(71190400001)(99286004)(305945005)(316002)(110136005)(3846002)(256004)(54906003)(53546011)(31686004)(102836004)(8676002)(26005)(86362001)(52116002)(81156014)(81166006)(76176011)(6506007)(31696002)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4226;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RZM5KHKD5QyM7yiwxOYLZIW2dksTpYwgg5TNAnTTpkeUrvoVJe7TTAbGzuMGuRVc+zI/NWIIcfoce+YX2ClMPzRhefCXQ9oZCmOY5YxE8wooquPcyMVT9CjWvo4+m7BHUgeRL/Ci6CHbovjtcPv/PykU0TLvGxiLE7BKmafK0ocPcmFtiuL2890nVjJvjOrY9wTMi9fBfCFaM1yqPjDQ1f66SS3CsdEwe2wzSMOMJt7xS8D7cHXbdMMxkK8fKYJf8NKf8C4yYw84L3Db+4y3Ir3F8jLaflX2oee0NFfptft3QfYtdm+maJjmJXqyspZGPNWVNq/1P2n/eMI5cDleZSwFfqfhfgMTFTmB3bDC9n8eL7Ir2X8R2lRuZUwmn41P6Saw6AfMTR27++KuUtm0T2nPAIapw7/SuQ/GrvO/hvM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <011A213CBCA0A147BC572D3E4BC36508@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5b08ab-f786-4e29-8733-08d6eda0cfe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 12:40:26.1155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4226
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.109
Subject: Re: [Qemu-devel] [PATCH v5] qemu-io: add pattern file for write
 command
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDMxLjA1LjIwMTkgMTg6MTMsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDUvMzEvMTkg
Mjo0NiBBTSwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPj4gVGhlIHBhdGNoIGFsbG93cyB0byBw
cm92aWRlIGEgcGF0dGVybiBmaWxlIGZvciB3cml0ZQ0KPj4gY29tbWFuZC4gVGhlcmUgd2FzIG5v
IHNpbWlsYXIgYWJpbGl0eSBiZWZvcmUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgUGxv
dG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+IHY1Og0KPj4gICAg
KiBmaWxlIG5hbWUgaW5pdGlhdGVkIHdpdGggbnVsbCB0byBtYWtlIGNvbXBpbGVycyBoYXBweQ0K
Pj4NCj4gDQo+PiArc3RhdGljIHZvaWQgKnFlbXVfaW9fYWxsb2NfZnJvbV9maWxlKEJsb2NrQmFj
a2VuZCAqYmxrLCBzaXplX3QgbGVuLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjaGFyICpmaWxlX25hbWUpDQo+PiArew0KPj4gKyAgICBjaGFyICpidWYsICpidWZf
cG9zOw0KPj4gKyAgICBGSUxFICpmID0gZm9wZW4oZmlsZV9uYW1lLCAiciIpOw0KPj4gKyAgICBp
bnQgbDsNCj4+ICsNCj4+ICsgICAgaWYgKCFmKSB7DQo+PiArICAgICAgICBwcmludGYoIiclcyc6
ICVzXG4iLCBmaWxlX25hbWUsIHN0cmVycm9yKGVycm5vKSk7DQo+PiArICAgICAgICByZXR1cm4g
TlVMTDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAocWVtdWlvX21pc2FsaWduKSB7DQo+
PiArICAgICAgICBsZW4gKz0gTUlTQUxJR05fT0ZGU0VUOw0KPj4gKyAgICB9DQo+PiArICAgIGJ1
ZiA9IGJsa19ibG9ja2FsaWduKGJsaywgbGVuKTsNCj4+ICsgICAgbWVtc2V0KGJ1ZiwgMCwgbGVu
KTsNCj4+ICsNCj4+ICsgICAgYnVmX3BvcyA9IGJ1ZjsNCj4+ICsNCj4+ICsgICAgd2hpbGUgKGxl
biA+IDApIHsNCj4+ICsgICAgICAgIGwgPSBmcmVhZChidWZfcG9zLCBzaXplb2YoY2hhciksIGxl
biwgZik7DQo+PiArDQo+PiArICAgICAgICBpZiAoZmVvZihmKSkgew0KPj4gKyAgICAgICAgICAg
IHJld2luZChmKTsNCj4+ICsgICAgICAgIH0NCj4gDQo+IFdoeSBhcmUgd2UgcmVhZGluZyB0aGUg
ZmlsZSBtb3JlIHRoYW4gb25jZT8gT25jZSB3ZSd2ZSByZWFkIGl0IG9uY2UsDQo+IGl0J3MgbW9y
ZSBlZmZpY2llbnQgdG8gc3dpdGNoIHRvIGEgbG9vcCB0aGF0IG1lbWNweSgpcyB0aGUgcHJlZml4
IGludG8NCj4gdGhlIHJlc3Qgb2YgdGhlIGJ1ZmZlciwgcmF0aGVyIHRoYW4gdG8gcGVyZm9ybSBy
ZXBlYXRlZCBJL08uDQo+IA0KWWVzLCBpdCBpcy4gV2lsbCBjaGFuZ2UgaXQuDQoNCkRlbmlzDQo=

