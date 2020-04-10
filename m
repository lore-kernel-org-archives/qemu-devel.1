Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E5EC2D0EC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 05:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A8D20787
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 05:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A8D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMlnd-000529-6P
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 01:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bowen.wang@intel.com>) id 1jMlme-0004Rh-Gi
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 01:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bowen.wang@intel.com>) id 1jMlmb-00059p-W1
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 01:00:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:20068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bowen.wang@intel.com>)
 id 1jMlmb-0004hm-O7
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 01:00:49 -0400
IronPort-SDR: xIOrQ59SbanC3wfhHzPpVg+vW755D3LQr6bEw1T7OlPQ/jBDcqjdjq+OhgONlQux3KRYIzQyB3
 8Oq+32eomOaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 22:00:21 -0700
IronPort-SDR: ilrqJ3TIqblCeNRKDlTzobM4izAPG+pyIot8y+BIMKGDpU21zFoH3QnyLgJg7bzK/k7Nm0Zg0Q
 NvL4/EQBW+6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; d="scan'208";a="452271483"
Received: from desktop-do5fptk.sh.intel.com (HELO localhost.localdomain)
 ([10.239.47.198])
 by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2020 22:00:19 -0700
From: WangBowen <bowen.wang@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hax: Add hax max vcpu IOCTL and support 64 vcpu
Date: Fri, 10 Apr 2020 12:57:51 +0800
Message-Id: <20200410045751.3448-1-bowen.wang@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.43
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
Cc: bowen.wang@intel.com, colin.xu@intel.com, wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit tried to obtain max vcpu of haxm driver by calling
HAX_IOCTL_CAP_MAX_VCPU before creating the vm so that if using hax as
the accelerator and the smp value is larger than the haxm driver
supported max value, the program will terminate. Previously, it will
create vm and vcpu one by one until haxm reports error. Also, the
maximum vcpu value in qemu for haxm is updated from 0x10 to 0x40 in
hax-i386.h.

This patch resolves the issue by calling hax device ioctl
HAX_IOCTL_CAP_MAX_VCPU in hax_init and store the min(haxm max, qemu max)
in hax_state structure. The value will be compared with smp value in
vm_create. (ioctl naming credit to KVM)

This commit results in if ioctl doesn't exist or occur error, it will
continue running but output warning, if smp value is larger than the
min(hax max,qemu max), it will terminate and output error message.

Signed-off-by: WangBowen <bowen.wang@intel.com>
---
 target/i386/hax-all.c     |  7 +++++--
 target/i386/hax-i386.h    |  4 +++-
 target/i386/hax-posix.c   | 29 +++++++++++++++++++++++++++++
 target/i386/hax-posix.h   |  1 +
 target/i386/hax-windows.c | 32 ++++++++++++++++++++++++++++++++
 target/i386/hax-windows.h |  2 ++
 6 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index a22adec5da..eadfa7c881 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -259,8 +259,9 @@ struct hax_vm *hax_vm_create(struct hax_state *hax, int max_cpus)
         goto error;
     }
 
-    if (max_cpus > HAX_MAX_VCPU) {
-        fprintf(stderr, "Maximum VCPU number QEMU supported is %d\n", HAX_MAX_VCPU);
+    if (max_cpus > hax->hax_max_vcpu) {
+        fprintf(stderr, "Maximum VCPU number QEMU and HAXM driver supported is %d\n",
+                hax->hax_max_vcpu);
         goto error;
     }
 
@@ -332,6 +333,8 @@ static int hax_init(ram_addr_t ram_size, int max_cpus)
         goto error;
     }
 
+    hax->hax_max_vcpu = hax_max_vcpus_support(hax);
+
     if (!hax_version_support(hax)) {
         ret = -EINVAL;
         goto error;
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 7d988f81da..1ffa8df63a 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -38,9 +38,10 @@ struct hax_state {
     struct hax_vm *vm;
     uint64_t mem_quota;
     bool supports_64bit_ramblock;
+    int hax_max_vcpu;
 };
 
-#define HAX_MAX_VCPU 0x10
+#define HAX_MAX_VCPU 0x40
 #define MAX_VM_ID 0x40
 #define MAX_VCPU_ID 0x40
 
@@ -74,6 +75,7 @@ int hax_notify_qemu_version(hax_fd vm_fd, struct hax_qemu_version *qversion);
 int hax_set_ram(uint64_t start_pa, uint32_t size, uint64_t host_va, int flags);
 
 /* Common host function */
+int hax_max_vcpus_support(struct hax_state *hax);
 int hax_host_create_vm(struct hax_state *hax, int *vm_id);
 hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id);
 int hax_host_create_vcpu(hax_fd vm_fd, int vcpuid);
diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index a5426a6dac..a4f9dce55e 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -163,6 +163,35 @@ int hax_host_create_vm(struct hax_state *hax, int *vmid)
     return ret;
 }
 
+int hax_max_vcpus_support(struct hax_state *hax)
+{
+    int ret;
+    int vcpu_num = 0;
+
+    if (hax_invalid_fd(hax->fd)) {
+        return vcpu_num;
+    }
+
+    ret = ioctl(hax->fd, HAX_IOCTL_CAP_MAX_VCPU, &vcpu_num);
+
+    if (ret == 0 && vcpu_num > 0) {
+        if (vcpu_num != HAX_MAX_VCPU) {
+            fprintf(stderr, "Warning: HAXM driver and QEMU are inconsistent"
+                    " in max vcpu number, HAXM driver: %d, QEMU: %d,"
+                    " refers to the smaller one.\n", vcpu_num, HAX_MAX_VCPU);
+            if (vcpu_num > HAX_MAX_VCPU) {
+                vcpu_num = HAX_MAX_VCPU;
+            }
+        }
+    } else {
+        vcpu_num = HAX_MAX_VCPU;
+        fprintf(stderr, "Warning: HAXM driver doesn't support HAX_IOCTL_CAP_MAX_VCPU,"
+                " will refer to max value defined in QEMU\n");
+    }
+
+    return vcpu_num;
+}
+
 hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
 {
     hax_fd fd;
diff --git a/target/i386/hax-posix.h b/target/i386/hax-posix.h
index fb7c64426d..42e58f6fa5 100644
--- a/target/i386/hax-posix.h
+++ b/target/i386/hax-posix.h
@@ -38,6 +38,7 @@ static inline void hax_close_fd(hax_fd fd)
 #define HAX_IOCTL_CREATE_VM _IOWR(0, 0x21, uint32_t)
 #define HAX_IOCTL_DESTROY_VM _IOW(0, 0x22, uint32_t)
 #define HAX_IOCTL_CAPABILITY _IOR(0, 0x23, struct hax_capabilityinfo)
+#define HAX_IOCTL_CAP_MAX_VCPU _IOR(0, 0x25, uint32_t)
 
 #define HAX_VM_IOCTL_VCPU_CREATE _IOWR(0, 0x80, uint32_t)
 #define HAX_VM_IOCTL_ALLOC_RAM _IOWR(0, 0x81, struct hax_alloc_ram_info)
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 5729ad9b48..c7816e1950 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -249,6 +249,38 @@ int hax_host_create_vm(struct hax_state *hax, int *vmid)
     return 0;
 }
 
+int hax_max_vcpus_support(struct hax_state *hax)
+{
+    int ret;
+    int vcpu_num = 0;
+    DWORD dSize = 0;
+
+    if (hax_invalid_fd(hax->fd)) {
+        return vcpu_num;
+    }
+
+    ret = DeviceIoControl(hax->fd,
+                          HAX_IOCTL_CAP_MAX_VCPU,
+                          NULL, 0, &vcpu_num, sizeof(vcpu_num), &dSize,
+                          (LPOVERLAPPED) NULL);
+    if (ret && vcpu_num > 0) {
+        if (vcpu_num != HAX_MAX_VCPU) {
+            fprintf(stderr, "Warning: HAXM driver and QEMU are inconsistent"
+                    " in max vcpu number, HAXM driver: %d, QEMU: %d,"
+                    " refers to the smaller one.\n", vcpu_num, HAX_MAX_VCPU);
+            if (vcpu_num > HAX_MAX_VCPU) {
+                vcpu_num = HAX_MAX_VCPU;
+            }
+        }
+    } else {
+        vcpu_num = HAX_MAX_VCPU;
+        fprintf(stderr, "Warning: HAXM driver doesn't support HAX_IOCTL_CAP_MAX_VCPU,"
+                " will refer to max value defined in QEMU\n");
+    }
+
+    return vcpu_num;
+}
+
 hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
 {
     char *vm_name = NULL;
diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
index 12cbd813dc..c4fa88a2fa 100644
--- a/target/i386/hax-windows.h
+++ b/target/i386/hax-windows.h
@@ -48,6 +48,8 @@ static inline int hax_invalid_fd(hax_fd fd)
                                          METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define HAX_IOCTL_CAPABILITY    CTL_CODE(HAX_DEVICE_TYPE, 0x910, \
                                          METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_IOCTL_CAP_MAX_VCPU  CTL_CODE(HAX_DEVICE_TYPE, 0x917, \
+                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
 
 #define HAX_VM_IOCTL_VCPU_CREATE   CTL_CODE(HAX_DEVICE_TYPE, 0x902, \
                                             METHOD_BUFFERED, FILE_ANY_ACCESS)
-- 
2.24.1


