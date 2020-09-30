Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B18C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A95D2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPRAu8XP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A95D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfLj-0000Pd-Tl
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJV-0006Yy-Qd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJS-0007CA-Cl
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IH1Y+lGzySf//AXyG6WjJKYyISNsRIiloaORu9fBW48=;
 b=YPRAu8XPDaTaCgLXKfp9iHr8Aptj2hUx6OBMLX2Enn1kaTTYg5oymMACv3ZBrEhpRPy9/J
 +9nTeT4+jrmI4Ef3HVvkuOqDBTEageV21cMxXkYiXXw5bFYf1B8trx8q7cQogAgwHVtpNH
 10E6VydnmyQJtRHiyoeHUUIDw44h6tQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-1Ol-nidxMUW2VBmyf64j0w-1; Wed, 30 Sep 2020 12:50:37 -0400
X-MC-Unique: 1Ol-nidxMUW2VBmyf64j0w-1
Received: by mail-wr1-f69.google.com with SMTP id w7so836983wrp.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IH1Y+lGzySf//AXyG6WjJKYyISNsRIiloaORu9fBW48=;
 b=DNfuvOkBhCAtLmD0PlWuSHO2dO2VDrZYUOpsAgR97riPr0iiajbhjXz4sJeiwk7xnf
 JtfTc6F/ocSa/K6UAkMnXVbf0fKqTSXGSF26q7+A6KiCVR9aaTW3ok6qB7O8UrXt1OYM
 6fTccfZOlFqp0qiL6Qtr/kMJ+v+r6eQGqs0sVUb84zSn959uc8BVsuWl3d8Fzw2ACzKF
 zW09Kn5N9XydW8bZUt5fijGgUTcCfOSzDTrt/T7FumxlgT19N0/ON15sDwY2nvFhr5wa
 ixTvBKPCGWnOXGRfr3DYuNf7jvJtlZh0wrI9Ml9qapS3bnwEQPuV/G/fH7mpdczoWHXy
 yS9Q==
X-Gm-Message-State: AOAM531sXpH/7NOPvDyJqPtm0haLrvu+lN206d7TmlAwMBjrW38RQwBP
 AB6fLUtij/vKHkQxoSsqUqwdII0rIsEysKYTcRvJ2n2Kqc0eFqfQP5YxbXAbkVizXfUNQdZt7gQ
 sPQSY+QzoreRCseE=
X-Received: by 2002:a1c:a515:: with SMTP id o21mr2686586wme.75.1601484635337; 
 Wed, 30 Sep 2020 09:50:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznTQ5tHY2LEURDng7l6x7ZBFNfIGeJ8HNoR9+adXwfX93CkjMyujmOmaLMzwV/x4X/ZMYvDw==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr2686535wme.75.1601484634815; 
 Wed, 30 Sep 2020 09:50:34 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z1sm3885958wmk.45.2020.09.30.09.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 08/11] hw/core/qdev-properties: Extract system-mode
 specific properties
Date: Wed, 30 Sep 2020 18:49:46 +0200
Message-Id: <20200930164949.1425294-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move properties specific to machines into a separate file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v3: Also move Reserved Region introduced in commit f78069253c
    ("qdev: Introduce DEFINE_PROP_RESERVED_REGION").
---
 hw/core/qdev-properties-system.c | 687 ++++++++++++++++++++++++++++++-
 hw/core/qdev-properties.c        | 674 ------------------------------
 2 files changed, 679 insertions(+), 682 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index b29daf4fb5..49bdd12581 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -11,19 +11,25 @@
  */
 
 #include "qemu/osdep.h"
