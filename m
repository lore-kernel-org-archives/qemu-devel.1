Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10D3C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 14:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7711B20663
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 14:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lEHlu2uB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7711B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46909 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG1tO-0007Gy-J3
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 10:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eyal.moscovici@oracle.com>) id 1jFwdy-0005pc-F8
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 05:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eyal.moscovici@oracle.com>) id 1jFwdv-00015o-PL
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 05:11:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jFwds-000149-H7; Sun, 22 Mar 2020 05:11:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02M9AEI1121158;
 Sun, 22 Mar 2020 09:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=4TKHpg48FG+WYR853DyAmnpjVBnplNSfECTD8ZLEO7A=;
 b=lEHlu2uB8/uxEUErYkUkN+z+5aLsWugZPcIEjbZwTAvaN5PchXoT6nYxwIyI1Tnuod7X
 hYSYW3b0FkObTXVmYY3ejByDFK6NG7CjPYa0bduJ3MUa5yzKV84iBIPSE4VbgDppJytH
 bdRI24QSBkcfgD37kxPqKkSI3dM/nnZgM1GCaXelq+S9cvmOW+uSOu5thLkk2c5AbFNe
 fikgfshhxT1r0nSjiChhuKduy1L8XGGBS/0xSpMc7mtYIRipn9+KXuTq8FT7mMnp3/eL
 tBQjfQhODw2mdoSt2iFZfc0UX9GOKcZ4Nio2cC+C5IeCs29kWF7lJABTYqWBipefBGkc fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2ywbjmtm0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Mar 2020 09:11:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02M92gNC068686;
 Sun, 22 Mar 2020 09:11:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2ywvmtye8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Mar 2020 09:11:35 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02M9BY3n003697;
 Sun, 22 Mar 2020 09:11:34 GMT
Received: from localhost.localdomain (/10.74.126.182)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 22 Mar 2020 02:11:33 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qemu-img: Add --start-offset and --max-length to map
Date: Sun, 22 Mar 2020 11:11:17 +0200
Message-Id: <20200322091117.79443-3-eyal.moscovici@oracle.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200322091117.79443-1-eyal.moscovici@oracle.com>
References: <20200322091117.79443-1-eyal.moscovici@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=1 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=1 impostorscore=0
 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003220053
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
X-Mailman-Approved-At: Sun, 22 Mar 2020 10:44:45 -0400
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Moscovici <eyal.moscovici@oracle.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, liran.alon@oracle.com,
 Yoav Elnekave <yoav.elnekave@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mapping operation of large disks especially ones stored over a
long chain of QCOW2 files can take a long time to finish.
Additionally when mapping fails there was no way recover by
restarting the mapping from the failed location.

The new options, --start-offset and --max-length allows the user to
divide these type of map operations into shorter independent tasks.

Acked-by: Mark Kanda <mark.kanda@oracle.com>
Co-developed-by: Yoav Elnekave <yoav.elnekave@oracle.com>
Signed-off-by: Yoav Elnekave <yoav.elnekave@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 docs/tools/qemu-img.rst |  2 +-
 qemu-img-cmds.hx        |  4 ++--
 qemu-img.c              | 30 +++++++++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 0080f83a76..924e89f679 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -519,7 +519,7 @@ Command description:
     ``ImageInfoSpecific*`` QAPI object (e.g. ``ImageInfoSpecificQCow2``
     for qcow2 images).
 
-.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [-U] FILENAME
+.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--start-offset=offset] [--max-length=len] [--output=OFMT] [-U] FILENAME
 
   Dump the metadata of image *FILENAME* and its backing file chain.
   In particular, this commands dumps the allocation state of every sector
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index c9c54de1df..35f832816f 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -63,9 +63,9 @@ SRST
 ERST
 
 DEF("map", img_map,
-    "map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename")
+    "map [--object objectdef] [--image-opts] [-f fmt] [--start-offset=offset] [--max-length=len] [--output=ofmt] [-U] filename")
 SRST
-.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [-U] FILENAME
+.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--start-offset=OFFSET] [--max-length=LEN] [--output=OFMT] [-U] FILENAME
 ERST
 
 DEF("measure", img_measure,
diff --git a/qemu-img.c b/qemu-img.c
index 9cf8576217..cd365b275e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2967,6 +2967,8 @@ static int img_map(int argc, char **argv)
     int ret = 0;
     bool image_opts = false;
     bool force_share = false;
+    int64_t start_offset = 0;
+    int64_t max_length = -1;
 
     fmt = NULL;
     output = NULL;
@@ -2979,9 +2981,11 @@ static int img_map(int argc, char **argv)
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"force-share", no_argument, 0, 'U'},
+            {"start-offset", required_argument, 0, 's'},
+            {"max-length", required_argument, 0, 'l'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:hU",
+        c = getopt_long(argc, argv, ":f:s:l:hU",
                         long_options, &option_index);
         if (c == -1) {
             break;
@@ -3005,6 +3009,26 @@ static int img_map(int argc, char **argv)
         case OPTION_OUTPUT:
             output = optarg;
             break;
+        case 's':
+            start_offset = cvtnum(optarg);
+            if (start_offset < 0) {
+                error_report("Invalid start offset specified! You may use "
+                             "k, M, G, T, P or E suffixes for ");
+                error_report("kilobytes, megabytes, gigabytes, terabytes, "
+                             "petabytes and exabytes.");
+                return 1;
+            }
+            break;
+        case 'l':
+            max_length = cvtnum(optarg);
+            if (max_length < 0) {
+                error_report("Invalid max length specified! You may use "
+                             "k, M, G, T, P or E suffixes for ");
+                error_report("kilobytes, megabytes, gigabytes, terabytes, "
+                             "petabytes and exabytes.");
+                return 1;
+            }
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -3050,7 +3074,11 @@ static int img_map(int argc, char **argv)
         printf("[");
     }
 
+    curr.start = start_offset;
     length = blk_getlength(blk);
+    if (max_length != -1) {
+        length = MIN(start_offset + max_length, length);
+    }
     while (curr.start + curr.length < length) {
         int64_t offset = curr.start + curr.length;
         int64_t n;
-- 
2.17.2 (Apple Git-113)


