Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2560C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788BC20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eS/q33Fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788BC20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisYb-0002e3-NJ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLf-0001bm-Ca
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLd-0008Mi-FX
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ZfvYRjYmGPxNT0fOPfO9sBNQzeK+Gxo9SoF7dTSLww=;
 b=eS/q33Fwu0j4Fq9ohN3OOzsGgpsGQR29CTygtaJ7CDW1wVlpbcKD3kMVnzR2AATq9YaAlx
 AiI1ZnfoE6U+y31r8qTQ8Sn/3/akA21F4c2cXpUNsOG/LUzOyyRc7s+FuQUtrcfeVA+d8Q
 EyQ2nd2LF7lCEhJPTp9619Z2CTLyrkk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-V3vVinx0Pxqtr0MlOdewaw-1; Wed, 10 Jun 2020 00:28:17 -0400
X-MC-Unique: V3vVinx0Pxqtr0MlOdewaw-1
Received: by mail-wr1-f69.google.com with SMTP id s17so510296wrt.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/ZfvYRjYmGPxNT0fOPfO9sBNQzeK+Gxo9SoF7dTSLww=;
 b=nUdBRqnUzA0vWMMfR5WIK/roWWULe/IhIC9FDgoX+N7Br+Hj2hWDyVD/4sMacQfAPN
 rA40qMjOE693bdYJaQ8x7tLfoUgYXduGUmh85tj5Ro9gQ4Y7YvrdvBOw3NA8N1bW0Lu1
 HycbLXKfEBwcItiihKyJ871iTT2GAmdW0dndXjMWte9vGr9VHVx7Rvu2zUTgRzXlnqVN
 pJ2VGO4U93+pe4eGbxZdRAHxMWT05a2f7NV3chQFcJn/opEo8oBU1zprftDSKuEZDTyK
 /QMy0BcuyYiSMwnRFBoelCKH0yprtToL8XQiwNvNYdgXDmrNL/yN41LegZlp7kbd0/J5
 ujAw==
X-Gm-Message-State: AOAM533Ya1lRcemRBtpHr3Z4I/DiRnlP7dB8fLXR9yzqtwgoaQv3pL/T
 sx8pHUFHFthVu5ol3mqAcjdUnhAiXZhEDurVvpV6m8itJGY5eE9Id7pGnrgyR9AbTw2Z7nCzA85
 IBTczEvztj7LOyS4=
X-Received: by 2002:a7b:c393:: with SMTP id s19mr1180487wmj.92.1591763296487; 
 Tue, 09 Jun 2020 21:28:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRHiDSeldSwySbv9WSf8RZPeErOrygvy+uTEBXMPdLv/rnhiYTC2BTcM3N+dm1gvaVsQYccw==
X-Received: by 2002:a7b:c393:: with SMTP id s19mr1180420wmj.92.1591763295227; 
 Tue, 09 Jun 2020 21:28:15 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id v19sm5077012wml.26.2020.06.09.21.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:14 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/56] Lift max ram slots limit in libvhost-user
Message-ID: <20200610042613.1459309-46-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Johannes Berg <johannes.berg@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

Historically, VMs with vhost-user devices could hot-add memory a maximum
of 8 times. Now that the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
protocol feature has been added, VMs with vhost-user backends which
support this new feature can support a configurable number of ram slots
up to the maximum supported by the target platform.

This change adds VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS support for
backends built with libvhost-user, and increases the number of supported
ram slots from 8 to 32.

Memory hot-add, hot-remove and postcopy migration were tested with
the vhost-user-bridge sample.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1588533678-23450-11-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 15 +++++++++++----
 contrib/libvhost-user/libvhost-user.c | 17 +++++++++--------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index f8439713a8..844c37c648 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -28,7 +28,13 @@
 
 #define VIRTQUEUE_MAX_SIZE 1024
 
