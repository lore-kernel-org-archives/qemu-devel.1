Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E807C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF433217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF433217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJDC-0007hr-2K
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSJBE-00064I-Ky
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSJBD-0002DD-J1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:08:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:25380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSJBD-0002BX-BR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:08:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 03:08:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="232836361"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 03:08:50 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 03:08:49 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 03:08:49 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.149]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 19:08:47 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v2 05/22] vfio/common: add iommu_ctx_notifier in container
Thread-Topic: [RFC v2 05/22] vfio/common: add iommu_ctx_notifier in container
Thread-Index: AQHVimspAF8thUJhUUeOxjDX+6mnpqd17sgAgAghT/A=
Date: Wed, 6 Nov 2019 11:08:46 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EF188@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-6-git-send-email-yi.l.liu@intel.com>
 <20191101145848.GD8888@xz-x1.metropole.lan>
In-Reply-To: <20191101145848.GD8888@xz-x1.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjVmNzI5M2QtZWQ3Zi00OGYxLTg5NDUtMWE3MjdlZGRiYmZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMU00UVVnemVqUmJpYjVnc2REXC9mR1Z5SlhXRTJmVUJNWFFUSTJQVitXcGhVTllwUzZcL3VTTWpWNlBMVmdYSEF6In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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

PiBGcm9tOiBQZXRlciBYdQ0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDEsIDIwMTkgMTA6NTkg
UE0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1JGQyB2MiAwNS8yMl0gdmZpby9jb21tb246IGFkZCBpb21tdV9jdHhfbm90aWZpZXIgaW4gY29u
dGFpbmVyDQo+IA0KPiBPbiBUaHUsIE9jdCAyNCwgMjAxOSBhdCAwODozNDoyNkFNIC0wNDAwLCBM
aXUgWWkgTCB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPiA+ICt0eXBlZGVmIHN0cnVjdCBWRklP
SU9NTVVDb250ZXh0IHsNCj4gPiArICAgIFZGSU9Db250YWluZXIgKmNvbnRhaW5lcjsNCj4gPiAr
ICAgIElPTU1VQ29udGV4dCAqaW9tbXVfY3R4Ow0KPiA+ICsgICAgSU9NTVVDVFhOb3RpZmllciBu
Ow0KPiA+ICsgICAgUUxJU1RfRU5UUlkoVkZJT0lPTU1VQ29udGV4dCkgaW9tbXVfY3R4X25leHQ7
IH0gVkZJT0lPTU1VQ29udGV4dDsNCj4gPiArDQo+IA0KPiBObyBzdHJvbmcgb3BpbmlvbiBvbiB0
aGlzIC0gYnV0IGZvciBtZSBpdCB3b3VsZCBiZSBtb3JlIG1lYW5pbmdmdWwgdG8gc3F1YXNoIHRo
aXMNCj4gcGF0Y2ggaW50byB3aGVyZSB0aGlzIHN0cnVjdCBpcyBmaXJzdGx5IHVzZWQuDQoNCmdv
dCBpdC4gd2lsbCBtYWtlIGl0IGluIG5leHQgdmVyc2lvbi4NCg0KUmVnYXJkcywNCllpIExpdQ0K

