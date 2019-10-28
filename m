Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D6ECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851262086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MundnMn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851262086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP3zL-0004ti-UH
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vU-00016K-TK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vT-00019L-JB
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50716
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vT-00018c-F9
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BJR7+7aH2YQU3yk/3SlY1tFahOTGnVjCwU3veQoNec=;
 b=MundnMn23qQ4cSmoeJSL/y28wCG5MPGGGVlAIPKF2a//BQYCar950nz/GD5DFkk9wU8eQX
 0PtxeXMPlU2RfF6yvXrYv+fS9JxEkRkN6A91BJeIvflSRPY93bZ7fQ/VXxRCyJV67qdwQF
 XLsdExZwv+Rph5ETjB00nkyvc3jQWWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-YR7kYPSGNJiHZbe_2KEh0Q-1; Mon, 28 Oct 2019 08:15:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC2248017DD;
 Mon, 28 Oct 2019 12:15:07 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CEB05C219;
 Mon, 28 Oct 2019 12:15:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/69] iotests: Allow skipping test cases
Date: Mon, 28 Oct 2019 13:13:54 +0100
Message-Id: <20191028121501.15279-3-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: YR7kYPSGNJiHZbe_2KEh0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
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
Message-id: 20190917092004.999-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 709def4d5d..6d5de6e504 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -838,6 +838,11 @@ class QMPTestCase(unittest.TestCase):
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
@@ -849,7 +854,11 @@ def notrun(reason):
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
@@ -950,8 +959,15 @@ def execute_unittest(output, verbosity, debug):
         unittest.main(testRunner=3Drunner)
     finally:
         if not debug:
-            sys.stderr.write(re.sub(r'Ran (\d+) tests? in [\d.]+s',
-                                    r'Ran \1 tests', output.getvalue()))
+            out =3D output.getvalue()
+            out =3D re.sub(r'Ran (\d+) tests? in [\d.]+s', r'Ran \1 tests'=
, out)
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


