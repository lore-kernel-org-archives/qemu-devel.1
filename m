Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8364CC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463A82178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463A82178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGV7-0004WS-Gv
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSGTa-0003Mf-O6
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSGTZ-0002A1-1w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:15:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:60088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSGTY-00027X-OH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:15:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 00:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="200634902"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga008.fm.intel.com with ESMTP; 06 Nov 2019 00:15:35 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 00:15:35 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 00:15:35 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.2]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 16:15:32 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v2 06/22] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
Thread-Topic: [RFC v2 06/22] hw/pci: modify pci_setup_iommu() to set
 PCIIOMMUOps
Thread-Index: AQHVimsrLg5zO45FAU+j+AEc4se2MKd2JAeAgAe7wGA=
Date: Wed, 6 Nov 2019 08:15:31 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EEF96@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-7-git-send-email-yi.l.liu@intel.com>
 <20191101180923.GG8888@xz-x1.metropole.lan>
In-Reply-To: <20191101180923.GG8888@xz-x1.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTljOGNkYzYtZjRlNS00ODViLWFmZGEtNGEyMzY5YTUzOTg1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibEoyYzl2SWEyQ2FcL3RhNHBRenNJMk9EZGJwRW5xSnBzV202Wm1lNVBzTUorMnVyK1FCSVA3bjBMWUV4N2pmUDMifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
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
cmRheSwgTm92ZW1iZXIgMiwgMjAxOSAyOjA5IEFNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1
QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgdjIgMDYvMjJdIGh3L3BjaTogbW9kaWZ5
IHBjaV9zZXR1cF9pb21tdSgpIHRvIHNldCBQQ0lJT01NVU9wcw0KPiANCj4gT24gVGh1LCBPY3Qg
MjQsIDIwMTkgYXQgMDg6MzQ6MjdBTSAtMDQwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gVGhpcyBw
YXRjaCBtb2RpZmllcyBwY2lfc2V0dXBfaW9tbXUoKSB0byBzZXQgUENJSU9NTVVPcHMgaW5zdGVh
ZCBvZg0KPiA+IG9ubHkgc2V0dGluZyBQQ0lJT01NVUZ1bmMuIFBDSUlPTU1VRnVuYyBpcyBwcmV2
aW91c2x5IHVzZWQgdG8gZ2V0IGFuDQo+ID4gYWRkcmVzcyBzcGFjZSBmb3IgYSBkZXZpY2UgaW4g
dmVuZG9yIHNwZWNpZmljIHdheS4gVGhlIFBDSUlPTU1VT3BzDQo+ID4gc3RpbGwgb2ZmZXJzIHRo
aXMgZnVuY3Rpb25hbGl0eS4gVXNlIFBDSUlPTU1VT3BzIGxlYXZlcyBzcGFjZSB0byBhZGQNCj4g
PiBtb3JlIGlvbW11IHJlbGF0ZWQgdmVuZG9yIHNwZWNpZmljIG9wZXJhdGlvbnMuDQo+ID4NCj4g
PiBDYzogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+ID4gQ2M6IEphY29iIFBh
biA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFBldGVyIFh1IDxwZXRl
cnhAcmVkaGF0LmNvbT4NCj4gPiBDYzogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29t
Pg0KPiA+IENjOiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogRGF2
aWQgR2lic29uIDxkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU+DQo+ID4gU2lnbmVkLW9mZi1i
eTogTGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBQZXRl
ciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KUmVn
YXJkcywNCllpIExpdQ0K

