Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6F6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0732075B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq6+yl1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0732075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqdy-0007YL-Pj
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZp-0008Ik-KJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZm-0004GO-FD
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594139769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIHtbmFgN5VBeIVjk3YffrBHlInUJbyCzazwzOr2c50=;
 b=gq6+yl1L4JPQQF+ER3KjOTpV8oQekdD+YGdQkDV92ALLpeepcbP0jLu8GF3b8vLPYjrito
 0vKL4lJFCR3I9kEoJDYzavuZDvSAIoDjLrFoaK6bGwv/PkSwQ7TUFgRakx8yvfJCDrnvo9
 w42uB9DY3EH8LfQjZPJ5/NujlwCsBw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-ufXHaJFzNcO9BDTmhHLluQ-1; Tue, 07 Jul 2020 12:36:00 -0400
X-MC-Unique: ufXHaJFzNcO9BDTmhHLluQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7CE418B6117;
 Tue,  7 Jul 2020 16:35:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-113.ams2.redhat.com
 [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6D9571674;
 Tue,  7 Jul 2020 16:35:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/12] qcow2: Deprecate use of qemu-img amend to change backing
 file
Date: Tue,  7 Jul 2020 18:35:01 +0200
Message-Id: <20200707163504.194740-10-kwolf@redhat.com>
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

The use of 'qemu-img amend' to change qcow2 backing files is not
tested very well.  In particular, our implementation has a bug where
if a new backing file is provided without a format, then the prior
format is blindly reused, even if this results in data corruption, but
this is not caught by iotests.

There are also situations where amending other options needs access to
the original backing file (for example, on a downgrade to a v2 image,
knowing whether a v3 zero cluster must be allocated or may be left
unallocated depends on knowing whether the backing file already reads
as zero), but the command line does not have a nice way to tell us
both the backing file to use for opening the image as well as the
backing file to install after the operation is complete.

Even if we do allow changing the backing file, it is redundant with
the existing ability to change backing files via 'qemu-img rebase -u'.
It is time to deprecate this support (leaving the existing behavior
intact, even if it is buggy), and at a point in the future, require
the use of only 'qemu-img rebase' for adjusting backing chain
relations, saving 'qemu-img amend' for changes unrelated to the
backing chain.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200706203954.341758-8-eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/system/deprecated.rst | 12 ++++++++++++
 docs/tools/qemu-img.rst    |  4 ++++
 block/qcow2.c              |  5 +++++
 tests/qemu-iotests/061.out |  1 +
 tests/qemu-iotests/082.out |  2 ++
 5 files changed, 24 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 6fbec34b8b..b312ad27aa 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -418,6 +418,18 @@ kernel in 2018, and has also been dropped from glibc.
 Related binaries
 ----------------
 
+qemu-img amend to adjust backing file (since 5.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''
+
+The use of ``qemu-img amend`` to modify the name or format of a qcow2
+backing image is deprecated; this functionality was never fully
+documented or tested, and interferes with other amend operations that
+need access to the original backing image (such as deciding whether a
+v3 zero cluster may be left unallocated when converting to a v2
+image).  Rather, any changes to the backing chain should be performed
+with ``qemu-img rebase -u`` either before or after the remaining
+changes being performed by amend, as appropriate.
+
 Backwards compatibility
 -----------------------
 
diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 7f0737488a..fa53e30697 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -258,6 +258,10 @@ Command description:
   Amends the image format specific *OPTIONS* for the image file
   *FILENAME*. Not all file formats support this operation.
 
+  The set of options that can be amended are dependent on the image
+  format, but note that amending the backing chain relationship should
+  instead be performed with ``qemu-img rebase``.
+
 .. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=FLUSH_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
 
   Run a simple sequential I/O benchmark on the specified image. If ``-w`` is
diff --git a/block/qcow2.c b/block/qcow2.c
index 0cd2e6757e..99aedb8eed 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5523,6 +5523,11 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     }
 
     if (backing_file || backing_format) {
+        if (g_strcmp0(backing_file, s->image_backing_file) ||
+            g_strcmp0(backing_format, s->image_backing_format)) {
+            warn_report("Deprecated use of amend to alter the backing file; "
+                        "use qemu-img rebase instead");
+        }
         ret = qcow2_change_backing_file(bs,
                     backing_file ?: s->image_backing_file,
                     backing_format ?: s->image_backing_format);
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 2f03cf045c..c549b139da 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -370,6 +370,7 @@ wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: warning: Deprecated use of amend to alter the backing file; use qemu-img rebase instead
 read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index a65e185179..e878572a0d 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -855,10 +855,12 @@ Creation options for 'qcow2':
 Note that not all of these options may be amendable.
 
 Testing: amend -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2
+qemu-img: warning: Deprecated use of amend to alter the backing file; use qemu-img rebase instead
 
 Testing: rebase -u -b  -f qcow2 TEST_DIR/t.qcow2
 
 Testing: amend -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2
+qemu-img: warning: Deprecated use of amend to alter the backing file; use qemu-img rebase instead
 
 Testing: rebase -u -b  -f qcow2 TEST_DIR/t.qcow2
 
-- 
2.25.4


