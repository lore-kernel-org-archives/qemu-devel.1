Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F24C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A37217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd61tXUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A37217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS17e-0003x5-IA
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iS106-0004QE-Tp
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iS105-0002ZM-Qk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iS105-0002Yv-Mj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572968649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqVtcEw030cWBKi4G/oHb1MwhDbny8Z9CDgObjufLLo=;
 b=Xd61tXURkuXPiEbbf9FXTjB/mkNIMBB5IF3XM+reVfAF4QQ+90FyLo878djr3vYa7V3t5l
 y9JvwBhn2IQVFEyqlOPOS/tv9PBdebwsesvhO38Wkz0i+3mcFjZszrrsYdtQDs3sa9TAgB
 fE8uUGP0U1RrC/+yVATZ+qj5TWH9jw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338--CFLquhaO-6qMugWq-lGQA-1; Tue, 05 Nov 2019 10:44:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06A048017DE;
 Tue,  5 Nov 2019 15:44:06 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D82C53C1D;
 Tue,  5 Nov 2019 15:43:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] image-fuzzer: Use io.StringIO
Date: Tue,  5 Nov 2019 16:43:25 +0100
Message-Id: <20191105154332.181417-5-stefanha@redhat.com>
In-Reply-To: <20191105154332.181417-1-stefanha@redhat.com>
References: <20191105154332.181417-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: -CFLquhaO-6qMugWq-lGQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

StringIO.StringIO is not available on Python 3, but io.StringIO
is available on both Python 2 and 3.  io.StringIO is slightly
different from the Python 2 StringIO module, though, so we need
bytes coming from subprocess.Popen() to be explicitly decoded.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20191016192430.25098-5-ehabkost@redhat.com
Message-Id: <20191016192430.25098-5-ehabkost@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
+        # fd is a text file, so we need to decode the process output befor=
e
+        # writing to it.
+        # We could be simply using the `errors` parameter of subprocess.Po=
pen(),
+        # but this will be possible only after migrating to Python 3
+        fd.write(out.decode(errors=3D'replace'))
+        fd.write(err.decode(errors=3D'replace'))
         fd.flush()
         return process.returncode
=20
@@ -183,7 +187,7 @@ class TestEnv(object):
                                            MAX_BACKING_FILE_SIZE) * (1 << =
20)
         cmd =3D self.qemu_img + ['create', '-f', backing_file_fmt,
                                backing_file_name, str(backing_file_size)]
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
2.23.0


