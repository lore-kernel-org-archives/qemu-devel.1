Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA41C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0F820835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6MtViu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0F820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlKn-0008Bf-2O
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl37-0000TQ-By
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl35-0001Zz-8O
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ZfvYRjYmGPxNT0fOPfO9sBNQzeK+Gxo9SoF7dTSLww=;
 b=i6MtViu3aH1bdqI++M2fTrcfwYFqmTsMFHtmlBTl3UCvxX0NtXtfsq2NRDMsGdI2TkQVb+
 R0Ld+/MUOlnftKh9u2TU0DCR61shtHSmkgKR2mbfqtBYFPcm4o4W8jLapcrs7JovHrR8LW
 zlKQTE72tXXieEc5JWiOrFdPwQcwfwQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-vXICXpsROg-EMQxw7jBclA-1; Fri, 12 Jun 2020 10:52:45 -0400
X-MC-Unique: vXICXpsROg-EMQxw7jBclA-1
Received: by mail-wm1-f71.google.com with SMTP id b63so3878202wme.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/ZfvYRjYmGPxNT0fOPfO9sBNQzeK+Gxo9SoF7dTSLww=;
 b=ZErFvFglDjC8Od+IKbFwpbm2rydDnrP/u6oVT3AvMYOKJeZaAXFB9m7cFBERmYw6P+
 qGRjbITKnfIbOtc9BwChsxT4p0H+lry4OTgf/eOrlw5GzcW8vDL+Za7wJVGiDVVQBk5X
 9iuga/BJ3J89sGicAVjY878drCOcz8jAjAo1vBDpoO5YNi4X2wgxTofEZm4O7oNwLHH8
 hmDMLga3QeYGy/h0W00fYZO2nukI7L2qQeu0UW+xUtuCb6UjfP5Y+tUxCvez8i3KqeNN
 8biBsP7VGg2GojaCywjQerW2vl4Fkce3rVFwb5aRMCDvM5se4xW3g15i8wXYTdqlwFpt
 tEIQ==
X-Gm-Message-State: AOAM530GPcUkwwPtfCWqYiw6ltfcNNgXNcp4Qmv6uxXAvNRoSaQ45Jp7
 2ZEBKUeb6K4riZnnK7cNZmzdGhI0gNf+6LeQPUzm75RiJPES1Jd4ckl1C4xcjQ8F3HwYoQMpVKl
 dfBKtfJuy9u+CbM0=
X-Received: by 2002:a1c:4009:: with SMTP id n9mr13904814wma.104.1591973563889; 
 Fri, 12 Jun 2020 07:52:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjLc0FcSoGpqNZ+8JaAgf5fjgVSv9uitAS1v95SMV89ijiX3CU2GAltlksjBA6mWZD5jhPDg==
X-Received: by 2002:a1c:4009:: with SMTP id n9mr13904795wma.104.1591973563664; 
 Fri, 12 Jun 2020 07:52:43 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id b81sm9781926wmc.5.2020.06.12.07.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:43 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 45/58] Lift max ram slots limit in libvhost-user
Message-ID: <20200612141917.9446-46-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
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


