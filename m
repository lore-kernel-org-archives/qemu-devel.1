Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A125C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1543B2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8qphw15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1543B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqvs-0001fT-9h
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZY-0007jn-9Z
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:35:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZV-0004AM-Ha
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594139752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xV9xQIvDYBqDZoBJhdSVcyP2Syk+NPN6QiMwXim3Yvk=;
 b=U8qphw151+OEQSOpHInHAFN2RI+tJTLH/bzw/B+bMPhmAvfu5tAbcL13Zz7tP/nQvMg1/S
 OiPxQqGIBNyhm9Tmu3wCR+ty8iByt/0uivS1qNIrrOe0Vki/7SE/ksQU/TM1AAmc+ndQnc
 cdVD7HlUIAIAIgx8W1SezAFqQwvYQTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-ZP4RwPQ6NVSepc_wkOAjZA-1; Tue, 07 Jul 2020 12:35:47 -0400
X-MC-Unique: ZP4RwPQ6NVSepc_wkOAjZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEC07100A62B;
 Tue,  7 Jul 2020 16:35:45 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-113.ams2.redhat.com
 [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 985447848B;
 Tue,  7 Jul 2020 16:35:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/12] block: Finish deprecation of 'qemu-img convert -n -o'
Date: Tue,  7 Jul 2020 18:34:56 +0200
Message-Id: <20200707163504.194740-5-kwolf@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
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

It's been two releases since we started warning; time to make the
combination an error as promised.  There was no iotest coverage, so
add some.

While touching the documentation, tweak another section heading for
consistent style.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200706203954.341758-3-eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/system/deprecated.rst | 18 ++++++++----------
 qemu-img.c                 |  4 ++--
 tests/qemu-iotests/122     |  7 +++++++
 tests/qemu-iotests/122.out |  4 ++++
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 47f84be8e0..73b9d9f378 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -418,14 +418,6 @@ kernel in 2018, and has also been dropped from glibc.
 Related binaries
 ----------------
 
-``qemu-img convert -n -o`` (since 4.2.0)
-''''''''''''''''''''''''''''''''''''''''
-
-All options specified in ``-o`` are image creation options, so
-they have no effect when used with ``-n`` to skip image creation.
-Silently ignored options can be confusing, so this combination of
-options will be made an error in future versions.
-
 Backwards compatibility
 -----------------------
 
@@ -531,8 +523,8 @@ spec you can use the ``-cpu rv64gcsu,priv_spec=v1.10.0`` command line argument.
 Related binaries
 ----------------
 
-``qemu-nbd --partition`` (removed in 5.0.0)
-'''''''''''''''''''''''''''''''''''''''''''
+``qemu-nbd --partition`` (removed in 5.0)
+'''''''''''''''''''''''''''''''''''''''''
 
 The ``qemu-nbd --partition $digit`` code (also spelled ``-P``)
 could only handle MBR partitions, and never correctly handled logical
@@ -548,6 +540,12 @@ can be rewritten as::
 
   qemu-nbd -t --image-opts driver=raw,offset=1M,size=100M,file.driver=qcow2,file.file.driver=file,file.file.filename=file.qcow2
 
+``qemu-img convert -n -o`` (removed in 5.1)
+'''''''''''''''''''''''''''''''''''''''''''
+
+All options specified in ``-o`` are image creation options, so
+they are now rejected when used with ``-n`` to skip image creation.
+
 Command line options
 --------------------
 
diff --git a/qemu-img.c b/qemu-img.c
index 74946f81ca..b366a89ce3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2369,8 +2369,8 @@ static int img_convert(int argc, char **argv)
     }
 
     if (skip_create && options) {
-        warn_report("-o has no effect when skipping image creation");
-        warn_report("This will become an error in future QEMU versions.");
+        error_report("-o has no effect when skipping image creation");
+        goto fail_getopt;
     }
 
     if (s.has_zero_init && !skip_create) {
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index f7a3ae684a..2dc16b2ca4 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -290,6 +290,13 @@ TEST_IMG="$TEST_IMG".orig _make_test_img 64M
 # backing file"
 $QEMU_IMG convert -O $IMGFMT -B "$TEST_IMG".base -n "$TEST_IMG" "$TEST_IMG".orig
 
+echo
+echo '=== -n incompatible with -o ==='
+echo
+
+$QEMU_IMG convert -O $IMGFMT -o preallocation=metadata -n \
+	  "$TEST_IMG" "$TEST_IMG".orig && echo "unexpected success"
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 1a35951a80..c2e154a1e5 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -233,4 +233,8 @@ Images are identical.
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
+
+=== -n incompatible with -o ===
+
+qemu-img: -o has no effect when skipping image creation
 *** done
-- 
2.25.4


