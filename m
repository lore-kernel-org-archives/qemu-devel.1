Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B344B20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Chq74P1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B344B20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaik8-0001Zj-Sl
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaign-0005IH-1s
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37220
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaigk-0003DS-N0
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589819545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oii076EEtIpLbw2zbK/UeFHcdIxo/eOwUrg1PeUKOQo=;
 b=Chq74P1oUXwQk+Az6fyM0Myzmw2/i6DJWt29Sj4VCx/K0xvSvYPyR9po66bzklGeSLhajK
 uFYLwVaC+URSP3EKzWVLkEKvFc5c/4QRIO/BQxa1CukoilGMIbd3NQ7zrp2q0AJORsTsSk
 Ks64ouFkDHCWPJ6JaelRXcHQtJLzMuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-uUGmwDcHMvmY0_j0MYoOTA-1; Mon, 18 May 2020 12:32:22 -0400
X-MC-Unique: uUGmwDcHMvmY0_j0MYoOTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D311B107ACF7;
 Mon, 18 May 2020 16:32:21 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52F9A5D9DC;
 Mon, 18 May 2020 16:32:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] qemu_img: add cvtnum_full to print error reports
Date: Mon, 18 May 2020 11:32:14 -0500
Message-Id: <20200518163218.649412-3-eblake@redhat.com>
In-Reply-To: <20200518163218.649412-1-eblake@redhat.com>
References: <20200518163218.649412-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eyal Moscovici <eyal.moscovici@oracle.com>

All calls to cvtnum check the return value and print the same error
message more or less. And so error reporting moved to cvtnum_full to
reduce code duplication and provide a single error
message. Additionally, cvtnum now wraps cvtnum_full with the existing
default range of 0 to MAX_INT64.

Acked-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Message-Id: <20200513133629.18508-2-eyal.moscovici@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: fix printf formatting, avoid trailing space, change error wording,
reformat commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c                 | 74 +++++++++++++++++---------------------
 tests/qemu-iotests/049.out |  8 ++---
 2 files changed, 37 insertions(+), 45 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6a4327aaba56..5d824fc15f39 100644
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
+    uint64_t res;

-    err = qemu_strtosz(s, NULL, &value);
-    if (err < 0) {
+    err = qemu_strtosz(value, NULL, &res);
+    if (err < 0 && err != -ERANGE) {
+        error_report("Invalid %s specified. You may use "
+                     "k, M, G, T, P or E suffixes for", name);
+        error_report("kilobytes, megabytes, gigabytes, terabytes, "
+                     "petabytes and exabytes.");
         return err;
     }
-    if (value > INT64_MAX) {
+    if (err == -ERANGE || res > max || res < min) {
+        error_report("Invalid %s specified. Must be between %" PRId64
+                     " and %" PRId64 ".", name, min, max);
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
index a5cfba175626..c54ae21b868a 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -92,19 +92,19 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 l
 == 3. Invalid sizes ==

 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.

 qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Value '-1024' is out of range for parameter 'size'

 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.

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
2.26.2


