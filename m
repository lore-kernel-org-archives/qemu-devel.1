Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D9BC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9942178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9942178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGU5-0003PF-ID
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSGSr-0002TX-MP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSGSq-0001mV-MA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:14:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:43496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSGSq-0001m8-FA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:14:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 00:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="227407911"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2019 00:14:50 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 00:14:49 -0800
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 00:14:49 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.248]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 16:14:47 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v2 07/22] hw/pci: introduce pci_device_iommu_context()
Thread-Topic: [RFC v2 07/22] hw/pci: introduce pci_device_iommu_context()
Thread-Index: AQHVimss5m6QyXCJlkWMz4ReUQcoB6d2JCaAgAe7bJA=
Date: Wed, 6 Nov 2019 08:14:47 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EEF75@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-8-git-send-email-yi.l.liu@intel.com>
 <20191101180949.GH8888@xz-x1.metropole.lan>
In-Reply-To: <20191101180949.GH8888@xz-x1.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmE5YTI4NWYtYTAxZi00ZjJjLWJkMjItODU2OWYxZmMzMmU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQmphT2hSallcL0FnbU1EbEpYRktuK3hudTgzdVhxeW4zd0NWa2tTU3ArcmtvTE5XZjQ1M2xqNjJhdkV4Q2duQ1QifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: "tianyu.lan@intel.com" <tianyu.lan@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBTYXR1
cmRheSwgTm92ZW1iZXIgMiwgMjAxOSAyOjEwIEFNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1
QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgdjIgMDcvMjJdIGh3L3BjaTogaW50cm9k
dWNlIHBjaV9kZXZpY2VfaW9tbXVfY29udGV4dCgpDQo+IA0KPiBPbiBUaHUsIE9jdCAyNCwgMjAx
OSBhdCAwODozNDoyOEFNIC0wNDAwLCBMaXUgWWkgTCB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFk
ZHMgcGNpX2RldmljZV9pb21tdV9jb250ZXh0KCkgdG8gZ2V0IGFuIGlvbW11X2NvbnRleHQgZm9y
DQo+ID4gYSBnaXZlbiBkZXZpY2UuIEEgbmV3IGNhbGxiYWNrIGlzIGFkZGVkIGluIFBDSUlPTU1V
T3BzLiBVc2VycyB3aG8NCj4gPiB3YW50cyB0byBsaXN0ZW4gdG8gZXZlbnRzIGlzc3VlZCBieSB2
SU9NTVUgY291bGQgdXNlIHRoaXMgbmV3DQo+ID4gaW50ZXJmYWNlIHRvIGdldCBhbiBpb21tdV9j
b250ZXh0IGFuZCByZWdpc3RlciB0aGVpciBvd24gbm90aWZpZXJzLA0KPiA+IHRoZW4gd2FpdCBm
b3Igbm90aWZpY2F0aW9ucyBmcm9tIHZJT01NVS4gZS5nLiBWRklPIGlzIHRoZSBmaXJzdCB1c2Vy
DQo+ID4gb2YgaXQgdG8gbGlzdGVuIHRvIHRoZSBQQVNJRF9BTExPQy9QQVNJRF9CSU5EL0NBQ0hF
X0lOViBldmVudHMgYW5kDQo+ID4gcHJvcGFnYXRlIHRoZSBldmVudHMgdG8gaG9zdC4NCj4gPg0K
PiA+IENjOiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPiBDYzogSmFjb2Ig
UGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogUGV0ZXIgWHUgPHBl
dGVyeEByZWRoYXQuY29tPg0KPiA+IENjOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5j
b20+DQo+ID4gQ2M6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPiA+IENjOiBE
YXZpZCBHaWJzb24gPGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaXUgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBl
dGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpS
ZWdhcmRzLA0KWWkgTGl1DQo=

