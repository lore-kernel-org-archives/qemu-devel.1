Return-Path: <SRS0=vKWr=3A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A0C33CA2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 02:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67C0206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 02:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67C0206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq6Ko-00038m-15
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 21:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1iq6Jg-0002Zm-Hh
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 21:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1iq6Jf-0000PJ-6j
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 21:15:56 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2051 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1iq6Je-0008Uq-R5; Fri, 10 Jan 2020 21:15:55 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id D0A4697E424D2ABCA5EC;
 Sat, 11 Jan 2020 10:15:49 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 11 Jan 2020 10:15:49 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.215]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0439.000;
 Sat, 11 Jan 2020 10:15:41 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>
Subject: RE: [PATCH] xhci: Fix memory leak in xhci_kick_epctx when poweroff
 GuestOS
Thread-Topic: [PATCH] xhci: Fix memory leak in xhci_kick_epctx when poweroff
 GuestOS
Thread-Index: AQHVx6T71tCpOn/wSkGorEYKOY6OCKfjWkgAgAFXCmA=
Date: Sat, 11 Jan 2020 02:15:40 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B0E37A2@dggemm531-mbx.china.huawei.com>
References: <20200110105855.81144-1-kuhn.chenqun@huawei.com>
 <d5e369c6-b1c2-2b64-97a5-d9b2fc443842@redhat.com>
