Received: from eggs.gnu.org ([2001:4830:134:3::10]:42365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBn-0002Yb-P4
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBk-0001E3-HV
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44465
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBk-0001DU-B8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:24 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hfvk136263
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:23 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm3s0mx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:23 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:23 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:18 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-25-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 24/67] iscsi: Fix divide-by-zero regression on
 raw SG devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Eric Blake <eblake@redhat.com>

When qemu uses iscsi devices in sg mode, iscsilun->block_size
is left at 0.  Prior to commits cf081fca and similar, when
block limits were tracked in sectors, this did not matter:
various block limits were just left at 0.  But when we started
scaling by block size, this caused SIGFPE.

Then, in a later patch, commit a5b8dd2c added an assertion to
bdrv_open_common() that request_alignment is always non-zero;
which was not true for SG mode.  Rather than relax that assertion,
we can just provide a sane value (we don't know of any SG device
with a block size smaller than qemu's default sizing of 512 bytes).

One possible solution for SG mode is to just blindly skip ALL
of iscsi_refresh_limits(), since we already short circuit so
many other things in sg mode.  But this patch takes a slightly
more conservative approach, and merely guarantees that scaling
will succeed, while still using multiples of the original size
where possible.  Resulting limits may still be zero in SG mode
(that is, we mostly only fix block_size used as a denominator
or which affect assertions, not all uses).

Reported-by: Holger Schranz <holger@fam-schranz.de>
Signed-off-by: Eric Blake <eblake@redhat.com>
CC: qemu-stable@nongnu.org

Message-Id: <1473283640-15756-1-git-send-email-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 95eaa78537c734fa3cb3373d47ba8c0099a36ff0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/iscsi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 95ce9e1..b2b4e5d 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1813,19 +1813,22 @@ static void iscsi_refresh_limits(BlockDriverState *bs, Error **errp)
 
     IscsiLun *iscsilun = bs->opaque;
     uint64_t max_xfer_len = iscsilun->use_16_for_rw ? 0xffffffff : 0xffff;
+    unsigned int block_size = MAX(BDRV_SECTOR_SIZE, iscsilun->block_size);
 
-    bs->bl.request_alignment = iscsilun->block_size;
+    assert(iscsilun->block_size >= BDRV_SECTOR_SIZE || bs->sg);
+
+    bs->bl.request_alignment = block_size;
 
     if (iscsilun->bl.max_xfer_len) {
         max_xfer_len = MIN(max_xfer_len, iscsilun->bl.max_xfer_len);
     }
 
-    if (max_xfer_len * iscsilun->block_size < INT_MAX) {
+    if (max_xfer_len * block_size < INT_MAX) {
         bs->bl.max_transfer = max_xfer_len * iscsilun->block_size;
     }
 
     if (iscsilun->lbp.lbpu) {
-        if (iscsilun->bl.max_unmap < 0xffffffff / iscsilun->block_size) {
+        if (iscsilun->bl.max_unmap < 0xffffffff / block_size) {
             bs->bl.max_pdiscard =
                 iscsilun->bl.max_unmap * iscsilun->block_size;
         }
@@ -1835,7 +1838,7 @@ static void iscsi_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.pdiscard_alignment = iscsilun->block_size;
     }
 
-    if (iscsilun->bl.max_ws_len < 0xffffffff / iscsilun->block_size) {
+    if (iscsilun->bl.max_ws_len < 0xffffffff / block_size) {
         bs->bl.max_pwrite_zeroes =
             iscsilun->bl.max_ws_len * iscsilun->block_size;
     }
@@ -1846,7 +1849,7 @@ static void iscsi_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.pwrite_zeroes_alignment = iscsilun->block_size;
     }
     if (iscsilun->bl.opt_xfer_len &&
-        iscsilun->bl.opt_xfer_len < INT_MAX / iscsilun->block_size) {
+        iscsilun->bl.opt_xfer_len < INT_MAX / block_size) {
         bs->bl.opt_transfer = pow2floor(iscsilun->bl.opt_xfer_len *
                                         iscsilun->block_size);
     }
-- 
1.9.1
