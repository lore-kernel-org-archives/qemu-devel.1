Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABFCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A3820663
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A3820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgHu3-0001ww-JZ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jgHtM-0001TW-F0
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:08:28 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:54380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jgHtJ-0002rU-SH
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:08:27 -0400
Received: from localhost (unknown [192.168.167.16])
 by lucky1.263xmail.com (Postfix) with ESMTP id BD205BE8D0;
 Wed,  3 Jun 2020 09:08:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [223.72.72.58])
 by smtp.263.net (postfix) whith ESMTP id
 P761T139943940695808S1591146491618573_; 
 Wed, 03 Jun 2020 09:08:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d0f552a632c88d22ab7a7ff9664e8195>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: laurent@vivier.eu
X-SENDER-IP: 223.72.72.58
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: laurent@vivier.eu,
	riku.voipio@iki.fi
Subject: [PATCH v5] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Date: Wed,  3 Jun 2020 09:08:09 +0800
Message-Id: <20200603010809.32139-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.157.147.133;
 envelope-from=chengang@emindsoft.com.cn; helo=lucky1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 21:08:18
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: chengang@emindsoft.com.cn, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

Another DRM_IOCTL_* commands will be done later.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 configure                  |  10 ++++
 linux-user/ioctls.h        |   5 ++
 linux-user/syscall.c       | 117 +++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  15 +++++
 linux-user/syscall_types.h |  11 ++++
 5 files changed, 158 insertions(+)

diff --git a/configure b/configure
index e225a1e3ff..3cf28a649a 100755
--- a/configure
+++ b/configure
@@ -3140,6 +3140,13 @@ if ! check_include "ifaddrs.h" ; then
   have_ifaddrs_h=no
 fi
 
+#########################################
+# libdrm check
+have_drm_h=no
+if check_include "libdrm/drm.h" ; then
+    have_drm_h=yes
+fi
+
 ##########################################
 # VTE probe
 
@@ -7149,6 +7156,9 @@ fi
 if test "$have_ifaddrs_h" = "yes" ; then
     echo "HAVE_IFADDRS_H=y" >> $config_host_mak
 fi
+if test "$have_drm_h" = "yes" ; then
+  echo "HAVE_DRM_H=y" >> $config_host_mak
+fi
 if test "$have_broken_size_max" = "yes" ; then
     echo "HAVE_BROKEN_SIZE_MAX=y" >> $config_host_mak
 fi
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0defa1d8c1..f2e2fa9c87 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -574,6 +574,11 @@
   IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
                 MK_PTR(MK_STRUCT(STRUCT_rtentry)))
 
+#ifdef HAVE_DRM_H
+  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
+                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
+#endif
+
 #ifdef TARGET_TIOCSTART
   IOCTL_IGNORE(TIOCSTART)
   IOCTL_IGNORE(TIOCSTOP)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5af55fca78..07b7596e0f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -112,6 +112,9 @@
 #include <linux/if_alg.h>
 #include <linux/rtc.h>
 #include <sound/asound.h>
+#ifdef HAVE_DRM_H
+#include <libdrm/drm.h>
+#endif
 #include "linux_loop.h"
 #include "uname.h"
 
@@ -5275,6 +5278,120 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
 }
 #endif
 
