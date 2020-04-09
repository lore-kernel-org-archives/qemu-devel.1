Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9822C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB70620769
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv7xAHPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB70620769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbD1-000745-UU
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jMbC9-0005TD-JI
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jMbC7-0006pm-8W
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:42:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jMbC7-0006pU-4t
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zq38BUlrj/isy7pME+Q9jm+00Jwv5PAkZjHQUQ5kxo=;
 b=Wv7xAHPjNkDHAUEll4tqvlPFYtZEqIq+JvwhWmhHcbF/a3meLT0Mt/yeFoIKsUIPHZlHzy
 n2JO3HO0RWm5CULC0v6SGjUusvmQQE7ena2EecYpSxBTtj3oIYGxctZTnCG53zs00kea6L
 LP4pECKbaFnDjiEtNNeKIZPyAa9qJVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-NgQl9B4HPLSsDAxMoL9b9g-1; Thu, 09 Apr 2020 13:42:24 -0400
X-MC-Unique: NgQl9B4HPLSsDAxMoL9b9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EEEA1922963;
 Thu,  9 Apr 2020 17:42:23 +0000 (UTC)
Received: from localhost (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0819C1195A6;
 Thu,  9 Apr 2020 17:42:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 2/3] aio-wait: delegate polling of main AioContext if
 BQL not held
