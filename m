Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4672C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE3C21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPXKFomG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE3C21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47bR-00086O-Ih
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j47aZ-0006kY-01
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j47aX-0002yA-HE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:27:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45932
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j47aX-0002wK-Bq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582050436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=77yczecx9ftaGGKdhEtcVK6iE2fCQfNto9il6wVIzig=;
 b=WPXKFomGj96EIkuWydCYA8x7/GB3YYr0TsUmVQpJGcgDvf7t/rmjlK+sMf+B8cFPLyVH/X
 spxAKK4OU+ttmihe3p3qWi4Ux1V4RU7PVxgo3a2le9tMVrSrggIiW280cnpK7g67gyZ8nT
 ArByuDNFZ3z6fK72iQeBuudyGWB7v20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-BKdLrWRGOpuWMGFx7PSu9A-1; Tue, 18 Feb 2020 13:27:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83BB48017CC;
 Tue, 18 Feb 2020 18:27:13 +0000 (UTC)
Received: from localhost (unknown [10.36.118.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E6D319756;
 Tue, 18 Feb 2020 18:27:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] aio-posix: avoid reacquiring rcu_read_lock() when polling
Date: Tue, 18 Feb 2020 18:27:08 +0000
Message-Id: <20200218182708.914552-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: BKdLrWRGOpuWMGFx7PSu9A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZpcnN0IHJjdV9yZWFkX2xvY2svdW5sb2NrKCkgaXMgZXhwZW5zaXZlLiAgTmVzdGVkIGNh
bGxzIGFyZSBjaGVhcC4KClRoaXMgb3B0aW1pemF0aW9uIGluY3JlYXNlcyBJT1BTIGZyb20gNzNr
IHRvIDE2Mmsgd2l0aCBhIExpbnV4IGd1ZXN0CnRoYXQgaGFzIDIgdmlydGlvLWJsayxudW0tcXVl
dWVzPTEgYW5kIDk5IHZpcnRpby1ibGssbnVtLXF1ZXVlcz0zMgpkZXZpY2VzLgoKU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvYWlv
LXBvc2l4LmMgfCAxMSArKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS91dGlsL2Fpby1wb3NpeC5jIGIvdXRpbC9haW8tcG9zaXguYwppbmRl
eCBhNDk3N2Y1MzhlLi5mNjdmNWIzNGU5IDEwMDY0NAotLS0gYS91dGlsL2Fpby1wb3NpeC5jCisr
KyBiL3V0aWwvYWlvLXBvc2l4LmMKQEAgLTE1LDYgKzE1LDcgQEAKIAogI2luY2x1ZGUgInFlbXUv
b3NkZXAuaCIKICNpbmNsdWRlICJibG9jay9ibG9jay5oIgorI2luY2x1ZGUgInFlbXUvcmN1Lmgi
CiAjaW5jbHVkZSAicWVtdS9yY3VfcXVldWUuaCIKICNpbmNsdWRlICJxZW11L3NvY2tldHMuaCIK
ICNpbmNsdWRlICJxZW11L2N1dGlscy5oIgpAQCAtNTE0LDYgKzUxNSwxNiBAQCBzdGF0aWMgYm9v
bCBydW5fcG9sbF9oYW5kbGVyc19vbmNlKEFpb0NvbnRleHQgKmN0eCwgaW50NjRfdCAqdGltZW91
dCkKICAgICBib29sIHByb2dyZXNzID0gZmFsc2U7CiAgICAgQWlvSGFuZGxlciAqbm9kZTsKIAor
ICAgIC8qCisgICAgICogT3B0aW1pemF0aW9uOiAtPmlvX3BvbGwoKSBoYW5kbGVycyBvZnRlbiBj
b250YWluIFJDVSByZWFkIGNyaXRpY2FsCisgICAgICogc2VjdGlvbnMgYW5kIHdlIHRoZXJlZm9y
ZSBzZWUgbWFueSByY3VfcmVhZF9sb2NrKCkgLT4gcmN1X3JlYWRfdW5sb2NrKCkKKyAgICAgKiAt
PiByY3VfcmVhZF9sb2NrKCkgLT4gLi4uIHNlcXVlbmNlcyB3aXRoIGV4cGVuc2l2ZSBtZW1vcnkK
KyAgICAgKiBzeW5jaHJvbml6YXRpb24gcHJpbWl0aXZlcy4gIE1ha2UgdGhlIGVudGlyZSBwb2xs
aW5nIGxvb3AgYW4gUkNVCisgICAgICogY3JpdGljYWwgc2VjdGlvbiBiZWNhdXNlIG5lc3RlZCBy
Y3VfcmVhZF9sb2NrKCkvcmN1X3JlYWRfdW5sb2NrKCkgY2FsbHMKKyAgICAgKiBhcmUgY2hlYXAu
CisgICAgICovCisgICAgUkNVX1JFQURfTE9DS19HVUFSRCgpOworCiAgICAgUUxJU1RfRk9SRUFD
SF9SQ1Uobm9kZSwgJmN0eC0+YWlvX2hhbmRsZXJzLCBub2RlKSB7CiAgICAgICAgIGlmICghbm9k
ZS0+ZGVsZXRlZCAmJiBub2RlLT5pb19wb2xsICYmCiAgICAgICAgICAgICBhaW9fbm9kZV9jaGVj
ayhjdHgsIG5vZGUtPmlzX2V4dGVybmFsKSAmJgotLSAKMi4yNC4xCgo=


