Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CBCC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C113720674
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhJILv/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C113720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttvc-0003oC-To
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jttum-0002tS-Oh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:22:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jttui-0004Lw-CP
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594390927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xeCWO/h8stA7OacnvuFCi1Lq98xknFoku/3saGS+ACA=;
 b=PhJILv/C6oAg2BAATxjJEKnnjSuqBAjtOF9QCyE5tsYPJVWogQxPTvW1vJjEnx23cUsrzi
 Qf7MAvsqSoEfo5WYufzmfQOnwSFTOHw5xUdGfb15dpigUNdWX1kGkNV5LZ2zyh6mk5ObN5
 /wrCbccJwk5AFvIRuJLKkRezwd2NlTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-BnpXMLsdP3SPgn472mL0eQ-1; Fri, 10 Jul 2020 10:22:06 -0400
X-MC-Unique: BnpXMLsdP3SPgn472mL0eQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E54801083E89;
 Fri, 10 Jul 2020 14:22:04 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-57.ams2.redhat.com [10.36.114.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC2D460C05;
 Fri, 10 Jul 2020 14:22:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 2/2] file-posix: Allow byte-aligned O_DIRECT with NFS
Date: Fri, 10 Jul 2020 16:21:49 +0200
Message-Id: <20200710142149.40962-3-kwolf@redhat.com>
In-Reply-To: <20200710142149.40962-1-kwolf@redhat.com>
References: <20200710142149.40962-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit a6b257a08e3 ('file-posix: Handle undetectable alignment'),
we assume that if we open a file with O_DIRECT and alignment probing
returns 1, we just couldn't find out the real alignment requirement
because some filesystems make the requirement only for allocated blocks.
In this case, a safe default of 4k is used.

This is too strict NFS, which does actually allow byte-aligned requests
even with O_DIRECT. Because we can't distinguish both cases with generic
code, let's just look at the file system magic and disable
s->needs_alignment for NFS. This way, O_DIRECT can still be used on NFS
for images that are not aligned to 4k.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0c4e07c415..4e9dac461b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -62,10 +62,12 @@
 #include <sys/ioctl.h>
 #include <sys/param.h>
 #include <sys/syscall.h>
+#include <sys/vfs.h>
 #include <linux/cdrom.h>
 #include <linux/fd.h>
 #include <linux/fs.h>
 #include <linux/hdreg.h>
+#include <linux/magic.h>
 #include <scsi/sg.h>
 #ifdef __s390__
 #include <asm/dasd.h>
@@ -300,6 +302,28 @@ static int probe_physical_blocksize(int fd, unsigned int *blk_size)
 #endif
 }
 
+/*
+ * Returns true if no alignment restrictions are necessary even for files
+ * opened with O_DIRECT.
+ *
+ * raw_probe_alignment() probes the required alignment and assume that 1 means
+ * the probing failed, so it falls back to a safe default of 4k. This can be
+ * avoided if we know that byte alignment is okay for the file.
+ */
+static bool dio_byte_aligned(int fd)
+{
+#ifdef __linux__
+    struct statfs buf;
+    int ret;
+
+    ret = fstatfs(fd, &buf);
+    if (ret == 0 && buf.f_type == NFS_SUPER_MAGIC) {
+        return true;
+    }
+#endif
+    return false;
+}
+
 /* Check if read is allowed with given memory buffer and length.
  *
  * This function is used to check O_DIRECT memory buffer and request alignment.
@@ -631,7 +655,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
     s->has_discard = true;
     s->has_write_zeroes = true;
-    if ((bs->open_flags & BDRV_O_NOCACHE) != 0) {
+    if ((bs->open_flags & BDRV_O_NOCACHE) != 0 && !dio_byte_aligned(s->fd)) {
         s->needs_alignment = true;
     }
 
-- 
2.25.4


