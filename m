Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D722DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C58206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C58206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKO9l-0005h9-RA
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 11:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jKO8y-0004qg-Lr
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jKO8x-0005QF-Nn
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:22:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:56072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jKO8x-0005Ol-FT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:22:03 -0400
IronPort-SDR: hq3VITqG+DnF0B6jxoe238yKpTz1v2HjZPTgTxtBVT5ecaR6pYpFqLuangDwRJBjOGLbFP7kmw
 qTb4J+fwJOgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 08:22:01 -0700
IronPort-SDR: f18KJOPBARxqq+jwBPeF22qGTZqDi8tT7KRl4cyGw3aUNSWwhi8RIFvPhj7N/hlRGChUQsiQtX
 /woycPv2B0yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; d="scan'208";a="241145420"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga007.fm.intel.com with ESMTP; 03 Apr 2020 08:22:01 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 08:22:01 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 08:22:00 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.138]) with mapi id 14.03.0439.000;
 Fri, 3 Apr 2020 23:21:57 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v2 19/22] intel_iommu: process PASID-based iotlb
 invalidation
Thread-Topic: [PATCH v2 19/22] intel_iommu: process PASID-based iotlb
 invalidation
Thread-Index: AQHWBkplO1jjT6AjC0K+wjIyCHcvO6hm+tuAgACPoRA=
Date: Fri, 3 Apr 2020 15:21:56 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A220E5F@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-20-git-send-email-yi.l.liu@intel.com>
 <20200403144719.GL103677@xz-x1>
In-Reply-To: <20200403144719.GL103677@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.151
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXBy
aWwgMywgMjAyMCAxMDo0NyBQTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTkvMjJdIGludGVsX2lvbW11OiBwcm9jZXNzIFBB
U0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbg0KPiANCj4gT24gU3VuLCBNYXIgMjksIDIwMjAg
YXQgMDk6MjQ6NThQTSAtMDcwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRz
IHRoZSBiYXNpYyBQQVNJRC1iYXNlZCBpb3RsYiAocGlvdGxiKSBpbnZhbGlkYXRpb24NCj4gPiBz
dXBwb3J0LiBwaW90bGIgaXMgdXNlZCBkdXJpbmcgd2Fsa2luZyBJbnRlbCBWVC1kIDFzdCBsZXZl
bCBwYWdlDQo+ID4gdGFibGUuIFRoaXMgcGF0Y2ggb25seSBhZGRzIHRoZSBiYXNpYyBwcm9jZXNz
aW5nLiBEZXRhaWxlZCBoYW5kbGluZw0KPiA+IHdpbGwgYmUgYWRkZWQgaW4gbmV4dCBwYXRjaC4N
Cj4gPg0KPiA+IENjOiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPiBDYzog
SmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogUGV0ZXIg
WHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiA+IENjOiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4g
PiBDYzogUmljaGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lkZGxlLm5ldD4NCj4gPiBDYzogRWR1YXJk
byBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpdSBZ
aSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogUGV0ZXIgWHUgPHBl
dGVyeEByZWRoYXQuY29tPg0KPiANCnRoYW5rcyBmb3IgeW91ciBoZWxwLiA6LSkNCg0KUmVnYXJk
cywNCllpIExpdQ0K

