Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D3C3B1A1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9952A222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/sJXipq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9952A222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ef9-0007ZB-SA
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2eb8-0001At-E1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2eb7-0007bq-C0
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52406
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2eb7-0007bB-89
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581700668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eASxJapIrJ7Wu9AyB2H0naFmKyv7JMS1os8B2nbIQDA=;
 b=P/sJXipqv9WO9lrznhw+SvtnYZwkPU8P87Xs0o2jf6kcpqFEu5VsXoUTqd3Gm1ob4OlDnc
 A5YqSf+YDGpIhWs0ldx27N+3dsHeN6Kk1xn01OO0NOHjV4bCmE/ZNaNScXwijjIDQVqD6x
 SBweZ4KqWldOYO691PU8CPsYq1m8UYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-vCCuurZsOGyua8N-nfDS6g-1; Fri, 14 Feb 2020 12:17:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A613DBA9;
 Fri, 14 Feb 2020 17:17:40 +0000 (UTC)
Received: from localhost (ovpn-116-135.ams2.redhat.com [10.36.116.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B65AC1001DD8;
 Fri, 14 Feb 2020 17:17:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] qemu/queue.h: add QLIST_SAFE_REMOVE()
Date: Fri, 14 Feb 2020 17:17:10 +0000
Message-Id: <20200214171712.541358-4-stefanha@redhat.com>
In-Reply-To: <20200214171712.541358-1-stefanha@redhat.com>
References: <20200214171712.541358-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: vCCuurZsOGyua8N-nfDS6g-1
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUxJU1RfUkVNT1ZFKCkgYXNzdW1lcyB0aGUgZWxlbWVudCBpcyBpbiBhIGxpc3QuICBJdCBhbHNv
IGxlYXZlcyB0aGUKZWxlbWVudCdzIGxpbmtlZCBsaXN0IHBvaW50ZXJzIGRhbmdsaW5nLgoKSW50
cm9kdWNlIGEgc2FmZSB2ZXJzaW9uIG9mIFFMSVNUX1JFTU9WRSgpIGFuZCBjb252ZXJ0IG9wZW4t
Y29kZWQKaW5zdGFuY2VzIG9mIHRoaXMgcGF0dGVybi4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBI
YWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBibG9jay5jICAgICAgICAgICAgICB8
ICA1ICstLS0tCiBjaGFyZGV2L3NwaWNlLmMgICAgICB8ICA0ICstLS0KIGluY2x1ZGUvcWVtdS9x
dWV1ZS5oIHwgMTQgKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9jay5jIGIvYmxvY2suYwppbmRl
eCA5YzgxMDUzNGQ2Li40ODRlMDFkMDQyIDEwMDY0NAotLS0gYS9ibG9jay5jCisrKyBiL2Jsb2Nr
LmMKQEAgLTI0OTksMTAgKzI0OTksNyBAQCBCZHJ2Q2hpbGQgKmJkcnZfYXR0YWNoX2NoaWxkKEJs
b2NrRHJpdmVyU3RhdGUgKnBhcmVudF9icywKIAogc3RhdGljIHZvaWQgYmRydl9kZXRhY2hfY2hp
bGQoQmRydkNoaWxkICpjaGlsZCkKIHsKLSAgICBpZiAoY2hpbGQtPm5leHQubGVfcHJldikgewot
ICAgICAgICBRTElTVF9SRU1PVkUoY2hpbGQsIG5leHQpOwotICAgICAgICBjaGlsZC0+bmV4dC5s
ZV9wcmV2ID0gTlVMTDsKLSAgICB9CisgICAgUUxJU1RfU0FGRV9SRU1PVkUoY2hpbGQsIG5leHQp
OwogCiAgICAgYmRydl9yZXBsYWNlX2NoaWxkKGNoaWxkLCBOVUxMKTsKIApkaWZmIC0tZ2l0IGEv
Y2hhcmRldi9zcGljZS5jIGIvY2hhcmRldi9zcGljZS5jCmluZGV4IDI0MWUyYjc3NzAuLmJmN2Vh
MWUyOTQgMTAwNjQ0Ci0tLSBhL2NoYXJkZXYvc3BpY2UuYworKysgYi9jaGFyZGV2L3NwaWNlLmMK
QEAgLTIxNiw5ICsyMTYsNyBAQCBzdGF0aWMgdm9pZCBjaGFyX3NwaWNlX2ZpbmFsaXplKE9iamVj
dCAqb2JqKQogCiAgICAgdm1jX3VucmVnaXN0ZXJfaW50ZXJmYWNlKHMpOwogCi0gICAgaWYgKHMt
Pm5leHQubGVfcHJldikgewotICAgICAgICBRTElTVF9SRU1PVkUocywgbmV4dCk7Ci0gICAgfQor
ICAgIFFMSVNUX1NBRkVfUkVNT1ZFKHMsIG5leHQpOwogCiAgICAgZ19mcmVlKChjaGFyICopcy0+
c2luLnN1YnR5cGUpOwogICAgIGdfZnJlZSgoY2hhciAqKXMtPnNpbi5wb3J0bmFtZSk7CmRpZmYg
LS1naXQgYS9pbmNsdWRlL3FlbXUvcXVldWUuaCBiL2luY2x1ZGUvcWVtdS9xdWV1ZS5oCmluZGV4
IDE5NDI1Zjk3M2YuLmEyNzYzNjMzNzIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvcWVtdS9xdWV1ZS5o
CisrKyBiL2luY2x1ZGUvcWVtdS9xdWV1ZS5oCkBAIC0xNDQsNiArMTQ0LDIwIEBAIHN0cnVjdCB7
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKICAgICAgICAgKihlbG0pLT5maWVsZC5sZV9wcmV2ID0gKGVsbSktPmZpZWxkLmxl
X25leHQ7ICAgICAgICAgICAgICAgICAgIFwKIH0gd2hpbGUgKC8qQ09OU1RDT05EKi8wKQogCisv
KgorICogTGlrZSBRTElTVF9SRU1PVkUoKSBidXQgc2FmZSB0byBjYWxsIHdoZW4gZWxtIGlzIG5v
dCBpbiBhIGxpc3QKKyAqLworI2RlZmluZSBRTElTVF9TQUZFX1JFTU9WRShlbG0sIGZpZWxkKSBk
byB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICBpZiAoKGVsbSktPmZp
ZWxkLmxlX3ByZXYgIT0gTlVMTCkgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAg
ICAgICAgICAgICAgIGlmICgoZWxtKS0+ZmllbGQubGVfbmV4dCAhPSBOVUxMKSAgICAgICAgICAg
ICAgICAgICAgICAgXAorICAgICAgICAgICAgICAgICAgICAgICAgKGVsbSktPmZpZWxkLmxlX25l
eHQtPmZpZWxkLmxlX3ByZXYgPSAgICAgICAgICAgXAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIChlbG0pLT5maWVsZC5sZV9wcmV2OyAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAg
ICAgICAgICAgICooZWxtKS0+ZmllbGQubGVfcHJldiA9IChlbG0pLT5maWVsZC5sZV9uZXh0OyAg
ICAgICAgICAgXAorICAgICAgICAgICAgICAgIChlbG0pLT5maWVsZC5sZV9uZXh0ID0gTlVMTDsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICAgICAgICAgIChlbG0pLT5maWVs
ZC5sZV9wcmV2ID0gTlVMTDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICB9
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXAorfSB3aGlsZSAoLypDT05TVENPTkQqLzApCisKICNkZWZpbmUgUUxJU1RfRk9SRUFD
SCh2YXIsIGhlYWQsIGZpZWxkKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAg
ICAgICAgZm9yICgodmFyKSA9ICgoaGVhZCktPmxoX2ZpcnN0KTsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAodmFyKTsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKLS0gCjIuMjQuMQoK


