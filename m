Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DAEC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DFA20781
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlxxRHGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DFA20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WYA-0005l9-4b
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnJ-0006l6-HV
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnG-00031o-Bx
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TP9gaoXiZGPIAqc5VwKmI9CRGkxUjv4ejHiQdZ/kS5M=;
 b=JlxxRHGiViTZHW6sfYe9feELao9XMexX9GL1KdC6DhKaiv6NXGEJ2jRIJofqnVuIJo3ioo
 f54azCCLRpoUpDT3pAY2u+/ydat/wxCnOEO/igYqgGfiG2fZGflRm4PcqAITwFsHenhIQW
 lNctrlC8zgCS7xC6PODLert5i9+QskI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-7Ig3wI9tPHuu10PtgzsXtQ-1; Fri, 14 Aug 2020 05:14:30 -0400
X-MC-Unique: 7Ig3wI9tPHuu10PtgzsXtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E041853DAF
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65F91600E4;
 Fri, 14 Aug 2020 09:14:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 083/150] meson: convert disas directory to Meson
Date: Fri, 14 Aug 2020 05:12:19 -0400
Message-Id: <20200814091326.16173-84-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:57:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Makefile.objs               |  2 --
 disas/Makefile.objs         | 30 ------------------------------
 disas/libvixl/Makefile.objs |  5 -----
 disas/libvixl/meson.build   |  7 +++++++
 disas/meson.build           | 27 +++++++++++++++++++++++++++
 meson.build                 |  1 +
 6 files changed, 35 insertions(+), 37 deletions(-)
 delete mode 100644 disas/Makefile.objs
 delete mode 100644 disas/libvixl/Makefile.objs
 create mode 100644 disas/libvixl/meson.build
 create mode 100644 disas/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 7158031c0c..3b32a4c9bb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -74,8 +74,6 @@ endif # CONFIG_SOFTMMU
 # Target-independent parts used in system and user emulation
 
 common-obj-y += hw/
-common-obj-y += qom/
-common-obj-y += disas/
 
 ######################################################################
 # Resource file for Windows executables