In-Reply-To: <d5e369c6-b1c2-2b64-97a5-d9b2fc443842@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.189
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Pannengyuan <pannengyuan@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIFttYWlsdG86cGhpbG1kQHJlZGhhdC5jb21dDQo+U2VudDogRnJpZGF5LCBKYW51YXJ5
IDEwLCAyMDIwIDk6MTQgUE0NCj5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3
ZWkuY29tPjsgcWVtdS0NCj5kZXZlbEBub25nbnUub3JnOyBrcmF4ZWxAcmVkaGF0LmNvbQ0KPkNj
OiBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsgUGFubmVuZ3l1YW4gPHBhbm5lbmd5dWFuQGh1YXdl
aS5jb20+Ow0KPlpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT4N
Cj5TdWJqZWN0OiBSZTogW1BBVENIXSB4aGNpOiBGaXggbWVtb3J5IGxlYWsgaW4geGhjaV9raWNr
X2VwY3R4IHdoZW4gcG93ZXJvZmYNCj5HdWVzdE9TDQo+DQo+T24gMS8xMC8yMCAxMTo1OCBBTSwg
a3Vobi5jaGVucXVuQGh1YXdlaS5jb20gd3JvdGU6DQo+PiBGcm9tOiBDaGVuIFF1biA8a3Vobi5j
aGVucXVuQGh1YXdlaS5jb20+DQo+Pg0KPj4gc3RhcnQgdm0gd2l0aCBsaWJ2aXJ0LCB3aGVuIEd1
ZXN0T1MgcnVubmluZywgZW50ZXIgcG93ZXJvZmYgY29tbWFuZA0KPj4gdXNpbmcgdGhlIHhoY2kg
a2V5Ym9hcmQsIHRoZW4gQVNBTiBzaG93cyBtZW1vcnkgbGVhayBzdGFja++8mg0KPj4NCj4+IERp
cmVjdCBsZWFrIG9mIDgwIGJ5dGUocykgaW4gNSBvYmplY3QocykgYWxsb2NhdGVkIGZyb206DQo+
PiAgICAgICMwIDB4ZmZmZDFlNjQzMWNiIGluIF9faW50ZXJjZXB0b3JfbWFsbG9jICgvbGliNjQv
bGliYXNhbi5zby40KzB4ZDMxY2IpDQo+PiAgICAgICMxIDB4ZmZmZDFlMTA3MTYzIGluIGdfbWFs
bG9jICgvbGliNjQvbGliZ2xpYi0yLjAuc28uMCsweDU3MTYzKQ0KPj4gICAgICAjMiAweGFhYWQz
OTA1MTM2NyBpbiBxZW11X3NnbGlzdF9pbml0IC9xZW11L2RtYS1oZWxwZXJzLmM6NDMNCj4+ICAg
ICAgIzMgMHhhYWFkMzk0N2M0MDcgaW4gcGNpX2RtYV9zZ2xpc3RfaW5pdA0KPi9xZW11L2luY2x1
ZGUvaHcvcGNpL3BjaS5oOjg0Mg0KPj4gICAgICAjNCAweGFhYWQzOTQ3YzQwNyBpbiB4aGNpX3hm
ZXJfY3JlYXRlX3NnbCAvcWVtdS9ody91c2IvaGNkLQ0KPnhoY2kuYzoxNDQ2DQo+PiAgICAgICM1
IDB4YWFhZDM5NDdjNDA3IGluIHhoY2lfc2V0dXBfcGFja2V0IC9xZW11L2h3L3VzYi9oY2QteGhj
aS5jOjE2MTgNCj4+ICAgICAgIzYgMHhhYWFkMzk0ODYyNWYgaW4geGhjaV9zdWJtaXQgL3FlbXUv
aHcvdXNiL2hjZC14aGNpLmM6MTgyNw0KPj4gICAgICAjNyAweGFhYWQzOTQ4NjI1ZiBpbiB4aGNp
X2ZpcmVfdHJhbnNmZXIgL3FlbXUvaHcvdXNiL2hjZC14aGNpLmM6MTgzOQ0KPj4gICAgICAjOCAw
eGFhYWQzOTQ4NjI1ZiBpbiB4aGNpX2tpY2tfZXBjdHggL3FlbXUvaHcvdXNiL2hjZC14aGNpLmM6
MTk5MQ0KPj4gICAgICAjOSAweGFhYWQzOTQ4ZjUzNyBpbiB4aGNpX2Rvb3JiZWxsX3dyaXRlIC9x
ZW11L2h3L3VzYi9oY2QtDQo+eGhjaS5jOjMxNTgNCj4+ICAgICAgIzEwIDB4YWFhZDM4YmNiZmM3
IGluIG1lbW9yeV9yZWdpb25fd3JpdGVfYWNjZXNzb3INCj4vcWVtdS9tZW1vcnkuYzo0ODMNCj4+
ICAgICAgIzExIDB4YWFhZDM4YmM2NTRmIGluIGFjY2Vzc193aXRoX2FkanVzdGVkX3NpemUgL3Fl
bXUvbWVtb3J5LmM6NTQ0DQo+PiAgICAgICMxMiAweGFhYWQzOGJkMTg3NyBpbiBtZW1vcnlfcmVn
aW9uX2Rpc3BhdGNoX3dyaXRlDQo+L3FlbXUvbWVtb3J5LmM6MTQ4Mg0KPj4gICAgICAjMTMgMHhh
YWFkMzhiMWM3N2YgaW4gZmxhdHZpZXdfd3JpdGVfY29udGludWUgL3FlbXUvZXhlYy5jOjMxNjcN
Cj4+ICAgICAgIzE0IDB4YWFhZDM4YjFjYTgzIGluIGZsYXR2aWV3X3dyaXRlIC9xZW11L2V4ZWMu
YzozMjA3DQo+PiAgICAgICMxNSAweGFhYWQzOGIyNjhkYiBpbiBhZGRyZXNzX3NwYWNlX3dyaXRl
IC9xZW11L2V4ZWMuYzozMjk3DQo+PiAgICAgICMxNiAweGFhYWQzOGJmOTA5YiBpbiBrdm1fY3B1
X2V4ZWMgL3FlbXUvYWNjZWwva3ZtL2t2bS1hbGwuYzoyMzgzDQo+PiAgICAgICMxNyAweGFhYWQz
OGJiMDYzZiBpbiBxZW11X2t2bV9jcHVfdGhyZWFkX2ZuIC9xZW11L2NwdXMuYzoxMjQ2DQo+PiAg
ICAgICMxOCAweGFhYWQzOTgyMWM5MyBpbiBxZW11X3RocmVhZF9zdGFydCAvcWVtdS91dGlsL3Fl
bXUtdGhyZWFkLQ0KPnBvc2l4LmM6NTE5DQo+PiAgICAgICMxOSAweGZmZmQxYzgzNzhiYiAgKC9s
aWI2NC9saWJwdGhyZWFkLnNvLjArMHg3OGJiKQ0KPj4gICAgICAjMjAgMHhmZmZkMWM3NzYxNmIg
ICgvbGliNjQvbGliYy5zby42KzB4ZDYxNmIpDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IEV1bGVyIFJv
Ym90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBRdW4g
PGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPj4gLS0tDQo+PiAgIGh3L3VzYi9oY2QteGhjaS5j
IHwgMSArDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9ody91c2IvaGNkLXhoY2kuYyBiL2h3L3VzYi9oY2QteGhjaS5jIGluZGV4DQo+PiA4
MDk4OGJiMzA1Li4wZDNkOTZkMDVhIDEwMDY0NA0KPj4gLS0tIGEvaHcvdXNiL2hjZC14aGNpLmMN
Cj4+ICsrKyBiL2h3L3VzYi9oY2QteGhjaS5jDQo+PiBAQCAtMjAwMCw2ICsyMDAwLDcgQEAgc3Rh
dGljIHZvaWQgeGhjaV9raWNrX2VwY3R4KFhIQ0lFUENvbnRleHQgKmVwY3R4LA0KPnVuc2lnbmVk
IGludCBzdHJlYW1pZCkNCj4+ICAgICAgICAgICBpZiAoeGZlciAhPSBOVUxMICYmIHhmZXItPnJ1
bm5pbmdfcmV0cnkpIHsNCj4+ICAgICAgICAgICAgICAgRFBSSU5URigieGhjaTogeGZlciBuYWNr
ZWQsIHN0b3BwaW5nIHNjaGVkdWxlXG4iKTsNCj4+ICAgICAgICAgICAgICAgZXBjdHgtPnJldHJ5
ID0geGZlcjsNCj4+ICsgICAgICAgICAgICB4aGNpX3hmZXJfdW5tYXAoeGZlcik7DQo+DQo+U2hv
dWxkbid0IHdlIHVzZSB4aGNpX2VwX2ZyZWVfeGZlcigpIGluc3RlYWQ/DQo+QWxzbywgaXQgd291
bGQgYmUgY2xlYW5lciBpZiB5b3Ugc2V0IGl0IHRvIE5VTEwuDQo+DQpIaSAgUGhpbGlwcGUsDQpU
aGFua3MgZm9yIHlvdXIgcmVwbHkhICANCkJ1dCwgIEl0ICBpcyBqdXN0IGEgc2dsaXN0IGxlYWsu
ICB4aGNpX3hmZXJfdW5tYXAoKSBjYW4gZnJlZSBhbmQgc2V0ICBpdCB0byBOVUxMLg0KVGhlICB4
aGNpX2VwX2ZyZWVfeGZlcigpIGRpZCd0IGZyZWUgYSBzZ2xpc3QuICANCg0KQnkgdGhlIHdheSwg
eGZlciBzaG91bGQgYmUgdXNlIGZvciBlcGN0eC0+cmV0cnksIHdlIGNhbid0IGZyZWUgaXQuDQoN
ClRoYW5rcy4NCj4+ICAgICAgICAgICAgICAgYnJlYWs7DQo+PiAgICAgICAgICAgfQ0KPj4gICAg
ICAgICAgIGlmIChjb3VudCsrID4gVFJBTlNGRVJfTElNSVQpIHsNCj4+DQoNCg==

