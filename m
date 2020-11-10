Return-Path: <SRS0=ixoB=EQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365B5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2020 01:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCA3206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2020 01:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCA3206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcI7b-0005x2-IM
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 20:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kcI6E-00056M-Ci; Mon, 09 Nov 2020 20:05:30 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kcI6A-0006Dc-VE; Mon, 09 Nov 2020 20:05:29 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CVV5Q13dsz50bF;
 Tue, 10 Nov 2020 09:04:58 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 10 Nov 2020 09:05:05 +0800
Received: from DGGEMM511-MBS.china.huawei.com ([169.254.2.226]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0487.000;
 Tue, 10 Nov 2020 09:04:58 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH] hw/intc: fix heap-buffer-overflow in rxicu_realize()
Thread-Topic: [PATCH] hw/intc: fix heap-buffer-overflow in rxicu_realize()
Thread-Index: AQHWs0I9MjF5nCKDLkWY9Hw35VFGIqnAkhaQ
Date: Tue, 10 Nov 2020 01:04:57 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA52F71@dggemm511-mbs.china.huawei.com>
References: <20201105070626.2277696-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20201105070626.2277696-1-kuhn.chenqun@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga02-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 20:05:08
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, ganqixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZywNCg0KRml4OiBlNzg1OTdjYzQ1N2ZmNzYxMSANCk1heWJlIHRoaXMgYnVnIG5lZWRzIHRv
IHFlbXUtNS4yIHZlcnNpb24uDQoNClRoZSAiaWN1LT5ucl9zZW5zZSIgaXMgYXJyYXkgbGVuZ3Ro
LiAgSXQncyBhIHR5cGljYWwgb3V0LW9mLWJvdW5kcyBhcnJheSBidWcuDQoNCg0KVGhhbmtzLA0K
Q2hlbiBRdW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVucXVu
IChrdWhuKQ0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNSwgMjAyMCAzOjA2IFBNDQo+IFRv
OiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUub3JnDQo+IENjOiBa
aGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBnYW5xaXhpbg0K
PiA8Z2FucWl4aW5AaHVhd2VpLmNvbT47IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVh
d2VpLmNvbT47DQo+IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPjsgWW9zaGlu
b3JpIFNhdG8NCj4gPHlzYXRvQHVzZXJzLnNvdXJjZWZvcmdlLmpwPg0KPiBTdWJqZWN0OiBbUEFU
Q0hdIGh3L2ludGM6IGZpeCBoZWFwLWJ1ZmZlci1vdmVyZmxvdyBpbiByeGljdV9yZWFsaXplKCkN
Cj4gDQo+IFdoZW4gJ2ogPSBpY3UtPm5yX3NlbnNlIOKAkyAxJywgdGhlICdqIDwgaWN1LT5ucl9z
ZW5zZScgY29uZGl0aW9uIGlzIHRydWUsIHRoZW4gJ2ogPQ0KPiBpY3UtPm5yX3NlbnNlJywgdGhl
J2ljdS0+aW5pdF9zZW5zZVtqXScgaGFzIG91dC1vZi1ib3VuZHMgYWNjZXNzLg0KPiBNYXliZSB0
aGlzIGNvdWxkIGxlYWQgdG8gc29tZSBzZWN1cml0eSBwcm9ibGVtcy4NCj4gDQo+IFRoZSBhc2Fu
IHNob3dlZCBzdGFjazoNCj4gRVJST1I6IEFkZHJlc3NTYW5pdGl6ZXI6IGhlYXAtYnVmZmVyLW92
ZXJmbG93IG9uIGFkZHJlc3MgMHg2MDQwMDAwMDRkN2QgYXQNCj4gcGMgMHg1NTg1MmNkMjZhNzYg
YnAgMHg3ZmZlMzlmMjYyMDAgc3AgMHg3ZmZlMzlmMjYxZjAgUkVBRCBvZiBzaXplIDEgYXQNCj4g
MHg2MDQwMDAwMDRkN2QgdGhyZWFkIFQwDQo+ICAgICAjMCAweDU1ODUyY2QyNmE3NSBpbiByeGlj
dV9yZWFsaXplIC4uL2h3L2ludGMvcnhfaWN1LmM6MzExDQo+ICAgICAjMSAweDU1ODUyY2YwNzVm
NyBpbiBkZXZpY2Vfc2V0X3JlYWxpemVkIC4uL2h3L2NvcmUvcWRldi5jOjg4Ng0KPiAgICAgIzIg
MHg1NTg1MmNkNGEzMmYgaW4gcHJvcGVydHlfc2V0X2Jvb2wgLi4vcW9tL29iamVjdC5jOjIyNTEN
Cj4gICAgICMzIDB4NTU4NTJjZDRmOWJiIGluIG9iamVjdF9wcm9wZXJ0eV9zZXQgLi4vcW9tL29i
amVjdC5jOjEzOTgNCj4gICAgICM0IDB4NTU4NTJjZDU0ZjNmIGluDQo+IG9iamVjdF9wcm9wZXJ0
eV9zZXRfcW9iamVjdCAuLi9xb20vcW9tLXFvYmplY3QuYzoyOA0KPiAgICAgIzUgMHg1NTg1MmNk
NGZjM2YgaW4gb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sIC4uL3FvbS9vYmplY3QuYzoxNDY1DQo+
ICAgICAjNiAweDU1ODUyY2JmMGIyNyBpbiByZWdpc3Rlcl9pY3UgLi4vaHcvcngvcng2Mm4uYzox
NTYNCj4gICAgICM3IDB4NTU4NTJjYmYxMmE2IGluIHJ4NjJuX3JlYWxpemUgLi4vaHcvcngvcng2
Mm4uYzoyNjENCj4gICAgICM4IDB4NTU4NTJjZjA3NWY3IGluIGRldmljZV9zZXRfcmVhbGl6ZWQg
Li4vaHcvY29yZS9xZGV2LmM6ODg2DQo+ICAgICAjOSAweDU1ODUyY2Q0YTMyZiBpbiBwcm9wZXJ0
eV9zZXRfYm9vbCAuLi9xb20vb2JqZWN0LmM6MjI1MQ0KPiAgICAgIzEwIDB4NTU4NTJjZDRmOWJi
IGluIG9iamVjdF9wcm9wZXJ0eV9zZXQgLi4vcW9tL29iamVjdC5jOjEzOTgNCj4gICAgICMxMSAw
eDU1ODUyY2Q1NGYzZiBpbg0KPiBvYmplY3RfcHJvcGVydHlfc2V0X3FvYmplY3QgLi4vcW9tL3Fv
bS1xb2JqZWN0LmM6MjgNCj4gICAgICMxMiAweDU1ODUyY2Q0ZmMzZiBpbiBvYmplY3RfcHJvcGVy
dHlfc2V0X2Jvb2wgLi4vcW9tL29iamVjdC5jOjE0NjUNCj4gICAgICMxMyAweDU1ODUyY2JmMWE4
NSBpbiByeF9nZGJzaW1faW5pdCAuLi9ody9yeC9yeC1nZGJzaW0uYzoxMDkNCj4gICAgICMxNCAw
eDU1ODUyY2QyMmRlMCBpbiBxZW11X2luaXQgLi4vc29mdG1tdS92bC5jOjQzODANCj4gICAgICMx
NSAweDU1ODUyY2E1NzA4OCBpbiBtYWluIC4uL3NvZnRtbXUvbWFpbi5jOjQ5DQo+ICAgICAjMTYg
MHg3ZmVlZmFmYTVkNDIgaW4gX19saWJjX3N0YXJ0X21haW4gKC9saWI2NC9saWJjLnNvLjYrMHgy
NmQ0MikNCj4gDQo+IENoYW5nZSB0aGUgJ2ogPCBpY3UtPm5yX3NlbnNlJyBjb25kaXRpb24gcGxh
Y2UgdG8gZml4IGl0Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IEV1bGVyIFJvYm90IDxldWxlci5yb2Jv
dEBodWF3ZWkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1
YXdlaS5jb20+DQo+IC0tLQ0KPiBDYzogWW9zaGlub3JpIFNhdG8gPHlzYXRvQHVzZXJzLnNvdXJj
ZWZvcmdlLmpwPg0KPiAtLS0NCj4gIGh3L2ludGMvcnhfaWN1LmMgfCA2ICsrLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9ody9pbnRjL3J4X2ljdS5jIGIvaHcvaW50Yy9yeF9pY3UuYyBpbmRleCA5NGUxN2E5
ZGVhLi42OTJhNGM3OGUwDQo+IDEwMDY0NA0KPiAtLS0gYS9ody9pbnRjL3J4X2ljdS5jDQo+ICsr
KyBiL2h3L2ludGMvcnhfaWN1LmMNCj4gQEAgLTMwOCwxMSArMzA4LDkgQEAgc3RhdGljIHZvaWQg
cnhpY3VfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvcg0KPiAqKmVycnApDQo+ICAgICAg
ICAgIHJldHVybjsNCj4gICAgICB9DQo+ICAgICAgZm9yIChpID0gaiA9IDA7IGkgPCBOUl9JUlFT
OyBpKyspIHsNCj4gLSAgICAgICAgaWYgKGljdS0+aW5pdF9zZW5zZVtqXSA9PSBpKSB7DQo+ICsg
ICAgICAgIGlmIChqIDwgaWN1LT5ucl9zZW5zZSAmJiBpY3UtPmluaXRfc2Vuc2Vbal0gPT0gaSkg
ew0KPiAgICAgICAgICAgICAgaWN1LT5zcmNbaV0uc2Vuc2UgPSBUUkdfTEVWRUw7DQo+IC0gICAg
ICAgICAgICBpZiAoaiA8IGljdS0+bnJfc2Vuc2UpIHsNCj4gLSAgICAgICAgICAgICAgICBqKys7
DQo+IC0gICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICBqKys7DQo+ICAgICAgICAgIH0gZWxz
ZSB7DQo+ICAgICAgICAgICAgICBpY3UtPnNyY1tpXS5zZW5zZSA9IFRSR19QRURHRTsNCj4gICAg
ICAgICAgfQ0KPiAtLQ0KPiAyLjI3LjANCg0K

