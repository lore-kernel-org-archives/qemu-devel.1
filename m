Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75536C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41338214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hugI2/x9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41338214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOas-0002pD-6p
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyo-0004Bz-14
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNym-0007dV-Ri
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:05 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNym-0007cI-LQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:04 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so2237595wmj.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RS88mU43BsDZbLTvz1eJVFNOqAsGkQFJZ4GvFL4UvXA=;
 b=hugI2/x9I8/d0IXYnMFRH8R0tX3jV1jKnVKvX3pZh6rDSDQMmkVRmAzHMK77bAkhlj
 loGGb6eqVKC9qW1Fx9Zkh5e56RWW09Z8oaLB6egumUHM7u2oiuWNcN05R/9+CKfxcZUV
 rdHzSUyGM4AHWCKKzxU/knEinGh++ibWFFvocOSL79ckZX6jIV85RPTMpLwUMsg/QQWW
 G+30DXk1EYg2pRfIDPiaIQNVrHnFIk0lRbFtIHjkRNJ5isZnoErO7ZaocS+zHOFIvo4G
 Cp6tuF0KeN1NVUQuexOJPCGgQS0uAykRYnA/LsooAPdGe7L8eG7LZ2Ioh1B053LWlj/t
 wZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RS88mU43BsDZbLTvz1eJVFNOqAsGkQFJZ4GvFL4UvXA=;
 b=GAxP4NA+uZMPO7s0wwhAd0pSAjtWxrmBwN31sPL4yc3f8soVmsKMJl2ZDtS+sRwRBh
 heV3+VXlQzNjtxCaj4lZH70DjshsqzxSloz6Hw90LYL24v90dRX7/dioMK+S2T3DCYtH
 KXEk0n6nr+dabWeKeaCsUJsXLoubihRwlwKjJJqo53qde8niI3/q02GkEBT1S5nSS627
 7Dh3VKHKj9X0yZpDrM7JqF8u6jplm2co2jo7BT5PQS+5lydISqTEAPSaF3pLDdnhVTC+
 eVlcVU8cOhRhE/Q6qsQEkDb0WtSe3jxmrmjxC46dUsYLG4kTggN6pN1bq9vFHcwIFSj/
 Bkmw==
X-Gm-Message-State: APjAAAX/cEaSmxHypzpEHvpGONTe5ECyn+GbElumyUVWYJFVPM7MnrQq
 jl7vQy4K0ZsPEiC869e4hvyBcxkO
X-Google-Smtp-Source: APXvYqyvROj8f0kYG9Sw7eUOXpETsBfdfL3hLOOILpAk0GloBS9tG1/AYF0ZZuxuZNfdMQgZCyv9sg==
X-Received: by 2002:a1c:286:: with SMTP id 128mr6207124wmc.176.1576155243366; 
 Thu, 12 Dec 2019 04:54:03 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 065/132] meson: convert hw/semihosting
Date: Thu, 12 Dec 2019 13:51:49 +0100
Message-Id: <1576155176-2464-66-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs             | 1 -
 hw/meson.build               | 1 +
 hw/semihosting/Makefile.objs | 2 --
 hw/semihosting/meson.build   | 4 ++++
 4 files changed, 5 insertions(+), 3 deletions(-)
 delete mode 100644 hw/semihosting/Makefile.objs
 create mode 100644 hw/semihosting/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 2ef93e7..1e23cb9 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
-devices-dirs-y += semihosting/
 devices-dirs-y += smbios/
 endif
 
diff --git a/hw/meson.build b/hw/meson.build
index fe7c466..66a2f6c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,2 +1,3 @@
 subdir('core')
+subdir('semihosting')
 subdir('xen')
diff --git a/hw/semihosting/Makefile.objs b/hw/semihosting/Makefile.objs
deleted file mode 100644
index 4ad47c0..0000000
--- a/hw/semihosting/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_SEMIHOSTING) += config.o
-obj-$(CONFIG_SEMIHOSTING) += console.o
diff --git a/hw/semihosting/meson.build b/hw/semihosting/meson.build
new file mode 100644
index 0000000..f40ac57
--- /dev/null
+++ b/hw/semihosting/meson.build
@@ -0,0 +1,4 @@
+specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
+  'config.c',
+  'console.c',
+))
-- 
1.8.3.1



