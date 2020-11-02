Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D1C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CB62224E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="am3c7YU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CB62224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeV7-0006d1-9s
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeR3-0001YT-TF
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:20:05 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeQw-0006iJ-8j
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:20:05 -0500
Received: by mail-lf1-x144.google.com with SMTP id j30so18671363lfp.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WUVUKv4PYWLLTid/U5M6cN4MwS3ke7uD6rvIMKkcOa8=;
 b=am3c7YU6Zc6q27BtqVlk9sOu7yFbX37F41tlp/oGYRUw1ULx/NXqDtrr+1NRdKK+Cp
 sPWS0rl/+TpycG/vbHKZjtQ7aYF5mscdWTDjl99m0V+EA0IhicM7EvDhEuQBEBQrLgtx
 ZdKlVp16NwVA/CvmInU5cAgvxq/XcBxSB+HxJbmoDrABderaSj1uqsDlVB0dXmS3Z92Z
 T6hup70vA60BXsJkB2T3a8+UEoDsXpCKk/yA24nA7BJys8PDoq23m55y5zKJ+uW/TNPM
 zgTvoO6BvkeSOpBA1VRTV5r0hymMiOsxKJi7BWUpH6bP3FL99d97K1ktBQVe8TXYmPec
 GdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WUVUKv4PYWLLTid/U5M6cN4MwS3ke7uD6rvIMKkcOa8=;
 b=iDh1FNxrGUFuWtKXUjLPQMmXj/g80QqhSbeOhXK7KgRknzEEPVwIlmICI4zqK28sCz
 hBIiTIf7n1JCOyRgqQLltAOccgn/jM+goV6Iih5BjwCx6zBU9QLsHFyhC9vf1EyX1D76
 hBG/yRHA0AEkEkhyM/Nplya7ZKm1k1xVtftB1cBbsFEB1PDbM9LyxE2gZQU/bsxK2C7b
 RYRJjlJMcg4DJxJtDKjY/KdyTdoChVKDhHAEXZfVN6kqF09RM/p8UHD+EHD2mti+VYgn
 tQAItg55Od3kw6g+QWqR0jxHTH4QPsqLPPgPh7zWg48C2mAgprg4ylHxQucpc/GpBjmR
 AbYQ==
X-Gm-Message-State: AOAM530SXD9bpwAwi1O7YnXxFv074J+U2v9cYH2PppjojLbeIXjhgvmK
 f4vqT8xN54QAImEtdHuzJty3FA==
X-Google-Smtp-Source: ABdhPJym5PpktOhe1HYFmkMhYeEYy6d77PYukIjPHukWIXViZyS/mlocpiy0CaNs5onurd+DNuzROA==
X-Received: by 2002:a05:6512:210f:: with SMTP id
 q15mr5756726lfr.78.1604341195879; 
 Mon, 02 Nov 2020 10:19:55 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id c6sm2527007lfm.226.2020.11.02.10.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 10:19:55 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [RFC PATCH 4/6] ebpf: Added eBPF RSS loader.
Date: Mon,  2 Nov 2020 20:51:14 +0200
Message-Id: <20201102185115.7425-5-andrew@daynix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102185115.7425-1-andrew@daynix.com>
References: <20201102185115.7425-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::144;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: yan@daynix.com, yuri.benditovich@daynix.com, Andrew <andrew@daynix.com>,
 Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

Added function that loads RSS eBPF program.
Added stub functions for RSS eBPF.
Added meson and configuration options.

Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 configure        |  36 ++++++++++
 ebpf/ebpf-stub.c |  28 ++++++++
 ebpf/ebpf_rss.c  | 178 +++++++++++++++++++++++++++++++++++++++++++++++
 ebpf/ebpf_rss.h  |  30 ++++++++
 ebpf/meson.build |   1 +
 meson.build      |   3 +
 6 files changed, 276 insertions(+)
 create mode 100644 ebpf/ebpf-stub.c
 create mode 100644 ebpf/ebpf_rss.c
 create mode 100644 ebpf/ebpf_rss.h
 create mode 100644 ebpf/meson.build

