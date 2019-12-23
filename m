Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D119C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EF3206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 09:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EF3206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijKLn-000627-Mj
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 04:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKIk-00034c-Ig
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKIj-0006qK-C0
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:46:58 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50722)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1ijKIi-0006kG-TP
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 04:46:57 -0500
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id DBC3154006B;
 Mon, 23 Dec 2019 12:46:38 +0300 (MSK)
Subject: [for-5.0 PATCH 02/11] qcow2: introduce icount field for snapshots
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 23 Dec 2019 12:46:38 +0300
Message-ID: <157709439859.12933.3023824005902199560.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch introduces the icount field for saving within the snapshot.
It is required for navigation between the snapshots in record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Acked-by: Kevin Wolf <kwolf@redhat.com>

--

v2:
 - documented format changes in docs/interop/qcow2.txt
   (suggested by Eric Blake)
v10:
 - updated the documentation
---
 block/qcow2-snapshot.c |    7 +++++++
 block/qcow2.h          |    3 +++
 docs/interop/qcow2.txt |    4 ++++
 3 files changed, 14 insertions(+)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 5ab64da1ec..b04b3e1634 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -163,6 +163,12 @@ static int qcow2_do_read_snapshots(BlockDriverState *bs, bool repair,
             sn->disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
         }
 
+        if (sn->extra_data_size >= endof(QCowSnapshotExtraData, icount)) {
+            sn->icount = be64_to_cpu(extra.icount);
+        } else {
+            sn->icount = -1ULL;
+        }
+
         if (sn->extra_data_size > sizeof(extra)) {
             uint64_t extra_data_end;
             size_t unknown_extra_data_size;
@@ -332,6 +338,7 @@ int qcow2_write_snapshots(BlockDriverState *bs)
         memset(&extra, 0, sizeof(extra));
         extra.vm_state_size_large = cpu_to_be64(sn->vm_state_size);
         extra.disk_size = cpu_to_be64(sn->disk_size);
+        extra.icount = cpu_to_be64(sn->icount);
 
         id_str_size = strlen(sn->id_str);
         name_size = strlen(sn->name);
diff --git a/block/qcow2.h b/block/qcow2.h
index 0942126232..f3e0d9aa56 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -171,6 +171,7 @@ typedef struct QEMU_PACKED QCowSnapshotHeader {
 typedef struct QEMU_PACKED QCowSnapshotExtraData {
     uint64_t vm_state_size_large;
     uint64_t disk_size;
+    uint64_t icount;
 } QCowSnapshotExtraData;
 
 
@@ -184,6 +185,8 @@ typedef struct QCowSnapshot {
     uint32_t date_sec;
     uint32_t date_nsec;
     uint64_t vm_clock_nsec;
+    /* icount value for the moment when snapshot was taken */
+    uint64_t icount;
     /* Size of all extra data, including QCowSnapshotExtraData if available */
     uint32_t extra_data_size;
     /* Data beyond QCowSnapshotExtraData, if any */
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index af5711e533..aa9d447cda 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -584,6 +584,10 @@ Snapshot table entry:
 
                     Byte 48 - 55:   Virtual disk size of the snapshot in bytes
 
+                    Byte 56 - 63:   icount value which corresponds to
+                                    the record/replay instruction count
+                                    when the snapshot was taken
+
                     Version 3 images must include extra data at least up to
                     byte 55.
 


