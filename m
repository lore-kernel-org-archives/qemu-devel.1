Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782BAC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 08:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4553F207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 08:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BdMcrlE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4553F207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8gZN-0007Ne-DL
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 04:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8gYV-0006uN-HF
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8gYU-0002QD-3y
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:03:47 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:24847)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i8gYT-0002PY-R9
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568361825;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uRauKbkGlmg8fwk+PXf7FxlWKRPNEQq0noEt4O9Iw9o=;
 b=BdMcrlE52i60Iuyhc+ndqGxKjgEp6QOKQ/R92Eh/DRHoG5Tgi08BPmX4
 en0w0+BtDLfn52eqacMsl4zU5ixztQE6GGe+w7OmLlgMhBfJE4vcF+1hY
 Dwy4XQ1ceFC5Xc2eTTm6BZlLCp+fBQC0uV9/mC/8FY8VVUDLVcNV8PXuV Y=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: w89N7k8+icj9p0L5rStHYiIeCYj8z5VaZaHdHvupfkM94Nf26OsFN+ya4oeLIOmxFI8rLPH/+s
 psvLSGkP0l6Bs+e6lfQEu33fJH1atQMObOaFPZeHblJdg70yPN9FSrkbfhvNjiy3iEmr4I0vlD
 D9dlj7hJFqO/LY7/WnBj8byDvjdAJExE16pCqpi7CSr67A2tlVJXxr/FtapXKs7+K6/UIuuOm8
 GEsvH5/pKVJdnvGo019h5dgsN1MKVoNLCqs3NZS/Z65+rxJZ2c3dSFkhoXKn2nxU7xKQ8k1GuR
 mt4=
X-SBRS: 2.7
X-MesageID: 5722127
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,500,1559534400"; 
   d="scan'208";a="5722127"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Paul Durrant <Paul.Durrant@citrix.com>, Anthony Perard
 <anthony.perard@citrix.com>
Thread-Topic: [PATCH v2 3/3] xen: perform XenDevice clean-up in XenBus watch
 handler
Thread-Index: AQHVaWP1a6uo9FDbNkeviSOLMWhOMKcoAmKAgAAj/tCAARiygA==
Date: Fri, 13 Sep 2019 08:03:40 +0000
Message-ID: <9c03c1ba9c1d4c1bb5d8b5a38cbca3de@AMSPEX02CL03.citrite.net>
References: <20190912121646.29148-1-paul.durrant@citrix.com>
 <20190912121646.29148-4-paul.durrant@citrix.com>
 <20190912150417.GD1308@perard.uk.xensource.com>
 <c71d01fbe7ab46d78992fe30fd2e550d@AMSPEX02CL03.citrite.net>