+#ifdef HAVE_DRM_H
+
+static void unlock_drm_version(struct drm_version *host_ver)
+{
+    if (host_ver->name) {
+        unlock_user(host_ver->name, 0UL, 0);
+    }
+    if (host_ver->date) {
+        unlock_user(host_ver->date, 0UL, 0);
+    }
+    if (host_ver->desc) {
+        unlock_user(host_ver->desc, 0UL, 0);
+    }
+}
+
+static inline abi_long target_to_host_drmversion(struct drm_version *host_ver,
+                                                abi_long target_addr)
+{
+    struct target_drm_version *target_ver;
+
+    if (!lock_user_struct(VERIFY_READ, target_ver, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(host_ver, 0, sizeof(*host_ver));
+
+    __get_user(host_ver->name_len, &target_ver->name_len);
+    if (host_ver->name_len) {
+        host_ver->name = lock_user(VERIFY_WRITE, target_ver->name,
+                                   target_ver->name_len, 0);
+        if (!host_ver->name) {
+            goto err;
+        }
+    }
+
+    __get_user(host_ver->date_len, &target_ver->date_len);
+    if (host_ver->date_len) {
+        host_ver->date = lock_user(VERIFY_WRITE, target_ver->date,
+                                   target_ver->date_len, 0);
+        if (!host_ver->date) {
+            goto err;
+        }
+    }
+
+    __get_user(host_ver->desc_len, &target_ver->desc_len);
+    if (host_ver->desc_len) {
+        host_ver->desc = lock_user(VERIFY_WRITE, target_ver->desc,
+                                   target_ver->desc_len, 0);
+        if (!host_ver->desc) {
+            goto err;
+        }
+    }
+
+    unlock_user_struct(target_ver, target_addr, 0);
+    return 0;
+err:
+    unlock_drm_version(host_ver);
+    unlock_user_struct(target_ver, target_addr, 0);
+    return -ENOMEM;
+}
+
+static inline abi_long host_to_target_drmversion(abi_ulong target_addr,
+                                                 struct drm_version *host_ver)
+{
+    struct target_drm_version *target_ver;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ver, target_addr, 0)) {
+        unlock_drm_version(host_ver);
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_ver->version_major, &target_ver->version_major);
+    __put_user(host_ver->version_minor, &target_ver->version_minor);
+    __put_user(host_ver->version_patchlevel, &target_ver->version_patchlevel);
+    __put_user(host_ver->name_len, &target_ver->name_len);
+    __put_user(host_ver->date_len, &target_ver->date_len);
+    __put_user(host_ver->desc_len, &target_ver->desc_len);
+    if (host_ver->name) {
+        unlock_user(host_ver->name, target_ver->name, host_ver->name_len);
+    }
+    if (host_ver->date) {
+        unlock_user(host_ver->date, target_ver->date, host_ver->date_len);
+    }
+    if (host_ver->desc) {
+        unlock_user(host_ver->desc, target_ver->desc, host_ver->desc_len);
+    }
+    unlock_user_struct(target_ver, target_addr, 0);
+    return 0;
+}
+
+static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
+                             int fd, int cmd, abi_long arg)
+{
+    struct drm_version *ver;
+    abi_long ret;
+
+    switch (ie->host_cmd) {
+    case DRM_IOCTL_VERSION:
+        ver = (struct drm_version *)buf_temp;
+        ret = target_to_host_drmversion(ver, arg);
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret = get_errno(safe_ioctl(fd, ie->host_cmd, ver));
+        if (is_error(ret)) {
+            unlock_drm_version(ver);
+            return ret;
+        }
+        return host_to_target_drmversion(arg, ver);
+    }
+    return -TARGET_EFAULT;
+}
+
+#endif
+
 static IOCTLEntry ioctl_entries[] = {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cb..3c261cff0e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1167,6 +1167,9 @@ struct target_rtc_pll_info {
 #define TARGET_DM_TARGET_MSG          TARGET_IOWRU(0xfd, 0x0e)
 #define TARGET_DM_DEV_SET_GEOMETRY    TARGET_IOWRU(0xfd, 0x0f)
 
+/* drm ioctls */
+#define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
+
 /* from asm/termbits.h */
 
 #define TARGET_NCC 8
@@ -2598,6 +2601,18 @@ struct target_mq_attr {
     abi_long mq_curmsgs;
 };
 
+struct target_drm_version {
+    int version_major;
+    int version_minor;
+    int version_patchlevel;
+    abi_ulong name_len;
+    abi_ulong name;
+    abi_ulong date_len;
+    abi_ulong date;
+    abi_ulong desc_len;
+    abi_ulong desc;
+};
+
 #include "socket.h"
 
 #include "errno_defs.h"
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e12c1661e..e2b0484f50 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -292,6 +292,17 @@ STRUCT(dm_target_versions,
 STRUCT(dm_target_msg,
        TYPE_ULONGLONG) /* sector */
 
+STRUCT(drm_version,
+       TYPE_INT, /* version_major */
+       TYPE_INT, /* version_minor */
+       TYPE_INT, /* version_patchlevel */
+       TYPE_ULONG, /* name_len */
+       TYPE_PTRVOID, /* name */
+       TYPE_ULONG, /* date_len */
+       TYPE_PTRVOID, /* date */
+       TYPE_ULONG, /* desc_len */
+       TYPE_PTRVOID) /* desc */
+
 STRUCT(file_clone_range,
        TYPE_LONGLONG, /* src_fd */
        TYPE_ULONGLONG, /* src_offset */
-- 
2.24.0.308.g228f53135a




