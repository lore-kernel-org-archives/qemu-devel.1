Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74010C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB432087B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TUFm5jYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB432087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRDRN-0000rM-7M
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 06:16:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRDQJ-0000Bc-NH
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRDNM-0002VN-Dw
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:12:37 -0400
Received: from mail-eopbgr40112.outbound.protection.outlook.com
	([40.107.4.112]:2692
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRDNK-0002Rv-GI; Thu, 16 May 2019 06:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=kXc0BaudoYAhwBjA7v0XCQD1Qwy7wu0gjodt5a1DkG8=;
	b=TUFm5jYrxRDyQwrurOweGR5jFCAy2o3RUNytLHT4uqK1lVnf941G6HyGXaMVSo9lj2Lg44kt6JCWmFHL4E9s4PZ4zgSzMVu9YW1o/YsO7zGQzXd6GNIPFd1urHRKccv2qd4cildwb/vWQz/FAFT0E0tx0yAUCJTzVuoEXNTj2N4=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB3528.eurprd08.prod.outlook.com (20.177.114.209) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Thu, 16 May 2019 10:12:30 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Thu, 16 May 2019 10:12:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2] migration/dirty-bitmaps: change bitmap enumeration
	method
Thread-Index: AQHVCpJiO5csnRf0D0OxXxQO3Uu316ZtipWA
Date: Thu, 16 May 2019 10:12:30 +0000
Message-ID: <72986b5d-0772-abfb-2c99-97470e8fd3da@virtuozzo.com>
References: <20190514201926.10407-1-jsnow@redhat.com>
In-Reply-To: <20190514201926.10407-1-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0166.eurprd05.prod.outlook.com
	(2603:10a6:3:f8::14) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190516131227930
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29a9dcce-4b4e-40e2-d5a2-08d6d9e7011f
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3528; 
x-ms-traffictypediagnostic: AM6PR08MB3528:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB35281468E8BF146A310C0661C10A0@AM6PR08MB3528.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(376002)(366004)(396003)(346002)(39850400004)(52314003)(189003)(199004)(3846002)(6116002)(25786009)(4326008)(66476007)(66556008)(64756008)(66446008)(66946007)(966005)(73956011)(256004)(305945005)(53936002)(68736007)(7736002)(36756003)(6246003)(14454004)(5660300002)(31686004)(110136005)(11346002)(446003)(71200400001)(71190400001)(6306002)(2501003)(6512007)(229853002)(6436002)(2616005)(476003)(6486002)(14444005)(6506007)(52116002)(102836004)(316002)(76176011)(386003)(486006)(99286004)(186003)(26005)(8676002)(81156014)(66066001)(81166006)(86362001)(54906003)(31696002)(2201001)(2906002)(478600001)(5024004)(8936002)(14143004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3528;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P/1Rfyq4Bhw7hBjISYmv2DR6UxuB+Ca+NXDKnSiXaacEeMQjs+705th4vfhPV5TllBnPnFZazhE0t26Knq3PgPH4RqQrepKCZ55L4TSn9Hp0TvKKcfUr7SNoejUKz+CGrgVIfGc3sWtqS9Fn6vJA8Vj4lw/s3asw5pfgbjl89NVaECrpAFl69X8vP7djq9WelOkqAuN30VEVU/NcdQz277jpSSCCsjWsG+sOd//3eIb9Z4gbRw98w6undkQb3XeNSURN6EeG7AKglHmP48uTs1jX2BYu3TXU+qxNcVAZmRLNvsoambwumTINkznNd52ylwvm9el90aBv07lxF5rGkWLKiZrrn41XH9a/7PBIyywqfnXCCSCP54c2COuT2s9eEbpTVEEdfTHTn2ydt2avFWzAe2iNLOJROQkYo9Z0jR4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CED074B4F098FD47B6733BA66F2431B3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a9dcce-4b4e-40e2-d5a2-08d6d9e7011f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 10:12:30.6655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3528
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.112
Subject: Re: [Qemu-devel] [PATCH v2] migration/dirty-bitmaps: change bitmap
 enumeration method
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	aihua liang <aliang@redhat.com>, Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMDUuMjAxOSAyMzoxOSwgSm9obiBTbm93IHdyb3RlOg0KPiBTaGlmdCBmcm9tIGxvb2tpbmcg
YXQgZXZlcnkgcm9vdCBCRFMgdG8gKmV2ZXJ5KiBCRFMuIFRoaXMgd2lsbCBtaWdyYXRlDQo+IGJp
dG1hcHMgdGhhdCBhcmUgYXR0YWNoZWQgdG8gYmxvY2tkZXYgY3JlYXRlZCBub2RlcyBpbnN0ZWFk
IG9mIGp1c3Qgb25lcw0KPiBhdHRhY2hlZCB0byBlbXVsYXRlZCBzdG9yYWdlIGRldmljZXMuDQo+
IA0KPiBOb3RlIHRoYXQgdGhpcyB3aWxsIG5vdCBtaWdyYXRlIGFub255bW91cyBvciBpbnRlcm5h
bC11c2UgYml0bWFwcywgYXMNCj4gdGhvc2UgYXJlIGRlZmluZWQgYXMgaGF2aW5nIG5vIG5hbWUu
DQo+IA0KPiBUaGlzIHdpbGwgYWxzbyBmaXggdGhlIENvdmVyaXR5IGlzc3VlcyBQZXRlciBNYXlk
ZWxsIGhhcyBiZWVuIGFza2luZw0KPiBhYm91dCBmb3IgdGhlIHBhc3Qgc2V2ZXJhbCByZWxlYXNl
cywgYXMgd2VsbCBhcyBmaXhpbmcgYSByZWFsIGJ1Zy4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBQZXRl
ciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFJlcG9ydGVkLWJ5OiBDb3Zl
cml0eSDwn5iFDQo+IFJlcG9ydGVkLWJ5OiBhaWh1YSBsaWFuZyA8YWxpYW5nQHJlZGhhdC5jb20+
DQo+IEZpeGVzOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE2
NTI0OTANCj4gRml4ZXM6IENvdmVyaXR5IENJRCAxMzkwNjI1DQo+IENDOiBTdGVmYW4gSGFqbm9j
emkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdyA8anNu
b3dAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5j
IHwgMTQgKysrKy0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vYmxvY2stZGly
dHktYml0bWFwLmMgYi9taWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwLmMNCj4gaW5kZXggZDFi
Yjg2M2NiNi4uNGE4OTZhMDllYiAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL2Jsb2NrLWRpcnR5
LWJpdG1hcC5jDQo+ICsrKyBiL21pZ3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYw0KPiBAQCAt
MjczLDcgKzI3Myw2IEBAIHN0YXRpYyBpbnQgaW5pdF9kaXJ0eV9iaXRtYXBfbWlncmF0aW9uKHZv
aWQpDQo+ICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJzOw0KPiAgICAgICBCZHJ2RGlydHlCaXRt
YXAgKmJpdG1hcDsNCj4gICAgICAgRGlydHlCaXRtYXBNaWdCaXRtYXBTdGF0ZSAqZGJtczsNCj4g
LSAgICBCZHJ2TmV4dEl0ZXJhdG9yIGl0Ow0KPiAgICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVM
TDsNCj4gICANCj4gICAgICAgZGlydHlfYml0bWFwX21pZ19zdGF0ZS5idWxrX2NvbXBsZXRlZCA9
IGZhbHNlOw0KPiBAQCAtMjgxLDEzICsyODAsOCBAQCBzdGF0aWMgaW50IGluaXRfZGlydHlfYml0
bWFwX21pZ3JhdGlvbih2b2lkKQ0KPiAgICAgICBkaXJ0eV9iaXRtYXBfbWlnX3N0YXRlLnByZXZf
Yml0bWFwID0gTlVMTDsNCj4gICAgICAgZGlydHlfYml0bWFwX21pZ19zdGF0ZS5ub19iaXRtYXBz
ID0gZmFsc2U7DQo+ICAgDQo+IC0gICAgZm9yIChicyA9IGJkcnZfZmlyc3QoJml0KTsgYnM7IGJz
ID0gYmRydl9uZXh0KCZpdCkpIHsNCj4gLSAgICAgICAgY29uc3QgY2hhciAqZHJpdmVfbmFtZSA9
IGJkcnZfZ2V0X2RldmljZV9vcl9ub2RlX25hbWUoYnMpOw0KPiAtDQo+IC0gICAgICAgIC8qIHNr
aXAgYXV0b21hdGljYWxseSBpbnNlcnRlZCBub2RlcyAqLw0KPiAtICAgICAgICB3aGlsZSAoYnMg
JiYgYnMtPmRydiAmJiBicy0+aW1wbGljaXQpIHsNCj4gLSAgICAgICAgICAgIGJzID0gYmFja2lu
Z19icyhicyk7DQo+IC0gICAgICAgIH0NCg0KaG0sIHNvLCBhZnRlciB0aGUgcGF0Y2gsIGZvciBp
bXBsaWNpdGx5LWZpbHRlcmVkIG5vZGVzIHdlJ2xsIGhhdmUgbm9kZV9uYW1lIGluc3RlYWQgb2Yg
ZGV2aWNlIG5hbWUuLg0KDQpCdXQsIG9uIHRoZSBvdGhlciwgaGFuZCwgaWYgd2UgaGF2ZSBpbXBs
aWNpdGx5LWZpbHRlcmVkIG5vZGUgb24gdGFyZ2V0LCB3ZSB3ZXJlIGRvaW5nIHdyb25nIHRoaW5n
IGFueXdheSwNCmFzIGRpcnR5X2JpdG1hcF9sb2FkX2hlYWRlciBkb24ndCBza2lwIGltcGxpY2l0
IG5vZGVzLg0KDQo+ICsgICAgZm9yIChicyA9IGJkcnZfbmV4dF9hbGxfc3RhdGVzKE5VTEwpOyBi
czsgYnMgPSBiZHJ2X25leHRfYWxsX3N0YXRlcyhicykpIHsNCg0KQXMgSSB1bmRlcnN0YW5kLCBk
aWZmZXJlbmNlIHdpdGggYmRydl9uZXh0X25vZGUgaXMgdGhhdCB3ZSBkb24ndCBza2lwIHVubmFt
ZWQgbm9kZXMgWy4uLl0NCg0KPiArICAgICAgICBjb25zdCBjaGFyICpuYW1lID0gYmRydl9nZXRf
ZGV2aWNlX29yX25vZGVfbmFtZShicyk7DQo+ICAgDQo+ICAgICAgICAgICBmb3IgKGJpdG1hcCA9
IGJkcnZfZGlydHlfYml0bWFwX25leHQoYnMsIE5VTEwpOyBiaXRtYXA7DQo+ICAgICAgICAgICAg
ICAgIGJpdG1hcCA9IGJkcnZfZGlydHlfYml0bWFwX25leHQoYnMsIGJpdG1hcCkpDQo+IEBAIC0y
OTYsNyArMjkwLDcgQEAgc3RhdGljIGludCBpbml0X2RpcnR5X2JpdG1hcF9taWdyYXRpb24odm9p
ZCkNCj4gICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICAgICAgICAgICAgICAgfQ0KPiAg
IA0KPiAtICAgICAgICAgICAgaWYgKGRyaXZlX25hbWUgPT0gTlVMTCkgew0KPiArICAgICAgICAg
ICAgaWYgKCFuYW1lIHx8IHN0cmNtcChuYW1lLCAiIikgPT0gMCkgew0KDQpbLi4uXSB0byBkbyB0
aGlzIChtYXkgYmUgcGFyYW5vaWFjLCBidXQgd2h5IG5vdD8pIGNoZWNrDQoNCj4gICAgICAgICAg
ICAgICAgICAgZXJyb3JfcmVwb3J0KCJGb3VuZCBiaXRtYXAgJyVzJyBpbiB1bm5hbWVkIG5vZGUg
JXAuIEl0IGNhbid0ICINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJiZSBtaWdy
YXRlZCIsIGJkcnZfZGlydHlfYml0bWFwX25hbWUoYml0bWFwKSwgYnMpOw0KPiAgICAgICAgICAg
ICAgICAgICBnb3RvIGZhaWw7DQo+IEBAIC0zMTMsNyArMzA3LDcgQEAgc3RhdGljIGludCBpbml0
X2RpcnR5X2JpdG1hcF9taWdyYXRpb24odm9pZCkNCj4gICANCj4gICAgICAgICAgICAgICBkYm1z
ID0gZ19uZXcwKERpcnR5Qml0bWFwTWlnQml0bWFwU3RhdGUsIDEpOw0KPiAgICAgICAgICAgICAg
IGRibXMtPmJzID0gYnM7DQo+IC0gICAgICAgICAgICBkYm1zLT5ub2RlX25hbWUgPSBkcml2ZV9u
YW1lOw0KPiArICAgICAgICAgICAgZGJtcy0+bm9kZV9uYW1lID0gbmFtZTsNCj4gICAgICAgICAg
ICAgICBkYm1zLT5iaXRtYXAgPSBiaXRtYXA7DQo+ICAgICAgICAgICAgICAgZGJtcy0+dG90YWxf
c2VjdG9ycyA9IGJkcnZfbmJfc2VjdG9ycyhicyk7DQo+ICAgICAgICAgICAgICAgZGJtcy0+c2Vj
dG9yc19wZXJfY2h1bmsgPSBDSFVOS19TSVpFICogOCAqDQo+IA0KDQpUaGVyZSBpcyBzdGlsbCBz
b21lIG1lc3MgYWJvdXQgZGV2aWNlIG5hbWUgdnMgbm9kZSBuYW1lLCBhbmQgSSBkb24ndCBrbm93
LCBjb3VsZCB3ZSBzb21laG93DQpzb2x2ZSBpdCwgYnV0IHBhdGNoIGxvb2tzIE9LIGZvciBtZSBh
bnl3YXk6DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