In-Reply-To: <c71d01fbe7ab46d78992fe30fd2e550d@AMSPEX02CL03.citrite.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.168
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen: perform XenDevice clean-up in
 XenBus watch handler
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
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYZW4tZGV2ZWwgPHhlbi1kZXZl
bC1ib3VuY2VzQGxpc3RzLnhlbnByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgUGF1bCBEdXJyYW50
DQo+IFNlbnQ6IDEyIFNlcHRlbWJlciAyMDE5IDE2OjE2DQo+IFRvOiBBbnRob255IFBlcmFyZCA8
YW50aG9ueS5wZXJhcmRAY2l0cml4LmNvbT4NCj4gQ2M6IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9q
ZWN0Lm9yZzsgU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPjsgcWVt
dS1kZXZlbEBub25nbnUub3JnDQo+IFN1YmplY3Q6IFJlOiBbWGVuLWRldmVsXSBbUEFUQ0ggdjIg
My8zXSB4ZW46IHBlcmZvcm0gWGVuRGV2aWNlIGNsZWFuLXVwIGluIFhlbkJ1cyB3YXRjaCBoYW5k
bGVyDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQW50aG9u
eSBQRVJBUkQgPGFudGhvbnkucGVyYXJkQGNpdHJpeC5jb20+DQo+ID4gU2VudDogMTIgU2VwdGVt
YmVyIDIwMTkgMTY6MDQNCj4gPiBUbzogUGF1bCBEdXJyYW50IDxQYXVsLkR1cnJhbnRAY2l0cml4
LmNvbT4NCj4gPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyB4ZW4tZGV2ZWxAbGlzdHMueGVu
cHJvamVjdC5vcmc7IFN0ZWZhbm8gU3RhYmVsbGluaQ0KPiA8c3N0YWJlbGxpbmlAa2VybmVsLm9y
Zz4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10geGVuOiBwZXJmb3JtIFhlbkRldmlj
ZSBjbGVhbi11cCBpbiBYZW5CdXMgd2F0Y2ggaGFuZGxlcg0KPiA+DQo+ID4gT24gVGh1LCBTZXAg
MTIsIDIwMTkgYXQgMDE6MTY6NDZQTSArMDEwMCwgUGF1bCBEdXJyYW50IHdyb3RlOg0KPiA+ID4g
Q2xlYW5pbmcgdXAgb2ZmaW5lIFhlbkRldmljZSBvYmplY3RzIGRpcmVjdGx5IGluDQo+ID4gICAg
ICAgICAgICAgICBeIG9mZmxpbmUNCj4gPg0KPiA+ID4geGVuX2RldmljZV9iYWNrZW5kX2NoYW5n
ZWQoKSBpcyBkYW5nZXJvdXMgYXMgeGVuX2RldmljZV91bnJlYWxpemUoKSB3aWxsDQo+ID4gPiBt
b2RpZnkgdGhlIHdhdGNoIGxpc3QgdGhhdCBpcyBiZWluZyB3YWxrZWQuIEV2ZW4gdGhlIFFMSVNU
X0ZPUkVBQ0hfU0FGRSgpDQo+ID4gPiB1c2VkIGluIG5vdGlmaWVyX2xpc3Rfbm90aWZ5KCkgaXMg
aW5zdWZmaWNpZW50IGFzICp0d28qIG5vdGlmaWVycyAoZm9yDQo+ID4gPiB0aGUgZnJvbnRlbmQg
YW5kIGJhY2tlbmQgd2F0Y2hlcykgYXJlIHJlbW92ZWQsIHRodXMgcG90ZW50aWFsbHkgcmVuZGVy
aW5nDQo+ID4gPiB0aGUgJ25leHQnIHBvaW50ZXIgdW5zYWZlLg0KPiA+ID4NCj4gPiA+IFRoZSBz
b2x1dGlvbiBpcyB0byB1c2UgdGhlIFhlbkJ1cyBiYWNrZW5kX3dhdGNoIGhhbmRsZXIgdG8gZG8g
dGhlIGNsZWFuLXVwDQo+ID4gPiBpbnN0ZWFkLCBhcyBpdCBpcyBpbnZva2VkIHdoaWxzdCB3YWxr
aW5nIGEgc2VwYXJhdGUgd2F0Y2ggbGlzdC4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIHRoZXJl
Zm9yZSBhZGRzIGEgbmV3ICdvZmZsaW5lX2RldmljZXMnIGxpc3QgdG8gWGVuQnVzLCB0byB3aGlj
aA0KPiA+ID4gb2ZmbGluZSBkZXZpY2VzIGFyZSBhZGRlZCBieSB4ZW5fZGV2aWNlX2JhY2tlbmRf
Y2hhbmdlZCgpLiBUaGUgWGVuQnVzDQo+ID4gPiBiYWNrZW5kX3dhdGNoIHJlZ2lzdHJhdGlvbiBp
cyBhbHNvIGNoYW5nZWQgdG8gbm90IG9ubHkgaW52b2tlDQo+ID4gPiB4ZW5fYnVzX2VudW1lcmF0
ZSgpIGJ1dCBhbHNvIGEgbmV3IHhlbl9idXNfY2xlYW51cCgpIGZ1bmN0aW9uLCB3aGljaCB3aWxs
DQo+ID4gPiB3YWxrICdvZmZsaW5lX2RldmljZXMnIGFuZCBwZXJmb3JtIHRoZSBuZWNlc3Nhcnkg
YWN0aW9ucy4NCj4gPiA+IEZvciBzYWZldHkgYSBhbiBleHRyYSAnb25saW5lJyBjaGVjayBpcyBh
bHNvIGFkZGVkIHRvDQo+ID4gICAgICAgICAgICAgIF4gb25lICdhJyB0b28gbWFueT8NCj4gPg0K
PiA+ID4geGVuX2J1c190eXBlX2VudW1lcmF0ZSgpIHRvIG1ha2Ugc3VyZSB0aGF0IG5vIGF0dGVt
cHQgaXMgbWFkZSB0byBjcmVhdGUgYQ0KPiA+ID4gbmV3IFhlbkRldmljZSBvYmplY3QgZm9yIGEg
YmFja2VuZCB0aGF0IGlzIG9mZmxpbmUuDQo+ID4gPg0KPiA+ID4gTk9URTogVGhpcyBwYXRjaCBh
bHNvIGluY2x1ZGUgc29tZSBjb3NtZXRpYyBjaGFuZ2VzOg0KPiA+ID4gICAgICAgLSBzdWJzdGl0
dXRlIHRoZSBsb2NhbCB2YXJpYWJsZSBuYW1lICdiYWNrZW5kX3N0YXRlJw0KPiA+ID4gICAgICAg
ICBpbiB4ZW5fYnVzX3R5cGVfZW51bWVyYXRlKCkgd2l0aCAnc3RhdGUnLCBzaW5jZSB0aGVyZQ0K
PiA+ID4gICAgICAgICBpcyBubyBhbWJpZ3VpdHkgd2l0aCBhbnkgb3RoZXIgc3RhdGUgaW4gdGhh
dCBjb250ZXh0Lg0KPiA+ID4gICAgICAgLSBjaGFuZ2UgeGVuX2RldmljZV9zdGF0ZV9pc19hY3Rp
dmUoKSB0bw0KPiA+ID4gICAgICAgICB4ZW5fZGV2aWNlX2Zyb250ZW5kX2lzX2FjdGl2ZSgpIChh
bmQgcGFzcyBhIFhlbkRldmljZSBkaXJlY3RseSkNCj4gPiA+ICAgICAgICAgc2luY2UgdGhlIHN0
YXRlIHRlc3RzIGNvbnRhaW5lZCB0aGVyZWluIG9ubHkgYXBwbHkgdG8gYSBmcm9udGVuZC4NCj4g
PiA+ICAgICAgIC0gdXNlICdzdGF0ZScgcmF0aGVyIHRoZW4gJ3hlbmRldi0+YmFja2VuZF9zdGF0
ZScgaW4NCj4gPiA+ICAgICAgICAgeGVuX2RldmljZV9iYWNrZW5kX2NoYW5nZWQoKSB0byBzaG9y
dGVuIHRoZSBjb2RlLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBhdWwgRHVycmFudCA8
cGF1bC5kdXJyYW50QGNpdHJpeC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+DQo+ID4gPiB2MjoNCj4g
PiA+ICAtIE1ha2Ugc3VyZSB3ZSBkb24ndCB0cnkgdG8gYWRkIGEgWGVuRGV2aWNlIHRvICdvZmZs
aW5lX2RldmljZXMnIG1vcmUgdGhhbg0KPiA+ID4gICAgb25jZQ0KPiA+ID4gLS0tDQo+ID4gPg0K
PiA+ID4gICAgICAvKg0KPiA+ID4gICAgICAgKiBJZiBhIGJhY2tlbmQgaXMgc3RpbGwgJ29ubGlu
ZScgdGhlbiB3ZSBzaG91bGQgbGVhdmUgaXQgYWxvbmUgYnV0LA0KPiA+ID4gLSAgICAgKiBpZiBh
IGJhY2tlbmQgaXMgbm90ICdvbmxpbmUnLCB0aGVuIHRoZSBkZXZpY2Ugc2hvdWxkIGJlIGRlc3Ry
b3llZA0KPiA+ID4gLSAgICAgKiBvbmNlIHRoZSBzdGF0ZSBpcyBDbG9zZWQuDQo+ID4gPiArICAg
ICAqIGlmIGEgYmFja2VuZCBpcyBub3QgJ29ubGluZScsIHRoZW4gdGhlIGRldmljZSBpcyBhIGNh
bmRpZGF0ZQ0KPiA+ID4gKyAgICAgKiBmb3IgZGVzdHJ1Y3Rpb24uIEhlbmNlIGFkZCBpdCB0byB0
aGUgJ29mZmxpbmUnIGxpc3QgdG8gYmUgY2xlYW5lZA0KPiA+ID4gKyAgICAgKiBieSB4ZW5fYnVz
X2NsZWFudXAoKS4NCj4gPiA+ICAgICAgICovDQo+ID4gPiAtICAgIGlmICgheGVuZGV2LT5iYWNr
ZW5kX29ubGluZSAmJg0KPiA+ID4gLSAgICAgICAgKHhlbmRldi0+YmFja2VuZF9zdGF0ZSA9PSBY
ZW5idXNTdGF0ZUNsb3NlZCB8fA0KPiA+ID4gLSAgICAgICAgIHhlbmRldi0+YmFja2VuZF9zdGF0
ZSA9PSBYZW5idXNTdGF0ZUluaXRpYWxpc2luZyB8fA0KPiA+ID4gLSAgICAgICAgIHhlbmRldi0+
YmFja2VuZF9zdGF0ZSA9PSBYZW5idXNTdGF0ZUluaXRXYWl0IHx8DQo+ID4gPiAtICAgICAgICAg
eGVuZGV2LT5iYWNrZW5kX3N0YXRlID09IFhlbmJ1c1N0YXRlVW5rbm93bikpIHsNCj4gPiA+IC0g
ICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiA+ID4gKyAgICBpZiAoIW9ubGluZSAm
Jg0KPiA+ID4gKyAgICAgICAgKHN0YXRlID09IFhlbmJ1c1N0YXRlQ2xvc2VkIHx8ICBzdGF0ZSA9
PSBYZW5idXNTdGF0ZUluaXRpYWxpc2luZyB8fA0KPiA+ID4gKyAgICAgICAgIHN0YXRlID09IFhl
bmJ1c1N0YXRlSW5pdFdhaXQgfHwgc3RhdGUgPT0gWGVuYnVzU3RhdGVVbmtub3duKSAmJg0KPiA+
ID4gKyAgICAgICAgIVFMSVNUX05FWFQoeGVuZGV2LCBsaXN0KSkgew0KPiA+DQo+ID4gQ291bGQg
eW91IGFkZCBhIG5vdGUgYWJvdXQgdGhpcyBRTElTVF9ORVhUPyBJIGRvbid0IHRoaW5rIGl0J3Mg
Z29pbmcgdG8NCj4gPiBiZSBvYnZpb3VzIGVub3VnaCB3aHkgd2UgY2hlY2sgdGhhdCB0aGVyZSBh
cmUgbm8gbmV4dCBpdGVtLiBJIG1pZ2h0IG9ubHkNCj4gPiB1bmRlcnN0YW5kIGl0IGp1c3QgYmVj
YXVzZSBvZiB5b3VyIHJlcGx5IHRvIHRoZSB2MSBvZiB0aGUgcGF0Y2guDQo+ID4gKFdlbGwgdGhl
IGNoYW5nZWxvZyBvZiB0aGUgcGF0Y2ggYWxzbyBwb2ludCBvdXQgd2hhdCBpdCdzIGZvci4pDQo+
ID4NCj4gDQo+IFN1cmUsIGl0J3Mgd29ydGggYSBjb21tZW50Lg0KDQpBY3R1YWxseSwgb24gY2xv
c2VyIGluc3BlY3Rpb24gIVFMSVNUX05FWFQoKSBpcyBhbiBpbnN1ZmZpY2llbnQgY2hlY2tlZC4g
SSBoYWQgYXNzdW1lZCB0aGF0IFFMSVNUcyB3ZXJlIGZ1bGwgZG91Ymx5LWxpbmtlZCBsaXN0cyBi
dXQgdGhleSBhcmUgbm90OyB0aGUgbGFzdCBlbGVtZW50IG9uIGEgbGlzdCB3aWxsIHN0aWxsIGhh
dmUgYSBOVUxMIG5leHQgcG9pbnRlci4gSXQgd2lsbCBiZSBzdWZmaWNpZW50LCBhbmQgYWxzbyBj
bGVhcmVyIHRvIHRoZSByZWFkZXIsIGlmIEkgYWRkIGEgYm9vbGVhbiB0byBYZW5EZXZpY2Ugd2hp
Y2ggaXMgc2V0IHdoZW4gaXQgaXMgYWRkZWQgdG8gdGhlIGxpc3QuDQoNCiAgUGF1bA0K

