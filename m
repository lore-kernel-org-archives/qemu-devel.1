Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93DCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBE7206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhHMdQRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBE7206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEdO-0001wZ-SJ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUD-0000sv-TO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20260
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUB-0001gX-Qb
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdpySV97K79Gyh8zeUujKQRFRgwzwS9j5RkITL/a4rs=;
 b=IhHMdQRyfg0yKudBZbrIjxA/OKFgD156iHX2KLOBwWxKxrYWYstGoMQzzbZWD7edQiXq75
 9nzzVyscmiyRv6yRODJcIGugUxbhJlw/YbXqVUzR8qBj/zPz11pyEOryo1jVut5cAQwlcN
 ACf9iivoRZzrBZxXcVkZSCx4wIuu9Nc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-FWuq9w9sN5yCtCdNgf7K5g-1; Wed, 24 Jun 2020 19:07:14 -0400
X-MC-Unique: FWuq9w9sN5yCtCdNgf7K5g-1
Received: by mail-wr1-f69.google.com with SMTP id a18so4704504wrm.14
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MdpySV97K79Gyh8zeUujKQRFRgwzwS9j5RkITL/a4rs=;
 b=RWxLs1Hbsd/5kdikz++wfKntjd5aRddU+l5FYzD8Gx0kKaZKTr969ae2S+NfyW31lc
 VoInTemXXkZNukQgizvJj+XbLVfwQWwhYJ7MMoiqGTZ9yvcKuaWf5QjZEhGEQFa8ddNV
 uKbAut5R/GKoSRa1M+k7uh2zuFYEtH3e4Evrd0jTMm99SbLhZsGFgX5D00tjlDPKqZoK
 poy2/pk6yLulOUkGJDKoF06Z9kmzdyHTIIJCJTW1jjx7VGtVbRDNqvgP1RJU9BnOgISG
 Qz/7QW8V62Ja5MLmcyq3ujo2ckHWqBw/dE7tP0+inq+/AbMpZskIarlKN7jMpMeTwYFS
 +0bA==
X-Gm-Message-State: AOAM530rWoS8QC655HxioaROCq4/LP98KBCYKtXuOKWvw5Mgi/uZtrcz
 yznMR405R2rCyk5g/BJEqz9sAnwGUqjqB5oSaqRqleBuoRNwWK0c4RqjuY9FcdNaHgzunfTiZpX
 Z2h/8ik8iC+stKQI=
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr115014wme.152.1593040032685; 
 Wed, 24 Jun 2020 16:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTRFDDBThaWTuJAY59AlbPE0ZSyPfdvKebKQSOi4xN/awIUuLly0594cjWVF9MndH6JPfNZg==
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr115002wme.152.1593040032495; 
 Wed, 24 Jun 2020 16:07:12 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 y19sm9316412wmi.6.2020.06.24.16.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:07:11 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:07:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/19] Stop vhost-user sending uninitialized mmap_offsets
Message-ID: <20200624230609.703104-17-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

Prior to this change, the vhost_user_fill_msg_region function filled out
all elements of the VhostUserMemoryRegion struct except the mmap_offset.

This function is often called on uninitialized structs, which are then
copied into VHOST_USER_SET_MEM_TABLE and VHOST_USER_ADD/REM_MEM_REG
messages. In some cases, where the mmap_offset was not needed, it was
left uninitialized, causing QEMU to send the backend uninitialized data,
which Coverity flagged as a series of issues.

This change augments the vhost_user_fill_msg_region API, adding a
mmap_offset paramenter, forcing the caller to initialize mmap_offset.

Fixes: ece99091c2d0aeb23734289a50ef2ff4e0a08929
Fixes: f1aeb14b0809e313c74244d838645ed25e85ea63
Reported-by: Coverity (CIDs 1429802, 1429803 and 1429804)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1592650156-25845-1-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/vhost-user.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 4d6cd4e58a..31231218dc 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -460,12 +460,14 @@ static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *offset,
 }
 
 static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
-                                       struct vhost_memory_region *src)
+                                       struct vhost_memory_region *src,
+                                       uint64_t mmap_offset)
 {
     assert(src != NULL && dst != NULL);
     dst->userspace_addr = src->userspace_addr;
     dst->memory_size = src->memory_size;
     dst->guest_phys_addr = src->guest_phys_addr;
+    dst->mmap_offset = mmap_offset;
 }
 
 static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
@@ -500,9 +502,8 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                 error_report("Failed preparing vhost-user memory table msg");
                 return -1;
             }
-            vhost_user_fill_msg_region(&region_buffer, reg);
+            vhost_user_fill_msg_region(&region_buffer, reg, offset);
             msg->payload.memory.regions[*fd_num] = region_buffer;
-            msg->payload.memory.regions[*fd_num].mmap_offset = offset;
             fds[(*fd_num)++] = fd;
         } else if (track_ramblocks) {
             u->region_rb_offset[i] = 0;
@@ -649,7 +650,7 @@ static int send_remove_regions(struct vhost_dev *dev,
 
         if (fd > 0) {
             msg->hdr.request = VHOST_USER_REM_MEM_REG;
-            vhost_user_fill_msg_region(&region_buffer, shadow_reg);
+            vhost_user_fill_msg_region(&region_buffer, shadow_reg, 0);
             msg->payload.mem_reg.region = region_buffer;
 
             if (vhost_user_write(dev, msg, &fd, 1) < 0) {
@@ -709,9 +710,8 @@ static int send_add_regions(struct vhost_dev *dev,
                 u->region_rb[reg_idx] = mr->ram_block;
             }
             msg->hdr.request = VHOST_USER_ADD_MEM_REG;
-            vhost_user_fill_msg_region(&region_buffer, reg);
+            vhost_user_fill_msg_region(&region_buffer, reg, offset);
             msg->payload.mem_reg.region = region_buffer;
-            msg->payload.mem_reg.region.mmap_offset = offset;
 
             if (vhost_user_write(dev, msg, &fd, 1) < 0) {
                 return -1;
-- 
MST


