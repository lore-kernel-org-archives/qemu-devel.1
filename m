Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652FFC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5B32073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYpBn896"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5B32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0wo-0003Cn-B0
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jK0vd-0001bf-L2
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jK0vc-0001kH-7l
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:34:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jK0vc-0001j2-3J
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585838083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RlhH1aMNpBHd87KQK1n4Ry0fINGXScOTp9bEq66FZs=;
 b=BYpBn896TIIGpRLGNkr7dXM6fKG44o0o9wnXJFz2Cx8w5oCTzyzkFuA3H4bXg//jmc3LFr
 1C7lfHa+Q6LZzs4SYozYCPnzMyfOvKYNAQtR6CXYRpGjd8Z8vpnaWQGcFygM0L/Krsm6Yj
 +d+98Rl/H1Ffw72kXQ1f8sDCyp4X5V0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-sH-7Yty6PVSsVu-vbmS1jg-1; Thu, 02 Apr 2020 10:34:42 -0400
X-MC-Unique: sH-7Yty6PVSsVu-vbmS1jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B868017F5;
 Thu,  2 Apr 2020 14:34:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8853B5DA76;
 Thu,  2 Apr 2020 14:34:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD29F11385E2; Thu,  2 Apr 2020 16:34:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <a3ca8c60-dd83-ea7b-c268-0c94e441bb52@virtuozzo.com>
 <alpine.BSF.2.22.395.2004021132270.75834@zero.eik.bme.hu>
 <53df0069-8a7a-9de8-29cb-21362d88bb4e@virtuozzo.com>