diff --git a/configure b/configure
index 6df4306c88..bae4ea54f8 100755
--- a/configure
+++ b/configure
@@ -330,6 +330,7 @@ vhost_scsi=""
 vhost_vsock=""
 vhost_user=""
 vhost_user_fs=""
+bpf=""
 kvm="auto"
 hax="auto"
 hvf="auto"
@@ -1210,6 +1211,10 @@ for opt do
   ;;
   --enable-membarrier) membarrier="yes"
   ;;
+  --disable-bpf) bpf="no"
+  ;;
+  --enable-bpf) bpf="yes"
+  ;;
   --disable-blobs) blobs="false"
   ;;
   --with-pkgversion=*) pkgversion="$optarg"
@@ -1792,6 +1797,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vhost-kernel    vhost kernel backend support
   vhost-user      vhost-user backend support
   vhost-vdpa      vhost-vdpa kernel backend support
+  bpf             BPF kernel support
   spice           spice
   rbd             rados block device (rbd)
   libiscsi        iscsi support
@@ -5347,6 +5353,33 @@ else
     membarrier=no
 fi
 
+##########################################
+# check for usable bpf system call
+if test "$bpf" = ""; then
+    have_bpf=no
+    if test "$linux" = "yes" ; then
+        cat > $TMPC << EOF
+    #include <sys/syscall.h>
+    #include <linux/bpf.h>
+    #include <unistd.h>
+    #include <stdlib.h>
+    #include <string.h>
+    int main(void) {
+        union bpf_attr * attr = NULL;
+        syscall(__NR_bpf, BPF_PROG_LOAD, attr, sizeof(attr));
+        exit(0);
+    }
+EOF
+        if compile_prog "" "" ; then
+            have_bpf=yes
+            bpf=yes
+        fi
+    fi
+    if test "$have_bpf" = "no"; then
+      feature_not_found "bpf" "the bpf system call is not available"
+    fi
+fi
+
 ##########################################
 # check if rtnetlink.h exists and is useful
 have_rtnetlink=no
@@ -6279,6 +6312,9 @@ fi
 if test "$membarrier" = "yes" ; then
   echo "CONFIG_MEMBARRIER=y" >> $config_host_mak
 fi
+if test "$bpf" = "yes" -a "$bigendian" != "yes"; then
+  echo "CONFIG_EBPF=y" >> $config_host_mak
+fi
 if test "$signalfd" = "yes" ; then
   echo "CONFIG_SIGNALFD=y" >> $config_host_mak
 fi
