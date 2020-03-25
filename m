Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78A5C18E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7740320771
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7740320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2DG-0001pM-Kl
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jH2CW-0001PS-DW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jH2CU-00058j-8p
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:19:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:61183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jH2CT-00052y-40
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:19:50 -0400
IronPort-SDR: eX3pGINcU4COPFcDyBdBr2YDA96SEqSfVk2ucwZfXpIZPRN1bGj3FKt7kaSo1pC3q/TghSH+DI
 F0hhz6m2zf8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 02:19:45 -0700
IronPort-SDR: SVpkEtL6FQF9ihkm/7TmbdTES4u5cSE3X5XmrUP3NZxlVHQe7LhVjheklB4jM4H/VUHBQj4NvL
 XrlFsEUV38Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; d="scan'208";a="393570476"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 02:19:44 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 02:19:44 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 02:19:44 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.155]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 17:19:40 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 21/22] intel_iommu: process PASID-based Device-TLB
 invalidation
Thread-Topic: [PATCH v1 21/22] intel_iommu: process PASID-based Device-TLB
 invalidation
Thread-Index: AQHWAEW3SLxZzekg2UiXjepI51bQEKhXj4aAgAF819A=
Date: Wed, 25 Mar 2020 09:19:39 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A201D7B@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-22-git-send-email-yi.l.liu@intel.com>
 <20200324183611.GF127076@xz-x1>
In-Reply-To: <20200324183611.GF127076@xz-x1>
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
X-Received-From: 134.134.136.24
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

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMjUsIDIwMjAgMjozNiBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMjEvMjJdIGludGVsX2lvbW11OiBwcm9jZXNz
IFBBU0lELWJhc2VkIERldmljZS1UTEINCj4gaW52YWxpZGF0aW9uDQo+IA0KPiBPbiBTdW4sIE1h
ciAyMiwgMjAyMCBhdCAwNTozNjoxOEFNIC0wNzAwLCBMaXUgWWkgTCB3cm90ZToNCj4gPiBUaGlz
IHBhdGNoIGFkZHMgYW4gZW1wdHkgaGFuZGxpbmcgZm9yIFBBU0lELWJhc2VkIERldmljZS1UTEIN
Cj4gPiBpbnZhbGlkYXRpb24uIEZvciBub3cgaXQgaXMgZW5vdWdoIGFzIGl0IGlzIG5vdCBuZWNl
c3NhcnkgdG8gcHJvcGFnYXRlDQo+ID4gaXQgdG8gaG9zdCBmb3IgcGFzc3RocnUgZGV2aWNlIGFu
ZCBhbHNvIHRoZXJlIGlzIG5vIGVtdWxhdGVkIGRldmljZQ0KPiA+IGhhcyBkZXZpY2UgdGxiLg0K
PiA+DQo+ID4gQ2M6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KPiA+IENjOiBK
YWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiA+IENjOiBQZXRlciBY
dSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+ID4gQ2M6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50
ZWwuY29tPg0KPiA+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiA+
IENjOiBSaWNoYXJkIEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUubmV0Pg0KPiA+IENjOiBFZHVhcmRv
IEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGl1IFlp
IEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gDQo+IE9LIHRoaXMgcGF0Y2ggc2VlbXMgdG8gYmUg
bW9zdGx5IG1lYW5pbmdsZXNzLi4uIGJ1dCBPSyBzaW5jZSB5b3UndmUgd3JvdGUgaXQuLi4gOikN
Cj4gDQo+IFJldmlld2VkLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQoNClRoYW5r
cywNCllpIExpdQ0K

