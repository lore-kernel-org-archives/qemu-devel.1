Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F86FC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EEF207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hN2M8JMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EEF207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxLR-0004Bu-1O
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJxKe-0003gu-AO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJxKc-0004pF-Pg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:12:04 -0400
Received: from mail-eopbgr130100.outbound.protection.outlook.com
 ([40.107.13.100]:30954 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJxKW-0004YJ-SZ; Mon, 14 Oct 2019 06:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrs37IWWIbt7d0jNizMQTV0tOUdS7JRsHUDEHxd75usJVDL30P8mbtIxmL32iaCXhoeiwZSgjBvGcmQL7iKDeS0Pwh4Kw1vHYukTL7lo2eZDTb2j1fO/mHGhPMiHWzipMNLKPTOIDhkB/vTJ/uuEVgwkzfBQLl3EtkbiVFbC5IUfnfdSakvZRn+V9Ws6wPC0xo4tHoTGhxEVyq4oC7RPXUnbV9uVL31CcXuuAQEoFM5G+t241SK9fP8TIEveBAyEHgmx6bpwwtGk/gUJEVvo5y0QVUnereWt2e/4YfZfLL8NI5ePYzEaFCAsf1TDbk6OFYnY2RaZ/YBYewigEPocQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsY0d/nZqimiWUnMClTc09mBmnlSk5EWxNFaUYxMIMg=;
 b=AmhNcpIwy6+SE+AKG2718/RjaIvlcu+qTwnggLiheGw5XoPTUjoNMptM4lRR4eTs46aUfgUC0/Rhr9PMCeuC4Kz1CfMIdGEUbzmgowHkYpXtrJDOc9LZJhcJTUAsE8hFrNWGOjNGKSHtCDXw2+bhFathzCw34a5qXzFf7axL4F0o/5uAgU5So5PvVZoLY9RmjSsjptJ8Wgwh/WxzFGOowH9x20uPFuqX8ihiU6NQRTthXfNGqKu0lSbdCAJFANgwTg8lUqrfgv2JjlXbLt6yrnLLspS+1oTeC1qMhWo5CxGRn0B9KH7zLp8+GTYagqfZvLJ2Zp6sgp/4fVtX91kjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsY0d/nZqimiWUnMClTc09mBmnlSk5EWxNFaUYxMIMg=;
 b=hN2M8JMfBJjhEIGA/n1uBQT67Nc8GGKFxnpQ+BJzlRiFMQPHssawJRwKETgW3TF7EJ/HETpwrjLR0uQiGshysd4iB0tkk6Q/s/MNl0Gy3v6PVt0+6s476IeQFcZT4wabJ0qlH1iKfiWhnmfzcRgapdo+kF8fASnUWGh1ZLvwWBE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5017.eurprd08.prod.outlook.com (10.255.19.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 14 Oct 2019 10:11:53 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 10:11:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] block: Reject misaligned write requests with
 BDRV_REQ_NO_FALLBACK
Thread-Topic: [PATCH] block: Reject misaligned write requests with
 BDRV_REQ_NO_FALLBACK
Thread-Index: AQHVgggiF38wa8WrGky2vaXA9FnGJqdZ64YA
Date: Mon, 14 Oct 2019 10:11:52 +0000
Message-ID: <6bbe4db2-a4fd-ee2b-1b79-879658b81753@virtuozzo.com>
References: <20191013204853.1046-1-berto@igalia.com>
In-Reply-To: <20191013204853.1046-1-berto@igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0049.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::38) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191014131150644
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03009929-8be5-46ae-9063-08d7508eef57
x-ms-traffictypediagnostic: DB8PR08MB5017:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5017FA8AAED9BB64942AC15DC1900@DB8PR08MB5017.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(136003)(396003)(376002)(366004)(199004)(189003)(71190400001)(52116002)(31696002)(99286004)(25786009)(5660300002)(8936002)(81166006)(81156014)(8676002)(186003)(31686004)(76176011)(66066001)(102836004)(14454004)(71200400001)(2501003)(54906003)(386003)(110136005)(26005)(86362001)(316002)(6506007)(478600001)(6116002)(305945005)(3846002)(476003)(7736002)(2906002)(486006)(11346002)(446003)(2616005)(4326008)(36756003)(256004)(14444005)(66446008)(64756008)(66556008)(66476007)(66946007)(6486002)(6246003)(6512007)(6306002)(6436002)(229853002)(21314003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5017;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VlCHyovkA/N5fkhb/P/2ofpPvR6CVYMaNyBStz2tWkQslNVVSNTGmB53R5WebwRlaUZJ+ozNeMk+/9PuHZlS3lUEhAk9oKLnXgadEUkJzZ2ZhJ8XuhoDT+CUmBhJOs7iIY7o6Ot8cfMQf9I+rCibsOftlE3RLBnPyruKVToc/VrMrz0nelChq+SS9WBxSC/aqxOJyrgvoj+hXmXE1fdXJjQmw5bGy+pbXNN7RDKjB9MfvFoETxaB11p0CU4Kn2ubqeY0zqHTWo6aAdJyidKPAXxmOGzGB6L+ctqpg1fF+Y/muTHybBHkKWv/1svQa02nBZ1bSRJTn36oNCYlEU9EuZapTYn7n/w0bAS0o/apraYyrCpLpBn8LOmzLL+gEBWOYwP18B/lsd9ZhsL98Jocl2DbxSav2KSNNnztcR6vWLXeprvyHa10J4yE73A/QPBHPGCPM8FAg9D/moh1DlcF2A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA038DA46A30F48A7EE115EE5D22584@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03009929-8be5-46ae-9063-08d7508eef57
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 10:11:52.9847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpuMTk0z3MmicNMt9t4KdddN+VuhtXhZZBLF4LNuMJ5tdqbqyRAQYH56xvwiHEQDXUUE6MtxEkF+CK239Qr1P8J0P7cqvvbFr0W/yQ54/UU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5017
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.100
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMTAuMjAxOSAyMzo0OCwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IFRoZSBCRFJWX1JFUV9O
T19GQUxMQkFDSyBmbGFnIG1lYW5zIHRoYXQgYW4gb3BlcmF0aW9uIHNob3VsZCBvbmx5IGJlDQo+
IHBlcmZvcm1lZCBpZiBpdCBjYW4gYmUgb2ZmbG9hZGVkIG9yIG90aGVyd2lzZSBwZXJmb3JtZWQg
ZWZmaWNpZW50bHkuDQoNCkFzIEkga25vdywgQkRSVl9SRVFfTk9fRkFMTEJBQ0sgaXMgZm9yIHdy
aXRlLXplcm9zIG9ubHksIG5vdCBhYm91dCBvZmZsb2FkaW5nLi4NCg0KPiANCj4gSG93ZXZlciBh
IG1pc2FsaWduZWQgd3JpdGUgcmVxdWVzdCByZXF1aXJlcyBhIFJNVyBzbyB3ZSBzaG91bGQgcmV0
dXJuDQo+IGFuIGVycm9yIGFuZCBsZXQgdGhlIGNhbGxlciBkZWNpZGUgaG93IHRvIHByb2NlZWQu
DQoNCkJlY2F1c2Ugd2UgY2FuIGZpbmlzaCB1cCB3aXRoIHRyeWluZyB0byB0byBub3JtYWwgd3Jp
dGUgKG5vdCB3cml0ZV96ZXJvKSB3aXRoDQpCRFJWX1JFUV9OT19GQUxMQkFDSyBmbGFnLCB3aGlj
aCBpcyBmb3JiaWRkZW4gZm9yIGJkcnZfZHJpdmVyX3B3cml0ZXYsIGFzIGl0J3MNCnNob3duIGlu
IGFzc2VydGlvbiBiZWxvdy4NCg0KPiANCj4gVGhpcyBoaXRzIGFuIGFzc2VydGlvbiBzaW5jZSBj
b21taXQgYzhiYjIzY2JkYiBpZiB0aGUgcmVxdWlyZWQNCj4gYWxpZ25tZW50IGlzIGxhcmdlciB0
aGFuIHRoZSBjbHVzdGVyIHNpemU6DQo+IA0KPiBxZW11LWltZyBjcmVhdGUgLWYgcWNvdzIgLW8g
Y2x1c3Rlcl9zaXplPTJrIGltZy5xY293MiA0Rw0KPiBxZW11LWlvIC1jICJvcGVuIC1vIGRyaXZl
cj1xY293MixmaWxlLmFsaWduPTRrIGJsa2RlYnVnOjppbWcucWNvdzIiIFwNCj4gICAgICAgICAg
LWMgJ3dyaXRlIDAgNTEyJw0KPiBxZW11LWlvOiBibG9jay9pby5jOjExMjc6IGJkcnZfZHJpdmVy
X3B3cml0ZXY6IEFzc2VydGlvbiBgIShmbGFncyAmIEJEUlZfUkVRX05PX0ZBTExCQUNLKScgZmFp
bGVkLg0KPiBBYm9ydGVkDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGJlcnRvIEdhcmNpYSA8YmVy
dG9AaWdhbGlhLmNvbT4NCj4gLS0tDQo+ICAgYmxvY2svaW8uYyAgICAgICAgICAgICAgICAgfCAg
NiArKysrKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNjggICAgIHwgNTUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjY4Lm91
dCB8ICA3ICsrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwICAgfCAgMSArDQo+ICAg
NCBmaWxlcyBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNzU1
IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjgNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcWVt
dS1pb3Rlc3RzLzI2OC5vdXQNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9pby5jIGIvYmxvY2sv
aW8uYw0KPiBpbmRleCA0ZjllZTk3YzJiLi5jNWQ0ZDAyOWRhIDEwMDY0NA0KPiAtLS0gYS9ibG9j
ay9pby5jDQo+ICsrKyBiL2Jsb2NrL2lvLmMNCj4gQEAgLTIwNzEsNiArMjA3MSwxMiBAQCBpbnQg
Y29yb3V0aW5lX2ZuIGJkcnZfY29fcHdyaXRldl9wYXJ0KEJkcnZDaGlsZCAqY2hpbGQsDQo+ICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICB9DQo+ICAgDQo+ICsgICAgLyogSWYgdGhlIHJl
cXVlc3QgaXMgbWlzYWxpZ25lZCB0aGVuIHdlIGNhbid0IG1ha2UgaXQgZWZmaWNpZW50ICovDQo+
ICsgICAgaWYgKCgob2Zmc2V0ICYgKGFsaWduIC0gMSkpIHx8IChieXRlcyAmIChhbGlnbiAtIDEp
KSkgJiYNCj4gKyAgICAgICAgKGZsYWdzICYgQkRSVl9SRVFfTk9fRkFMTEJBQ0spKSB7DQo+ICsg
ICAgICAgIHJldHVybiAtRU5PVFNVUDsNCj4gKyAgICB9DQo+ICsNCg0KU28sIGlmIEJEUlZfUkVR
X05PX0ZBTExCQUNLIGlzIG9ubHkgZm9yIHdyaXRlIHplcm9zLCBtb3N0IGNvcnJlY3QgcGxhY2Ug
Zm9yIHRoaXMgY2hlY2sNCmlzIGJkcnZfY29fZG9femVyb19wd3JpdGV2KCkuLiBCdXQgaXQncyBP
SyBhcyBpcyB0b28uDQoNCk5vdCBsb25nIGFnbyBzdWNoIGNoZWNrcyB3YXMgZml4ZWQgdG8gYmUg
UUVNVV9JU19BTElHTkVELCBzbyB3aXRoIGl0IHVzZWQgaW5zdGVhZDoNClJldmlld2VkLWJ5OiBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoN
Cj4gICAgICAgYmRydl9pbmNfaW5fZmxpZ2h0KGJzKTsNCj4gICAgICAgLyoNCj4gICAgICAgICog
QWxpZ24gd3JpdGUgaWYgbmVjZXNzYXJ5IGJ5IHBlcmZvcm1pbmcgYSByZWFkLW1vZGlmeS13cml0
ZSBjeWNsZS4NCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNjggYi90ZXN0cy9x
ZW11LWlvdGVzdHMvMjY4DQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAwMDAw
MDAuLjg5NWY2ZTU5M2YNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVz
dHMvMjY4DQo+IEBAIC0wLDAgKzEsNTUgQEANCj4gKyMhL3Vzci9iaW4vZW52IGJhc2gNCj4gKyMN
Cj4gKyMgVGVzdCB3cml0ZSByZXF1ZXN0IHdpdGggcmVxdWlyZWQgYWxpZ25tZW50IGxhcmdlciB0
aGFuIHRoZSBjbHVzdGVyIHNpemUNCj4gKyMNCj4gKyMgQ29weXJpZ2h0IChDKSAyMDE5IElnYWxp
YSwgUy5MLg0KPiArIyBBdXRob3I6IEFsYmVydG8gR2FyY2lhIDxiZXJ0b0BpZ2FsaWEuY29tPg0K
PiArIw0KPiArIyBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KPiArIyBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KPiArIyB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcg0K
PiArIyAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLg0KPiArIw0KPiArIyBUaGlz
IHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1
bCwNCj4gKyMgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxp
ZWQgd2FycmFudHkgb2YNCj4gKyMgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFS
VElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KPiArIyBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBmb3IgbW9yZSBkZXRhaWxzLg0KPiArIw0KPiArIyBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQg
YSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQ0KPiArIyBhbG9uZyB3aXRo
IHRoaXMgcHJvZ3JhbS4gIElmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMv
Pi4NCj4gKyMNCj4gKw0KPiArIyBjcmVhdG9yDQo+ICtvd25lcj1iZXJ0b0BpZ2FsaWEuY29tDQo+
ICsNCj4gK3NlcT1gYmFzZW5hbWUgJDBgDQo+ICtlY2hvICJRQSBvdXRwdXQgY3JlYXRlZCBieSAk
c2VxIg0KPiArDQo+ICtzdGF0dXM9MQkjIGZhaWx1cmUgaXMgdGhlIGRlZmF1bHQhDQo+ICsNCj4g
K19jbGVhbnVwKCkNCj4gK3sNCj4gKyAgICBfY2xlYW51cF90ZXN0X2ltZw0KPiArfQ0KPiArdHJh
cCAiX2NsZWFudXA7IGV4aXQgXCRzdGF0dXMiIDAgMSAyIDMgMTUNCj4gKw0KPiArIyBnZXQgc3Rh
bmRhcmQgZW52aXJvbm1lbnQsIGZpbHRlcnMgYW5kIGNoZWNrcw0KPiArLiAuL2NvbW1vbi5yYw0K
PiArLiAuL2NvbW1vbi5maWx0ZXINCj4gKw0KPiArX3N1cHBvcnRlZF9mbXQgcWNvdzINCj4gK19z
dXBwb3J0ZWRfcHJvdG8gZmlsZQ0KPiArDQo+ICtlY2hvDQo+ICtlY2hvICI9PSBSZXF1aXJlZCBh
bGlnbm1lbnQgbGFyZ2VyIHRoYW4gY2x1c3RlciBzaXplID09Ig0KPiArDQo+ICtDTFVTVEVSX1NJ
WkU9MmsgX21ha2VfdGVzdF9pbWcgMU0NCj4gKyMgU2luY2UgY29tbWl0IGM4YmIyM2NiZGIgd3Jp
dGluZyB0byBhbiBhbGxvY2F0ZWQgY2x1c3RlciBmaWxscyB0aGUNCj4gKyMgZW1wdHkgQ09XIGFy
ZWFzIHdpdGggYmRydl93cml0ZV96ZXJvZXMoZmxhZ3M9QkRSVl9SRVFfTk9fRkFMTEJBQ0spDQo+
ICskUUVNVV9JTyAtYyAib3BlbiAtbyBkcml2ZXI9JElNR0ZNVCxmaWxlLmFsaWduPTRrIGJsa2Rl
YnVnOjokVEVTVF9JTUciIFwNCj4gKyAgICAgICAgIC1jICJ3cml0ZSAwIDUxMiIgfCBfZmlsdGVy
X3FlbXVfaW8NCj4gKw0KPiArIyBzdWNjZXNzLCBhbGwgZG9uZQ0KPiArZWNobyAiKioqIGRvbmUi
DQo+ICtybSAtZiAkc2VxLmZ1bGwNCj4gK3N0YXR1cz0wDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9x
ZW11LWlvdGVzdHMvMjY4Lm91dCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNjgub3V0DQo+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjJlZDZjNjg1MjkNCj4gLS0tIC9k
ZXYvbnVsbA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjY4Lm91dA0KPiBAQCAtMCwwICsx
LDcgQEANCj4gK1FBIG91dHB1dCBjcmVhdGVkIGJ5IDI2OA0KPiArDQo+ICs9PSBSZXF1aXJlZCBh
bGlnbm1lbnQgbGFyZ2VyIHRoYW4gY2x1c3RlciBzaXplID09DQo+ICtGb3JtYXR0aW5nICdURVNU
X0RJUi90LklNR0ZNVCcsIGZtdD1JTUdGTVQgc2l6ZT0xMDQ4NTc2DQo+ICt3cm90ZSA1MTIvNTEy
IGJ5dGVzIGF0IG9mZnNldCAwDQo+ICs1MTIgYnl0ZXMsIFggb3BzOyBYWDpYWDpYWC5YIChYWFgg
WVlZL3NlYyBhbmQgWFhYIG9wcy9zZWMpDQo+ICsqKiogZG9uZQ0KPiBkaWZmIC0tZ2l0IGEvdGVz
dHMvcWVtdS1pb3Rlc3RzL2dyb3VwIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+IGluZGV4
IDU4MDVhNzlkOWUuLjRjODYxZjdlZWQgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0
cy9ncm91cA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXANCj4gQEAgLTI3OCwzICsy
NzgsNCBAQA0KPiAgIDI2NSBydyBhdXRvIHF1aWNrDQo+ICAgMjY2IHJ3IHF1aWNrDQo+ICAgMjY3
IHJ3IGF1dG8gcXVpY2sgc25hcHNob3QNCj4gKzI2OCBydyBhdXRvIHF1aWNrDQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

