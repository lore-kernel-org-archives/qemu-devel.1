Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62931C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4356238E6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4356238E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1pD-0000JC-Ob
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX1nk-0007CC-HP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:40:40 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:36444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX1nj-0007Jk-0C
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:40:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-eEJOh1uuPHytZkRxe4FZ6g-1; Mon, 26 Oct 2020 08:40:36 -0400
X-MC-Unique: eEJOh1uuPHytZkRxe4FZ6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FF6A5720C;
 Mon, 26 Oct 2020 12:40:35 +0000 (UTC)
Received: from bahia.lan (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE3219D7D;
 Mon, 26 Oct 2020 12:40:34 +0000 (UTC)
Subject: [PATCH 1/4] spapr: qemu_memalign() doesn't return NULL
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 26 Oct 2020 13:40:33 +0100
Message-ID: <160371603337.305923.17158585537944509438.stgit@bahia.lan>
In-Reply-To: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

qemu_memalign() aborts if OOM. Drop some dead code.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c       |    6 ------
 hw/ppc/spapr_hcall.c |    8 ++------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0cc19b5863a4..f098d0ee6d98 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1521,12 +1521,6 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, =
int shift,
         int i;
=20
         spapr->htab =3D qemu_memalign(size, size);
-        if (!spapr->htab) {
-            error_setg_errno(errp, errno,
-                             "Could not allocate HPT of order %d", shift);
-            return;
-        }
-
         memset(spapr->htab, 0, size);
         spapr->htab_shift =3D shift;
=20
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 607740150fa2..34e146f628fb 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -361,12 +361,8 @@ static void *hpt_prepare_thread(void *opaque)
     size_t size =3D 1ULL << pending->shift;
=20
     pending->hpt =3D qemu_memalign(size, size);
-    if (pending->hpt) {
-        memset(pending->hpt, 0, size);
-        pending->ret =3D H_SUCCESS;
-    } else {
-        pending->ret =3D H_NO_MEM;
-    }
+    memset(pending->hpt, 0, size);
+    pending->ret =3D H_SUCCESS;
=20
     qemu_mutex_lock_iothread();
=20



