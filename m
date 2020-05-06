Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22AAC47257
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3EF2070B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JPXYcFi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3EF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWRil-0008Ou-OH
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 17:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWRhR-0006wz-V6; Wed, 06 May 2020 17:35:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eyal.moscovici@oracle.com>)
 id 1jWRhQ-0007HT-J0; Wed, 06 May 2020 17:35:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046LJG2N099741;
 Wed, 6 May 2020 21:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=KfZMoZ7bnwZv2BOgcPIdtmUUQ0+cdV+ar33s6cn9D04=;
 b=JPXYcFi3KIh2jVZ7A3U7Zf2ZiOQkbRX2AKnYqKDAQU2WUQmo90ZdgQ+N8P7+NMOeF4RW
 r+D0LN0G0XcgU3s4573RZ1WMzMDZ7D526gekj6ih6z9qBv36MV4hSSxqAYo2qzDiVk+t
 O628XT5+TldekmLPwTHWBkzSugvdWDRJXLPr7w8uv9/t2uWVAagTNOeoqt7Sfx9rozfY
 +iKgJCKB9XHsK9PlYTtBNRg/+TwM83haKAN/xGjGhnDQz5ypWiStIyTU2oAr8robbsUN
 2YRaDLAVmSjr86M6DzfNKTNv0N8rOwCt4rb5rHbDT/wBB0xr1Lj5lYy+jKFF7+Pc8NK7 Ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 30usgq3y8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 21:35:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046LHnku039740;
 Wed, 6 May 2020 21:35:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 30t1r8ss1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 21:35:25 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046LZONI017970;
 Wed, 6 May 2020 21:35:24 GMT
Received: from localhost.localdomain (/10.74.121.228)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 May 2020 14:35:24 -0700
From: Eyal Moscovici <eyal.moscovici@oracle.com>
To: 
Subject: [PATCH v2 2/5] qemu_img: add error report to cvtnum
Date: Thu,  7 May 2020 00:34:56 +0300
Message-Id: <20200506213459.44743-3-eyal.moscovici@oracle.com>
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
 liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All calls to cvtnum check the return value and print the same error message more
or less. And so error reporting moved to cvtnum to reduce duplicate code and
provide a single error message.

Acked-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
---
 qemu-img.c                 | 63 ++++++++++++++++----------------------
 tests/qemu-iotests/049.out |  4 +--
 2 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 116a9c6349..4a06ab7fe8 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -470,16 +470,22 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
     return 0;
 }
 
-static int64_t cvtnum(const char *s)
+static int64_t cvtnum(const char *arg_name, const char *arg_value)
 {
     int err;
     uint64_t value;
 
-    err = qemu_strtosz(s, NULL, &value);
-    if (err < 0) {
+    err = qemu_strtosz(arg_value, NULL, &value);
+    if (err < 0 && err != -ERANGE) {
+        error_report("Invalid %s specified! You may use "
+                     "k, M, G, T, P or E suffixes for ", arg_name);
+        error_report("kilobytes, megabytes, gigabytes, terabytes, "
+                     "petabytes and exabytes.");
         return err;
     }
-    if (value > INT64_MAX) {
+    if (err == -ERANGE || value > INT64_MAX) {
+        error_report("Invalid %s specified! Must be less than 8 EiB!",
+                     arg_name);
         return -ERANGE;
     }
     return value;
@@ -572,16 +578,8 @@ static int img_create(int argc, char **argv)
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
@@ -2187,8 +2185,10 @@ static int img_convert(int argc, char **argv)
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
@@ -4291,9 +4291,8 @@ static int img_bench(int argc, char **argv)
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
@@ -4306,9 +4305,8 @@ static int img_bench(int argc, char **argv)
         {
             int64_t sval;
 
-            sval = cvtnum(optarg);
+            sval = cvtnum("buffer size", optarg);
             if (sval < 0) {
-                error_report("Invalid buffer size specified");
                 return 1;
             }
 
@@ -4319,9 +4317,8 @@ static int img_bench(int argc, char **argv)
         {
             int64_t sval;
 
-            sval = cvtnum(optarg);
+            sval = cvtnum("step_size", optarg);
             if (sval < 0) {
-                error_report("Invalid step size specified");
                 return 1;
             }
 
@@ -4491,10 +4488,12 @@ static int img_dd_bs(const char *arg,
 {
     int64_t res;
 
-    res = cvtnum(arg);
+    res = cvtnum("bs", arg);
 
-    if (res <= 0) {
-        error_report("invalid number: '%s'", arg);
+    if (res < 0) {
+        return 1;
+    } else if (res == 0) {
+        error_report("Invalid bs specified! It cannot be 0.");
         return 1;
     }
     in->bsz = out->bsz = res;
@@ -4506,10 +4505,9 @@ static int img_dd_count(const char *arg,
                         struct DdIo *in, struct DdIo *out,
                         struct DdInfo *dd)
 {
-    dd->count = cvtnum(arg);
+    dd->count = cvtnum("count", arg);
 
     if (dd->count < 0) {
-        error_report("invalid number: '%s'", arg);
         return 1;
     }
 
@@ -4538,10 +4536,9 @@ static int img_dd_skip(const char *arg,
                        struct DdIo *in, struct DdIo *out,
                        struct DdInfo *dd)
 {
-    in->offset = cvtnum(arg);
+    in->offset = cvtnum("skip", arg);
 
     if (in->offset < 0) {
-        error_report("invalid number: '%s'", arg);
         return 1;
     }
 
@@ -4923,16 +4920,8 @@ static int img_measure(int argc, char **argv)
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
index affa55b341..0ec2e6b82e 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -92,13 +92,13 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 l
 == 3. Invalid sizes ==
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: Invalid image size specified! Must be less than 8 EiB!
 
 qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Value '-1024' is out of range for parameter 'size'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: Invalid image size specified! Must be less than 8 EiB!
 
 qemu-img create -f qcow2 -o size=-1k TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Value '-1k' is out of range for parameter 'size'
-- 
2.17.2 (Apple Git-113)


