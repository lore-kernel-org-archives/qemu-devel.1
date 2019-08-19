Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4E7C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A4D2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A4D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoPu-0001Xu-Bz
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzo7U-0001Jf-Om
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzo7T-0004Pn-Kw
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzo7R-0004Oa-4i; Mon, 19 Aug 2019 16:19:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5953E3001AB7;
 Mon, 19 Aug 2019 20:19:08 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E400C1001959;
 Mon, 19 Aug 2019 20:19:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 22:18:46 +0200
Message-Id: <20190819201851.24418-4-mreitz@redhat.com>
In-Reply-To: <20190819201851.24418-1-mreitz@redhat.com>
References: <20190819201851.24418-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 19 Aug 2019 20:19:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/8] iotests: Allow skipping test cases
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
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
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
---
 tests/qemu-iotests/iotests.py | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 84438e837c..2f53baf633 100644
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
@@ -813,7 +818,10 @@ def notrun(reason):
     sys.exit(0)
=20
 def case_notrun(reason):
-    '''Skip this test case'''
+    '''Mark this test case as not having been run, but do not actually
+    skip it; that is left to the caller.  See QMPTestCase.case_skip()
+    for a variant that actually skips the current test case.'''
+
     # Each test in qemu-iotests has a number ("seq")
     seq =3D os.path.basename(sys.argv[0])
=20
@@ -904,8 +912,15 @@ def execute_unittest(output, verbosity, debug):
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