Date: Thu,  9 Apr 2020 18:42:08 +0100
Message-Id: <20200409174209.321725-3-stefanha@redhat.com>
In-Reply-To: <20200409174209.321725-1-stefanha@redhat.com>
References: <20200409174209.321725-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KCkFueSB0aHJlYWQgdGhh
dCBpcyBub3QgYSBpb3RocmVhZCByZXR1cm5zIE5VTEwgZm9yIHFlbXVfZ2V0X2N1cnJlbnRfYWlv
X2NvbnRleHQoKS4KQXMgYSByZXN1bHQsIGl0IHdvdWxkIGFsc28gcmV0dXJuIHRydWUgZm9yCmlu
X2Fpb19jb250ZXh0X2hvbWVfdGhyZWFkKHFlbXVfZ2V0X2Fpb19jb250ZXh0KCkpLCBjYXVzaW5n
CkFJT19XQUlUX1dISUxFIHRvIGludm9rZSBhaW9fcG9sbCgpIGRpcmVjdGx5LiAgVGhpcyBpcyBp
bmNvcnJlY3QKaWYgdGhlIEJRTCBpcyBub3QgaGVsZCwgYmVjYXVzZSBhaW9fcG9sbCgpIGRvZXMg
bm90IGV4cGVjdCB0bwpydW4gY29uY3VycmVudGx5IGZyb20gbXVsdGlwbGUgdGhyZWFkcywgYW5k
IGl0IGNhbiBhY3R1YWxseQpoYXBwZW4gd2hlbiBzYXZldm0gd3JpdGVzIHRvIHRoZSB2bXN0YXRl
IGZpbGUgZnJvbSB0aGUKbWlncmF0aW9uIHRocmVhZC4KClRoZXJlZm9yZSwgcmVzdHJpY3QgaW5f
YWlvX2NvbnRleHRfaG9tZV90aHJlYWQgdG8gcmV0dXJuIHRydWUKZm9yIHRoZSBtYWluIEFpb0Nv
bnRleHQgb25seSBpZiB0aGUgQlFMIGlzIGhlbGQuCgpUaGUgZnVuY3Rpb24gaXMgbW92ZWQgdG8g
YWlvLXdhaXQuaCBiZWNhdXNlIGl0IGlzIG1vc3RseSB1c2VkCnRoZXJlIGFuZCB0byBhdm9pZCBh
IGNpcmN1bGFyIHJlZmVyZW5jZSBiZXR3ZWVuIG1haW4tbG9vcC5oCmFuZCBibG9jay9haW8uaC4K
ClNpZ25lZC1vZmYtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+Ck1lc3Nh
Z2UtSWQ6IDwyMDIwMDQwNzE0MDc0Ni44MDQxLTUtcGJvbnppbmlAcmVkaGF0LmNvbT4KU2lnbmVk
LW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGluY2x1
ZGUvYmxvY2svYWlvLXdhaXQuaCB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUv
YmxvY2svYWlvLmggICAgICB8IDI5ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCiAyIGZp
bGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvYmxvY2svYWlvLXdhaXQuaCBiL2luY2x1ZGUvYmxvY2svYWlvLXdhaXQuaApp
bmRleCBhZmVlYjE4Zjk1Li43MTZkMjYzOWRmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2Jsb2NrL2Fp
by13YWl0LmgKKysrIGIvaW5jbHVkZS9ibG9jay9haW8td2FpdC5oCkBAIC0yNiw2ICsyNiw3IEBA
CiAjZGVmaW5lIFFFTVVfQUlPX1dBSVRfSAogCiAjaW5jbHVkZSAiYmxvY2svYWlvLmgiCisjaW5j
bHVkZSAicWVtdS9tYWluLWxvb3AuaCIKIAogLyoqCiAgKiBBaW9XYWl0OgpAQCAtMTI0LDQgKzEy
NSwyNSBAQCB2b2lkIGFpb193YWl0X2tpY2sodm9pZCk7CiAgKi8KIHZvaWQgYWlvX3dhaXRfYmhf
b25lc2hvdChBaW9Db250ZXh0ICpjdHgsIFFFTVVCSEZ1bmMgKmNiLCB2b2lkICpvcGFxdWUpOwog
CisvKioKKyAqIGluX2Fpb19jb250ZXh0X2hvbWVfdGhyZWFkOgorICogQGN0eDogdGhlIGFpbyBj
b250ZXh0CisgKgorICogUmV0dXJuIHdoZXRoZXIgd2UgYXJlIHJ1bm5pbmcgaW4gdGhlIHRocmVh
ZCB0aGF0IG5vcm1hbGx5IHJ1bnMgQGN0eC4gIE5vdGUKKyAqIHRoYXQgYWNxdWlyaW5nL3JlbGVh
c2luZyBjdHggZG9lcyBub3QgYWZmZWN0IHRoZSBvdXRjb21lLCBlYWNoIEFpb0NvbnRleHQKKyAq
IHN0aWxsIG9ubHkgaGFzIG9uZSBob21lIHRocmVhZCB0aGF0IGlzIHJlc3BvbnNpYmxlIGZvciBy
dW5uaW5nIGl0LgorICovCitzdGF0aWMgaW5saW5lIGJvb2wgaW5fYWlvX2NvbnRleHRfaG9tZV90
aHJlYWQoQWlvQ29udGV4dCAqY3R4KQoreworICAgIGlmIChjdHggPT0gcWVtdV9nZXRfY3VycmVu
dF9haW9fY29udGV4dCgpKSB7CisgICAgICAgIHJldHVybiB0cnVlOworICAgIH0KKworICAgIGlm
IChjdHggPT0gcWVtdV9nZXRfYWlvX2NvbnRleHQoKSkgeworICAgICAgICByZXR1cm4gcWVtdV9t
dXRleF9pb3RocmVhZF9sb2NrZWQoKTsKKyAgICB9IGVsc2UgeworICAgICAgICByZXR1cm4gZmFs
c2U7CisgICAgfQorfQorCiAjZW5kaWYgLyogUUVNVV9BSU9fV0FJVF9IICovCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2Jsb2NrL2Fpby5oIGIvaW5jbHVkZS9ibG9jay9haW8uaAppbmRleCBjYjE5ODkx
MDVhLi42MmVkOTU0MzQ0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2Jsb2NrL2Fpby5oCisrKyBiL2lu
Y2x1ZGUvYmxvY2svYWlvLmgKQEAgLTEzMywxMiArMTMzLDE2IEBAIHN0cnVjdCBBaW9Db250ZXh0
IHsKICAgICBBaW9IYW5kbGVyTGlzdCBkZWxldGVkX2Fpb19oYW5kbGVyczsKIAogICAgIC8qIFVz
ZWQgdG8gYXZvaWQgdW5uZWNlc3NhcnkgZXZlbnRfbm90aWZpZXJfc2V0IGNhbGxzIGluIGFpb19u
b3RpZnk7Ci0gICAgICogYWNjZXNzZWQgd2l0aCBhdG9taWMgcHJpbWl0aXZlcy4gIElmIHRoaXMg
ZmllbGQgaXMgMCwgZXZlcnl0aGluZwotICAgICAqIChmaWxlIGRlc2NyaXB0b3JzLCBib3R0b20g
aGFsdmVzLCB0aW1lcnMpIHdpbGwgYmUgcmUtZXZhbHVhdGVkCi0gICAgICogYmVmb3JlIHRoZSBu
ZXh0IGJsb2NraW5nIHBvbGwoKSwgdGh1cyB0aGUgZXZlbnRfbm90aWZpZXJfc2V0IGNhbGwKLSAg
ICAgKiBjYW4gYmUgc2tpcHBlZC4gIElmIGl0IGlzIG5vbi16ZXJvLCB5b3UgbWF5IG5lZWQgdG8g
d2FrZSB1cCBhCi0gICAgICogY29uY3VycmVudCBhaW9fcG9sbCBvciB0aGUgZ2xpYiBtYWluIGV2
ZW50IGxvb3AsIG1ha2luZwotICAgICAqIGV2ZW50X25vdGlmaWVyX3NldCBuZWNlc3NhcnkuCisg
ICAgICogb25seSB3cml0dGVuIGZyb20gdGhlIEFpb0NvbnRleHQgaG9tZSB0aHJlYWQsIG9yIHVu
ZGVyIHRoZSBCUUwgaW4KKyAgICAgKiB0aGUgY2FzZSBvZiB0aGUgbWFpbiBBaW9Db250ZXh0LiAg
SG93ZXZlciwgaXQgaXMgcmVhZCBmcm9tIGFueQorICAgICAqIHRocmVhZCBzbyBpdCBpcyBzdGls
bCBhY2Nlc3NlZCB3aXRoIGF0b21pYyBwcmltaXRpdmVzLgorICAgICAqCisgICAgICogSWYgdGhp
cyBmaWVsZCBpcyAwLCBldmVyeXRoaW5nIChmaWxlIGRlc2NyaXB0b3JzLCBib3R0b20gaGFsdmVz
LAorICAgICAqIHRpbWVycykgd2lsbCBiZSByZS1ldmFsdWF0ZWQgYmVmb3JlIHRoZSBuZXh0IGJs
b2NraW5nIHBvbGwoKSBvcgorICAgICAqIGlvX3VyaW5nIHdhaXQ7IHRoZXJlZm9yZSwgdGhlIGV2
ZW50X25vdGlmaWVyX3NldCBjYWxsIGNhbiBiZQorICAgICAqIHNraXBwZWQuICBJZiBpdCBpcyBu
b24temVybywgeW91IG1heSBuZWVkIHRvIHdha2UgdXAgYSBjb25jdXJyZW50CisgICAgICogYWlv
X3BvbGwgb3IgdGhlIGdsaWIgbWFpbiBldmVudCBsb29wLCBtYWtpbmcgZXZlbnRfbm90aWZpZXJf
c2V0CisgICAgICogbmVjZXNzYXJ5LgogICAgICAqCiAgICAgICogQml0IDAgaXMgcmVzZXJ2ZWQg
Zm9yIEdTb3VyY2UgdXNhZ2Ugb2YgdGhlIEFpb0NvbnRleHQsIGFuZCBpcyAxCiAgICAgICogYmV0
d2VlbiBhIGNhbGwgdG8gYWlvX2N0eF9wcmVwYXJlIGFuZCB0aGUgbmV4dCBjYWxsIHRvIGFpb19j
dHhfY2hlY2suCkBAIC02ODEsMTkgKzY4NSw2IEBAIHZvaWQgYWlvX2NvX2VudGVyKEFpb0NvbnRl
eHQgKmN0eCwgc3RydWN0IENvcm91dGluZSAqY28pOwogICovCiBBaW9Db250ZXh0ICpxZW11X2dl
dF9jdXJyZW50X2Fpb19jb250ZXh0KHZvaWQpOwogCi0vKioKLSAqIGluX2Fpb19jb250ZXh0X2hv
bWVfdGhyZWFkOgotICogQGN0eDogdGhlIGFpbyBjb250ZXh0Ci0gKgotICogUmV0dXJuIHdoZXRo
ZXIgd2UgYXJlIHJ1bm5pbmcgaW4gdGhlIHRocmVhZCB0aGF0IG5vcm1hbGx5IHJ1bnMgQGN0eC4g
IE5vdGUKLSAqIHRoYXQgYWNxdWlyaW5nL3JlbGVhc2luZyBjdHggZG9lcyBub3QgYWZmZWN0IHRo
ZSBvdXRjb21lLCBlYWNoIEFpb0NvbnRleHQKLSAqIHN0aWxsIG9ubHkgaGFzIG9uZSBob21lIHRo
cmVhZCB0aGF0IGlzIHJlc3BvbnNpYmxlIGZvciBydW5uaW5nIGl0LgotICovCi1zdGF0aWMgaW5s
aW5lIGJvb2wgaW5fYWlvX2NvbnRleHRfaG9tZV90aHJlYWQoQWlvQ29udGV4dCAqY3R4KQotewot
ICAgIHJldHVybiBjdHggPT0gcWVtdV9nZXRfY3VycmVudF9haW9fY29udGV4dCgpOwotfQotCiAv
KioKICAqIGFpb19jb250ZXh0X3NldHVwOgogICogQGN0eDogdGhlIGFpbyBjb250ZXh0Ci0tIAoy
LjI1LjEKCg==


