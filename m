Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5073FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A97206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aqyvy2T8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A97206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfcU-0003kD-Ct
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 05:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTk-00077f-Kb
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:56:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTi-0007DM-BH
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591952157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7CIysZD1OBUeA3YX2r2swVtVwPy1qac/ud5dumb4Y0=;
 b=Aqyvy2T8Qp5jnDCmLgWahDvs8C3V1z5XBZzsqSulgLaRwX5Z5Brru4geNpAEaEfTiIRtqw
 e3XJ5dMls8PKW/MA6mBMhjVkPBN5L3hKgczY3AjdLcTZ2sLIPZ2MfE14V5ISctfK2hjQfp
 mFqgwRkURtThGmWsS8LAZ+6c/r1a3cE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248--jYKQ1kqMKuZfAqM6ESF5g-1; Fri, 12 Jun 2020 04:55:54 -0400
X-MC-Unique: -jYKQ1kqMKuZfAqM6ESF5g-1
Received: by mail-wr1-f70.google.com with SMTP id l1so3643451wrc.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 01:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d7CIysZD1OBUeA3YX2r2swVtVwPy1qac/ud5dumb4Y0=;
 b=oGryv+PUAI/REdr+8kGwAIprd0q7D+6BHXdcbwGD2ptjIlgUUFR/RhLzfnn+Bfa3kH
 2ir+e7qpaeYgRKhmpijK2U4kjgTU2PM598VkYb3RJ3Ao4RiCrZWQMxvK7iRscwUQ5OsJ
 7C5krZdi6yE9ACAJGnfBfCbre/Hz2nNM8sQ7mYId4I88S5YkRDQbrRvMRtPi/twXCxcd
 G7wcgMwR04Vh2QVRSX87innfnaJSAb0frWPbzmaR1AZih1VEWolYZduMPnqTEe4KmyeB
 uGQ3R41YGYizX4WWx9YgW1WlF0TVOd1cuR956PKpgtOlakk1AtcdEVhlrH1a8hcbyVUr
 0Qgw==
X-Gm-Message-State: AOAM531yFJaAx9UNNARjZQEy5aTmLIRDIacmM3RNLF6jLPbSud1rUw9I
 fGCl4YskmX0C+BQbEdD57STbBBlCq3Yapk8NfNW2M/5JcBLoXK48LnMLOrU7br+7qNSJsvo9O/I
 YKIpRRrkPyAYWODY=
X-Received: by 2002:a1c:4d0c:: with SMTP id o12mr12600961wmh.181.1591952152661; 
 Fri, 12 Jun 2020 01:55:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAumwuPx3HncrxBbxIh6ZLCTU1dGbxHYvMTBhOtLmlKaQsVUpTqx8gjAtVWGAJjnY16GjAnQ==
X-Received: by 2002:a1c:4d0c:: with SMTP id o12mr12600924wmh.181.1591952152167; 
 Fri, 12 Jun 2020 01:55:52 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d2sm9320318wrs.95.2020.06.12.01.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 01:55:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/12] tpm: Move backend code under the 'backends/'
 directory
