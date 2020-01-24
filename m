Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D634EC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EF12070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mTA5uwvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EF12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwKr-000428-R8
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1iuwJv-0003A5-Uf
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1iuwJu-00064G-Im
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:36:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1iuwJr-0005tS-6w; Fri, 24 Jan 2020 05:36:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OANFkR051386;
 Fri, 24 Jan 2020 10:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=5GljaixeKsOYoXfgulGKQys/W9vJqv766ycj8860+Jw=;
 b=mTA5uwvc/+BJ9Vzt8Ju/fOzWtn3zJZVqqrEAnRmK7jzGYdMhqNipwKb9UiYz9h1LugvY
 A5LUfjFYO/7laAz9gmqaz0jYK3AIldJoKF9ykaQKri8fPTrv9jhdBt/IgMOu5noG9k8b
 luEM8c04rSYMGC7iWK5ybvVWBCp/uqRyWE0PgEw6VdKgDyj7u76yQ42d2myXtBhQQwez
 a5gWYpA0YBDApKiO1sgSc/7YY5+uS2swb4A5m4s42/MSKFhY/5L37nWo3NfBkOncRx2k
 IV98HfZ6VfmCbEd5yDmreT9IMu3rKMYPbtRzbReIiQV/LhZy9OMVLm0ku9rtqy5wygXu MQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2xksyqr7tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2020 10:36:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OAVIwT112194;
 Fri, 24 Jan 2020 10:36:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2xqmuepud9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2020 10:36:04 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00OAa3t8025711;
 Fri, 24 Jan 2020 10:36:03 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 24 Jan 2020 02:36:03 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 3b9029b8;
 Fri, 24 Jan 2020 10:36:00 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH v2 1/2] qemu-img: Add --target-is-zero to convert
Date: Fri, 24 Jan 2020 10:34:57 +0000
Message-Id: <20200124103458.1525982-2-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124103458.1525982-1-david.edmondson@oracle.com>
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240086
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
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
Cc: David Edmondson <david.edmondson@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In many cases the target of a convert operation is a newly provisioned
target that the user knows is blank (filled with zeroes). In this
situation there is no requirement for qemu-img to wastefully zero out
the entire device.

Add a new option, --target-is-zero, allowing the user to indicate that
an existing target device is already zero filled.

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
---
 qemu-img-cmds.hx |  4 ++--
 qemu-img.c       | 25 ++++++++++++++++++++++---
 qemu-img.texi    |  4 ++++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1c93e6d185..6f958a0a48 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -44,9 +44,9 @@ STEXI
 ETEXI
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
 STEXI
-@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] [--salvage] @var{filename} [@var{filename2} [...]] @var{output_filename}
+@item convert [--object @var{objectdef}] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] [--salvage] @var{filename} [@var{filename2} [...]] @var{output_filename}
 ETEXI
 
 DEF("create", img_create,
diff --git a/qemu-img.c b/qemu-img.c
index 6233b8ca56..46db72dbe0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -70,6 +70,7 @@ enum {
     OPTION_PREALLOCATION = 265,
     OPTION_SHRINK = 266,
     OPTION_SALVAGE = 267,
+    OPTION_TARGET_IS_ZERO = 268,
 };
 
 typedef enum OutputFormat {
@@ -1984,10 +1985,9 @@ static int convert_do_copy(ImgConvertState *s)
     int64_t sector_num = 0;
 
     /* Check whether we have zero initialisation or can get it efficiently */
-    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
+    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
+        !s->target_has_backing) {
         s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
-    } else {
-        s->has_zero_init = false;
     }
 
     if (!s->has_zero_init && !s->target_has_backing &&
@@ -2086,6 +2086,7 @@ static int img_convert(int argc, char **argv)
             {"force-share", no_argument, 0, 'U'},
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {"salvage", no_argument, 0, OPTION_SALVAGE},
+            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
@@ -2209,6 +2210,14 @@ static int img_convert(int argc, char **argv)
         case OPTION_TARGET_IMAGE_OPTS:
             tgt_image_opts = true;
             break;
+        case OPTION_TARGET_IS_ZERO:
+            /*
+             * The user asserting that the target is blank has the
+             * same effect as the target driver supporting zero
+             * initialisation.
+             */
+            s.has_zero_init = true;
+            break;
         }
     }
 
@@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
         warn_report("This will become an error in future QEMU versions.");
     }
 
+    if (s.has_zero_init && !skip_create) {
+        error_report("--target-is-zero requires use of -n flag");
+        goto fail_getopt;
+    }
+
     s.src_num = argc - optind - 1;
     out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
 
@@ -2380,6 +2394,11 @@ static int img_convert(int argc, char **argv)
     }
     s.target_has_backing = (bool) out_baseimg;
 
+    if (s.has_zero_init && s.target_has_backing) {
+        error_report("Cannot use --target-is-zero with a backing file");
+        goto out;
+    }
+
     if (s.src_num > 1 && out_baseimg) {
         error_report("Having a backing file for the target makes no sense when "
                      "concatenating multiple input images");
diff --git a/qemu-img.texi b/qemu-img.texi
index b5156d6316..3b6dfd8682 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -179,6 +179,10 @@ information.
 Try to ignore I/O errors when reading.  Unless in quiet mode (@code{-q}), errors
 will still be printed.  Areas that cannot be read from the source will be
 treated as containing only zeroes.
+@item --target-is-zero
+Assume that the destination is filled with zeros. This parameter is
+mutually exclusive with the use of a backing file. It is required to
+also use the @code{-n} parameter to skip image creation.
 @end table
 
 Parameters to dd subcommand:
-- 
2.24.1


