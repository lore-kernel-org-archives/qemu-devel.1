Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B06C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DDB205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 13:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DDB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLShi-0006JJ-AT
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 09:21:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLSfw-0004z9-Pm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLSfw-00054x-1M
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:20:00 -0400
Received: from inet-orm.provo.novell.com ([137.65.248.124]:49033
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1hLSfv-00053e-OO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 09:19:59 -0400
Received: from brogers1.provo.novell.com ([137.65.223.116])
	by mail.novell.com with ESMTP (NOT encrypted);
	Tue, 30 Apr 2019 07:19:52 -0600
From: Bruce Rogers <brogers@suse.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 07:19:46 -0600
Message-Id: <20190430131946.26628-1-brogers@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 137.65.248.124
Subject: [Qemu-devel] [PATCH v2] scsi-disk: handle invalid cdb length
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, pbonzini@redhat.com, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430131946.tT93KpImqNT4Sq0enxtQ9Gt6plye6SLc9QwoqJ-iv08@z>

While investigating link-time-optimization, the compiler flagged this
case of not handling the error return from scsi_cdb_length(). Handle
this error case with a trace report.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 hw/scsi/scsi-disk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e7e865ab3b..8fbf7512e5 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2520,6 +2520,10 @@ static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
     int len = scsi_cdb_length(buf);
     char *line_buffer, *p;
 
+    if (len < 0) {
+        trace_scsi_disk_new_request(lun, tag, "bad cdb length");
+        return;
+    }
     line_buffer = g_malloc(len * 5 + 1);
 
     for (i = 0, p = line_buffer; i < len; i++) {
-- 
2.21.0


