Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA9CC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB69206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB69206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23yu-0002sv-Se
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 21:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j23xO-0000uV-Do
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j23xN-0000oa-2b
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:10:22 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2436 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j23xM-0000l9-NL; Wed, 12 Feb 2020 21:10:21 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 7BD41A594BC1037DAB50;
 Thu, 13 Feb 2020 10:10:17 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 13 Feb 2020 10:10:16 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.201]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0439.000;
 Thu, 13 Feb 2020 10:10:10 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: RE: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
Thread-Topic: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
Thread-Index: AQHV4VWsc9vZRGjal0y1pX+CTm1jdKgWjwaAgACIWKD//48WgIAAkUyAgAEnmAA=
Date: Thu, 13 Feb 2020 02:10:09 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B116A87@dggemm531-mbx.china.huawei.com>
References: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
 <ce5d39c0-d532-4b54-a39c-01c9c97cbb59@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B1163F4@dggemm531-mbx.china.huawei.com>
 <99531e05-f8fc-ef0a-ca62-6d477c899e78@redhat.com>
 <20200212161957.GA5028@habkost.net>
In-Reply-To: <20200212161957.GA5028@habkost.net>
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
X-Received-From: 45.249.212.187
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "i.mitsyanko@gmail.com" <i.mitsyanko@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRWR1YXJkbyBIYWJrb3N0IFttYWls
dG86ZWhhYmtvc3RAcmVkaGF0LmNvbV0NCj5TZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTMsIDIw
MjAgMTI6MjAgQU0NCj5UbzogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQu
Y29tPg0KPkNjOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+OyBxZW11
LQ0KPmRldmVsQG5vbmdudS5vcmc7IGkubWl0c3lhbmtvQGdtYWlsLmNvbTsgcGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnOw0KPnFlbXUtdHJpdmlhbEBub25nbnUub3JnOyBaaGFuZ2hhaWxpYW5nDQo+
PHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IE1hcmt1cyBBcm1icnVzdGVyDQo+PGFy
bWJydUByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh3L2NoYXIvZXh5bm9zNDIx
MF91YXJ0OiBGaXggbWVtbGVha3MgaW4NCj5leHlub3M0MjEwX3VhcnRfaW5pdA0KPg0KPk9uIFdl
ZCwgRmViIDEyLCAyMDIwIGF0IDA4OjM5OjU1QU0gKzAxMDAsIFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIHdyb3RlOg0KPj4gQ2MnaW5nIEVkdWFyZG8gJiBNYXJrdXMuDQo+Pg0KPj4gT24gMi8xMi8y
MCA3OjQ0IEFNLCBDaGVucXVuIChrdWhuKSB3cm90ZToNCj4+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPj4gPiA+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIFttYWlsdG86
cGhpbG1kQHJlZGhhdC5jb21dDQo+PiA+ID4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxMiwg
MjAyMCAyOjE2IFBNDQo+PiA+ID4gVG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVh
d2VpLmNvbT47IHFlbXUtDQo+PiA+ID4gZGV2ZWxAbm9uZ251Lm9yZzsgaS5taXRzeWFua29AZ21h
aWwuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcNCj4+ID4gPiBDYzogcWVtdS10cml2aWFs
QG5vbmdudS5vcmc7IFpoYW5naGFpbGlhbmcNCj4+ID4gPiA8emhhbmcuemhhbmdoYWlsaWFuZ0Bo
dWF3ZWkuY29tPg0KPj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh3L2NoYXIvZXh5bm9zNDIx
MF91YXJ0OiBGaXggbWVtbGVha3MgaW4NCj4+ID4gPiBleHlub3M0MjEwX3VhcnRfaW5pdA0KPj4g
PiA+DQo+PiA+ID4gT24gMi8xMi8yMCA0OjM2IEFNLCBrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbSB3
cm90ZToNCj4+ID4gPiA+IEZyb206IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4N
Cj4+ID4gPiA+DQo+PiA+ID4gPiBJdCdzIGVhc3kgdG8gcmVwcm9kdWNlIGFzIGZvbGxvdzoNCj4+
ID4gPiA+IHZpcnNoIHFlbXUtbW9uaXRvci1jb21tYW5kIHZtMSAtLXByZXR0eSAneyJleGVjdXRl
IjoNCj4+ID4gPiA+ICJkZXZpY2UtbGlzdC1wcm9wZXJ0aWVzIiwNCj4iYXJndW1lbnRzIjp7InR5
cGVuYW1lIjoiZXh5bm9zNDIxMC51YXJ0In19Jw0KPj4gPiA+ID4NCj4+ID4gPiA+IEFTQU4gc2hv
d3MgbWVtb3J5IGxlYWsgc3RhY2s6DQo+PiA+ID4gPiAgICAgIzEgMHhmZmZkODk2ZDcxY2IgaW4g
Z19tYWxsb2MwICgvbGliNjQvbGliZ2xpYi0yLjAuc28uMCsweDU3MWNiKQ0KPj4gPiA+ID4gICAg
ICMyIDB4YWFhZDI3MGJlZWUzIGluIHRpbWVyX25ld19mdWxsDQo+L3FlbXUvaW5jbHVkZS9xZW11
L3RpbWVyLmg6NTMwDQo+PiA+ID4gPiAgICAgIzMgMHhhYWFkMjcwYmVlZTMgaW4gdGltZXJfbmV3
IC9xZW11L2luY2x1ZGUvcWVtdS90aW1lci5oOjU1MQ0KPj4gPiA+ID4gICAgICM0IDB4YWFhZDI3
MGJlZWUzIGluIHRpbWVyX25ld19ucw0KPi9xZW11L2luY2x1ZGUvcWVtdS90aW1lci5oOjU2OQ0K
Pj4gPiA+ID4gICAgICM1IDB4YWFhZDI3MGJlZWUzIGluIGV4eW5vczQyMTBfdWFydF9pbml0DQo+
PiA+ID4gL3FlbXUvaHcvY2hhci9leHlub3M0MjEwX3VhcnQuYzo2NzcNCj4+ID4gPiA+ICAgICAj
NiAweGFhYWQyNzVjOGY0ZiBpbiBvYmplY3RfaW5pdGlhbGl6ZV93aXRoX3R5cGUNCj4vcWVtdS9x
b20vb2JqZWN0LmM6NTE2DQo+PiA+ID4gPiAgICAgIzcgMHhhYWFkMjc1YzkxYmIgaW4gb2JqZWN0
X25ld193aXRoX3R5cGUNCj4vcWVtdS9xb20vb2JqZWN0LmM6Njg0DQo+PiA+ID4gPiAgICAgIzgg
MHhhYWFkMjc1NWRmMmYgaW4gcW1wX2RldmljZV9saXN0X3Byb3BlcnRpZXMNCj4+ID4gPiA+IC9x
ZW11L3FvbS9xb20tcW1wLWNtZHMuYzoxNTINCj4+ID4gPiA+DQo+PiA+ID4gPiBSZXBvcnRlZC1i
eTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+PiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+PiA+ID4gPiAtLS0N
Cj4+ID4gPiA+ICAgIGh3L2NoYXIvZXh5bm9zNDIxMF91YXJ0LmMgfCA4ICsrKystLS0tDQo+PiA+
ID4gPiAgICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
Pj4gPiA+ID4NCj4+ID4gPiA+IGRpZmYgLS1naXQgYS9ody9jaGFyL2V4eW5vczQyMTBfdWFydC5j
DQo+PiA+ID4gPiBiL2h3L2NoYXIvZXh5bm9zNDIxMF91YXJ0LmMgaW5kZXggMjVkNjU4OGU0MS4u
NTA0OGRiNTQxMCAxMDA2NDQNCj4+ID4gPiA+IC0tLSBhL2h3L2NoYXIvZXh5bm9zNDIxMF91YXJ0
LmMNCj4+ID4gPiA+ICsrKyBiL2h3L2NoYXIvZXh5bm9zNDIxMF91YXJ0LmMNCj4+ID4gPiA+IEBA
IC02NzQsMTAgKzY3NCw2IEBAIHN0YXRpYyB2b2lkIGV4eW5vczQyMTBfdWFydF9pbml0KE9iamVj
dCAqb2JqKQ0KPj4gPiA+ID4gICAgICAgIFN5c0J1c0RldmljZSAqZGV2ID0gU1lTX0JVU19ERVZJ
Q0Uob2JqKTsNCj4+ID4gPiA+ICAgICAgICBFeHlub3M0MjEwVWFydFN0YXRlICpzID0gRVhZTk9T
NDIxMF9VQVJUKGRldik7DQo+PiA+ID4gPg0KPj4gPiA+ID4gLSAgICBzLT5maWZvX3RpbWVvdXRf
dGltZXIgPSB0aW1lcl9uZXdfbnMoUUVNVV9DTE9DS19WSVJUVUFMLA0KPj4gPiA+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXh5bm9zNDIxMF91YXJ0X3RpbWVv
dXRfaW50LCBzKTsNCj4+ID4gPiA+IC0gICAgcy0+d29yZHRpbWUgPSBOQU5PU0VDT05EU19QRVJf
U0VDT05EICogMTAgLyA5NjAwOw0KPj4gPiA+DQo+PiA+ID4gV2h5IGFyZSB5b3UgbW92aW5nIHMt
PndvcmR0aW1lIGZyb20gaW5pdCgpIHRvIHJlYWxpemUoKT8NCj4+ID4gPg0KPj4gPiBIaSAgUGhp
bGlwcGUsICB0aGFua3MgZm9yIHlvdXIgcmVwbHkhDQo+PiA+DQo+PiA+IEJlY2F1c2UgSSBmb3Vu
ZCB0aGUgdmFyaWFibGUgd29yZHRpbWUgaXMgdXN1YWxseSB1c2VkIHdpdGgNCj5maWZvX3RpbWVv
dXRfdGltZXIuDQo+PiA+IEVnLCB0aGV5IGFyZSB1c2VkIHRvZ2V0aGVyIGluIHRoZSBleHlub3M0
MjEwX3VhcnRfcnhfdGltZW91dF9zZXQNCj5mdW5jdGlvbi4NCj4+ID4NCj4+ID4gSSBkaWRuJ3Qg
ZmluZCBhbnl0aGluZyB3cm9uZyB3aXRoIHdvcmR0aW1lIGluIHRoZSByZWFsaXplKCkuDQo+PiA+
IERvZXMgaXQgaGF2ZSBhbnkgb3RoZXIgZWZmZWN0cz8NCj4+DQo+PiBJSVVDIHdoZW4gd2UgdXNl
IGJvdGggaW5pdCgpIGFuZCByZWFsaXplKCksIHJlYWxpemUoKSBzaG91bGQgb25seQ0KPj4gY29u
dGFpbnMgb24gY29kZSB0aGF0IGNvbnN1bWVzIHRoZSBvYmplY3QgcHJvcGVydGllcy4uLiBCdXQg
bWF5YmUgdGhlDQo+PiBkZXNpZ24gaXMgbm90IGNsZWFyLiBUaGVuIHdoeSBub3QgbW92ZSBhbGwg
dGhlIGluaXQoKSBjb2RlIHRvIHJlYWxpemUoKT8NCj4NCj5Ob3JtYWxseSBJIHdvdWxkIHJlY29t
bWVuZCB0aGUgb3Bwb3NpdGU6IGRlbGF5IGFzIG11Y2ggYXMgcG9zc2libGUgdG8NCj5yZWFsaXpl
KCksIHRvIGF2b2lkIHVud2FudGVkIHNpZGUgZWZmZWN0cyB3aGVuIChlLmcuKSBydW5uaW5nIHFv
bS1saXN0LQ0KPnByb3BlcnRpZXMuDQo+DQo+QnV0IGFzIHMtPndvcmR0aW1lIGlzIGEgc2ltcGxl
IHN0cnVjdCBmaWVsZCAodGhhdCB3ZSBjb3VsZCBldmVuIGRlY2lkZSB0bw0KPmV4cG9zZSB0byB0
aGUgb3V0c2lkZSBhcyBhIHJlYWQtb25seSBRT00gcHJvcGVydHkpLCBpdCBkb2Vzbid0IHJlYWxs
eSBtYXR0ZXIuDQo+UGVyc29uYWxseSwgSSB3b3VsZCBrZWVwIGl0IHdoZXJlIGl0IGlzIGp1c3Qg
dG8gYXZvaWQgY2h1cm4uDQo+DQpPSywgIExldCdzIGtlZXAgcy0+d29yZHRpbWUgIGluIGluaXQo
KS4gDQpJIHdpbGwgY2hhbmdlIGl0IGluIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLg0KPi0tDQo+
RWR1YXJkbw0KDQo=

