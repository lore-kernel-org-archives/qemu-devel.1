Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F023CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66712223E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 13:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kOMXtRs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66712223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYrbc-0001a4-I1
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 09:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYray-0000iV-JU; Wed, 13 May 2020 09:38:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jYrax-0005Bu-Cn; Wed, 13 May 2020 09:38:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DDXE2a164512;
 Wed, 13 May 2020 13:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=rUPZHNuSUsVradKy4beIPtnoBx/+30g1NxkePgtibM0=;
 b=kOMXtRs7kV/z7mtrhq+yF+RVdLruWGz3hWqbVI2E2P+ZoktAmQVD+gf0HKr81kuhnKrE
 izKtPZP9JS9bSZ+clZUjdDRW+U78oI9LEQyfjF8XKYthK+7FFQSaQPfIDnV76PbMdM82
 lkqAemEjsf1JfTbGBS/lqMeIt0sLi+FHoIqmg2YHcMKhT8NrRAos1SH2DlD4T/woQuRQ
 mGyC4NxwINa/aTWCV0uuJs0J97PqbTCn6UCq02ali6xT1Y9r0ASwtGmnM44V3xz4SVwa
 HCpyQtpUd5FVTodBBjl+IicWzgTL339/YjOa1Qo69XcplJedtZQcc+ZgAdBaAPjISmD8 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 3100yfv7f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 May 2020 13:38:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DDY393113679;
 Wed, 13 May 2020 13:36:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 3100yek9c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 13:36:44 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DDahtG021129;
 Wed, 13 May 2020 13:36:43 GMT
Received: from localhost.localdomain (/10.74.123.68)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 May 2020 06:36:43 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: 
Subject: [PATCH v3 1/1] qemu_img: add cvtnum_full to print error reports
Date: Wed, 13 May 2020 16:36:26 +0300
Message-Id: <20200513133629.18508-2-eyal.moscovici@oracle.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200513133629.18508-1-eyal.moscovici@oracle.com>
References: <20200513133629.18508-1-eyal.moscovici@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130121
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=eyal.moscovici@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 09:36:43
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
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
 liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All calls to cvtnum check the return value and print the same error message more
or less. And so error reporting moved to cvtnum_full to reduce code
duplication and provide a single error message. Additionally, cvtnum now wraps
cvtnum_full with the existing default range of 0 to MAX_INT64.

Acked-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 qemu-img.c                 | 76 +++++++++++++++++---------------------
 tests/qemu-iotests/049.out |  8 ++--
 2 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6a4327aaba..a4ce35abc5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -470,19 +470,31 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
     return 0;
 }
 
