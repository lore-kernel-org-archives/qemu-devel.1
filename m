Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2346C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F148217F5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9QxXKom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F148217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMfz-0008NG-J1
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1iSMel-00073x-V5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1iSMek-000422-N3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:51:35 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1iSMek-00041b-H8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:51:34 -0500
Received: by mail-wm1-x343.google.com with SMTP id b11so860643wmb.5
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VoLJFtEIkSYy1clLkMnJOf/MQB43jYk2R2juAnJ5n0w=;
 b=G9QxXKomPNS7jxfHk2I1SAdPxK9GQNCkXwJ3rk8FXbQiQrd7a0XnDqN6+Rp0Kt6iO1
 JPf2pVXpJJg1eQ67b0RovLOGBWpJKMhrXzAzRLI+9RL5KfSPQSSMwir0WlAYQ4MMtQLD
 k0BGGjtB4R0XAk8WA9I0Jay3Yt+mhZJd94smkrqD7oZXR+IbXn7qYm3wQMgkwP3fp4rO
 +PG+PGRzszw4KzFVsffkqcVTPboZiqHKl5PfKf1NBvHVqhYTAFyso1vkbMimyQbBMe1l
 ph3hNkPf4RkrHj1vWLNkMwhc7GHdx1xEGhm0L4Jn6oxp6A19gw29Qau1VnG9oHGdSGlq
 FOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VoLJFtEIkSYy1clLkMnJOf/MQB43jYk2R2juAnJ5n0w=;
 b=K0gSnP/gg/knzFLdRyXtGD8hohzWJAok2nmaamMF157ut7zt7g2Kc4C4UwBU11JURc
 3I3D40GR7tWU49IPgacBznRMi5VVcYwOEFz+5pqr40m9MrtQGZC02SzXiyFl85ZxoAyq
 1Z1GrDGPdA7TUpLs4bU0he9PeHql0H/8Wviyx4ylffyPHXaYLo/mTLybaFAKEvzAy9ds
 Kyx7emNFc5hn8tiHlXi6Umuc0hbFF/+OX31+m0q74JSbQ6ZGXPvA3SbIrY6ZopvKVX0r
 qzxN506+CTlLXSnymmWP2I8dTaZxBFzOQagyIvj8IZcQqujyDo+sz+dH5+RlG4ZlYrRt
 x68w==
X-Gm-Message-State: APjAAAXcQunalaDtPw6kMMPQovxpW+y3Be6AdPrtBfS9bmLdRf0fzM05
 hjK9HlMiCQiVNStN4anBQ9NttErh
X-Google-Smtp-Source: APXvYqy2JezJHv7u6TmYsgez7AFeOhqSL6obEDXoCk3ulDNBdzjZUFxxh2/taAnKO540E+pmFHdBbA==
X-Received: by 2002:a1c:cc16:: with SMTP id h22mr3067861wmb.51.1573051892958; 
 Wed, 06 Nov 2019 06:51:32 -0800 (PST)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id t133sm3116744wmb.1.2019.11.06.06.51.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Nov 2019 06:51:32 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [Qemu-devel] [PATCH PULL 2/2] hw/rdma: Utilize ibv_reg_mr_iova for
 memory registration
Date: Wed,  6 Nov 2019 16:51:27 +0200
Message-Id: <20191106145127.23700-3-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191106145127.23700-1-marcel.apfelbaum@gmail.com>
References: <20191106145127.23700-1-marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: yuval.shaia@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuval Shaia <yuval.shaia@oracle.com>

The virtual address that is provided by the guest in post_send and
post_recv operations is related to the guest address space. This address
space is unknown to the HCA resides on host so extra step in these
operations is needed to adjust the address to host virtual address.

This step, which is done in data-path affects performances.

An enhanced verion of MR registration introduced here
https://patchwork.kernel.org/patch/11044467/ can be used so that the
guest virtual address space for this MR is known to the HCA in host.

This will save the data-path adjustment.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20190818132107.18181-3-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c    | 13 +++++++++++++
 hw/rdma/rdma_backend.h    |  5 +++++
 hw/rdma/rdma_rm.c         |  5 +++++
 hw/rdma/vmw/pvrdma_main.c |  6 ++++++
 4 files changed, 29 insertions(+)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c39051068d..c346407cd3 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -391,7 +391,11 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
             return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
         }
 
+#ifdef LEGACY_RDMA_REG_MR
         dsge->addr = (uintptr_t)mr->virt + ssge[ssge_idx].addr - mr->start;
+#else
+        dsge->addr = ssge[ssge_idx].addr;
+#endif
         dsge->length = ssge[ssge_idx].length;
         dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
 
@@ -735,10 +739,19 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
     }
 }
 
+#ifdef LEGACY_RDMA_REG_MR
 int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
                            size_t length, int access)
+#else
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
+                           size_t length, uint64_t guest_start, int access)
+#endif
 {
+#ifdef LEGACY_RDMA_REG_MR
     mr->ibmr = ibv_reg_mr(pd->ibpd, addr, length, access);
+#else
+    mr->ibmr = ibv_reg_mr_iova(pd->ibpd, addr, length, guest_start, access);
+#endif
     if (!mr->ibmr) {
         rdma_error_report("ibv_reg_mr fail, errno=%d", errno);
         return -EIO;
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 7c1a19a2b5..127f96e2d5 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -78,8 +78,13 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
 int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd);
 void rdma_backend_destroy_pd(RdmaBackendPD *pd);
 
+#ifdef LEGACY_RDMA_REG_MR
 int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
                            size_t length, int access);
+#else
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
+                           size_t length, uint64_t guest_start, int access);
+#endif
 void rdma_backend_destroy_mr(RdmaBackendMR *mr);
 
 int rdma_backend_create_cq(RdmaBackendDev *backend_dev, RdmaBackendCQ *cq,
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 1927f85472..1524dfaeaa 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -227,8 +227,13 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
         mr->length = guest_length;
         mr->virt += (mr->start & (TARGET_PAGE_SIZE - 1));
 
+#ifdef LEGACY_RDMA_REG_MR
         ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
                                      mr->length, access_flags);
+#else
+        ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
+                                     mr->length, guest_start, access_flags);
+#endif
         if (ret) {
             ret = -EIO;
             goto out_dealloc_mr;
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 3722d9e772..6f0fc405c7 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -664,6 +664,12 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
     qemu_register_shutdown_notifier(&dev->shutdown_notifier);
 
+#ifdef LEGACY_RDMA_REG_MR
+    rdma_info_report("Using legacy reg_mr");
+#else
+    rdma_info_report("Using iova reg_mr");
+#endif
+
 out:
     if (rc) {
         pvrdma_fini(pdev);
-- 
2.17.2


