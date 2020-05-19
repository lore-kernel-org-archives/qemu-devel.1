Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9ECC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A01F20825
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="ZQhl7QBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A01F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1PJ-0000uM-I6
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1Jg-0000J6-A7
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:52 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:36374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1Jf-0003Br-7L
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=jT92JqZtZUmA3PFJRrvDF8fwEZnfiERhVDKGu5hwiQ4=;
 b=ZQhl7QBTbZqYUh6Z5d+XgdkPNOVARmpugKSJmwVIPXw0CuZieOdsR6/5oXyVRhef7xOy
 444lqNj+TRsMMpgzZc0RyPjRfJTBGKPxCWRcKi+RF6fcU4bHEXvZp8j153Y9jzZ+FKcyKa
 Oq1uY7mDL+YFkagWV7d8HKUfWOsMp+lJE=
Received: by filterdrecv-p3iad2-8ddf98858-szfkb with SMTP id
 filterdrecv-p3iad2-8ddf98858-szfkb-20-5EC3D04D-6
 2020-05-19 12:25:49.190975261 +0000 UTC m=+4706298.008098870
Received: from localhost.localdomain.com (unknown)
 by ismtpd0002p1lon1.sendgrid.net (SG) with ESMTP
 id lkz1JrdfRLuDvJ5OvT0Jjg Tue, 19 May 2020 12:25:48.926 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v3 09/10] Support individual region unmap in libvhost-user
Date: Tue, 19 May 2020 12:25:49 +0000 (UTC)
Message-Id: <1588473683-27067-10-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zSN6V8XISlCxxStuT?=
 =?us-ascii?Q?F=2FSD=2FCRgKNDHTJ+8Y+=2FFdyf6lzmistsVxaKPxtP?=
 =?us-ascii?Q?dBxSJR8DMIFC1GRq7o1EYP4sEyR9tDHlXy4glAI?=
 =?us-ascii?Q?=2FG4Qj1aSHEpZKdvzbJMxP9IuiZJjqNbBqx0C0uP?=
 =?us-ascii?Q?eVK+nzO=2Fr7J0Jgr51NLm7Z4ttavJs1Z8yE=2FkhZn?=
 =?us-ascii?Q?38AvYPNnFFl6eGmm0vigQ=3D=3D?=
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 08:25:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: raphael.s.norwitz@gmail.com, marcandre.lureau@gmail.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol feature is
enabled, on memory hot-unplug qemu will transmit memory regions to
remove individually using the new message VHOST_USER_REM_MEM_REG
message. With this change, vhost-user backends build with libvhost-user
can now unmap individual memory regions when receiving the
VHOST_USER_REM_MEM_REG message.

Qemu only sends VHOST_USER_REM_MEM_REG messages when the
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS feature is negotiated, and
support for that feature has not yet been added in libvhost-user, this
new functionality is not yet used.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 contrib/libvhost-user/libvhost-user.c | 63 +++++++++++++++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |  1 +
 2 files changed, 64 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 2c2a8d9..635cfb1 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -139,6 +139,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_VRING_KICK),
         REQ(VHOST_USER_GET_MAX_MEM_SLOTS),
         REQ(VHOST_USER_ADD_MEM_REG),
+        REQ(VHOST_USER_REM_MEM_REG),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -763,6 +764,66 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     }
 }
 
+static inline bool reg_equal(VuDevRegion *vudev_reg,
+                             VhostUserMemoryRegion *msg_reg)
+{
+    if (vudev_reg->gpa == msg_reg->guest_phys_addr &&
+        vudev_reg->qva == msg_reg->userspace_addr &&
+        vudev_reg->size == msg_reg->memory_size) {
+        return true;
+    }
+
+    return false;
+}
+
+static bool
+vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
+    int i, j;
+    bool found = false;
+    VuDevRegion shadow_regions[VHOST_MEMORY_MAX_NREGIONS] = {};
+    VhostUserMemoryRegion *msg_region = &vmsg->payload.memreg.region;
+
+    DPRINT("Removing region:\n");
+    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+           msg_region->guest_phys_addr);
+    DPRINT("    memory_size:     0x%016"PRIx64"\n",
+           msg_region->memory_size);
+    DPRINT("    userspace_addr   0x%016"PRIx64"\n",
+           msg_region->userspace_addr);
+    DPRINT("    mmap_offset      0x%016"PRIx64"\n",
+           msg_region->mmap_offset);
+
+    for (i = 0, j = 0; i < dev->nregions; i++) {
+        if (!reg_equal(&dev->regions[i], msg_region)) {
+            shadow_regions[j].gpa = dev->regions[i].gpa;
+            shadow_regions[j].size = dev->regions[i].size;
+            shadow_regions[j].qva = dev->regions[i].qva;
+            shadow_regions[j].mmap_offset = dev->regions[i].mmap_offset;
+            j++;
+        } else {
+            found = true;
+            VuDevRegion *r = &dev->regions[i];
+            void *m = (void *) (uintptr_t) r->mmap_addr;
+
+            if (m) {
+                munmap(m, r->size + r->mmap_offset);
+            }
+        }
+    }
+
+    if (found) {
+        memcpy(dev->regions, shadow_regions,
+               sizeof(VuDevRegion) * VHOST_MEMORY_MAX_NREGIONS);
+        DPRINT("Successfully removed a region\n");
+        dev->nregions--;
+        vmsg_set_reply_u64(vmsg, 0);
+    } else {
+        vu_panic(dev, "Specified region not found\n");
+    }
+
+    return true;
+}
+
 static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1771,6 +1832,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_handle_get_max_memslots(dev, vmsg);
     case VHOST_USER_ADD_MEM_REG:
         return vu_add_mem_reg(dev, vmsg);
+    case VHOST_USER_REM_MEM_REG:
+        return vu_rem_mem_reg(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 60ef7fd..f843971 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -99,6 +99,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_VRING_KICK = 35,
     VHOST_USER_GET_MAX_MEM_SLOTS = 36,
     VHOST_USER_ADD_MEM_REG = 37,
+    VHOST_USER_REM_MEM_REG = 38,
     VHOST_USER_MAX
 } VhostUserRequest;
 
-- 
1.8.3.1


