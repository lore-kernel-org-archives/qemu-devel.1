Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB1C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B241206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4zk8YT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B241206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hDA-0005u4-Hf
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dhildenb@redhat.com>) id 1j2hCU-0005MX-Az
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dhildenb@redhat.com>) id 1j2hCS-0006ah-5z
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:04:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dhildenb@redhat.com>) id 1j2hCR-0006YV-K5
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581710670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NA5EaKv0d9a58fzQKDBDPRvGMx+wK/lFS8RuIofgGWo=;
 b=N4zk8YT3VsN5GTZWPrfT/vK69uoznrjb2hXqa53/r07oG0c0dz1H38y8hglQV80e0y3NAX
 Csj0PnJp1f1cvwOy4xjnTGxP9rS0g+Dp08uB9zGCkqNEFBbSDLxExIY5uQPHqgdrje86oE
 dKWVl/6AShKGsidNPweMnNP2rPk8Ruw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-2m5q7PhiNiCOWkPGzPIP4w-1; Fri, 14 Feb 2020 15:04:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2752F8017CC;
 Fri, 14 Feb 2020 20:04:25 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 020595C115;
 Fri, 14 Feb 2020 20:04:24 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com
 (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 1551D38A1;
 Fri, 14 Feb 2020 20:04:24 +0000 (UTC)
From: David Hildenbrand <dhildenb@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Date: Fri, 14 Feb 2020 15:04:23 -0500 (EST)
Message-Id: <A5C9F372-A9A6-4D6C-8C08-798F4ED15C10@redhat.com>
References: <20200214194459.GB1193332@xz-x1>
In-Reply-To: <20200214194459.GB1193332@xz-x1>
To: Peter Xu <peterx@redhat.com>
Thread-Topic: memory: Don't allow to resize RAM while migrating
Thread-Index: gotyl5UxVRI3EQ6107rNB7EXT6zFVA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2m5q7PhiNiCOWkPGzPIP4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhao@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gQW0gMTQuMDIuMjAyMCB1bSAyMDo0NSBzY2hyaWViIFBldGVyIFh1IDxwZXRlcnhAcmVk
aGF0LmNvbT46DQo+IA0KPiDvu79PbiBGcmksIEZlYiAxNCwgMjAyMCBhdCAwNzoyNjo1OVBNICsw
MTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+Pj4+PiArICAgIGlmICghcG9zdGNvcHlf
aXNfcnVubmluZygpKSB7DQo+Pj4+Pj4gKyAgICAgICAgRXJyb3IgKmVyciA9IE5VTEw7DQo+Pj4+
Pj4gKw0KPj4+Pj4+ICsgICAgICAgIC8qDQo+Pj4+Pj4gKyAgICAgICAgICogUHJlY29weSBjb2Rl
IGNhbm5vdCBkZWFsIHdpdGggdGhlIHNpemUgb2YgcmFtIGJsb2NrcyBjaGFuZ2luZyBhdA0KPj4+
Pj4+ICsgICAgICAgICAqIHJhbmRvbSBwb2ludHMgaW4gdGltZS4gV2UncmUgc3RpbGwgcnVubmlu
ZyBvbiB0aGUgc291cmNlLCBhYm9ydA0KPj4+Pj4+ICsgICAgICAgICAqIHRoZSBtaWdyYXRpb24g
YW5kIGNvbnRpbnVlIHJ1bm5pbmcgaGVyZS4gTWFrZSBzdXJlIHRvIHdhaXQgdW50aWwNCj4+Pj4+
PiArICAgICAgICAgKiBtaWdyYXRpb24gd2FzIGNhbmNlbGVkLg0KPj4+Pj4+ICsgICAgICAgICAq
Lw0KPj4+Pj4+ICsgICAgICAgIGVycm9yX3NldGcoJmVyciwgIlJBTSByZXNpemVkIGR1cmluZyBw
cmVjb3B5LiIpOw0KPj4+Pj4+ICsgICAgICAgIG1pZ3JhdGVfc2V0X2Vycm9yKG1pZ3JhdGVfZ2V0
X2N1cnJlbnQoKSwgZXJyKTsNCj4+Pj4+PiArICAgICAgICBlcnJvcl9mcmVlKGVycik7DQo+Pj4+
Pj4gKyAgICAgICAgbWlncmF0aW9uX2NhbmNlbCgpOw0KPj4+Pj4+ICsgICAgfSBlbHNlIHsNCj4+
Pj4+PiArICAgICAgICAvKg0KPj4+Pj4+ICsgICAgICAgICAqIFBvc3Rjb3B5IGNvZGUgY2Fubm90
IGRlYWwgd2l0aCB0aGUgc2l6ZSBvZiByYW0gYmxvY2tzIGNoYW5naW5nIGF0DQo+Pj4+Pj4gKyAg
ICAgICAgICogcmFuZG9tIHBvaW50cyBpbiB0aW1lLiBXZSdyZSBydW5uaW5nIG9uIHRoZSB0YXJn
ZXQuIEZhaWwgaGFyZC4NCj4+Pj4+PiArICAgICAgICAgKg0KPj4+Pj4+ICsgICAgICAgICAqIFRP
RE86IEhvdyB0byBoYW5kbGUgdGhpcyBpbiBhIGJldHRlciB3YXk/DQo+Pj4+Pj4gKyAgICAgICAg
ICovDQo+Pj4+Pj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJSQU0gcmVzaXplZCBkdXJpbmcgcG9z
dGNvcHkuIik7DQo+Pj4+Pj4gKyAgICAgICAgZXhpdCgtMSk7DQo+Pj4+PiANCj4+Pj4+IE5vdyBJ
J20gcmV0aGlua2luZyB0aGUgcG9zdGNvcHkgY2FzZS4uLi4NCj4+Pj4+IA0KPj4+Pj4gcmFtX2Rp
cnR5X2JpdG1hcF9yZWxvYWQoKSBzaG91bGQgb25seSBoYXBwZW4gZHVyaW5nIHRoZSBwb3N0Y29w
eQ0KPj4+Pj4gcmVjb3ZlcnksIGFuZCB3aGVuIHRoYXQgaGFwcGVucyB0aGUgVk0gc2hvdWxkIGJl
IHN0b3BwZWQgb24gYm90aA0KPj4+Pj4gc2lkZXMuICBXaGljaCBtZWFucywgcmFtIHJlc2l6aW5n
IHNob3VsZCBub3QgdHJpZ2dlciB0aGVyZS4uLg0KPj4+PiANCj4+Pj4gQnV0IHRoYXQgZ3Vlc3Qg
Z290IHRoZSBjaGFuY2UgdG8gcnVuIGZvciBhIGJpdCBhbmQgZXZlbnR1YWxseSByZWJvb3QNCj4+
Pj4gQUZBSUsuIEFsc28sIHRoZXJlIGFyZSBvdGhlciBkYXRhIHJhY2VzIHBvc3NpYmxlIHdoZW4g
dXNlZF9sZW5ndGgNCj4+Pj4gc3VkZGVubHkgY2hhbmdlcywgdGhpcyBpcyBqdXN0IHRoZSBtb3N0
IG9idmlvdXMgb25lIHdoZXJlIHRoaW5ncyB3aWxsOw0KPj4+PiBnZXQgc2NyZXdlZCB1cC4NCj4+
PiANCj4+PiBSaWdodCwgdGhlIG1ham9yIG9uZSBjb3VsZCBiZSBpbiByYW1fbG9hZF9wb3N0Y29w
eSgpIHdoZXJlIHdlIGNhbGwNCj4+PiBob3N0X2Zyb21fcmFtX2Jsb2NrX29mZnNldCgpLiAgSG93
ZXZlciBpZiBGVyBleHRlbnNpb24gaXMgdGhlIG1ham9yDQo+Pj4gdXNlIGNhc2UgdGhlbiBpdCBz
ZWVtcyB0byBzdGlsbCB3b3JrIChzdGlsbCBiZXR0ZXIgdGhhbiBjcmFzaGluZywNCj4+PiBpc24n
dCBpdD8gOikuDQo+PiANCj4+ICJMZXQncyBjbG9zZSBvdXIgZXllcyBhbmQgaG9wZSBpdCB3aWxs
IG5ldmVyIGhhcHBlbiIgPyA6KSBObywgSSBkb24ndA0KPj4gbGlrZSB0aGF0LiBUaGlzIHNjcmVh
bXMgZm9yIGEgYmV0dGVyIHNvbHV0aW9uIGxvbmcgdGVybSwgYW5kIHVudGlsIHRoZW4NCj4+IGEg
cHJvcGVyIGZlbmNpbmcgSU1ITy4gV2UncmUgbWFraW5nIGhlcmUgd2lsZCBndWVzc2VzIGFib3V0
IGRhdGEgcmFjZXMNCj4+IGFuZCB3aHkgdGhleSBtaWdodCBub3QgYmUgdGhhdCBiYWQgaW4gY2Vy
dGFpbiBjYXNlcyAoZGlkIEkgbWVudGlvbg0KPj4gbG9hZC9zdG9yZSB0ZWFyaW5nPyB1c2VkX2xl
bmd0aCBpcyBub3QgYW4gYXRvbWljIHZhbHVlIC4uLikuDQo+IA0KPiBZZWFoIGZlbmNpbmcgaXMg
Z29vZCwgYnV0IGNyYXNoaW5nIGEgVk0gd2hpbGUgaXQgd2Fzbid0IGdvaW5nIHRvIGNyYXNoDQo+
IGlzIGFub3RoZXIgdGhpbmcsIGltaG8uICBZb3UgY2FuIGR1bXAgYW4gZXJyb3IgbWVzc2FnZSBp
ZiB5b3UgcmVhbGx5DQo+IGxpa2UsIGJ1dCBpbnN0ZWFkIG9mIGV4aXQoKSBJIHJlYWxseSBwcmVm
ZXIgd2UgZWl0aGVyIHN0aWxsIGxldCB0aGUNCj4gb2xkIHdheSB0byBhdCBsZWFzdCB3b3JrIG9y
IHJlYWxseSBmaXggaXQuDQoNCknigJhsbCBkbyB3aGF0ZXZlciBKdWFuL0RhdmUgdGhpbmsgaXMg
YmVzdC4gSSBhbSBub3QgY29udmluY2VkIHRoYXQgdGhlcmUgaXMgbm8gd2F5IHRvIGNvcnJ1cHQg
ZGF0YSBvciBjcmFzaCBsYXRlciB3aGVuIHRoZSBndWVzdCBpcyBhbHJlYWR5IHJ1bm5pbmcgYWdh
aW4gcG9zdC1yZWJvb3QgYW5kIGRvaW5nIHJlYWwgd29yay4NCg0KPiANCj4gV2hlbiBJIHNheSAi
cmVhbGx5IGZpeCBpdCIsIEkgbWVhbiB3ZSBjYW4gZXZlbiBzdGFydCB0byB0aGluayBhYm91dA0K
PiB0aGUgc2hyaW5raW5nIGNhc2UgYW5kIGhvdyB0byBzdXBwb3J0IHRoYXQgZm9yIHBvc3Rjb3B5
LiAgRm9yIGV4YW1wbGUsDQo+IGluIHRoZSBhYm92ZSBjYXNlIGhvc3RfZnJvbV9yYW1fYmxvY2tf
b2Zmc2V0KCkgd2lsbCByZXR1cm4gTlVMTCB0aGVuLA0KPiBhbmQgdGhlIGZpeCBjb3VsZCBiZSB0
aGF0IHdlIGRyb3AgdGhhdCBleHRyYSBwYWdlIGJlY2F1c2Ugd2UgZG9uJ3QNCj4gbmVlZCB0aGF0
IGFueSBtb3JlLCBpbnN0ZWFkIG9mIGJhaWxpbmcgb3V0Lg0KPiANCg0KSSBoYXZlIHBhdGNoZXMg
b24gdGhlIGxpc3QgdGhhdCB3aWxsIG1ha2UgZXZlcnl0aGluZyBleGNlZWQgdXNlZF9sZW5ndGgg
aW5hY2Nlc3NpYmxlLiBJZiB0aGVyZSBpcyBzdGlsbCBhbiBhY2Nlc3MsIHdlIHdpbGwgY3Jhc2gu
IFByaW50aW5nIGEgd2FybmluZyBtaWdodCBoZWxwIGZpZ3VyZSBvdXQgd2hhdCB3ZW50IHdyb25n
Lg0KDQpJIGhhdmUgYSBwYXRjaCBseWluZyBhcm91bmQgdGhhdCBhbGxvY2F0ZXMgdGhlIGJpdG1h
cHMgb25seSBmb3IgdGhlIHVzZWRfbGVuZ3RoLiBBY2Nlc3Mgb3V0c2lkZSBvZiB0aGF0IChlc3Au
IHJlY2VpY2VkIGJpdG1hcCkgd2lsbCwgd2VsbCwgZGVwZW5kcywgY3Jhc2ggb3IgbWVzcyB1cCBk
YXRhLiBQcmludGluZyBhbiBlcnJvciBtaWdodCBoZWxwIHRvIGZpZ3VyZSBvdXQgd2hhdCB3ZW50
IHdyb25nLiBNYXliZS4NCg0KSnVzdCBGWUkgaG93IEkgZm91bmQgdGhpcyBpc3N1ZSBhbmQgd2h5
IEkgd2FudCB0byBzYW5pdGl6ZSB0aGUgY29kZS4gQW5kIHdlIGFyZSB0cnlpbmcgdG8ga2VlcCBz
b21ldGhpbmcgYWxpdmUgaGVyZSB0aGF0IG5ldmVyIGNvdWxkIGhhdmUgd29ya2VkIDEwMCUgcmVs
aWFibHkgYXMgaXQgaXMgaW5oZXJlbnRseSByYWN5Lg0KDQpDaGVlcnMh


