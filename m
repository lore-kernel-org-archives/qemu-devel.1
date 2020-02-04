Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB4C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB28F20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URLtLa/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB28F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv8k-0000eg-VT
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david.edmondson@oracle.com>) id 1iyutA-0005TB-52
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.edmondson@oracle.com>) id 1iyut8-0008OS-NP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:53:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.edmondson@oracle.com>)
 id 1iyut5-0008DN-CQ; Tue, 04 Feb 2020 04:52:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0149m90g134194;
 Tue, 4 Feb 2020 09:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=mL78wW22g1ArSNTmFkQFgj+08Vel93CIIJqNUH7+oj8=;
 b=URLtLa/lnZFxWbhgoFV9j0IVzj8/PF472kE49F8GEcw2z/3jK/fWP9Z53ms6ld8AFtzS
 aRLnq9xQ9WeT2o5xQ0MEyy7sc/Xgfu31knVob/YA9kKbF3TTiaq6RwYL9NfmOpjFUJ3s
 /mHNWx0HWub1mBpEenFBwyFgce12rZqwbf2+VC+wFbM9oSXKuKA+IjVGDOx6z8ZB+lzo
 kPJsvjYsgHHxvUanGcNv6QwNlF27GjQX+nUfi4ViGBrj/RiUaCIi/Fn5cfqlCju+8uop
 5ZdE8S9sEK5Oks0lxWpIshBjV5GrWHMMsyyVbP6qKUPJenyOfR/KsoUKshK2vhAptFac Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xwyg9hqvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 09:52:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0149nPkj177871;
 Tue, 4 Feb 2020 09:52:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2xxw0wjbuy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 09:52:52 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0149qpE2021518;
 Tue, 4 Feb 2020 09:52:51 GMT
Received: from disaster-area.hh.sledj.net (/81.149.164.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 04 Feb 2020 01:52:50 -0800
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id e2280f7b;
 Tue, 4 Feb 2020 09:52:48 +0000 (UTC)
From: David Edmondson <david.edmondson@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
Date: Tue,  4 Feb 2020 09:52:46 +0000
Message-Id: <20200204095246.1974117-2-david.edmondson@oracle.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204095246.1974117-1-david.edmondson@oracle.com>
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040073
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: David Edmondson <david.edmondson@oracle.com>, qemu-block@nongnu.org
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
 docs/interop/qemu-img.rst |  8 +++++++-
 qemu-img-cmds.hx          |  4 ++--
 qemu-img.c                | 25 ++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
index fa27e5c7b453..99bdbe4740ee 100644
--- a/docs/interop/qemu-img.rst
+++ b/docs/interop/qemu-img.rst
@@ -214,6 +214,12 @@ Parameters to convert subcommand:
   will still be printed.  Areas that cannot be read from the source will be
   treated as containing only zeroes.
 
+.. option:: --target-is-zero
+
+  Assume that the destination is filled with zeros. This parameter is
+  mutually exclusive with the use of a backing file. It is required to
+  also use the ``-n`` parameter to skip image creation.
+
 Parameters to dd subcommand:
 
 .. program:: qemu-img-dd
@@ -366,7 +372,7 @@ Command description:
   4
     Error on reading data
 
-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
 
   Convert the disk image *FILENAME* or a snapshot *SNAPSHOT_PARAM*
   to disk image *OUTPUT_FILENAME* using format *OUTPUT_FMT*. It can
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 3fd836ca9090..e6f98b75473f 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -39,9 +39,9 @@ SRST
 ERST
 
 DEF("convert", img_convert,
-    "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
+    "convert [--object objectdef] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filename")
 SRST
-.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
+.. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-opts] [--target-is-zero] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_SIZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT_FILENAME
 ERST
 
 DEF("create", img_create,
diff --git a/qemu-img.c b/qemu-img.c
index 2b4562b9d9f2..e0bfc33ef4f6 100644
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
-- 
2.24.1


