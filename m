Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E579C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BE221556
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ErQp/ru1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BE221556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQJi-0000vE-Nx
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnj-0002J8-SI; Tue, 27 Oct 2020 10:18:17 -0400
Received: from ozlabs.org ([203.11.71.1]:40093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnh-0007d7-0v; Tue, 27 Oct 2020 10:18:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLt1Qt0z9sj3; Wed, 28 Oct 2020 01:17:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808278;
 bh=iYQRi/tNG112bmgF4xqQ7eKKIeFdgRePVgkns9RLLKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ErQp/ru1Of/fHE4PD6Xv4YL2DI33SJhLg7Jc2WQsqNnnaMDKp1QfdNRGxw9lNzU7O
 LaB+8gob81bBNVqjmQFIOVVwkCkfPilbnsvx8Nb+0L36LDtHrV7RiS8U5b46Ovfu3r
 kHAx3VBIL+RGbcYrof6b0VmdNIjuvoUKJM/RENEU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 16/18] target/ppc: Fix kvmppc_load_htab_chunk() error reporting
Date: Wed, 28 Oct 2020 01:17:33 +1100
Message-Id: <20201027141735.728821-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:17:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

If kvmppc_load_htab_chunk() fails, its return value is propagated up
to vmstate_load(). It should thus be a negative errno, not -1 (which
maps to EPERM and would lure the user into thinking that the problem
is necessarily related to a lack of privilege).

Return the error reported by KVM or ENOSPC in case of short write.
While here, propagate the error message through an @errp argument
and have the caller to print it with error_report_err() instead
of relying on fprintf().

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160371604713.305923.5264900354159029580.stgit@bahia.lan>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       |  4 +++-
 target/ppc/kvm.c     | 11 +++++------
 target/ppc/kvm_ppc.h |  5 +++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ba0894e73a..ec2536dba1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2347,8 +2347,10 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
 
             assert(fd >= 0);
 
-            rc = kvmppc_load_htab_chunk(f, fd, index, n_valid, n_invalid);
+            rc = kvmppc_load_htab_chunk(f, fd, index, n_valid, n_invalid,
+                                        &local_err);
             if (rc < 0) {
+                error_report_err(local_err);
                 return rc;
             }
         }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d85ba8ffe0..0223b93ea5 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2683,7 +2683,7 @@ int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns)
 }
 
 int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
-                           uint16_t n_valid, uint16_t n_invalid)
+                           uint16_t n_valid, uint16_t n_invalid, Error **errp)
 {
     struct kvm_get_htab_header *buf;
     size_t chunksize = sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
@@ -2698,14 +2698,13 @@ int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
 
     rc = write(fd, buf, chunksize);
     if (rc < 0) {
-        fprintf(stderr, "Error writing KVM hash table: %s\n",
-                strerror(errno));
-        return rc;
+        error_setg_errno(errp, errno, "Error writing the KVM hash table");
+        return -errno;
     }
     if (rc != chunksize) {
         /* We should never get a short write on a single chunk */
-        fprintf(stderr, "Short write, restoring KVM hash table\n");
-        return -1;
+        error_setg(errp, "Short write while restoring the KVM hash table");
+        return -ENOSPC;
     }
     return 0;
 }
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 72e05f1cd2..73ce2bc951 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -56,7 +56,7 @@ int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
 int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp);
 int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns);
 int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
-                           uint16_t n_valid, uint16_t n_invalid);
+                           uint16_t n_valid, uint16_t n_invalid, Error **errp);
 void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n);
 void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1);
 bool kvmppc_has_cap_fixup_hcalls(void);
@@ -316,7 +316,8 @@ static inline int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize,
 }
 
 static inline int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
-                                         uint16_t n_valid, uint16_t n_invalid)
+                                         uint16_t n_valid, uint16_t n_invalid,
+                                         Error **errp)
 {
     abort();
 }
-- 
2.26.2


