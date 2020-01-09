Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB7C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7A120673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7A120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUdb-0007tA-Gb
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvE-00010N-5w
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvC-0001Nw-63
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34924 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPvB-0001Gt-Fg
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:50 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E03C13A71F11B0D96E00;
 Thu,  9 Jan 2020 12:59:45 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:37 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 11/12] migration/rdma: use multiRDMA to send RAM block for
 NOT rdma-pin-all mode
Date: Thu, 9 Jan 2020 12:59:21 +0800
Message-ID: <20200109045922.904-12-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20200109045922.904-1-fengzhimin1@huawei.com>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
X-Mailman-Approved-At: Thu, 09 Jan 2020 04:56:54 -0500
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
Cc: jemmy858585@gmail.com, fengzhimin <fengzhimin1@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fengzhimin <fengzhimin1@huawei.com>

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/rdma.c | 109 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 4 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 36261f1fc8..0a150099e2 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2084,8 +2084,7 @@ static int qemu_rdma_write_one(QEMUFile *f, RDMACon=
text *rdma,
                                .repeat =3D 1,
                              };
=20
-    if (migrate_use_multiRDMA() &&
-        migrate_use_rdma_pin_all()) {
+    if (migrate_use_multiRDMA()) {
         /* The multiRDMA threads only send ram block */
         if (strcmp(block->block_name, "mach-virt.ram") =3D=3D 0) {
             int channel =3D get_multiRDMA_channel();
@@ -2311,8 +2310,7 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAC=
ontext *rdma)
     }
=20
     if (ret =3D=3D 0) {
-        if (migrate_use_multiRDMA() &&
-            migrate_use_rdma_pin_all()) {
+        if (migrate_use_multiRDMA()) {
             /* The multiRDMA threads only send ram block */
             RDMALocalBlock *block =3D NULL;
             block =3D &(rdma->local_ram_blocks.block[rdma->current_index=
]);
@@ -4234,12 +4232,24 @@ err:
=20
 static int qemu_multiRDMA_registration_handle(void *opaque)
 {
+    RDMAControlHeader reg_resp =3D { .len =3D sizeof(RDMARegisterResult)=
,
+                                   .type =3D RDMA_CONTROL_REGISTER_RESUL=
T,
+                                   .repeat =3D 0,
+                                 };
     RDMAControlHeader blocks =3D { .type =3D RDMA_CONTROL_RAM_BLOCKS_RES=
ULT,
                                  .repeat =3D 1 };
     MultiRDMARecvParams *p =3D opaque;
     RDMAContext *rdma =3D p->rdma;
     RDMALocalBlocks *local =3D &rdma->local_ram_blocks;
     RDMAControlHeader head;
+    RDMARegister *reg, *registers;
+    RDMACompress *comp;
+    RDMARegisterResult *reg_result;
+    static RDMARegisterResult results[RDMA_CONTROL_MAX_COMMANDS_PER_MESS=
AGE];
+    RDMALocalBlock *block;
+    void *host_addr;
+    int idx =3D 0;
+    int count =3D 0;
     int ret =3D 0;
     int i =3D 0;
=20
@@ -4260,8 +4270,28 @@ static int qemu_multiRDMA_registration_handle(void=
 *opaque)
         }
=20
         switch (head.type) {
+        case RDMA_CONTROL_COMPRESS:
+            comp =3D (RDMACompress *) rdma->wr_data[idx].control_curr;
+            network_to_compress(comp);
+
+            if (comp->block_idx >=3D rdma->local_ram_blocks.nb_blocks) {
+                error_report("rdma: 'compress' bad block index %u (vs %d=
)",
+                        (unsigned int)comp->block_idx,
+                        rdma->local_ram_blocks.nb_blocks);
+                ret =3D -EIO;
+                goto out;
+            }
+            block =3D &(rdma->local_ram_blocks.block[comp->block_idx]);
+
+            host_addr =3D block->local_host_addr +
+                (comp->offset - block->offset);
+
+            ram_handle_compressed(host_addr, comp->value, comp->length);
+            break;
+
         case RDMA_CONTROL_REGISTER_FINISHED:
             goto out;
+
         case RDMA_CONTROL_RAM_BLOCKS_REQUEST:
             qsort(rdma->local_ram_blocks.block,
                   rdma->local_ram_blocks.nb_blocks,
@@ -4310,8 +4340,79 @@ static int qemu_multiRDMA_registration_handle(void=
 *opaque)
                 error_report("rdma migration: error sending remote info"=
);
                 goto out;
             }
+            break;
+
+        case RDMA_CONTROL_REGISTER_REQUEST:
+            reg_resp.repeat =3D head.repeat;
+            registers =3D (RDMARegister *) rdma->wr_data[idx].control_cu=
rr;
=20
+            for (count =3D 0; count < head.repeat; count++) {
+                uint64_t chunk;
+                uint8_t *chunk_start, *chunk_end;
+
+                reg =3D &registers[count];
+                network_to_register(reg);
+
+                reg_result =3D &results[count];
+
+                if (reg->current_index >=3D rdma->local_ram_blocks.nb_bl=
ocks) {
+                    error_report("rdma: 'register' bad block index %u (v=
s %d)",
+                            (unsigned int)reg->current_index,
+                            rdma->local_ram_blocks.nb_blocks);
+                    ret =3D -ENOENT;
+                    goto out;
+                }
+                block =3D &(rdma->local_ram_blocks.block[reg->current_in=
dex]);
+                if (block->is_ram_block) {
+                    if (block->offset > reg->key.current_addr) {
+                        error_report("rdma: bad register address for blo=
ck %s"
+                                " offset: %" PRIx64 " current_addr: %" P=
RIx64,
+                                block->block_name, block->offset,
+                                reg->key.current_addr);
+                        ret =3D -ERANGE;
+                        goto out;
+                    }
+                    host_addr =3D (block->local_host_addr +
+                            (reg->key.current_addr - block->offset));
+                    chunk =3D ram_chunk_index(block->local_host_addr,
+                            (uint8_t *) host_addr);
+                } else {
+                    chunk =3D reg->key.chunk;
+                    host_addr =3D block->local_host_addr +
+                        (reg->key.chunk * (1UL << RDMA_REG_CHUNK_SHIFT))=
;
+                    /* Check for particularly bad chunk value */
+                    if (host_addr < (void *)block->local_host_addr) {
+                        error_report("rdma: bad chunk for block %s"
+                                " chunk: %" PRIx64,
+                                block->block_name, reg->key.chunk);
+                        ret =3D -ERANGE;
+                        goto out;
+                    }
+                }
+                chunk_start =3D ram_chunk_start(block, chunk);
+                chunk_end =3D ram_chunk_end(block, chunk + reg->chunks);
+                if (qemu_rdma_register_and_get_keys(rdma, block,
+                            (uintptr_t)host_addr, NULL, &reg_result->rke=
y,
+                            chunk, chunk_start, chunk_end)) {
+                    error_report("cannot get rkey");
+                    ret =3D -EINVAL;
+                    goto out;
+                }
+
+                reg_result->host_addr =3D (uintptr_t)block->local_host_a=
ddr;
+
+                result_to_network(reg_result);
+            }
+
+            ret =3D qemu_rdma_post_send_control(rdma,
+                    (uint8_t *) results, &reg_resp);
+
+            if (ret < 0) {
+                error_report("Failed to send control buffer");
+                goto out;
+            }
             break;
+
         default:
             error_report("Unknown control message %s", control_desc(head=
.type));
             ret =3D -EIO;
--=20
2.19.1



