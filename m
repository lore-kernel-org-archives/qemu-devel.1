Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04D0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897B220708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4aYMWJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897B220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqkZ-0002dI-PB
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZT-0007dH-Cw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:35:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52861
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZQ-00046p-LU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594139748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMcWg280qwj4dY28QYW9fIHWQGMPslj2ZzyqLEbKb/M=;
 b=Q4aYMWJ5RFDOrkAvRjnX2uboyz/Cgba1dE6RSCncRd1/w4jItJ7Ij/dS3uYJvdhY1jDKVz
 Iz3s7pzbzC6M10ovAur2dBgmE89StOTw8wKey+rsViq6Z4afsqjo+NqyzBF+9uhcFiR+KM
 P6z7Y9nE05q6nOgdRoaGwp5GmXYfiLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-3UN0mP0wPeuUeIU-uDYGGg-1; Tue, 07 Jul 2020 12:35:44 -0400
X-MC-Unique: 3UN0mP0wPeuUeIU-uDYGGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093AD102C817;
 Tue,  7 Jul 2020 16:35:43 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-113.ams2.redhat.com
 [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 950A97849E;
 Tue,  7 Jul 2020 16:35:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/12] file-posix: Mitigate file fragmentation with extent size
 hints
Date: Tue,  7 Jul 2020 18:34:54 +0200
Message-Id: <20200707163504.194740-3-kwolf@redhat.com>
In-Reply-To: <20200707163504.194740-1-kwolf@redhat.com>
References: <20200707163504.194740-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Especially when O_DIRECT is used with image files so that the page cache
indirection can't cause a merge of allocating requests, the file will
fragment on the file system layer, with a potentially very small
fragment size (this depends on the requests the guest sent).

On Linux, fragmentation can be reduced by setting an extent size hint
when creating the file (at least on XFS, it can't be set any more after
the first extent has been allocated), basically giving raw files a
"cluster size" for allocation.

This adds a create option to set the extent size hint, and changes the
default from not setting a hint to setting it to 1 MB. The main reason
why qcow2 defaults to smaller cluster sizes is that COW becomes more
expensive, which is not an issue with raw files, so we can choose a
larger size. The tradeoff here is only potentially wasted disk space.

For qcow2 (or other image formats) over file-posix, the advantage should
even be greater because they grow sequentially without leaving holes, so
there won't be wasted space. Setting even larger extent size hints for
such images may make sense. This can be done with the new option, but
let's keep the default conservative for now.

The effect is very visible with a test that intentionally creates a
badly fragmented file with qemu-img bench (the time difference while
creating the file is already remarkable) and then looks at the number of
extents and the time a simple "qemu-img map" takes.

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
Message-Id: <20200707142329.48303-1-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json       | 11 ++++++----
 include/block/block_int.h  |  1 +
 block/file-posix.c         | 42 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/082.out | 16 +++++++++++++++
 tests/qemu-iotests/243     |  7 ++++---
 tests/qemu-iotests/243.out | 16 +++++++--------
 6 files changed, 78 insertions(+), 15 deletions(-)

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
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 529a1214e1..a65e185179 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -62,6 +62,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -86,6 +87,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -110,6 +112,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -134,6 +137,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -158,6 +162,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -182,6 +187,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -206,6 +212,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -230,6 +237,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -353,6 +361,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -377,6 +386,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -401,6 +411,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -425,6 +436,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -449,6 +461,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -473,6 +486,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -497,6 +511,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -521,6 +536,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
index a61852f6d9..17388a4644 100755
--- a/tests/qemu-iotests/243
+++ b/tests/qemu-iotests/243
@@ -51,7 +51,7 @@ for mode in off metadata falloc full; do
     echo "=== preallocation=$mode ==="
     echo
 
-    _make_test_img -o "preallocation=$mode" 64M
+    _make_test_img -o "preallocation=$mode,extent_size_hint=0" 64M
 
     printf "File size: "
     du -b $TEST_IMG | cut -f1
@@ -68,7 +68,8 @@ for mode in off metadata falloc full; do
     echo "=== External data file: preallocation=$mode ==="
     echo
 
-    _make_test_img -o "data_file=$TEST_IMG.data,preallocation=$mode" 64M
+    _make_test_img \
+        -o "data_file=$TEST_IMG.data,preallocation=$mode,extent_size_hint=0" 64M
 
     echo -n "qcow2 file size: "
     du -b $TEST_IMG | cut -f1
@@ -79,7 +80,7 @@ for mode in off metadata falloc full; do
     echo -n "qcow2 disk usage: "
     [ $(du -B1 $TEST_IMG | cut -f1) -lt 1048576 ] && echo "low" || echo "high"
     echo -n "data disk usage:  "
-    [ $(du -B1 $TEST_IMG.data | cut -f1) -lt 1048576 ] && echo "low" || echo "high"
+    [ $(du -B1 $TEST_IMG.data | cut -f1) -lt 2097152 ] && echo "low" || echo "high"
 
 done
 
diff --git a/tests/qemu-iotests/243.out b/tests/qemu-iotests/243.out
index dcb33fac32..8bd3d79d66 100644
--- a/tests/qemu-iotests/243.out
+++ b/tests/qemu-iotests/243.out
@@ -2,31 +2,31 @@ QA output created by 243
 
 === preallocation=off ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=off extent_size_hint=0
 File size: 196616
 Disk usage: low
 
 === preallocation=metadata ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=metadata extent_size_hint=0
 File size: 67436544
 Disk usage: low
 
 === preallocation=falloc ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=falloc extent_size_hint=0
 File size: 67436544
 Disk usage: high
 
 === preallocation=full ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=full extent_size_hint=0
 File size: 67436544
 Disk usage: high
 
 === External data file: preallocation=off ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=off extent_size_hint=0
 qcow2 file size: 196616
 data file size:  67108864
 qcow2 disk usage: low
@@ -34,7 +34,7 @@ data disk usage:  low
 
 === External data file: preallocation=metadata ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=metadata extent_size_hint=0
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
@@ -42,7 +42,7 @@ data disk usage:  low
 
 === External data file: preallocation=falloc ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=falloc extent_size_hint=0
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
@@ -50,7 +50,7 @@ data disk usage:  high
 
 === External data file: preallocation=full ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=full extent_size_hint=0
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
-- 
2.25.4


