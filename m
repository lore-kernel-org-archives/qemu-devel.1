Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15148C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE994206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DI/GnSzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE994206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5bkq-0004Cy-4q
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 17:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1k5bk1-0003iA-TZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:23:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1k5bjz-0003vE-G9
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597181004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MG+d0kbNVtjx+DhxFbOtKCgs+wkbTImmSFWz1KDfu8Q=;
 b=DI/GnSzREz+r19UP0GisXGwHNkfkpkGuvvfACTreaEPMSBZW7iQKERf3/rhaHAFSRAPrD2
 Ok9UKHE41G8jPVncFXfL+0qoBqH2UErQTjVXq35dXaKoeVaZmUsSYEgkObICgWIdSimOHN
 hFTo14rBusENdKO1cExuxJhEU+vss5k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-tjbdbJ9rN_2nzdXjeuZ29g-1; Tue, 11 Aug 2020 17:23:21 -0400
X-MC-Unique: tjbdbJ9rN_2nzdXjeuZ29g-1
Received: by mail-qv1-f70.google.com with SMTP id q12so10570111qvm.19
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 14:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MG+d0kbNVtjx+DhxFbOtKCgs+wkbTImmSFWz1KDfu8Q=;
 b=jVm+hNQKykDjdbDsmijEjKIsONP/8RJRzcLBC6DkqCumuc0AjL1miwJgJHt/9shxkW
 ruDNCicNDoWSL2J4Rrz7k1T3+S6KWsAEe1qjr0skdGivjVyAdRoz5vHtQDvoqU6YJCV9
 PE3H/E9+eApbxRA8bc70DPaiwTeg+efCWXMwClJLwJ+3clBoqi4nE1g4HB3LDVIIRHI9
 hQQSTsiMXdwQ8/xKZ3+zc0CGTzv/uhgnU30moC9mpYtcDE8oqBRfGUVQW8UTo8sg3g36
 8r28KSqAXteqlVmZ09iUx5mFrzofhbUSM4rXiERqE72xYbhekoOMYxZczE82NFYyDOaX
 snHw==
X-Gm-Message-State: AOAM531aR9BLUaX6TJLwIdcgls8StTgiomo3MUBRQFfpwGdfXS+msr/W
 Izj62ATzCPpFT8XmFSUXAxx96L9iQGVFhN5Ug1vo/qVAfUpuJaOjUlNGGUUUMSVZ3wUuNaAfGco
 Zbnwr1nKdKQCDoZ0=
X-Received: by 2002:a05:620a:1594:: with SMTP id
 d20mr2757278qkk.242.1597181001002; 
 Tue, 11 Aug 2020 14:23:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ4hMBCBIGVuXjPdgLcAVKkcKXmexSbV2TWx2jXTRzGTQgAYkqDM1EQo+QEBPEgT/I2V22Dw==
X-Received: by 2002:a05:620a:1594:: with SMTP id
 d20mr2757262qkk.242.1597181000739; 
 Tue, 11 Aug 2020 14:23:20 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id q126sm72620qkb.75.2020.08.11.14.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:23:20 -0700 (PDT)
From: Connor Kuehl <ckuehl@redhat.com>
To: kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v2] block: Raise an error when backing file parameter is an
 empty string
Date: Tue, 11 Aug 2020 16:23:18 -0500
Message-Id: <20200811212318.708290-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
v2:
  - Removed 4 spaces to resolve pylint warning
  - Updated format to be 'iotests.imgfmt' instead
    of hardcoding 'qcow2'
  - Use temporary file instead of '/tmp/foo'
  - Give a size parameter to qemu-img
  - Run test for qcow2, qcow, qed and *not* raw

 block.c                    |  4 ++++
 tests/qemu-iotests/298     | 49 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  5 ++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 59 insertions(+)
 create mode 100755 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

diff --git a/block.c b/block.c
index d9ac0e07eb..1f72275b87 100644
--- a/block.c
+++ b/block.c
@@ -6117,6 +6117,10 @@ void bdrv_img_create(const char *filename, const char *fmt,
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
index 0000000000..879dae2d8e
--- /dev/null
+++ b/tests/qemu-iotests/298
@@ -0,0 +1,49 @@
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
+        with iotests.FilePath('test.img') as img_path:
+            actual = iotests.qemu_img_pipe(
+                'create',
+                '-f', iotests.imgfmt,
+                '-b', '',
+                img_path,
+                '1M'
+            )
+            expected = f'qemu-img: {img_path}: Expected backing file name,' \
+                       ' got empty string'
+
+            self.assertEqual(actual.strip(), expected.strip())
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qed', 'qcow', 'qcow2'])
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
index 025ed5238d..6f80c884a1 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -306,6 +306,7 @@
 295 rw
 296 rw
 297 meta
+298 img auto quick
 299 auto quick
 301 backing quick
 302 quick
-- 
2.25.4