-#include "audio/audio.h"
-#include "net/net.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qapi/qapi-types-block.h"
+#include "qapi/qapi-types-machine.h"
+#include "qapi/qapi-types-migration.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "qdev-prop-internal.h"
+
+#include "audio/audio.h"
+#include "chardev/char-fe.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-#include "hw/block/block.h"
-#include "net/hub.h"
-#include "qapi/visitor.h"
-#include "chardev/char-fe.h"
-#include "sysemu/iothread.h"
-#include "sysemu/tpm_backend.h"
+#include "net/net.h"
+#include "hw/pci/pci.h"
 
 static bool check_prop_still_unset(DeviceState *dev, const char *name,
                                    const void *old_val, const char *new_val,
@@ -280,6 +286,96 @@ const PropertyInfo qdev_prop_chr = {
     .release = release_chr,
 };
 
+/* --- mac address --- */
+
+/*
+ * accepted syntax versions:
+ *   01:02:03:04:05:06
+ *   01-02-03-04-05-06
+ */
+static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
+                    Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    MACAddr *mac = qdev_get_prop_ptr(dev, prop);
+    char buffer[2 * 6 + 5 + 1];
+    char *p = buffer;
+
+    snprintf(buffer, sizeof(buffer), "%02x:%02x:%02x:%02x:%02x:%02x",
+             mac->a[0], mac->a[1], mac->a[2],
+             mac->a[3], mac->a[4], mac->a[5]);
+
+    visit_type_str(v, name, &p, errp);
+}
+
+static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
+                    Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    MACAddr *mac = qdev_get_prop_ptr(dev, prop);
+    int i, pos;
+    char *str;
+    const char *p;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
+
+    for (i = 0, pos = 0; i < 6; i++, pos += 3) {
+        long val;
+
+        if (!qemu_isxdigit(str[pos])) {
+            goto inval;
+        }
+        if (!qemu_isxdigit(str[pos + 1])) {
+            goto inval;
+        }
+        if (i == 5) {
+            if (str[pos + 2] != '\0') {
+                goto inval;
+            }
+        } else {
+            if (str[pos + 2] != ':' && str[pos + 2] != '-') {
+                goto inval;
+            }
+        }
+        if (qemu_strtol(str + pos, &p, 16, &val) < 0 || val > 0xff) {
+            goto inval;
+        }
+        mac->a[i] = val;
+    }
+    g_free(str);
+    return;
+
+inval:
+    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    g_free(str);
+}
+
+const PropertyInfo qdev_prop_macaddr = {
+    .name  = "str",
+    .description = "Ethernet 6-byte MAC Address, example: 52:54:00:12:34:56",
+    .get   = get_mac,
+    .set   = set_mac,
+};
+
+void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
+                           const uint8_t *value)
+{
+    char str[2 * 6 + 5 + 1];
+    snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
+             value[0], value[1], value[2], value[3], value[4], value[5]);
+
+    object_property_set_str(OBJECT(dev), name, str, &error_abort);
+}
+
 /* --- netdev device --- */
 static void get_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
@@ -465,3 +561,578 @@ void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd)
     }
     nd->instantiated = 1;
 }
