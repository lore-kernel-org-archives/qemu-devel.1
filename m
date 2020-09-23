Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61C8C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C0D20739
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C0D20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKyZq-0006Aw-8p
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 02:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKyZ2-0005jy-AY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:47:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:50048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKyYz-0000nA-EX
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:47:40 -0400
IronPort-SDR: 7eWd9ZMQRbIipGG7o5UQVNp6gbyJA3zBOtb9Bf5EjfE2nHwBv7reB+NoRIO2FEoat9Bx97osRv
 tcaFoMd9dfOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="148548571"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="148548571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 23:47:30 -0700
IronPort-SDR: pQBjypFTtcYYeRq8yeYlgy2mSrdcyjfj2MwUNwqsQXSn2Ug4vT+g2W3dqzBxErE7YoX88/uXum
 KeJrnubj3zcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="291568158"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2020 23:47:29 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 23:47:29 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 14:47:27 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 14:47:27 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/4] net/colo-compare.c: Add secondary old packet detection
Thread-Topic: [PATCH 3/4] net/colo-compare.c: Add secondary old packet
 detection
Thread-Index: AQHWjZ19seEynVntl0mme3qawj1B1qlztugAgAHSdZA=
Date: Wed, 23 Sep 2020 06:47:27 +0000
Message-ID: <a46e87a6aa2b4237abb47f276b6ed97c@intel.com>
References: <20200918092203.20384-1-chen.zhang@intel.com>
 <20200918092203.20384-4-chen.zhang@intel.com>
 <a7b2e242-e19f-107c-7b72-0eea6eb300dc@cn.fujitsu.com>
In-Reply-To: <a7b2e242-e19f-107c-7b72-0eea6eb300dc@cn.fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=chen.zhang@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 02:47:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGkgWmhpamlhbiA8bGl6
aGlqaWFuQGNuLmZ1aml0c3UuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjIsIDIw
MjAgMjo0NyBQTQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgSmFz
b24gV2FuZw0KPiA8amFzb3dhbmdAcmVkaGF0LmNvbT47IHFlbXUtZGV2IDxxZW11LWRldmVsQG5v
bmdudS5vcmc+DQo+IENjOiBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDMvNF0gbmV0L2NvbG8tY29tcGFyZS5jOiBBZGQgc2Vjb25kYXJ5IG9s
ZCBwYWNrZXQNCj4gZGV0ZWN0aW9uDQo+IA0KPiANCj4gDQo+IE9uIDkvMTgvMjAgNToyMiBQTSwg
WmhhbmcgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVs
LmNvbT4NCj4gPg0KPiA+IERldGVjdCBxdWV1ZWQgc2Vjb25kYXJ5IHBhY2tldCB0byBzeW5jIFZN
IHN0YXRlIGluIHRpbWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBDaGVuIDxjaGVu
LnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIG5ldC9jb2xvLWNvbXBhcmUuYyB8IDI1
ICsrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9jb2xv
LWNvbXBhcmUuYyBiL25ldC9jb2xvLWNvbXBhcmUuYyBpbmRleA0KPiA+IDNiNzIzMDlkMDguLmY3
MjcxYjk3NmYgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2NvbG8tY29tcGFyZS5jDQo+ID4gKysrIGIv
bmV0L2NvbG8tY29tcGFyZS5jDQo+ID4gQEAgLTY0MSwxOSArNjQxLDI2IEBAIHZvaWQgY29sb19j
b21wYXJlX3VucmVnaXN0ZXJfbm90aWZpZXIoTm90aWZpZXINCj4gKm5vdGlmeSkNCj4gPiAgIHN0
YXRpYyBpbnQgY29sb19vbGRfcGFja2V0X2NoZWNrX29uZV9jb25uKENvbm5lY3Rpb24gKmNvbm4s
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDb21wYXJl
U3RhdGUgKnMpDQo+ID4gICB7DQo+ID4gLSAgICBHTGlzdCAqcmVzdWx0ID0gTlVMTDsNCj4gPiAt
DQo+ID4gLSAgICByZXN1bHQgPSBnX3F1ZXVlX2ZpbmRfY3VzdG9tKCZjb25uLT5wcmltYXJ5X2xp
c3QsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5jb21wYXJlX3Rp
bWVvdXQsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChHQ29tcGFyZUZ1
bmMpY29sb19vbGRfcGFja2V0X2NoZWNrX29uZSk7DQo+ID4gKyAgICBpZiAoIWdfcXVldWVfaXNf
ZW1wdHkoJmNvbm4tPnByaW1hcnlfbGlzdCkpIHsNCj4gTG9va3Mgd2UgZG9uJ3QgbmVlZCB0byBj
aGVjayBpc19lbXB0eQ0KDQpSZS1jaGVja2VkIGdsaWIgY29kZSwgaXQganVzdCBjaGVja2VkIHRo
ZSBxdWV1ZSByYXRoZXIgdGhhbiBpbnNpZGUgY29udGVudC4NCk1heWJlIGNoZWNrIGVtcHR5IGJl
Zm9yZSB0aGF0IHdpbGwgYmVuZWZpdCBwZXJmb3JtYW5jZS4NCg0KVGhhbmtzDQpaaGFuZyBDaGVu
DQoNCj4gDQo+ID4gKyAgICAgICAgaWYgKGdfcXVldWVfZmluZF9jdXN0b20oJmNvbm4tPnByaW1h
cnlfbGlzdCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcy0+Y29tcGFy
ZV90aW1lb3V0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChHQ29tcGFy
ZUZ1bmMpY29sb19vbGRfcGFja2V0X2NoZWNrX29uZSkpDQo+ID4gKyAgICAgICAgICAgIGdvdG8g
b3V0Ow0KPiA+ICsgICAgfQ0KPiA+DQo+ID4gLSAgICBpZiAocmVzdWx0KSB7DQo+ID4gLSAgICAg
ICAgLyogRG8gY2hlY2twb2ludCB3aWxsIGZsdXNoIG9sZCBwYWNrZXQgKi8NCj4gPiAtICAgICAg
ICBjb2xvX2NvbXBhcmVfaW5jb25zaXN0ZW5jeV9ub3RpZnkocyk7DQo+ID4gLSAgICAgICAgcmV0
dXJuIDA7DQo+ID4gKyAgICBpZiAoIWdfcXVldWVfaXNfZW1wdHkoJmNvbm4tPnNlY29uZGFyeV9s
aXN0KSkgew0KPiBEaXR0bw0KPiANCj4gVGhhbmtzDQo+ID4gKyAgICAgICAgaWYgKGdfcXVldWVf
ZmluZF9jdXN0b20oJmNvbm4tPnNlY29uZGFyeV9saXN0LA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZzLT5jb21wYXJlX3RpbWVvdXQsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKEdDb21wYXJlRnVuYyljb2xvX29sZF9wYWNrZXRfY2hlY2tfb25l
KSkNCj4gPiArICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAg
ICAgcmV0dXJuIDE7DQo+ID4gKw0KPiA+ICtvdXQ6DQo+ID4gKyAgICAvKiBEbyBjaGVja3BvaW50
IHdpbGwgZmx1c2ggb2xkIHBhY2tldCAqLw0KPiA+ICsgICAgY29sb19jb21wYXJlX2luY29uc2lz
dGVuY3lfbm90aWZ5KHMpOw0KPiA+ICsgICAgcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiAg
IC8qDQo+IA0KPiANCg0K