-static int64_t cvtnum(const char *s)
+static int64_t cvtnum_full(const char *name, const char *value, int64_t min,
+                           int64_t max)
 {
     int err;
-    uint64_t value;
-
-    err = qemu_strtosz(s, NULL, &value);
-    if (err < 0) {
+    uint64_t res;
+
+    err = qemu_strtosz(value, NULL, &res);
+    if (err < 0 && err != -ERANGE) {
+        error_report("Invalid %s specified. You may use "
+                     "k, M, G, T, P or E suffixes for ", name);
+        error_report("kilobytes, megabytes, gigabytes, terabytes, "
+                     "petabytes and exabytes.");
         return err;
     }
-    if (value > INT64_MAX) {
+    if (err == -ERANGE || res > max || res < min) {
+        error_report("Invalid %s specified. Must be between %ld bytes "
+                     "to %ld bytes.", name, min, max);
         return -ERANGE;
     }
-    return value;
+    return res;
+}
+
+static int64_t cvtnum(const char *name, const char *value)
+{
+    return cvtnum_full(name, value, 0, INT64_MAX);
 }
 
 static int img_create(int argc, char **argv)
@@ -572,16 +584,8 @@ static int img_create(int argc, char **argv)
     if (optind < argc) {
         int64_t sval;
 
-        sval = cvtnum(argv[optind++]);
+        sval = cvtnum("image size", argv[optind++]);
         if (sval < 0) {
-            if (sval == -ERANGE) {
-                error_report("Image size must be less than 8 EiB!");
-            } else {
-                error_report("Invalid image size specified! You may use k, M, "
-                      "G, T, P or E suffixes for ");
-                error_report("kilobytes, megabytes, gigabytes, terabytes, "
-                             "petabytes and exabytes.");
-            }
             goto fail;
         }
         img_size = (uint64_t)sval;
@@ -2187,8 +2191,10 @@ static int img_convert(int argc, char **argv)
         {
             int64_t sval;
 
-            sval = cvtnum(optarg);
-            if (sval < 0 || !QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
+            sval = cvtnum("buffer size for sparse output", optarg);
+            if (sval < 0) {
+                goto fail_getopt;
+            } else if (!QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
                 sval / BDRV_SECTOR_SIZE > MAX_BUF_SECTORS) {
                 error_report("Invalid buffer size for sparse output specified. "
                     "Valid sizes are multiples of %llu up to %llu. Select "
@@ -4291,9 +4297,8 @@ static int img_bench(int argc, char **argv)
             break;
         case 'o':
         {
-            offset = cvtnum(optarg);
+            offset = cvtnum("offset", optarg);
             if (offset < 0) {
-                error_report("Invalid offset specified");
                 return 1;
             }
             break;
@@ -4306,9 +4311,8 @@ static int img_bench(int argc, char **argv)
         {
             int64_t sval;
 
-            sval = cvtnum(optarg);
-            if (sval < 0 || sval > INT_MAX) {
-                error_report("Invalid buffer size specified");
+            sval = cvtnum_full("buffer size", optarg, 0, INT_MAX);
+            if (sval < 0) {
                 return 1;
             }
 
@@ -4319,9 +4323,8 @@ static int img_bench(int argc, char **argv)
         {
             int64_t sval;
 
-            sval = cvtnum(optarg);
-            if (sval < 0 || sval > INT_MAX) {
-                error_report("Invalid step size specified");
+            sval = cvtnum_full("step_size", optarg, 0, INT_MAX);
+            if (sval < 0) {
                 return 1;
             }
 
@@ -4491,10 +4494,9 @@ static int img_dd_bs(const char *arg,
 {
     int64_t res;
 
-    res = cvtnum(arg);
+    res = cvtnum_full("bs", arg, 1, INT_MAX);
 
-    if (res <= 0 || res > INT_MAX) {
-        error_report("invalid number: '%s'", arg);
+    if (res < 0) {
         return 1;
     }
     in->bsz = out->bsz = res;
@@ -4506,10 +4508,9 @@ static int img_dd_count(const char *arg,
                         struct DdIo *in, struct DdIo *out,
                         struct DdInfo *dd)
 {
-    dd->count = cvtnum(arg);
+    dd->count = cvtnum("count", arg);
 
     if (dd->count < 0) {
-        error_report("invalid number: '%s'", arg);
         return 1;
     }
 
@@ -4538,10 +4539,9 @@ static int img_dd_skip(const char *arg,
                        struct DdIo *in, struct DdIo *out,
                        struct DdInfo *dd)
 {
-    in->offset = cvtnum(arg);
+    in->offset = cvtnum("skip", arg);
 
     if (in->offset < 0) {
-        error_report("invalid number: '%s'", arg);
         return 1;
     }
 
@@ -4923,16 +4923,8 @@ static int img_measure(int argc, char **argv)
         {
             int64_t sval;
 
-            sval = cvtnum(optarg);
+            sval = cvtnum("image size", optarg);
             if (sval < 0) {
-                if (sval == -ERANGE) {
-                    error_report("Image size must be less than 8 EiB!");
-                } else {
-                    error_report("Invalid image size specified! You may use "
-                                 "k, M, G, T, P or E suffixes for ");
-                    error_report("kilobytes, megabytes, gigabytes, terabytes, "
-                                 "petabytes and exabytes.");
-                }
                 goto out;
             }
             img_size = (uint64_t)sval;
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index affa55b341..e00d311180 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -92,19 +92,19 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 l
 == 3. Invalid sizes ==
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: Invalid image size specified. Must be between 0 bytes to 9223372036854775807 bytes.
 
 qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Value '-1024' is out of range for parameter 'size'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: Invalid image size specified. Must be between 0 bytes to 9223372036854775807 bytes.
 
 qemu-img create -f qcow2 -o size=-1k TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Value '-1k' is out of range for parameter 'size'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
-qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
+qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=1kilobyte TEST_DIR/t.qcow2
@@ -113,7 +113,7 @@ Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
-qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
+qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=foobar TEST_DIR/t.qcow2
-- 
2.17.2 (Apple Git-113)


