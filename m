Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C63C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 01:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1677A2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 01:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1677A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGuzY-00043H-6q
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 21:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jGuyx-0003Y5-Vx
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 21:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jGuyv-0003Cb-Sg
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 21:37:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:60567)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jGuyv-00038A-LE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 21:37:21 -0400
IronPort-SDR: 4LFGpoiFdjYtiDRn9ajBsceyEojUgReaK1rEM5rKqITYAKKllYNnuSzFHflO6wEj2kvN0wBJd0
 o5ohbxXUm9hg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 18:37:17 -0700
IronPort-SDR: wDbNQor7A02CwOCNDQichCyvtE1THkIv/RbsaJnmTWb7kHFvwdnPBTevg8lI2HiW2CjK/D4d7e
 WLFBwxXGIryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; d="scan'208";a="270651461"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2020 18:37:17 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 18:37:16 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Mar 2020 09:37:14 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 25 Mar 2020 09:37:14 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jing-Wei Su <jwsu1986@gmail.com>
Subject: RE: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
Thread-Topic: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in
 packet_enqueue()
Thread-Index: AQHWAHITxBU5D7mjSkWbPnpdLQyVtKhWi7uA///6NgCAAgGA0A==
Date: Wed, 25 Mar 2020 01:37:14 +0000
Message-ID: <2046ed570c754e25ae2b8d5c6c48de2f@intel.com>
References: <20200322174751.12559-1-dereksu@qnap.com>
 <20200322174751.12559-2-dereksu@qnap.com>
 <883bf4e2916f43baa6700f98bbb85523@intel.com>
 <CAFKS8hUJ34Qh7gsggtbVM6GU4hLEn_xBLFM7X5mQrsmQg-Yc7w@mail.gmail.com>
