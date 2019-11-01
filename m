Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A84ACA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EDA32054F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDA32054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTMe-0004PS-9x
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 05:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1iQTKb-0002qf-Am
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1iQTKY-0005GF-SQ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 05:34:57 -0400
Received: from smtp.h3c.com ([60.191.123.56]:1855 helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1iQTKT-0004P7-F0; Fri, 01 Nov 2019 05:34:49 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
 by h3cspam01-ex.h3c.com with ESMTPS id xA19YUcv054243
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Nov 2019 17:34:30 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 1 Nov 2019 17:34:33 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Fri, 1 Nov 2019 17:34:33 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: RE: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWQhrb0bffMwMc6ShSREntjykPuIgADxL+AAAAaQEA=
Date: Fri, 1 Nov 2019 09:34:33 +0000
Message-ID: <7650a7b706d24774b4ea3af23a2b371f@h3c.com>
References: <4ba40cd1e7ee4a708b40899952e49f22@h3c.com>
 <8b7d3d50-4a29-a8b3-5b6c-cde4af1b1d7a@virtuozzo.com>
In-Reply-To: <8b7d3d50-4a29-a8b3-5b6c-cde4af1b1d7a@virtuozzo.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.112]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com xA19YUcv054243
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.56
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMDEuMTEuMjAxOSAxNzoyNSBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0K
PiAwMS4xMS4yMDE5IDEwOjM3LCBUdWd1b3lpIHdyb3RlOg0KPiA+IFRoZXJlIGFyZSB0d28gaXNz
dWVzIGluIEluIGNoZWNrX2NvbnN0cmFpbnRzX29uX2JpdG1hcCgpLA0KPiA+IDEpIFRoZSBzYW5p
dHkgY2hlY2sgb24gdGhlIGdyYW51bGFyaXR5IHdpbGwgY2F1c2UgdWludDY0X3QgaW50ZWdlcg0K
PiA+IGxlZnQtc2hpZnQgb3ZlcmZsb3cgd2hlbiBjbHVzdGVyX3NpemUgaXMgMk0gYW5kIHRoZSBn
cmFudWxhcml0eSBpcw0KPiA+IEJJR0dFUiB0aGFuIDMySy4NCj4gPiAyKSBUaGUgd2F5IHRvIGNh
bGN1bGF0ZSBpbWFnZSBzaXplIHRoYXQgdGhlIG1heGltdW0gYml0bWFwIHN1cHBvcnRlZA0KPiA+
IGNhbiBtYXAgdG8gaXMgYSBiaXQgaW5jb3JyZWN0Lg0KPiA+IFRoaXMgcGF0Y2ggZml4IGl0IGJ5
IGFkZCBhIGhlbHBlciBmdW5jdGlvbiB0byBjYWxjdWxhdGUgdGhlIG51bWJlciBvZg0KPiA+IGJ5
dGVzIG5lZWRlZCBieSBhIG5vcm1hbCBiaXRtYXAgaW4gaW1hZ2UgYW5kIGNvbXBhcmUgaXQgdG8g
dGhlIG1heGltdW0NCj4gPiBiaXRtYXAgYnl0ZXMgc3VwcG9ydGVkIGJ5IHFlbXUuDQo+ID4NCj4g
PiBGaXhlczogNWY3MjgyNmU3ZmM2MjE2N2NmM2ENCj4gPiBTaWduZWQtb2ZmLWJ5OiBHdW95aSBU
dSA8dHUuZ3VveWlAaDNjLmNvbT4NCj4gDQo+IFlvdSBmb3JnZXQgbXkNCj4gUmV2aWV3ZWQtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
Cg0KU29ycnkgZm9yIHRoYXQsIGl0J3MgbXkgZmlyc3QgdGltZSB0byBzdWJtaXQgcGF0Y2ggdG8g
cWVtdSwgYW5kIHNob3VsZCBJIHNlbmQgYW5vdGhlciBwYXRjaCBvciBub3QgPw0KDQo+IChJIGRv
bid0IHNlZSBjaGFuZ2VzIGV4Y2VwdCBhZGQgIkZpeGVzOiAiIHRvIGNvbW1pdCBtc2cgYW5kIHB1
dA0KPiBnZXRfYml0bWFwX2J5dGVzX25lZWRlZCBkZWZpbml0aW9uIGhlYWRlciBpbnRvIG9uZSBs
aW5lLikNCg0KWWVzLCBPbmx5IG1pbm9yIGNoYW5nZXMgYXJlIG1hZGUsIGluY2x1ZGluZyByZW1v
dmluZyAnaW5saW5lJyBrZXl3b3JkLg0KDQpUaGFua3MgZm9yIHlvdXIgcGF0aWVuY2UgaW4gcmV2
aWV3aW5nDQoNCj4gPiAtLS0NCj4gPiAgIGJsb2NrL3Fjb3cyLWJpdG1hcC5jIHwgMTQgKysrKysr
KysrKystLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jIGIvYmxv
Y2svcWNvdzItYml0bWFwLmMgaW5kZXgNCj4gPiA5ODI5NGE3Li5lZjllZjYyIDEwMDY0NA0KPiA+
IC0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+ID4gKysrIGIvYmxvY2svcWNvdzItYml0bWFw
LmMNCj4gPiBAQCAtMTQyLDYgKzE0MiwxMyBAQCBzdGF0aWMgaW50IGNoZWNrX3RhYmxlX2VudHJ5
KHVpbnQ2NF90IGVudHJ5LCBpbnQNCj4gY2x1c3Rlcl9zaXplKQ0KPiA+ICAgICAgIHJldHVybiAw
Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQ2NF90IGdldF9iaXRtYXBfYnl0ZXNfbmVl
ZGVkKGludDY0X3QgbGVuLCB1aW50MzJfdA0KPiA+ICtncmFudWxhcml0eSkgew0KPiA+ICsgICAg
aW50NjRfdCBudW1fYml0cyA9IERJVl9ST1VORF9VUChsZW4sIGdyYW51bGFyaXR5KTsNCj4gPiAr
DQo+ID4gKyAgICByZXR1cm4gRElWX1JPVU5EX1VQKG51bV9iaXRzLCA4KTsgfQ0KPiA+ICsNCj4g
PiAgIHN0YXRpYyBpbnQgY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKEJsb2NrRHJpdmVyU3Rh
dGUgKmJzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3QgY2hhciAqbmFtZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQzMl90IGdyYW51bGFyaXR5LCBAQA0KPiA+IC0xNTAsNiArMTU3LDcgQEAgc3RhdGlj
IGludCBjaGVja19jb25zdHJhaW50c19vbl9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZQ0KPiAqYnMs
DQo+ID4gICAgICAgQkRSVlFjb3cyU3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KPiA+ICAgICAgIGlu
dCBncmFudWxhcml0eV9iaXRzID0gY3R6MzIoZ3JhbnVsYXJpdHkpOw0KPiA+ICAgICAgIGludDY0
X3QgbGVuID0gYmRydl9nZXRsZW5ndGgoYnMpOw0KPiA+ICsgICAgaW50NjRfdCBiaXRtYXBfYnl0
ZXM7DQo+ID4NCj4gPiAgICAgICBhc3NlcnQoZ3JhbnVsYXJpdHkgPiAwKTsNCj4gPiAgICAgICBh
c3NlcnQoKGdyYW51bGFyaXR5ICYgKGdyYW51bGFyaXR5IC0gMSkpID09IDApOyBAQCAtMTcxLDkg
KzE3OSw5DQo+ID4gQEAgc3RhdGljIGludCBjaGVja19jb25zdHJhaW50c19vbl9iaXRtYXAoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsDQo+ID4gICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICAg
ICAgIH0NCj4gPg0KPiA+IC0gICAgaWYgKChsZW4gPiAodWludDY0X3QpQk1FX01BWF9QSFlTX1NJ
WkUgPDwgZ3JhbnVsYXJpdHlfYml0cykgfHwNCj4gPiAtICAgICAgICAobGVuID4gKHVpbnQ2NF90
KUJNRV9NQVhfVEFCTEVfU0laRSAqIHMtPmNsdXN0ZXJfc2l6ZSA8PA0KPiA+IC0gICAgICAgICAg
ICAgICBncmFudWxhcml0eV9iaXRzKSkNCj4gPiArICAgIGJpdG1hcF9ieXRlcyA9IGdldF9iaXRt
YXBfYnl0ZXNfbmVlZGVkKGxlbiwgZ3JhbnVsYXJpdHkpOw0KPiA+ICsgICAgaWYgKChiaXRtYXBf
Ynl0ZXMgPiAodWludDY0X3QpQk1FX01BWF9QSFlTX1NJWkUpIHx8DQo+ID4gKyAgICAgICAgKGJp
dG1hcF9ieXRlcyA+ICh1aW50NjRfdClCTUVfTUFYX1RBQkxFX1NJWkUgKg0KPiA+ICsgcy0+Y2x1
c3Rlcl9zaXplKSkNCj4gPiAgICAgICB7DQo+ID4gICAgICAgICAgIGVycm9yX3NldGcoZXJycCwg
IlRvbyBtdWNoIHNwYWNlIHdpbGwgYmUgb2NjdXBpZWQgYnkgdGhlDQo+IGJpdG1hcC4gIg0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICJVc2UgbGFyZ2VyIGdyYW51bGFyaXR5Iik7DQo+ID4NCj4g
DQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IFZsYWRpbWlyDQo=

