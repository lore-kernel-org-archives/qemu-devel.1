Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13129C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98AC20850
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98AC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOU1P-0000TG-6m
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 17:22:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOTxR-0004bN-Jp
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOTxO-0005nb-O1
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:18:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOTxM-0005mP-Dj; Wed, 08 May 2019 17:18:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0019330279;
	Wed,  8 May 2019 21:18:27 +0000 (UTC)
Received: from localhost (ovpn-204-96.brq.redhat.com [10.40.204.96])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 34B9617C23;
	Wed,  8 May 2019 21:18:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  8 May 2019 23:18:17 +0200
Message-Id: <20190508211820.17851-3-mreitz@redhat.com>
In-Reply-To: <20190508211820.17851-1-mreitz@redhat.com>
References: <20190508211820.17851-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 08 May 2019 21:18:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/5] iotests.py: Add qemu_nbd_early_pipe()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_nbd_pipe() currently unconditionally reads qemu-nbd's output.  That
is not ideal because qemu-nbd may keep stderr open after the parent
process has exited.

Currently, the only user of qemu_nbd_pipe() is 147, which discards the
whole output if the parent process returned success and only evaluates
it on error.  Therefore, we can replace qemu_nbd_pipe() by
qemu_nbd_early_pipe() that does the same: Discard the output on success,
and return it on error.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/147        | 4 ++--
 tests/qemu-iotests/iotests.py | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 82513279b0..2d84fddb01 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -24,7 +24,7 @@ import socket
 import stat
 import time
 import iotests
-from iotests import cachemode, imgfmt, qemu_img, qemu_nbd, qemu_nbd_pipe
+from iotests import cachemode, imgfmt, qemu_img, qemu_nbd, qemu_nbd_earl=
y_pipe
=20
 NBD_PORT_START      =3D 32768
 NBD_PORT_END        =3D NBD_PORT_START + 1024
@@ -93,7 +93,7 @@ class QemuNBD(NBDBlockdevAddBase):
             pass
=20
     def _try_server_up(self, *args):
-        status, msg =3D qemu_nbd_pipe('-f', imgfmt, test_img, *args)
+        status, msg =3D qemu_nbd_early_pipe('-f', imgfmt, test_img, *arg=
s)
         if status =3D=3D 0:
             return True
         if 'Address already in use' in msg:
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index f811f69135..ce21d83182 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -204,9 +204,9 @@ def qemu_nbd(*args):
     '''Run qemu-nbd in daemon mode and return the parent's exit code'''
     return subprocess.call(qemu_nbd_args + ['--fork'] + list(args))
=20
-def qemu_nbd_pipe(*args):
+def qemu_nbd_early_pipe(*args):
     '''Run qemu-nbd in daemon mode and return both the parent's exit cod=
e
-       and its output'''
+       and its output in case of an error'''
     subp =3D subprocess.Popen(qemu_nbd_args + ['--fork'] + list(args),
                             stdout=3Dsubprocess.PIPE,
                             stderr=3Dsubprocess.STDOUT,
@@ -216,7 +216,10 @@ def qemu_nbd_pipe(*args):
         sys.stderr.write('qemu-nbd received signal %i: %s\n' %
                          (-exitcode,
                           ' '.join(qemu_nbd_args + ['--fork'] + list(arg=
s))))
-    return exitcode, subp.communicate()[0]
+    if exitcode =3D=3D 0:
+        return exitcode, ''
+    else:
+        return exitcode, subp.communicate()[0]
=20
 def compare_images(img1, img2, fmt1=3Dimgfmt, fmt2=3Dimgfmt):
     '''Return True if two image files are identical'''
--=20
2.21.0


