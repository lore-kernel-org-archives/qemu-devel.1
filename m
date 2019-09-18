Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E92FC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29EF214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29EF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVTX-0006BR-63
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iAVSa-0005k1-UK
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iAVSZ-0006N6-4C
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:37:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:57429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iAVSY-0006Js-TF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:37:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Sep 2019 01:37:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; d="scan'208";a="189201102"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga003.jf.intel.com with ESMTP; 18 Sep 2019 01:37:05 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Sep 2019 01:37:05 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.23]) with mapi id 14.03.0439.000;
 Wed, 18 Sep 2019 16:37:02 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>
Thread-Topic: [Qemu-devel] vhost, iova, and dirty page tracking
Thread-Index: AdVsLg/AAnCsYtAES/qfxc77B9v7gf//8I+A//3tsaCAA8b/gP/+jHxggAK7doD//1RiwA==
Date: Wed, 18 Sep 2019 08:37:02 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B90C@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
 <8302a4ae-1914-3046-b3b5-b3234d7dda02@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B1D1@SHSMSX104.ccr.corp.intel.com>
 <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
In-Reply-To: <6d73572e-1e89-b04a-bdd6-98ac73798083@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmY5YTczYWMtNDcyMy00MzBhLTkzODMtNGQxNzM4OTc4ZjNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYnlwK3MyK3FYN3VtZk1VXC9hcTl5b2RIQjFRcTRic0JLanBlV0t1cnVoVlpMVnNLcEx1djFLVFEzZGFOS3ZraUoifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
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
Cc: 'Alex Williamson' <alex.williamson@redhat.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gU2VudDog
V2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMTkgMjoxMCBQTQ0KPiANCj4gPj4NCj4gPj4gTm90
ZSB0aGF0IHRoZSBIVkEgdG8gR1BBIG1hcHBpbmcgaXMgbm90IGFuIDE6MSBtYXBwaW5nLiBPbmUg
SFZBDQo+IHJhbmdlDQo+ID4+IGNvdWxkIGJlIG1hcHBlZCB0byBzZXZlcmFsIEdQQSByYW5nZXMu
DQo+ID4gVGhpcyBpcyBmaW5lLiBDdXJyZW50bHkgdmZpb19kbWEgbWFpbnRhaW5zIElPVkEtPkhW
QSBtYXBwaW5nLg0KPiA+DQo+ID4gYnR3IHVuZGVyIHdoYXQgY29uZGl0aW9uIEhWQS0+R1BBIGlz
IG5vdCAxOjEgbWFwcGluZz8gSSBkaWRuJ3QgcmVhbGl6ZSBpdC4NCj4gDQo+IA0KPiBJIGRvbid0
IHJlbWVtYmVyIHRoZSBkZXRhaWxzIGUuZyBtZW1vcnkgcmVnaW9uIGFsaWFzPyBBbmQgbmVpdGhl
ciBrdm0NCj4gbm9yIGt2bSBBUEkgZG9lcyBmb3JiaWQgdGhpcyBpZiBteSBtZW1vcnkgaXMgY29y
cmVjdC4NCj4gDQoNCkkgY2hlY2tlZCBodHRwczovL3FlbXUud2VpbG5ldHouZGUvZG9jL2RldmVs
L21lbW9yeS5odG1sLCB3aGljaA0KcHJvdmlkZXMgYW4gZXhhbXBsZSBvZiBhbGlhc2VkIGxheW91
dC4gSG93ZXZlciwgaXRzIGFsaWFzaW5nIGlzIGFsbA0KMToxLCBpbnN0ZWFkIG9mIE46MS4gRnJv
bSBndWVzdCBwLm8udiBldmVyeSB3cml0YWJsZSBHUEEgaW1wbGllcyBhbg0KdW5pcXVlIGxvY2F0
aW9uLiBXaHkgd291bGQgd2UgaGl0IHRoZSBzaXR1YXRpb24gd2hlcmUgbXVsdGlwbGUNCndyaXRl
LWFibGUgR1BBcyBhcmUgbWFwcGVkIHRvIHRoZSBzYW1lIEhWQSAoaS5lLiBzYW1lIHBoeXNpY2Fs
DQptZW1vcnkgbG9jYXRpb24pPyBJcyBRZW11IGRvaW5nIGl0cyBvd24gc2FtZS1jb250ZW50IG1l
bW9yeQ0KbWVyZ2luZyBpbiBHUEEgbGV2ZWwsIHNpbWlsYXIgdG8gS1NNPw0KDQpUaGFua3MNCktl
dmluDQo=

