Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0EBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0093207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0093207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1s6-0003NJ-Ta
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX1o2-0007bC-Ry
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:40:59 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:43030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX1nz-0007Sb-2p
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:40:58 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-RpLFQiOWOyuxOy1thYqQ_g-1; Mon, 26 Oct 2020 08:40:50 -0400
X-MC-Unique: RpLFQiOWOyuxOy1thYqQ_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750D05AED2;
 Mon, 26 Oct 2020 12:40:49 +0000 (UTC)
Received: from bahia.lan (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F4185DC1B;
 Mon, 26 Oct 2020 12:40:47 +0000 (UTC)
Subject: [PATCH 3/4] target/ppc: Fix kvmppc_load_htab_chunk() error reporting
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 26 Oct 2020 13:40:47 +0100
Message-ID: <160371604713.305923.5264900354159029580.stgit@bahia.lan>
In-Reply-To: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 08:40:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If kvmppc_load_htab_chunk() fails, its return value is propagated up
to vmstate_load(). It should thus be a negative errno, not -1 (which
maps to EPERM and would lure the user into thinking that the problem
is necessarily related to a lack of privilege).

Return the error reported by KVM or ENOSPC in case of short write.
While here, propagate the error message through an @errp argument
and have the caller to print it with error_report_err() instead
of relying on fprintf().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c       |    4 +++-
 target/ppc/kvm.c     |   11 +++++------
 target/ppc/kvm_ppc.h |    5 +++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f51b663f7dcb..ff7de7da2875 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2341,8 +2341,10 @@ static int htab_load(QEMUFile *f, void *opaque, int =
version_id)
=20
             assert(fd >=3D 0);
=20
-            rc =3D kvmppc_load_htab_chunk(f, fd, index, n_valid, n_invalid=
);
+            rc =3D kvmppc_load_htab_chunk(f, fd, index, n_valid, n_invalid=
,
+                                        &local_err);
             if (rc < 0) {
+                error_report_err(local_err);
                 return rc;
             }
         }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d85ba8ffe00b..0223b93ea561 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2683,7 +2683,7 @@ int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufs=
ize, int64_t max_ns)
 }
=20
 int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
-                           uint16_t n_valid, uint16_t n_invalid)
+                           uint16_t n_valid, uint16_t n_invalid, Error **e=
rrp)
 {
     struct kvm_get_htab_header *buf;
     size_t chunksize =3D sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
@@ -2698,14 +2698,13 @@ int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uin=
t32_t index,
=20
     rc =3D write(fd, buf, chunksize);
     if (rc < 0) {
-        fprintf(stderr, "Error writing KVM hash table: %s\n",
-                strerror(errno));
-        return rc;
+        error_setg_errno(errp, errno, "Error writing the KVM hash table");
+        return -errno;
     }
     if (rc !=3D chunksize) {
         /* We should never get a short write on a single chunk */
-        fprintf(stderr, "Short write, restoring KVM hash table\n");
-        return -1;
+        error_setg(errp, "Short write while restoring the KVM hash table")=
;
+        return -ENOSPC;
     }
     return 0;
 }
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 72e05f1cd2fc..73ce2bc95114 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -56,7 +56,7 @@ int kvmppc_define_rtas_kernel_token(uint32_t token, const=
 char *function);
 int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp);
 int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns);
 int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
-                           uint16_t n_valid, uint16_t n_invalid);
+                           uint16_t n_valid, uint16_t n_invalid, Error **e=
rrp);
 void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n);
 void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1);
 bool kvmppc_has_cap_fixup_hcalls(void);
@@ -316,7 +316,8 @@ static inline int kvmppc_save_htab(QEMUFile *f, int fd,=
 size_t bufsize,
 }
=20
 static inline int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t ind=
ex,
-                                         uint16_t n_valid, uint16_t n_inva=
lid)
+                                         uint16_t n_valid, uint16_t n_inva=
lid,
+                                         Error **errp)
 {
     abort();
 }



