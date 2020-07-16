Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A44C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EAB206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqH6cpvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EAB206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4se-0003fK-N6
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jw4qB-0001IH-J8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:26:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jw4q9-0005bQ-NK
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594909584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFOMtfrauKOkTwVYHiiz1g6uh4pzmKAKYAHQfuee8aM=;
 b=eqH6cpvWxPMhorwiYFav7cekIdLE2zNdww250mxhNAYnaLc4Ke0ATXRape4mv+NsOodRZ7
 eiSu6B6qqvLlDmFBuZjWZB30naTPF0Geft9wQm1ZjXpVI08omEaa2VYyfmHb+1JunfEDMb
 lfFVka1P1JNt7wLug7vSOFTPq9GU8/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-u2McWtaOMOyhr9RY6Lo1vA-1; Thu, 16 Jul 2020 10:26:23 -0400
X-MC-Unique: u2McWtaOMOyhr9RY6Lo1vA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 054A91082B28;
 Thu, 16 Jul 2020 14:26:22 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-172.ams2.redhat.com
 [10.36.114.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEFB672AE1;
 Thu, 16 Jul 2020 14:26:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 v2 2/2] file-posix: Allow byte-aligned O_DIRECT with
 NFS
Date: Thu, 16 Jul 2020 16:26:01 +0200
Message-Id: <20200716142601.111237-3-kwolf@redhat.com>
In-Reply-To: <20200716142601.111237-1-kwolf@redhat.com>
References: <20200716142601.111237-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit a6b257a08e3 ('file-posix: Handle undetectable alignment'),
we assume that if we open a file with O_DIRECT and alignment probing
returns 1, we just couldn't find out the real alignment requirement
because some filesystems make the requirement only for allocated blocks.
In this case, a safe default of 4k is used.

This is too strict for NFS, which does actually allow byte-aligned
requests even with O_DIRECT. Because we can't distinguish both cases
with generic code, let's just look at the file system magic and disable
s->needs_alignment for NFS. This way, O_DIRECT can still be used on NFS
for images that are not aligned to 4k.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8067e238cb..ae8190edab 100644
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
@@ -629,7 +653,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
     s->has_discard = true;
     s->has_write_zeroes = true;
-    if ((bs->open_flags & BDRV_O_NOCACHE) != 0) {
+    if ((bs->open_flags & BDRV_O_NOCACHE) != 0 && !dio_byte_aligned(s->fd)) {
         s->needs_alignment = true;
     }
 
-- 
2.25.4


