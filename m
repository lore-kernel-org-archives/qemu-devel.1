Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A31C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01723206A3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01723206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGQB-0001HR-8s
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSGPF-0000WX-KD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSGPD-0000MV-Ne
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:11:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:18817)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSGPD-0000LJ-Eb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:11:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 00:11:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="205251210"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga003.jf.intel.com with ESMTP; 06 Nov 2019 00:11:02 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 00:11:02 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 00:11:02 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.108]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 16:11:00 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v2 15/22] intel_iommu: bind/unbind guest page table to host
Thread-Topic: [RFC v2 15/22] intel_iommu: bind/unbind guest page table to host
Thread-Index: AQHVims5m/VTtt5x00GGBT23FJlhp6d7ATCAgALb2xA=
Date: Wed, 6 Nov 2019 08:10:59 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EEF4D@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-16-git-send-email-yi.l.liu@intel.com>
 <20191104202559.GA12619@xz-x1>
In-Reply-To: <20191104202559.GA12619@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDI4NGE3OWEtMGJmZi00MmVkLThlZTEtOWU5MzMzZjFkNTAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid1h5QXRGM1hcLzdOUHlNanlGUFYwbVprdWxBbzhhUnlKTG1KZmhjZEtXTk9tSGRqWlBRU1FlVTJNbUpSZm1rMnAifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBUdWVz
ZGF5LCBOb3ZlbWJlciA1LCAyMDE5IDQ6MjYgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyB2MiAxNS8yMl0gaW50ZWxfaW9tbXU6IGJp
bmQvdW5iaW5kIGd1ZXN0IHBhZ2UgdGFibGUgdG8gaG9zdA0KPiANCj4gT24gVGh1LCBPY3QgMjQs
IDIwMTkgYXQgMDg6MzQ6MzZBTSAtMDQwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gVGhpcyBwYXRj
aCBjYXB0dXJlcyB0aGUgZ3Vlc3QgUEFTSUQgdGFibGUgZW50cnkgbW9kaWZpY2F0aW9ucyBhbmQN
Cj4gPiBwcm9wYWdhdGVzIHRoZSBjaGFuZ2VzIHRvIGhvc3QgdG8gc2V0dXAgbmVzdGVkIHRyYW5z
bGF0aW9uLiBUaGUNCj4gPiBndWVzdCBwYWdlIHRhYmxlIGlzIGNvbmZpZ3VyZWQgYXMgMXN0IGxl
dmVsIHBhZ2UgdGFibGUgKEdWQS0+R1BBKQ0KPiA+IHdob3NlIHRyYW5zbGF0aW9uIHJlc3VsdCB3
b3VsZCBmdXJ0aGVyIGdvIHRocm91Z2ggaG9zdCBWVC1kIDJuZA0KPiA+IGxldmVsIHBhZ2UgdGFi
bGUoR1BBLT5IUEEpIHVuZGVyIG5lc3RlZCB0cmFuc2xhdGlvbiBtb2RlLiBUaGlzIGlzDQo+ID4g
YSBrZXkgcGFydCBvZiB2U1ZBIHN1cHBvcnQuDQo+ID4NCj4gPiBDYzogS2V2aW4gVGlhbiA8a2V2
aW4udGlhbkBpbnRlbC5jb20+DQo+ID4gQ2M6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51
eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiBD
YzogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvaTM4Ni9pbnRl
bF9pb21tdS5jICAgICAgICAgIHwgODENCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIwICsr
KysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4gPiBpbmRleCBkODgyN2M5Li43OTNiMGRlIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+IEBA
IC00MSw2ICs0MSw3IEBADQo+ID4gICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPiA+
ICAjaW5jbHVkZSAidHJhY2UuaCINCj4gPiAgI2luY2x1ZGUgInFlbXUvamhhc2guaCINCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L2lvbW11Lmg+DQo+ID4NCj4gPiAgLyogY29udGV4dCBlbnRyeSBvcGVy
YXRpb25zICovDQo+ID4gICNkZWZpbmUgVlREX0NFX0dFVF9SSUQyUEFTSUQoY2UpIFwNCj4gPiBA
QCAtNjk1LDYgKzY5NiwxNiBAQCBzdGF0aWMgaW5saW5lIHVpbnQxNl90DQo+IHZ0ZF9wZV9nZXRf
ZG9tYWluX2lkKFZURFBBU0lERW50cnkgKnBlKQ0KPiA+ICAgICAgcmV0dXJuIFZURF9TTV9QQVNJ
RF9FTlRSWV9ESUQoKHBlKS0+dmFsWzFdKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbmxp
bmUgdWludDMyX3QgdnRkX3BlX2dldF9mbF9hdyhWVERQQVNJREVudHJ5ICpwZSkNCj4gPiArew0K
PiA+ICsgICAgcmV0dXJuIDQ4ICsgKChwZS0+dmFsWzJdID4+IDIpICYgVlREX1NNX1BBU0lEX0VO
VFJZX0ZMUE0pICogOTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSBkbWFfYWRk
cl90IHZ0ZF9wZV9nZXRfZmxwdF9iYXNlKFZURFBBU0lERW50cnkgKnBlKQ0KPiA+ICt7DQo+ID4g
KyAgICByZXR1cm4gcGUtPnZhbFsyXSAmIFZURF9TTV9QQVNJRF9FTlRSWV9GTFBUUFRSOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW5saW5lIGJvb2wgdnRkX3BkaXJlX3ByZXNlbnQoVlRE
UEFTSUREaXJFbnRyeSAqcGRpcmUpDQo+ID4gIHsNCj4gPiAgICAgIHJldHVybiBwZGlyZS0+dmFs
ICYgMTsNCj4gPiBAQCAtMTg1MCw2ICsxODYxLDY3IEBAIHN0YXRpYyB2b2lkDQo+IHZ0ZF9jb250
ZXh0X2dsb2JhbF9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcykNCj4gPiAgICAgIHZ0ZF9p
b21tdV9yZXBsYXlfYWxsKHMpOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgdnRkX2Jp
bmRfZ3Vlc3RfcGFzaWQoSW50ZWxJT01NVVN0YXRlICpzLCBWVERCdXMgKnZ0ZF9idXMsDQo+ID4g
KyAgICAgICAgICAgIGludCBkZXZmbiwgaW50IHBhc2lkLCBWVERQQVNJREVudHJ5ICpwZSwgVlRE
UEFTSURPcCBvcCkNCj4gPiArew0KPiA+ICsjaWZkZWYgX19saW51eF9fDQo+ID4gKyAgICBWVERJ
T01NVUNvbnRleHQgKnZ0ZF9pYzsNCj4gPiArICAgIElPTU1VQ1RYRXZlbnREYXRhIGV2ZW50X2Rh
dGE7DQo+ID4gKyAgICBJT01NVUNUWFBBU0lEQmluZERhdGEgYmluZDsNCj4gPiArICAgIHN0cnVj
dCBpb21tdV9ncGFzaWRfYmluZF9kYXRhICpnX2JpbmRfZGF0YTsNCj4gPiArDQo+ID4gKyAgICB2
dGRfaWMgPSB2dGRfYnVzLT5kZXZfaWNbZGV2Zm5dOw0KPiA+ICsgICAgaWYgKCF2dGRfaWMpIHsN
Cj4gPiArICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgZ19iaW5k
X2RhdGEgPSBnX21hbGxvYzAoc2l6ZW9mKCpnX2JpbmRfZGF0YSkpOw0KPiA+ICsgICAgYmluZC5m
bGFnID0gMDsNCj4gPiArICAgIGdfYmluZF9kYXRhLT5mbGFncyA9IDA7DQo+ID4gKyAgICBnX2Jp
bmRfZGF0YS0+dnRkLmZsYWdzID0gMDsNCj4gPiArICAgIHN3aXRjaCAob3ApIHsNCj4gPiArICAg
IGNhc2UgVlREX1BBU0lEX0JJTkQ6DQo+ID4gKyAgICBjYXNlIFZURF9QQVNJRF9VUERBVEU6DQo+
ID4gKyAgICAgICAgZ19iaW5kX2RhdGEtPnZlcnNpb24gPSBJT01NVV9HUEFTSURfQklORF9WRVJT
SU9OXzE7DQo+ID4gKyAgICAgICAgZ19iaW5kX2RhdGEtPmZvcm1hdCA9IElPTU1VX1BBU0lEX0ZP
Uk1BVF9JTlRFTF9WVEQ7DQo+ID4gKyAgICAgICAgZ19iaW5kX2RhdGEtPmdwZ2QgPSB2dGRfcGVf
Z2V0X2ZscHRfYmFzZShwZSk7DQo+ID4gKyAgICAgICAgZ19iaW5kX2RhdGEtPmFkZHJfd2lkdGgg
PSB2dGRfcGVfZ2V0X2ZsX2F3KHBlKTsNCj4gPiArICAgICAgICBnX2JpbmRfZGF0YS0+aHBhc2lk
ID0gcGFzaWQ7DQo+ID4gKyAgICAgICAgZ19iaW5kX2RhdGEtPmdwYXNpZCA9IHBhc2lkOw0KPiA+
ICsgICAgICAgIGdfYmluZF9kYXRhLT5mbGFncyB8PSBJT01NVV9TVkFfR1BBU0lEX1ZBTDsNCj4g
PiArICAgICAgICBnX2JpbmRfZGF0YS0+dnRkLmZsYWdzID0NCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAoVlREX1NNX1BBU0lEX0VOVFJZX1NSRV9CSVQocGUtPnZhbFsyXSkgPyAx
IDogMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAoVlREX1NNX1BBU0lEX0VO
VFJZX0VBRkVfQklUKHBlLT52YWxbMl0pID8gMSA6IDApDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgKFZURF9TTV9QQVNJRF9FTlRSWV9QQ0RfQklUKHBlLT52YWxbMV0pID8gMSA6
IDApDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgKFZURF9TTV9QQVNJRF9FTlRS
WV9QV1RfQklUKHBlLT52YWxbMV0pID8gMSA6IDApDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgKFZURF9TTV9QQVNJRF9FTlRSWV9FTVRFX0JJVChwZS0+dmFsWzFdKSA/IDEgOiAw
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICB8IChWVERfU01fUEFTSURfRU5UUllf
Q0RfQklUKHBlLT52YWxbMV0pID8gMSA6IDApOw0KPiA+ICsgICAgICAgIGdfYmluZF9kYXRhLT52
dGQucGF0ID0gVlREX1NNX1BBU0lEX0VOVFJZX1BBVChwZS0+dmFsWzFdKTsNCj4gPiArICAgICAg
ICBnX2JpbmRfZGF0YS0+dnRkLmVtdCA9IFZURF9TTV9QQVNJRF9FTlRSWV9FTVQocGUtPnZhbFsx
XSk7DQo+ID4gKyAgICAgICAgYmluZC5mbGFnIHw9IElPTU1VX0NUWF9CSU5EX1BBU0lEOw0KPiA+
ICsgICAgICAgIGJyZWFrOw0KPiA+ICsNCj4gPiArICAgIGNhc2UgVlREX1BBU0lEX1VOQklORDoN
Cj4gPiArICAgICAgICBnX2JpbmRfZGF0YS0+Z3BnZCA9IDA7DQo+ID4gKyAgICAgICAgZ19iaW5k
X2RhdGEtPmFkZHJfd2lkdGggPSAwOw0KPiA+ICsgICAgICAgIGdfYmluZF9kYXRhLT5ocGFzaWQg
PSBwYXNpZDsNCj4gPiArICAgICAgICBiaW5kLmZsYWcgfD0gSU9NTVVfQ1RYX1VOQklORF9QQVNJ
RDsNCj4gPiArICAgICAgICBicmVhazsNCj4gPiArDQo+ID4gKyAgICBkZWZhdWx0Og0KPiA+ICsg
ICAgICAgIHByaW50ZigiVW5rbm93biBWVERQQVNJRE9wISFcbiIpOw0KPiANCj4gUGxlYXNlIGRv
bid0IHVzZSBwcmludGYoKS4uICBIZXJlIGFzc2VydCgpIHN1aXRzLg0KDQpXaWxsIGNvcnJlY3Qg
aXQuIFRoYW5rcy4NCg0KPiANCj4gPiArICAgICAgICBicmVhazsNCj4gPiArICAgIH0NCj4gPiAr
ICAgIGlmIChiaW5kLmZsYWcpIHsNCj4gDQo+IFdpbGwgdGhpcyBiZSB1bnRydWU/ICBJZiBub3Qs
IGFzc2VydCgpIHdvcmtzIHRvby4NCg0KeWVzLCBpdCBpcyBwb3NzaWJsZS4gSWYgYW4gdW5rbm93
biBWVERQQVNJRE9wLCB0aGVuIG5vIHN3aXRjaCBjYXNlDQp3aWxsIGluaXRpYXRlIGJpbmQuZmxh
Zy4NCg0KPiA+ICsgICAgICAgIGV2ZW50X2RhdGEuZXZlbnQgPSBJT01NVV9DVFhfRVZFTlRfUEFT
SURfQklORDsNCj4gPiArICAgICAgICBiaW5kLmRhdGEgPSBnX2JpbmRfZGF0YTsNCj4gPiArICAg
ICAgICBldmVudF9kYXRhLmRhdGEgPSAmYmluZDsNCj4gPiArICAgICAgICBpb21tdV9jdHhfZXZl
bnRfbm90aWZ5KCZ2dGRfaWMtPmlvbW11X2NvbnRleHQsICZldmVudF9kYXRhKTsNCj4gPiArICAg
IH0NCj4gPiArICAgIGdfZnJlZShnX2JpbmRfZGF0YSk7DQo+ID4gKyNlbmRpZg0KPiA+ICt9DQo+
ID4gKw0KPiA+ICAvKiBEbyBhIGNvbnRleHQtY2FjaGUgZGV2aWNlLXNlbGVjdGl2ZSBpbnZhbGlk
YXRpb24uDQo+ID4gICAqIEBmdW5jX21hc2s6IEZNIGZpZWxkIGFmdGVyIHNoaWZ0aW5nDQo+ID4g
ICAqLw0KPiA+IEBAIC0yNTI4LDEyICsyNjAwLDE3IEBAIHN0YXRpYyBnYm9vbGVhbiB2dGRfZmx1
c2hfcGFzaWQoZ3BvaW50ZXIga2V5LA0KPiBncG9pbnRlciB2YWx1ZSwNCj4gPiAgICAgICAgICAg
ICAgICAgIHBjX2VudHJ5LT5wYXNpZF9jYWNoZV9nZW4gPSBzLT5wYXNpZF9jYWNoZV9nZW47DQo+
ID4gICAgICAgICAgICAgICAgICBpZiAoIXZ0ZF9wYXNpZF9lbnRyeV9jb21wYXJlKCZwZSwgJnBj
X2VudHJ5LT5wYXNpZF9lbnRyeSkpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICBwY19lbnRy
eS0+cGFzaWRfZW50cnkgPSBwZTsNCj4gPiArICAgICAgICAgICAgICAgICAgICB2dGRfYmluZF9n
dWVzdF9wYXNpZChzLCB2dGRfYnVzLCBkZXZmbiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBhc2lkLCAmcGUsIFZURF9QQVNJRF9VUERBVEUpOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgIC8qDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICogVE9ETzogd2hl
biBwYXNpZC1iYXNlLWlvdGxiKHBpb3RsYikgaW5mcmFzdHJ1Y3R1cmUgaXMNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgKiByZWFkeSwgc2hvdWxkIGludmFsaWRhdGUgUUVNVSBwaW90bGIgdG9n
ZWh0ZXIgd2l0aCB0aGlzDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICogY2hhbmdlLg0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiA+ICAgICAgICAgICAgICAgICAgfQ0KPiA+ICsg
ICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICAgdnRkX2JpbmRfZ3Vlc3Rf
cGFzaWQocywgdnRkX2J1cywgZGV2Zm4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwYXNpZCwgTlVMTCwgVlREX1BBU0lEX1VOQklORCk7DQo+IA0KPiBQbGVhc2Ugc2Vl
IHRoZSByZXBseSBpbiB0aGUgb3RoZXIgdGhyZWFkIG9uIHZ0ZF9mbHVzaF9wYXNpZCgpLiAgSSd2
ZQ0KPiBmaWxsZWQgaW4gd2hlcmUgSSBmZWVsIGxpa2UgdGhpcyBVTkJJTkQgc2hvdWxkIGV4aXN0
LCBJIGZlZWwgbGlrZSB5b3VyDQo+IGN1cnJlbnQgY29kZSBjb3VsZCBtaXNzIHNvbWUgcGxhY2Vz
IHdoZXJlIHlvdSBzaG91bGQgdW5iaW5kIGJ1dCBkaWRuJ3QuDQoNCkkndmUgcmVwbGllZCBpbiB0
aGF0IHRocmVhZCByZWdhcmRzIHRvIHlvdXIgY29tbWVudHMuIE1heSB5b3UNCnJlY29uc2lkZXIg
aXQgaGVyZS4gSG9wZSwgaXQgc3VpdHMgd2hhdCB5b3UgdGhvdWdodC4gSWYgc3RpbGwNCnNvbWV0
aGluZyBtaXNzZWQsIHBscyBmZWVsIGZyZWUgdG8gcG9pbnQgb3V0Lg0KDQpSZWdhcmRzLA0KWWkg
TGl1DQo=