diff --git a/ebpf/ebpf-stub.c b/ebpf/ebpf-stub.c
new file mode 100644
index 0000000000..281dc039d3
--- /dev/null
+++ b/ebpf/ebpf-stub.c
@@ -0,0 +1,28 @@
+#include "qemu/osdep.h"
+#include "ebpf/ebpf_rss.h"
+
+void ebpf_rss_init(struct EBPFRSSContext *ctx)
+{
+
+}
+
+bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
+{
+    return false;
+}
+
+bool ebpf_rss_load(struct EBPFRSSContext *ctx)
+{
+    return false;
+}
+
+bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
+                      uint16_t *indirections_table, uint8_t *toeplitz_key)
+{
+    return false;
+}
+
+void ebpf_rss_unload(struct EBPFRSSContext *ctx)
+{
+
+}
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
new file mode 100644
index 0000000000..f3c948a7a0
--- /dev/null
+++ b/ebpf/ebpf_rss.c
@@ -0,0 +1,178 @@
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+
+#include "hw/virtio/virtio-net.h" /* VIRTIO_NET_RSS_MAX_TABLE_LEN */
+
+#include "ebpf/ebpf_rss.h"
+#include "ebpf/ebpf.h"
+#include "ebpf/tun_rss_steering.h"
+#include "trace.h"
+
+void ebpf_rss_init(struct EBPFRSSContext *ctx)
+{
+    if (ctx != NULL) {
+        ctx->program_fd = -1;
+    }
+}
+
+bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
+{
+    return ctx != NULL && ctx->program_fd >= 0;
+}
+
+bool ebpf_rss_load(struct EBPFRSSContext *ctx)
+{
+    if (ctx == NULL) {
+        return false;
+    }
+
+    ctx->map_configuration =
+            bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(uint32_t),
+                           sizeof(struct EBPFRSSConfig), 1);
+    if (ctx->map_configuration < 0) {
+        trace_ebpf_error("eBPF RSS", "can not create MAP for configurations");
+        goto l_conf_create;
+    }
+    ctx->map_toeplitz_key =
+            bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(uint32_t),
+                           VIRTIO_NET_RSS_MAX_KEY_SIZE, 1);
+    if (ctx->map_toeplitz_key < 0) {
+        trace_ebpf_error("eBPF RSS", "can not create MAP for toeplitz key");
+        goto l_toe_create;
+    }
+
+    ctx->map_indirections_table =
+            bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(uint32_t),
+                           sizeof(uint16_t), VIRTIO_NET_RSS_MAX_TABLE_LEN);
+    if (ctx->map_indirections_table < 0) {
+        trace_ebpf_error("eBPF RSS", "can not create MAP for indirections table");
+        goto l_table_create;
+    }
+
+    bpf_fixup_mapfd(reltun_rss_steering,
+            sizeof(reltun_rss_steering) / sizeof(struct fixup_mapfd_t),
+            instun_rss_steering,
+            sizeof(instun_rss_steering) / sizeof(struct bpf_insn),
+            "tap_rss_map_configurations", ctx->map_configuration);
+
+    bpf_fixup_mapfd(reltun_rss_steering,
+            sizeof(reltun_rss_steering) / sizeof(struct fixup_mapfd_t),
+            instun_rss_steering,
+            sizeof(instun_rss_steering) / sizeof(struct bpf_insn),
+            "tap_rss_map_toeplitz_key", ctx->map_toeplitz_key);
+
+    bpf_fixup_mapfd(reltun_rss_steering,
+            sizeof(reltun_rss_steering) / sizeof(struct fixup_mapfd_t),
+            instun_rss_steering,
+            sizeof(instun_rss_steering) / sizeof(struct bpf_insn),
+            "tap_rss_map_indirection_table", ctx->map_indirections_table);
+
+    ctx->program_fd =
+            bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, instun_rss_steering,
+                         sizeof(instun_rss_steering) / sizeof(struct bpf_insn),
+                         "GPL");
+    if (ctx->program_fd < 0) {
+        trace_ebpf_error("eBPF RSS", "can not load eBPF program");
+        goto l_prog_load;
+    }
+
+    return true;
+l_prog_load:
+    close(ctx->map_indirections_table);
+l_table_create:
+    close(ctx->map_toeplitz_key);
+l_toe_create:
+    close(ctx->map_configuration);
+l_conf_create:
+    return false;
+}
+
+static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
+                                struct EBPFRSSConfig *config)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
+    uint32_t map_key = 0;
+    if (bpf_update_elem(ctx->map_configuration,
+                            &map_key, config, BPF_ANY) < 0) {
+        return false;
+    }
+    return true;
+}
+
+static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
+                                            uint16_t *indirections_table,
+                                            size_t len)
+{
+    if (!ebpf_rss_is_loaded(ctx) || indirections_table == NULL ||
+       len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
+        return false;
+    }
+    uint32_t i = 0;
+
+    for (; i < len; ++i) {
+        if (bpf_update_elem(ctx->map_indirections_table, &i,
+                                indirections_table + i, BPF_ANY) < 0) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
+                                     uint8_t *toeplitz_key)
+{
+    if (!ebpf_rss_is_loaded(ctx) || toeplitz_key == NULL) {
+        return false;
+    }
+    uint32_t map_key = 0;
+
+    /* prepare toeplitz key */
+    uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] = {};
+    memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
+    *(uint32_t *)toe = ntohl(*(uint32_t *)toe);
+
+    if (bpf_update_elem(ctx->map_toeplitz_key, &map_key, toe,
+                            BPF_ANY) < 0) {
+        return false;
+    }
+    return true;
+}
+
+bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
+                      uint16_t *indirections_table, uint8_t *toeplitz_key)
+{
+    if (!ebpf_rss_is_loaded(ctx) || config == NULL ||
+        indirections_table == NULL || toeplitz_key == NULL) {
+        return false;
+    }
+
+    if (!ebpf_rss_set_config(ctx, config)) {
+        return false;
+    }
+
+    if (!ebpf_rss_set_indirections_table(ctx, indirections_table,
+                                      config->indirections_len)) {
+        return false;
+    }
+
+    if (!ebpf_rss_set_toepliz_key(ctx, toeplitz_key)) {
+        return false;
+    }
+
+    return true;
+}
+
+void ebpf_rss_unload(struct EBPFRSSContext *ctx)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return;
+    }
+
+    close(ctx->program_fd);
+    close(ctx->map_configuration);
+    close(ctx->map_toeplitz_key);
+    close(ctx->map_indirections_table);
+    ctx->program_fd = -1;
+}
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
new file mode 100644
index 0000000000..ffed7b571a
--- /dev/null
+++ b/ebpf/ebpf_rss.h
@@ -0,0 +1,30 @@
+#ifndef QEMU_EBPF_RSS_H
+#define QEMU_EBPF_RSS_H
+
+struct EBPFRSSContext {
+    int program_fd;
+    int map_configuration;
+    int map_toeplitz_key;
+    int map_indirections_table;
+};
+
+struct EBPFRSSConfig {
+    uint8_t redirect;
+    uint8_t populate_hash;
+    uint32_t hash_types;
+    uint16_t indirections_len;
+    uint16_t default_queue;
+};
+
+void ebpf_rss_init(struct EBPFRSSContext *ctx);
+
+bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
+
+bool ebpf_rss_load(struct EBPFRSSContext *ctx);
+
+bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
+                      uint16_t *indirections_table, uint8_t *toeplitz_key);
+
+void ebpf_rss_unload(struct EBPFRSSContext *ctx);
+
+#endif /* QEMU_EBPF_RSS_H */
diff --git a/ebpf/meson.build b/ebpf/meson.build
new file mode 100644
index 0000000000..10f4bc9ca8
--- /dev/null
+++ b/ebpf/meson.build
@@ -0,0 +1 @@
+specific_ss.add(when: 'CONFIG_EBPF', if_true: files('ebpf_rss.c', 'ebpf.c'), if_false: files('ebpf-stub.c'))
diff --git a/meson.build b/meson.build
index 47e32e1fcb..d0ea1a0e9d 100644
--- a/meson.build
+++ b/meson.build
@@ -1368,6 +1368,7 @@ if have_system
     'backends',
     'backends/tpm',
     'chardev',
