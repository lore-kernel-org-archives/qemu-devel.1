Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967BCCA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 02:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B1B2086A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 02:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B1B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPdad-00030U-9m
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 22:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1iPdZe-0002O0-Ji
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 22:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1iPdZc-0001qE-5B
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 22:19:02 -0400
Received: from smtp.h3c.com ([60.191.123.50]:2772 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1iPdZb-0001S9-Jb; Tue, 29 Oct 2019 22:19:00 -0400
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
 by h3cspam02-ex.h3c.com with ESMTPS id x9U2II2n072234
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Oct 2019 10:18:18 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Oct 2019 10:18:19 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Wed, 30 Oct 2019 10:18:19 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz
 <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: RE: [PATCH v2] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v2] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWNWOAJ7czUdZfnT3+PEnECPxQetwArhuYAAAF964AALldNsA==
Date: Wed, 30 Oct 2019 02:18:19 +0000
Message-ID: <446f2e5235ac45269d733a169251ddd6@h3c.com>
References: <494aedb644bf434f8eee0263aa17aa23@h3c.com>
 <8f65c725-68ae-6a9f-d155-cb0dd15c995e@redhat.com>
 <c5c45c60-8d8a-ca0d-4a89-4a5e26176164@virtuozzo.com>
In-Reply-To: <c5c45c60-8d8a-ca0d-4a89-4a5e26176164@virtuozzo.com>
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
X-MAIL: h3cspam02-ex.h3c.com x9U2II2n072234
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.50
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
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMjkuMTAuMjAxOSAxOTo1NyBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0K
PiAyOS4xMC4yMDE5IDE0OjE0LCBNYXggUmVpdHogd3JvdGU6DQo+ID4gT24gMjguMTAuMTkgMDc6
MzMsIFR1Z3VveWkgd3JvdGU6DQo+ID4+IEluIGNoZWNrX2NvbnN0cmFpbnRzX29uX2JpdG1hcCgp
LCB0aGUgc2FuaXR5IGNoZWNrIG9uIHRoZSBncmFudWxhcml0eQ0KPiA+PiB3aWxsIGNhdXNlIHVp
bnQ2NF90IGludGVnZXIgbGVmdC1zaGlmdCBvdmVyZmxvdyB3aGVuIGNsdXN0ZXJfc2l6ZSBpcw0K
PiA+PiAyTSBhbmQgdGhlIGdyYW51bGFyaXR5IGlzIEJJR0dFUiB0aGFuIDMySy4gQXMgYSByZXN1
bHQsIGZvciBhIHFjb3cyDQo+ID4+IGRpc2sgd2l0aCBjbHVzdGVyX3NpemUgc2V0IHRvIDJNLCB3
ZSBjb3VsZCBub3QgZXZlbiBjcmVhdGUgYSBkaXJ0eQ0KPiA+PiBiaXRtYXAgd2l0aCBkZWZhdWx0
IGdyYW51bGFyaXR5LiBUaGlzIHBhdGNoIGZpeCB0aGUgaXNzdWUgYnkgZGl2aWRpbmcNCj4gPj4g
QGxlbiBieSBncmFudWxhcml0eSBpbnN0ZWFkLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBH
dW95aSBUdSA8dHUuZ3VveWlAaDNjLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgYmxvY2svcWNvdzIt
Yml0bWFwLmMgfCA0ICsrLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItYml0
bWFwLmMgYi9ibG9jay9xY293Mi1iaXRtYXAuYyBpbmRleA0KPiA+PiA5ODI5NGE3Li43MWFjODIy
IDEwMDY0NA0KPiA+PiAtLS0gYS9ibG9jay9xY293Mi1iaXRtYXAuYw0KPiA+PiArKysgYi9ibG9j
ay9xY293Mi1iaXRtYXAuYw0KPiA+PiBAQCAtMTcyLDggKzE3Miw4IEBAIHN0YXRpYyBpbnQNCj4g
Y2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiA+PiAg
ICAgICB9DQo+ID4+DQo+ID4+ICAgICAgIGlmICgobGVuID4gKHVpbnQ2NF90KUJNRV9NQVhfUEhZ
U19TSVpFIDw8IGdyYW51bGFyaXR5X2JpdHMpIHx8DQoNCkhlcmUgaXMgdGhlIHNhbWUgcHJvYmxl
bSwgd2UgbmVlZCBhbHNvIHRvIGNhbGN1bGF0ZSB0aGUgbnVtYmVyIG9mIGJpdHMgaW5zdGVhZCBv
ZiBieXRlcy4NCg0KPiA+PiAtICAgICAgICAobGVuID4gKHVpbnQ2NF90KUJNRV9NQVhfVEFCTEVf
U0laRSAqIHMtPmNsdXN0ZXJfc2l6ZSA8PA0KPiA+PiAtICAgICAgICAgICAgICAgZ3JhbnVsYXJp
dHlfYml0cykpDQo+ID4+ICsgICAgICAgIChESVZfUk9VTkRfVVAobGVuLCBncmFudWxhcml0eSkg
Pg0KPiAodWludDY0X3QpQk1FX01BWF9UQUJMRV9TSVpFICoNCj4gPj4gKyAgICAgICAgICAgICAg
ICBzLT5jbHVzdGVyX3NpemUpKQ0KPiA+DQo+ID4gVGhpcyBkaWRu4oCZdCBjaGFuZ2UgYmVjYXVz
ZSBvZiB0aGlzIHBhdGNoLCBidXQgZG9lc27igJl0IHRoaXMgY29tcGFyaXNvbg0KPiA+IG5lZWQg
YSBjb252ZXJzaW9uIG9mIGJpdHMgdG8gYnl0ZXMgc29tZXdoZXJlPw0KPiA+DQo+ID4gbGVuIC8g
Z3JhbnVsYXJpdHkgZ2l2ZXMgdXMgdGhlIG51bWJlciBvZiBiaXRzIG5lZWRlZCBmb3IgdGhlIGJp
dG1hcC4NCj4gPg0KPiA+IEJNRV9NQVhfVEFCTEVfU0laRSBpcywgYXMgZmFyIGFzIEkgY2FuIHNl
ZSwgYSBudW1iZXIgb2YgYml0bWFwDQo+ID4gY2x1c3RlcnMsIHNvIG11bHRpcGx5aW5nIGl0IGJ5
IHRoZSBjbHVzdGVyIHNpemUgZ2l2ZXMgdGhlIG51bWJlciBvZg0KPiA+IGJ5dGVzIGluIHRoZSBi
aXRtYXAuICBCdXQgdGhlIG51bWJlciBvZiBiaXRzIGlzIGVpZ2h0IHRpbWVzIGhpZ2hlci4NCj4g
DQo+IEkgdGhpbmsgeW91IGFyZSByaWdodC4gSXQgd291bGQgYmUgYmV0dGVyIHRvIGZpeCBpdCBp
biB0aGUgc2FtZSBwYXRjaC4uDQo+IA0KDQpJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBh
ZGQgYSBpbmxpbmUgZnVuY3Rpb24gdG8gY2FsY3VsYXRlIHRoZSBtYXggYnl0ZXMgDQpvZiBiaXRt
YXAgd2l0aCBnaXZlbiB2aXJ0dWFsIHNpemUgYW5kIGdyYW51bGFyaXR5Lg0KDQpJJ2xsIHNlbmQg
YW5vdGhlciBwYXRjaCBsYXRlcg0KDQo+ID4NCj4gPiBBbm90aGVyIHRvcGljOiBJc27igJl0IEJN
RV9NQVhfVEFCTEVfU0laRSB0b28gYmlnPw0KPiANCj4gTWF5YmUpIFN0aWxsLCBJIGRvbid0IHN1
cmUgdGhhdCB3ZSBuZWVkIHRvIGNoYW5nZSBpdC4uDQo+IA0KPiA+ICBBcyBpdCBpcywgYml0bWFw
DQo+ID4gdGFibGVzIGNhbiBoYXZlIGEgc2l6ZSBvZiAxIEdCLCBhbmQgdGhhdOKAmXMgdGhlIHRh
YmxlIGFsb25lLiAgRGVwZW5kaW5nDQo+ID4gb24gdGhlIGNsdXN0ZXIgc2l6ZSwgdGhlIGJpdG1h
cCB3b3VsZCB0YWtlIHVwIGF0IGxlYXN0IDY0IEdCIGFuZCBjb3Zlcg0KPiA+IGF0IGxlYXN0IDMy
IFRCIChhdCBhIGdyYW51bGFyaXR5IG9mIDUxMiBieXRlcykuDQo+ID4NCj4gPiBNYXgNCj4gPg0K
PiA+PiAgICAgICB7DQo+ID4+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJUb28gbXVjaCBz
cGFjZSB3aWxsIGJlIG9jY3VwaWVkIGJ5IHRoZQ0KPiBiaXRtYXAuICINCj4gPj4gICAgICAgICAg
ICAgICAgICAgICAgIlVzZSBsYXJnZXIgZ3JhbnVsYXJpdHkiKTsNCj4gPj4NCj4gPg0KPiA+DQo+
IA0KPiANCj4gLS0NCj4gQmVzdCByZWdhcmRzLA0KPiBWbGFkaW1pcg0K

