Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB1BCA9ECF
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 02:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598B3208CB
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 02:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598B3208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQj9f-0002bF-DM
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 22:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1iQj8T-0001su-4W
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 22:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1iQj8R-0007NT-U1
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 22:27:29 -0400
Received: from smtp.h3c.com ([60.191.123.50]:50478 helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1iQj8O-0006dS-He; Fri, 01 Nov 2019 22:27:25 -0400
Received: from DAG2EX05-BASE.srv.huawei-3com.com ([10.8.0.68])
 by h3cspam02-ex.h3c.com with ESMTPS id xA22RBqd038775
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 2 Nov 2019 10:27:11 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 10:27:12 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Sat, 2 Nov 2019 10:27:12 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: RE: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWQhrb0bffMwMc6ShSREntjykPuIgADxL+AAAAaQED//4ZggP/+aTZw
Date: Sat, 2 Nov 2019 02:27:11 +0000
Message-ID: <6321642b1fcd4bbf817d08c5ddcbf524@h3c.com>
References: <4ba40cd1e7ee4a708b40899952e49f22@h3c.com>
 <8b7d3d50-4a29-a8b3-5b6c-cde4af1b1d7a@virtuozzo.com>
 <7650a7b706d24774b4ea3af23a2b371f@h3c.com>
 <dcdf7075-45f4-8ba1-69fc-17cd673125ca@virtuozzo.com>
In-Reply-To: <dcdf7075-45f4-8ba1-69fc-17cd673125ca@virtuozzo.com>
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
X-MAIL: h3cspam02-ex.h3c.com xA22RBqd038775
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
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMDEuMTEuMjAxOSAxODowOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToN
Cj4gMDEuMTEuMjAxOSAxMjozNCwgVHVndW95aSB3cm90ZToNCj4gPiBPbiAwMS4xMS4yMDE5IDE3
OjI1IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+ID4+IDAxLjExLjIwMTkg
MTA6MzcsIFR1Z3VveWkgd3JvdGU6DQo+ID4+PiBUaGVyZSBhcmUgdHdvIGlzc3VlcyBpbiBJbiBj
aGVja19jb25zdHJhaW50c19vbl9iaXRtYXAoKSwNCj4gPj4+IDEpIFRoZSBzYW5pdHkgY2hlY2sg
b24gdGhlIGdyYW51bGFyaXR5IHdpbGwgY2F1c2UgdWludDY0X3QgaW50ZWdlcg0KPiA+Pj4gbGVm
dC1zaGlmdCBvdmVyZmxvdyB3aGVuIGNsdXN0ZXJfc2l6ZSBpcyAyTSBhbmQgdGhlIGdyYW51bGFy
aXR5IGlzDQo+ID4+PiBCSUdHRVIgdGhhbiAzMksuDQo+ID4+PiAyKSBUaGUgd2F5IHRvIGNhbGN1
bGF0ZSBpbWFnZSBzaXplIHRoYXQgdGhlIG1heGltdW0gYml0bWFwIHN1cHBvcnRlZA0KPiA+Pj4g
Y2FuIG1hcCB0byBpcyBhIGJpdCBpbmNvcnJlY3QuDQo+ID4+PiBUaGlzIHBhdGNoIGZpeCBpdCBi
eSBhZGQgYSBoZWxwZXIgZnVuY3Rpb24gdG8gY2FsY3VsYXRlIHRoZSBudW1iZXINCj4gPj4+IG9m
IGJ5dGVzIG5lZWRlZCBieSBhIG5vcm1hbCBiaXRtYXAgaW4gaW1hZ2UgYW5kIGNvbXBhcmUgaXQg
dG8gdGhlDQo+ID4+PiBtYXhpbXVtIGJpdG1hcCBieXRlcyBzdXBwb3J0ZWQgYnkgcWVtdS4NCj4g
Pj4+DQo+ID4+PiBGaXhlczogNWY3MjgyNmU3ZmM2MjE2N2NmM2ENCj4gPj4+IFNpZ25lZC1vZmYt
Ynk6IEd1b3lpIFR1IDx0dS5ndW95aUBoM2MuY29tPg0KPiA+Pg0KPiA+PiBZb3UgZm9yZ2V0IG15
DQo+ID4+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50
c292QHZpcnR1b3p6by5jb20+DQo+ID4NCj4gPiBTb3JyeSBmb3IgdGhhdCwgaXQncyBteSBmaXJz
dCB0aW1lIHRvIHN1Ym1pdCBwYXRjaCB0byBxZW11LCBhbmQgc2hvdWxkIEkgc2VuZA0KPiBhbm90
aGVyIHBhdGNoIG9yIG5vdCA/DQo+IA0KPiBHb29kIHN0YXJ0IQ0KPiANCj4gTm8sIHlvdSBzaG91
bGRuJ3QuIE1haW50YWluZXIgd2lsbCB0YWtlIHN1Y2ggbWFya3MgKGFuZCBtYXkgYmUgb3RoZXIN
Cj4gcHJvcG9zZWQgaW1wcm92ZW1lbnRzIGZvciBjb21taXQgbWVzc2FnZSBsaWtlIHRoaXMgIkZp
eGVzOiAiLCB3aGVuIGFwcGx5aW5nLA0KPiBzbyBubyByZWFzb24gdG8gcmVzZW5kLg0KPiANCj4g
QWxzbywgd2hlbiBzZW5kaW5nIGEgbmV3IHZlcnNpb24gb2YgcGF0Y2gsIHN1bW1hcml6ZSB3aGF0
IHdhcyBjaGFuZ2VkDQo+IHNpbmNlIHByZXZpb3VzIHZlcnNpb24gKHlvdSBtYXkgZG8gaXQgdW5k
ZXIgIi0tLSIgd2hpY2ggZm9sbG93cyBjb21taXQNCj4gbWVzc2FnZSwgb3IgaW4gY292ZXIgbGV0
dGVyIGlmIGl0J3MgYSBwYXRjaCBzZXQgd2l0aCBzZXZlcmFsIHBhdGNoZXMuDQoNCk9LLCBJIGdv
dCBpdCwgdGhhbmtzIGEgbG90LiANCg0KPiA+DQo+ID4+IChJIGRvbid0IHNlZSBjaGFuZ2VzIGV4
Y2VwdCBhZGQgIkZpeGVzOiAiIHRvIGNvbW1pdCBtc2cgYW5kIHB1dA0KPiA+PiBnZXRfYml0bWFw
X2J5dGVzX25lZWRlZCBkZWZpbml0aW9uIGhlYWRlciBpbnRvIG9uZSBsaW5lLikNCj4gPg0KPiA+
IFllcywgT25seSBtaW5vciBjaGFuZ2VzIGFyZSBtYWRlLCBpbmNsdWRpbmcgcmVtb3ZpbmcgJ2lu
bGluZScga2V5d29yZC4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBwYXRpZW5jZSBpbiByZXZp
ZXdpbmcgPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBibG9jay9xY293Mi1iaXRtYXAuYyB8IDE0ICsr
KysrKysrKysrLS0tDQo+ID4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItYml0
bWFwLmMgYi9ibG9jay9xY293Mi1iaXRtYXAuYyBpbmRleA0KPiA+Pj4gOTgyOTRhNy4uZWY5ZWY2
MiAxMDA2NDQNCj4gPj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+ID4+PiArKysgYi9i
bG9jay9xY293Mi1iaXRtYXAuYw0KPiA+Pj4gQEAgLTE0Miw2ICsxNDIsMTMgQEAgc3RhdGljIGlu
dCBjaGVja190YWJsZV9lbnRyeSh1aW50NjRfdCBlbnRyeSwNCj4gPj4+IGludA0KPiA+PiBjbHVz
dGVyX3NpemUpDQo+ID4+PiAgICAgICAgcmV0dXJuIDA7DQo+ID4+PiAgICB9DQo+ID4+Pg0KPiA+
Pj4gK3N0YXRpYyBpbnQ2NF90IGdldF9iaXRtYXBfYnl0ZXNfbmVlZGVkKGludDY0X3QgbGVuLCB1
aW50MzJfdA0KPiA+Pj4gK2dyYW51bGFyaXR5KSB7DQo+ID4+PiArICAgIGludDY0X3QgbnVtX2Jp
dHMgPSBESVZfUk9VTkRfVVAobGVuLCBncmFudWxhcml0eSk7DQo+ID4+PiArDQo+ID4+PiArICAg
IHJldHVybiBESVZfUk9VTkRfVVAobnVtX2JpdHMsIDgpOyB9DQo+ID4+PiArDQo+ID4+PiAgICBz
dGF0aWMgaW50IGNoZWNrX2NvbnN0cmFpbnRzX29uX2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpi
cywNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0
IGNoYXIgKm5hbWUsDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MzJfdCBncmFudWxhcml0eSwNCj4gQEANCj4gPj4+IC0xNTAsNiArMTU3LDcgQEAg
c3RhdGljIGludA0KPiA+Pj4gY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKEJsb2NrRHJpdmVy
U3RhdGUNCj4gPj4gKmJzLA0KPiA+Pj4gICAgICAgIEJEUlZRY293MlN0YXRlICpzID0gYnMtPm9w
YXF1ZTsNCj4gPj4+ICAgICAgICBpbnQgZ3JhbnVsYXJpdHlfYml0cyA9IGN0ejMyKGdyYW51bGFy
aXR5KTsNCj4gPj4+ICAgICAgICBpbnQ2NF90IGxlbiA9IGJkcnZfZ2V0bGVuZ3RoKGJzKTsNCj4g
Pj4+ICsgICAgaW50NjRfdCBiaXRtYXBfYnl0ZXM7DQo+ID4+Pg0KPiA+Pj4gICAgICAgIGFzc2Vy
dChncmFudWxhcml0eSA+IDApOw0KPiA+Pj4gICAgICAgIGFzc2VydCgoZ3JhbnVsYXJpdHkgJiAo
Z3JhbnVsYXJpdHkgLSAxKSkgPT0gMCk7IEBAIC0xNzEsOQ0KPiA+Pj4gKzE3OSw5IEBAIHN0YXRp
YyBpbnQgY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0K
PiA+Pj4gICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPj4+ICAgICAgICB9DQo+ID4+Pg0K
PiA+Pj4gLSAgICBpZiAoKGxlbiA+ICh1aW50NjRfdClCTUVfTUFYX1BIWVNfU0laRSA8PCBncmFu
dWxhcml0eV9iaXRzKSB8fA0KPiA+Pj4gLSAgICAgICAgKGxlbiA+ICh1aW50NjRfdClCTUVfTUFY
X1RBQkxFX1NJWkUgKiBzLT5jbHVzdGVyX3NpemUgPDwNCj4gPj4+IC0gICAgICAgICAgICAgICBn
cmFudWxhcml0eV9iaXRzKSkNCj4gPj4+ICsgICAgYml0bWFwX2J5dGVzID0gZ2V0X2JpdG1hcF9i
eXRlc19uZWVkZWQobGVuLCBncmFudWxhcml0eSk7DQo+ID4+PiArICAgIGlmICgoYml0bWFwX2J5
dGVzID4gKHVpbnQ2NF90KUJNRV9NQVhfUEhZU19TSVpFKSB8fA0KPiA+Pj4gKyAgICAgICAgKGJp
dG1hcF9ieXRlcyA+ICh1aW50NjRfdClCTUVfTUFYX1RBQkxFX1NJWkUgKg0KPiA+Pj4gKyBzLT5j
bHVzdGVyX3NpemUpKQ0KPiA+Pj4gICAgICAgIHsNCj4gPj4+ICAgICAgICAgICAgZXJyb3Jfc2V0
ZyhlcnJwLCAiVG9vIG11Y2ggc3BhY2Ugd2lsbCBiZSBvY2N1cGllZCBieSB0aGUNCj4gPj4gYml0
bWFwLiAiDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgIlVzZSBsYXJnZXIgZ3JhbnVsYXJp
dHkiKTsNCj4gPj4+DQo+ID4+DQo+ID4+DQo+ID4+IC0tDQo+ID4+IEJlc3QgcmVnYXJkcywNCj4g
Pj4gVmxhZGltaXINCj4gDQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IFZsYWRpbWlyDQo=

