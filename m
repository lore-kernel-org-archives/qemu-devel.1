Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AABCC35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F40206E2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwNqEBB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F40206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QZs-0005XH-7S
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QWo-00080b-Fg
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QWn-0000c4-E9
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:52:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53682
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QWn-0000bt-9u
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55oTC4xDyElzZCjyv3/NkspkFng+VS8ekFLzonhjjWI=;
 b=RwNqEBB8ZH2sexsidMSnB+5lKIBf/MCgPWH6azkilvViAsmq78GcgjwmLKdLCtO35rMJ4F
 wJSJf5cwn8oyxVPDz8B87txm7utoSnTZ3RPQYW7LIiclzxmGILaC9otl1z1W7T8km4ImA2
 po3vOzOsyXC/TYRTbQBFXTyzti6JJsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-nq_utKbXN3-0KP-QVBkFzQ-1; Sat, 22 Feb 2020 03:52:47 -0500
X-MC-Unique: nq_utKbXN3-0KP-QVBkFzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 630D513E2;
 Sat, 22 Feb 2020 08:52:45 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EFA75C105;
 Sat, 22 Feb 2020 08:52:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/31] module: check module wasn't already initialized
Date: Sat, 22 Feb 2020 08:50:11 +0000
Message-Id: <20200222085030.1760640-13-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Darren Kenny <darren.kenny@oracle.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpUaGUgdmlydHVhbC1kZXZp
Y2UgZnV6emVyIG11c3QgaW5pdGlhbGl6ZSBRT00sIHByaW9yIHRvIHJ1bm5pbmcKdmw6cWVtdV9p
bml0LCBzbyB0aGF0IGl0IGNhbiB1c2UgdGhlIHFvc19ncmFwaCB0byBpZGVudGlmeSB0aGUgYXJn
dW1lbnRzCnJlcXVpcmVkIHRvIGluaXRpYWxpemUgYSBndWVzdCBmb3IgbGlicW9zLWFzc2lzdGVk
IGZ1enppbmcuIFRoaXMgY2hhbmdlCnByZXZlbnRzIGVycm9ycyB3aGVuIHZsOnFlbXVfaW5pdCB0
cmllcyB0byAocmUpaW5pdGlhbGl6ZSB0aGUgcHJldmlvdXNseQppbml0aWFsaXplZCBRT00gbW9k
dWxlLgoKU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+ClJl
dmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2Vk
LWJ5OiBEYXJyZW4gS2VubnkgPGRhcnJlbi5rZW5ueUBvcmFjbGUuY29tPgpSZXZpZXdlZC1ieTog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAy
MDIwMDIyMDA0MTExOC4yMzI2NC00LWFseG5kckBidS5lZHUKU2lnbmVkLW9mZi1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvbW9kdWxlLmMgfCA3ICsr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS91dGls
L21vZHVsZS5jIGIvdXRpbC9tb2R1bGUuYwppbmRleCA4YzUzMTVhN2EzLi4yMzZhN2JiNTJhIDEw
MDY0NAotLS0gYS91dGlsL21vZHVsZS5jCisrKyBiL3V0aWwvbW9kdWxlLmMKQEAgLTMwLDYgKzMw
LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgTW9kdWxlRW50cnkKIHR5cGVkZWYgUVRBSUxRX0hFQUQoLCBN
b2R1bGVFbnRyeSkgTW9kdWxlVHlwZUxpc3Q7CiAKIHN0YXRpYyBNb2R1bGVUeXBlTGlzdCBpbml0
X3R5cGVfbGlzdFtNT0RVTEVfSU5JVF9NQVhdOworc3RhdGljIGJvb2wgbW9kdWxlc19pbml0X2Rv
bmVbTU9EVUxFX0lOSVRfTUFYXTsKIAogc3RhdGljIE1vZHVsZVR5cGVMaXN0IGRzb19pbml0X2xp
c3Q7CiAKQEAgLTkxLDExICs5MiwxNyBAQCB2b2lkIG1vZHVsZV9jYWxsX2luaXQobW9kdWxlX2lu
aXRfdHlwZSB0eXBlKQogICAgIE1vZHVsZVR5cGVMaXN0ICpsOwogICAgIE1vZHVsZUVudHJ5ICpl
OwogCisgICAgaWYgKG1vZHVsZXNfaW5pdF9kb25lW3R5cGVdKSB7CisgICAgICAgIHJldHVybjsK
KyAgICB9CisKICAgICBsID0gZmluZF90eXBlKHR5cGUpOwogCiAgICAgUVRBSUxRX0ZPUkVBQ0go
ZSwgbCwgbm9kZSkgewogICAgICAgICBlLT5pbml0KCk7CiAgICAgfQorCisgICAgbW9kdWxlc19p
bml0X2RvbmVbdHlwZV0gPSB0cnVlOwogfQogCiAjaWZkZWYgQ09ORklHX01PRFVMRVMKLS0gCjIu
MjQuMQoK


