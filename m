Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45459C2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D0E20768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1wtBdsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D0E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOo0L-0004OH-95
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 15:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dhildenb@redhat.com>) id 1jOnz8-0003uo-Eq
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dhildenb@redhat.com>) id 1jOnz6-0007G1-Iz
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:46:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dhildenb@redhat.com>) id 1jOnz6-0007Fm-DA
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586979967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4N7qtTeupHI73EXl64Q6f82qnZ08evDE5EPe5oxF1c=;
 b=B1wtBdsKL3wNa77IDS+fqSWg6RZqgiNOfaXt0wWH3zh1y2uyciqVIWg2XVfKPiiv6AE8mU
 QZ+3aKVtInMBsLgjc4KteJ3weO/grFHd/HC+afFyGGStSu7SMVjx+RXuWiId/TN3czI1V5
 JXRAECMj9nIcmualEvZ7wxQkLDrywzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-9AeSbJltN0mzt1vYGKq3dQ-1; Wed, 15 Apr 2020 15:46:03 -0400
X-MC-Unique: 9AeSbJltN0mzt1vYGKq3dQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4222D8017F3;
 Wed, 15 Apr 2020 19:46:02 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35BB35D9E2;
 Wed, 15 Apr 2020 19:46:02 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com
 (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id E0F121803C32;
 Wed, 15 Apr 2020 19:46:01 +0000 (UTC)
From: David Hildenbrand <dhildenb@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
Date: Wed, 15 Apr 2020 15:46:01 -0400 (EDT)
Message-Id: <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
In-Reply-To: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Thread-Topic: virtio-balloon: Implement support for page poison tracking
 feature
Thread-Index: TPi92OUme84EDgVddt8Iuy/bzEut0w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
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
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, "Wang,
 Wei W" <wei.w.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gQW0gMTUuMDQuMjAyMCB1bSAyMToyOSBzY2hyaWViIEFsZXhhbmRlciBEdXljayA8YWxl
eGFuZGVyLmR1eWNrQGdtYWlsLmNvbT46DQo+IA0KPiDvu79PbiBXZWQsIEFwciAxNSwgMjAyMCBh
dCAxMToxNyBBTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
PiANCj4+PiANCj4+PiBUaGUgY29tbWVudCBhYm92ZSBleHBsYWlucyB0aGUgIndoeSIuIEJhc2lj
YWxseSBwb2lzb25pbmcgYSBwYWdlIHdpbGwNCj4+PiBkaXJ0eSBpdC4gU28gd2h5IGhpbnQgYSBw
YWdlIGFzIGZyZWUgd2hlbiB0aGF0IHdpbGwgZHJvcCBpdCBiYWNrIGludG8NCj4+PiB0aGUgZ3Vl
c3QgYW5kIHJlc3VsdCBpbiBpdCBiZWluZyBkaXJ0aWVkIGFnYWluLiBXaGF0IHlvdSBlbmQgdXAg
d2l0aA0KPj4+IGlzIGFsbCB0aGUgcGFnZXMgdGhhdCB3ZXJlIHRlbXBvcmFyaWx5IHBsYWNlZCBp
biB0aGUgYmFsbG9vbiBhcmUgZGlydHkNCj4+PiBhZnRlciB0aGUgaGludGluZyByZXBvcnQgaXMg
ZmluaXNoZWQgYXQgd2hpY2ggcG9pbnQgeW91IG1hZGUgdGhpbmdzDQo+Pj4gd29yc2UgaW5zdGVh
ZCBvZiBoZWxwaW5nIHRvIGltcHJvdmUgdGhlbS4NCj4+IA0KPj4gTGV0IG1lIHRoaW5rIHRoaXMg
dGhyb3VnaC4gV2hhdCBoYXBwZW5zIG9uIGZyZWUgcGFnZSBoaW50aW5nIGlzIHRoYXQNCj4+IA0K
Pj4gYSkgd2UgdGVsbCB0aGUgZ3Vlc3QgdGhhdCBtaWdyYXRpb24gc3RhcnRzDQo+PiBiKSBpdCBh
bGxvY2F0ZXMgcGFnZXMgKGFsbG9jX3BhZ2VzKCkpLCBzZW5kcyB0aGVtIHRvIHVzIGFuZCBhZGRz
IHRoZW0gdG8NCj4+ICAgYSBsaXN0DQo+PiBiKSB3ZSBleGNsdWRlIHRoZXNlIHBhZ2VzIG9uIG1p
Z3JhdGlvbg0KPj4gYykgd2UgdGVsbCB0aGUgZ3Vlc3QgdGhhdCBtaWdyYXRpb24gaXMgb3Zlcg0K
Pj4gZCkgdGhlIGd1ZXN0IGZyZWVzIGFsbCBhbGxvY2F0ZWQgcGFnZXMNCj4+IA0KPj4gVGhlICJp
c3N1ZSIgd2l0aCBWSVJUSU9fQkFMTE9PTl9GX1BBR0VfUE9JU09OIGlzLCB0aGF0IGluIGQpLCB0
aGUgZ3Vlc3QNCj4+IHdpbGwgZmlsbCBhbGwgcGFnZXMgYWdhaW4gd2l0aCBhIHBhdHRlcm4gKG9y
IHplcm8pLg0KPiANCj4gVGhleSBzaG91bGQgaGF2ZSBhbHJlYWR5IGJlZW4gZmlsbGVkIHdpdGgg
dGhlIHBvaXNvbiBwYXR0ZXJuIGJlZm9yZSB3ZQ0KPiBnb3QgdG8gZCkuIEEgYmlnZ2VyIHdvcnJ5
IGlzIHRoYXQgd2UgYXQgc29tZSBwb2ludCBpbiB0aGUgZnV0dXJlDQo+IHVwZGF0ZSB0aGUga2Vy
bmVsIHNvIHRoYXQgZCkgZG9lc24ndCB0cmlnZ2VyIHJlLXBvaXNvbmluZywgaW4gd2hpY2gNCj4g
Y2FzZSB0aGUgcGFnZXMgd29uJ3QgYmUgbWFya2VkIGFzIGRpcnR5LCB3ZSB3aWxsIGhhdmUgc2tp
cHBlZCB0aGUNCj4gbWlncmF0aW9uLCBhbmQgd2UgaGF2ZSBubyBpZGVhIHdoYXQgd2lsbCBiZSBp
biB0aGUgcGFnZXMgYXQgdGhlIGVuZC4NCj4gDQo+PiBBRkFJS3MsIGl0J3MgZWl0aGVyDQo+PiAN
Cj4+IDEpIE5vdCBwZXJmb3JtaW5nIGZyZWUgcGFnZSBoaW50aW5nLCBtaWdyYXRpbmcgcGFnZXMg
ZmlsbGVkIHdpdGggYQ0KPj4gcG9pc29uIHZhbHVlIChvciB6ZXJvKS4NCj4+IDIpIFBlcmZvcm1p
bmcgZnJlZSBwYWdlIGhpbnRpbmcsIG5vdCBtaWdyYXRpbmcgcGFnZXMgZmlsbGVkIHdpdGggYQ0K
Pj4gcG9pc29uIHZhbHVlIChvciB6ZXJvKSwgbGV0dGluZyBvbmx5IHRoZSBndWVzdCBmaWxsIHRo
ZW0gYWdhaW4uDQo+PiANCj4+IEkgaGF2ZSB0aGUgZmVlbGluZywgdGhhdCAyKSBpcyBzdGlsbCBi
ZXR0ZXIgZm9yIG1pZ3JhdGlvbiwgYmVjYXVzZSB3ZQ0KPj4gZG9uJ3QgbWlncmF0ZSB1c2VsZXNz
IHBhZ2VzIGFuZCBsZXQgdGhlIGd1ZXN0IHJlY29uc3RydWN0IHRoZSBjb250ZW50Pw0KPj4gKGhh
dmluZyBhIHBvaXNvbiB2YWx1ZSBvZiB6ZXJvIG1pZ2h0IGJlIGRlYmF0YWJsZSkNCj4+IA0KPj4g
Q2FuIHlvdSB0ZWxsIG1lIHdoYXQgSSBhbSBtaXNzaW5nPyA6KQ0KPiANCj4gVGhlIGdvYWwgb2Yg
dGhlIGZyZWUgcGFnZSBoaW50aW5nIHdhcyB0byByZWR1Y2UgdGhlIG51bWJlciBvZiBwYWdlcw0K
PiB0aGF0IGhhdmUgdG8gYmUgbWlncmF0ZWQsIGluIHRoZSBzZWNvbmQgY2FzZSB5b3UgcG9pbnQg
b3V0IGlzIGlzDQo+IGJhc2ljYWxseSBkZWZlcnJpbmcgaXQgYW5kIHdpbGwgbWFrZSB0aGUgcG9z
dC1jb3B5IHF1aXRlIG1vcmUNCj4gZXhwZW5zaXZlIHNpbmNlIGFsbCBvZiB0aGUgZnJlZSBtZW1v
cnkgd2lsbCBiZSBwdXNoZWQgdG8gdGhlIHBvc3QtY29weQ0KPiB3aGljaCBJIHdvdWxkIHRoaW5r
IHdvdWxkIGJlIHVuZGVzaXJhYmxlIHNpbmNlIGl0IG1lYW5zIHRoZSBWTSB3b3VsZA0KPiBoYXZl
IHRvIGJlIGRvd24gZm9yIGEgZ3JlYXRlciBhbW91bnQgb2YgdGltZSB3aXRoIHRoZSBwb2lzb25p
bmcNCj4gZW5hYmxlZC4NCg0KUG9zdGNvcHkgaXMgYSB2ZXJ5IGdvb2QgcG9pbnQsIGJvdWdodCEN
Cg0KQnV0ICh3aGF0IHlvdSB3cm90ZSBhYm92ZSkgaXQgc291bmRzIGxpa2UgdGhhdCB0aGlzIGlz
IHJlYWxseSB3aGF0IHdlICpoYXZlIHRvKiBkbywgbm90IGFuIG9wdGltaXphdGlvbi4gSeKAmGxs
IGRvdWJsZSBjaGVjayB0aGUgc3BlYyB0b21vcnJvdyAoaG9wZWZ1bGx5IGl0IHdhcyBkb2N1bWVu
dGVkKS4gV2Ugc2hvdWxkIHJlcGhyYXNlIHRoZSBjb21tZW50IHRoZW4uDQoNCkkgY291bGQgaW1h
Z2luZSB0aGF0IHdlIGFsc28gaGF2ZSB0byBjYXJlIGFib3V0IG9yZGluYXJ5IHBhZ2UgaW5mbGF0
aW9uL2RlZmxhdGlvbiB3aGVuIGhhbmRsaW5nIHBhZ2UgcG9pc29uaW5nLiAoSW93LCBkb27igJh0
IGluZmxhdGUvZGVmbGF0ZSBpZiBzZXQgZm9yIG5vdykuDQoNCj4gDQo+IFRoZSB3b3JzdCBjYXNl
IHNjZW5hcmlvIHdvdWxkIGJlIG9uZSBpbiB3aGljaCB0aGUgVk0gd2FzIHN1c3BlbmRlZCBmb3IN
Cj4gbWlncmF0aW9uIHdoaWxlIHRoZXJlIHdlcmUgc3RpbGwgcGFnZXMgaW4gdGhlIGJhbGxvb24g
dGhhdCBuZWVkZWQgdG8NCj4gYmUgZHJhaW5lZC4gSW4gc3VjaCBhIGNhc2UgeW91IHdvdWxkIGhh
dmUgdGhlbSBpbiBhbiBpbmRldGVybWluYXRlDQo+IHN0YXRlIHNpbmNlIHRoZSBsYXN0IHBhZ2Ug
cG9pc29uaW5nIGZvciB0aGVtIG1pZ2h0IGhhdmUgYmVlbiBpZ25vcmVkDQo+IHNpbmNlIHRoZXkg
d2VyZSBtYXJrZWQgYXMgImZyZWUiLCBzbyB0aGV5IGFyZSBqdXN0IGdvaW5nIHRvIGJlDQo+IHdo
YXRldmVyIHZhbHVlIHRoZXkgd2VyZSBpZiB0aGV5IGhhZCBiZWVuIG1pZ3JhdGVkIGF0IGFsbC4N
Cj4gDQo+Pj4gDQo+Pj4+IA0KPj4+Pj4gKyAgICAgICAgcmV0dXJuOw0KPj4+Pj4gKyAgICB9DQo+
Pj4+PiArDQo+Pj4+PiAgICAgaWYgKHMtPmZyZWVfcGFnZV9yZXBvcnRfY21kX2lkID09IFVJTlRf
TUFYKSB7DQo+Pj4+PiAgICAgICAgIHMtPmZyZWVfcGFnZV9yZXBvcnRfY21kX2lkID0NCj4+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX0JBTExPT05fRlJFRV9QQUdFX1JFUE9SVF9D
TURfSURfTUlOOw0KPj4+PiANCj4+Pj4gV2Ugc2hvdWxkIHJlbmFtZSBhbGwgImZyZWVfcGFnZV9y
ZXBvcnQiIHN0dWZmIHdlIGNhbiB0bw0KPj4+PiAiZnJlZV9wYWdlX2hpbnQiLyJmcmVlX3BhZ2Vf
aGludGluZyIgdG8gYXZvaWQgY29uZnVzaW9uIChlLmcuLCBvbiBteQ0KPj4+PiBzaWRlIDopICkg
YmVmb3JlIGFkZGluZyBmcmVlIHBhZ2UgcmVwb3J0aW5nIC4NCj4+Pj4gDQo+Pj4+IChsb29raW5n
IGF0IHRoZSB2aXJ0aW8tYmFsbG9vbiBsaW51eCBoZWFkZXIsIGl0J3MgYWxzbyBjb25mdXNpbmcg
YnV0DQo+Pj4+IHdlJ3JlIHN0dWNrIHdpdGggdGhhdCAtIG1heWJlIHdlIHNob3VsZCBhZGQgYmV0
dGVyIGNvbW1lbnRzKQ0KPj4+IA0KPj4+IEFyZSB3ZSBzdHVjaz8gQ291bGRuJ3Qgd2UganVzdCBj
b252ZXJ0IGl0IHRvIGFuIGFub255bW91cyB1bmlvbiB3aXRoDQo+Pj4gZnJlZV9wYWdlX2hpbnRf
Y21kX2lkIGFuZCB0aGVuIHVzZSB0aGF0IHdoZXJlIG5lZWRlZD8NCj4+IA0KPj4gU2F3IHlvdXIg
cGF0Y2ggYWxyZWFkeSA6KQ0KPj4gDQo+Pj4gDQo+Pj4+PiBAQCAtNjE4LDEyICs2MjcsMTAgQEAg
c3RhdGljIHNpemVfdCB2aXJ0aW9fYmFsbG9vbl9jb25maWdfc2l6ZShWaXJ0SU9CYWxsb29uICpz
KQ0KPj4+Pj4gICAgIGlmIChzLT5xZW11XzRfMF9jb25maWdfc2l6ZSkgew0KPj4+Pj4gICAgICAg
ICByZXR1cm4gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmFsbG9vbl9jb25maWcpOw0KPj4+Pj4gICAg
IH0NCj4+Pj4+IC0gICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZShmZWF0dXJlcywgVklSVElPX0JB
TExPT05fRl9QQUdFX1BPSVNPTikpIHsNCj4+Pj4+ICsgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVy
ZShmZWF0dXJlcywgVklSVElPX0JBTExPT05fRl9QQUdFX1BPSVNPTikgfHwNCj4+Pj4+ICsgICAg
ICAgIHZpcnRpb19oYXNfZmVhdHVyZShmZWF0dXJlcywgVklSVElPX0JBTExPT05fRl9GUkVFX1BB
R0VfSElOVCkpIHsNCj4+Pj4+ICAgICAgICAgcmV0dXJuIHNpemVvZihzdHJ1Y3QgdmlydGlvX2Jh
bGxvb25fY29uZmlnKTsNCj4+Pj4+ICAgICB9DQo+Pj4+PiAtICAgIGlmICh2aXJ0aW9faGFzX2Zl
YXR1cmUoZmVhdHVyZXMsIFZJUlRJT19CQUxMT09OX0ZfRlJFRV9QQUdFX0hJTlQpKSB7DQo+Pj4+
PiAtICAgICAgICByZXR1cm4gb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19iYWxsb29uX2NvbmZpZywg
cG9pc29uX3ZhbCk7DQo+Pj4+PiAtICAgIH0NCj4+Pj4gDQo+Pj4+IEkgYW0gbm90IHN1cmUgdGhp
cyBjaGFuZ2UgaXMgY29tcGxldGVseSBzYW5lLiBXaHkgaXMgdGhhdCBuZWNlc3NhcnkgYXQgYWxs
Pw0KPj4+IA0KPj4+IFRoZSBwb2lzb25fdmFsIGlzIHN0b3JlZCBhdCB0aGUgZW5kIG9mIHRoZSBz
dHJ1Y3R1cmUgYW5kIGlzIHJlcXVpcmVkDQo+Pj4gaW4gb3JkZXIgdG8gbWFrZSBmcmVlIHBhZ2Ug
aGludGluZyB0byB3b3JrLiBXaGF0IHRoaXMgY2hhbmdlIGlzIGRvaW5nDQo+PiANCj4+IFJlcXVp
cmVkIHRvIG1ha2UgaXQgd29yaz8gSW4gdGhlIGtlcm5lbCwNCj4+IA0KPj4gY29tbWl0IDJlOTkx
NjI5YmNmNTVhNDM2ODFhZWMxZWUwOTZlZWIwM2NmODE3MDkNCj4+IEF1dGhvcjogV2VpIFdhbmcg
PHdlaS53LndhbmdAaW50ZWwuY29tPg0KPj4gRGF0ZTogICBNb24gQXVnIDI3IDA5OjMyOjE5IDIw
MTggKzA4MDANCj4+IA0KPj4gICAgdmlydGlvLWJhbGxvb246IFZJUlRJT19CQUxMT09OX0ZfUEFH
RV9QT0lTT04NCj4+IA0KPj4gd2FzIG1lcmdlZCBhZnRlcg0KPj4gDQo+PiBjb21taXQgODZhNTU5
Nzg3ZTZmNWNmNjYyYzA4MTM2M2Y2NGEyMGNhZDY1NDE5NQ0KPj4gQXV0aG9yOiBXZWkgV2FuZyA8
d2VpLncud2FuZ0BpbnRlbC5jb20+DQo+PiBEYXRlOiAgIE1vbiBBdWcgMjcgMDk6MzI6MTcgMjAx
OCArMDgwMA0KPj4gDQo+PiAgICB2aXJ0aW8tYmFsbG9vbjogVklSVElPX0JBTExPT05fRl9GUkVF
X1BBR0VfSElOVA0KPj4gDQo+PiBTbyBJIGFzc3VtZSBpdCdzIHBlcmZlY3RseSBmaW5lIHRvIG5v
dCBoYXZlIGl0Lg0KPj4gDQo+PiBJJ2Qgc2F5IGl0J3MgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIHRo
ZSBndWVzdCB0byAqbm90KiB1c2UNCj4+IFZJUlRJT19CQUxMT09OX0ZfRlJFRV9QQUdFX0hJTlQg
aW4gY2FzZSBpdCBpcyB1c2luZyBwYWdlIHBvaXNvbmluZw0KPj4gd2l0aG91dCBWSVJUSU9fQkFM
TE9PTl9GX1BBR0VfUE9JU09OLiBPdGhlcndpc2UgaXQgd2lsbCBzaG9vdCBpdHNlbGYNCj4+IGlu
dG8gdGhlIGZvb3QuDQo+IA0KPiBCYXNlZCBvbiB0aGUgdGltaW5nIEkgYW0gZ3Vlc3NpbmcgdGhl
IHBhZ2UgcG9pc29uaW5nIHdhcyBpbiB0aGUgc2FtZQ0KPiBwYXRjaCBzZXQgYXMgdGhlIGZyZWUg
cGFnZSBoaW50aW5nIHNpbmNlIHRoZXJlIGlzIG9ubHkgMiBzZWNvbmRzDQo+IGJldHdlZW4gd2hl
biB0aGUgdHdvIGFyZSBtZXJnZWQuIElmIEkgcmVjYWxsIHRoZSBwYWdlIHBvaXNvbmluZyBsb2dp
Yw0KPiB3YXMgYWRkZWQgYWZ0ZXIgdGhlIGlzc3VlIHdhcyBwb2ludGVkIG91dCB0aGF0IGl0IG5l
ZWRlZCB0byBhZGRyZXNzDQo+IGl0Lg0KPiANCg0KWWVhaCwgYnV0IGFueSBvdGhlciBPUyBpbXBs
ZW1lbnRpbmcgdGhpcywgbm90IGNhcmluZyBhYm91dCBwYWdlIHBvaXNvbmluZyB3b3VsZG7igJh0
IG5lZWQgaXQuIE1heWJlIHRoZXJlIGlzIHNvbWV0aGluZyBpbiB0aGUgc3BlYy4NCg0KTWVudGFs
IG5vdGU6IHdl4oCYbGwgaGF2ZSB0byBtaWdyYXRlIHRoZSBwb2lzb24gdmFsdWUgaWYgbm90IGFs
cmVhZHkgZG9uZSAod3JpdGluZyBvbiBteSBtb2JpbGUpLg==