+    'ebpf',
     'hw/9pfs',
     'hw/acpi',
     'hw/alpha',
@@ -1530,6 +1531,7 @@ subdir('accel')
 subdir('plugins')
 subdir('bsd-user')
 subdir('linux-user')
+subdir('ebpf')
 
 bsd_user_ss.add(files('gdbstub.c'))
 specific_ss.add_all(when: 'CONFIG_BSD_USER', if_true: bsd_user_ss)
@@ -2093,6 +2095,7 @@ summary_info += {'vhost-vsock support': config_host.has_key('CONFIG_VHOST_VSOCK'
 summary_info += {'vhost-user support': config_host.has_key('CONFIG_VHOST_KERNEL')}
 summary_info += {'vhost-user-fs support': config_host.has_key('CONFIG_VHOST_USER_FS')}
 summary_info += {'vhost-vdpa support': config_host.has_key('CONFIG_VHOST_VDPA')}
+summary_info += {'bpf support': config_host.has_key('CONFIG_EBPF')}
 summary_info += {'Trace backends':    config_host['TRACE_BACKENDS']}
 if config_host['TRACE_BACKENDS'].split().contains('simple')
   summary_info += {'Trace output file': config_host['CONFIG_TRACE_FILE'] + '-<pid>'}
-- 
2.28.0