+
+/* --- lost tick policy --- */
+
+QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) != sizeof(int));
+
+const PropertyInfo qdev_prop_losttickpolicy = {
+    .name  = "LostTickPolicy",
+    .enum_table  = &LostTickPolicy_lookup,
+    .get   = qdev_propinfo_get_enum,
+    .set   = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
+/* --- blocksize --- */
+
+/* lower limit is sector size */
+#define MIN_BLOCK_SIZE          512
+#define MIN_BLOCK_SIZE_STR      "512 B"
+/*
+ * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
+ * matches qcow2 cluster size limit
+ */
+#define MAX_BLOCK_SIZE          (2 * MiB)
+#define MAX_BLOCK_SIZE_STR      "2 MiB"
+
+static void set_blocksize(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
+    uint64_t value;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    if (!visit_type_size(v, name, &value, errp)) {
+        return;
+    }
+    /* value of 0 means "unset" */
+    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
+        error_setg(errp,
+                   "Property %s.%s doesn't take value %" PRIu64
+                   " (minimum: " MIN_BLOCK_SIZE_STR
+                   ", maximum: " MAX_BLOCK_SIZE_STR ")",
+                   dev->id ? : "", name, value);
+        return;
+    }
+
+    /* We rely on power-of-2 blocksizes for bitmasks */
+    if ((value & (value - 1)) != 0) {
+        error_setg(errp,
+                  "Property %s.%s doesn't take value '%" PRId64 "', "
+                  "it's not a power of 2", dev->id ?: "", name, (int64_t)value);
+        return;
+    }
+
+    *ptr = value;
+}
+
+const PropertyInfo qdev_prop_blocksize = {
+    .name  = "size",
+    .description = "A power of two between " MIN_BLOCK_SIZE_STR
+                   " and " MAX_BLOCK_SIZE_STR,
+    .get   = qdev_propinfo_get_size32,
+    .set   = set_blocksize,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
+};
+
+/* --- Block device error handling policy --- */
+
+QEMU_BUILD_BUG_ON(sizeof(BlockdevOnError) != sizeof(int));
+
+const PropertyInfo qdev_prop_blockdev_on_error = {
+    .name = "BlockdevOnError",
+    .description = "Error handling policy, "
+                   "report/ignore/enospc/stop/auto",
+    .enum_table = &BlockdevOnError_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
+/* --- BIOS CHS translation */
+
+QEMU_BUILD_BUG_ON(sizeof(BiosAtaTranslation) != sizeof(int));
+
+const PropertyInfo qdev_prop_bios_chs_trans = {
+    .name = "BiosAtaTranslation",
+    .description = "Logical CHS translation algorithm, "
+                   "auto/none/lba/large/rechs",
+    .enum_table = &BiosAtaTranslation_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
+/* --- FDC default drive types */
+
+const PropertyInfo qdev_prop_fdc_drive_type = {
+    .name = "FdcDriveType",
+    .description = "FDC drive type, "
+                   "144/288/120/none/auto",
+    .enum_table = &FloppyDriveType_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
+/* --- MultiFDCompression --- */
+
+const PropertyInfo qdev_prop_multifd_compression = {
+    .name = "MultiFDCompression",
+    .description = "multifd_compression values, "
+                   "none/zlib/zstd",
+    .enum_table = &MultiFDCompression_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
+/* --- Reserved Region --- */
+
+/*
+ * Accepted syntax:
+ *   <low address>:<high address>:<type>
+ *   where low/high addresses are uint64_t in hexadecimal
+ *   and type is a non-negative decimal integer
+ */
+static void get_reserved_region(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
+    char buffer[64];
+    char *p = buffer;
+    int rc;
+
+    rc = snprintf(buffer, sizeof(buffer), "0x%"PRIx64":0x%"PRIx64":%u",
+                  rr->low, rr->high, rr->type);
+    assert(rc < sizeof(buffer));
+
+    visit_type_str(v, name, &p, errp);
+}
+
+static void set_reserved_region(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
+    Error *local_err = NULL;
+    const char *endptr;
+    char *str;
+    int ret;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    ret = qemu_strtou64(str, &endptr, 16, &rr->low);
+    if (ret) {
+        error_setg(errp, "start address of '%s'"
+                   " must be a hexadecimal integer", name);
+        goto out;
+    }
+    if (*endptr != ':') {
+        goto separator_error;
+    }
+
+    ret = qemu_strtou64(endptr + 1, &endptr, 16, &rr->high);
+    if (ret) {
+        error_setg(errp, "end address of '%s'"
+                   " must be a hexadecimal integer", name);
+        goto out;
+    }
+    if (*endptr != ':') {
+        goto separator_error;
+    }
+
+    ret = qemu_strtoui(endptr + 1, &endptr, 10, &rr->type);
+    if (ret) {
+        error_setg(errp, "type of '%s'"
+                   " must be a non-negative decimal integer", name);
+    }
+    goto out;
+
+separator_error:
+    error_setg(errp, "reserved region fields must be separated with ':'");
+out:
+    g_free(str);
+    return;
+}
+
+const PropertyInfo qdev_prop_reserved_region = {
+    .name  = "reserved_region",
+    .description = "Reserved Region, example: 0xFEE00000:0xFEEFFFFF:0",
+    .get   = get_reserved_region,
+    .set   = set_reserved_region,
+};
+
+/* --- pci address --- */
+
+/*
+ * bus-local address, i.e. "$slot" or "$slot.$fn"
+ */
+static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    int32_t value, *ptr = qdev_get_prop_ptr(dev, prop);
+    unsigned int slot, fn, n;
+    char *str;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    if (!visit_type_str(v, name, &str, NULL)) {
+        if (!visit_type_int32(v, name, &value, errp)) {
+            return;
+        }
+        if (value < -1 || value > 255) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                       name ? name : "null", "pci_devfn");
+            return;
+        }
+        *ptr = value;
+        return;
+    }
+
+    if (sscanf(str, "%x.%x%n", &slot, &fn, &n) != 2) {
+        fn = 0;
+        if (sscanf(str, "%x%n", &slot, &n) != 1) {
+            goto invalid;
+        }
+    }
+    if (str[n] != '\0' || fn > 7 || slot > 31) {
+        goto invalid;
+    }
+    *ptr = slot << 3 | fn;
+    g_free(str);
+    return;
+
+invalid:
+    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    g_free(str);
+}
+
+static int print_pci_devfn(DeviceState *dev, Property *prop, char *dest,
+                           size_t len)
+{
+    int32_t *ptr = qdev_get_prop_ptr(dev, prop);
+
+    if (*ptr == -1) {
+        return snprintf(dest, len, "<unset>");
+    } else {
+        return snprintf(dest, len, "%02x.%x", *ptr >> 3, *ptr & 7);
+    }
+}
+
+const PropertyInfo qdev_prop_pci_devfn = {
+    .name  = "int32",
+    .description = "Slot and optional function number, example: 06.0 or 06",
+    .print = print_pci_devfn,
+    .get   = qdev_propinfo_get_int32,
+    .set   = set_pci_devfn,
+    .set_default_value = qdev_propinfo_set_default_value_int,
+};
+
+/* --- pci host address --- */
+
+static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
+    char buffer[] = "ffff:ff:ff.f";
+    char *p = buffer;
+    int rc = 0;
+
+    /*
+     * Catch "invalid" device reference from vfio-pci and allow the
+     * default buffer representing the non-existent device to be used.
+     */
+    if (~addr->domain || ~addr->bus || ~addr->slot || ~addr->function) {
+        rc = snprintf(buffer, sizeof(buffer), "%04x:%02x:%02x.%0d",
+                      addr->domain, addr->bus, addr->slot, addr->function);
+        assert(rc == sizeof(buffer) - 1);
+    }
+
+    visit_type_str(v, name, &p, errp);
+}
+
+/*
+ * Parse [<domain>:]<bus>:<slot>.<func>
+ *   if <domain> is not supplied, it's assumed to be 0.
+ */
+static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
+    char *str, *p;
+    const char *e;
+    unsigned long val;
+    unsigned long dom = 0, bus = 0;
+    unsigned int slot = 0, func = 0;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    if (!visit_type_str(v, name, &str, errp)) {
+        return;
+    }
+
+    p = str;
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e == p) {
+        goto inval;
+    }
+    if (*e != ':') {
+        goto inval;
+    }
+    bus = val;
+
+    p = (char *)e + 1;
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
+        goto inval;
+    }
+    if (*e == ':') {
+        dom = bus;
+        bus = val;
+        p = (char *)e + 1;
+        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
+            goto inval;
+        }
+    }
+    slot = val;
+
+    if (*e != '.') {
+        goto inval;
+    }
+    p = (char *)e + 1;
+    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e == p) {
+        goto inval;
+    }
+    func = val;
+
+    if (bus > 0xff) {
+        goto inval;
+    }
+
+    if (*e) {
+        goto inval;
+    }
+
+    addr->domain = dom;
+    addr->bus = bus;
+    addr->slot = slot;
+    addr->function = func;
+
+    g_free(str);
+    return;
+
+inval:
+    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
+    g_free(str);
+}
+
+const PropertyInfo qdev_prop_pci_host_devaddr = {
+    .name = "str",
+    .description = "Address (bus/device/function) of "
+                   "the host device, example: 04:10.0",
+    .get = get_pci_host_devaddr,
+    .set = set_pci_host_devaddr,
+};
+
+/* --- OffAutoPCIBAR off/auto/bar0/bar1/bar2/bar3/bar4/bar5 --- */
+
+const PropertyInfo qdev_prop_off_auto_pcibar = {
+    .name = "OffAutoPCIBAR",
+    .description = "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
+    .enum_table = &OffAutoPCIBAR_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
+/* --- PCIELinkSpeed 2_5/5/8/16 -- */
+
+static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
+    int speed;
+
+    switch (*p) {
+    case QEMU_PCI_EXP_LNK_2_5GT:
+        speed = PCIE_LINK_SPEED_2_5;
+        break;
+    case QEMU_PCI_EXP_LNK_5GT:
+        speed = PCIE_LINK_SPEED_5;
+        break;
+    case QEMU_PCI_EXP_LNK_8GT:
+        speed = PCIE_LINK_SPEED_8;
+        break;
+    case QEMU_PCI_EXP_LNK_16GT:
+        speed = PCIE_LINK_SPEED_16;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+
+    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
+    int speed;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    if (!visit_type_enum(v, prop->name, &speed, prop->info->enum_table,
+                         errp)) {
+        return;
+    }
+
+    switch (speed) {
+    case PCIE_LINK_SPEED_2_5:
+        *p = QEMU_PCI_EXP_LNK_2_5GT;
+        break;
+    case PCIE_LINK_SPEED_5:
+        *p = QEMU_PCI_EXP_LNK_5GT;
+        break;
+    case PCIE_LINK_SPEED_8:
+        *p = QEMU_PCI_EXP_LNK_8GT;
+        break;
+    case PCIE_LINK_SPEED_16:
+        *p = QEMU_PCI_EXP_LNK_16GT;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+}
+
+const PropertyInfo qdev_prop_pcie_link_speed = {
+    .name = "PCIELinkSpeed",
+    .description = "2_5/5/8/16",
+    .enum_table = &PCIELinkSpeed_lookup,
+    .get = get_prop_pcielinkspeed,
+    .set = set_prop_pcielinkspeed,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
+/* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
+
+static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
+    int width;
+
+    switch (*p) {
+    case QEMU_PCI_EXP_LNK_X1:
+        width = PCIE_LINK_WIDTH_1;
+        break;
+    case QEMU_PCI_EXP_LNK_X2:
+        width = PCIE_LINK_WIDTH_2;
+        break;
+    case QEMU_PCI_EXP_LNK_X4:
+        width = PCIE_LINK_WIDTH_4;
+        break;
+    case QEMU_PCI_EXP_LNK_X8:
+        width = PCIE_LINK_WIDTH_8;
+        break;
+    case QEMU_PCI_EXP_LNK_X12:
+        width = PCIE_LINK_WIDTH_12;
+        break;
+    case QEMU_PCI_EXP_LNK_X16:
+        width = PCIE_LINK_WIDTH_16;
+        break;
+    case QEMU_PCI_EXP_LNK_X32:
+        width = PCIE_LINK_WIDTH_32;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+
+    visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
+    int width;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    if (!visit_type_enum(v, prop->name, &width, prop->info->enum_table,
+                         errp)) {
+        return;
+    }
+
+    switch (width) {
+    case PCIE_LINK_WIDTH_1:
+        *p = QEMU_PCI_EXP_LNK_X1;
+        break;
+    case PCIE_LINK_WIDTH_2:
+        *p = QEMU_PCI_EXP_LNK_X2;
+        break;
+    case PCIE_LINK_WIDTH_4:
+        *p = QEMU_PCI_EXP_LNK_X4;
+        break;
+    case PCIE_LINK_WIDTH_8:
+        *p = QEMU_PCI_EXP_LNK_X8;
+        break;
+    case PCIE_LINK_WIDTH_12:
+        *p = QEMU_PCI_EXP_LNK_X12;
+        break;
+    case PCIE_LINK_WIDTH_16:
+        *p = QEMU_PCI_EXP_LNK_X16;
+        break;
+    case PCIE_LINK_WIDTH_32:
+        *p = QEMU_PCI_EXP_LNK_X32;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+}
+
+const PropertyInfo qdev_prop_pcie_link_width = {
+    .name = "PCIELinkWidth",
+    .description = "1/2/4/8/12/16/32",
+    .enum_table = &PCIELinkWidth_lookup,
+    .get = get_prop_pcielinkwidth,
+    .set = set_prop_pcielinkwidth,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 37e309077a..509cbf155d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1,20 +1,11 @@
 #include "qemu/osdep.h"
-#include "qemu/cutils.h"
-#include "net/net.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "hw/pci/pci.h"
-#include "qapi/qapi-types-block.h"
-#include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
-#include "qapi/qapi-types-migration.h"
-#include "hw/block/block.h"
-#include "net/hub.h"
 #include "qapi/visitor.h"
-#include "chardev/char.h"
 #include "qemu/uuid.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
@@ -506,174 +497,6 @@ const PropertyInfo qdev_prop_string = {
     .set   = set_string,
 };
 
-/* --- mac address --- */
-
-/*
- * accepted syntax versions:
- *   01:02:03:04:05:06
- *   01-02-03-04-05-06
- */
-static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
-                    Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    MACAddr *mac = qdev_get_prop_ptr(dev, prop);
-    char buffer[2 * 6 + 5 + 1];
-    char *p = buffer;
-
-    snprintf(buffer, sizeof(buffer), "%02x:%02x:%02x:%02x:%02x:%02x",
-             mac->a[0], mac->a[1], mac->a[2],
-             mac->a[3], mac->a[4], mac->a[5]);
-
-    visit_type_str(v, name, &p, errp);
-}
-
-static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
-                    Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    MACAddr *mac = qdev_get_prop_ptr(dev, prop);
-    int i, pos;
-    char *str;
-    const char *p;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    if (!visit_type_str(v, name, &str, errp)) {
-        return;
-    }
-
-    for (i = 0, pos = 0; i < 6; i++, pos += 3) {
-        long val;
-
-        if (!qemu_isxdigit(str[pos])) {
-            goto inval;
-        }
-        if (!qemu_isxdigit(str[pos + 1])) {
-            goto inval;
-        }
-        if (i == 5) {
-            if (str[pos + 2] != '\0') {
-                goto inval;
-            }
-        } else {
-            if (str[pos + 2] != ':' && str[pos + 2] != '-') {
-                goto inval;
-            }
-        }
-        if (qemu_strtol(str + pos, &p, 16, &val) < 0 || val > 0xff) {
-            goto inval;
-        }
-        mac->a[i] = val;
-    }
-    g_free(str);
-    return;
-
-inval:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
-    g_free(str);
-}
-
-const PropertyInfo qdev_prop_macaddr = {
-    .name  = "str",
-    .description = "Ethernet 6-byte MAC Address, example: 52:54:00:12:34:56",
-    .get   = get_mac,
-    .set   = set_mac,
-};
-
-/* --- Reserved Region --- */
-
-/*
- * Accepted syntax:
- *   <low address>:<high address>:<type>
- *   where low/high addresses are uint64_t in hexadecimal
- *   and type is a non-negative decimal integer
- */
-static void get_reserved_region(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
-    char buffer[64];
-    char *p = buffer;
-    int rc;
-
-    rc = snprintf(buffer, sizeof(buffer), "0x%"PRIx64":0x%"PRIx64":%u",
-                  rr->low, rr->high, rr->type);
-    assert(rc < sizeof(buffer));
-
-    visit_type_str(v, name, &p, errp);
-}
-
-static void set_reserved_region(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
-    const char *endptr;
-    char *str;
-    int ret;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    ret = qemu_strtou64(str, &endptr, 16, &rr->low);
-    if (ret) {
-        error_setg(errp, "start address of '%s'"
-                   " must be a hexadecimal integer", name);
-        goto out;
-    }
-    if (*endptr != ':') {
-        goto separator_error;
-    }
-
-    ret = qemu_strtou64(endptr + 1, &endptr, 16, &rr->high);
-    if (ret) {
-        error_setg(errp, "end address of '%s'"
-                   " must be a hexadecimal integer", name);
-        goto out;
-    }
-    if (*endptr != ':') {
-        goto separator_error;
-    }
-
-    ret = qemu_strtoui(endptr + 1, &endptr, 10, &rr->type);
-    if (ret) {
-        error_setg(errp, "type of '%s'"
-                   " must be a non-negative decimal integer", name);
-    }
-    goto out;
-
-separator_error:
-    error_setg(errp, "reserved region fields must be separated with ':'");
-out:
-    g_free(str);
-    return;
-}
-
-const PropertyInfo qdev_prop_reserved_region = {
-    .name  = "reserved_region",
-    .description = "Reserved Region, example: 0xFEE00000:0xFEEFFFFF:0",
-    .get   = get_reserved_region,
-    .set   = set_reserved_region,
-};
-
 /* --- on/off/auto --- */
 
 const PropertyInfo qdev_prop_on_off_auto = {
@@ -685,141 +508,6 @@ const PropertyInfo qdev_prop_on_off_auto = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
-/* --- lost tick policy --- */
-
-QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) != sizeof(int));
-
-const PropertyInfo qdev_prop_losttickpolicy = {
-    .name  = "LostTickPolicy",
-    .enum_table  = &LostTickPolicy_lookup,
-    .get   = qdev_propinfo_get_enum,
-    .set   = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
-};
-
-/* --- Block device error handling policy --- */
-
-QEMU_BUILD_BUG_ON(sizeof(BlockdevOnError) != sizeof(int));
-
-const PropertyInfo qdev_prop_blockdev_on_error = {
-    .name = "BlockdevOnError",
-    .description = "Error handling policy, "
-                   "report/ignore/enospc/stop/auto",
-    .enum_table = &BlockdevOnError_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
-};
-
-/* --- BIOS CHS translation */
-
-QEMU_BUILD_BUG_ON(sizeof(BiosAtaTranslation) != sizeof(int));
-
-const PropertyInfo qdev_prop_bios_chs_trans = {
-    .name = "BiosAtaTranslation",
-    .description = "Logical CHS translation algorithm, "
-                   "auto/none/lba/large/rechs",
-    .enum_table = &BiosAtaTranslation_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
-};
-
-/* --- FDC default drive types */
-
-const PropertyInfo qdev_prop_fdc_drive_type = {
-    .name = "FdcDriveType",
-    .description = "FDC drive type, "
-                   "144/288/120/none/auto",
-    .enum_table = &FloppyDriveType_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
-};
-
-/* --- MultiFDCompression --- */
-
-const PropertyInfo qdev_prop_multifd_compression = {
-    .name = "MultiFDCompression",
-    .description = "multifd_compression values, "
-                   "none/zlib/zstd",
-    .enum_table = &MultiFDCompression_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
-};
-
-/* --- pci address --- */
-
-/*
- * bus-local address, i.e. "$slot" or "$slot.$fn"
- */
-static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    int32_t value, *ptr = qdev_get_prop_ptr(dev, prop);
-    unsigned int slot, fn, n;
-    char *str;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    if (!visit_type_str(v, name, &str, NULL)) {
-        if (!visit_type_int32(v, name, &value, errp)) {
-            return;
-        }
-        if (value < -1 || value > 255) {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                       name ? name : "null", "pci_devfn");
-            return;
-        }
-        *ptr = value;
-        return;
-    }
-
-    if (sscanf(str, "%x.%x%n", &slot, &fn, &n) != 2) {
-        fn = 0;
-        if (sscanf(str, "%x%n", &slot, &n) != 1) {
-            goto invalid;
-        }
-    }
-    if (str[n] != '\0' || fn > 7 || slot > 31) {
-        goto invalid;
-    }
-    *ptr = slot << 3 | fn;
-    g_free(str);
-    return;
-
-invalid:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
-    g_free(str);
-}
-
-static int print_pci_devfn(DeviceState *dev, Property *prop, char *dest,
-                           size_t len)
-{
-    int32_t *ptr = qdev_get_prop_ptr(dev, prop);
-
-    if (*ptr == -1) {
-        return snprintf(dest, len, "<unset>");
-    } else {
-        return snprintf(dest, len, "%02x.%x", *ptr >> 3, *ptr & 7);
-    }
-}
-
-const PropertyInfo qdev_prop_pci_devfn = {
-    .name  = "int32",
-    .description = "Slot and optional function number, example: 06.0 or 06",
-    .print = print_pci_devfn,
-    .get   = get_int32,
-    .set   = set_pci_devfn,
-    .set_default_value = set_default_value_int,
-};
-
 /* --- 32bit unsigned int 'size' type --- */
 
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
@@ -868,175 +556,6 @@ const PropertyInfo qdev_prop_size32 = {
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
-/* --- blocksize --- */
-
-/* lower limit is sector size */
-#define MIN_BLOCK_SIZE          512
-#define MIN_BLOCK_SIZE_STR      "512 B"
-/*
- * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
- * matches qcow2 cluster size limit
- */
-#define MAX_BLOCK_SIZE          (2 * MiB)
-#define MAX_BLOCK_SIZE_STR      "2 MiB"
-
-static void set_blocksize(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
-    uint64_t value;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    if (!visit_type_size(v, name, &value, errp)) {
-        return;
-    }
-    /* value of 0 means "unset" */
-    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
-        error_setg(errp,
-                   "Property %s.%s doesn't take value %" PRIu64
-                   " (minimum: " MIN_BLOCK_SIZE_STR
-                   ", maximum: " MAX_BLOCK_SIZE_STR ")",
-                   dev->id ? : "", name, value);
-        return;
-    }
-
-    /* We rely on power-of-2 blocksizes for bitmasks */
-    if ((value & (value - 1)) != 0) {
-        error_setg(errp,
-                  "Property %s.%s doesn't take value '%" PRId64 "', "
-                  "it's not a power of 2", dev->id ?: "", name, (int64_t)value);
-        return;
-    }
-
-    *ptr = value;
-}
-
-const PropertyInfo qdev_prop_blocksize = {
-    .name  = "size",
-    .description = "A power of two between " MIN_BLOCK_SIZE_STR
-                   " and " MAX_BLOCK_SIZE_STR,
-    .get   = qdev_propinfo_get_size32,
-    .set   = set_blocksize,
-    .set_default_value = qdev_propinfo_set_default_value_uint,
-};
-
-/* --- pci host address --- */
-
-static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
-    char buffer[] = "ffff:ff:ff.f";
-    char *p = buffer;
-    int rc = 0;
-
-    /*
-     * Catch "invalid" device reference from vfio-pci and allow the
-     * default buffer representing the non-existent device to be used.
-     */
-    if (~addr->domain || ~addr->bus || ~addr->slot || ~addr->function) {
-        rc = snprintf(buffer, sizeof(buffer), "%04x:%02x:%02x.%0d",
-                      addr->domain, addr->bus, addr->slot, addr->function);
-        assert(rc == sizeof(buffer) - 1);
-    }
-
-    visit_type_str(v, name, &p, errp);
-}
-
-/*
- * Parse [<domain>:]<bus>:<slot>.<func>
- *   if <domain> is not supplied, it's assumed to be 0.
- */
-static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
-    char *str, *p;
-    const char *e;
-    unsigned long val;
-    unsigned long dom = 0, bus = 0;
-    unsigned int slot = 0, func = 0;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    if (!visit_type_str(v, name, &str, errp)) {
-        return;
-    }
-
-    p = str;
-    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e == p) {
-        goto inval;
-    }
-    if (*e != ':') {
-        goto inval;
-    }
-    bus = val;
-
-    p = (char *)e + 1;
-    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
-        goto inval;
-    }
-    if (*e == ':') {
-        dom = bus;
-        bus = val;
-        p = (char *)e + 1;
-        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
-            goto inval;
-        }
-    }
-    slot = val;
-
-    if (*e != '.') {
-        goto inval;
-    }
-    p = (char *)e + 1;
-    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e == p) {
-        goto inval;
-    }
-    func = val;
-
-    if (bus > 0xff) {
-        goto inval;
-    }
-
-    if (*e) {
-        goto inval;
-    }
-
-    addr->domain = dom;
-    addr->bus = bus;
-    addr->slot = slot;
-    addr->function = func;
-
-    g_free(str);
-    return;
-
-inval:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
-    g_free(str);
-}
-
-const PropertyInfo qdev_prop_pci_host_devaddr = {
-    .name = "str",
-    .description = "Address (bus/device/function) of "
-                   "the host device, example: 04:10.0",
-    .get = get_pci_host_devaddr,
-    .set = set_pci_host_devaddr,
-};
-
 /* --- UUID --- */
 
 static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -1286,16 +805,6 @@ void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value)
     object_property_set_str(OBJECT(dev), name, value, &error_abort);
 }
 