Date: Fri, 12 Jun 2020 10:54:44 +0200
Message-Id: <20200612085444.8362-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
References: <20200612085444.8362-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TPM subsytem is split into backends (see commit f4ede81eed2)
and frontends (see i.e. 3676bc69b35). Keep the emulated
hardware 'frontends' under hw/tpm/, but move the backends
in the backends/tpm/ directory.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/specs/tpm.rst                     |  8 +++---
 Makefile                               |  2 +-
 Makefile.objs                          |  1 +
 {hw => backends}/tpm/tpm_int.h         |  6 ++---
 {hw => backends}/tpm/tpm_ioctl.h       |  0
 {hw => backends}/tpm/tpm_emulator.c    |  0
 {hw => backends}/tpm/tpm_passthrough.c |  0
 {hw => backends}/tpm/tpm_util.c        |  0
 tests/qtest/tpm-emu.c                  |  2 +-
 backends/Kconfig                       |  1 +
 backends/tpm/Kconfig                   | 14 +++++++++++
 backends/tpm/Makefile.objs             |  3 +++
 backends/tpm/trace-events              | 33 +++++++++++++++++++++++++
 hw/tpm/Kconfig                         | 15 ------------
 hw/tpm/Makefile.objs                   |  3 ---
 hw/tpm/trace-events                    | 34 +-------------------------
 16 files changed, 62 insertions(+), 60 deletions(-)
 rename {hw => backends}/tpm/tpm_int.h (96%)
 rename {hw => backends}/tpm/tpm_ioctl.h (100%)
 rename {hw => backends}/tpm/tpm_emulator.c (100%)
 rename {hw => backends}/tpm/tpm_passthrough.c (100%)
 rename {hw => backends}/tpm/tpm_util.c (100%)
 create mode 100644 backends/Kconfig
 create mode 100644 backends/tpm/Kconfig
 create mode 100644 backends/tpm/trace-events

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 0200fdac68..ed6c0d785d 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -232,8 +232,8 @@ Integrity Measurement Architecture (IMA), are not expecting to share
 PCRs.
 
 QEMU files related to the TPM passthrough device:
- - ``hw/tpm/tpm_passthrough.c``
- - ``hw/tpm/tpm_util.c``
+ - ``backends/tpm/tpm_passthrough.c``
+ - ``backends/tpm/tpm_util.c``
  - ``include/sysemu/tpm_util.h``
 
 
@@ -292,8 +292,8 @@ instrumented to initialize a TPM 1.2 or TPM 2 device using this
 command.
 
 QEMU files related to the TPM emulator device:
- - ``hw/tpm/tpm_emulator.c``
- - ``hw/tpm/tpm_util.c``
+ - ``backends/tpm/tpm_emulator.c``
+ - ``backends/tpm/tpm_util.c``
  - ``include/sysemu/tpm_util.h``
 
 The following commands start the swtpm with a UnixIO control channel over
diff --git a/Makefile b/Makefile
index d1af126ea1..0ab6e12dd6 100644
--- a/Makefile
+++ b/Makefile
@@ -418,7 +418,7 @@ MINIKCONF_ARGS = \
     CONFIG_LINUX=$(CONFIG_LINUX) \
     CONFIG_PVRDMA=$(CONFIG_PVRDMA)
 
-MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
+MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/backends/Kconfig $(SRC_PATH)/hw/Kconfig
 MINIKCONF_DEPS = $(MINIKCONF_INPUTS) $(wildcard $(SRC_PATH)/hw/*/Kconfig)
 MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
 
diff --git a/Makefile.objs b/Makefile.objs
index 99774cfd25..84fc651f53 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -125,6 +125,7 @@ trace-events-subdirs =
 trace-events-subdirs += accel/kvm
 trace-events-subdirs += accel/tcg
 trace-events-subdirs += backends
+trace-events-subdirs += backends/tpm
 trace-events-subdirs += crypto
 trace-events-subdirs += monitor
 ifeq ($(CONFIG_USER_ONLY),y)
diff --git a/hw/tpm/tpm_int.h b/backends/tpm/tpm_int.h
similarity index 96%
rename from hw/tpm/tpm_int.h
rename to backends/tpm/tpm_int.h
index 9f72879d89..ba6109306e 100644
--- a/hw/tpm/tpm_int.h
+++ b/backends/tpm/tpm_int.h
@@ -9,8 +9,8 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
-#ifndef TPM_TPM_INT_H
-#define TPM_TPM_INT_H
+#ifndef BACKENDS_TPM_INT_H
+#define BACKENDS_TPM_INT_H
 
 #include "qemu/option.h"
 #include "sysemu/tpm.h"
@@ -85,4 +85,4 @@ typedef struct TPMSizedBuffer {
 
 void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
 
-#endif /* TPM_TPM_INT_H */
+#endif /* BACKENDS_TPM_INT_H */
diff --git a/hw/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
similarity index 100%
rename from hw/tpm/tpm_ioctl.h
rename to backends/tpm/tpm_ioctl.h
diff --git a/hw/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
similarity index 100%
rename from hw/tpm/tpm_emulator.c
rename to backends/tpm/tpm_emulator.c
diff --git a/hw/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
similarity index 100%
rename from hw/tpm/tpm_passthrough.c
rename to backends/tpm/tpm_passthrough.c
diff --git a/hw/tpm/tpm_util.c b/backends/tpm/tpm_util.c
similarity index 100%
rename from hw/tpm/tpm_util.c
rename to backends/tpm/tpm_util.c
diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index c43ac4aef8..337647846f 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 
-#include "hw/tpm/tpm_ioctl.h"
+#include "backends/tpm/tpm_ioctl.h"
 #include "io/channel-socket.h"
 #include "qapi/error.h"
 #include "tpm-emu.h"
diff --git a/backends/Kconfig b/backends/Kconfig
new file mode 100644
index 0000000000..f35abc1609
--- /dev/null
+++ b/backends/Kconfig
@@ -0,0 +1 @@
+source tpm/Kconfig
diff --git a/backends/tpm/Kconfig b/backends/tpm/Kconfig
new file mode 100644
index 0000000000..5d91eb89c2
--- /dev/null
+++ b/backends/tpm/Kconfig
@@ -0,0 +1,14 @@
+config TPM_BACKEND
+    bool
+    depends on TPM
+
+config TPM_PASSTHROUGH
+    bool
+    default y
+    # FIXME: should check for x86 host as well
+    depends on TPM_BACKEND && LINUX
+
+config TPM_EMULATOR
+    bool
+    default y
+    depends on TPM_BACKEND
diff --git a/backends/tpm/Makefile.objs b/backends/tpm/Makefile.objs
index 8cf5772824..db2731f634 100644
--- a/backends/tpm/Makefile.objs
+++ b/backends/tpm/Makefile.objs
@@ -1 +1,4 @@
 common-obj-y += tpm_backend.o
+common-obj-y += tpm_util.o
+common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
+common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
diff --git a/backends/tpm/trace-events b/backends/tpm/trace-events
new file mode 100644
index 0000000000..0a2591fb2d
--- /dev/null
+++ b/backends/tpm/trace-events
@@ -0,0 +1,33 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# tpm_passthrough.c
+tpm_passthrough_handle_request(void *cmd) "processing command %p"
+tpm_passthrough_reset(void) "reset"
+
+# tpm_util.c
+tpm_util_get_buffer_size_hdr_len(uint32_t len, size_t expected) "tpm_resp->hdr.len = %u, expected = %zu"
+tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u, expected = %zu"
+tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
+tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
+tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
+tpm_util_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
+
+# tpm_emulator.c
+tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
+tpm_emulator_handle_request(void) "processing TPM command"
+tpm_emulator_probe_caps(uint64_t caps) "capabilities: 0x%"PRIx64
+tpm_emulator_set_buffer_size(uint32_t buffersize, uint32_t minsize, uint32_t maxsize) "buffer size: %u, min: %u, max: %u"
+tpm_emulator_startup_tpm_resume(bool is_resume, size_t buffersize) "is_resume: %d, buffer size: %zu"
+tpm_emulator_get_tpm_established_flag(uint8_t flag) "got established flag: %d"
+tpm_emulator_cancel_cmd_not_supt(void) "Backend does not support CANCEL_TPM_CMD"
+tpm_emulator_handle_device_opts_tpm12(void) "TPM Version 1.2"
+tpm_emulator_handle_device_opts_tpm2(void) "TPM Version 2"
+tpm_emulator_handle_device_opts_unspec(void) "TPM Version Unspecified"
+tpm_emulator_handle_device_opts_startup_error(void) "Startup error"
+tpm_emulator_get_state_blob(uint8_t type, uint32_t size, uint32_t flags) "got state blob type %d, %u bytes, flags 0x%08x"
+tpm_emulator_set_state_blob(uint8_t type, uint32_t size, uint32_t flags) "set state blob type %d, %u bytes, flags 0x%08x"
+tpm_emulator_set_state_blobs(void) "setting state blobs"
+tpm_emulator_set_state_blobs_error(const char *msg) "error while setting state blobs: %s"
+tpm_emulator_set_state_blobs_done(void) "Done setting state blobs"
+tpm_emulator_pre_save(void) ""
+tpm_emulator_inst_init(void) ""
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 5028fd8880..29e82f3c92 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -1,7 +1,3 @@
-config TPM_BACKEND
-    bool
-    depends on TPM
-
 config TPM_TIS_ISA
     bool
     depends on TPM && ISA_BUS
@@ -22,17 +18,6 @@ config TPM_CRB
     depends on TPM && PC
     select TPM_BACKEND
 
-config TPM_PASSTHROUGH
-    bool
-    default y
-    # FIXME: should check for x86 host as well
-    depends on TPM_BACKEND && LINUX
-
-config TPM_EMULATOR
-    bool
-    default y
-    depends on TPM_BACKEND
-
 config TPM_SPAPR
     bool
     default y
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index f1ec4beb95..6fc05be67c 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,9 +1,6 @@
-common-obj-$(CONFIG_TPM) += tpm_util.o
 obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
 common-obj-$(CONFIG_TPM_TIS_ISA) += tpm_tis_isa.o
 common-obj-$(CONFIG_TPM_TIS_SYSBUS) += tpm_tis_sysbus.o
 common-obj-$(CONFIG_TPM_TIS) += tpm_tis_common.o
 common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
-common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
-common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
 obj-$(CONFIG_TPM_SPAPR) += tpm_spapr.o
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 439e514787..de9bf1e01b 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -4,38 +4,6 @@
 tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
 tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
 
-# tpm_passthrough.c
-tpm_passthrough_handle_request(void *cmd) "processing command %p"
-tpm_passthrough_reset(void) "reset"
-
-# tpm_util.c
-tpm_util_get_buffer_size_hdr_len(uint32_t len, size_t expected) "tpm_resp->hdr.len = %u, expected = %zu"
-tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u, expected = %zu"
-tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
-tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
-tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
-tpm_util_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
-
-# tpm_emulator.c
-tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
-tpm_emulator_handle_request(void) "processing TPM command"
-tpm_emulator_probe_caps(uint64_t caps) "capabilities: 0x%"PRIx64
-tpm_emulator_set_buffer_size(uint32_t buffersize, uint32_t minsize, uint32_t maxsize) "buffer size: %u, min: %u, max: %u"
-tpm_emulator_startup_tpm_resume(bool is_resume, size_t buffersize) "is_resume: %d, buffer size: %zu"
-tpm_emulator_get_tpm_established_flag(uint8_t flag) "got established flag: %d"
-tpm_emulator_cancel_cmd_not_supt(void) "Backend does not support CANCEL_TPM_CMD"
-tpm_emulator_handle_device_opts_tpm12(void) "TPM Version 1.2"
-tpm_emulator_handle_device_opts_tpm2(void) "TPM Version 2"
-tpm_emulator_handle_device_opts_unspec(void) "TPM Version Unspecified"
-tpm_emulator_handle_device_opts_startup_error(void) "Startup error"
-tpm_emulator_get_state_blob(uint8_t type, uint32_t size, uint32_t flags) "got state blob type %d, %u bytes, flags 0x%08x"
-tpm_emulator_set_state_blob(uint8_t type, uint32_t size, uint32_t flags) "set state blob type %d, %u bytes, flags 0x%08x"
-tpm_emulator_set_state_blobs(void) "setting state blobs"
-tpm_emulator_set_state_blobs_error(const char *msg) "error while setting state blobs: %s"
-tpm_emulator_set_state_blobs_done(void) "Done setting state blobs"
-tpm_emulator_pre_save(void) ""
-tpm_emulator_inst_init(void) ""
-
 # tpm_tis.c
 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
 tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
@@ -56,7 +24,7 @@ tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_offset = %u"
 # tpm_ppi.c
 tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
 
-# hw/tpm/tpm_spapr.c
+# tpm_spapr.c
 tpm_spapr_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
 tpm_spapr_do_crq(uint8_t raw1, uint8_t raw2) "1st 2 bytes in CRQ: 0x%02x 0x%02x"
 tpm_spapr_do_crq_crq_result(void) "SPAPR_VTPM_INIT_CRQ_RESULT"
-- 
2.21.3


