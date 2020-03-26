Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF445C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 02:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC0120737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 02:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC0120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHHyq-000568-PL
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 22:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.hu@intel.com>) id 1jHHyF-0004cC-Si
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 22:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.hu@intel.com>) id 1jHHyD-0004lK-Vz
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 22:10:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:58975)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robert.hu@intel.com>) id 1jHHyD-0004ft-Mk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 22:10:09 -0400
IronPort-SDR: uW59+/N6nZISqvjdugOr1OObKRkdqQnOf1+5p8k28b+HNhdCx2gstuhM8+PAk4QXGJhvMoNszY
 vR2GMlhwEe9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 19:10:00 -0700
IronPort-SDR: MWIa4ocway2r++484TTaT704uqp5jacGRFxXUUAJ0Ir/qqfOutmI4NR1u2VRDjoA52f0UHWdE5
 5dozeFeUQZMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; d="scan'208";a="393819656"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 19:10:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 19:10:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Mar 2020 19:09:59 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 19:09:59 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.232]) with mapi id 14.03.0439.000;
 Thu, 26 Mar 2020 10:09:57 +0800
From: "Hu, Robert" <robert.hu@intel.com>
To: Eric Blake <eblake@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>
Subject: RE: [PATCH 2/2] util/bufferiszero: improve avx2 accelerator
Thread-Topic: [PATCH 2/2] util/bufferiszero: improve avx2 accelerator
Thread-Index: AQHWAnG3WhC4Os1eBEWng7pQnrt47ahYveoAgAFgeaA=
Date: Thu, 26 Mar 2020 02:09:57 +0000
Message-ID: <9E79D1C9A97CFD4097BCE431828FDD31178F147A@SHSMSX104.ccr.corp.intel.com>
References: <1585119021-46593-1-git-send-email-robert.hu@linux.intel.com>
 <1585119021-46593-2-git-send-email-robert.hu@linux.intel.com>
 <9eea6e9c-e35c-72e7-4574-7b9a6b72f9a7@redhat.com>
In-Reply-To: <9eea6e9c-e35c-72e7-4574-7b9a6b72f9a7@redhat.com>
Accept-Language: zh-CN, en-US
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
X-Received-From: 192.55.52.88
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KERvbid0IGtub3cgd2h5IG15IExpbnV4LUV2b2x1dGlvbiBtaXNzZWQgdGhpcyBtYWlsLikNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjUsIDIwMjAgMjA6NTQNCj4gVG86
IFJvYmVydCBIb28gPHJvYmVydC5odUBsaW51eC5pbnRlbC5jb20+OyBxZW11LWRldmVsQG5vbmdu
dS5vcmc7DQo+IHBib256aW5pQHJlZGhhdC5jb207IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5v
cmcNCj4gQ2M6IEh1LCBSb2JlcnQgPHJvYmVydC5odUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMi8yXSB1dGlsL2J1ZmZlcmlzemVybzogaW1wcm92ZSBhdngyIGFjY2VsZXJhdG9y
DQo+IA0KPiBPbiAzLzI1LzIwIDE6NTAgQU0sIFJvYmVydCBIb28gd3JvdGU6DQo+ID4gQnkgaW5j
cmVhc2luZyBhdngyIGxlbmd0aF90b19hY2NlbCB0byAxMjgsIHdlIGNhbiBzaW1wbGlmeSBpdHMg
bG9naWMNCj4gPiBhbmQgcmVkdWNlIGEgYnJhbmNoLg0KPiA+DQo+ID4gVGhlIGF1dGhvcnNoaXAg
b2YgdGhpcyBwYXRjaCBhY3R1YWxseSBiZWxvbmdzIHRvIFJpY2hhcmQgSGVuZGVyc29uDQo+ID4g
PHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+LA0KPiANCj4gTG9uZyBsaW5lOyBpdCdzIG5p
Y2UgdG8gd3JhcCBjb21taXQgbWVzc2FnZXMgYXJvdW5kIGNvbHVtbiA3MCBvciBzbyAoYmVjYXVz
ZQ0KPiByZWFkaW5nICdnaXQgbG9nJyBpbiBhbiA4MC1jb2x1bW4gd2luZG93IGFkZHMgaW5kZW50
YXRpb24pLg0KPiANCltIdSwgUm9iZXJ0XSANCkkgdGhpbmsgSSBzZXQgbXkgdmltIG9uIHdyYXAu
IFRoaXMgcHJvYmFibHkgZXNjYXBlZCBieSBwYXN0ZS4NCkkgcmFuIGNoZWNrcGF0Y2gucGwgb24g
dGhlIHBhdGNoZXMgYmVmb3JlIHNlbmRpbmcuIEl0IGVzY2FwZWQgY2hlY2sgYnV0IGRpZG4ndA0K
ZXNjYXBlZCB5b3VyIGVhZ2xlIGV5ZfCfmIogVGhhbmsgeW91Lg0KDQo+ID4gSSBqdXN0IGZpeCBh
IGJvdWRhcnkgY2FzZSBvbiBoaXMgb3JpZ2luYWwgcGF0Y2guDQo+IA0KPiBib3VuZGFyeQ0KW0h1
LCBSb2JlcnRdIA0KRW1tLi4uIGFnYWluIHNwZWxsIGVycm9yLiBVc3VhbGx5IEkgd291bGQgcGFz
dGUgZGVzY3JpcHRpb25zIGludG8gc29tZSBlZGl0b3JzDQp3aXRoIHNwZWxsIGNoZWNrLCBidXQg
Zm9yZ290IHRoaXMgdGltZS4NClZpbSBkb2Vzbid0IGhhdmUgc3BlbGwgY2hlY2sgSSB0aGluay4g
V2hhdCBlZGl0b3Igd291bGQgeW91IHN1Z2dlc3QgbWUgdG8NCmludGVncmF0ZSB3aXRoIGdpdCBl
ZGl0aW5nPw0KDQpCVFcsIGRvIEkgbmVlZCB0byByZXNlbmQgdGhlc2UgMiBwYXRjaGVzPw0KPiAN
Cj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0IEhvbyA8cm9iZXJ0Lmh1
QGxpbnV4LmludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHV0aWwvYnVmZmVyaXN6ZXJvLmMgfCAy
NiArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBFcmljIEJs
YWtlLCBQcmluY2lwYWwgU29mdHdhcmUgRW5naW5lZXINCj4gUmVkIEhhdCwgSW5jLiAgICAgICAg
ICAgKzEtOTE5LTMwMS0zMjI2DQo+IFZpcnR1YWxpemF0aW9uOiAgcWVtdS5vcmcgfCBsaWJ2aXJ0
Lm9yZw0KDQo=

