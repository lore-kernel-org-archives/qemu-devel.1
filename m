Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A9EC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A5B20835
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A5B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37086 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLsdW-0003FZ-FH
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 13:03:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLscB-0002qI-8V
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLsc6-0006IF-Gx
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:01:50 -0400
Received: from inet-orm.provo.novell.com ([137.65.248.124]:47010
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1hLsc6-000609-3c
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:01:46 -0400
Received: from brogers1.provo.novell.com ([137.65.184.169])
	by mail.novell.com with ESMTP (NOT encrypted);
	Wed, 01 May 2019 11:01:30 -0600
From: Bruce Rogers <brogers@suse.com>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 11:01:25 -0600
Message-Id: <20190501170125.10244-1-brogers@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 137.65.248.124
Subject: [Qemu-devel] [PATCH] scsi-disk: assert positive value to avoid
 compiler warning
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
Cc: fam@euphon.net, pbonzini@redhat.com, jsnow@redhat.com,
	Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501170125.QbTYq9NV9eBlJVPo-mGZI7xFdMm5WrhGD015_eJcTj4@z>

While investigating link-time-optimization, the compiler complained as
follows:
In function ‘scsi_disk_new_request_dump’,
    inlined from ‘scsi_new_request.part.24’ at hw/scsi/scsi-disk.c:2549:9,
    inlined from ‘scsi_new_request’ at hw/scsi/scsi-disk.c:2533:21:
hw/scsi/scsi-disk.c:2523:19: error: argument 1 value ‘18446744073709551612’ exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
hw/scsi/scsi-disk.c: In function ‘scsi_new_request’:
/usr/include/glib-2.0/glib/gmem.h:78:10: note: in a call to allocation function ‘g_malloc’ declared here
 gpointer g_malloc         (gsize  n_bytes) G_GNUC_MALLOC G_GNUC_ALLOC_SIZE(1);

Asserting that len is positive avoids this diagnostic. This assert is
reasonable since the error case of scsi_cdb_length() has already been
handled by a previous call to that function.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e7e865ab3b..ac180fdddf 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2520,6 +2520,7 @@ static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
     int len = scsi_cdb_length(buf);
     char *line_buffer, *p;
 
+    assert(len > 0);
     line_buffer = g_malloc(len * 5 + 1);
 
     for (i = 0, p = line_buffer; i < len; i++) {
-- 
2.21.0


