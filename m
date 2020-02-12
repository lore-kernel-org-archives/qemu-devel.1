Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6710C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FFB2073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FFB2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1loG-0002kd-Is
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j1llc-0000x4-Mo
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j1llb-0000hZ-Bw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:45:00 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2434 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j1lla-0000fR-Vv; Wed, 12 Feb 2020 01:44:59 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 0C3219168B9D294B0A53;
 Wed, 12 Feb 2020 14:44:53 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.201]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0439.000;
 Wed, 12 Feb 2020 14:44:46 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "i.mitsyanko@gmail.com"
 <i.mitsyanko@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
Thread-Topic: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
Thread-Index: AQHV4VWsc9vZRGjal0y1pX+CTm1jdKgWjwaAgACIWKA=
Date: Wed, 12 Feb 2020 06:44:46 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B1163F4@dggemm531-mbx.china.huawei.com>
References: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
 <ce5d39c0-d532-4b54-a39c-01c9c97cbb59@redhat.com>
In-Reply-To: <ce5d39c0-d532-4b54-a39c-01c9c97cbb59@redhat.com>
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgW21haWx0bzpwaGlsbWRAcmVkaGF0LmNvbV0NCj5TZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5
IDEyLCAyMDIwIDI6MTYgUE0NCj5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3
ZWkuY29tPjsgcWVtdS0NCj5kZXZlbEBub25nbnUub3JnOyBpLm1pdHN5YW5rb0BnbWFpbC5jb207
IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZw0KPkNjOiBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsg
WmhhbmdoYWlsaWFuZw0KPjx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+DQo+U3ViamVj
dDogUmU6IFtQQVRDSF0gaHcvY2hhci9leHlub3M0MjEwX3VhcnQ6IEZpeCBtZW1sZWFrcyBpbg0K
PmV4eW5vczQyMTBfdWFydF9pbml0DQo+DQo+T24gMi8xMi8yMCA0OjM2IEFNLCBrdWhuLmNoZW5x
dW5AaHVhd2VpLmNvbSB3cm90ZToNCj4+IEZyb206IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVh
d2VpLmNvbT4NCj4+DQo+PiBJdCdzIGVhc3kgdG8gcmVwcm9kdWNlIGFzIGZvbGxvdzoNCj4+IHZp
cnNoIHFlbXUtbW9uaXRvci1jb21tYW5kIHZtMSAtLXByZXR0eSAneyJleGVjdXRlIjoNCj4+ICJk
ZXZpY2UtbGlzdC1wcm9wZXJ0aWVzIiwgImFyZ3VtZW50cyI6eyJ0eXBlbmFtZSI6ImV4eW5vczQy
MTAudWFydCJ9fScNCj4+DQo+PiBBU0FOIHNob3dzIG1lbW9yeSBsZWFrIHN0YWNrOg0KPj4gICAg
IzEgMHhmZmZkODk2ZDcxY2IgaW4gZ19tYWxsb2MwICgvbGliNjQvbGliZ2xpYi0yLjAuc28uMCsw
eDU3MWNiKQ0KPj4gICAgIzIgMHhhYWFkMjcwYmVlZTMgaW4gdGltZXJfbmV3X2Z1bGwgL3FlbXUv
aW5jbHVkZS9xZW11L3RpbWVyLmg6NTMwDQo+PiAgICAjMyAweGFhYWQyNzBiZWVlMyBpbiB0aW1l
cl9uZXcgL3FlbXUvaW5jbHVkZS9xZW11L3RpbWVyLmg6NTUxDQo+PiAgICAjNCAweGFhYWQyNzBi
ZWVlMyBpbiB0aW1lcl9uZXdfbnMgL3FlbXUvaW5jbHVkZS9xZW11L3RpbWVyLmg6NTY5DQo+PiAg
ICAjNSAweGFhYWQyNzBiZWVlMyBpbiBleHlub3M0MjEwX3VhcnRfaW5pdA0KPi9xZW11L2h3L2No
YXIvZXh5bm9zNDIxMF91YXJ0LmM6Njc3DQo+PiAgICAjNiAweGFhYWQyNzVjOGY0ZiBpbiBvYmpl
Y3RfaW5pdGlhbGl6ZV93aXRoX3R5cGUgL3FlbXUvcW9tL29iamVjdC5jOjUxNg0KPj4gICAgIzcg
MHhhYWFkMjc1YzkxYmIgaW4gb2JqZWN0X25ld193aXRoX3R5cGUgL3FlbXUvcW9tL29iamVjdC5j
OjY4NA0KPj4gICAgIzggMHhhYWFkMjc1NWRmMmYgaW4gcW1wX2RldmljZV9saXN0X3Byb3BlcnRp
ZXMNCj4+IC9xZW11L3FvbS9xb20tcW1wLWNtZHMuYzoxNTINCj4+DQo+PiBSZXBvcnRlZC1ieTog
RXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBD
aGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+PiAtLS0NCj4+ICAgaHcvY2hhci9l
eHlub3M0MjEwX3VhcnQuYyB8IDggKysrKy0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvY2hhci9l
eHlub3M0MjEwX3VhcnQuYyBiL2h3L2NoYXIvZXh5bm9zNDIxMF91YXJ0LmMNCj4+IGluZGV4IDI1
ZDY1ODhlNDEuLjUwNDhkYjU0MTAgMTAwNjQ0DQo+PiAtLS0gYS9ody9jaGFyL2V4eW5vczQyMTBf
dWFydC5jDQo+PiArKysgYi9ody9jaGFyL2V4eW5vczQyMTBfdWFydC5jDQo+PiBAQCAtNjc0LDEw
ICs2NzQsNiBAQCBzdGF0aWMgdm9pZCBleHlub3M0MjEwX3VhcnRfaW5pdChPYmplY3QgKm9iaikN
Cj4+ICAgICAgIFN5c0J1c0RldmljZSAqZGV2ID0gU1lTX0JVU19ERVZJQ0Uob2JqKTsNCj4+ICAg
ICAgIEV4eW5vczQyMTBVYXJ0U3RhdGUgKnMgPSBFWFlOT1M0MjEwX1VBUlQoZGV2KTsNCj4+DQo+
PiAtICAgIHMtPmZpZm9fdGltZW91dF90aW1lciA9IHRpbWVyX25ld19ucyhRRU1VX0NMT0NLX1ZJ
UlRVQUwsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBleHlu
b3M0MjEwX3VhcnRfdGltZW91dF9pbnQsIHMpOw0KPj4gLSAgICBzLT53b3JkdGltZSA9IE5BTk9T
RUNPTkRTX1BFUl9TRUNPTkQgKiAxMCAvIDk2MDA7DQo+DQo+V2h5IGFyZSB5b3UgbW92aW5nIHMt
PndvcmR0aW1lIGZyb20gaW5pdCgpIHRvIHJlYWxpemUoKT8NCj4NCkhpICBQaGlsaXBwZSwgIHRo
YW5rcyBmb3IgeW91ciByZXBseSENCg0KQmVjYXVzZSBJIGZvdW5kIHRoZSB2YXJpYWJsZSB3b3Jk
dGltZSBpcyB1c3VhbGx5IHVzZWQgd2l0aCBmaWZvX3RpbWVvdXRfdGltZXIuICAgDQpFZywgdGhl
eSBhcmUgdXNlZCB0b2dldGhlciBpbiB0aGUgZXh5bm9zNDIxMF91YXJ0X3J4X3RpbWVvdXRfc2V0
IGZ1bmN0aW9uLg0KDQpJIGRpZG4ndCBmaW5kIGFueXRoaW5nIHdyb25nIHdpdGggd29yZHRpbWUg
aW4gdGhlIHJlYWxpemUoKS4gIA0KRG9lcyBpdCBoYXZlIGFueSBvdGhlciBlZmZlY3RzPw0KDQpU
aGFua3MuDQo+PiAtDQo+PiAgICAgICAvKiBtZW1vcnkgbWFwcGluZyAqLw0KPj4gICAgICAgbWVt
b3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5pb21lbSwgb2JqLCAmZXh5bm9zNDIxMF91YXJ0X29wcywg
cywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZXh5bm9zNDIxMC51YXJ0IiwNCj4+
IEVYWU5PUzQyMTBfVUFSVF9SRUdTX01FTV9TSVpFKTsgQEAgLTY5MSw2ICs2ODcsMTAgQEAgc3Rh
dGljIHZvaWQNCj5leHlub3M0MjEwX3VhcnRfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJv
ciAqKmVycnApDQo+PiAgIHsNCj4+ICAgICAgIEV4eW5vczQyMTBVYXJ0U3RhdGUgKnMgPSBFWFlO
T1M0MjEwX1VBUlQoZGV2KTsNCj4+DQo+PiArICAgIHMtPmZpZm9fdGltZW91dF90aW1lciA9IHRp
bWVyX25ld19ucyhRRU1VX0NMT0NLX1ZJUlRVQUwsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBleHlub3M0MjEwX3VhcnRfdGltZW91dF9pbnQsIHMpOw0KPj4g
KyAgICBzLT53b3JkdGltZSA9IE5BTk9TRUNPTkRTX1BFUl9TRUNPTkQgKiAxMCAvIDk2MDA7DQo+
PiArDQo+PiAgICAgICBxZW11X2Nocl9mZV9zZXRfaGFuZGxlcnMoJnMtPmNociwgZXh5bm9zNDIx
MF91YXJ0X2Nhbl9yZWNlaXZlLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4
eW5vczQyMTBfdWFydF9yZWNlaXZlLCBleHlub3M0MjEwX3VhcnRfZXZlbnQsDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgcywgTlVMTCwgdHJ1ZSk7DQo+Pg0KDQo=