diff --git a/disas/Makefile.objs b/disas/Makefile.objs
deleted file mode 100644
index 3c1cdce026..0000000000
--- a/disas/Makefile.objs
+++ /dev/null
@@ -1,30 +0,0 @@
-
-common-obj-$(CONFIG_ALPHA_DIS) += alpha.o
-common-obj-$(CONFIG_ARM_DIS) += arm.o
-common-obj-$(CONFIG_ARM_A64_DIS) += arm-a64.o
-common-obj-$(CONFIG_ARM_A64_DIS) += libvixl/
-libvixldir = $(SRC_PATH)/disas/libvixl
-# The -Wno-sign-compare is needed only for gcc 4.6, which complains about
-# some signed-unsigned equality comparisons in libvixl which later gcc
-# versions do not.
-arm-a64.o-cflags := -I$(libvixldir) -Wno-sign-compare
-common-obj-$(CONFIG_CRIS_DIS) += cris.o
-common-obj-$(CONFIG_HPPA_DIS) += hppa.o
-common-obj-$(CONFIG_I386_DIS) += i386.o
-common-obj-$(CONFIG_M68K_DIS) += m68k.o
-common-obj-$(CONFIG_MICROBLAZE_DIS) += microblaze.o
-common-obj-$(CONFIG_MIPS_DIS) += mips.o
-common-obj-$(CONFIG_NANOMIPS_DIS) += nanomips.o
-common-obj-$(CONFIG_NIOS2_DIS) += nios2.o
-common-obj-$(CONFIG_MOXIE_DIS) += moxie.o
-common-obj-$(CONFIG_PPC_DIS) += ppc.o
-common-obj-$(CONFIG_RISCV_DIS) += riscv.o
-common-obj-$(CONFIG_S390_DIS) += s390.o
-common-obj-$(CONFIG_SH4_DIS) += sh4.o
-common-obj-$(CONFIG_SPARC_DIS) += sparc.o
-common-obj-$(CONFIG_LM32_DIS) += lm32.o
-common-obj-$(CONFIG_XTENSA_DIS) += xtensa.o
-
-# TODO: As long as the TCG interpreter and its generated code depend
-# on the QEMU target, we cannot compile the disassembler here.
-#common-obj-$(CONFIG_TCI_DIS) += tci.o
diff --git a/disas/libvixl/Makefile.objs b/disas/libvixl/Makefile.objs
deleted file mode 100644
index 99a637f6a0..0000000000
--- a/disas/libvixl/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-common-obj-$(CONFIG_ARM_A64_DIS) = vixl/utils.o \
-               vixl/compiler-intrinsics.o \
-               vixl/a64/instructions-a64.o \
-               vixl/a64/decoder-a64.o \
-               vixl/a64/disasm-a64.o
diff --git a/disas/libvixl/meson.build b/disas/libvixl/meson.build
new file mode 100644
index 0000000000..5e2eb33e8e
--- /dev/null
+++ b/disas/libvixl/meson.build
@@ -0,0 +1,7 @@
+libvixl_ss.add(files(
+  'vixl/a64/decoder-a64.cc',
+  'vixl/a64/disasm-a64.cc',
+  'vixl/a64/instructions-a64.cc',
+  'vixl/compiler-intrinsics.cc',
+  'vixl/utils.cc',
+))
diff --git a/disas/meson.build b/disas/meson.build
new file mode 100644
index 0000000000..0527d69128
--- /dev/null
+++ b/disas/meson.build
@@ -0,0 +1,27 @@
+libvixl_ss = ss.source_set()
+subdir('libvixl')
+
+common_ss.add(when: 'CONFIG_ALPHA_DIS', if_true: files('alpha.c'))
+common_ss.add(when: 'CONFIG_ARM_A64_DIS', if_true: files('arm-a64.cc'))
+common_ss.add_all(when: 'CONFIG_ARM_A64_DIS', if_true: libvixl_ss)
+common_ss.add(when: 'CONFIG_ARM_DIS', if_true: files('arm.c'))
+common_ss.add(when: 'CONFIG_CRIS_DIS', if_true: files('cris.c'))
+common_ss.add(when: 'CONFIG_HPPA_DIS', if_true: files('hppa.c'))
+common_ss.add(when: 'CONFIG_I386_DIS', if_true: files('i386.c'))
+common_ss.add(when: 'CONFIG_LM32_DIS', if_true: files('lm32.c'))
+common_ss.add(when: 'CONFIG_M68K_DIS', if_true: files('m68k.c'))
+common_ss.add(when: 'CONFIG_MICROBLAZE_DIS', if_true: files('microblaze.c'))
+common_ss.add(when: 'CONFIG_MIPS_DIS', if_true: files('mips.c'))
+common_ss.add(when: 'CONFIG_MOXIE_DIS', if_true: files('moxie.c'))
+common_ss.add(when: 'CONFIG_NANOMIPS_DIS', if_true: files('nanomips.cpp'))
+common_ss.add(when: 'CONFIG_NIOS2_DIS', if_true: files('nios2.c'))
+common_ss.add(when: 'CONFIG_PPC_DIS', if_true: files('ppc.c'))
+common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files('riscv.c'))
+common_ss.add(when: 'CONFIG_S390_DIS', if_true: files('s390.c'))
+common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
+common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
+common_ss.add(when: 'CONFIG_XTENSA_DIS', if_true: files('xtensa.c'))
+
+# TODO: As long as the TCG interpreter and its generated code depend
+# on the QEMU target, we cannot compile the disassembler here.
+#common_ss.add(when: 'CONFIG_TCI_DIS', if_true: files('tci.c'))
diff --git a/meson.build b/meson.build
index 8955ca280e..16c8c3a337 100644
--- a/meson.build
+++ b/meson.build
@@ -669,6 +669,7 @@ common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
 subdir('backends')
+subdir('disas')
 subdir('migration')
 subdir('monitor')
 subdir('net')
-- 
2.26.2



