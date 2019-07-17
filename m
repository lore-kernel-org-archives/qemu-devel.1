Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01EAC76195
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4702145D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QVtBZfgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4702145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnrSc-0008Fa-LB
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 17:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrSB-0006p4-D9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrSA-0006zc-9a
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrSA-0006xf-0I; Wed, 17 Jul 2019 17:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563398830; x=1594934830;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/Kwi8Jp1yIRIowLQtDYQc9c9gPWOx1jGUCy5ob5WQvw=;
 b=QVtBZfgV58RJUv3FAS/sgPpm0/jEhjGD+EjQjEyi7xnb0n0tWnDbKgOF
 BF7U9Brf97SGk+SmoSC4E3unAD/6kQg4eBzq/FcG6gbyJt3KknSMoiotL
 VaPkmQMXFBE69kvk9cCYEF+QFBUvZof5dsTjjj8lcLOt4DV6V9llwBu8P
 6fVMpuPfsvb17K3Li5jA4A/qsbdzBIuSX26588xkrT8q1ABmg5Cfme3z2
 fzfwkOv3NxjoLpDuMWJMKtFTjFI8KVO/F2oKCyQwDSCjUceUn03NxorWh
 apsWihxBRDW4M7xsY5D4q8brrHtXl5QS7nJR1g6DeEjEiICpAnJi/1Ess A==;
IronPort-SDR: G/rveNnfRilmOVnYQBBdXo9jt9JOz9hMRSkj9tB8vNzdhfHUve2Eq/TmZo/K9ZDfNxRcAVFFKb
 TE4bBbvoy9frg9vh/oc+BedNiOqrXIaZGBzei6iqdlkHiO594O8mHkkMNpG7Eo1Fjusw25Vreq
 LfbXMHfq06kP/EQDzxSFbNV/v/CC5O91XwHrQcDHaiZYT79S9a5V/7bDNbiAhyk8x9zUsfIoEk
 lpoNw1YrzAiv5vhMwtqWHRIlFpA+YPi1Ol597RuuI2goWD10uZQEyxRznSD5XqfpXKETxPDkFJ
 Gns=
X-IronPort-AV: E=Sophos;i="5.64,275,1559491200"; d="scan'208";a="113319452"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2019 05:27:09 +0800
IronPort-SDR: t8V0AnoNdPujx04FaQDJId0OEaCDTezSqzL6zwoIU88Ib0BTxPYPOmtm43nHAXarR2c4gzzl7o
 +ElfJtaFz/o/rniuxgTXJjCsxUSHLNE8gMp4EiEUQjXP5ht7R1fO1mBTM29YvT1k3+kfXKLAKI
 7VnMqqJfacT5qKpsygFBhjrD3w4F04ChlaTIFzD7LOZHi1EcA3IRObThl0RBqfJEKunGBJRJu6
 UZ8Pl29OO4KviOCELNsy41GPoXionG+AAFLTF1rp831fiU1DNewmVJsRQQF9L71Hu1IkhuyhEU
 ksTzfzPCenI9waunsLvrO70d
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jul 2019 14:25:36 -0700
IronPort-SDR: pTb1FxQsRwIPStElC3a+7qw8scmcMYrbh+vKglXa6/CVEi1hz3Yx8u2UOV8+1q/OnpBBwF46+a
 /xJR6utYIsdAjx8+WXGxVGD/keLI+lQgiRB2X9oZb7YuBlPbphTmako+bCVVRi1ndVfSp2MKl9
 YywV6BqRjHKzwTckNgZIm9nsZ2R7wx/ZVshOTmhktvaJZF3Bh1NY91xlKytkEmektF4Nvp7Nww
 csFUoQUsN3YLZSHe5CNW2jt+evWj2AKoRjjjZ+5gbq12UQkf7sBZW9wpIfaqOlr6aGSiPN/ert
 VUM=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Jul 2019 14:27:09 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 17 Jul 2019 17:27:03 -0400