-#define VHOST_MEMORY_MAX_NREGIONS 8
+#define VHOST_MEMORY_BASELINE_NREGIONS 8
+
+/*
+ * Set a reasonable maximum number of ram slots, which will be supported by
+ * any architecture.
+ */
+#define VHOST_USER_MAX_RAM_SLOTS 32
 
 typedef enum VhostSetConfigType {
     VHOST_SET_CONFIG_TYPE_MASTER = 0,
@@ -55,6 +61,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
+    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -123,7 +130,7 @@ typedef struct VhostUserMemoryRegion {
 typedef struct VhostUserMemory {
     uint32_t nregions;
     uint32_t padding;
-    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
+    VhostUserMemoryRegion regions[VHOST_MEMORY_BASELINE_NREGIONS];
 } VhostUserMemory;
 
 typedef struct VhostUserMemRegMsg {
@@ -190,7 +197,7 @@ typedef struct VhostUserMsg {
         VhostUserInflight inflight;
     } payload;
 
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     int fd_num;
     uint8_t *data;
 } VU_PACKED VhostUserMsg;
@@ -368,7 +375,7 @@ typedef struct VuDevInflightInfo {
 struct VuDev {
     int sock;
     uint32_t nregions;
-    VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
+    VuDevRegion regions[VHOST_USER_MAX_RAM_SLOTS];
     VuVirtq *vq;
     VuDevInflightInfo inflight_info;
     int log_call_fd;
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 386449b697..b1e607298c 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -269,7 +269,7 @@ have_userfault(void)
 static bool
 vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
-    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] = { };
+    char control[CMSG_SPACE(VHOST_MEMORY_BASELINE_NREGIONS * sizeof(int))] = {};
     struct iovec iov = {
         .iov_base = (char *)vmsg,
         .iov_len = VHOST_USER_HDR_SIZE,
@@ -340,7 +340,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
     int rc;
     uint8_t *p = (uint8_t *)vmsg;
-    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] = { };
+    char control[CMSG_SPACE(VHOST_MEMORY_BASELINE_NREGIONS * sizeof(int))] = {};
     struct iovec iov = {
         .iov_base = (char *)vmsg,
         .iov_len = VHOST_USER_HDR_SIZE,
@@ -353,7 +353,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
     struct cmsghdr *cmsg;
 
     memset(control, 0, sizeof(control));
-    assert(vmsg->fd_num <= VHOST_MEMORY_MAX_NREGIONS);
+    assert(vmsg->fd_num <= VHOST_MEMORY_BASELINE_NREGIONS);
     if (vmsg->fd_num > 0) {
         size_t fdsize = vmsg->fd_num * sizeof(int);
         msg.msg_controllen = CMSG_SPACE(fdsize);
@@ -780,7 +780,7 @@ static bool
 vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     int i, j;
     bool found = false;
-    VuDevRegion shadow_regions[VHOST_MEMORY_MAX_NREGIONS] = {};
+    VuDevRegion shadow_regions[VHOST_USER_MAX_RAM_SLOTS] = {};
     VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
 
     DPRINT("Removing region:\n");
@@ -813,7 +813,7 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
 
     if (found) {
         memcpy(dev->regions, shadow_regions,
-               sizeof(VuDevRegion) * VHOST_MEMORY_MAX_NREGIONS);
+               sizeof(VuDevRegion) * VHOST_USER_MAX_RAM_SLOTS);
         DPRINT("Successfully removed a region\n");
         dev->nregions--;
         vmsg_set_reply_u64(vmsg, 0);
@@ -1394,7 +1394,8 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
                         1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ |
                         1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER |
                         1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD |
-                        1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK;
+                        1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK |
+                        1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS;
 
     if (have_userfault()) {
         features |= 1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT;
@@ -1732,14 +1733,14 @@ static bool vu_handle_get_max_memslots(VuDev *dev, VhostUserMsg *vmsg)
 {
     vmsg->flags = VHOST_USER_REPLY_MASK | VHOST_USER_VERSION;
     vmsg->size  = sizeof(vmsg->payload.u64);
-    vmsg->payload.u64 = VHOST_MEMORY_MAX_NREGIONS;
+    vmsg->payload.u64 = VHOST_USER_MAX_RAM_SLOTS;
     vmsg->fd_num = 0;
 
     if (!vu_message_write(dev, dev->sock, vmsg)) {
         vu_panic(dev, "Failed to send max ram slots: %s\n", strerror(errno));
     }
 
-    DPRINT("u64: 0x%016"PRIx64"\n", (uint64_t) VHOST_MEMORY_MAX_NREGIONS);
+    DPRINT("u64: 0x%016"PRIx64"\n", (uint64_t) VHOST_USER_MAX_RAM_SLOTS);
 
     return false;
 }
-- 
MST


