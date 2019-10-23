Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB679CA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 06:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9CA2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 06:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9CA2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNAVD-0003iw-GI
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 02:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iNAUC-0002cT-Na
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 02:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iNAUA-0003rm-Ly
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 02:51:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:27428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iNAUA-0003ey-E9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 02:51:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 23:50:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,219,1569308400"; d="scan'208";a="372785812"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 22 Oct 2019 23:50:58 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 22 Oct 2019 23:50:58 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 22 Oct 2019 23:50:57 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.33]) with mapi id 14.03.0439.000;
 Wed, 23 Oct 2019 14:50:56 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
Thread-Topic: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
Thread-Index: AQHVhBTjxTqcvh6BcUahjVnjYn1+nKdk2kkAgALnuaA=
Date: Wed, 23 Oct 2019 06:50:55 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78062C3047@shsmsx102.ccr.corp.intel.com>
References: <20191016112209.9024-1-chen.zhang@intel.com>
 <20191016112209.9024-2-chen.zhang@intel.com>
 <dccc1c86-cc78-9136-ff47-3d7308c795ad@redhat.com>
In-Reply-To: <dccc1c86-cc78-9136-ff47-3d7308c795ad@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjg1YzhjMGYtMjMyYy00NDU5LWFmYWItMzc4NTVhYjU2ODM1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ2tiSnpWbFRpWmhsV1h4ZDA5NW5KN2RQZ2xDeW83cUpqOWtPNkFjOUdqUGVcL0FLa0VxdG9SdDJoSjdBNEc0Wk0ifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgPHBi
b256aW5pQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjIsIDIwMTkgMToy
NCBBTQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgSmFzb24gV2Fu
Zw0KPiA8amFzb3dhbmdAcmVkaGF0LmNvbT47IHFlbXUtZGV2IDxxZW11LWRldmVsQG5vbmdudS5v
cmc+DQo+IENjOiBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1JGQyBQQVRDSCAxLzRdIG5ldC9hd2QuYzogSW50cm9kdWNlIEFkdmFuY2VkIFdhdGNoIERv
Zw0KPiBtb2R1bGUgZnJhbWV3b3JrDQo+IA0KPiBPbiAxNi8xMC8xOSAxMzoyMiwgWmhhbmcgQ2hl
biB3cm90ZToNCj4gPiBGcm9tOiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4g
Pg0KPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlIGEgbmV3IG1vZHVsZSBuYW1lZCBBZHZhbmNlZCBX
YXRjaCBEb2csIGFuZA0KPiA+IGRlZmluZWQgdGhlIGlucHV0IGFuZCBvdXRwdXQgcGFyYW1ldGVy
LiBBV0QgdXNlIHN0YW5kYXJkIGNoYXJkZXYgYXMNCj4gPiB0aGUgd2F5IG9mIGNvbW11bmljYXRp
b25nIHdpdGggdGhlIG91dHNpZGUgd29ybGQuIERlbW8gY29tbWFuZDoNCj4gPiAtb2JqZWN0DQo+
ID4gYWR2YW5jZWQtDQo+IHdhdGNoZG9nLGlkPWhlYXJ0MSxzZXJ2ZXI9b24sYXdkX25vZGU9aDEs
bm90aWZpY2F0aW9uX25vZGU9aGUNCj4gPiBhcnRiZWF0MCxvcHRfc2NyaXB0PW9wdF9zY3JpcHRf
cGF0aCxpb3RocmVhZD1pb3RocmVhZDEscHVsc2VfaW50ZXJ2YWw9DQo+ID4gMTAwMCx0aW1lb3V0
PTUwMDANCj4gSXMgdGhlcmUgYSBzdGFuZGFyZCBvciBzcGVjaWZpY2F0aW9uIGZvciBob3cgdG8g
aW50ZXJhY3Qgd2l0aCB0aGlzPyAgSXMgdGhpcw0KPiBzb21ldGhpbmcgdGhhdCB3YXMgZGV2ZWxv
cGVkIGV4cGxpY2l0bHkgZm9yIHRoZXNlIHBhdGNoZXMsIG9yIGRpZCBpdCBleGlzdA0KPiBiZWZv
cmU/DQo+IA0KDQpIaSBQYW9sbywNCg0KVGhhbmtzIHlvdSBmb3IgeW91ciBhdHRlbnRpb24uDQpD
dXJyZW50IEFXRCBwYXRjaCBqdXN0IGFjY2VwdCBhbnkgaW5wdXQgYXMgdGhlIHNpZ25hbCB0byBy
ZWZyZXNoIHRoZSB3YXRjaGRvZyB0aW1lciwNCmFuZCB3ZSBjYW4gYWxzbyBtYWtlIGEgY2VydGFp
biBpbnRlcmFjdGl2ZSBwcm90b2NvbCBoZXJlLiBGb3IgdGhlIG91dHB1dCB1c2VyIGNhbiBwcmUt
d3JpdGUNCnNvbWUgY29tbWFuZCBvciBzb21lIG1lc3NhZ2VzIGluIHRoZSBBV0Qgb3B0LXNjcmlw
dC4gV2Ugbm90aWNlZCB0aGF0IHRoZXJlIGlzIG5vIHdheQ0KZm9yIFZNTSBjb21tdW5pY2F0ZSBk
aXJlY3RseSwgbWF5YmUgc29tZSBwZW9wbGUgdGhpbmsgd2UgZG9uJ3QgbmVlZCBzdWNoIHRoaW5n
cyh1cCBsYXllcg0Kc29mdHdhcmUgbGlrZSBvcGVuc3RhY2sgY2FuIGhhbmRsZSBpdCkuIEJ1dCB3
ZSBlbmdhZ2VkIHdpdGggcmVhbCBjdXN0b21lciBmb3VuZCB0aGF0IGluIHNvbWUgY2FzZXMsDQp0
aGV5IG5lZWQgYSBsaWdodHdlaWdodCBhbmQgZWZmaWNpZW50IG1lY2hhbmlzbSB0byBzb2x2ZSBz
b21lIHByYWN0aWNhbCBwcm9ibGVtcyhvcGVuc3RhY2sgaXMgdG9vIGhlYXZ5KS4NCkZvciBleGFt
cGxlIGluIENPTE8gKGh0dHBzOi8vd2lraS5xZW11Lm9yZy9GZWF0dXJlcy9DT0xPKS4NCldlIG5l
ZWQgaGVhcnRiZWF0IHNlcnZpY2UgdG8gZGV0ZWN0IHR3byBub2RlIHN0YXR1cywgY3VycmVudCBp
bXBsZW1lbnQgbmVlZCBhbm90aGVyIGFwcGxpY2F0aW9uDQpydW5uaW5nIGluIHRoZSBob3N0IHRv
IGRvIHRoaXMgam9iLCBpZiBmb3VuZCBpc3N1ZSBpdCB3aWxsIHNlbmQgbWVzc2FnZSB0byBsb2Nh
bCBRZW11IGJ5IHFtcCBjb21tYW5kLA0KVGhpcyBpcyB2ZXJ5IGNvbXBsaWNhdGVkIGluIGFjdHVh
bCBzY2VuYXJpb3MsIHdlIGhhdmUgdG8gYmluZCBlYWNoIGhlYXJ0YmVhdCBzZXJ2aWNlIHdpdGgN
CnRoZSBWTSBpbnN0YW5jZSBhbmQgaGFuZGxlIGxvdHMgb2YgaW50ZXJuYWwgZXJyb3JzLiBBZHZh
bmNlZCB3YXRjaCBkb2cgY2FuIHNvbHZlIHRoaXMgaXNzdWUgaW4gbW9zdCBjYXNlcy4NCkF0IHRo
ZSBzYW1lIHRpbWUsIEFXRCBhbHNvIGNhbiBiZSB1c2VkIGluIGEgdmFyaWV0eSBvZiBzY2VuYXJp
b3MsIGl0IGNhbiBhY3RpdmUgZGV0ZWN0IFFlbXUgc3RhdHVzIGFuZCANCmRvIHNvbWUgc2ltcGxl
IGF1dG9tYXRpYyBwcm9jZXNzaW5nIGZvciBleGFtcGxlIGtpbGwgaXRzZWxmIHdoZW4gaXQgbG9z
cyBjb250cm9sIHdpdGggb3BlbnN0YWNrKGp1c3QgbmVlZCBzaW1wbGUgcGFpcmVkIHNlcnZpY2Up
LiANCiANCg0KVGhhbmtzDQpaaGFuZyBDaGVuDQoNCj4gUGFvbG8NCg==

