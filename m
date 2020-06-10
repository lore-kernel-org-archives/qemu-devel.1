Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91D1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25672072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4vzsjAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25672072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisng-0001Ov-SF
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLa-0001VH-A8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29997
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLZ-0008MU-6k
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/61PXreG9CtbL2ch+1GsTIa5m/Lv2qjj0nnVUy3KBs8=;
 b=H4vzsjAWkp9pLihSuBvLjxg22JkPaEANj7d3cdyGYtHBzL2H5E8asIoR7O1KgFkD5i4D4L
 PxJAc9g2M2BrGhlw2a3O2c6opXSoMBU3449cAp3isZMSQi51t2IJz8Pw/TK44jggQPfO8S
 DIoYWVgYKvWQBqTUOZgELKES8i0OibQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-JkYzOIovP9-gMwoeiGeTEw-1; Wed, 10 Jun 2020 00:28:14 -0400
X-MC-Unique: JkYzOIovP9-gMwoeiGeTEw-1
Received: by mail-wm1-f70.google.com with SMTP id x6so86975wmj.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/61PXreG9CtbL2ch+1GsTIa5m/Lv2qjj0nnVUy3KBs8=;
 b=rYiZ9BL3NABuT58ugOIOFgyeqSEcZ2EE0oZIrHvyHNanV1URWZORQTkDZ6+iv6Op8e
 vEPjABFz4+qI7qMCEdNPpyYjdWh/rY0RzQFa8LC9BnGzGrEf/SGCjkIYjVB2aCLHkNKF
 xRdPXAKLqK7p1YB7ivYTUDYZEPUSbh6sJOoXLDe8xlRob4o42LGYYDChVRKvfgj31rrB
 V6+U7S4sRnyWgjjfaq759cv8s0GkxLbP6LBVVbz95aYuGA4Hkv+c68jDPKSQfMlpom0I
 nHxJjBZpURG2wts2B3mTDNCCUTrYPdCC6UMbK7G8ZE5zrXAYDist+VY+TXRoF92kAXhy
 jAOA==
X-Gm-Message-State: AOAM531Bv/qG6CDvRWwOvmBXDTwXcY9em5MgVcQdWdNTDpr/zzUCFMMK
 KPvCZ+eDx5iP2H1CTKiWTA8cxF3P/GArvqAzccjp7hYB+nAjI3Vq6T7lUG43Ry05vq/IyfPXt3O
 OIcww2Bjd0ollaxg=
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr1290959wru.15.1591763293290;
 Tue, 09 Jun 2020 21:28:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoI0BCIMIA7Qn+cDeCy+2+S6jfdff3ksThVNues6g7z4bsQeuWuKZkMfWUssb49z4e4xqUhQ==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr1290940wru.15.1591763293093;
 Tue, 09 Jun 2020 21:28:13 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id r2sm6307143wrg.68.2020.06.09.21.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:12 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/56] Support individual region unmap in libvhost-user
Message-ID: <20200610042613.1459309-45-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
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
 Johannes Berg <johannes.berg@intel.com>, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
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


