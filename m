Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB40C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B6321655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpbc/8Rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B6321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOxe-0005xC-Bu
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz4-0004bu-CW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz3-00086Q-7s
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNz3-00085A-1L
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id d73so2254549wmd.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mu6uKBj23GfwgLLtrI1LQgebtJ3PayuYBhfAScWqBhc=;
 b=Lpbc/8Rjn+Wr7NKvGR/My43oDQn/nix3hE/0SCMSEfk+u21gObbAz2PXNdT002tvVG
 TKTfX05gEepb7UhXPZy2EDUb/8jukYkw8Z/FrBRkUqgBwkL0VthxHmlaMLqplNi03snt
 zZVJgF7cdNlDB99go9AxvCeWzASmQClWDeSsNvlSJCJC8iQcohU7n2EY5MIHQlwmt/PV
 jR8vJnSWFiNNa/o16xdIYvwmnXNOTVnXfN+WlTYqwHpv4Qzrm61SHvRavG8Shdpv8apQ
 EIJHjawV41bF+rJ3TWFFxmZPS8T53be02kpVw5SggJm9JRME8cZ9hrt9AlS6httIV4jV
 22mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mu6uKBj23GfwgLLtrI1LQgebtJ3PayuYBhfAScWqBhc=;
 b=F21Mvvu3plMXoNxwT7bzfY/QPioups6/zbLp6aDXUJw/kgp3HwFUb1wnQji3AXqHBW
 xGiJY6lnyNmLqwAqxij39Dh2yvX8ArVZ/XD+SM+9wocPwTtEF5Uv6UVaMa+hjuetsQE/
 xN3eyUxUWY6NiNVkRgYVfG0fLObTK++TWjGsyS2BXTOMw1FUJIdRMAfkNDjHFypPn1oP
 lZjUIxrWnNpcUV7BH4voUHM+cK5OLhKY+rkt6DLkKleMDeAhTgLBDpSYAkxVgVwv08BP
 IUXPOFkfXYHj/fp6+ih2Ro58bmlMD2fyVB29NEptDoK+opU9vFq57mQOvjUP/+sBVSCU
 SYRQ==
X-Gm-Message-State: APjAAAWfv0FZemrnkuyRt09jt+lEj9xI4TIl3dUwhF0RsA4NWYrNHmCS
 slRfoniFoa6b37N5SahGvy2gDZSY
X-Google-Smtp-Source: APXvYqwnbxutPIv2whsrmxqhgb4ooXWL575xzOmLx6pgMojvTNct94bBq/M+QefTPvYhedcfwHDdmg==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr6379579wmc.126.1576155259892; 
 Thu, 12 Dec 2019 04:54:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 082/132] meson: convert hw/rdma
Date: Thu, 12 Dec 2019 13:52:06 +0100
Message-Id: <1576155176-2464-83-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
 hw/Makefile.objs      |  1 -
 hw/meson.build        |  1 +
 hw/rdma/Makefile.objs |  3 ---
 hw/rdma/meson.build   | 10 ++++++++++
 4 files changed, 11 insertions(+), 4 deletions(-)
 delete mode 100644 hw/rdma/Makefile.objs
 create mode 100644 hw/rdma/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6ce70d5..4903808 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -20,7 +20,6 @@ devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-y += isa/
 devices-dirs-y += misc/
 devices-dirs-y += net/
-devices-dirs-y += rdma/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 0c528e5..56e6057 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -5,6 +5,7 @@ subdir('pci')
 subdir('pci-bridge')
 subdir('pci-host')
 subdir('pcmcia')
+subdir('rdma')
 subdir('scsi')
 subdir('sd')
 subdir('semihosting')
diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
deleted file mode 100644
index 819bb12..0000000
--- a/hw/rdma/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-$(CONFIG_VMW_PVRDMA) += rdma_utils.o rdma_backend.o rdma_rm.o rdma.o
-obj-$(CONFIG_VMW_PVRDMA) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
-                     vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o
diff --git a/hw/rdma/meson.build b/hw/rdma/meson.build
new file mode 100644
index 0000000..7325f40
--- /dev/null
+++ b/hw/rdma/meson.build
@@ -0,0 +1,10 @@
+specific_ss.add(when: 'CONFIG_VMW_PVRDMA', if_true: files(
+  'rdma.c',
+  'rdma_backend.c',
+  'rdma_rm.c',
+  'rdma_utils.c',
+  'vmw/pvrdma_cmd.c',
+  'vmw/pvrdma_dev_ring.c',
+  'vmw/pvrdma_main.c',
+  'vmw/pvrdma_qp_ops.c',
+))
-- 
1.8.3.1



