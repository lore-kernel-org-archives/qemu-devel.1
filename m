Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3050C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F2F2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F2F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOQ0-0003f2-6J
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7Q-0004QU-JI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7P-0007eK-EK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7M-0007cY-79; Tue, 01 Oct 2019 15:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7BFAD10DCC94;
 Tue,  1 Oct 2019 19:47:27 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 156795D6D0;
 Tue,  1 Oct 2019 19:47:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 04/67] iotests.py: create_test_image, remove_test_image
Date: Tue,  1 Oct 2019 21:46:12 +0200
Message-Id: <20191001194715.2796-5-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 01 Oct 2019 19:47:27 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python tests should use these two new functions instead of
qemu_img('create', ...) + os.remove(), so that user-supplied image
options are interpreted and handled correctly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b5ea424de4..fce1ab04c9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -122,6 +122,62 @@ def qemu_img_create(*args):
=20
     return qemu_img(*args)
=20
+def create_test_image(filename, size=3DNone, fmt=3Dimgfmt, opts=3D[],
+                      backing_file=3DNone, backing_fmt=3DNone,
+                      objects=3D[], unsafe=3DFalse):
+    if fmt =3D=3D imgfmt:
+        # Only use imgopts for the default format
+        opts =3D imgopts + opts
+
+    for i, opt in enumerate(opts):
+        if '$TEST_IMG' in opt:
+            opts[i] =3D opt.replace('$TEST_IMG', filename)
+
+    # default luks support
+    if fmt =3D=3D 'luks':
+        if not any('key-secret' in opt for opt in opts):
+            opts.append(luks_default_key_secret_opt)
+        objects.append(luks_default_secret_object)
+
+    args =3D ['create', '-f', fmt]
+
+    if len(opts) > 0:
+        args +=3D ['-o', ','.join(opts)]
+
+    if backing_file is not None:
+        args +=3D ['-b', backing_file]
+
+    if backing_fmt is not None:
+        args +=3D ['-F', backing_fmt]
+
+    if len(objects) > 0:
+        # Generate a [['--object', $obj], [...], ...] list and flatten i=
t
+        args +=3D [arg for objarg in (['--object', obj] for obj in objec=
ts) \
+                     for arg in objarg]
+
+    if unsafe:
+        args.append('-u')
+
+    args.append(filename)
+    if size is not None:
+        args.append(str(size))
+
+    return qemu_img(*args)
+
+# Use this to remove images create with create_test_image in the
+# default image format (iotests.imgfmt)
+def remove_test_image(filename):
+    try:
+        os.remove(filename)
+
+        data_file =3D next(opt.replace('data_file=3D', '') \
+                            .replace('$TEST_IMG', filename) \
+                         for opt in imgopts if opt.startswith('data_file=
=3D'))
+
+        os.remove(data_file)
+    except:
+        pass
+
 def qemu_img_verbose(*args):
     '''Run qemu-img without suppressing its output and return the exit c=
ode'''
     exitcode =3D subprocess.call(qemu_img_args + list(args))
--=20
2.21.0


