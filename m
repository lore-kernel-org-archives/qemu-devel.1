Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF718C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796D0208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCa/scJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796D0208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQ29-00019T-Kl
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPtt-00052m-RR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58453
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPtp-0008OH-PR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594990537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpESJwDzpITFP8Z/klDCIrIRZGj2a7URcjCJxBrzFgs=;
 b=JCa/scJFIain25pQfSCAJo8j9cwVKOZRAUB8KVw/DQZfqx2IW6Q8OPH18Smo+KZ7oOoJRS
 f4HMhMDnnBUhCy35SBxSw8Cd1KDU/6dIGNM3wLeQID9RH81NmXCwXZZwVV3tlpWu86MWla
 MrZOrd3YePhjyyZWU6lDcW2CSK1Be+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-iXCnrfy0OYqkb1k7h_3Svw-1; Fri, 17 Jul 2020 08:55:35 -0400
X-MC-Unique: iXCnrfy0OYqkb1k7h_3Svw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DC8D8AF852;
 Fri, 17 Jul 2020 12:55:28 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADF34710B1;
 Fri, 17 Jul 2020 12:55:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/12] file-posix: Allow byte-aligned O_DIRECT with NFS
Date: Fri, 17 Jul 2020 14:55:07 +0200
Message-Id: <20200717125510.238374-10-kwolf@redhat.com>
In-Reply-To: <20200717125510.238374-1-kwolf@redhat.com>
References: <20200717125510.238374-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
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
Message-Id: <20200716142601.111237-3-kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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