In-Reply-To: <CAFKS8hUJ34Qh7gsggtbVM6GU4hLEn_xBLFM7X5mQrsmQg-Yc7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.65
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
Cc: "dereksu@qnap.com" <dereksu@qnap.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmluZy1XZWkgU3UgPGp3
c3UxOTg2QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMjQsIDIwMjAgMTA6NDcg
QU0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gQ2M6IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsgbGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tOw0KPiBqYXNvd2FuZ0By
ZWRoYXQuY29tOyBkZXJla3N1QHFuYXAuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8x
XSBuZXQvY29sby1jb21wYXJlLmM6IEZpeCBtZW1vcnkgbGVhayBpbg0KPiBwYWNrZXRfZW5xdWV1
ZSgpDQo+IA0KPiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+IOaWvCAyMDIw5bm0
M+aciDI05pelIOmAseS6jCDkuIrljYgzOjI0DQo+IOWvq+mBk++8mg0KPiA+DQo+ID4NCj4gPg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IERlcmVrIFN1IDxq
d3N1MTk4NkBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBNb25kYXksIE1hcmNoIDIzLCAyMDIwIDE6
NDggQU0NCj4gPiA+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPiA+IENjOiBaaGFuZywg
Q2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBsaXpoaWppYW5AY24uZnVqaXRzdS5jb207DQo+
ID4gPiBqYXNvd2FuZ0ByZWRoYXQuY29tOyBkZXJla3N1QHFuYXAuY29tDQo+ID4gPiBTdWJqZWN0
OiBbUEFUQ0ggdjIgMS8xXSBuZXQvY29sby1jb21wYXJlLmM6IEZpeCBtZW1vcnkgbGVhayBpbg0K
PiA+ID4gcGFja2V0X2VucXVldWUoKQ0KPiA+ID4NCj4gPiA+IFRoZSBwYXRjaCBpcyB0byBmaXgg
dGhlICJwa3QiIG1lbW9yeSBsZWFrIGluIHBhY2tldF9lbnF1ZXVlKCkuDQo+ID4gPiBUaGUgYWxs
b2NhdGVkICJwa3QiIG5lZWRzIHRvIGJlIGZyZWVkIGlmIHRoZSBjb2xvIGNvbXBhcmUgcHJpbWFy
eSBvcg0KPiA+ID4gc2Vjb25kYXJ5IHF1ZXVlIGlzIHRvbyBiaWcuDQo+ID4NCj4gPiBIaSBEZXJl
aywNCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPiA+IEkgcmUtdGhpbmsgdGhp
cyBpc3N1ZSBpbiBhIGJpZyB2aWV3LCBsb29rcyBqdXN0IGZyZWUgdGhlIHBrZyBpcyBub3QgZW5v
dWdoIGluDQo+IHRoaXMgc2l0dWF0aW9uLg0KPiA+IFRoZSByb290IGNhdXNlIGlzIG5ldHdvcmsg
aXMgdG9vIGJ1c3kgdG8gY29tcGFyZSwgU28sIGJldHRlciBjaG9pY2UgaXMNCj4gPiBub3RpZnkg
Q09MTyBmcmFtZSB0byBkbyBhIGNoZWNrcG9pbnQgYW5kIGNsZWFuIHVwIGFsbCB0aGUgbmV0d29y
aw0KPiA+IHF1ZXVlLiBUaGlzIHdvcmsgbWF5YmUgZGVjcmVhc2UgQ09MTyBuZXR3b3JrIHBlcmZv
cm1hbmNlIGJ1dCBzZWFtcw0KPiBiZXR0ZXIgdGhhbiBkcm9wIGxvdHMgb2YgcGtnLg0KPiA+DQo+
ID4gVGhhbmtzDQo+ID4gWmhhbmcgQ2hlbg0KPiA+DQo+IA0KPiBIZWxsbywgWmhhbmcNCj4gDQo+
IEdvdCBpdC4NCj4gV2hhdCBpcyB0aGUgY29uY2VybiBvZiB0aGUgbWFzc2l2ZSAiZHJvcCBwYWNr
ZXRzIj8NCj4gRG9lcyB0aGUgYmVoYXZpb3IgbWFrZSB0aGUgQ09MTyBkbyBjaGVja3BvaW50IHBl
cmlvZGljYWxseSAofjIwIHNlY29uZHMpDQo+IGluc3RlYWQgb2YgZG9pbmcgaW1tZWRpYXRlIGNo
ZWNrcG9pbnQgd2hlbiBlbmNvdW50ZXJpbmcgZGlmZmVyZW50DQo+IHJlc3BvbnNlIHBhY2tldHM/
DQoNClRoZSBjb25jZXJuIG9mIHRoZSAiZHJvcCBwYWNrZXRzIiBpcyBndWVzdCB3aWxsIGxvc2Ug
bmV0d29yayBjb25uZWN0aW9uIHdpdGgNCm1vc3Qgb2YgcmVhbCBjbGllbnRzIHVudGlsIG5leHQg
cGVyaW9kaWMgZm9yY2UgY2hlY2twb2ludC4gQ09MTyBkZXNpZ25lZCBmb3IgZHluYW1pYw0KY29u
dHJvbCBjaGVja3BvaW50LCBzbyBJIHRoaW5rIGRvIGEgY2hlY2twb2ludCBoZXJlIHdpbGwgaGVs
cCBndWVzdCBzdXBwbHkgc2VydmljZSBmYXN0ZXIuDQoNCj4gDQo+IEl0IHNlZW1zIHRoYXQgZnJl
cXVlbnQgY2hlY2twb2ludHMgY2F1c2VkIGJ5IHRoZSBmdWxsIHF1ZXVlIChidXN5DQo+IG5ldHdv
cmspIGluc3RlYWQgb2YgZGlmZmVyZW50DQo+IHJlc3BvbnNlIHBhY2tldHMgbWF5IGhhcm0gdGhl
IGhpZ2ggc3BlZWQgbmV0d29yayAoMTAgR2JwcyBvciBoaWdoZXIpDQo+IHBlcmZvcm1hbmNlIGRy
YW1hdGljYWxseS4NCg0KWWVzLCBtYXliZSBJIGNhbiBzZW5kIGEgcGF0Y2ggdG8gbWFrZSB1c2Vy
IGFkanVzdCBxdWV1ZSBzaXplIGRlcGVuZCBvbiBpdCdzIG93biBlbnZpcm9ubWVudC4NCkJ1dCB3
aXRoIGxhcmdlciBxdWV1ZSBzaXplLCBjb2xvLWNvbXBhcmUgd2lsbCBzcGVuZCBtdWNoIHRpbWUg
dG8gZG8gY29tcGFyZSBwYWNrZXQgd2hlbiBuZXR3b3JrDQpJcyByZWFsIGJ1c3kgc3RhdHVzLg0K
DQpUaGFua3MNClpoYW5nIENoZW4gICANCg0KPiANCj4gVGhhbmtzDQo+IERlcmVrDQo+IA0KPiA+
ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERlcmVrIFN1IDxkZXJla3N1QHFuYXAuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiAgbmV0L2NvbG8tY29tcGFyZS5jIHwgMjMgKysrKysrKysrKysrKysrLS0t
LS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NvbG8tY29tcGFyZS5jIGIvbmV0
L2NvbG8tY29tcGFyZS5jIGluZGV4DQo+ID4gPiA3ZWUxN2YyY2Y4Li5jZGQ4N2IyYWE4IDEwMDY0
NA0KPiA+ID4gLS0tIGEvbmV0L2NvbG8tY29tcGFyZS5jDQo+ID4gPiArKysgYi9uZXQvY29sby1j
b21wYXJlLmMNCj4gPiA+IEBAIC0xMjAsNiArMTIwLDEwIEBAIGVudW0gew0KPiA+ID4gICAgICBT
RUNPTkRBUllfSU4sDQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiArc3RhdGljIGNvbnN0IGNoYXIg
KmNvbG9fbW9kZVtdID0gew0KPiA+ID4gKyAgICBbUFJJTUFSWV9JTl0gPSAicHJpbWFyeSIsDQo+
ID4gPiArICAgIFtTRUNPTkRBUllfSU5dID0gInNlY29uZGFyeSIsDQo+ID4gPiArfTsNCj4gPiA+
DQo+ID4gPiAgc3RhdGljIGludCBjb21wYXJlX2Nocl9zZW5kKENvbXBhcmVTdGF0ZSAqcywNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgdWludDhfdCAqYnVmLCBAQCAt
MjE1LDYgKzIxOSw3IEBADQo+ID4gPiBzdGF0aWMgaW50IHBhY2tldF9lbnF1ZXVlKENvbXBhcmVT
dGF0ZSAqcywgaW50IG1vZGUsIENvbm5lY3Rpb24NCj4gKipjb24pDQo+ID4gPiAgICAgIENvbm5l
Y3Rpb25LZXkga2V5Ow0KPiA+ID4gICAgICBQYWNrZXQgKnBrdCA9IE5VTEw7DQo+ID4gPiAgICAg
IENvbm5lY3Rpb24gKmNvbm47DQo+ID4gPiArICAgIGludCByZXQ7DQo+ID4gPg0KPiA+ID4gICAg
ICBpZiAobW9kZSA9PSBQUklNQVJZX0lOKSB7DQo+ID4gPiAgICAgICAgICBwa3QgPSBwYWNrZXRf
bmV3KHMtPnByaV9ycy5idWYsIEBAIC0yNDMsMTYgKzI0OCwxOCBAQA0KPiA+ID4gc3RhdGljIGlu
dCBwYWNrZXRfZW5xdWV1ZShDb21wYXJlU3RhdGUgKnMsIGludCBtb2RlLCBDb25uZWN0aW9uDQo+
ICoqY29uKQ0KPiA+ID4gICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICBpZiAobW9kZSA9PSBQUklN
QVJZX0lOKSB7DQo+ID4gPiAtICAgICAgICBpZiAoIWNvbG9faW5zZXJ0X3BhY2tldCgmY29ubi0+
cHJpbWFyeV9saXN0LCBwa3QsICZjb25uLT5wYWNrKSkgew0KPiA+ID4gLSAgICAgICAgICAgIGVy
cm9yX3JlcG9ydCgiY29sbyBjb21wYXJlIHByaW1hcnkgcXVldWUgc2l6ZSB0b28gYmlnLCINCj4g
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgImRyb3AgcGFja2V0Iik7DQo+ID4gPiAtICAg
ICAgICB9DQo+ID4gPiArICAgICAgICByZXQgPSBjb2xvX2luc2VydF9wYWNrZXQoJmNvbm4tPnBy
aW1hcnlfbGlzdCwgcGt0LA0KPiA+ID4gKyAmY29ubi0+cGFjayk7DQo+ID4gPiAgICAgIH0gZWxz
ZSB7DQo+ID4gPiAtICAgICAgICBpZiAoIWNvbG9faW5zZXJ0X3BhY2tldCgmY29ubi0+c2Vjb25k
YXJ5X2xpc3QsIHBrdCwgJmNvbm4tPnNhY2spKSB7DQo+ID4gPiAtICAgICAgICAgICAgZXJyb3Jf
cmVwb3J0KCJjb2xvIGNvbXBhcmUgc2Vjb25kYXJ5IHF1ZXVlIHNpemUgdG9vIGJpZywiDQo+ID4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICJkcm9wIHBhY2tldCIpOw0KPiA+ID4gLSAgICAg
ICAgfQ0KPiA+ID4gKyAgICAgICAgcmV0ID0gY29sb19pbnNlcnRfcGFja2V0KCZjb25uLT5zZWNv
bmRhcnlfbGlzdCwgcGt0LA0KPiA+ID4gKyAmY29ubi0+c2Fjayk7DQo+ID4gPiAgICAgIH0NCj4g
PiA+ICsNCj4gPiA+ICsgICAgaWYgKCFyZXQpIHsNCj4gPiA+ICsgICAgICAgIGVycm9yX3JlcG9y
dCgiY29sbyBjb21wYXJlICVzIHF1ZXVlIHNpemUgdG9vIGJpZywiDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgImRyb3AgcGFja2V0IiwgY29sb19tb2RlW21vZGVdKTsNCj4gPiA+ICsgICAg
ICAgIHBhY2tldF9kZXN0cm95KHBrdCwgTlVMTCk7DQo+ID4gPiArICAgICAgICBwa3QgPSBOVUxM
Ow0KPiA+ID4gKyAgICB9DQo+ID4gPiArDQo+ID4gPiAgICAgICpjb24gPSBjb25uOw0KPiA+ID4N
Cj4gPiA+ICAgICAgcmV0dXJuIDA7DQo+ID4gPiAtLQ0KPiA+ID4gMi4xNy4xDQo+ID4NCg==

