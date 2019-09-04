Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8E1C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620FC23400
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 05:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620FC23400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5OB9-0004xW-KF
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 01:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1i5O7k-0003hj-2h
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1i5O7f-00086t-3R
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 01:46:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:58268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1i5O7c-000836-3G; Wed, 04 Sep 2019 01:46:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 22:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; d="scan'208";a="173457118"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga007.jf.intel.com with ESMTP; 03 Sep 2019 22:46:16 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Sep 2019 22:46:15 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Sep 2019 22:46:15 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.86]) with mapi id 14.03.0439.000;
 Wed, 4 Sep 2019 13:46:13 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peter Xu <peterx@redhat.com>
Thread-Topic: [PATCH for-4.2 v10 08/15] virtio-iommu: Implement map/unmap
Thread-Index: AQHVRvt45mqYxba1WEGcL7R8WepU8acBt2WAgBfMYYCAAOysAIAAsfiA//+PJgCAAIeL0A==
Date: Wed, 4 Sep 2019 05:46:13 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D562270@SHSMSX104.ccr.corp.intel.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-9-eric.auger@redhat.com>
 <20190819081143.GA13560@xz-x1>
 <b5e2ff32-eed8-829e-ffd4-2b62ed6b2fda@redhat.com>
 <20190904014416.GB30402@xz-x1>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D561F28@SHSMSX104.ccr.corp.intel.com>
 <20190904053720.GG30402@xz-x1>
In-Reply-To: <20190904053720.GG30402@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGRhNzBiMGYtMjRjMi00MmJlLTlkMTQtMWRkYjU5MDBhMjliIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNENtaVN1WGwzY2oyRWJcL2dzbjI5eFoxMTcyQTJTSjdXSjhtclA1NEFLUWc4ZXp0amZ6YTREVnRTVllcL1MzbGpoIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 08/15] virtio-iommu: Implement
 map/unmap
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
 "mst@redhat.com" <mst@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Auger Eric <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciA0LCAyMDE5IDE6MzcgUE0NCj4gDQo+IE9uIFdlZCwgU2VwIDA0LCAy
