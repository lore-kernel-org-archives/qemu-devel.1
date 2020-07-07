Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033A5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25E120708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0HAuCiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25E120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqjm-0001Cb-US
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZh-00083o-Co
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35164
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZf-0004E2-Hk
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594139762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d5RAa4IkRRtpkwW+Lhk3rW/uSVH67xU3i6P+7DcfEOU=;
 b=C0HAuCiEJPM3TAGaK59qIblXk+EL3yhFi/dPtvWmkXj6H4zUOnYU0nYDfacyUY6tFj4ikJ
 8SXYgqyzJ25e+AxM9zoOk+s70MMfANSm1N9NMN5NOwWUtlJAobTwI5urq8Cb5r72hJTqTX
 edbAGKkL5qx2k4fLbGvhRWUAfEeA7Ho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-9kaSeznfNqeToCPPqkxEiQ-1; Tue, 07 Jul 2020 12:35:53 -0400
X-MC-Unique: 9kaSeznfNqeToCPPqkxEiQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F9CC10506E2;
 Tue,  7 Jul 2020 16:35:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-113.ams2.redhat.com
 [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE55D512FE;
 Tue,  7 Jul 2020 16:35:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/12] block: Error if backing file fails during creation
 without -u
Date: Tue,  7 Jul 2020 18:35:00 +0200
Message-Id: <20200707163504.194740-9-kwolf@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Eric Blake <eblake@redhat.com>

Back in commit 6e6e55f5 (Jul 2017, v2.10), we tweaked the code to warn
if the backing file could not be opened but the user gave a size,
unless the user also passes the -u option to bypass the open of the
backing file.  As one common reason for failure to open the backing
file is when there is mismatch in the requested backing format in
relation to what the backing file actually contains, we actually want
to open the backing file and ensure that it has the right format in as
many cases as possible.  iotest 293 for qcow demonstrates how
detecting explicit format mismatch is useful to prevent the creation
of an image that would probe differently than the user requested.  Now
is the time to finally turn the warning an error, as promised.

Note that the original warning was added prior to our documentation of
an official deprecation policy (eb22aeca, also Jul 2017), and because
the warning didn't mention the word "deprecated", we never actually
remembered to document it as such.  But the warning has been around
long enough that I don't see prolonging it another two releases.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200706203954.341758-7-eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/system/deprecated.rst | 12 ++++++++++++
 block.c                    | 12 ++----------
 tests/qemu-iotests/111.out |  2 +-
 tests/qemu-iotests/293.out | 13 +++++--------
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 73b9d9f378..6fbec34b8b 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -546,6 +546,18 @@ can be rewritten as::
 All options specified in ``-o`` are image creation options, so
 they are now rejected when used with ``-n`` to skip image creation.
 
+
+``qemu-img create -b bad file $size`` (removed in 5.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+When creating an image with a backing file that could not be opened,
+``qemu-img create`` used to issue a warning about the failure but
+proceed with the image creation if an explicit size was provided.
+However, as the ``-u`` option exists for this purpose, it is safer to
+enforce that any failure to open the backing image (including if the
+backing file is missing or an incorrect format was specified) is an
+error when ``-u`` is not used.
+
 Command line options
 --------------------
 
diff --git a/block.c b/block.c
index a568196ba2..983b9bd29a 100644
--- a/block.c
+++ b/block.c
@@ -6150,16 +6150,8 @@ void bdrv_img_create(const char *filename, const char *fmt,
         bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
                        &local_err);
         g_free(full_backing);
-        if (!bs && size != -1) {
-            /* Couldn't open BS, but we have a size, so it's nonfatal */
-            warn_reportf_err(local_err,
-                            "Could not verify backing image. "
-                            "This may become an error in future versions.\n");
-            local_err = NULL;
-        } else if (!bs) {
-            /* Couldn't open bs, do not have size */
-            error_append_hint(&local_err,
-                              "Could not open backing image to determine size.\n");
+        if (!bs) {
+            error_append_hint(&local_err, "Could not open backing image.\n");
             goto out;
         } else {
             if (size == -1) {
diff --git a/tests/qemu-iotests/111.out b/tests/qemu-iotests/111.out
index 5279c462fc..ba034e5c58 100644
--- a/tests/qemu-iotests/111.out
+++ b/tests/qemu-iotests/111.out
@@ -1,4 +1,4 @@
 QA output created by 111
 qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.inexistent': No such file or directory
-Could not open backing image to determine size.
+Could not open backing image.
 *** done
diff --git a/tests/qemu-iotests/293.out b/tests/qemu-iotests/293.out
index d07918b6d7..3c612903f8 100644
--- a/tests/qemu-iotests/293.out
+++ b/tests/qemu-iotests/293.out
@@ -17,18 +17,15 @@ backing file: TEST_DIR/t.IMGFMT.base
 
 == mismatched command line detection ==
 qemu-img: TEST_DIR/t.IMGFMT: invalid VMDK image descriptor
-Could not open backing image to determine size.
-qemu-img: warning: Could not verify backing image. This may become an error in future versions.
-invalid VMDK image descriptor
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=vmdk
+Could not open backing image.
+qemu-img: TEST_DIR/t.IMGFMT: invalid VMDK image descriptor
+Could not open backing image.
 
 qemu-img: TEST_DIR/t.IMGFMT: Image creation needs a size parameter
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=vmdk
 
-qemu-img: warning: Could not verify backing image. This may become an error in future versions.
-Unknown driver 'garbage'
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=garbage
-qemu-img: TEST_DIR/t.IMGFMT: unrecognized backing format 'garbage'
+qemu-img: TEST_DIR/t.IMGFMT: Unknown driver 'garbage'
+Could not open backing image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=garbage
 qemu-img: TEST_DIR/t.IMGFMT: unrecognized backing format 'garbage'
 image: TEST_DIR/t.IMGFMT
-- 
2.25.4