Message-Id: <20190717212703.10205-6-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
References: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 5/5] hw/scsi: Check sense key before READ
 CAPACITY output snoop
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

When READ CAPACITY command completes, scsi_read_complete() function
snoops the command result and updates SCSIDevice members blocksize and
max_lba . However, this update is executed even when READ CAPACITY
command indicates an error in sense data. This causes unexpected
blocksize update with zero value for SCSI devices without
READ CAPACITY(10) command support and eventually results in a divide
by zero. An emulated device by TCMU-runner is an example of a device
that doesn't support READ CAPACITY(10) command.

To avoid the unexpected update, add sense key check in
scsi_read_complete() function. The function already checks the sense
key for VPD Block Limits emulation. Make scsi_parse_sense_buf() call
common for VPD Block Limits emulation and READ CAPACITY snoop. Update
blocksize and max_lba only if READ CAPACITY returns zero sense key.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 hw/scsi/scsi-generic.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index a43efe39ec..e38d3160fa 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -238,6 +238,7 @@ static void scsi_read_complete(void * opaque, int ret)
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
     SCSIDevice *s = r->req.dev;
     int len;
+    uint8_t sense_key = NO_SENSE;
 
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
@@ -254,6 +255,12 @@ static void scsi_read_complete(void * opaque, int ret)
 
     r->len = -1;
 
+    if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
+        SCSISense sense =
+            scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr);
+        sense_key = sense.key;
+    }
+
     /*
      * Check if this is a VPD Block Limits request that
      * resulted in sense error but would need emulation.
@@ -264,9 +271,7 @@ static void scsi_read_complete(void * opaque, int ret)
         r->req.cmd.buf[0] == INQUIRY &&
         (r->req.cmd.buf[1] & 0x01) &&
         r->req.cmd.buf[2] == 0xb0) {
-        SCSISense sense =
-            scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr);
-        if (sense.key == ILLEGAL_REQUEST) {
+        if (sense_key == ILLEGAL_REQUEST) {
             len = scsi_generic_emulate_block_limits(r, s);
             /*
              * No need to let scsi_read_complete go on and handle an
@@ -281,15 +286,17 @@ static void scsi_read_complete(void * opaque, int ret)
         goto done;
     }
 
-    /* Snoop READ CAPACITY output to set the blocksize.  */
-    if (r->req.cmd.buf[0] == READ_CAPACITY_10 &&
-        (ldl_be_p(&r->buf[0]) != 0xffffffffU || s->max_lba == 0)) {
-        s->blocksize = ldl_be_p(&r->buf[4]);
-        s->max_lba = ldl_be_p(&r->buf[0]) & 0xffffffffULL;
-    } else if (r->req.cmd.buf[0] == SERVICE_ACTION_IN_16 &&
-               (r->req.cmd.buf[1] & 31) == SAI_READ_CAPACITY_16) {
-        s->blocksize = ldl_be_p(&r->buf[8]);
-        s->max_lba = ldq_be_p(&r->buf[0]);
+    /* Snoop READ CAPACITY output to set the blocksize. */
+    if (sense_key == NO_SENSE) {
+        if (r->req.cmd.buf[0] == READ_CAPACITY_10 &&
+            (ldl_be_p(&r->buf[0]) != 0xffffffffU || s->max_lba == 0)) {
+            s->blocksize = ldl_be_p(&r->buf[4]);
+            s->max_lba = ldl_be_p(&r->buf[0]) & 0xffffffffULL;
+        } else if (r->req.cmd.buf[0] == SERVICE_ACTION_IN_16 &&
+                   (r->req.cmd.buf[1] & 31) == SAI_READ_CAPACITY_16) {
+            s->blocksize = ldl_be_p(&r->buf[8]);
+            s->max_lba = ldq_be_p(&r->buf[0]);
+        }
     }
     blk_set_guest_block_size(s->conf.blk, s->blocksize);
 
-- 
2.21.0


