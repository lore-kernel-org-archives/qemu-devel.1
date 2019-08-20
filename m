Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF04C3A59E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A631722CF4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A631722CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyAj-0007Xq-OU
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8D-0005Qp-CE
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy88-00031k-GB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy88-00031I-Aa
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9DFB1309174E
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:31 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D76359F70
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:27 +0200
Message-Id: <1566284395-30287-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 20 Aug 2019 07:00:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/36] block: fix NetBSD qemu-iotests failure
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Opening a block device on NetBSD has an additional step compared to other OSes,
corresponding to raw_normalize_devicepath.  The error message in that function
is slightly different from that in raw_open_common and this was causing spurious
failures in qemu-iotests.  However, in general it is not important to know what
exact step was failing, for example in the qemu-iotests case the error message
contains the fairly unequivocal "No such file or directory" text from strerror.
We can thus fix the failures by standardizing on a single error message for
both raw_open_common and raw_normalize_devicepath; in fact, we can even
use error_setg_file_open to make sure the error message is the same as in
the rest of QEMU.

Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4479cc7..da1fde1 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -217,7 +217,7 @@ static int raw_normalize_devicepath(const char **filename, Error **errp)
     fname = *filename;
     dp = strrchr(fname, '/');
     if (lstat(fname, &sb) < 0) {
-        error_setg_errno(errp, errno, "%s: stat failed", fname);
+        error_setg_file_open(errp, errno, fname);
         return -errno;
     }
 
@@ -547,7 +547,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     ret = fd < 0 ? -errno : 0;
 
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not open '%s'", filename);
+        error_setg_file_open(errp, -ret, filename);
         if (ret == -EROFS) {
             ret = -EACCES;
         }
-- 
1.8.3.1



