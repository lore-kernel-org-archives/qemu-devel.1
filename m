Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67CDECE599
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A63D2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A63D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKp0r-0007qM-DN
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 15:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKoup-0001S3-5d
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKoun-0002Rf-Ur
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:24:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1iKoul-0002Pa-4V; Wed, 16 Oct 2019 15:24:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FF0B30860BE;
 Wed, 16 Oct 2019 19:24:54 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8021C5D9DC;
 Wed, 16 Oct 2019 19:24:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] image-fuzzer: Use io.StringIO
Date: Wed, 16 Oct 2019 16:24:24 -0300
Message-Id: <20191016192430.25098-5-ehabkost@redhat.com>
In-Reply-To: <20191016192430.25098-1-ehabkost@redhat.com>
References: <20191016192430.25098-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 16 Oct 2019 19:24:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

StringIO.StringIO is not available on Python 3, but io.StringIO
is available on both Python 2 and 3.  io.StringIO is slightly
different from the Python 2 StringIO module, though, so we need
bytes coming from subprocess.Popen() to be explicitly decoded.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/image-fuzzer/runner.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.py
index 95d84f38f3..94cab5bd93 100755
--- a/tests/image-fuzzer/runner.py
+++ b/tests/image-fuzzer/runner.py
@@ -28,7 +28,7 @@ import shutil
 from itertools import count
 import time
 import getopt
-import StringIO
+import io
 import resource
=20
 try:
@@ -84,8 +84,12 @@ def run_app(fd, q_args):
     try:
         out, err =3D process.communicate()
         signal.alarm(0)
-        fd.write(out)
-        fd.write(err)
+        # fd is a text file, so we need to decode the process output bef=
ore
+        # writing to it.
+        # We could be simply using the `errors` parameter of subprocess.=
Popen(),
+        # but this will be possible only after migrating to Python 3
+        fd.write(out.decode(errors=3D'replace'))
+        fd.write(err.decode(errors=3D'replace'))
         fd.flush()
         return process.returncode
=20
@@ -183,7 +187,7 @@ class TestEnv(object):
                                            MAX_BACKING_FILE_SIZE) * (1 <=
< 20)
         cmd =3D self.qemu_img + ['create', '-f', backing_file_fmt,
                                backing_file_name, str(backing_file_size)=
]
-        temp_log =3D StringIO.StringIO()
+        temp_log =3D io.StringIO()
         retcode =3D run_app(temp_log, cmd)
         if retcode =3D=3D 0:
             temp_log.close()
@@ -240,7 +244,7 @@ class TestEnv(object):
                            "Backing file: %s\n" \
                            % (self.seed, " ".join(current_cmd),
                               self.current_dir, backing_file_name)
-            temp_log =3D StringIO.StringIO()
+            temp_log =3D io.StringIO()
             try:
                 retcode =3D run_app(temp_log, current_cmd)
             except OSError as e:
--=20
2.21.0


