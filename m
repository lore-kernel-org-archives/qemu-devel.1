Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BDAC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5476C207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2Ci6OAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5476C207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgCJ-0007NY-AZ
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfst-0001Lf-Gp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfsp-0000mn-EU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxaBXukieqd0bKROHpBknWZKD/JELXqlMlAShG+WSFs=;
 b=D2Ci6OAVSM0XIViBJIgx8OfOAPYoGA6MXzcl4wjp/tSR6e0udc6AsLXPyFlJn35+E1EJpW
 bsaAxY/okdtlGU9GLiD7jSwjHA0SNE2peCcPaenbTIwriiLUXxYsRio+4awXKEZyKGHJ8t
 HuSoEwa1FpQLS6S552/mt80g2xCc6xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-pcITSo-xOgy3TQR4N7EJrg-1; Tue, 22 Sep 2020 06:50:46 -0400
X-MC-Unique: pcITSo-xOgy3TQR4N7EJrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99002593B1;
 Tue, 22 Sep 2020 10:50:45 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EC9E610AF;
 Tue, 22 Sep 2020 10:50:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 14/20] iotests: Let _make_test_img guess $TEST_IMG_FILE
Date: Tue, 22 Sep 2020 12:49:26 +0200
Message-Id: <20200922104932.46384-15-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When most iotests want to create a test image that is named differently
from the default $TEST_IMG, they do something like this:

    TEST_IMG="$TEST_IMG.base" _make_test_img $options

This works fine with the "file" protocol, but not so much for anything
else: _make_test_img tries to create an image under $TEST_IMG_FILE
first, and only under $TEST_IMG if the former is not set; and on
everything but "file", $TEST_IMG_FILE is set.

There are two ways we can fix this: First, we could make all tests
adjust not only TEST_IMG, but also TEST_IMG_FILE if that is present
(e.g. with something like _set_test_img_suffix $suffix that would affect
not only TEST_IMG but also TEST_IMG_FILE, if necessary).  This is a
pretty clean solution, and this is maybe what we should have done from
the start.

But it would also require changes to most existing bash tests.  So the
alternative is this: Let _make_test_img see whether $TEST_IMG_FILE still
points to the original value.  If so, it is possible that the caller has
adjusted $TEST_IMG but not $TEST_IMG_FILE.  In such a case, we can (for
most protocols) derive the corresponding $TEST_IMG_FILE value from
$TEST_IMG value and thus work around what technically is the caller
misbehaving.

This second solution is less clean, but it is robust against people
keeping their old habit of adjusting TEST_IMG only, and requires much
less changes.  So this patch implements it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 40 +++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 494490a272..23f46da2db 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -268,6 +268,7 @@ else
         TEST_IMG=$IMGPROTO:$TEST_DIR/t.$IMGFMT
     fi
 fi
+ORIG_TEST_IMG_FILE=$TEST_IMG_FILE
 ORIG_TEST_IMG="$TEST_IMG"
 
 if [ -z "$TEST_DIR" ]; then
@@ -330,6 +331,30 @@ _get_data_file()
                     | sed -e "s#\\\$TEST_IMG#$1#"
 }
 
+# Translate a $TEST_IMG to its corresponding $TEST_IMG_FILE for
+# different protocols
+_test_img_to_test_img_file()
+{
+    case "$IMGPROTO" in
+        file)
+            echo "$1"
+            ;;
+
+        nfs)
+            echo "$1" | sed -e "s#nfs://127.0.0.1##"
+            ;;
+
+        ssh)
+            echo "$1" | \
+                sed -e "s#ssh://\\($USER@\\)\\?127.0.0.1\\(:[0-9]\\+\\)\\?##"
+            ;;
+
+        *)
+            return 1
+            ;;
+    esac
+}
+
 _make_test_img()
 {
     # extra qemu-img options can be added by tests
@@ -343,10 +368,19 @@ _make_test_img()
     local opts_param=false
     local misc_params=()
 
-    if [ -n "$TEST_IMG_FILE" ]; then
-        img_name=$TEST_IMG_FILE
-    else
+    if [ -z "$TEST_IMG_FILE" ]; then
         img_name=$TEST_IMG
+    elif [ "$IMGOPTSSYNTAX" != "true" -a \
+           "$TEST_IMG_FILE" = "$ORIG_TEST_IMG_FILE" ]; then
+        # Handle cases of tests only updating TEST_IMG, but not TEST_IMG_FILE
+        img_name=$(_test_img_to_test_img_file "$TEST_IMG")
+        if [ "$?" != 0 ]; then
+            img_name=$TEST_IMG_FILE
+        fi
+    else
+        # $TEST_IMG_FILE is not the default value, so it definitely has been
+        # modified by the test
+        img_name=$TEST_IMG_FILE
     fi
 
     if [ -n "$IMGOPTS" ]; then
-- 
2.26.2


