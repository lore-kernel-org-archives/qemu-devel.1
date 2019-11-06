Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D1CC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F68B206A3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F68B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGT2-0002Sh-DK
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSGSP-00021c-AG
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSGSO-0001Xg-8M
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:14:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:41748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSGSO-0001X3-0W
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:14:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 00:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="205252047"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga003.jf.intel.com with ESMTP; 06 Nov 2019 00:14:21 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 00:14:21 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.213]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 16:14:19 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v2 12/22] intel_iommu: add present bit check for pasid
 table entries
Thread-Topic: [RFC v2 12/22] intel_iommu: add present bit check for pasid
 table entries
Thread-Index: AQHVims04dTSFqLNz0S2LC9QARGUe6d3mAmAgAZHUHA=
Date: Wed, 6 Nov 2019 08:14:19 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EEF68@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-13-git-send-email-yi.l.liu@intel.com>
 <20191102162051.GB26023@xz-x1.metropole.lan>
In-Reply-To: <20191102162051.GB26023@xz-x1.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDc2MDg5Y2YtNzU4NS00ODBhLTg1YTQtZWI4YWNjYmYyOWJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTTJHSTJRMlNZWmczaEdRbml4NEpMNUdqS0c4ZHUwZjdxWUpwcXZBaE1lUWtTVE9LQzhSWHhIeW1sY1NGTzBCQSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBTdW5k
YXksIE5vdmVtYmVyIDMsIDIwMTkgMTI6MjEgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyB2MiAxMi8yMl0gaW50ZWxfaW9tbXU6IGFk
ZCBwcmVzZW50IGJpdCBjaGVjayBmb3IgcGFzaWQgdGFibGUNCj4gZW50cmllcw0KPiANCj4gT24g
VGh1LCBPY3QgMjQsIDIwMTkgYXQgMDg6MzQ6MzNBTSAtMDQwMCwgTGl1IFlpIEwgd3JvdGU6DQo+
ID4gVGhlIHByZXNlbnQgYml0IGNoZWNrIGZvciBwYXNpZCBlbnRyeSAocGUpIGFuZCBwYXNpZCBk
aXJlY3RvcnkgZW50cnkNCj4gPiAocGRpcmUpIHdlcmUgbWlzc2VkIGluIHByZXZpb3VzIGNvbW1p
dHMgYXMgZnBkIGJpdCBjaGVjayBkb2Vzbid0DQo+ID4gcmVxdWlyZSBwcmVzZW50IGJpdCBhcyAi
U2V0Ii4gVGhpcyBwYXRjaCBhZGRzIHRoZSBwcmVzZW50IGJpdCBjaGVjaw0KPiA+IGZvciBjYWxs
ZXJzIHdoaWNoIHdhbnRzIHRvIGdldCBhIHZhbGlkIHBlL3BkaXJlLg0KPiA+DQo+ID4gQ2M6IEtl
dmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KPiA+IENjOiBKYWNvYiBQYW4gPGphY29i
Lmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiA+IENjOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhh
dC5jb20+DQo+ID4gQ2M6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+IA0KPiBSZXZpZXdl
ZC1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KDQpUaGFua3MgZm9yIHRoZSByZXZp
ZXcuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==

