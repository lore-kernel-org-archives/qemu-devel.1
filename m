Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54CEC468C2
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 05:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E8520861
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 05:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E8520861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haDIp-0001Hk-Qh
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 01:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1haDIM-0000p0-A7
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 01:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1haDIL-0004zI-1T
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 01:56:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:15048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1haDIK-0004y1-QL
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 01:56:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jun 2019 22:56:33 -0700
X-ExtLoop1: 1
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2019 22:56:32 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 9 Jun 2019 22:56:32 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 9 Jun 2019 22:56:31 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.134]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.10]) with mapi id 14.03.0415.000;
 Mon, 10 Jun 2019 13:56:30 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela
 <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-dev <qemu-devel@nongnu.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>
Thread-Topic: [PATCH V2 0/5] Add Xen COLO support
Thread-Index: AQHVHuNRBWevQzBoQk2i1pAZg06es6aTwJgAgACjccA=
Date: Mon, 10 Jun 2019 05:56:29 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780615AACB@shsmsx102.ccr.corp.intel.com>
References: <20190609164433.5866-1-chen.zhang@intel.com>
 <e02f265c-a0f4-0b34-e3e9-48f0d9eefaf8@redhat.com>
In-Reply-To: <e02f265c-a0f4-0b34-e3e9-48f0d9eefaf8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzBmYWFhYTItYTBiNy00ZWM0LTllM2YtZGUzMDBiZTlmZTM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ0VSa0krdmRYemVheWFXQzkxTzRNKytIU0Q0RjdQVE5tcDQ5Z1pGcGN1U2xvS296SHNnWTFaVVkzdG9DT0xaQSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH V2 0/5] Add Xen COLO support
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyBbbWFp
bHRvOmphc293YW5nQHJlZGhhdC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAxMCwgMjAxOSAx
MjowOSBQTQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPjsNCj4gRHIuIERhdmlkIEFsYW4gR2lsYmVy
dCA8ZGdpbGJlcnRAcmVkaGF0LmNvbT47IEp1YW4gUXVpbnRlbGENCj4gPHF1aW50ZWxhQHJlZGhh
dC5jb20+OyB6aGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+Ow0K
PiBxZW11LWRldiA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgU3RlZmFubyBTdGFiZWxsaW5pDQo+
IDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPjsgUGF1bCBEdXJyYW50IDxwYXVsLmR1cnJhbnRAY2l0
cml4LmNvbT4NCj4gQ2M6IFpoYW5nIENoZW4gPHpoYW5nY2tpZEBnbWFpbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjIgMC81XSBBZGQgWGVuIENPTE8gc3VwcG9ydA0KPiANCj4gDQo+IE9u
IDIwMTkvNi8xMCDkuIrljYgxMjo0NCwgWmhhbmcgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBaaGFu
ZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IFhlbiBDT0xPIGJhc2VkIG9u
IEtWTSBDT0xPIGFyY2hpdGVjdHVyZSwgaXQgc2hhcmVkIENPTE8gcHJveHkgYW5kDQo+ID4gYmxv
Y2sgcmVwbGljYXRpb24gd2l0aCBLVk0gQ09MTy4gVGhlIG9ubHkgZGlmZmVyZWNlIGlzIFhlbiBD
T0xPIGhhdmUNCj4gPiBvd24gQ09MTy1mcmFtZSB0byBoYW5kbGUgbGl2ZSBtaWdyYXRpb24gcmVs
YXRlZCBmdW5jdGlvbiwgc28gd2UgbmVlZA0KPiA+IHRoaXMgc2VyaWVzIG1ha2UgWGVuIENPTE8g
ZnJhbWUgY2FuIGNvbW11bmljYXRlIHdpdGggb3RoZXIgQ09MTw0KPiA+IG1vZHVsZXMgaW4gcWVt
dS4gWGVuIHNpZGUgcmVsYXRlZCBwYXRjaGVzIGhhdmUgYmVlbiBtZXJnZWQuDQo+IA0KPiANCj4g
QW55IHBvaW50ZXIgdG8gdGhpcz8NCj4gDQoNClllcywgcGxlYXNlIHNlZSB0aGlzIHRocmVhZDoN
Cg0KaHR0cHM6Ly9saXN0cy54ZW4ub3JnL2FyY2hpdmVzL2h0bWwveGVuLWRldmVsLzIwMTctMDMv
bXNnMDA3MTguaHRtbA0KDQpUaGFua3MNClpoYW5nIENoZW4NCg0KPiBUaGFua3MNCj4gDQo+IA0K
PiA+DQo+ID4gVjI6DQo+ID4gICAtIFJlYmFzZSBvbiB1cHN0cmVhbSBjb2RlLg0KPiA+ICAgLSBP
cHRpbWl6ZSBjb2RlIGJ5IFpoaWppYW4ncyBjb21tZW50cyBpbiBwYXRjaCA0LzUuDQo+ID4gICAt
IFJlbW92ZSBvcmlnaW4gNS82IHBhdGNoLg0KPiA+DQo+ID4gVjE6DQo+ID4gICAtIEluaXRpYWwg
cGF0Y2guDQo+ID4NCj4gPiBaaGFuZyBDaGVuICg1KToNCj4gPiAgICBDT0xPLWNvbXBhcmU6IEFk
ZCBuZXcgcGFyYW1ldGVyIHRvIGNvbW11bmljYXRlIHdpdGggcmVtb3RlIGNvbG8tDQo+IGZyYW1l
DQo+ID4gICAgQ09MTy1jb21wYXJlOiBBZGQgcmVtb3RlIG5vdGlmaWNhdGlvbiBjaGFyZGV2IGhh
bmRsZXIgZnJhbWUNCj4gPiAgICBDT0xPLWNvbXBhcmU6IE1ha2UgdGhlIGNvbXBhcmVfY2hyX3Nl
bmQoKSBjYW4gc2VuZCBub3RpZmljYXRpb24NCj4gPiAgICAgIG1lc3NhZ2UuDQo+ID4gICAgQ09M
Ty1jb21wYXJlOiBBZGQgY29sby1jb21wYXJlIHJlbW90ZSBub3RpZnkgc3VwcG9ydA0KPiA+ICAg
IG1pZ3JhdGlvbi9jb2xvLmM6IEFkZCBtaXNzZWQgZmlsdGVyIG5vdGlmeSBmb3IgWGVuIENPTE8u
DQo+ID4NCj4gPiAgIG1pZ3JhdGlvbi9jb2xvLmMgICB8ICAgMiArDQo+ID4gICBuZXQvY29sby1j
b21wYXJlLmMgfCAxNTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
DQo+IC0tLQ0KPiA+ICAgcWVtdS1vcHRpb25zLmh4ICAgIHwgIDMzICsrKysrKysrKy0NCj4gPiAg
IDMgZmlsZXMgY2hhbmdlZCwgMTcxIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+
DQo=

