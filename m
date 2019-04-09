Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA04C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74326208C0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74326208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42851 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDsC6-0002aZ-Pf
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:57:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDsAv-0001us-Tg
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDsAu-0006mN-NM
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:56:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:39716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDsAu-0006lJ-BP; Tue, 09 Apr 2019 10:56:36 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDsAr-0007rL-4N; Tue, 09 Apr 2019 17:56:33 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  9 Apr 2019 17:56:31 +0300
Message-Id:
 <1554821792-968307-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/2] qemu-img convert: ignore read errors
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
	andrey.shinkevich@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409145631.-RMOjEJni4-53d4YoLPcd9OWLA6V2wULpKy8ygfcsKw@z>

The 'qemu-img convert' new command option 'force read' with the key '-R'
allows converting a damaged image to get all the available information
in case of the read errors. The program reports read errors and continue
the image conversion. The users should keep in their minds that the
resulting image is inconsistent.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 qemu-img-cmds.hx |  4 ++--
 qemu-img.c       | 18 ++++++++++++++++--
 qemu-img.texi    |  2 +-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1526f32..09af9cb 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -44,9 +44,9 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-R] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-R] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("create", img_create,
diff --git a/qemu-img.c b/qemu-img.c
index aa6f81f..494e880 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -175,6 +175,7 @@ static void QEMU_NORETURN help(void)
            "Parameters to convert subcommand:\n"
            "  '-m' specifies how many coroutines work in parallel during the convert\n"
            "       process (defaults to 8)\n"
+           "  '-R' continue the image conversion in case of the sector read error\n"
            "  '-W' allow to write to the target out of order rather than sequential\n"
            "\n"
            "Parameters to snapshot subcommand:\n"
@@ -1579,6 +1580,7 @@ typedef struct ImgConvertState {
     int64_t wait_sector_num[MAX_COROUTINES];
     CoMutex lock;
     int ret;
+    bool force_read;
 } ImgConvertState;
 
 static void convert_select_part(ImgConvertState *s, int64_t sector_num,
@@ -1693,7 +1695,15 @@ static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sector_num,
                 blk, (sector_num - src_cur_offset) << BDRV_SECTOR_BITS,
                 n << BDRV_SECTOR_BITS, &qiov, 0);
         if (ret < 0) {
-            return ret;
+            if (!s->force_read) {
+                return ret;
+            }
+            int64_t offset = (sector_num - src_cur_offset) << BDRV_SECTOR_BITS;
+            unsigned int bytes = n << BDRV_SECTOR_BITS;
+            error_report("failed to read %d bytes at offset %" PRId64 ": %s",
+                         bytes, offset, strerror(-ret));
+            memset(buf, 0, n * BDRV_SECTOR_SIZE);
+            /* TODO: retry to read smaller chunks */
         }
 
         sector_num += n;
@@ -2018,6 +2028,7 @@ static int img_convert(int argc, char **argv)
         .buf_sectors        = IO_BUF_SIZE / BDRV_SECTOR_SIZE,
         .wr_in_order        = true,
         .num_coroutines     = 8,
+        .force_read         = false,
     };
 
     for(;;) {
@@ -2029,7 +2040,7 @@ static int img_convert(int argc, char **argv)
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
+        c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:RWU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2132,6 +2143,9 @@ static int img_convert(int argc, char **argv)
         case 'U':
             force_share = true;
             break;
+        case 'R':
+            s.force_read = true;
+            break;
         case OPTION_OBJECT: {
             QemuOpts *object_opts;
             object_opts = qemu_opts_parse_noisily(&qemu_object_opts,
diff --git a/qemu-img.texi b/qemu-img.texi
index 3b6710a..94f7d80 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -325,7 +325,7 @@ Error on reading data
 
 @end table
 
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-R] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
 
 Convert the disk image @var{filename} or a snapshot @var{snapshot_param}
 to disk image @var{output_filename} using format @var{output_fmt}. It can be optionally compressed (@code{-c}
-- 
1.8.3.1


