Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F8DC41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9F420691
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9F420691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOl7r-0003di-Gl
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kOl5o-00029D-7k
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:13:08 -0400
Received: from mail.ispras.ru ([83.149.199.84]:35970)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kOl5m-0008Ee-2W
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:13:07 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 008B740A1DB0;
 Sat,  3 Oct 2020 17:13:03 +0000 (UTC)
Subject: [PATCH v7 03/14] qcow2: introduce icount field for snapshots
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Sat, 03 Oct 2020 20:13:02 +0300
Message-ID: <160174518284.12451.2301137308458777398.stgit@pasha-ThinkPad-X280>
In-Reply-To: <160174516520.12451.10785284392438702137.stgit@pasha-ThinkPad-X280>
References: <160174516520.12451.10785284392438702137.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 13:12:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, pavel.dovgalyuk@ispras.ru,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces the icount field for saving within the snapshot.
It is required for navigation between the snapshots in record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Kevin Wolf <kwolf@redhat.com>

--

v7 changes:
 - also fix the test which checks qcow2 snapshot extra data
---
 block/qcow2-snapshot.c     |    7 ++++++
 block/qcow2.h              |    3 +++
 docs/interop/qcow2.txt     |    5 ++++
 tests/qemu-iotests/261     |   15 ++++++++-----
 tests/qemu-iotests/261.out |   51 +++++++++++++++++++++++++++++---------------
 5 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 9b68690f56..d68b25e0c5 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -164,6 +164,12 @@ static int qcow2_do_read_snapshots(BlockDriverState *bs, bool repair,
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
@@ -333,6 +339,7 @@ int qcow2_write_snapshots(BlockDriverState *bs)
         memset(&extra, 0, sizeof(extra));
         extra.vm_state_size_large = cpu_to_be64(sn->vm_state_size);
         extra.disk_size = cpu_to_be64(sn->disk_size);
+        extra.icount = cpu_to_be64(sn->icount);
 
         id_str_size = strlen(sn->id_str);
         name_size = strlen(sn->name);
diff --git a/block/qcow2.h b/block/qcow2.h
index b71e444fca..125ea9679b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -206,6 +206,7 @@ typedef struct QEMU_PACKED QCowSnapshotHeader {
 typedef struct QEMU_PACKED QCowSnapshotExtraData {
     uint64_t vm_state_size_large;
     uint64_t disk_size;
+    uint64_t icount;
 } QCowSnapshotExtraData;
 
 
@@ -219,6 +220,8 @@ typedef struct QCowSnapshot {
     uint32_t date_sec;
     uint32_t date_nsec;
     uint64_t vm_clock_nsec;
+    /* icount value for the moment when snapshot was taken */
+    uint64_t icount;
     /* Size of all extra data, including QCowSnapshotExtraData if available */
     uint32_t extra_data_size;
     /* Data beyond QCowSnapshotExtraData, if any */
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 7da0d81df8..0463f761ef 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -707,6 +707,11 @@ Snapshot table entry:
 
                     Byte 48 - 55:   Virtual disk size of the snapshot in bytes
 
+                    Byte 56 - 63:   icount value which corresponds to
+                                    the record/replay instruction count
+                                    when the snapshot was taken. Set to -1
+                                    if icount was disabled
+
                     Version 3 images must include extra data at least up to
                     byte 55.
 
diff --git a/tests/qemu-iotests/261 b/tests/qemu-iotests/261
index ddcb04f285..848ffa760d 100755
--- a/tests/qemu-iotests/261
+++ b/tests/qemu-iotests/261
@@ -91,7 +91,10 @@ print_snapshot_table()
         if [ $extra_len -ge 16 ]; then
             echo "    Disk size: $(peek_file_be "$1" $((extra_ofs + 8)) 8)"
         fi
-        if [ $extra_len -gt 16 ]; then
+        if [ $extra_len -ge 24 ]; then
+            echo "    Icount: $(peek_file_be "$1" $((extra_ofs + 16)) 8)"
+        fi
+        if [ $extra_len -gt 24 ]; then
             echo '    Unknown extra data:' \
                 "$(peek_file_raw "$1" $((extra_ofs + 16)) $((extra_len - 16)) \
                    | tr -d '\0')"
@@ -198,12 +201,12 @@ truncate -s 0 "$TEST_DIR/sn0-extra"
 truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn0-pre") - 40)) \
     "$TEST_DIR/sn0-post"
 
-# Set sn1's extra data size to 42
-poke_file "$TEST_DIR/sn1-pre" 36 '\x00\x00\x00\x2a'
-truncate -s 42 "$TEST_DIR/sn1-extra"
-poke_file "$TEST_DIR/sn1-extra" 16 'very important data'
+# Set sn1's extra data size to 50
+poke_file "$TEST_DIR/sn1-pre" 36 '\x00\x00\x00\x32'
+truncate -s 50 "$TEST_DIR/sn1-extra"
+poke_file "$TEST_DIR/sn1-extra" 24 'very important data'
 # Grow sn1-post to pad
-truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn1-pre") - 82)) \
+truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn1-pre") - 90)) \
     "$TEST_DIR/sn1-post"
 
 # Set sn2's extra data size to 8
diff --git a/tests/qemu-iotests/261.out b/tests/qemu-iotests/261.out
index 2600354566..612433ae40 100644
--- a/tests/qemu-iotests/261.out
+++ b/tests/qemu-iotests/261.out
@@ -12,9 +12,10 @@ Snapshots in TEST_DIR/t.IMGFMT.v2.orig:
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [2]
     ID: 3
@@ -29,22 +30,25 @@ Snapshots in TEST_DIR/t.IMGFMT.v3.orig:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [2]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
 
 === Repair botched v3 ===
 
@@ -61,22 +65,25 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [2]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
 
 === Add new snapshot ===
 
@@ -85,28 +92,32 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [2]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [3]
     ID: 4
     Name: sn3
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
 
 === Remove different snapshots ===
 
@@ -116,16 +127,18 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [1]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
 
 --- sn1 ---
 No errors were found on the image.
@@ -133,15 +146,17 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
 
 --- sn2 ---
 No errors were found on the image.
@@ -149,15 +164,17 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
 
 === Reject too much unknown extra data ===


