Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0321C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7F52073E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnuGghVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7F52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsoWI-0003AX-Vo
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 10:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsoVi-0002f6-R9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:23:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsoVg-0003OK-C7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 10:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594131827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AELbVvmO4BK3VahuQzPwVMOmMkOQCJ/L0XmAkHeL2MQ=;
 b=LnuGghVOqhfeUhU6UtPEM183kyzfR6KdXhaSNKbi0ftpx8saXrxX0olo0MSbJipuGxXriu
 /bpSYUfd7lHTRKSvP5Hb9igmoUNInP0j7DdVtw4tGgyefjyMH6fcx1OvWabqr+t+mvf5h3
 F0XdNnF3hJuz7ssg2CFEnkdp9ydtGmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Oay8bKoXMxmAne_pCkEqlQ-1; Tue, 07 Jul 2020 10:23:44 -0400
X-MC-Unique: Oay8bKoXMxmAne_pCkEqlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED39F107B7E5;
 Tue,  7 Jul 2020 14:23:43 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-113.ams2.redhat.com
 [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAFF75BAC3;
 Tue,  7 Jul 2020 14:23:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1] file-posix: Mitigate file fragmentation with extent
 size hints
Date: Tue,  7 Jul 2020 16:23:29 +0200
Message-Id: <20200707142329.48303-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Espeically when O_DIRECT is used with image files so that the page cache
indirection can't cause a merge of allocating requests, the file will
fragment on the file system layer, with a potentially very small
fragment size (this depends on the requests the guest sent).

On Linux, fragmentation can be reduced by setting an extent size hint
when creating the file (at least on XFS, it can't be set any more after
the first extent has been allocated), basically giving raw files a
"cluster size" for allocation.

This adds an create option to set the extent size hint, and changes the
default from not setting a hint to setting it to 1 MB. The main reason
why qcow2 defaults to smaller cluster sizes is that COW becomes more
expensive, which is not an issue with raw files, so we can choose a
larger file. The tradeoff here is only potentially wasted disk space.

For qcow2 (or other image formats) over file-posix, the advantage should
even be greater because they grow sequentially without leaving holes, so
there won't be wasted space. Setting even larger extent size hints for
such images may make sense. This can be done with the new option, but
let's keep the default conservative for now.

The effect is very visible with a test that intentionally creates a
badly fragmented file with qemu-img bench (the time difference while
creating the file is already remarkable) and then looks at the number of
extents and the take a simple "qemu-img map" takes.

Without an extent size hint:

    $ ./qemu-img create -f raw -o extent_size_hint=0 ~/tmp/test.raw 10G
    Formatting '/home/kwolf/tmp/test.raw', fmt=raw size=10737418240 extent_size_hint=0
    $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S 8192 -o 0
    Sending 1000000 write requests, 4096 bytes each, 64 in parallel (starting at offset 0, step size 8192)
    Run completed in 25.848 seconds.
    $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S 8192 -o 4096
    Sending 1000000 write requests, 4096 bytes each, 64 in parallel (starting at offset 4096, step size 8192)
    Run completed in 19.616 seconds.
    $ filefrag ~/tmp/test.raw
    /home/kwolf/tmp/test.raw: 2000000 extents found
    $ time ./qemu-img map ~/tmp/test.raw
    Offset          Length          Mapped to       File
    0               0x1e8480000     0               /home/kwolf/tmp/test.raw

    real    0m1,279s
    user    0m0,043s
    sys     0m1,226s

With the new default extent size hint of 1 MB:

    $ ./qemu-img create -f raw -o extent_size_hint=1M ~/tmp/test.raw 10G
    Formatting '/home/kwolf/tmp/test.raw', fmt=raw size=10737418240 extent_size_hint=1048576
    $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S 8192 -o 0
    Sending 1000000 write requests, 4096 bytes each, 64 in parallel (starting at offset 0, step size 8192)
    Run completed in 11.833 seconds.
    $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S 8192 -o 4096
    Sending 1000000 write requests, 4096 bytes each, 64 in parallel (starting at offset 4096, step size 8192)
    Run completed in 10.155 seconds.
    $ filefrag ~/tmp/test.raw
    /home/kwolf/tmp/test.raw: 178 extents found
    $ time ./qemu-img map ~/tmp/test.raw
    Offset          Length          Mapped to       File
    0               0x1e8480000     0               /home/kwolf/tmp/test.raw

    real    0m0,061s
    user    0m0,040s
    sys     0m0,014s

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json      | 11 ++++++----
 include/block/block_int.h |  1 +
 block/file-posix.c        | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0e1c6a59f2..ddd3737d90 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4185,14 +4185,17 @@
 #                 falloc (if defined CONFIG_POSIX_FALLOCATE),
 #                 full (if defined CONFIG_POSIX))
 # @nocow: Turn off copy-on-write (valid only on btrfs; default: off)
