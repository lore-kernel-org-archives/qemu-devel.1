Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16833C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F61207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP2VThL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F61207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVgl-0002OD-1n
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5A-000828-OU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV59-0001qI-Ak
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:24 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV58-0001mR-UX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:23 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so17096464wre.10
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6aTXzl4RBhwocYJkxuMJOQNVj38LQZD8twjzizQLzLI=;
 b=RP2VThL6HzXF94BgUwIHgpArNIOfQLPvSf1WKSfH1Caq8j2eiKcsTKSSgySaN58ynM
 9z1yjBty8K50tA/+KOZcGNM/HDP6aHy04ykIm4cQbB4ls3r7urIzUdx7W555NtdnYeZW
 YgUKEFg2x2Y4ITb0qOoNAINEUJqbjvwzaTOOWlGv8SJUZUDKZFxluwW70zDkodgE3Kh6
 2TyV5hhsEpTx8xyF/Dg+YB/0LbYdSRDsl155RQpxYJ7Nl4mioOWP90IuoFQA1HM9zU9X
 CIjWCiwZcnJFXjq5z3r5FBaAMhj0JRnpClKTMw5oKf6v6Z9fVPexqJyrWRJjjdxlQSWh
 JBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6aTXzl4RBhwocYJkxuMJOQNVj38LQZD8twjzizQLzLI=;
 b=t8cTarYZnyGwAGTh2fm5aEUJda8xDW3JkrAUIa7zcxGj4ZdHDUYixOd+nV81t9MDsM
 Wq1YW8LcOoWo0dsEZBSnwGT67x5usME9pk09rir4tNLl8G6FnTC2Oo0Ar2D+NbIk73wS
 WXD8ZJKfMqavTArDA4zQWphQ3EWmATmDfkSgWVa/UwlAidU8Mg842JPyCNr4IzzDaSlm
 ztnvZA9CSij2+5JYauCZfyTf4MzEP3JIhw/Z6jt+RfaPBVrofSGdFEbmUKHsrIFnO/Rz
 mev2SLkpH77m3Fx9iDZEmjnDdHQrBlh/KnHTzoKPd4nJ0GU324fY1i+Fz64kmV1lFQiK
 zSow==
X-Gm-Message-State: APjAAAU/wFRxuT1ukCEd7+NWI/Ka7GL4DXVoG7Q7vTpA+lo9Snu2JbtA
 KzZduovaQ5CYOZvoPO7PC7+4xflU
X-Google-Smtp-Source: APXvYqyQul52g1I5gzuJmzBLu/60Ha32wwAeXA2U2x8+G7rOHPLYMALC20cmk5i3kBmEgwh9q9dVWg==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr31198093wrw.255.1580234121520; 
 Tue, 28 Jan 2020 09:55:21 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 039/142] meson: convert qom directory to Meson
Date: Tue, 28 Jan 2020 18:51:59 +0100
Message-Id: <20200128175342.9066-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile               |  2 +-
 Makefile.objs          |  4 ++--
 Makefile.target        |  3 ++-
 meson.build            |  1 +
 qom/Makefile.objs      |  3 ---
 qom/meson.build        | 15 +++++++++++++++
 tests/Makefile.include |  2 +-
 7 files changed, 22 insertions(+), 8 deletions(-)
 create mode 100644 qom/meson.build

diff --git a/Makefile b/Makefile
index e863250107..80894601dc 100644
--- a/Makefile
+++ b/Makefile
@@ -225,7 +225,6 @@ dummy := $(call unnest-vars,, \
                 block-obj-y \
                 block-obj-m \
                 crypto-obj-y \
-                qom-obj-y \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m)
@@ -245,6 +244,7 @@ $(SOFTMMU_ALL_RULES): $(block-obj-y)
 $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
+$(SOFTMMU_ALL_RULES): $(qom-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
 
 .PHONY: $(TARGET_DIRS_RULES)
diff --git a/Makefile.objs b/Makefile.objs
index f1465a620e..18caccdba8 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -24,9 +24,9 @@ block-obj-m = block/
 crypto-obj-y = crypto/
 
 #######################################################################
-# qom-obj-y is code used by both qemu system emulation and qemu-img
+# libraries built entirely from meson
 
-qom-obj-y = qom/
+qom-obj-y = qom/libqom.fa
 
 #######################################################################
 # io-obj-y is code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index d94fa687bf..40ab105568 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -178,13 +178,14 @@ dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
 include $(SRC_PATH)/Makefile.objs
+dummy := $(call fix-paths,../,, \
+              qom-obj-y)
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
                crypto-obj-y \
-               qom-obj-y \
                io-obj-y \
                common-obj-y \
                common-obj-m)
diff --git a/meson.build b/meson.build
index 585fc7aca5..0c4e5e5823 100644
--- a/meson.build
+++ b/meson.build
@@ -287,6 +287,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
+subdir('qom')
 subdir('fsdev')
 
 # Other build targets
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index f9d77350ac..fc1248e3f3 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -1,4 +1 @@
-qom-obj-y = object.o container.o qom-qobject.o
-qom-obj-y += object_interfaces.o
-
 common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
diff --git a/qom/meson.build b/qom/meson.build
new file mode 100644
index 0000000000..3c41ed37e4
--- /dev/null
+++ b/qom/meson.build
@@ -0,0 +1,15 @@
+qom_ss = ss.source_set()
+qom_ss.add(files(
+  'container.c',
+  'object.c',
+  'object_interfaces.c',
+  'qom-qobject.c',
+))
+
+qom_ss = qom_ss.apply(config_host, strict: false)
+libqom = static_library('qom', qom_ss.sources(),
+                        dependencies: [qom_ss.dependencies()],
+                        link_with: [libqemuutil],
+                        name_suffix: 'fa')
+
+qom = declare_dependency(link_whole: libqom)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7838a45a18..62b65f409d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -511,7 +511,7 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
 
 # Deps that are common to various different sets of tests below
 test-util-obj-y = libqemuutil.a
-test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
+test-qom-obj-y = qom/libqom.fa $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-types.o \
 	tests/include/test-qapi-types-sub-module.o \
 	tests/test-qapi-types-sub-sub-module.o \
-- 
2.21.0



