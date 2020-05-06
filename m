Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC833C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F582070B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q9LeDFHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F582070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWRlk-0004iy-Ns
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 17:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWRhd-0007Da-UE; Wed, 06 May 2020 17:35:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWRhc-0008BP-HO; Wed, 06 May 2020 17:35:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046LJIuR099860;
 Wed, 6 May 2020 21:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=hbXlgDGqtdlxUDisBUtKc5JIY9Tow9V2NgxslTx1slM=;
 b=q9LeDFHicNRLckjUd2VOgdEzeYqU0uKZhT0RZu8UpfAX45gA2S9XGrUIeTj22ay0w6Hd
 /LpECSoSX7W7GPv80OV92m3PcgYI/rh5tvaM70SIoQKp35T2BdBRqicAM8BhxVBB01Sz
 UOg1agluIVXkqDxh7Vy3Vs1wrDO3kNS5vGabvvW+CwHaS+5LfViZcj2007bZZpqfr307
 M2NgSo49AlOYipfaTUkgpBOMqRe4Zhk51MdpWJ3zPKIHC6VZg52wjxW86pjtWuZWmbOB
 G+SETJDfbCmWf2TMnAAclIXE6/yFn6x7Ru/+NLbxnrjt9kQkD0s3cCInQfpnMSeGjCGA RQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 30usgq3y99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 21:35:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046LHmtX039635;
 Wed, 6 May 2020 21:35:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 30t1r8ssam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 21:35:38 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046LZbqm017882;
 Wed, 6 May 2020 21:35:37 GMT
Received: from localhost.localdomain (/10.74.121.228)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 May 2020 14:35:36 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: 
Subject: [PATCH v2 5/5] qemu-img: Add --start-offset and --max-length to map
Date: Thu,  7 May 2020 00:34:59 +0300
Message-Id: <20200506213459.44743-6-eyal.moscovici@oracle.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200506213459.44743-1-eyal.moscovici@oracle.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060172
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=eyal.moscovici@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 17:35:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Moscovici <eyal.moscovici@oracle.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 liran.alon@oracle.com, Yoav Elnekave <yoav.elnekave@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mapping operation of large disks especially ones stored over a
long chain of QCOW2 files can take a long time to finish.
Additionally when mapping fails there was no way recover by
restarting the mapping from the failed location.

The new options, --start-offset and --max-length allows the user to
divide these type of map operations into shorter independent tasks.

Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Mark Kanda <mark.kanda@oracle.com>
Co-developed-by: Yoav Elnekave <yoav.elnekave@oracle.com>
Signed-off-by: Yoav Elnekave <yoav.elnekave@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 docs/tools/qemu-img.rst |  2 +-
 qemu-img-cmds.hx        |  4 ++--
 qemu-img.c              | 22 +++++++++++++++++++++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 0080f83a76..f4ffe528ea 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -519,7 +519,7 @@ Command description:
     ``ImageInfoSpecific*`` QAPI object (e.g. ``ImageInfoSpecificQCow2``
     for qcow2 images).
 
-.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [-U] FILENAME
+.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--start-offset=OFFSET] [--max-length=LEN] [--output=OFMT] [-U] FILENAME
 
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
index 0a140fe564..f59b2c0a7c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3003,6 +3003,8 @@ static int img_map(int argc, char **argv)
     int ret = 0;
     bool image_opts = false;
     bool force_share = false;
+    int64_t start_offset = 0;
+    int64_t max_length = -1;
 
     fmt = NULL;
     output = NULL;
@@ -3015,9 +3017,11 @@ static int img_map(int argc, char **argv)
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
@@ -3041,6 +3045,18 @@ static int img_map(int argc, char **argv)
         case OPTION_OUTPUT:
             output = optarg;
             break;
+        case 's':
+            start_offset = cvtnum("start offset", optarg);
+            if (start_offset < 0) {
+                return 1;
+            }
+            break;
+        case 'l':
+            max_length = cvtnum("max length", optarg);
+            if (max_length < 0) {
+                return 1;
+            }
+            break;
         case OPTION_OBJECT: {
             QemuOpts *opts;
             opts = qemu_opts_parse_noisily(&qemu_object_opts,
@@ -3091,7 +3107,11 @@ static int img_map(int argc, char **argv)
         error_report("Failed to get size for '%s'", filename);
         return 1;
     }
+    if (max_length != -1) {
+        length = MIN(start_offset + max_length, length);
+    }
 
+    curr.start = start_offset;
     while (curr.start + curr.length < length) {
         int64_t offset = curr.start + curr.length;
         int64_t n;
-- 
2.17.2 (Apple Git-113)


