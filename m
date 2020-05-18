Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DC2C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E5A20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2qTwHaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E5A20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiju-0001Cu-I0
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaign-0005Ja-Kj
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24065
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jaigm-0003HE-97
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589819547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0aF8eppS+yvsU4EEHPHYd94QaqK4y//bjVQKPx5j1g=;
 b=J2qTwHaJ6k5PZECvg3XMdfVSqteR5w8WdJ7zgsEkgi0EaZ6VWI4Ion3nJju8NY7Nw1veib
 mTya/bcAk/XXaG2dN4FtO6bYr6TE6ikDC4URoBNOgbr+ALPaWaVlBAoufI0ICWKzcz2Ao8
 Xwt4kjI5pGyMl2UcImQeJLOJ5HIpilo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-owRo0MjtP2yk7Dtjy80DOA-1; Mon, 18 May 2020 12:32:25 -0400
X-MC-Unique: owRo0MjtP2yk7Dtjy80DOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2443EC1A0;
 Mon, 18 May 2020 16:32:23 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6858E5D9DC;
 Mon, 18 May 2020 16:32:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] qemu-img: Add --start-offset and --max-length to map
Date: Mon, 18 May 2020 11:32:17 -0500
Message-Id: <20200518163218.649412-6-eblake@redhat.com>
In-Reply-To: <20200518163218.649412-1-eblake@redhat.com>
References: <20200518163218.649412-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
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
 Max Reitz <mreitz@redhat.com>, Yoav Elnekave <yoav.elnekave@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eyal Moscovici <eyal.moscovici@oracle.com>

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
Message-Id: <20200513133629.18508-5-eyal.moscovici@oracle.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/tools/qemu-img.rst |  2 +-
 qemu-img.c              | 22 +++++++++++++++++++++-
 qemu-img-cmds.hx        |  4 ++--
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 0080f83a76c9..f4ffe528ea83 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -519,7 +519,7 @@ Command description:
     ``ImageInfoSpecific*`` QAPI object (e.g. ``ImageInfoSpecificQCow2``
     for qcow2 images).

-.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [-U] FILENAME
+.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--start-offset=OFFSET] [--max-length=LEN] [--output=OFMT] [-U] FILENAME

   Dump the metadata of image *FILENAME* and its backing file chain.
   In particular, this commands dumps the allocation state of every sector
diff --git a/qemu-img.c b/qemu-img.c
index 4aa9414aba6f..947bf8b34b3d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3009,6 +3009,8 @@ static int img_map(int argc, char **argv)
     int ret = 0;
     bool image_opts = false;
     bool force_share = false;
+    int64_t start_offset = 0;
+    int64_t max_length = -1;

     fmt = NULL;
     output = NULL;
@@ -3021,9 +3023,11 @@ static int img_map(int argc, char **argv)
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
@@ -3047,6 +3051,18 @@ static int img_map(int argc, char **argv)
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
@@ -3097,7 +3113,11 @@ static int img_map(int argc, char **argv)
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
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index c9c54de1df40..35f832816f96 100644
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
-- 
2.26.2


