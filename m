Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3307AC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935CA208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhZHhmVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935CA208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfqN-0000a0-Kx
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHd-0005mm-Gf
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHG-0007Rm-SA
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XnSf1LAuLV+MUmLsNDrigQ0JXDrj9izEtgHHuUjdSPY=;
 b=IhZHhmVvJRw2KJTibc5F/FK6whbMX0xFWhHEKJenV5C2KMfdLWSp2XCuVjYPqiifVUgPSh
 pjgiM+I+kyYOE4eHx3B0ijAMDCKhyLQhFFmi004uXuB9ZvWoJQOHEgK7CsjuECZ3kVyr+W
 /tfMiEcII9vZnOgRTxoSo8pE9aRPyFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-XKuddB2gNL6PicyhRwQy3g-1; Sat, 19 Sep 2020 11:59:51 -0400
X-MC-Unique: XKuddB2gNL6PicyhRwQy3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DFCE8712D9
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F18845576A
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/57] cutils: introduce get_relocated_path
Date: Sat, 19 Sep 2020 11:59:03 -0400
Message-Id: <20200919155916.1046398-45-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the function that will compute a relocated version of the
directories in CONFIG_QEMU_*DIR and CONFIG_QEMU_*PATH.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/cutils.h | 12 +++++++++
 meson.build           |  4 +--
 util/cutils.c         | 61 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index eb59852dfd..3a86ec0321 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -184,4 +184,16 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n);
  */
 int qemu_pstrcmp0(const char **str1, const char **str2);
 
+
+/**
+ * get_relocated_path:
+ * @dir: the directory (typically a `CONFIG_*DIR` variable) to be relocated.
+ *
+ * Returns a path for @dir that uses the directory of the running executable
+ * as the prefix.  For example, if `bindir` is `/usr/bin` and @dir is
+ * `/usr/share/qemu`, the function will append `../share/qemu` to the
+ * directory that contains the running executable and return the result.
+ */
+char *get_relocated_path(const char *dir);
+
 #endif
diff --git a/meson.build b/meson.build
index 1f8487eacf..1b1cde8725 100644
--- a/meson.build
+++ b/meson.build
@@ -566,9 +566,9 @@ config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1]
 config_host_data.set('QEMU_VERSION_MICRO', meson.project_version().split('.')[2])
 
 arrays = ['CONFIG_AUDIO_DRIVERS', 'CONFIG_BDRV_RW_WHITELIST', 'CONFIG_BDRV_RO_WHITELIST']
-strings = ['HOST_DSOSUF', 'CONFIG_IASL', 'bindir', 'qemu_confdir', 'qemu_datadir',
+strings = ['HOST_DSOSUF', 'CONFIG_IASL', 'bindir', 'prefix', 'qemu_confdir', 'qemu_datadir',
            'qemu_moddir', 'qemu_localstatedir', 'qemu_helperdir', 'qemu_localedir',
-           'qemu_icondir', 'qemu_desktopdir', 'qemu_firmwarepath']
+           'qemu_icondir', 'qemu_desktopdir', 'qemu_firmwarepath', 'sysconfdir']
 foreach k, v: config_host
   if arrays.contains(k)
     if v != ''
diff --git a/util/cutils.c b/util/cutils.c
index 36ce712271..8da34e04b0 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -889,3 +889,64 @@ int qemu_pstrcmp0(const char **str1, const char **str2)
 {
     return g_strcmp0(*str1, *str2);
 }
+
+static inline bool starts_with_prefix(const char *dir)
+{
+    size_t prefix_len = strlen(CONFIG_PREFIX);
+    return !memcmp(dir, CONFIG_PREFIX, prefix_len) &&
+        (!dir[prefix_len] || G_IS_DIR_SEPARATOR(dir[prefix_len]));
+}
+
+/* Return the next path component in dir, and store its length in *p_len.  */
+static inline const char *next_component(const char *dir, int *p_len)
+{
+    int len;
+    while (*dir && G_IS_DIR_SEPARATOR(*dir)) {
+        dir++;
+    }
+    len = 0;
+    while (dir[len] && !G_IS_DIR_SEPARATOR(dir[len])) {
+        len++;
+    }
+    *p_len = len;
+    return dir;
+}
+
+char *get_relocated_path(const char *dir)
+{
+    size_t prefix_len = strlen(CONFIG_PREFIX);
+    const char *bindir = CONFIG_BINDIR;
+    const char *exec_dir = qemu_get_exec_dir();
+    GString *result;
+    int len_dir, len_bindir;
+
+    /* Fail if qemu_init_exec_dir was not called.  */
+    assert(exec_dir[0]);
+    if (!starts_with_prefix(dir) || !starts_with_prefix(bindir)) {
+        return strdup(dir);
+    }
+
+    result = g_string_new(exec_dir);
+
+    /* Advance over common components.  */
+    len_dir = len_bindir = prefix_len;
+    do {
+        dir += len_dir;
+        bindir += len_bindir;
+        dir = next_component(dir, &len_dir);
+        bindir = next_component(bindir, &len_bindir);
+    } while (len_dir == len_bindir && !memcmp(dir, bindir, len_dir));
+
+    /* Ascend from bindir to the common prefix with dir.  */
+    while (len_bindir) {
+        bindir += len_bindir;
+        g_string_append(result, "/..");
+        bindir = next_component(bindir, &len_bindir);
+    }
+
+    if (*dir) {
+        assert(G_IS_DIR_SEPARATOR(dir[-1]));
+        g_string_append(result, dir - 1);
+    }
+    return result->str;
+}
-- 
2.26.2