MDE5IGF0IDA0OjIzOjUwQU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTog
UGV0ZXIgWHUgW21haWx0bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gPiA+IFNlbnQ6IFdlZG5lc2Rh
eSwgU2VwdGVtYmVyIDQsIDIwMTkgOTo0NCBBTQ0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgU2VwIDAz
LCAyMDE5IGF0IDAxOjM3OjExUE0gKzAyMDAsIEF1Z2VyIEVyaWMgd3JvdGU6DQo+ID4gPiA+IEhp
IFBldGVyLA0KPiA+ID4gPg0KPiA+ID4gPiBPbiA4LzE5LzE5IDEwOjExIEFNLCBQZXRlciBYdSB3
cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIEp1bCAzMCwgMjAxOSBhdCAwNzoyMTozMFBNICswMjAw
LCBFcmljIEF1Z2VyIHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gWy4uLl0NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+PiArICAgIG1hcHBpbmcgPSBnX3RyZWVfbG9va3VwKGRvbWFpbi0+bWFwcGlu
Z3MsDQo+IChncG9pbnRlcikoJmludGVydmFsKSk7DQo+ID4gPiA+ID4+ICsNCj4gPiA+ID4gPj4g
KyAgICB3aGlsZSAobWFwcGluZykgew0KPiA+ID4gPiA+PiArICAgICAgICB2aW9tbXVfaW50ZXJ2
YWwgY3VycmVudDsNCj4gPiA+ID4gPj4gKyAgICAgICAgdWludDY0X3QgbG93ICA9IG1hcHBpbmct
PnZpcnRfYWRkcjsNCj4gPiA+ID4gPj4gKyAgICAgICAgdWludDY0X3QgaGlnaCA9IG1hcHBpbmct
PnZpcnRfYWRkciArIG1hcHBpbmctPnNpemUgLSAxOw0KPiA+ID4gPiA+PiArDQo+ID4gPiA+ID4+
ICsgICAgICAgIGN1cnJlbnQubG93ID0gbG93Ow0KPiA+ID4gPiA+PiArICAgICAgICBjdXJyZW50
LmhpZ2ggPSBoaWdoOw0KPiA+ID4gPiA+PiArDQo+ID4gPiA+ID4+ICsgICAgICAgIGlmIChsb3cg
PT0gaW50ZXJ2YWwubG93ICYmIHNpemUgPj0gbWFwcGluZy0+c2l6ZSkgew0KPiA+ID4gPiA+PiAr
ICAgICAgICAgICAgZ190cmVlX3JlbW92ZShkb21haW4tPm1hcHBpbmdzLCAoZ3BvaW50ZXIpKCZj
dXJyZW50KSk7DQo+ID4gPiA+ID4+ICsgICAgICAgICAgICBpbnRlcnZhbC5sb3cgPSBoaWdoICsg
MTsNCj4gPiA+ID4gPj4gKyAgICAgICAgICAgIHRyYWNlX3ZpcnRpb19pb21tdV91bm1hcF9sZWZ0
X2ludGVydmFsKGN1cnJlbnQubG93LA0KPiA+ID4gY3VycmVudC5oaWdoLA0KPiA+ID4gPiA+PiAr
ICAgICAgICAgICAgICAgIGludGVydmFsLmxvdywgaW50ZXJ2YWwuaGlnaCk7DQo+ID4gPiA+ID4+
ICsgICAgICAgIH0gZWxzZSBpZiAoaGlnaCA9PSBpbnRlcnZhbC5oaWdoICYmIHNpemUgPj0gbWFw
cGluZy0+c2l6ZSkgew0KPiA+ID4gPiA+PiArICAgICAgICAgICAgdHJhY2VfdmlydGlvX2lvbW11
X3VubWFwX3JpZ2h0X2ludGVydmFsKGN1cnJlbnQubG93LA0KPiA+ID4gY3VycmVudC5oaWdoLA0K
PiA+ID4gPiA+PiArICAgICAgICAgICAgICAgIGludGVydmFsLmxvdywgaW50ZXJ2YWwuaGlnaCk7
DQo+ID4gPiA+ID4+ICsgICAgICAgICAgICBnX3RyZWVfcmVtb3ZlKGRvbWFpbi0+bWFwcGluZ3Ms
IChncG9pbnRlcikoJmN1cnJlbnQpKTsNCj4gPiA+ID4gPj4gKyAgICAgICAgICAgIGludGVydmFs
LmhpZ2ggPSBsb3cgLSAxOw0KPiA+ID4gPiA+PiArICAgICAgICB9IGVsc2UgaWYgKGxvdyA+IGlu
dGVydmFsLmxvdyAmJiBoaWdoIDwgaW50ZXJ2YWwuaGlnaCkgew0KPiA+ID4gPiA+PiArICAgICAg
ICAgICAgdHJhY2VfdmlydGlvX2lvbW11X3VubWFwX2luY19pbnRlcnZhbChjdXJyZW50LmxvdywN
Cj4gPiA+IGN1cnJlbnQuaGlnaCk7DQo+ID4gPiA+ID4+ICsgICAgICAgICAgICBnX3RyZWVfcmVt
b3ZlKGRvbWFpbi0+bWFwcGluZ3MsIChncG9pbnRlcikoJmN1cnJlbnQpKTsNCj4gPiA+ID4gPj4g
KyAgICAgICAgfSBlbHNlIHsNCj4gPiA+ID4gPj4gKyAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4g
PiA+PiArICAgICAgICB9DQo+ID4gPiA+ID4+ICsgICAgICAgIGlmIChpbnRlcnZhbC5sb3cgPj0g
aW50ZXJ2YWwuaGlnaCkgew0KPiA+ID4gPiA+PiArICAgICAgICAgICAgcmV0dXJuIFZJUlRJT19J
T01NVV9TX09LOw0KPiA+ID4gPiA+PiArICAgICAgICB9IGVsc2Ugew0KPiA+ID4gPiA+PiArICAg
ICAgICAgICAgbWFwcGluZyA9IGdfdHJlZV9sb29rdXAoZG9tYWluLT5tYXBwaW5ncywNCj4gPiA+
IChncG9pbnRlcikoJmludGVydmFsKSk7DQo+ID4gPiA+ID4+ICsgICAgICAgIH0NCj4gPiA+ID4g
Pj4gKyAgICB9DQo+ID4gPiA+ID4+ICsNCj4gPiA+ID4gPj4gKyAgICBpZiAobWFwcGluZykgew0K
PiA+ID4gPiA+PiArICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCj4gPiA+
ID4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAiKioqKioqICVzOiBVbm1hcCAweCUiUFJJeDY0
IiBzaXplPTB4JSJQUkl4NjQNCj4gPiA+ID4gPj4gKyAgICAgICAgICAgICAgICAgICAgICIgZnJv
bSAweCUiUFJJeDY0IiBzaXplPTB4JSJQUkl4NjQiIGlzIG5vdCBzdXBwb3J0ZWRcbiIsDQo+ID4g
PiA+ID4+ICsgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgaW50ZXJ2YWwubG93LCBzaXpl
LA0KPiA+ID4gPiA+PiArICAgICAgICAgICAgICAgICAgICAgbWFwcGluZy0+dmlydF9hZGRyLCBt
YXBwaW5nLT5zaXplKTsNCj4gPiA+ID4gPj4gKyAgICB9IGVsc2Ugew0KPiA+ID4gPiA+PiArICAg
ICAgICByZXR1cm4gVklSVElPX0lPTU1VX1NfT0s7DQo+ID4gPiA+ID4+ICsgICAgfQ0KPiA+ID4g
PiA+PiArDQo+ID4gPiA+ID4+ICsgICAgcmV0dXJuIFZJUlRJT19JT01NVV9TX0lOVkFMOw0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gQ291bGQgdGhlIGFib3ZlIGNodW5rIGJlIHNpbXBsaWZpZWQgYXMg
c29tZXRoaW5nIGxpa2UgYmVsb3c/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgIHdoaWxlICgobWFw
cGluZyA9IGdfdHJlZV9sb29rdXAoZG9tYWluLT5tYXBwaW5ncywgJmludGVydmFsKSkpIHsNCj4g
PiA+ID4gPiAgICAgZ190cmVlX3JlbW92ZShkb21haW4tPm1hcHBpbmdzLCBtYXBwaW5nKTsNCj4g
PiA+ID4gPiAgIH0NCj4gPiA+ID4gSW5kZWVkIHRoZSBjb2RlIGNvdWxkIGJlIHNpbXBsaWZpZWQu
IEkgb25seSBuZWVkIHRvIG1ha2Ugc3VyZSBJIGRvbid0DQo+ID4gPiA+IHNwbGl0IGFuIGV4aXN0
aW5nIG1hcHBpbmcuDQo+ID4gPg0KPiA+ID4gSG1tLi4uIERvIHdlIG5lZWQgdG8gc3RpbGwgc3Bs
aXQgYW4gZXhpc3RpbmcgbWFwcGluZyBpZiBuZWNlc3Nhcnk/DQo+ID4gPiBGb3IgZXhhbXBsZSB3
aGVuIHdpdGggdGhpcyBtYXBwaW5nOg0KPiA+ID4NCj4gPiA+ICAgaW92YT0weDEwMDAsIHNpemU9
MHgyMDAwLCBwaHlzPUFERFIxLCBmbGFncz1GTEFHUzENCj4gPiA+DQo+ID4gPiBBbmQgaWYgd2Ug
d2FudCB0byB1bm1hcCB0aGUgcmFuZ2UgKGlvdmE9MCwgc2l6ZT0weDIwMDApLCB0aGVuIHdlDQo+
ID4gPiBzaG91bGQgc3BsaXQgdGhlIGV4aXN0aW5nIG1hcHBwaW5nIGFuZCBsZWF2ZSB0aGlzIG9u
ZToNCj4gPiA+DQo+ID4gPiAgIGlvdmE9MHgyMDAwLCBzaXplPTB4MTAwMCwgcGh5cz0oQUREUjEr
MHgxMDAwKSwgZmxhZ3M9RkxBR1MxDQo+ID4gPg0KPiA+ID4gUmlnaHQ/DQo+ID4gPg0KPiA+DQo+
ID4gdmlydGlvLWlvbW11IHNwZWMgZXhwbGljaXRseSBkaXNhbGxvd3MgcGFydGlhbCB1bm1hcC4N
Cj4gPg0KPiA+IDUuMTEuNi42LjEgRHJpdmVyIFJlcXVpcmVtZW50czogVU5NQVAgcmVxdWVzdA0K
PiA+DQo+ID4gVGhlIGZpcnN0IGFkZHJlc3Mgb2YgYSByYW5nZSBNVVNUIGVpdGhlciBiZSB0aGUg
Zmlyc3QgYWRkcmVzcyBvZiBhDQo+ID4gbWFwcGluZyBvciBiZSBvdXRzaWRlIGFueSBtYXBwaW5n
LiBUaGUgbGFzdCBhZGRyZXNzIG9mIGEgcmFuZ2UNCj4gPiBNVVNUIGVpdGhlciBiZSB0aGUgbGFz
dCBhZGRyZXNzIG9mIGEgbWFwcGluZyBvciBiZSBvdXRzaWRlIGFueQ0KPiA+IG1hcHBpbmcuDQo+
ID4NCj4gPiA1LjExLjYuNi4yIERldmljZSBSZXF1aXJlbWVudHM6IFVOTUFQIHJlcXVlc3QNCj4g
Pg0KPiA+IElmIGEgbWFwcGluZyBhZmZlY3RlZCBieSB0aGUgcmFuZ2UgaXMgbm90IGNvdmVyZWQg
aW4gaXRzIGVudGlyZXR5DQo+ID4gYnkgdGhlIHJhbmdlICh0aGUgVU5NQVAgcmVxdWVzdCB3b3Vs
ZCBzcGxpdCB0aGUgbWFwcGluZyksDQo+ID4gdGhlbiB0aGUgZGV2aWNlIFNIT1VMRCBzZXQgdGhl
IHJlcXVlc3Qgc3RhdHVzIHRvIFZJUlRJT19JT01NVQ0KPiA+IF9TX1JBTkdFLCBhbmQgU0hPVUxE
IE5PVCByZW1vdmUgYW55IG1hcHBpbmcuDQo+IA0KPiBJIHNlZSwgdGhhbmtzIEtldmluLg0KPiAN
Cj4gVGhvdWdoIHdoeSBzbyBzdHJpY3Q/ICAoU29ycnkgaWYgSSBtaXNzZWQgc29tZSBkaXNjdXNz
aW9ucw0KPiAuLi4gcG9pbnRlcnMgd2VsY29tZWQuLi4pDQo+IA0KPiBXaGF0IEknbSB0aGlua2lu
ZyBpcyB3aGVuIHdlIHdhbnQgdG8gYWxsb2NhdGUgYSBidW5jaCBvZiBidWZmZXJzDQo+IChlLmcu
LCAxTSkgd2hpbGUgd2Ugd2lsbCBhbHNvIG5lZWQgdG8gYmUgYWJsZSB0byBmcmVlIHRoZW0gd2l0
aA0KPiBzbWFsbGVyIGNodW5rcyAoZS5nLiwgNEspLCB0aGVuIGl0IHdvdWxkIGJlIGV2ZW4gYmV0
dGVyIHRoYXQgd2UgYWxsb3cNCj4gdG8gYWxsb2NhdGUgYSB3aG9sZSAxTSBidWZmZXIgd2l0aGlu
IHRoZSBndWVzdCBhbmQgbWFwIGl0IGFzIGEgd2hvbGUsDQo+IHRoZW4gd2UgY2FuIHNlbGVjdGl2
ZWx5IHVubWFwIHRoZSBwYWdlcyBhZnRlciB1c2VkLiAgSWYgd2l0aCB0aGUNCj4gc3RyaWN0IHJ1
bGUsIHdlJ2xsIG5lZWQgdG8gbWFwIG9uZSBieSBvbmUsIHRoYXQgY2FuIGJlIGEgdG90YWwgb2YN
Cj4gMU0vNEsgcm91bmR0cmlwcy4NCj4gDQoNClNvcnJ5IEkgZm9yZ290IHRoZSBvcmlnaW5hbCBk
aXNjdXNzaW9uLiBOZWVkIEplYW4gdG8gcmVzcG9uZC4gOi0pDQoNCkEgcG9zc2libGUgcmVhc29u
IGlzIHRoYXQgbm8gc3VjaCB1c2FnZSBleGlzdHMgdG9kYXksIHRodXMgc2ltcGxpZmljYXRpb24N
CndhcyBtYWRlPyANCg0KVGhhbmtzDQpLZXZpbg0K

