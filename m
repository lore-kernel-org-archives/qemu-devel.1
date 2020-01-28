Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B55C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918D32467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYRE7vJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918D32467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWAu-0005W4-AB
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7L-0002uo-9f
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7J-00071B-3O
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:39 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7I-0006ux-5s
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id f129so3584613wmf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XeZsEiuXXzVwBMwjPhINKW9tDqdI5YQS5k8FKrjL0WI=;
 b=PYRE7vJCwniUqjOdDs9GjEexxikZnQh6pHhSEE9rxbmSkCPn/Es4/UMdKxPsphesG2
 E7Du1qeR9B/bVs0lpVUkTUeMxWCq7kdgAjbBPwE6C6QwtvK7hg6ackopDqHko+3KvBtm
 NuPxlREEf+tljqjWQcQMHvuqODNOzKE3Yic3fvMQHEqlaDQfUFBBHxCDUgQ7EkEfFsvR
 OPDJH82FQWX1oZMOyim2E+YO7hqJkjUkht8nKwMC7jK3g8e6IM5zDgCr+k92hYEipLXf
 xzsIeGokwtF9LqYn7ie+rRxw3MLsr+FNDkCLSNvoSdcKPm25ij8vrVPtLWo2GeOqd6xt
 a9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XeZsEiuXXzVwBMwjPhINKW9tDqdI5YQS5k8FKrjL0WI=;
 b=HzWH8I6e3OkS6wPlRkUsu5i3AAPUFZ0fyoFRIzEet2a25ySvzMLDyLhj9la1D/CcIs
 A5xIk6A8INy7fP+lqS002BWCE9mwlqfJO5VS4Slnt19aOBD4GGwrsXKAgEvUxAiMWzFC
 mtIy9RYpuEyFxpGpuMgANcH9wPR7USGPpFcsPUuGOPxsV8Hqx/M0myjucrE+KNJvYjH1
 z14SpZRY+kI25qEpearPNRs/lSG+nxNWbPA03iBakz/BBgbm6CInyTsJvCgWDwjfBKFW
 Rh/GYwkOM1w+TLi05CvZA6/Y/urbOtc8hch9UQhvkflZvgu04iO9LRVY9AGefJUfRDG1
 LRbQ==
X-Gm-Message-State: APjAAAVIFe7ooJl2nnfic2RGgcCTTccUY2JuFElRZEtePqJw0d7i+STQ
 oDDehj2k/8FukPkPIVKnirDqQuMG
X-Google-Smtp-Source: APXvYqwsBX8JzRBjnjEWIJztdk1A9uPZ1unTMoLwyWqEH/TH2wLlj4a9hAMG1EMqYaBa8dsL0m5o2w==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr6362743wmj.170.1580234251116; 
 Tue, 28 Jan 2020 09:57:31 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 095/142] meson: convert hw/ipack
Date: Tue, 28 Jan 2020 18:52:55 +0100
Message-Id: <20200128175342.9066-96-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs       | 1 -
 hw/ipack/Makefile.objs | 2 --
 hw/ipack/meson.build   | 1 +
 hw/meson.build         | 1 +
 4 files changed, 2 insertions(+), 3 deletions(-)
 delete mode 100644 hw/ipack/Makefile.objs
 create mode 100644 hw/ipack/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a2744ad4b9..7dee607489 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -14,7 +14,6 @@ devices-dirs-$(CONFIG_I2C) += i2c/
 devices-dirs-y += ide/
 devices-dirs-y += input/
 devices-dirs-y += intc/
-devices-dirs-$(CONFIG_IPACK) += ipack/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/ipack/Makefile.objs b/hw/ipack/Makefile.objs
deleted file mode 100644
index 8b9bdcb549..0000000000
--- a/hw/ipack/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-common-obj-$(CONFIG_IPACK) += ipack.o
-common-obj-$(CONFIG_IPACK) += tpci200.o
diff --git a/hw/ipack/meson.build b/hw/ipack/meson.build
new file mode 100644
index 0000000000..3f8138b6f2
--- /dev/null
+++ b/hw/ipack/meson.build
@@ -0,0 +1 @@
+softmmu_ss.add(when: 'CONFIG_IPACK', if_true: files('ipack.c', 'tpci200.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 9796f95e5c..ec4bb48a0f 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('ipack')
 subdir('ipmi')
 subdir('isa')
 subdir('mem')
-- 
2.21.0



