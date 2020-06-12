Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C62C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492E02081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7wH69Hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492E02081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlIh-0003zZ-Ho
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl31-0000EU-0u
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39563
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2z-0001Yv-5o
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/61PXreG9CtbL2ch+1GsTIa5m/Lv2qjj0nnVUy3KBs8=;
 b=g7wH69HgjG+0aDwCr+7Pk9x+M6YgE3khimSXeLrNuTYyQGe4qO25Qrdou6FHeJyr7sUN8I
 E3CB0torDjkUznT4pQvmsHbjQxU6KJiacZnGBeF0OOrP/bAALLOHmHEKMLcbcd6j1BXY+Z
 eVnWO5PAjKhIEIxVJgILi/aRrvd9h7c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491--LDxGG3HNGOhkejuAnIOZw-1; Fri, 12 Jun 2020 10:52:42 -0400
X-MC-Unique: -LDxGG3HNGOhkejuAnIOZw-1
Received: by mail-wr1-f72.google.com with SMTP id c14so3980161wrm.15
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/61PXreG9CtbL2ch+1GsTIa5m/Lv2qjj0nnVUy3KBs8=;
 b=O44+Z3DaBDnowsY5/T8z1aHVPZ3uphMm1OIv2cz9I8dkm0eufYn+lOSNQ4k3Tn54mV
 ZXUMHTLxSN0wlBlSFhNkn5ByQ5HkMJq9RiiCJVQ52tZwxJjlw8tp9PALalzye4JCIg6x
 +Qp6mP4C8Ho4/Pix3nljme+Hi4f6WuxSnDWIU3v/ox8LUGrnaFo6d5h81rio5JzwRfxV
 ooLEyMrBDFJjvc2G2TwwUjeLVN/C3Ts2LUM2Ftlav3Vg2/9MBDOtMUPxksmGT2l22/80
 Kp6PJB4lo0FEyvePHYA+ZpBx7AH2oFbSyM50ifk/F4hQeA/95TP3oEoijsStnjrBlstm
 nR8A==
X-Gm-Message-State: AOAM5308bJcAGUbHxfWKHrrGb3joUrI1UDpX3AsJZNSzc1MI0RXnXLjJ
 WrmJD5fx/dVauCbHIk0yW27BmKygXCbiFfuHdS6N6WRIHtFhvJIjPfH5JblQkOjLbAvB1lUCmXK
 ZLSYjJ5gCUO9rEaQ=
X-Received: by 2002:a1c:2c45:: with SMTP id s66mr14424576wms.40.1591973561589; 
 Fri, 12 Jun 2020 07:52:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDb7wtsbBKIK5Jby1Kz+peKBBPvIuXhdZpDu8O1dmNK/046yiLgjeKRP3cDXIMFk5FsxzhxA==
X-Received: by 2002:a1c:2c45:: with SMTP id s66mr14424561wms.40.1591973561357; 
 Fri, 12 Jun 2020 07:52:41 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id t7sm9674317wrq.41.2020.06.12.07.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:40 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 44/58] Support individual region unmap in libvhost-user
Message-ID: <20200612141917.9446-45-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

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
Message-Id: <1588533678-23450-10-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 contrib/libvhost-user/libvhost-user.c | 63 +++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 60ef7fd13e..f8439713a8 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -99,6 +99,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_VRING_KICK = 35,
     VHOST_USER_GET_MAX_MEM_SLOTS = 36,
     VHOST_USER_ADD_MEM_REG = 37,
+    VHOST_USER_REM_MEM_REG = 38,
     VHOST_USER_MAX
 } VhostUserRequest;
 
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index d8ee7a23a3..386449b697 100644
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
+    VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
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
-- 
MST


