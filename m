Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFF7C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1BC20848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1BC20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B0I-0004Wh-B7
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2AxB-0006zY-WD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2AxA-0005Dj-Tm
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2777 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2AxA-00051U-I6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:36 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CD6209BCF9EC61BBFD07;
 Thu, 13 Feb 2020 17:38:20 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:12 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 08/14] migration/rdma: Add the function for dynamic page
 registration
Date: Thu, 13 Feb 2020 17:37:49 +0800
Message-ID: <20200213093755.370-9-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20200213093755.370-1-fengzhimin1@huawei.com>
References: <20200213093755.370-1-fengzhimin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: jemmy858585@gmail.com, Zhimin Feng <fengzhimin1@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the 'qemu_rdma_registration' function,
multifd send threads call it to register memory.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/rdma.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/rdma.h |  1 +
 2 files changed, 52 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 23f7f525f4..19a238be30 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3471,6 +3471,57 @@ out:
     return ret;
 }
=20
+/*
+ * Dynamic page registrations for multifd RDMA threads.
+ */
+int qemu_rdma_registration(void *opaque)
+{
+    RDMAContext *rdma =3D opaque;
+    RDMAControlHeader resp =3D {.type =3D RDMA_CONTROL_RAM_BLOCKS_RESULT=
 };
+    RDMALocalBlocks *local =3D &rdma->local_ram_blocks;
+    int reg_result_idx, i, nb_dest_blocks;
+    RDMAControlHeader head =3D { .len =3D 0, .repeat =3D 1 };
+    int ret =3D 0;
+
+    head.type =3D RDMA_CONTROL_RAM_BLOCKS_REQUEST;
+
+    ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, &resp,
+            &reg_result_idx, rdma->pin_all ?
+            qemu_rdma_reg_whole_ram_blocks : NULL);
+    if (ret < 0) {
+        goto out;
+    }
+
+    nb_dest_blocks =3D resp.len / sizeof(RDMADestBlock);
+
+    if (local->nb_blocks !=3D nb_dest_blocks) {
+        rdma->error_state =3D -EINVAL;
+        ret =3D -1;
+        goto out;
+    }
+
+    qemu_rdma_move_header(rdma, reg_result_idx, &resp);
+    memcpy(rdma->dest_blocks,
+           rdma->wr_data[reg_result_idx].control_curr, resp.len);
+
+    for (i =3D 0; i < nb_dest_blocks; i++) {
+        network_to_dest_block(&rdma->dest_blocks[i]);
+
+        /* We require that the blocks are in the same order */
+        if (rdma->dest_blocks[i].length !=3D local->block[i].length) {
+            rdma->error_state =3D -EINVAL;
+            ret =3D -1;
+            goto out;
+        }
+        local->block[i].remote_host_addr =3D
+            rdma->dest_blocks[i].remote_host_addr;
+        local->block[i].remote_rkey =3D rdma->dest_blocks[i].remote_rkey=
;
+    }
+
+out:
+    return ret;
+}
+
 /* Destination:
  * Called via a ram_control_load_hook during the initial RAM load sectio=
n which
  * lists the RAMBlocks by name.  This lets us know the order of the RAMB=
locks
diff --git a/migration/rdma.h b/migration/rdma.h
index 8e1a6edf57..86c89bdd1f 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -280,6 +280,7 @@ int qemu_rdma_exchange_send(RDMAContext *rdma, RDMACo=
ntrolHeader *head,
                             uint8_t *data, RDMAControlHeader *resp,
                             int *resp_idx,
                             int (*callback)(RDMAContext *rdma));
+int qemu_rdma_registration(void *opaque);
=20
 void rdma_start_outgoing_migration(void *opaque, const char *host_port,
                                    Error **errp);
--=20
2.19.1



