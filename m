Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE5FC5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0152075A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFqjCGfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0152075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRChQ-0003Ip-1C
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1jRCg8-0001wj-8b
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1jRCg5-0001zQ-F7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:32:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jRCg3-0001lb-VI
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587551542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EA5m1e8tPUQV/7F5915rUPgFXLJ1efSqTe2C2O/TVPM=;
 b=RFqjCGfu8sWkg5i4ocv/3+by8WCp0QV/hl8AK3lQ73R20prtXpGyUMdCDLV3NqH/rO6PmL
 X3FoVud2C2NGMjLpGd1sfT2Ptewxnny/atNt77TnaPF62R+gmJwktUwzRAPxs/J1bnj+Nx
 bI4PwV7DyY9QXUQU1AcvQQpHaVehRYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-GF2QtEvrM8WItEWny5yjwQ-1; Wed, 22 Apr 2020 06:31:05 -0400
X-MC-Unique: GF2QtEvrM8WItEWny5yjwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56A461937FC0;
 Wed, 22 Apr 2020 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22E0560BF3;
 Wed, 22 Apr 2020 10:30:57 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vfio-helpers: Free QEMUVFIOState in qemu_vfio_close()
Date: Wed, 22 Apr 2020 12:30:48 +0200
Message-Id: <04cb6cb30a49cabd5ff8e6c094c0d13572de9fb1.1587551421.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qemu_vfio_open_pci() allocates this QEMUVFIOState structure
but free counterpart is missing. Since we already have
qemu_vfio_close() which does cleanup of the state, it looks like
a perfect place to free the structure too. However, to avoid
confusing rename the function to make it explicit that the passed
structure is also freed.

=3D=3D167296=3D=3D 528 (360 direct, 168 indirect) bytes in 1 blocks are def=
initely lost in loss record 8,504 of 8,908
=3D=3D167296=3D=3D    at 0x4837B86: calloc (vg_replace_malloc.c:762)
=3D=3D167296=3D=3D    by 0x4B8F6A0: g_malloc0 (in /usr/lib64/libglib-2.0.so=
.0.6000.7)
=3D=3D167296=3D=3D    by 0xA7F532: qemu_vfio_open_pci (vfio-helpers.c:428)
=3D=3D167296=3D=3D    by 0x989595: nvme_init (nvme.c:606)
=3D=3D167296=3D=3D    by 0x989EB0: nvme_file_open (nvme.c:795)
=3D=3D167296=3D=3D    by 0x8F9D04: bdrv_open_driver (block.c:1466)
=3D=3D167296=3D=3D    by 0x8FA6E1: bdrv_open_common (block.c:1744)
=3D=3D167296=3D=3D    by 0x8FDC73: bdrv_open_inherit (block.c:3291)
=3D=3D167296=3D=3D    by 0x8FE1B5: bdrv_open (block.c:3384)
=3D=3D167296=3D=3D    by 0x5EE828: bds_tree_init (blockdev.c:663)
=3D=3D167296=3D=3D    by 0x5F57F8: qmp_blockdev_add (blockdev.c:3746)
=3D=3D167296=3D=3D    by 0x5666DC: configure_blockdev (vl.c:1047)

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 block/nvme.c                | 2 +-
 include/qemu/vfio-helpers.h | 2 +-
 util/vfio-helpers.c         | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 7b7c0cc5d6..7e00c4f1a7 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -766,7 +766,7 @@ static void nvme_close(BlockDriverState *bs)
                            false, NULL, NULL);
     event_notifier_cleanup(&s->irq_notifier);
     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE)=
;
-    qemu_vfio_close(s->vfio);
+    qemu_vfio_close_and_free(s->vfio);
=20
     g_free(s->device);
 }
diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 1f057c2b9e..c96a0b1963 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -16,7 +16,7 @@
 typedef struct QEMUVFIOState QEMUVFIOState;
=20
 QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp);
-void qemu_vfio_close(QEMUVFIOState *s);
+void qemu_vfio_close_and_free(QEMUVFIOState *s);
 int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
                       bool temporary, uint64_t *iova_list);
 int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s);
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index ddd9a96e76..4c525d245b 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -706,7 +706,7 @@ static void qemu_vfio_reset(QEMUVFIOState *s)
 }
=20
 /* Close and free the VFIO resources. */
-void qemu_vfio_close(QEMUVFIOState *s)
+void qemu_vfio_close_and_free(QEMUVFIOState *s)
 {
     int i;
=20
@@ -721,4 +721,5 @@ void qemu_vfio_close(QEMUVFIOState *s)
     close(s->device);
     close(s->group);
     close(s->container);
+    g_free(s);
 }
--=20
2.25.3


