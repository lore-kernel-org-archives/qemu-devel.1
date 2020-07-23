Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B09C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E66B20825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irSxg5MZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E66B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyOzQ-0005P9-P1
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3o9cYXwMKCrQmWqaiiafY.WigkYgo-XYpYfhihaho.ila@flex--scw.bounces.google.com>)
 id 1jyOxl-0003OQ-J7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:54 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:52413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3o9cYXwMKCrQmWqaiiafY.WigkYgo-XYpYfhihaho.ila@flex--scw.bounces.google.com>)
 id 1jyOxh-00024m-G3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:19:53 -0400
Received: by mail-yb1-xb49.google.com with SMTP id k75so4411350ybf.19
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=rCcDPdjZOM8MYPVww2N4n3DAJeDeaSBkF5CXlp0or60=;
 b=irSxg5MZZioGeG7mcFjhqRZzAYZc47KNrYHrcVgNNDNERXsGQqQnns1oXPza8QuzIi
 GxORuh3DRtYffCiGVE7J465jYG9Vf3J6b/147XxS4Vsv/86cFbOz2FwRPCPv4179kFyu
 ffqFUai295m+CAxtYqiFKQfuIQ+yWc4D90wmuXxX2StTjhNYjfopH3lHr/XCeyjdYhHg
 oWlIAhRYQnrF/PtM+SmzR+esOXCc8vktXT0y3DlDUwiYP/oSfbEqTS6RyUOEQUwGZXXE
 PC67iDg2uyHxTiFvIwUSLRmI9GiNilrAogUQXnrggV9eBy2R0Mba/5XKHIh8bB4mQBSw
 Px4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=rCcDPdjZOM8MYPVww2N4n3DAJeDeaSBkF5CXlp0or60=;
 b=kyHtyW92P06IQMpjZBfgL4GadExH3WEHxITr5PIlSXiyaQSS/dTDZC04z6cGT0mIea
 8XI3j2gL7vT8u46EgNCLVIGJYS4MLBAkwSkPyXU817gz0SoDAVD9/lz0jJ7O6v2QmY2T
 MWzdOG1SWrRKRZVmBVyIFQf53eZ02LLwUZXq9FZLNVZVvDcS5QoJZyjgSTXKyHIMXOFp
 u/CpTB3TRQrX+Sm8Dq2ese5bJ3By2IMFhGzs3mZzkaJsSVWAUBKQtL5nhOW3T4zpQVpi
 LNuGphUyHND9e3c+wPWhUqOoiPS+UaiKLLm82oexGQtLd8paSmMaK2pEdWR2OI76F78B
 Qd1w==
X-Gm-Message-State: AOAM530fJau4PZ8LxprFoIQWYacQZLoJxA+UtzPNjd9or1d6bnIziJw5
 WgjC8bIsWf0TSUTKLVcEEb6mqdgEInZAlp/0QN48gjds6D3SHHq4gVaeHRE7/Ccr9sn3ngAiP0l
 S2OeTElF6w/y7cl7/IMBEDFTzunkLB9+LUNyVZ5AmPqiOLMwXbqUb
X-Google-Smtp-Source: ABdhPJyTcI8K3iRSWJtfzJhhYV/FIgMH07p/Qk6OzYYXDCzXagdmu36B6Yae9+9koS473/OTZ4nUH2k=
X-Received: by 2002:a25:2044:: with SMTP id g65mr2965803ybg.87.1595463587741; 
 Wed, 22 Jul 2020 17:19:47 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:19:15 -0700
In-Reply-To: <cover.1595461447.git.scw@google.com>
Message-Id: <ad1196b95745042a7918f5291cf22e911a6fb2c3.1595461447.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1595461447.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 6/6] linux-user: Add support for SIOCETHTOOL ioctl
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu, riku.voipio@iki.fi, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3o9cYXwMKCrQmWqaiiafY.WigkYgo-XYpYfhihaho.ila@flex--scw.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ioctl numeric values are platform-independent and determined by
the file include/uapi/linux/sockios.h in Linux kernel source code:

  #define SIOCETHTOOL   0x8946

These ioctls get (or set) various structures pointed by the field
ifr_data in the structure ifreq depending on the first 4 bytes of the
memory region.

This change clones the ioctl framework into ethtool-specific dispatch
logic in its own file. A number of definitions previously only visible
in syscall.c are thus exported to syscall_defs.h to be used in the new
files.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/Makefile.objs      |   3 +-
 linux-user/ethtool.c          | 819 ++++++++++++++++++++++++++++++++++
 linux-user/ethtool.h          |  19 +
 linux-user/ethtool_entries.h  | 107 +++++
 linux-user/ioctls.h           |   2 +
 linux-user/qemu.h             |   1 +
 linux-user/syscall.c          |  35 +-
 linux-user/syscall_defs.h     |  12 +
 linux-user/syscall_types.h    | 277 ++++++++++++
 tests/tcg/multiarch/ethtool.c | 417 +++++++++++++++++
 10 files changed, 1680 insertions(+), 12 deletions(-)
 create mode 100644 linux-user/ethtool.c
 create mode 100644 linux-user/ethtool.h
 create mode 100644 linux-user/ethtool_entries.h
 create mode 100644 tests/tcg/multiarch/ethtool.c

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 1940910a73..971d43173a 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,7 +1,8 @@
 obj-y = main.o syscall.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
 	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
