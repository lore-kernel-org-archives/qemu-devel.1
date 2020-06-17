Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B85C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B8A212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZox2gWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B8A212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlcoi-0000BL-59
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1jlcnk-0008Ac-Iz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:28:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34312
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1jlcnh-0006LB-Gh
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592418520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EonT1A6c9Rx6AQvRKMgsZ6/YashYoQt44aYHSyzBM2A=;
 b=fZox2gWr2R4/Ky+/bcX0hSDm4mANigzwgjC9Hx7rkWWnYJANDBgid5Fpj03BdoUC/uNV8f
 5vG2HOETuiNcFw75NIDsTIJzuQBfpKy21C9BjHGIStKe1tnH1tvGq6ApTlnFfXzOlIAARH
 NFr/p+U8LL2q92Dj1XzCHySZ3XwRibk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-0vUaXnZgM86eJmv1_rmXMw-1; Wed, 17 Jun 2020 14:27:29 -0400
X-MC-Unique: 0vUaXnZgM86eJmv1_rmXMw-1
Received: by mail-qv1-f71.google.com with SMTP id j4so2222163qvt.20
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 11:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EonT1A6c9Rx6AQvRKMgsZ6/YashYoQt44aYHSyzBM2A=;
 b=XNHEwnqsslbSrBv0+tqNVXBYhIRUg6/rF47PO92FfsSiI7nDQMUcGTspA00YHSEKLW
 Q5E+5+op/gMGliEw3iuCG5m0SJ8wRRlRxyB3GgwQPiY/ZMyVkK5wI72kjS0tDsbIAXhn
 B7O4SDpOHfplHkNpwn11ckunjfRpcL9oho4CO+tEp1n5x01uY0TFN2EcJ4BF8GBp+c96
 Iy+ynpQCloobu+jZCb5MW4m399E3PgMeVHpFFfkHmtflSF9TFRlxhdrrgYoEEBxehzCt
 NlR3ZSlIdtnpz96fH73ZeSvS2nwo9Zszsr/gW/1G8lwxqLZxo82yJmhgu37rpyuMDSn4
 h/+A==
X-Gm-Message-State: AOAM533zwE8b1DChUzvj94B/HuHxHu7saASPcB1UzjjBUfvulZsNfoFN
 bQJxTUsdomkYQCosXPYw2Dl4i7y6g7PdGCge2XL+EW0AB13uoAHvoKmcbwRKirMM1cuEaVBhZ52
 TZ1+c+IWwrIWLQYU=
X-Received: by 2002:a37:5805:: with SMTP id m5mr25101781qkb.176.1592418448706; 
 Wed, 17 Jun 2020 11:27:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWZOEn4LlgYPmz6QnZrYsws2iNX1n1ou20jQyzTmh6haTPuWPwq3NMtVTTljffDcQHqqbR5w==
X-Received: by 2002:a37:5805:: with SMTP id m5mr25101749qkb.176.1592418448411; 
 Wed, 17 Jun 2020 11:27:28 -0700 (PDT)
Received: from redhat.redhat.com (c-71-63-171-240.hsd1.or.comcast.net.
 [71.63.171.240])
 by smtp.gmail.com with ESMTPSA id a14sm704779qkn.16.2020.06.17.11.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 11:27:27 -0700 (PDT)
From: Connor Kuehl <ckuehl@redhat.com>
To: kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH] block: Raise an error when backing file parameter is an empty
 string
Date: Wed, 17 Jun 2020 11:27:25 -0700
Message-Id: <20200617182725.951119-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Providing an empty string for the backing file parameter like so:

	qemu-img create -f qcow2 -b '' /tmp/foo

allows the flow of control to reach and subsequently fail an assert
statement because passing an empty string to

	bdrv_get_full_backing_filename_from_filename()

simply results in NULL being returned without an error being raised.

To fix this, let's check for an empty string when getting the value from
the opts list.

Reported-by: Attila Fazekas <afazekas@redhat.com>
Fixes: https://bugzilla.redhat.com/1809553
Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 block.c                    |  4 ++++
 tests/qemu-iotests/298     | 47 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  5 ++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 57 insertions(+)
 create mode 100755 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

diff --git a/block.c b/block.c
index 6dbcb7e083..b335d6bcb2 100644
--- a/block.c
+++ b/block.c
@@ -6116,6 +6116,10 @@ void bdrv_img_create(const char *filename, const char *fmt,
                              "same filename as the backing file");
             goto out;
         }
+        if (backing_file[0] == '\0') {
+            error_setg(errp, "Expected backing file name, got empty string");
+            goto out;
+        }
     }
 
     backing_fmt = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
new file mode 100755
index 0000000000..1e30caebec
--- /dev/null
+++ b/tests/qemu-iotests/298
@@ -0,0 +1,47 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2020 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+
+
+# Regression test for avoiding an assertion when the 'backing file'
+# parameter (-b) is set to an empty string for qemu-img create
+#
+#   qemu-img create -f qcow2 -b '' /tmp/foo
+#
+# This ensures the invalid parameter is handled with a user-
+# friendly message instead of a failed assertion.
+
+import iotests
+
+class TestEmptyBackingFilename(iotests.QMPTestCase):
+
+
+    def test_empty_backing_file_name(self):
+        actual = iotests.qemu_img_pipe(
+                'create',
+                '-f', 'qcow2',
+                '-b', '',
+                '/tmp/foo'
+        )
+        expected = 'qemu-img: /tmp/foo: Expected backing file name,' \
+                   ' got empty string'
+
+        self.assertEqual(actual.strip(), expected.strip())
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['raw', 'qcow2'])
diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/298.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d886fa0cb3..4bca2d9e05 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -302,3 +302,4 @@
 291 rw quick
 292 rw auto quick
 297 meta
+298 img auto quick
-- 
2.25.4


