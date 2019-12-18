Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DE7C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E034C21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF2pFPF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E034C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYOc-00032T-D8
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3J-0006Vx-5r
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3F-00016n-8b
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:40 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44234)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3E-000138-Up
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:37 -0500
Received: by mail-wr1-x42e.google.com with SMTP id q10so1984378wrm.11
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=eX9q8umIrXfd/sk2F6QDWc9JJlH4gBHHbDDQi+DXr74=;
 b=WF2pFPF6046r/94+RXAsFrjvf99tn68ygwUA/3wE+AXgvZgD5C3NbfjkQPJQd+9pS5
 hbhGOS3s3D/BEG+zyaLlyjDFxZsKSpoLcxG26BaW47xGLoYm3WVW8dgKAgVff4D7ow3D
 jPqkBM73c0oMKfTE17GEtXRa6/q7ZOAlvfBjQ3nwDJ37Gjri3qJ2jwJYwGFwceeyMAqC
 4UvKdM4Xbv5Ng3G41HmGhzexqDGe+3fAGEod9tFsSe4ah4gCSITV/IJZtsLc5OcnY/69
 9G6jivNK6TGBgDJVnGfA5wMvG1OMMP44aZJsrQjjoRXB80+jmI/Tw2dRuMMRI5gA3sCc
 b6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=eX9q8umIrXfd/sk2F6QDWc9JJlH4gBHHbDDQi+DXr74=;
 b=H7USb3bs4OqnKHfXh7t3lCqudMB1DOW3Z7pc01b5pdzOc65bRb1JjB3GO1FnQH5QT6
 GcjbOVwFzco3fuQd5bBmqfGLkYP/OZN0HaM/DsxLXW9U6sh+VbN90tqruADMsgr5JwYF
 FxnQCa/QijK6XZpt2E6OKHiG8J23qwIl6fWIwzLLWk2cy/1fVqdNlMNDLtcHv2gU0+Kw
 QoZylaeyXpOT+XEws/4txjOFB2nLjbptAN02MtBsKy6Y14U1MLJz+iGO2AZRUYoDATs2
 sXo4YN14TUOAl1ZrUz9hdmdOtR5ANetI+l967BNhPlE7Y6M8L8THiVug6upfkYeWE9Rw
 39QA==
X-Gm-Message-State: APjAAAXzKKMVDCcK000Vk/oJ2Br4cqX/e/vG1P0AkeBrbBLUEK6d+kwq
 dViddAgOwAGMMltqeNHRh/uAsO0U
X-Google-Smtp-Source: APXvYqwWIGQadIUjviFhD2SIc7xN7alqSD5fNrkcwVRIGIhWuEFN76RXxmcM/mjDBRZZZsOQITYUJQ==
X-Received: by 2002:adf:d184:: with SMTP id v4mr2489334wrc.76.1576670615832;
 Wed, 18 Dec 2019 04:03:35 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/87] stubs: replace stubs with lnot if applicable
Date: Wed, 18 Dec 2019 13:02:07 +0100
Message-Id: <1576670573-48048-42-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
index 6807c8b..02bf5ce 100644
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