+# @extent-size-hint: Extent size hint to add to the image file; 0 for not
+#                    adding an extent size hint (default: 1 MB, since 5.1)
 #
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsFile',
-  'data': { 'filename':         'str',
-            'size':             'size',
-            '*preallocation':   'PreallocMode',
-            '*nocow':           'bool' } }
+  'data': { 'filename':             'str',
+            'size':                 'size',
+            '*preallocation':       'PreallocMode',
+            '*nocow':               'bool',
+            '*extent-size-hint':    'size'} }
 
 ##
 # @BlockdevCreateOptionsGluster:
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 791de6a59c..03cd266948 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -53,6 +53,7 @@
 #define BLOCK_OPT_ADAPTER_TYPE      "adapter_type"
 #define BLOCK_OPT_REDUNDANCY        "redundancy"
 #define BLOCK_OPT_NOCOW             "nocow"
+#define BLOCK_OPT_EXTENT_SIZE_HINT  "extent_size_hint"
 #define BLOCK_OPT_OBJECT_SIZE       "object_size"
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
 #define BLOCK_OPT_DATA_FILE         "data_file"
diff --git a/block/file-posix.c b/block/file-posix.c
index 3ab8f5a0fa..1a74dd3565 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -30,6 +30,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/units.h"
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
@@ -2322,6 +2323,14 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     if (!file_opts->has_preallocation) {
         file_opts->preallocation = PREALLOC_MODE_OFF;
     }
+    if (!file_opts->has_extent_size_hint) {
+        file_opts->extent_size_hint = 1 * MiB;
+    }
+    if (file_opts->extent_size_hint > UINT32_MAX) {
+        result = -EINVAL;
+        error_setg(errp, "Extent size hint is too large");
+        goto out;
+    }
 
     /* Create file */
     fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
@@ -2379,6 +2388,25 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
         }
 #endif
     }
+#ifdef FS_IOC_FSSETXATTR
+    /*
+     * Try to set the extent size hint. Failure is not fatal, and a warning is
+     * only printed if the option was explicitly specified.
+     */
+    {
+        struct fsxattr attr;
+        result = ioctl(fd, FS_IOC_FSGETXATTR, &attr);
+        if (result == 0) {
+            attr.fsx_xflags |= FS_XFLAG_EXTSIZE;
+            attr.fsx_extsize = file_opts->extent_size_hint;
+            result = ioctl(fd, FS_IOC_FSSETXATTR, &attr);
+        }
+        if (result < 0 && file_opts->has_extent_size_hint) {
+            warn_report("Failed to set extent size hint: %s",
+                        strerror(errno));
+        }
+    }
+#endif
 
     /* Resize and potentially preallocate the file to the desired
      * final size */
@@ -2414,6 +2442,8 @@ static int coroutine_fn raw_co_create_opts(BlockDriver *drv,
 {
     BlockdevCreateOptions options;
     int64_t total_size = 0;
+    int64_t extent_size_hint = 0;
+    bool has_extent_size_hint = false;
     bool nocow = false;
     PreallocMode prealloc;
     char *buf = NULL;
@@ -2425,6 +2455,11 @@ static int coroutine_fn raw_co_create_opts(BlockDriver *drv,
     /* Read out options */
     total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
                           BDRV_SECTOR_SIZE);
+    if (qemu_opt_get(opts, BLOCK_OPT_EXTENT_SIZE_HINT)) {
+        has_extent_size_hint = true;
+        extent_size_hint =
+            qemu_opt_get_size_del(opts, BLOCK_OPT_EXTENT_SIZE_HINT, -1);
+    }
     nocow = qemu_opt_get_bool(opts, BLOCK_OPT_NOCOW, false);
     buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
     prealloc = qapi_enum_parse(&PreallocMode_lookup, buf,
@@ -2444,6 +2479,8 @@ static int coroutine_fn raw_co_create_opts(BlockDriver *drv,
             .preallocation      = prealloc,
             .has_nocow          = true,
             .nocow              = nocow,
+            .has_extent_size_hint = has_extent_size_hint,
+            .extent_size_hint   = extent_size_hint,
         },
     };
     return raw_co_create(&options, errp);
@@ -2937,6 +2974,11 @@ static QemuOptsList raw_create_opts = {
 #endif
                     ", full)"
         },
+        {
+            .name = BLOCK_OPT_EXTENT_SIZE_HINT,
+            .type = QEMU_OPT_SIZE,
+            .help = "Extent size hint for the image file, 0 to disable"
+        },
         { /* end of list */ }
     }
 };
-- 
2.25.4