-void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
-                           const uint8_t *value)
-{
-    char str[2 * 6 + 5 + 1];
-    snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
-             value[0], value[1], value[2], value[3], value[4], value[5]);
-
-    object_property_set_str(OBJECT(dev), name, str, &error_abort);
-}
-
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
 {
     Property *prop;
@@ -1420,186 +929,3 @@ const PropertyInfo qdev_prop_link = {
     .name = "link",
     .create = create_link_property,
 };
-
-/* --- OffAutoPCIBAR off/auto/bar0/bar1/bar2/bar3/bar4/bar5 --- */
-
-const PropertyInfo qdev_prop_off_auto_pcibar = {
-    .name = "OffAutoPCIBAR",
-    .description = "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
-    .enum_table = &OffAutoPCIBAR_lookup,
-    .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
-};
-
-/* --- PCIELinkSpeed 2_5/5/8/16 -- */
-
-static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
-    int speed;
-
-    switch (*p) {
-    case QEMU_PCI_EXP_LNK_2_5GT:
-        speed = PCIE_LINK_SPEED_2_5;
-        break;
-    case QEMU_PCI_EXP_LNK_5GT:
-        speed = PCIE_LINK_SPEED_5;
-        break;
-    case QEMU_PCI_EXP_LNK_8GT:
-        speed = PCIE_LINK_SPEED_8;
-        break;
-    case QEMU_PCI_EXP_LNK_16GT:
-        speed = PCIE_LINK_SPEED_16;
-        break;
-    default:
-        /* Unreachable */
-        abort();
-    }
-
-    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
-}
-
-static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
-    int speed;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    if (!visit_type_enum(v, prop->name, &speed, prop->info->enum_table,
-                         errp)) {
-        return;
-    }
-
-    switch (speed) {
-    case PCIE_LINK_SPEED_2_5:
-        *p = QEMU_PCI_EXP_LNK_2_5GT;
-        break;
-    case PCIE_LINK_SPEED_5:
-        *p = QEMU_PCI_EXP_LNK_5GT;
-        break;
-    case PCIE_LINK_SPEED_8:
-        *p = QEMU_PCI_EXP_LNK_8GT;
-        break;
-    case PCIE_LINK_SPEED_16:
-        *p = QEMU_PCI_EXP_LNK_16GT;
-        break;
-    default:
-        /* Unreachable */
-        abort();
-    }
-}
-
-const PropertyInfo qdev_prop_pcie_link_speed = {
-    .name = "PCIELinkSpeed",
-    .description = "2_5/5/8/16",
-    .enum_table = &PCIELinkSpeed_lookup,
-    .get = get_prop_pcielinkspeed,
-    .set = set_prop_pcielinkspeed,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
-};
-
-/* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
-
-static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
-    int width;
-
-    switch (*p) {
-    case QEMU_PCI_EXP_LNK_X1:
-        width = PCIE_LINK_WIDTH_1;
-        break;
-    case QEMU_PCI_EXP_LNK_X2:
-        width = PCIE_LINK_WIDTH_2;
-        break;
-    case QEMU_PCI_EXP_LNK_X4:
-        width = PCIE_LINK_WIDTH_4;
-        break;
-    case QEMU_PCI_EXP_LNK_X8:
-        width = PCIE_LINK_WIDTH_8;
-        break;
-    case QEMU_PCI_EXP_LNK_X12:
-        width = PCIE_LINK_WIDTH_12;
-        break;
-    case QEMU_PCI_EXP_LNK_X16:
-        width = PCIE_LINK_WIDTH_16;
-        break;
-    case QEMU_PCI_EXP_LNK_X32:
-        width = PCIE_LINK_WIDTH_32;
-        break;
-    default:
-        /* Unreachable */
-        abort();
-    }
-
-    visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
-}
-
-static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    DeviceState *dev = DEVICE(obj);
-    Property *prop = opaque;
-    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
-    int width;
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    if (!visit_type_enum(v, prop->name, &width, prop->info->enum_table,
-                         errp)) {
-        return;
-    }
-
-    switch (width) {
-    case PCIE_LINK_WIDTH_1:
-        *p = QEMU_PCI_EXP_LNK_X1;
-        break;
-    case PCIE_LINK_WIDTH_2:
-        *p = QEMU_PCI_EXP_LNK_X2;
-        break;
-    case PCIE_LINK_WIDTH_4:
-        *p = QEMU_PCI_EXP_LNK_X4;
-        break;
-    case PCIE_LINK_WIDTH_8:
-        *p = QEMU_PCI_EXP_LNK_X8;
-        break;
-    case PCIE_LINK_WIDTH_12:
-        *p = QEMU_PCI_EXP_LNK_X12;
-        break;
-    case PCIE_LINK_WIDTH_16:
-        *p = QEMU_PCI_EXP_LNK_X16;
-        break;
-    case PCIE_LINK_WIDTH_32:
-        *p = QEMU_PCI_EXP_LNK_X32;
-        break;
-    default:
-        /* Unreachable */
-        abort();
-    }
-}
-
-const PropertyInfo qdev_prop_pcie_link_width = {
-    .name = "PCIELinkWidth",
-    .description = "1/2/4/8/12/16/32",
-    .enum_table = &PCIELinkWidth_lookup,
-    .get = get_prop_pcielinkwidth,
-    .set = set_prop_pcielinkwidth,
-    .set_default_value = qdev_propinfo_set_default_value_enum,
-};
-- 
2.26.2


