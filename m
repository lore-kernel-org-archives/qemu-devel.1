Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91776C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 21:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596F62082E
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 21:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y81r//nP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596F62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibADS-0000QV-GO
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 16:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dhildenb@redhat.com>) id 1ibACb-0008PN-0g
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 16:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dhildenb@redhat.com>) id 1ibACY-0005QS-AW
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 16:22:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38688
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dhildenb@redhat.com>) id 1ibACX-0005QA-Uu
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 16:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575148968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLZQNj38ZZKNp6xrZ3Qqm960Ibdvwyhsmw0E1EV8WFU=;
 b=Y81r//nPK8c7+3AGVmg5ZW94Nt60einugwcANra4OmCTO3JrsqV2t4/kYPAagFZnldo/ir
 vc19zS9oqwcuXfIHq/ROHeYMIbZkZmp+k02Ld/bD+nO9gpJQYRkyZIL/suBeY9o8YGUQL1
 00JpGBSOISe46QzH8wnYJZ22JbF2CmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-uAJiAFlMNU-J5tnMdGTpxw-1; Sat, 30 Nov 2019 16:22:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C88D80183C;
 Sat, 30 Nov 2019 21:22:43 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EE3C1001281;
 Sat, 30 Nov 2019 21:22:43 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com
 (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 039604BB5C;
 Sat, 30 Nov 2019 21:22:43 +0000 (UTC)
From: David Hildenbrand <dhildenb@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
Date: Sat, 30 Nov 2019 16:22:42 -0500 (EST)
Message-Id: <9C97FEE6-D390-4CEB-9B00-50AE00AEA4D2@redhat.com>
References: <20191130194240.10517-18-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-18-armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Thread-Topic: s390x: Fix latent query-cpu-model-FOO error handling bugs
Thread-Index: Wp1WnB9C33dgfjTc0TuQHdyoRmFTrQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: uAJiAFlMNU-J5tnMdGTpxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Cornelia Huck <cohuck@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gQW0gMzAuMTEuMjAxOSB1bSAyMDo0MiBzY2hyaWViIE1hcmt1cyBBcm1icnVzdGVyIDxh
cm1icnVAcmVkaGF0LmNvbT46DQo+IA0KPiDvu79jcHVfbW9kZWxfZnJvbV9pbmZvKCkgaXMgYSBo
ZWxwZXIgZm9yIHFtcF9xdWVyeV9jcHVfbW9kZWxfZXhwYW5zaW9uKCksDQo+IHFtcF9xdWVyeV9j
cHVfbW9kZWxfY29tcGFyaXNvbigpLCBxbXBfcXVlcnlfY3B1X21vZGVsX2Jhc2VsaW5lKCkuICBJ
dA0KPiBjcmFzaGVzIHdoZW4gdGhlIHZpc2l0b3Igb3IgdGhlIFFPTSBzZXR0ZXIgZmFpbHMsIGFu
ZCBpdHMgQGVycnANCj4gYXJndW1lbnQgaXMgbnVsbC4gIE1lc3NlZCB1cCBpbiBjb21taXQgMTM3
OTc0Y2VhMyAnczM5MHgvY3B1bW9kZWw6DQo+IGltcGxlbWVudCBRTVAgaW50ZXJmYWNlICJxdWVy
eS1jcHUtbW9kZWwtZXhwYW5zaW9uIicuDQo+IA0KPiBJdHMgdGhyZWUgY2FsbGVycyBoYXZlIHRo
ZSBzYW1lIGJ1Zy4gIE1lc3NlZCB1cCBpbiBjb21taXQgNGU4MmVmMDUwMg0KPiAnczM5MHgvY3B1
bW9kZWw6IGltcGxlbWVudCBRTVAgaW50ZXJmYWNlICJxdWVyeS1jcHUtbW9kZWwtY29tcGFyaXNv
biInDQo+IGFuZCBjb21taXQgZjFhNDdkMDhlZiAnczM5MHgvY3B1bW9kZWw6IGltcGxlbWVudCBR
TVAgaW50ZXJmYWNlDQo+ICJxdWVyeS1jcHUtbW9kZWwtYmFzZWxpbmUiJy4NCj4gDQo+IFRoZSBi
dWdzIGNhbid0IGJpdGUgYXMgbm8gY2FsbGVyIGFjdHVhbGx5IHBhc3NlcyBudWxsLiAgRml4IHRo
ZW0NCj4gYW55d2F5Lg0KDQpodHRwczovL2VuLm0ud2lraXBlZGlhLm9yZy93aWtpL1NvZnR3YXJl
X2J1Zw0KDQogIOKAniBBIHNvZnR3YXJlIGJ1ZyBpcyBhbiBlcnJvciwgZmxhdyBvciBmYXVsdCBp
biBhIGNvbXB1dGVyIHByb2dyYW0gb3Igc3lzdGVtIHRoYXQgY2F1c2VzIGl0IHRvIHByb2R1Y2Ug
YW4gaW5jb3JyZWN0IG9yIHVuZXhwZWN0ZWQgcmVzdWx0LCBvciB0byBiZWhhdmUgaW4gdW5pbnRl
bmRlZCB3YXlzLiDigJ4NCg0KUGxlYXNlIG1ha2UgaXQgY2xlYXIgaW4gdGhlIGRlc2NyaXB0aW9u
cyB0aGF0IHRoZXNlIGFyZSBjbGVhbnVwcyBhbmQgbm90IGJ1Z2ZpeGVzLiBJdCBtaWdodCBiZSB2
ZXJ5IGNvbmZ1c2luZyBmb3IgcGVvcGxlIGxvb2tpbmcgb3V0IGZvciByZWFsIGJ1Z3MuIEFsc28s
IHBsZWFzZSBjaGFuZ2UgdGhlIHRlcm1pbm9sb2d5IOKAnm1lc3NlZCB1cOKAnCB0byDigJ5pbnRy
b2R1Y2VkIGlu4oCcIG9yIHNpbWlsYXIuDQoNCihhcHBsaWVzIHRvIGFsbCBzMzkweCBwYXRjaGVz
KQ0KDQpUaGFua3Mu


