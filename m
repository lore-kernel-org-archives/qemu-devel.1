Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E09C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734422082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CKP+xxBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734422082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5Au-0001nu-In
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44829)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3T0qLXQYKCgQweqimhksskpi.gsquiqy-hiziprsrkry.svk@flex--sameid.bounces.google.com>)
 id 1iD58M-0007ws-Hp
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3T0qLXQYKCgQweqimhksskpi.gsquiqy-hiziprsrkry.svk@flex--sameid.bounces.google.com>)
 id 1iD58L-0004Q9-EP
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:58 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a]:35487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3T0qLXQYKCgQweqimhksskpi.gsquiqy-hiziprsrkry.svk@flex--sameid.bounces.google.com>)
 id 1iD58L-0004PJ-9D
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:57 -0400
Received: by mail-wm1-x34a.google.com with SMTP id k9so1944986wmb.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=D4/WwEuQfb0OwGTdHL/wsfMkxNs9t/uthskzigDltsc=;
 b=CKP+xxBXKbd6sJ6s1kT6DlCCCqq4Hv0YuAOPqLXuI100erdqtHh2+pr+qXBQOPx+bP
 T+5MjmV7+Dt1qKBWWBjmKZGQ1yIOeC+NmGKG0MH6gxO38rlDJjlLcN8eVoeP9NbXtBfe
 BWNlQrpCxzIGfayhIwzEQbbB2U9Zanf/N0bB6LOMfA3MKdsZwtY7PrMb5Mi/q2p5eWi4
 10h3fWESQ7BIn4KSh6MdZq7Ggxn3k6G0RAkf000HZdlIKoJqTZICbna8HQO5wHCYtiUK
 swtIpYOw+I9J3sDdG6MZxa3OrCYsv4xNZyx/RQEvcgb6hpIV5OXEuAZ3FAtI+cNlpI8u
 mUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=D4/WwEuQfb0OwGTdHL/wsfMkxNs9t/uthskzigDltsc=;
 b=TOqajF5hC4mXWRj3uONPwFe8r6zKUMYCefkvwtYyTg1tpL53/G4uIe0CuG1SUM+dzu
 6AR5/pL11nhxy+BDOToZ3iOMz4qg+3CuEhGjeEhFMVv84gAh66muAJW/0ZiyLB/JaD+P
 ydtetAUtAx6fKx7ge8qpqvApFfPgCOrwGkhtVLQEtVLM5hqkzRgx/ltXve5lpwNF1QIm
 PaApAdOdsPrdrT5lQoHq/KW1ijgVptCCA7RVTc4FK+ah2NoePVSiCeTfxejmpeADj6zK
 47SRyoIO3BQS5bJmLFeVnV4J6su/qY9x/6R9PwYXzun+PTE1xmyMjT3JO4vnTueokeF4
 edPg==
X-Gm-Message-State: APjAAAX7sLER9tuXg1z4WqakjuuP/moBXM0MEIOhrcSA4sXgmBNJ99Sq
 gSEzo40zJTw2o7UXOTcu7GwBSy4V68fI3ZrSLPVXIPYSeIIOhzQ5TdY9CdnxT6+oGKblg79eC8E
 BSY5UQATAaBTrONssSKNxBBoDCcgJ+bNnZM5YAOBLKkK1EQ5noQ77Xq+4aGW2
X-Google-Smtp-Source: APXvYqwP3pUkQht+a8Vbqi9tV8ffJFe2CuKJBedfO3HE6n1nzU5HMGwOD0Id1LbAvmqQg5Jg+utKsXsPrNA=
X-Received: by 2002:a5d:5229:: with SMTP id i9mr8756866wra.76.1569409615715;
 Wed, 25 Sep 2019 04:06:55 -0700 (PDT)
Date: Wed, 25 Sep 2019 14:06:34 +0300
In-Reply-To: <20190925110639.100699-1-sameid@google.com>
Message-Id: <20190925110639.100699-4-sameid@google.com>
Mime-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v7 3/8] bootdevice: Add interface to gather LCHS
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::34a
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, kevin@koconnor.net, liran.alon@oracle.com,
 kraxel@redhat.com, Sam Eiderman <shmuel.eiderman@oracle.com>,
 sameid@google.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Sam Eiderman <sameid@google.com>
From: Sam Eiderman via <qemu-devel@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Add an interface to provide direct logical CHS values for boot devices.
We will use this interface in the next commits.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 bootdevice.c            | 55 +++++++++++++++++++++++++++++++++++++++++
 include/sysemu/sysemu.h |  3 +++
 2 files changed, 58 insertions(+)

diff --git a/bootdevice.c b/bootdevice.c
index 1d225202f9..bc5e1c2de4 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -343,3 +343,58 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
     /* initialize devices' bootindex property to -1 */
     object_property_set_int(obj, -1, name, NULL);
 }
+
+typedef struct FWLCHSEntry FWLCHSEntry;
+
+struct FWLCHSEntry {
+    QTAILQ_ENTRY(FWLCHSEntry) link;
+    DeviceState *dev;
+    char *suffix;
+    uint32_t lcyls;
+    uint32_t lheads;
+    uint32_t lsecs;
+};
+
+static QTAILQ_HEAD(, FWLCHSEntry) fw_lchs =
+    QTAILQ_HEAD_INITIALIZER(fw_lchs);
+
+void add_boot_device_lchs(DeviceState *dev, const char *suffix,
+                          uint32_t lcyls, uint32_t lheads, uint32_t lsecs)
+{
+    FWLCHSEntry *node;
+
+    if (!lcyls && !lheads && !lsecs) {
+        return;
+    }
+
+    assert(dev != NULL || suffix != NULL);
+
+    node = g_malloc0(sizeof(FWLCHSEntry));
+    node->suffix = g_strdup(suffix);
+    node->dev = dev;
+    node->lcyls = lcyls;
+    node->lheads = lheads;
+    node->lsecs = lsecs;
+
+    QTAILQ_INSERT_TAIL(&fw_lchs, node, link);
+}
+
+void del_boot_device_lchs(DeviceState *dev, const char *suffix)
+{
+    FWLCHSEntry *i;
+
+    if (dev == NULL) {
+        return;
+    }
+
+    QTAILQ_FOREACH(i, &fw_lchs, link) {
+        if ((!suffix || !g_strcmp0(i->suffix, suffix)) &&
+             i->dev == dev) {
+            QTAILQ_REMOVE(&fw_lchs, i, link);
+            g_free(i->suffix);
+            g_free(i);
+
+            break;
+        }
+    }
+}
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 44f18eb739..5bc5c79cbc 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -103,6 +103,9 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
                                    DeviceState *dev, Error **errp);
 void restore_boot_order(void *opaque);
 void validate_bootdevices(const char *devices, Error **errp);
+void add_boot_device_lchs(DeviceState *dev, const char *suffix,
+                          uint32_t lcyls, uint32_t lheads, uint32_t lsecs);
+void del_boot_device_lchs(DeviceState *dev, const char *suffix);
 
 /* handler to set the boot_device order for a specific type of MachineClass */
 typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
-- 
2.23.0.351.gc4317032e6-goog