Date: Thu, 02 Apr 2020 16:34:38 +0200
In-Reply-To: <53df0069-8a7a-9de8-29cb-21362d88bb4e@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 2 Apr 2020 17:11:55 +0300")
Message-ID: <87pncq0xdt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3
cml0ZXM6DQoNCj4gMDIuMDQuMjAyMCAxMjozNiwgQkFMQVRPTiBab2x0YW4gd3JvdGU6DQo+PiBP
biBUaHUsIDIgQXByIDIwMjAsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+
Pj4gMDEuMDQuMjAyMCAyMzoxNSwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4+Pj4gT24gV2VkLCAx
IEFwciAyMDIwIGF0IDEwOjAzLCBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+
IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IFFFTVUncyBFcnJvciB3YXMgcGF0dGVybmVkIGFmdGVyIEdM
aWIncyBHRXJyb3IuwqAgRGlmZmVyZW5jZXMgaW5jbHVkZToNCj4+Pj4NCj4+Pj4gwqBGcm9tIG15
IFBPViB0aGUgbWFqb3IgcHJvYmxlbSB3aXRoIEVycm9yIGFzIHdlIGhhdmUgaXQgdG9kYXkNCj4+
Pj4gaXMgdGhhdCBpdCBtYWtlcyB0aGUgc2ltcGxlIHByb2Nlc3Mgb2Ygd3JpdGluZyBjb2RlIGxp
a2UNCj4+Pj4gZGV2aWNlIHJlYWxpemUgZnVuY3Rpb25zIGhvcnJpZmljYWxseSBib2lsZXJwbGF0
ZSBoZWF2eTsNCj4+Pj4gZm9yIGluc3RhbmNlIHRoaXMgaXMgZnJvbSBody9hcm0vYXJtc3NlLmM6
DQo+Pj4+DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKGNw
dW9iaiwgT0JKRUNUKCZzLT5jcHVfY29udGFpbmVyW2ldKSwNCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJtZW1v
cnkiLCAmZXJyKTsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyKSB7DQo+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJyKTsNCj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKGNwdW9iaiwgT0JK
RUNUKHMpLCAiaWRhdSIsICZlcnIpOw0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIpIHsN
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBlcnIp
Ow0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgIH0NCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBvYmplY3RfcHJvcGVydHlfc2V0X2Jvb2wo
Y3B1b2JqLCB0cnVlLCAicmVhbGl6ZWQiLCAmZXJyKTsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoZXJyKSB7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9wcm9wYWdhdGUo
ZXJycCwgZXJyKTsNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+DQo+Pj4+IDE2IGxpbmVzIG9mIGNvZGUganVzdCB0byBz
ZXQgMiBwcm9wZXJ0aWVzIG9uIGFuIG9iamVjdA0KPj4+PiBhbmQgcmVhbGl6ZSBpdC4gSXQncyBh
IGxvdCBvZiBib2lsZXJwbGF0ZSBhbmQgYXMNCj4+Pj4gYSByZXN1bHQgd2UgZnJlcXVlbnRseSBn
ZXQgaXQgd3Jvbmcgb3IgdGFrZSBzaG9ydGN1dHMNCj4+Pj4gKGVnIGZvcmdldHRpbmcgdGhlIGVy
cm9yLWhhbmRsaW5nIGVudGlyZWx5LCBjYWxsaW5nDQo+Pj4+IGVycm9yX3Byb3BhZ2F0ZSBqdXN0
IG9uY2UgZm9yIGEgd2hvbGUgc2VxdWVuY2Ugb2YNCj4+Pj4gY2FsbHMsIHRha2luZyB0aGUgbGF6
eSBhcHByb2FjaCBhbmQgdXNpbmcgZXJyX2Fib3J0DQo+Pj4+IG9yIGVycl9mYXRhbCB3aGVuIHdl
IG91Z2h0IHJlYWxseSB0byBiZSBwcm9wYWdhdGluZw0KPj4+PiBhbiBlcnJvciwgZXRjKS4gSSBo
YXZlbid0IGxvb2tlZCBhdCAnYXV0byBwcm9wYWdhdGlvbicNCj4+Pj4geWV0LCBob3BlZnVsbHkg
aXQgd2lsbCBoZWxwPw0KPj4+DQo+Pj4gWWVzLCBhZnRlciBpdCB0aGUgY29kZSBhYm92ZSB3aWxs
IGxvb2sgbGlrZSB0aGlzOg0KPj4+DQo+Pj4gLi4uIHNvbWVfZnVuYyguLi4sIGVycnApDQo+Pj4g
ew0KPj4+IMKgwqAgRVJSUF9BVVRPX1BST1BBR0FURSgpOyAjIG1hZ2ljIG1hY3JvIGF0IGZ1bmN0
aW9uIHN0YXJ0LCBhbmQgbm8gIkVycm9yICplcnIiIGRlZmluaXRpb24NCj4+Pg0KPj4+IC4uLg0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKGNwdW9iaiwgT0JK
RUNUKCZzLT5jcHVfY29udGFpbmVyW2ldKSwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIm1lbW9yeSIsIGVycnAp
Ow0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKCplcnJwKSB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybjsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+PiDCoMKgwqDCoMKg
wqDCoMKgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhjcHVvYmosIE9CSkVDVChzKSwgImlkYXUi
LCBlcnJwKTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlmICgqZXJycCkgew0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoCBvYmplY3RfcHJvcGVydHlfc2V0X2Jvb2woY3B1b2JqLCB0cnVlLCAicmVh
bGl6ZWQiLCBlcnJwKTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlmICgqZXJycCkgew0KPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+
Pj4gLi4uDQo+Pj4gfQ0KPj4+DQo+Pj4gLSBwcm9wYWdhdGlvbiBpcyBhdXRvbWF0aWMsIGVycnAg
aXMgdXNlZCBkaXJlY3RseSBhbmQgbWF5IGJlIHNhZmVseSBkZXJlZmVyZW5jZWQuDQo+Pg0KPj4g
Tm90IG11Y2ggYmV0dGVyLiBDb3VsZCBpdCBiZSBzb21ldGhpbmcgbGlrZToNCj4NCj4gQWN0dWFs
bHksIG11Y2ggYmV0dGVyLCBhcyBpdCBzb2x2ZXMgc29tZSByZWFsIHByb2JsZW1zIGFyb3VuZCBl
cnJvciBwcm9wYWdhdGlvbi4NCg0KVGhlIGF1dG8gcHJvcGFnYXRpb24gcGF0Y2hlcycgc3RhdGVk
IGFpbSBpcyB0byBmaXggJmVycm9yX2ZhdGFsIG5vdCB0bw0KZWF0IGhpbnRzLCBhbmQgdG8gcHJv
dmlkZSBtb3JlIHVzZWZ1bCBzdGFjayBiYWNrdHJhY2VzIHdpdGgNCiZlcnJvcl9hYm9ydC4gIFRo
ZSBzbGlnaHQgc2hyaW5raW5nIG9mIGJvaWxlcnBsYXRlIGlzIGEgd2VsY29tZSBib251cy4NCg0K
Rm9yIGEgYmlnZ2VyIGltcHJvdmVtZW50LCBoYXZlIHRoZSBmdW5jdGlvbnMgcmV0dXJuIGEgdXNl
ZnVsIHZhbHVlLCBhcw0KZGlzY3Vzc2VkIGVsc2V3aGVyZSBpbiB0aGlzIHRocmVhZC4NCg0KPj4N
Cj4+ICDCoMKgwqAgRVJSUF9SRVQob2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKGNwdW9iaiwgT0JK
RUNUKCZzLT5jcHVfY29udGFpbmVyW2ldKSwNCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAibWVtb3J5
IiwgZXJycCkpOw0KPj4gIMKgwqDCoCBFUlJQX1JFVChvYmplY3RfcHJvcGVydHlfc2V0X2xpbmso
Y3B1b2JqLCBPQkpFQ1QocyksICJpZGF1IiwgZXJycCkpOw0KPj4gIMKgwqDCoCBFUlJQX1JFVChv
YmplY3RfcHJvcGVydHlfc2V0X2Jvb2woY3B1b2JqLCB0cnVlLCAicmVhbGl6ZWQiLCBlcnJwKSk7
DQo+Pg0KPg0KPiBhbmQgdHVybiBhbGwNCj4NCj4gcmV0ID0gZnVuYyguLi4pOw0KPiBpZiAocmV0
IDwgMCkgew0KPiAgICAgcmV0dXJuIHJldDsNCj4gfQ0KPg0KPiBpbnRvDQo+DQo+IEZBSUxfUkVU
KGZ1bmMoLi4uKSkNCj4NCj4gPw0KPg0KPiBOb3QgYSBwcm9ibGVtIHRvIG1ha2Ugc3VjaCBtYWNy
by4uIEJ1dCBJIHRoaW5rIGl0J3MgYSBiYWQgaWRlYSB0byB0dXJuIGFsbCB0aGUgY29kZQ0KPiBp
bnRvIHNlcXVlbmNlIG9mIG1hY3JvIGludm9jYXRpb25zLiBJdCdzIGhhcmQgdG8gZGVidWcgYW5k
IGZvbGxvdy4NCg0KWWVzLiAgSGlkaW5nIGNvbnRyb2wgZmxvdyBpbiBtYWNyb3MgaXMgYWxtb3N0
IGFsd2F5cyB0b28gbXVjaCBtYWdpYy4NClRoZXJlIGFyZSBleGNlcHRpb25zLCBidXQgdGhpcyBk
b2Vzbid0IGxvb2sgbGlrZSBvbmUuDQo=


