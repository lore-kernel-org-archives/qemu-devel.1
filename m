Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCA6C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FB221881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FB221881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9gi-0003W9-Ax
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iA9er-0001eC-8l
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iA9ep-0004Xz-Tv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38065)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iA9en-0004VZ-4U; Tue, 17 Sep 2019 05:20:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B63B3CA16;
 Tue, 17 Sep 2019 09:20:20 +0000 (UTC)
Received: from localhost (ovpn-116-130.ams2.redhat.com [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A3CF60126;
 Tue, 17 Sep 2019 09:20:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 11:19:59 +0200
Message-Id: <20190917092004.999-3-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-1-mreitz@redhat.com>
References: <20190917092004.999-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 17 Sep 2019 09:20:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 2/7] iotests: Allow skipping test cases
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

case_notrun() does not actually skip the current test case.  It just
adds a "notrun" note and then returns to the caller, who manually has to
skip the test.  Generally, skipping a test case is as simple as
returning from the current function, but not always: For example, this
model does not allow skipping tests already in the setUp() function.

Thus, add a QMPTestCase.case_skip() function that invokes case_notrun()
and then self.skipTest().  To make this work, we need to filter the
information on how many test cases were skipped from the unittest
output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b26271187c..e46f3b6aed 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -802,6 +802,11 @@ class QMPTestCase(unittest.TestCase):
             return self.pause_wait(job_id)
         return result
=20
+    def case_skip(self, reason):
+        '''Skip this test case'''
+        case_notrun(reason)
+        self.skipTest(reason)
+
=20
 def notrun(reason):
     '''Skip this test suite'''
@@ -813,7 +818,11 @@ def notrun(reason):
     sys.exit(0)
=20
 def case_notrun(reason):
-    '''Skip this test case'''
+    '''Mark this test case as not having been run (without actually
+    skipping it, that is left to the caller).  See
+    QMPTestCase.case_skip() for a variant that actually skips the
+    current test case.'''
+
     # Each test in qemu-iotests has a number ("seq")
     seq =3D os.path.basename(sys.argv[0])
=20
@@ -904,8 +913,15 @@ def execute_unittest(output, verbosity, debug):
         unittest.main(testRunner=3Drunner)
     finally:
         if not debug:
-            sys.stderr.write(re.sub(r'Ran (\d+) tests? in [\d.]+s',
-                                    r'Ran \1 tests', output.getvalue()))
+            out =3D output.getvalue()
+            out =3D re.sub(r'Ran (\d+) tests? in [\d.]+s', r'Ran \1 test=
s', out)
+
+            # Hide skipped tests from the reference output
+            out =3D re.sub(r'OK \(skipped=3D\d+\)', 'OK', out)
+            out_first_line, out_rest =3D out.split('\n', 1)
+            out =3D out_first_line.replace('s', '.') + '\n' + out_rest
+
+            sys.stderr.write(out)
=20
 def execute_test(test_function=3DNone,
                  supported_fmts=3D[], supported_oses=3D['linux'],
--=20
2.21.0


