Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C47C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37712206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqdZjdVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37712206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igteq-0003lk-Pw
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFT-0005bK-O9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFR-0008Kb-Kz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:31 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFR-0008IP-Eh
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:29 -0500
Received: by mail-wm1-x336.google.com with SMTP id t14so7386208wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=tBpzfzYqe4L+iQBP0UHondSvsbeR1HdqnLiLfCq4g+Y=;
 b=oqdZjdVGD3BPUbUAzOAmgbU34kJUgAG3HwoZZVOtlcJaybQGJmK7D0N5S47IQ1geM4
 DlqhM3NFaxYsN4qLZxCBzPKoirIl5y+yJZ4vC7NHH0Ca5vV6vOyd0xyD5Rpf6wHTxOs/
 rngT6v6cK73jz23o8lxms9iPdvzLmC3oWUoBA2jAkV0HIW5eJMm2UH1/knXLSKmHdNdw
 NPn0h+4hQlRc7VFjRCEaCmf1/r3XKaO7NYtFLp3oVs27/Xbzbz6vx8IsZrC4Ry/lG9Q7
 U8MhX/n5iB6b92aeCrFylppdsPOyz8QDvho2z8/r818EibuiOpmI7MOXaJi5YfIRGVix
 yhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=tBpzfzYqe4L+iQBP0UHondSvsbeR1HdqnLiLfCq4g+Y=;
 b=MuN22tJhoMRaCJyHn2jhsfqxmPKzT/+SVe4OASBWVQEDegUTwP4grW21B4ftZMf9kI
 V6MblTWQbS4TLo3kHmFnFZl23KgUR/yJm8hDkv7qCyYcmh4sax7elQsljEJrQsDRNboj
 vSOwgsVR1+UMjRZdY2GoClKW+FZp6mT7EfvGKVNLWsoVtK6VkdO0n/nU6DEGjeqPoX6A
 jwl8yX/cwsLc5jUdgvEfg5JpKZoOusf2CuPSlEO/CXGvLs3QfExFzVK8nji7Iolxdkq3
 5/8n+cQUzRMYgOupmOStqv44t9hzifcnXgt5Mo2DjhNea8WkK2qFVQKkxOqiesBCg6mB
 5Ovw==
X-Gm-Message-State: APjAAAVJAdhFglRRQ0xdxYMtxQpw54ij4nGhOzpTRia6CJ3BxMLVHdyE
 xmvLEwYEn5cRgWLjxm4Hniy6UQFc
X-Google-Smtp-Source: APXvYqzvglUAB/J7X5EiaaeKHt6LqpuiLVywXEb0HzvX9L3XYAZ0aXm513rXkQNz/yY4/z9Rqgh0og==
X-Received: by 2002:a05:600c:2c0b:: with SMTP id
 q11mr13665565wmg.2.1576513768210; 
 Mon, 16 Dec 2019 08:29:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/62] stubs: replace stubs with lnot if applicable
Date: Mon, 16 Dec 2019 17:28:25 +0100
Message-Id: <1576513726-53700-42-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

The stubs mechanism relies on static libraries and compilation order,
which is a bit brittle and should be avoided unless necessary.
Replace it with Boolean operations on CONFIG_* symbols.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs        | 2 +-
 crypto/Makefile.objs | 3 +--
 util/Makefile.objs   | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index e33e992..7b179d1 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,6 +1,6 @@
 #######################################################################
 # Common libraries for tools and emulators
-stub-obj-y = stubs/ util/ crypto/
+stub-obj-y = stubs/
 util-obj-y = crypto/ util/ qobject/ qapi/
 
 chardev-obj-y = chardev/
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 58014d1..c2a371b 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -22,6 +22,7 @@ crypto-obj-y += secret.o
 crypto-obj-y += pbkdf.o
 crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
+crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += pbkdf-stub.o
 crypto-obj-y += ivgen.o
 crypto-obj-y += ivgen-essiv.o
 crypto-obj-y += ivgen-plain.o
@@ -32,8 +33,6 @@ crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
 
-stub-obj-y += pbkdf-stub.o
-
 util-obj-$(CONFIG_GCRYPT) += random-gcrypt.o
 util-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) += random-gnutls.o
 util-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) += random-platform.o
diff --git a/util/Makefile.objs b/util/Makefile.objs
index df124af..63599d6 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -52,8 +52,7 @@ util-obj-y += stats64.o
 util-obj-y += systemd.o
 util-obj-y += iova-tree.o
 util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
+util-obj-$(call lnot,$(CONFIG_INOTIFY1)) += filemonitor-stub.o
 util-obj-$(CONFIG_LINUX) += vfio-helpers.o
 util-obj-$(CONFIG_POSIX) += drm.o
 util-obj-y += guest-random.o
-
-stub-obj-y += filemonitor-stub.o
-- 
1.8.3.1