+	$(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o \
+	ethtool.o
 
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
diff --git a/linux-user/ethtool.c b/linux-user/ethtool.c
new file mode 100644
index 0000000000..cb134e7c9b
--- /dev/null
+++ b/linux-user/ethtool.c
@@ -0,0 +1,819 @@
+/*
+ *  Linux ioctl system call SIOCETHTOOL requests
+ *
+ *  Copyright (c) 2020 Shu-Chun Weng
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include <stdio.h>
+#include <linux/ethtool.h>
+#include <linux/if.h>
+#include <linux/sockios.h>
+#include <linux/unistd.h>
+#include "ethtool.h"
+#include "qemu.h"
+#include "syscall_defs.h"
+
+/* Non-standard ethtool structure definitions. */
+/* struct ethtool_rxnfc {
+ *     __u32 cmd;
+ *     __u32 flow_type;
+ *     __u64 data;
+ *     struct ethtool_rx_flow_spec fs;
+ *     union {
+ *         __u32 rule_cnt;
+ *         __u32 rss_context;
+ *     };
+ *     __u32 rule_locs[0];
+ * };
+ *
+ * Originally defined for ETHTOOL_{G,S}RXFH with only the cmd, flow_type and
+ * data members. For other commands, dedicated standard structure definitions
+ * are listed in syscall_types.h.
+ */
+static void host_to_target_ethtool_rxnfc_get_set_rxfh(void *dst,
+                                                      const void *src)
+{
+    static const argtype ethtool_rx_flow_spec_argtype[] = {
+        MK_STRUCT(STRUCT_ethtool_rx_flow_spec), TYPE_NULL };
+    struct ethtool_rxnfc *target = dst;
+    const struct ethtool_rxnfc *host = src;
+
+    target->cmd = tswap32(host->cmd);
+    target->flow_type = tswap32(host->flow_type);
+    target->data = tswap64(host->data);
+
+    if (host->cmd == ETHTOOL_SRXFH) {
+        /* struct ethtool_rxnfc was originally defined for ETHTOOL_{G,S}RXFH
+         * with only the cmd, flow_type and data members. Guest program might
+         * still be using that definition.
+         */
+        return;
+    }
+    if (host->cmd != ETHTOOL_GRXFH) {
+        fprintf(stderr, "host_to_target_ethtool_rxnfc_get_set_rxfh called with "
+                "command 0x%x which is not ETHTOOL_SRXFH or ETHTOOL_GRXFH\n",
+                host->cmd);
+    }
+    if ((host->flow_type & FLOW_RSS) == 0) {
+        return;
+    }
+    /* If `FLOW_RSS` was requested then guest program must be using the new
+     * definition.
+     */
+    thunk_convert(&target->fs, &host->fs, ethtool_rx_flow_spec_argtype,
+                  THUNK_TARGET);
+    target->rule_cnt = tswap32(host->rule_cnt);
+}
+
+static void target_to_host_ethtool_rxnfc_get_set_rxfh(void *dst,
+                                                      const void *src)
+{
+    static const argtype ethtool_rx_flow_spec_argtype[] = {
+        MK_STRUCT(STRUCT_ethtool_rx_flow_spec), TYPE_NULL };
+    struct ethtool_rxnfc *host = dst;
+    const struct ethtool_rxnfc *target = src;
+
+    host->cmd = tswap32(target->cmd);
+    host->flow_type = tswap32(target->flow_type);
+    host->data = tswap64(target->data);
+
+    if (host->cmd == ETHTOOL_SRXFH) {
+        /* struct ethtool_rxnfc was originally defined for ETHTOOL_{G,S}RXFH
+         * with only the cmd, flow_type and data members. Guest program might
+         * still be using that definition.
+         */
+        return;
+    }
+    if (host->cmd != ETHTOOL_GRXFH) {
+        fprintf(stderr, "target_to_host_ethtool_rxnfc_get_set_rxfh called with "
+                "command 0x%x which is not ETHTOOL_SRXFH or ETHTOOL_GRXFH\n",
+                host->cmd);
+    }
+    if ((host->flow_type & FLOW_RSS) == 0) {
+        return;
+    }
+    /* If `FLOW_RSS` was requested then guest program must be using the new
+     * definition.
+     */
+    thunk_convert(&host->fs, &target->fs, ethtool_rx_flow_spec_argtype,
+                  THUNK_HOST);
+    host->rule_cnt = tswap32(target->rule_cnt);
+}
+
+static int target_ethtool_rxnfc_get_set_rxfh_size(const void *src)
+{
+    const struct ethtool_rxnfc *target = src;
+    int cmd = tswap32(target->cmd);
+    if (cmd == ETHTOOL_SRXFH ||
+        (cmd == ETHTOOL_GRXFH &&
+         (tswap32(target->flow_type) & FLOW_RSS) == 0)) {
+        return 16;
+    }
+    return sizeof(struct ethtool_rxnfc);
+}
+
+static int host_ethtool_rxnfc_get_set_rxfh_size(const void *src)
+{
+    const struct ethtool_rxnfc *host = src;
+    if (host->cmd == ETHTOOL_SRXFH ||
+        (host->cmd == ETHTOOL_GRXFH && (host->flow_type & FLOW_RSS) == 0)) {
+        return 16;
+    }
+    return sizeof(struct ethtool_rxnfc);
+}
+
+const StructEntry struct_ethtool_rxnfc_get_set_rxfh_def = {
+    .convert = {
+        host_to_target_ethtool_rxnfc_get_set_rxfh,
+        target_to_host_ethtool_rxnfc_get_set_rxfh },
+    .thunk_size = {
+        target_ethtool_rxnfc_get_set_rxfh_size,
+        host_ethtool_rxnfc_get_set_rxfh_size },
+    .size = { 16, 16 },
+    .align = {
+        __alignof__(struct ethtool_rxnfc),
+        __alignof__(struct ethtool_rxnfc) },
+};
+
+/* struct ethtool_sset_info {
+ *     __u32 cmd;
+ *     __u32 reserved;
+ *     __u64 sset_mask;
+ *     __u32 data[0];
+ * };
+ *
+ * `sset_mask` is a bitmask of string sets. `data` is the buffer for string set
+ * sizes, containing number of 1s in `sset_mask`'s binary representation number
+ * of 4-byte entries.
+ *
+ * Since all fields are fixed-width and number of 1s in `sset_mask` does not
+ * change between architectures, host-to-target and target-to-host are
+ * identical.
+ */
+static void convert_ethtool_sset_info(void *dst, const void *src)
+{
+    int i, set_count;
+    struct ethtool_sset_info *dst_sset_info = dst;
+    const struct ethtool_sset_info *src_sset_info = src;
+
+    dst_sset_info->cmd = tswap32(src_sset_info->cmd);
+    dst_sset_info->sset_mask = tswap64(src_sset_info->sset_mask);
+
+    set_count = ctpop64(src_sset_info->sset_mask);
+    for (i = 0; i < set_count; ++i) {
+        dst_sset_info->data[i] = tswap32(src_sset_info->data[i]);
+    }
+}
+
+static int ethtool_sset_info_size(const void *src)
+{
+    const struct ethtool_sset_info *src_sset_info = src;
+    return sizeof(struct ethtool_sset_info) +
+        ctpop64(src_sset_info->sset_mask) * sizeof(src_sset_info->data[0]);
+}
+
+const StructEntry struct_ethtool_sset_info_def = {
+    .convert = {
+        convert_ethtool_sset_info, convert_ethtool_sset_info },
+    .thunk_size = {
+        ethtool_sset_info_size, ethtool_sset_info_size },
+    .size = {
+        sizeof(struct ethtool_sset_info),
+        sizeof(struct ethtool_sset_info) },
+    .align = {
+        __alignof__(struct ethtool_sset_info),
+        __alignof__(struct ethtool_sset_info) },
+};
+
+/* struct ethtool_rxfh {
+ *     __u32 cmd;
+ *     __u32 rss_context;
+ *     __u32 indir_size;
+ *     __u32 key_size;
+ *     __u8  hfunc;
+ *     __u8  rsvd8[3];
+ *     __u32 rsvd32;
+ *     __u32 rss_config[0];
+ * };
+ *
+ * `rss_config`: indirection table of `indir_size` __u32 elements, followed by
+ * hash key of `key_size` bytes.
+ *
+ * `indir_size` could be ETH_RXFH_INDIR_NO_CHANGE when `cmd` is ETHTOOL_SRSSH
+ * and there would be no indircetion table in `rss_config`.
+ */
+static void convert_ethtool_rxfh_header(void *dst, const void *src)
+{
+    struct ethtool_rxfh *dst_rxfh = dst;
+    const struct ethtool_rxfh *src_rxfh = src;
+
+    dst_rxfh->cmd = tswap32(src_rxfh->cmd);
+    dst_rxfh->rss_context = tswap32(src_rxfh->rss_context);
+    dst_rxfh->indir_size = tswap32(src_rxfh->indir_size);
+    dst_rxfh->key_size = tswap32(src_rxfh->key_size);
+    dst_rxfh->hfunc = src_rxfh->hfunc;
+    dst_rxfh->rsvd8[0] = src_rxfh->rsvd8[0];
+    dst_rxfh->rsvd8[1] = src_rxfh->rsvd8[1];
+    dst_rxfh->rsvd8[2] = src_rxfh->rsvd8[2];
+    dst_rxfh->rsvd32 = tswap32(src_rxfh->rsvd32);
+}
+
+static void convert_ethtool_rxfh_rss_config(
+    void *dst, const void *src, uint32_t indir_size, uint32_t key_size) {
+    uint32_t *dst_rss_config = (uint32_t *)dst;
+    const uint32_t *src_rss_config = (const uint32_t *)src;
+    int i;
+    for (i = 0; i < indir_size; ++i) {
+        dst_rss_config[i] = tswap32(src_rss_config[i]);
+    }
+    if (key_size > 0) {
+        memcpy(dst_rss_config + indir_size,
+               src_rss_config + indir_size,
+               key_size);
+    }
+}
+
+static void host_to_target_ethtool_rxfh(void *dst, const void *src)
+{
+    struct ethtool_rxfh *target = dst;
+    const struct ethtool_rxfh *host = src;
+
+    convert_ethtool_rxfh_header(dst, src);
+
+    const uint32_t indir_size =
+        host->cmd == ETHTOOL_SRSSH &&
+        host->indir_size == ETH_RXFH_INDIR_NO_CHANGE ?
+        0 :
+        host->indir_size;
+    convert_ethtool_rxfh_rss_config(target->rss_config, host->rss_config,
+                                    indir_size, host->key_size);
+}
+
+static void target_to_host_ethtool_rxfh(void *dst, const void *src)
+{
+    struct ethtool_rxfh *host = dst;
+    const struct ethtool_rxfh *target = src;
+
+    convert_ethtool_rxfh_header(dst, src);
+
+    const uint32_t indir_size =
+        host->cmd == ETHTOOL_SRSSH &&
+        host->indir_size == ETH_RXFH_INDIR_NO_CHANGE ?
+        0 :
+        host->indir_size;
+    convert_ethtool_rxfh_rss_config(host->rss_config, target->rss_config,
+                                    indir_size, host->key_size);
+}
+
+static int target_ethtool_rxfh_size(const void *src)
+{
+    const struct ethtool_rxfh *target = src;
+    if (tswap32(target->cmd) == ETHTOOL_SRSSH &&
+        tswap32(target->indir_size) == ETH_RXFH_INDIR_NO_CHANGE) {
+        return sizeof(struct ethtool_rxfh) + tswap32(target->key_size);
+    }
+    return sizeof(struct ethtool_rxfh) +
+        tswap32(target->indir_size) * sizeof(target->rss_config[0]) +
+        tswap32(target->key_size);
+}
+
+static int host_ethtool_rxfh_size(const void *src)
+{
+    const struct ethtool_rxfh *host = src;
+    if (host->cmd == ETHTOOL_SRSSH &&
+        host->indir_size == ETH_RXFH_INDIR_NO_CHANGE) {
+        return sizeof(struct ethtool_rxfh) + host->key_size;
+    }
+    return sizeof(struct ethtool_rxfh) +
+        host->indir_size * sizeof(host->rss_config[0]) +
+        host->key_size;
+}
+
+const StructEntry struct_ethtool_rxfh_def = {
+    .convert = {
+        host_to_target_ethtool_rxfh, target_to_host_ethtool_rxfh },
+    .thunk_size = {
+        target_ethtool_rxfh_size, host_ethtool_rxfh_size },
+    .size = {
+        sizeof(struct ethtool_rxfh), sizeof(struct ethtool_rxfh) },
+    .align = {
+        __alignof__(struct ethtool_rxfh), __alignof__(struct ethtool_rxfh) },
+};
+
+/* struct ethtool_link_settings {
+ *     __u32 cmd;
+ *     __u32 speed;
+ *     __u8  duplex;
+ *     __u8  port;
+ *     __u8  phy_address;
+ *     __u8  autoneg;
+ *     __u8  mdio_support;
+ *     __u8  eth_tp_mdix;
+ *     __u8  eth_tp_mdix_ctrl;
+ *     __s8  link_mode_masks_nwords;
+ *     __u8  transceiver;
+ *     __u8  reserved1[3];
+ *     __u32 reserved[7];
+ *     __u32 link_mode_masks[0];
+ * };
+ *
+ * layout of link_mode_masks fields:
+ * __u32 map_supported[link_mode_masks_nwords];
+ * __u32 map_advertising[link_mode_masks_nwords];
+ * __u32 map_lp_advertising[link_mode_masks_nwords];
+ *
+ * `link_mode_masks_nwords` can be negative when returning from kernel if the
+ * provided request size is not supported.
+ */
+
+static void host_to_target_ethtool_link_settings(void *dst, const void *src)
+{
+    int i;
+    struct ethtool_link_settings *target = dst;
+    const struct ethtool_link_settings *host = src;
+
+    target->cmd = tswap32(host->cmd);
+    target->speed = tswap32(host->speed);
+    target->duplex = host->duplex;
+    target->port = host->port;
+    target->phy_address = host->phy_address;
+    target->autoneg = host->autoneg;
+    target->mdio_support = host->mdio_support;
+    target->eth_tp_mdix = host->eth_tp_mdix;
+    target->eth_tp_mdix_ctrl = host->eth_tp_mdix_ctrl;
+    target->link_mode_masks_nwords = host->link_mode_masks_nwords;
+    target->transceiver = host->transceiver;
+    for (i = 0; i < 3; ++i) {
+        target->reserved1[i] = host->reserved1[i];
+    }
+    for (i = 0; i < 7; ++i) {
+        target->reserved[i] = tswap32(host->reserved[i]);
+    }
+
+    if (host->link_mode_masks_nwords > 0) {
+        for (i = 0; i < host->link_mode_masks_nwords * 3; ++i) {
+            target->link_mode_masks[i] = tswap32(host->link_mode_masks[i]);
+        }
+    }
+}
+
+static void target_to_host_ethtool_link_settings(void *dst, const void *src)
+{
+    int i;
+    struct ethtool_link_settings *host = dst;
+    const struct ethtool_link_settings *target = src;
+
+    host->cmd = tswap32(target->cmd);
+    host->speed = tswap32(target->speed);
+    host->duplex = target->duplex;
+    host->port = target->port;
+    host->phy_address = target->phy_address;
+    host->autoneg = target->autoneg;
+    host->mdio_support = target->mdio_support;
+    host->eth_tp_mdix = target->eth_tp_mdix;
+    host->eth_tp_mdix_ctrl = target->eth_tp_mdix_ctrl;
+    host->link_mode_masks_nwords = target->link_mode_masks_nwords;
+    host->transceiver = target->transceiver;
+    for (i = 0; i < 3; ++i) {
+        host->reserved1[i] = target->reserved1[i];
+    }
+    for (i = 0; i < 7; ++i) {
+        host->reserved[i] = tswap32(target->reserved[i]);
+    }
+
+    if (host->link_mode_masks_nwords > 0) {
+        for (i = 0; i < host->link_mode_masks_nwords * 3; ++i) {
+            host->link_mode_masks[i] = tswap32(target->link_mode_masks[i]);
+        }
+    }
+}
+
+static int target_ethtool_link_settings_size(const void *src)
+{
+    const struct ethtool_link_settings *target = src;
+    if (target->link_mode_masks_nwords > 0) {
+        return sizeof(struct ethtool_link_settings) +
+            3 * target->link_mode_masks_nwords *
+            sizeof(target->link_mode_masks[0]);
+    } else {
+        return sizeof(struct ethtool_link_settings);
+    }
+}
+
+static int host_ethtool_link_settings_size(const void *src)
+{
+    const struct ethtool_link_settings *host = src;
+    if (host->link_mode_masks_nwords > 0) {
+        return sizeof(struct ethtool_link_settings) +
+            3 * host->link_mode_masks_nwords *
+            sizeof(host->link_mode_masks[0]);
+    } else {
+        return sizeof(struct ethtool_link_settings);
+    }
+}
+
+const StructEntry struct_ethtool_link_settings_def = {
+    .convert = {
+        host_to_target_ethtool_link_settings,
+        target_to_host_ethtool_link_settings
+    },
+    .thunk_size = {
+        target_ethtool_link_settings_size, host_ethtool_link_settings_size },
+    .size = {
+        sizeof(struct ethtool_link_settings),
+        sizeof(struct ethtool_link_settings) },
+    .align = {
+        __alignof__(struct ethtool_link_settings),
+        __alignof__(struct ethtool_link_settings) },
+};
+
+/* struct ethtool_per_queue_op {
+ *     __u32 cmd;
+ *     __u32 sub_command;
+ *     __u32 queue_mask[__KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32)];
+ *     char  data[];
+ * };
+ *
+ * `queue_mask` are a series of bitmasks of the queues. `data` is a complete
+ * command structure for each of the queues addressed.
+ *
+ * When `cmd` is `ETHTOOL_PERQUEUE` and `sub_command` is `ETHTOOL_GCOALESCE` or
+ * `ETHTOOL_SCOALESCE`, the command structure is `struct ethtool_coalesce`.
+ */
+static void host_to_target_ethtool_per_queue_op(void *dst, const void *src)
+{
+    static const argtype ethtool_coalesce_argtype[] = {
+        MK_STRUCT(STRUCT_ethtool_coalesce), TYPE_NULL };
+    int i, queue_count;
+    struct ethtool_per_queue_op *target = dst;
+    const struct ethtool_per_queue_op *host = src;
+
+    target->cmd = tswap32(host->cmd);
+    target->sub_command = tswap32(host->sub_command);
+
+    queue_count = 0;
+    for (i = 0; i < __KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32); ++i) {
+        target->queue_mask[i] = tswap32(host->queue_mask[i]);
+        queue_count += ctpop32(host->queue_mask[i]);
+    }
+
+    if (host->cmd != ETHTOOL_PERQUEUE ||
+        (host->sub_command != ETHTOOL_GCOALESCE &&
+         host->sub_command != ETHTOOL_SCOALESCE)) {
+        fprintf(stderr,
+                "Unknown command 0x%x sub_command 0x%x for "
+                "ethtool_per_queue_op, unable to convert the `data` field "
+                "(host-to-target)\n",
+                host->cmd, host->sub_command);
+        return;
+    }
+
+    for (i = 0; i < queue_count; ++i) {
+        thunk_convert(target->data + i * sizeof(struct ethtool_coalesce),
+                      host->data + i * sizeof(struct ethtool_coalesce),
+                      ethtool_coalesce_argtype, THUNK_TARGET);
+    }
+}
+
+static void target_to_host_ethtool_per_queue_op(void *dst, const void *src)
+{
+    static const argtype ethtool_coalesce_argtype[] = {
+        MK_STRUCT(STRUCT_ethtool_coalesce), TYPE_NULL };
+    int i, queue_count;
+    struct ethtool_per_queue_op *host = dst;
+    const struct ethtool_per_queue_op *target = src;
+
+    host->cmd = tswap32(target->cmd);
+    host->sub_command = tswap32(target->sub_command);
+
+    queue_count = 0;
+    for (i = 0; i < __KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32); ++i) {
+        host->queue_mask[i] = tswap32(target->queue_mask[i]);
+        queue_count += ctpop32(host->queue_mask[i]);
+    }
+
+    if (host->cmd != ETHTOOL_PERQUEUE ||
+        (host->sub_command != ETHTOOL_GCOALESCE &&
+         host->sub_command != ETHTOOL_SCOALESCE)) {
+        fprintf(stderr,
+                "Unknown command 0x%x sub_command 0x%x for "
+                "ethtool_per_queue_op, unable to convert the `data` field "
+                "(target-to-host)\n",
+                host->cmd, host->sub_command);
+        return;
+    }
+
+    for (i = 0; i < queue_count; ++i) {
+        thunk_convert(host->data + i * sizeof(struct ethtool_coalesce),
+                      target->data + i * sizeof(struct ethtool_coalesce),
+                      ethtool_coalesce_argtype, THUNK_HOST);
+    }
+}
+
+static int target_ethtool_per_queue_op_size(const void *src)
+{
+    int i, queue_count;
+    const struct ethtool_per_queue_op *target = src;
+
+    if (tswap32(target->cmd) != ETHTOOL_PERQUEUE ||
+        (tswap32(target->sub_command) != ETHTOOL_GCOALESCE &&
+         tswap32(target->sub_command) != ETHTOOL_SCOALESCE)) {
+        fprintf(stderr,
+                "Unknown command 0x%x sub_command 0x%x for "
+                "ethtool_per_queue_op, unable to compute the size of the "
+                "`data` field (target)\n",
+                tswap32(target->cmd), tswap32(target->sub_command));
+        return sizeof(struct ethtool_per_queue_op);
+    }
+
+    queue_count = 0;
+    for (i = 0; i < __KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32); ++i) {
+        queue_count += ctpop32(target->queue_mask[i]);
+    }
+    return sizeof(struct ethtool_per_queue_op) +
+        queue_count * sizeof(struct ethtool_coalesce);
+}
+
+static int host_ethtool_per_queue_op_size(const void *src)
+{
+    int i, queue_count;
+    const struct ethtool_per_queue_op *host = src;
+
+    if (host->cmd != ETHTOOL_PERQUEUE ||
+        (host->sub_command != ETHTOOL_GCOALESCE &&
+         host->sub_command != ETHTOOL_SCOALESCE)) {
+        fprintf(stderr,
+                "Unknown command 0x%x sub_command 0x%x for "
+                "ethtool_per_queue_op, unable to compute the size of the "
+                "`data` field (host)\n",
+                host->cmd, host->sub_command);
+        return sizeof(struct ethtool_per_queue_op);
+    }
+
+    queue_count = 0;
+    for (i = 0; i < __KERNEL_DIV_ROUND_UP(MAX_NUM_QUEUE, 32); ++i) {
+        queue_count += ctpop32(host->queue_mask[i]);
+    }
+    return sizeof(struct ethtool_per_queue_op) +
+        queue_count * sizeof(struct ethtool_coalesce);
+}
+
+const StructEntry struct_ethtool_per_queue_op_def = {
+    .convert = {
+        host_to_target_ethtool_per_queue_op,
+        target_to_host_ethtool_per_queue_op
+    },
+    .thunk_size = {
+        target_ethtool_per_queue_op_size, host_ethtool_per_queue_op_size },
+    .size = {
+        sizeof(struct ethtool_per_queue_op),
+        sizeof(struct ethtool_per_queue_op) },
+    .align = {
+        __alignof__(struct ethtool_per_queue_op),
+        __alignof__(struct ethtool_per_queue_op) },
+};
+
+#define safe_dev_ethtool(fd,...) \
+    safe_syscall(__NR_ioctl, (fd), SIOCETHTOOL, __VA_ARGS__)
+
+typedef struct EthtoolEntry EthtoolEntry;
+
+typedef abi_long do_ethtool_fn(const EthtoolEntry *ee, uint8_t *buf_temp,
+                               int fd, struct ifreq *host_ifreq);
+
+struct EthtoolEntry {
+    uint32_t cmd;
+    int access;
+    do_ethtool_fn *do_ethtool;
+    const argtype arg_type[3];
+};
+
+#define ETHT_R 0x0001
+#define ETHT_W 0x0002
+#define ETHT_RW (ETHT_R | ETHT_W)
+
+static do_ethtool_fn do_ethtool_get_rxfh;
+
+static EthtoolEntry ethtool_entries[] = {
+#define ETHTOOL(cmd, access, ...) \
+    { cmd, access, 0, { __VA_ARGS__ } },
+#define ETHTOOL_SPECIAL(cmd, access, dofn, ...) \
+    { cmd, access, dofn, { __VA_ARGS__ } },
+#include "ethtool_entries.h"
+#undef ETHTOOL
+#undef ETHTOOL_SPECIAL
+    { 0, 0 },
+};
+
+/* ETHTOOL_GRSSH has two modes of operations: querying the sizes of the indir
+ * and key as well as actually querying the indir and key. When either
+ * `indir_size` or `key_size` is zero, the size of the corresponding entry is
+ * retrieved and updated into the `ethtool_rxfh` struct. When either of them is
+ * non-zero, the actually indir or key is written to `rss_config`.
+ *
+ * This causes a problem for the generic framework which converts between host
+ * and target structures without the context. When the convertion function sees
+ * an `ethtool_rxfh` struct with non-zero `indir_size` or `key_size`, it has to
+ * assume that there are entries in `rss_config` and needs to convert them.
+ * Unfortunately, when converting the returned `ethtool_rxfh` struct from host
+ * to target after an ETHTOOL_GRSSH call with the first mode, the `indir_size`
+ * and `key_size` fields are populated but there is no actual data to be
+ * converted. More importantly, user programs would not have prepared enough
+ * memory for the convertion to take place safely.
+ *
+ * ETHTOOL_GRSSH thus needs a special implementation which is aware of the two
+ * modes of operations and converts the structure accordingly.
+ */
+abi_long do_ethtool_get_rxfh(const EthtoolEntry *ee, uint8_t *buf_temp,
+                             int fd, struct ifreq *host_ifreq)
+{
+    const argtype *arg_type = ee->arg_type;
+    const abi_long ifreq_data = (abi_long)(unsigned long)host_ifreq->ifr_data;
+    struct ethtool_rxfh *rxfh = (struct ethtool_rxfh *)buf_temp;
+    uint32_t user_indir_size, user_key_size;
+    abi_long ret;
+    void *argptr;
+
+    assert(arg_type[0] == TYPE_PTR);
+    assert(ee->access == IOC_RW);
+    arg_type++;
+
+    /* As of Linux kernel v5.8-rc4, ETHTOOL_GRSSH calls never read the
+     * `rss_config` part. Converting only the "header" part suffices.
+     */
+    argptr = lock_user(VERIFY_READ, ifreq_data, sizeof(*rxfh), 1);
+    if (!argptr)
+        return -TARGET_EFAULT;
+    convert_ethtool_rxfh_header(rxfh, argptr);
+    unlock_user(argptr, ifreq_data, sizeof(*rxfh));
+
+    if (rxfh->cmd != ETHTOOL_GRSSH)
+        return -TARGET_EINVAL;
+    user_indir_size = rxfh->indir_size;
+    user_key_size = rxfh->key_size;
+
+    host_ifreq->ifr_data = (void *)rxfh;
+    ret = get_errno(safe_dev_ethtool(fd, host_ifreq));
+
+    /* When a user program supplies `indir_size` or `key_size` but does not
+     * match what the kernel has, the syscall returns EINVAL but the structure
+     * is already updated. Mimicking it here.
+     */
+    argptr = lock_user(VERIFY_WRITE, ifreq_data, sizeof(*rxfh), 0);
+    if (!argptr)
+        return -TARGET_EFAULT;
+    convert_ethtool_rxfh_header(argptr, rxfh);
+    unlock_user(argptr, ifreq_data, 0);
+
+    if (is_error(ret))
+        return ret;
+
+    if (user_indir_size > 0 || user_key_size > 0) {
+        const int rss_config_size =
+            user_indir_size * sizeof(rxfh->rss_config[0]) + user_key_size;
+        argptr = lock_user(VERIFY_WRITE, ifreq_data + sizeof(*rxfh),
+                           rss_config_size, 0);
+        if (!argptr)
+            return -TARGET_EFAULT;
+        convert_ethtool_rxfh_rss_config(argptr, rxfh->rss_config,
+                                        user_indir_size, user_key_size);
+        unlock_user(argptr, ifreq_data + sizeof(*rxfh), rss_config_size);
+    }
+    return ret;
+}
+
+/* Calculates the size of the data type represented by `type_ptr` with
+ * `guest_addr` being the underlying memory. Since `type_ptr` may contain
+ * flexible arrays, we need access to the underlying memory to determine their
+ * sizes.
+ */
+static int thunk_size(abi_long guest_addr, const argtype *type_ptr)
+{
+    /* lock_user based on `thunk_type_size` then call `thunk_type_size_with_src`
+     * on it.
+     */
+    void *src;
+    int type_size = thunk_type_size(type_ptr, /*is_host=*/0);
+    if (!thunk_type_has_flexible_array(type_ptr)) {
+        return type_size;
+    }
+
+    src = lock_user(VERIFY_READ, guest_addr, type_size, 0);
+    type_size = thunk_type_size_with_src(src, type_ptr, /*is_host=*/0);
+    unlock_user(src, guest_addr, 0);
+
+    return type_size;
+}
+
+abi_long dev_ethtool(int fd, uint8_t *buf_temp)
+{
+    uint32_t *cmd;
+    uint32_t host_cmd;
+    const EthtoolEntry *ee;
+    const argtype *arg_type;
+    abi_long ret;
+    int target_size;
+    void *argptr;
+
+    /* Make a copy of `host_ifreq` because we are going to reuse `buf_temp` and
+     * overwrite it. Further, we will overwrite `host_ifreq.ifreq_data`, so
+     * keep a copy in `ifreq_data`.
+     */
+    struct ifreq host_ifreq = *(struct ifreq *)(unsigned long)buf_temp;
+    const abi_long ifreq_data = (abi_long)(unsigned long)host_ifreq.ifr_data;
+
+    cmd = (uint32_t *)lock_user(VERIFY_READ, ifreq_data, sizeof(uint32_t), 0);
+    host_cmd = tswap32(*cmd);
+    unlock_user(cmd, ifreq_data, 0);
+
+    ee = ethtool_entries;
+    for(;;) {
+        if (ee->cmd == 0) {
+            qemu_log_mask(LOG_UNIMP, "Unsupported ethtool cmd=0x%04lx\n",
+                          (long)host_cmd);
+            return -TARGET_ENOSYS;
+        }
+        if (ee->cmd == host_cmd) {
+            break;
+        }
+        ee++;
+    }
+    if (ee->do_ethtool) {
+        return ee->do_ethtool(ee, buf_temp, fd, &host_ifreq);
+    }
+
+    host_ifreq.ifr_data = buf_temp;
+    /* Even for ETHT_R, cmd still needs to be copied. */
+    *(uint32_t *)buf_temp = host_cmd;
+
+    arg_type = ee->arg_type;
+    switch (arg_type[0]) {
+    case TYPE_NULL:
+        /* no argument other than cmd */
+        ret = get_errno(safe_dev_ethtool(fd, &host_ifreq));
+        break;
+    case TYPE_PTR:
+        arg_type++;
+        target_size = thunk_size(ifreq_data, arg_type);
+        switch (ee->access) {
+        case ETHT_R:
+            ret = get_errno(safe_dev_ethtool(fd, &host_ifreq));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, ifreq_data, target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type, THUNK_TARGET);
+                unlock_user(argptr, ifreq_data, target_size);
+            }
+            break;
+        case ETHT_W:
+            argptr = lock_user(VERIFY_READ, ifreq_data, target_size, 1);
+            if (!argptr) {
+                return -TARGET_EFAULT;
+            }
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, ifreq_data, 0);
+            ret = get_errno(safe_dev_ethtool(fd, &host_ifreq));
+            break;
+        default:
+        case ETHT_RW:
+            argptr = lock_user(VERIFY_READ, ifreq_data, target_size, 1);
+            if (!argptr)
+                return -TARGET_EFAULT;
+            thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+            unlock_user(argptr, ifreq_data, 0);
+            ret = get_errno(safe_dev_ethtool(fd, &host_ifreq));
+            if (!is_error(ret)) {
+                argptr = lock_user(VERIFY_WRITE, ifreq_data, target_size, 0);
+                if (!argptr) {
+                    return -TARGET_EFAULT;
+                }
+                thunk_convert(argptr, buf_temp, arg_type, THUNK_TARGET);
+                unlock_user(argptr, ifreq_data, target_size);
+            }
+            break;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "Unsupported ethtool type: cmd=0x%04lx type=%d\n",
+                      (long)host_cmd, arg_type[0]);
+        ret = -TARGET_ENOSYS;
+        break;
+    }
+    return ret;
+}
diff --git a/linux-user/ethtool.h b/linux-user/ethtool.h
new file mode 100644
index 0000000000..24de5dccb3
--- /dev/null
+++ b/linux-user/ethtool.h
@@ -0,0 +1,19 @@
+#ifndef ETHTOOL_H
+#define ETHTOOL_H
+
+#include <linux/if.h>
+#include "qemu.h"
+
+extern const StructEntry struct_ethtool_rxnfc_get_set_rxfh_def;
+extern const StructEntry struct_ethtool_sset_info_def;
+extern const StructEntry struct_ethtool_rxfh_def;
+extern const StructEntry struct_ethtool_link_settings_def;
+extern const StructEntry struct_ethtool_per_queue_op_def;
+
+/* Takes the file descriptor and the buffer for temporarily storing data read
+ * from / to be written to guest memory. `buf_temp` must now contain the host
+ * representation of `struct ifreq`.
+ */
+abi_long dev_ethtool(int fd, uint8_t *buf_temp);
+
+#endif /* ETHTOOL_H */
diff --git a/linux-user/ethtool_entries.h b/linux-user/ethtool_entries.h
new file mode 100644
index 0000000000..14f4e80a21
--- /dev/null
+++ b/linux-user/ethtool_entries.h
@@ -0,0 +1,107 @@
+  ETHTOOL(ETHTOOL_GSET, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_cmd)))
+  ETHTOOL(ETHTOOL_SSET, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_cmd)))
+  ETHTOOL(ETHTOOL_GDRVINFO, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_drvinfo)))
+  ETHTOOL(ETHTOOL_GREGS, ETHT_RW, MK_PTR(MK_STRUCT(STRUCT_ethtool_regs)))
+  ETHTOOL(ETHTOOL_GWOL, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_wolinfo)))
+  ETHTOOL(ETHTOOL_SWOL, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_wolinfo)))
+  ETHTOOL(ETHTOOL_GMSGLVL, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_SMSGLVL, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GEEE, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_eee)))
+  ETHTOOL(ETHTOOL_SEEE, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_eee)))
+  ETHTOOL(ETHTOOL_NWAY_RST, 0, TYPE_NULL)
+  ETHTOOL(ETHTOOL_GLINK, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GEEPROM, ETHT_RW, MK_PTR(MK_STRUCT(STRUCT_ethtool_eeprom)))
+  ETHTOOL(ETHTOOL_SEEPROM, ETHT_RW, MK_PTR(MK_STRUCT(STRUCT_ethtool_eeprom)))
+  ETHTOOL(ETHTOOL_GCOALESCE, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_coalesce)))
+  ETHTOOL(ETHTOOL_SCOALESCE, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_coalesce)))
+  ETHTOOL(ETHTOOL_GRINGPARAM, ETHT_R,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_ringparam)))
+  ETHTOOL(ETHTOOL_SRINGPARAM, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_ringparam)))
+  ETHTOOL(ETHTOOL_GPAUSEPARAM, ETHT_R,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_pauseparam)))
+  ETHTOOL(ETHTOOL_SPAUSEPARAM, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_pauseparam)))
+  ETHTOOL(ETHTOOL_TEST, ETHT_RW, MK_PTR(MK_STRUCT(STRUCT_ethtool_test)))
+  ETHTOOL(ETHTOOL_GSTRINGS, ETHT_RW, MK_PTR(MK_STRUCT(STRUCT_ethtool_gstrings)))
+  ETHTOOL(ETHTOOL_PHYS_ID, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GSTATS, ETHT_RW, MK_PTR(MK_STRUCT(STRUCT_ethtool_stats)))
+  ETHTOOL(ETHTOOL_GPERMADDR, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_perm_addr)))
+  ETHTOOL(ETHTOOL_GFLAGS, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_SFLAGS, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GPFLAGS, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_SPFLAGS, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GRXFH, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxnfc_get_set_rxfh)))
+  ETHTOOL(ETHTOOL_GRXRINGS, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxnfc_rss_context)))
+  ETHTOOL(ETHTOOL_GRXCLSRLCNT, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxnfc_rule_cnt)))
+  ETHTOOL(ETHTOOL_GRXCLSRULE, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxnfc_rss_context)))
+  ETHTOOL(ETHTOOL_GRXCLSRLALL, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxnfc_rule_locs)))
+  ETHTOOL(ETHTOOL_SRXFH, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxnfc_get_set_rxfh)))
+  ETHTOOL(ETHTOOL_SRXCLSRLDEL, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxnfc_rss_context)))
+  ETHTOOL(ETHTOOL_SRXCLSRLINS, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxnfc_rss_context)))
+  ETHTOOL(ETHTOOL_FLASHDEV, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_flash)))
+  ETHTOOL(ETHTOOL_RESET, ETHT_RW, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GSSET_INFO, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_sset_info)))
+  ETHTOOL(ETHTOOL_GRXFHINDIR, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxfh_indir)))
+  ETHTOOL(ETHTOOL_SRXFHINDIR, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxfh_indir)))
+  ETHTOOL_SPECIAL(ETHTOOL_GRSSH, ETHT_RW, do_ethtool_get_rxfh,
+                  MK_PTR(MK_STRUCT(STRUCT_ethtool_rxfh)))
+  ETHTOOL(ETHTOOL_SRSSH, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_rxfh)))
+  ETHTOOL(ETHTOOL_GFEATURES, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_gfeatures)))
+  ETHTOOL(ETHTOOL_SFEATURES, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_sfeatures)))
+  ETHTOOL(ETHTOOL_GTXCSUM, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GRXCSUM, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GSG, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GTSO, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GGSO, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GGRO, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_STXCSUM, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_SRXCSUM, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_SSG, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_STSO, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_SGSO, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_SGRO, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_value)))
+  ETHTOOL(ETHTOOL_GCHANNELS, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_channels)))
+  ETHTOOL(ETHTOOL_SCHANNELS, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_channels)))
+  ETHTOOL(ETHTOOL_SET_DUMP, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_dump_no_data)))
+  ETHTOOL(ETHTOOL_GET_DUMP_FLAG, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_dump_no_data)))
+  ETHTOOL(ETHTOOL_GET_DUMP_DATA, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_dump)))
+  ETHTOOL(ETHTOOL_GET_TS_INFO, ETHT_R,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_ts_info)))
+  ETHTOOL(ETHTOOL_GMODULEINFO, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_modinfo)))
+  ETHTOOL(ETHTOOL_GMODULEEEPROM, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_eeprom)))
+  ETHTOOL(ETHTOOL_GTUNABLE, ETHT_RW, MK_PTR(MK_STRUCT(STRUCT_ethtool_tunable)))
+  ETHTOOL(ETHTOOL_STUNABLE, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_tunable)))
+  ETHTOOL(ETHTOOL_GPHYSTATS, ETHT_RW, MK_PTR(MK_STRUCT(STRUCT_ethtool_stats)))
+  ETHTOOL(ETHTOOL_PERQUEUE, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_per_queue_op)))
+  ETHTOOL(ETHTOOL_GLINKSETTINGS, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_link_settings)))
+  ETHTOOL(ETHTOOL_SLINKSETTINGS, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_link_settings)))
+  ETHTOOL(ETHTOOL_PHY_GTUNABLE, ETHT_RW,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_tunable)))
+  ETHTOOL(ETHTOOL_PHY_STUNABLE, ETHT_W,
+          MK_PTR(MK_STRUCT(STRUCT_ethtool_tunable)))
+  ETHTOOL(ETHTOOL_GFECPARAM, ETHT_R, MK_PTR(MK_STRUCT(STRUCT_ethtool_fecparam)))
+  ETHTOOL(ETHTOOL_GFECPARAM, ETHT_W, MK_PTR(MK_STRUCT(STRUCT_ethtool_fecparam)))
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0713ae1311..fd6ac963ec 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -238,6 +238,8 @@
   IOCTL(SIOCSIFHWADDR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
   IOCTL(SIOCGIFTXQLEN, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
   IOCTL(SIOCSIFTXQLEN, IOC_W, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
+  IOCTL_SPECIAL(SIOCETHTOOL, IOC_W | IOC_R, do_ioctl_ethtool,
+                MK_PTR(MK_STRUCT(STRUCT_ptr_ifreq)))
   IOCTL(SIOCGIFMETRIC, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCSIFMETRIC, IOC_W, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCGIFMTU, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5c964389c1..43f00681f8 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -231,6 +231,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8);
+abi_long get_errno(abi_long ret);
 extern __thread CPUState *thread_cpu;
 void cpu_loop(CPUArchState *env);
 const char *target_strerror(int err);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 483f8ce48f..bbdcc5d4db 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -127,6 +127,7 @@
 #include "qapi/error.h"
 #include "fd-trans.h"
 #include "tcg/tcg.h"
+#include "ethtool.h"
 
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -683,7 +684,7 @@ static inline int target_to_host_errno(int err)
     return err;
 }
 
-static inline abi_long get_errno(abi_long ret)
+abi_long get_errno(abi_long ret)
 {
     if (ret == -1)
         return -host_to_target_errno(errno);
@@ -4681,16 +4682,6 @@ static abi_long do_ipc(CPUArchState *cpu_env,
 #endif
 
 /* kernel structure types definitions */
-
-#define STRUCT(name, ...) STRUCT_ ## name,
-#define STRUCT_SPECIAL(name) STRUCT_ ## name,
-enum {
-#include "syscall_types.h"
-STRUCT_MAX
-};
-#undef STRUCT
-#undef STRUCT_SPECIAL
-
 #define STRUCT(name, ...) static const argtype struct_ ## name ## _def[] = {  __VA_ARGS__, TYPE_NULL };
 #define STRUCT_SPECIAL(name)
 #include "syscall_types.h"
@@ -4788,6 +4779,28 @@ static abi_long do_ioctl_fs_ioc_fiemap(const IOCTLEntry *ie, uint8_t *buf_temp,
 }
 #endif
 
+static abi_long do_ioctl_ethtool(const IOCTLEntry *ie, uint8_t *buf_temp,
+                                int fd, int cmd, abi_long arg)
+{
+    const argtype *arg_type = ie->arg_type;
+    int target_size;
+    void *argptr;
+
+    assert(arg_type[0] == TYPE_PTR);
+    assert(ie->access == IOC_RW);
+
+    arg_type++;
+    target_size = thunk_type_size(arg_type, 0);
+
+    argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+    if (!argptr)
+        return -TARGET_EFAULT;
+    thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
+    unlock_user(argptr, arg, target_size);
+
+    return dev_ethtool(fd, buf_temp);
+}
+
 static abi_long do_ioctl_ifconf(const IOCTLEntry *ie, uint8_t *buf_temp,
                                 int fd, int cmd, abi_long arg)
 {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 70df1a94fb..5d344d5ffa 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -866,6 +866,8 @@ struct target_rtc_pll_info {
 #define TARGET_SIOCGIFTXQLEN   0x8942          /* Get the tx queue length      */
 #define TARGET_SIOCSIFTXQLEN   0x8943          /* Set the tx queue length      */
 
+#define TARGET_SIOCETHTOOL     0x8946          /* Ethtool interface            */
+
 /* ARP cache control calls. */
 #define TARGET_OLD_SIOCDARP    0x8950          /* old delete ARP table entry   */
 #define TARGET_OLD_SIOCGARP    0x8951          /* old get ARP table entry      */
@@ -2776,4 +2778,14 @@ struct target_statx {
    /* 0x100 */
 };
 
+/* kernel structure types definitions */
+#define STRUCT(name, ...) STRUCT_ ## name,
+#define STRUCT_SPECIAL(name) STRUCT_ ## name,
+enum {
+#include "syscall_types.h"
+STRUCT_MAX
+};
+#undef STRUCT
+#undef STRUCT_SPECIAL
+
 #endif
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 3f1f033464..e920086e66 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -1,3 +1,4 @@
+
 STRUCT_SPECIAL(termios)
 
 STRUCT(winsize,
@@ -464,3 +465,279 @@ STRUCT(usbdevfs_disconnect_claim,
         TYPE_INT, /* flags */
         MK_ARRAY(TYPE_CHAR, USBDEVFS_MAXDRIVERNAME + 1)) /* driver */
 #endif /* CONFIG_USBFS */
+
+/* ethtool ioctls */
+STRUCT(ethtool_cmd,
+       TYPE_INT,   /* cmd */
+       TYPE_INT,   /* supported */
+       TYPE_INT,   /* advertising */
+       TYPE_SHORT, /* speed */
+       TYPE_CHAR,  /* duplex */
+       TYPE_CHAR,  /* port */
+       TYPE_CHAR,  /* phy_address */
+       TYPE_CHAR,  /* transceiver */
+       TYPE_CHAR,  /* autoneg */
+       TYPE_CHAR,  /* mdio_support */
+       TYPE_INT,   /* maxtxpkt */
+       TYPE_INT,   /* maxrxpkt */
+       TYPE_SHORT, /* speed_hi */
+       TYPE_CHAR,  /* eth_tp_mdix */
+       TYPE_CHAR,  /* eth_tp_mdix_ctrl */
+       TYPE_INT,   /* lp_advertising */
+       MK_ARRAY(TYPE_INT, 2)) /* reserved */
+
+STRUCT(ethtool_drvinfo,
+       TYPE_INT, /* cmd */
+       MK_ARRAY(TYPE_CHAR, 32), /* driver */
+       MK_ARRAY(TYPE_CHAR, 32), /* version */
+       MK_ARRAY(TYPE_CHAR, 32), /* fw_version[ETHTOOL_FWVERS_LEN] */
+       MK_ARRAY(TYPE_CHAR, 32), /* bus_info[ETHTOOL_BUSINFO_LEN] */
+       MK_ARRAY(TYPE_CHAR, 32), /* erom_version[ETHTOOL_EROMVERS_LEN] */
+       MK_ARRAY(TYPE_CHAR, 12), /* reserved2 */
+       TYPE_INT, /* n_priv_flags */
+       TYPE_INT, /* n_stats */
+       TYPE_INT, /* testinfo_len */
+       TYPE_INT, /* eedump_len */
+       TYPE_INT) /* regdump_len */
+
+STRUCT(ethtool_regs,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* version */
+       TYPE_INT, /* len */
+       MK_FLEXIBLE_ARRAY(TYPE_CHAR, 2)) /* data[0]: len */
+
+STRUCT(ethtool_wolinfo,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* supported */
+       TYPE_INT, /* wolopts */
+       MK_ARRAY(TYPE_CHAR,  6)) /* sopass[SOPASS_MAX] */
+
+STRUCT(ethtool_value,
+       TYPE_INT, /* cmd */
+       TYPE_INT) /* data */
+
+STRUCT(ethtool_eee,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* supported */
+       TYPE_INT, /* advertised */
+       TYPE_INT, /* lp_advertised */
+       TYPE_INT, /* eee_active */
+       TYPE_INT, /* eee_enabled */
+       TYPE_INT, /* tx_lpi_enabled */
+       TYPE_INT, /* tx_lpi_timer */
+       MK_ARRAY(TYPE_INT, 2)) /* reserved */
+
+STRUCT(ethtool_eeprom,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* magic */
+       TYPE_INT, /* offset */
+       TYPE_INT, /* len */
+       MK_FLEXIBLE_ARRAY(TYPE_CHAR, 3)) /* data[0]: len */
+
+STRUCT(ethtool_coalesce,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* rx_coalesce_usecs */
+       TYPE_INT, /* rx_max_coalesced_frames */
+       TYPE_INT, /* rx_coalesce_usecs_irq */
+       TYPE_INT, /* rx_max_coalesced_frames_irq */
+       TYPE_INT, /* tx_coalesce_usecs */
+       TYPE_INT, /* tx_max_coalesced_frames */
+       TYPE_INT, /* tx_coalesce_usecs_irq */
+       TYPE_INT, /* tx_max_coalesced_frames_irq */
+       TYPE_INT, /* stats_block_coalesce_usecs */
+       TYPE_INT, /* use_adaptive_rx_coalesce */
+       TYPE_INT, /* use_adaptive_tx_coalesce */
+       TYPE_INT, /* pkt_rate_low */
+       TYPE_INT, /* rx_coalesce_usecs_low */
+       TYPE_INT, /* rx_max_coalesced_frames_low */
+       TYPE_INT, /* tx_coalesce_usecs_low */
+       TYPE_INT, /* tx_max_coalesced_frames_low */
+       TYPE_INT, /* pkt_rate_high */
+       TYPE_INT, /* rx_coalesce_usecs_high */
+       TYPE_INT, /* rx_max_coalesced_frames_high */
+       TYPE_INT, /* tx_coalesce_usecs_high */
+       TYPE_INT, /* tx_max_coalesced_frames_high */
+       TYPE_INT) /* rate_sample_interval */
+
+STRUCT(ethtool_ringparam,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* rx_max_pending */
+       TYPE_INT, /* rx_mini_max_pending */
+       TYPE_INT, /* rx_jumbo_max_pending */
+       TYPE_INT, /* tx_max_pending */
+       TYPE_INT, /* rx_pending */
+       TYPE_INT, /* rx_mini_pending */
+       TYPE_INT, /* rx_jumbo_pending */
+       TYPE_INT) /* tx_pending */
+
+STRUCT(ethtool_pauseparam,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* autoneg */
+       TYPE_INT, /* rx_pause */
+       TYPE_INT) /* tx_pause */
+
+STRUCT(ethtool_test,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* flags */
+       TYPE_INT, /* reserved */
+       TYPE_INT, /* len */
+       MK_FLEXIBLE_ARRAY(TYPE_LONGLONG, 3)) /* data[0]: len */
+
+STRUCT(ethtool_gstrings,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* string_set */
+       TYPE_INT, /* len */
+       MK_FLEXIBLE_ARRAY(MK_ARRAY(TYPE_CHAR, 32), 2))
+       /* data[0]: len * ETH_GSTRING_LEN */
+
+STRUCT(ethtool_stats,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* n_stats */
+       MK_FLEXIBLE_ARRAY(TYPE_LONGLONG, 1)) /* data[0]: n_stats */
+
+STRUCT(ethtool_perm_addr,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* size */
+       MK_FLEXIBLE_ARRAY(TYPE_CHAR, 1)) /* data[0]: size */
+
+STRUCT(ethtool_flow_ext,
+       MK_ARRAY(TYPE_CHAR, 2), /* padding */
+       MK_ARRAY(TYPE_CHAR, 6), /* h_dest[ETH_ALEN] */
+       MK_ARRAY(TYPE_CHAR, 2), /* __be16 vlan_etype */
+       MK_ARRAY(TYPE_CHAR, 2), /* __be16 vlan_tci */
+       MK_ARRAY(TYPE_CHAR, 8)) /* __be32 data[2] */
+
+/* Union ethtool_flow_union contains alternatives that are either struct that
+ * only uses __be* types or char/__u8, or "__u8 hdata[52]". We can treat it as
+ * byte array in all cases.
+ */
+STRUCT(ethtool_rx_flow_spec,
+       TYPE_INT,                           /* flow_type */
+       MK_ARRAY(TYPE_CHAR, 52),            /* union ethtool_flow_union h_u */
+       MK_STRUCT(STRUCT_ethtool_flow_ext), /* h_ext */
+       MK_ARRAY(TYPE_CHAR, 52),            /* union ethtool_flow_union m_u */
+       MK_STRUCT(STRUCT_ethtool_flow_ext), /* m_ext */
+       TYPE_LONGLONG,                      /* ring_cookie */
+       TYPE_INT)                           /* location */
+
+STRUCT(ethtool_rxnfc_rss_context,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* flow_type */
+       TYPE_LONGLONG, /* data */
+       MK_STRUCT(STRUCT_ethtool_rx_flow_spec), /* fs */
+       TYPE_INT) /* rss_context */
+
+STRUCT(ethtool_rxnfc_rule_cnt,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* flow_type */
+       TYPE_LONGLONG, /* data */
+       MK_STRUCT(STRUCT_ethtool_rx_flow_spec), /* fs */
+       TYPE_INT) /* rss_cnt */
+
+STRUCT(ethtool_rxnfc_rule_locs,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* flow_type */
+       TYPE_LONGLONG, /* data */
+       MK_STRUCT(STRUCT_ethtool_rx_flow_spec), /* fs */
+       TYPE_INT, /* rss_cnt */
+       MK_FLEXIBLE_ARRAY(TYPE_INT, 4)) /* rule_locs[0]: rss_cnt */
+
+/* For ETHTOOL_{G,S}RXFH, originally only the first three fields are defined,
+ * but with certain options, more fields are used.
+ */
+STRUCT_SPECIAL(ethtool_rxnfc_get_set_rxfh)
+
+STRUCT(ethtool_flash,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* region */
+       MK_ARRAY(TYPE_CHAR, 128)) /* data[ETHTOOL_FLASH_MAX_FILENAME] */
+
+STRUCT_SPECIAL(ethtool_sset_info)
+
+STRUCT(ethtool_rxfh_indir,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* size */
+       MK_FLEXIBLE_ARRAY(TYPE_INT, 1)) /* ring_index[0]: size */
+
+STRUCT_SPECIAL(ethtool_rxfh)
+
+STRUCT(ethtool_get_features_block,
+       TYPE_INT, /* available */
+       TYPE_INT, /* requested */
+       TYPE_INT, /* active */
+       TYPE_INT) /* never_changed */
+
+STRUCT(ethtool_gfeatures,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* size */
+       MK_FLEXIBLE_ARRAY(MK_STRUCT(STRUCT_ethtool_get_features_block), 1))
+       /* features[0]: size */
+
+STRUCT(ethtool_set_features_block,
+       TYPE_INT, /* valid */
+       TYPE_INT) /* requested */
+
+STRUCT(ethtool_sfeatures,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* size */
+       MK_FLEXIBLE_ARRAY(MK_STRUCT(STRUCT_ethtool_set_features_block), 1))
+       /* features[0]: size */
+
+STRUCT(ethtool_channels,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* max_rx */
+       TYPE_INT, /* max_tx */
+       TYPE_INT, /* max_other */
+       TYPE_INT, /* max_combined */
+       TYPE_INT, /* rx_count */
+       TYPE_INT, /* tx_count */
+       TYPE_INT, /* other_count */
+       TYPE_INT) /* combined_count */
+
+/* For ETHTOOL_SET_DUMP and ETHTOOL_GET_DUMP_FLAG, the flexible array `data` is
+ * not used.
+ */
+STRUCT(ethtool_dump_no_data,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* version */
+       TYPE_INT, /* flag */
+       TYPE_INT) /* len */
+
+STRUCT(ethtool_dump,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* version */
+       TYPE_INT, /* flag */
+       TYPE_INT, /* len */
+       MK_FLEXIBLE_ARRAY(TYPE_CHAR, 3)) /* data[0]: len */
+
+STRUCT(ethtool_ts_info,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* so_timestamping */
+       TYPE_INT, /* phc_index */
+       TYPE_INT, /* tx_types */
+       MK_ARRAY(TYPE_INT, 3), /* tx_reserved */
+       TYPE_INT, /* rx_filters */
+       MK_ARRAY(TYPE_INT, 3)) /* rx_reserved */
+
+STRUCT(ethtool_modinfo,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* type */
+       TYPE_INT, /* eeprom_len */
+       MK_ARRAY(TYPE_INT, 8)) /* reserved */
+
+STRUCT(ethtool_tunable,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* id */
+       TYPE_INT, /* type_id */
+       TYPE_INT, /* len */
+       MK_FLEXIBLE_ARRAY(TYPE_PTRVOID, 3)) /* data[0]: len */
+
+STRUCT_SPECIAL(ethtool_link_settings)
+
+STRUCT(ethtool_fecparam,
+       TYPE_INT, /* cmd */
+       TYPE_INT, /* active_fec */
+       TYPE_INT, /* fec */
+       TYPE_INT) /* reserved */
+
+STRUCT_SPECIAL(ethtool_per_queue_op)
diff --git a/tests/tcg/multiarch/ethtool.c b/tests/tcg/multiarch/ethtool.c
new file mode 100644
index 0000000000..54b2337aa7
--- /dev/null
+++ b/tests/tcg/multiarch/ethtool.c
@@ -0,0 +1,417 @@
+#include <asm-generic/errno.h>
+#include <assert.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/ethtool.h>
+#include <linux/if.h>
+#include <linux/sockios.h>
+#include <netinet/in.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+
+const int number_of_entries_to_print = 10;
+const uint32_t protected_memory_pattern[] = {
+      0xdeadc0de, 0xb0bb1e, 0xfacade, 0xfeeb1e };
+
+static void fail_with(const char *action, const char *cmd_name, int cmd, int err) {
+    if (errno == EOPNOTSUPP) {
+        printf("Unsupported operation: %s; errno = %d: %s.\n"
+               "TEST SKIPPED (%s = 0x%x).\n",
+               action, err, strerror(err), cmd_name, cmd);
+        return;
+    }
+    if (err) {
+        fprintf(stderr,
+                "Failed to %s (%s = 0x%x): errno = %d: %s\n",
+                action, cmd_name, cmd, err, strerror(err));
+    } else {
+        fprintf(stderr,
+                "Failed to %s (%s = 0x%x): no errno\n",
+                action, cmd_name, cmd);
+    }
+    exit(err);
+}
+#define FAIL(action,cmd) fail_with(action, #cmd, cmd, errno)
+
+/* `calloc_protected` and `protected_memory_changed` can be used to verify that
+ * a system call does not write pass intended memory boundary.
+ *
+ * `ptr = calloc_protected(n)` will allocate extra memory after `n` bytes and
+ * populate it with a memory pattern. The first `n` bytes are still guaranteed
+ * to be zeroed out like `calloc(1, n)`. `protected_memory_changed(ptr, n)`
+ * takes the pointer and the original size `n` and checks that the memory
+ * pattern is intact.
+ */
+uint8_t *calloc_protected(size_t struct_size)
+{
+    uint8_t *buf = (uint8_t *) calloc(
+        1,
+        struct_size + sizeof(protected_memory_pattern));
+    memcpy(buf + struct_size, protected_memory_pattern,
+           sizeof(protected_memory_pattern));
+    return buf;
+}
+
+bool protected_memory_changed(const uint8_t *ptr, size_t struct_size)
+{
+    return memcmp(ptr + struct_size, protected_memory_pattern,
+                  sizeof(protected_memory_pattern)) != 0;
+}
+
+void print_entries(const char *fmt, int len, uint32_t *entries)
+{
+    int i;
+    for (i = 0; i < len && i < number_of_entries_to_print; ++i) {
+        printf(fmt, entries[i]);
+    }
+    if (len > number_of_entries_to_print) {
+        printf(" (%d more omitted)", len - number_of_entries_to_print);
+    }
+}
+
+void basic_test(int socketfd, struct ifreq ifr)
+{
+   struct ethtool_drvinfo drvinfo;
+   drvinfo.cmd = ETHTOOL_GDRVINFO;
+   ifr.ifr_data = (void *)&drvinfo;
+   if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+       FAIL("get driver info", ETHTOOL_GDRVINFO);
+       return;
+   }
+   printf("Driver: %s (version %s)\n", drvinfo.driver, drvinfo.version);
+}
+
+/* Test flexible array. */
+void test_get_stats(int socketfd, struct ifreq ifr, int n_stats)
+{
+    int i;
+    struct ethtool_stats *stats = (struct ethtool_stats *)calloc(
+        1, sizeof(*stats) + sizeof(stats->data[0]) * n_stats);
+    stats->cmd = ETHTOOL_GSTATS;
+    stats->n_stats = n_stats;
+    ifr.ifr_data = (void *)stats;
+    if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+        FAIL("get statastics", ETHTOOL_GSTATS);
+        free(stats);
+        return;
+    }
+    if (stats->n_stats != n_stats) {
+        FAIL("get consistent number of statistics", ETHTOOL_GSTATS);
+    }
+    for (i = 0; i < stats->n_stats && i < number_of_entries_to_print; ++i) {
+        printf("stats[%d] = %llu\n", i, (unsigned long long)stats->data[i]);
+    }
+    if (stats->n_stats > number_of_entries_to_print) {
+        printf("(%d more omitted)\n",
+               stats->n_stats - number_of_entries_to_print);
+    }
+    free(stats);
+}
+
+/* Test flexible array with char array as elements. */
+void test_get_strings(int socketfd, struct ifreq ifr, int n_stats)
+{
+    int i;
+    struct ethtool_gstrings *gstrings =
+        (struct ethtool_gstrings *)calloc(
+            1, sizeof(*gstrings) + ETH_GSTRING_LEN * n_stats);
+    gstrings->cmd = ETHTOOL_GSTRINGS;
+    gstrings->string_set = ETH_SS_STATS;
+    gstrings->len = n_stats;
+    ifr.ifr_data = (void *)gstrings;
+    if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+        FAIL("get string set", ETHTOOL_GSTRINGS);
+        free(gstrings);
+        return;
+    }
+    if (gstrings->len != n_stats) {
+        FAIL("get consistent number of statistics", ETHTOOL_GSTRINGS);
+    }
+    for (i = 0; i < gstrings->len && i < number_of_entries_to_print; ++i) {
+        printf("stat_names[%d] = %.*s\n",
+               i, ETH_GSTRING_LEN, gstrings->data + i * ETH_GSTRING_LEN);
+    }
+    if (gstrings->len > number_of_entries_to_print) {
+        printf("(%d more omitted)\n",
+               gstrings->len - number_of_entries_to_print);
+    }
+    free(gstrings);
+}
+
+/* Testing manual implementation of converting `struct ethtool_sset_info`, also
+ * info for subsequent tests.
+ */
+int test_get_sset_info(int socketfd, struct ifreq ifr)
+{
+    const int n_sset = 2;
+    int n_stats;
+    struct ethtool_sset_info *sset_info =
+        (struct ethtool_sset_info *)calloc(
+            1, sizeof(*sset_info) + sizeof(sset_info->data[0]) * n_sset);
+    sset_info->cmd = ETHTOOL_GSSET_INFO;
+    sset_info->sset_mask = 1 << ETH_SS_TEST | 1 << ETH_SS_STATS;
+    assert(__builtin_popcount(sset_info->sset_mask) == n_sset);
+    ifr.ifr_data = (void *)sset_info;
+    if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+        fail_with("get string set info", "ETHTOOL_GSSET_INFO",
+                  ETHTOOL_GSSET_INFO, errno);
+        free(sset_info);
+        return 0;
+    }
+    if ((sset_info->sset_mask & (1 << ETH_SS_STATS)) == 0) {
+        puts("No stats string set info, SKIPPING dependent tests");
+        free(sset_info);
+        return 0;
+    }
+    n_stats = (sset_info->sset_mask & (1 << ETH_SS_TEST)) ?
+        sset_info->data[1] :
+        sset_info->data[0];
+    printf("n_stats = %d\n", n_stats);
+    free(sset_info);
+    return n_stats;
+}
+
+/* Test manual implementation of converting `struct ethtool_rxnfc`, focusing on
+ * the case where only the first three fields are present. (The original struct
+ * definition.)
+ */
+void test_get_rxfh(int socketfd, struct ifreq ifr)
+{
+    struct ethtool_rxnfc *rxnfc;
+    const int rxnfc_first_three_field_size =
+        sizeof(rxnfc->cmd) + sizeof(rxnfc->flow_type) + sizeof(rxnfc->data);
+    rxnfc = (struct ethtool_rxnfc *)calloc_protected(
+        rxnfc_first_three_field_size);
+    rxnfc->cmd = ETHTOOL_GRXFH;
+    rxnfc->flow_type = TCP_V4_FLOW;
+    ifr.ifr_data = (void *)rxnfc;
+    if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+        FAIL("get RX flow classification rules", ETHTOOL_GRXFH);
+        free(rxnfc);
+        return;
+    }
+    if (protected_memory_changed((const uint8_t *)rxnfc,
+                                 rxnfc_first_three_field_size)) {
+        FAIL("preserve memory after the first three fields", ETHTOOL_GRXFH);
+    }
+    printf("Flow hash bitmask (flow_type = TCP v4): 0x%llx\n",
+           (unsigned long long)rxnfc->data);
+    free(rxnfc);
+}
+
+/* Test manual implementation of converting `struct ethtool_link_settings`. */
+void test_get_link_settings(int socketfd, struct ifreq ifr)
+{
+    int link_mode_masks_nwords;
+    struct ethtool_link_settings *link_settings_header =
+        (struct ethtool_link_settings *) calloc_protected(
+            sizeof(*link_settings_header));
+    link_settings_header->cmd = ETHTOOL_GLINKSETTINGS;
+    link_settings_header->link_mode_masks_nwords = 0;
+    ifr.ifr_data = (void*)link_settings_header;
+    if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+        FAIL("get link settings mask sizes", ETHTOOL_GLINKSETTINGS);
+        free(link_settings_header);
+        return;
+    }
+    if (protected_memory_changed((const uint8_t *)link_settings_header,
+                                 sizeof(*link_settings_header))) {
+        FAIL("preserve link_mode_masks", ETHTOOL_GLINKSETTINGS);
+    }
+    if (link_settings_header->link_mode_masks_nwords >= 0) {
+        FAIL("complete handshake", ETHTOOL_GLINKSETTINGS);
+    }
+    link_mode_masks_nwords = -link_settings_header->link_mode_masks_nwords;
+
+    struct ethtool_link_settings *link_settings =
+        (struct ethtool_link_settings *)calloc(
+            1,
+            sizeof(*link_settings) +
+            sizeof(link_settings_header->link_mode_masks[0]) *
+            link_mode_masks_nwords * 3);
+    link_settings->cmd = ETHTOOL_GLINKSETTINGS;
+    link_settings->link_mode_masks_nwords = link_mode_masks_nwords;
+    ifr.ifr_data = (void *)link_settings;
+    if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+        FAIL("get link settings", ETHTOOL_GLINKSETTINGS);
+        free(link_settings_header);
+        free(link_settings);
+        return;
+    }
+    if (link_settings->link_mode_masks_nwords != link_mode_masks_nwords) {
+        FAIL("have consistent number of mode masks", ETHTOOL_GLINKSETTINGS);
+    }
+
+    printf("Link speed: %d MB\n", link_settings->speed);
+    printf("Number of link mode masks: %d\n",
+           link_settings->link_mode_masks_nwords);
+    if (link_settings->link_mode_masks_nwords > 0) {
+        printf("Supported bitmap:");
+        print_entries(" 0x%08x",
+                      link_settings->link_mode_masks_nwords,
+                      link_settings->link_mode_masks);
+        putchar('\n');
+
+        printf("Advertising bitmap:");
+        print_entries(" 0x%08x",
+                      link_settings->link_mode_masks_nwords,
+                      link_settings->link_mode_masks +
+                      link_settings->link_mode_masks_nwords);
+        putchar('\n');
+
+        printf("Lp advertising bitmap:");
+        print_entries(" 0x%08x",
+                      link_settings->link_mode_masks_nwords,
+                      link_settings->link_mode_masks +
+                      2 * link_settings->link_mode_masks_nwords);
+        putchar('\n');
+    }
+
+    free(link_settings_header);
+    free(link_settings);
+}
+
+/* Test manual implementation of converting `struct ethtool_per_queue_op`. */
+void test_perqueue(int socketfd, struct ifreq ifr)
+{
+    const int n_queue = 2;
+    int i;
+    struct ethtool_per_queue_op *per_queue_op =
+        (struct ethtool_per_queue_op *)calloc(
+            1,
+            sizeof(*per_queue_op) + sizeof(struct ethtool_coalesce) * n_queue);
+    per_queue_op->cmd = ETHTOOL_PERQUEUE;
+    per_queue_op->sub_command = ETHTOOL_GCOALESCE;
+    per_queue_op->queue_mask[0] = 0x3;
+    ifr.ifr_data = (void *)per_queue_op;
+    if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+      FAIL("get coalesce per queue", ETHTOOL_PERQUEUE);
+      free(per_queue_op);
+      return;
+    }
+    for (i = 0; i < n_queue; ++i) {
+        struct ethtool_coalesce *coalesce = (struct ethtool_coalesce *)(
+            per_queue_op->data + sizeof(*coalesce) * i);
+        if (coalesce->cmd != ETHTOOL_GCOALESCE) {
+            fprintf(stderr,
+                    "ETHTOOL_PERQUEUE (%d) sub_command ETHTOOL_GCOALESCE (%d) "
+                    "fails to set entry %d's cmd to ETHTOOL_GCOALESCE, got %d "
+                    "instead\n",
+                    ETHTOOL_PERQUEUE, ETHTOOL_GCOALESCE, i,
+                    coalesce->cmd);
+            exit(-1);
+        }
+        printf("rx_coalesce_usecs[%d] = %u\nrx_max_coalesced_frames[%d] = %u\n",
+               i, coalesce->rx_coalesce_usecs,
+               i, coalesce->rx_max_coalesced_frames);
+    }
+
+    free(per_queue_op);
+}
+
+/* Test manual implementation of ETHTOOL_GRSSH. */
+void test_get_rssh(int socketfd, struct ifreq ifr)
+{
+    int i;
+    struct ethtool_rxfh *rxfh_header =
+        (struct ethtool_rxfh *)calloc_protected(sizeof(*rxfh_header));
+    rxfh_header->cmd = ETHTOOL_GRSSH;
+    ifr.ifr_data = (void *)rxfh_header;
+    if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+        FAIL("get RX flow hash indir and hash key size", ETHTOOL_GRSSH);
+        free(rxfh_header);
+        return;
+    }
+    if (protected_memory_changed((const uint8_t *)rxfh_header,
+                                 sizeof(*rxfh_header))) {
+        FAIL("preserve rss_config", ETHTOOL_GRSSH);
+    }
+    printf("RX flow hash indir size = %d\nRX flow hash key size = %d\n",
+           rxfh_header->indir_size, rxfh_header->key_size);
+
+    struct ethtool_rxfh *rxfh = (struct ethtool_rxfh *)calloc(
+        1,
+        sizeof(*rxfh) + 4 * rxfh_header->indir_size + rxfh_header->key_size);
+    *rxfh = *rxfh_header;
+    ifr.ifr_data = (void*)rxfh;
+    if (ioctl(socketfd, SIOCETHTOOL, &ifr) == -1) {
+        FAIL("get RX flow hash indir and hash key", ETHTOOL_GRSSH);
+        free(rxfh_header);
+        free(rxfh);
+        return;
+    }
+
+    if (rxfh->indir_size == 0) {
+        printf("No RX flow hash indir\n");
+    } else {
+        printf("RX flow hash indir:");
+        print_entries(" 0x%08x", rxfh->indir_size, rxfh->rss_config);
+        putchar('\n');
+    }
+
+    if (rxfh->key_size == 0) {
+        printf("No RX flow hash key\n");
+    } else {
+        char *key = (char *)(rxfh->rss_config + rxfh->indir_size);
+        printf("RX flow hash key:");
+        for (i = 0;  i < rxfh->key_size; ++i) {
+            if (i % 2 == 0)
+                putchar(' ');
+            printf("%02hhx", key[i]);
+        }
+        putchar('\n');
+    }
+    free(rxfh_header);
+    free(rxfh);
+}
+
+int main(int argc, char **argv)
+{
+    int socketfd, n_stats, i;
+    struct ifreq ifr;
+
+    socketfd = socket(AF_INET, SOCK_DGRAM, 0);
+    if (socketfd == -1) {
+        int err = errno;
+        fprintf(stderr,
+                "Failed to open socket: errno = %d: %s\n",
+                err, strerror(err));
+        return err;
+    }
+
+    for (i = 1;; ++i) {
+        ifr.ifr_ifindex = i;
+        if (ioctl(socketfd, SIOCGIFNAME, &ifr) == -1) {
+            puts("Could not find a non-loopback interface, SKIPPING");
+            return 0;
+        }
+        if (strncmp(ifr.ifr_name, "lo", IFNAMSIZ) != 0) {
+            break;
+        }
+    }
+    printf("Interface index: %d\nInterface name: %.*s\n",
+           ifr.ifr_ifindex, IFNAMSIZ, ifr.ifr_name);
+
+    basic_test(socketfd, ifr);
+
+    n_stats = test_get_sset_info(socketfd, ifr);
+    if (n_stats > 0) {
+        /* Testing lexible arrays. */
+        test_get_stats(socketfd, ifr, n_stats);
+        test_get_strings(socketfd, ifr, n_stats);
+    }
+
+    /* Testing manual implementations of structure convertions. */
+    test_get_rxfh(socketfd, ifr);
+    test_get_link_settings(socketfd, ifr);
+    test_perqueue(socketfd, ifr);
+
+    /* Testing manual implementations of operations. */
+    test_get_rssh(socketfd, ifr);
+
+    return 0;
+}
-- 
2.28.0.rc0.105.gf9edc3c819-goog


