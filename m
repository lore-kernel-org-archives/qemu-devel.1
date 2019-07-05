Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D3BC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAE921670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAE921670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUqA-0002q5-Ie
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hjUeQ-0005zH-T7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hjUeP-0007SO-TA
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:17:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hjUeN-0007Pv-EA; Fri, 05 Jul 2019 16:17:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B306AC057E9F;
 Fri,  5 Jul 2019 20:17:42 +0000 (UTC)
Received: from probe.redhat.com (ovpn-122-149.rdu2.redhat.com [10.10.122.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5C7A86432;
 Fri,  5 Jul 2019 20:17:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 16:16:28 -0400
Message-Id: <20190705201631.26266-16-jsnow@redhat.com>
In-Reply-To: <20190705201631.26266-1-jsnow@redhat.com>
References: <20190705201631.26266-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 05 Jul 2019 20:17:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 15/18] iotests: teach FilePath to produce
 multiple paths
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use "FilePaths" instead of "FilePath" to request multiple files be
cleaned up after we leave that object's scope.

This is not crucial; but it saves a little typing.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index c544659ecb..6135c9663d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -358,31 +358,45 @@ class Timeout:
     def timeout(self, signum, frame):
         raise Exception(self.errmsg)
=20
+def file_pattern(name):
+    return "{0}-{1}".format(os.getpid(), name)
=20
-class FilePath(object):
-    '''An auto-generated filename that cleans itself up.
+class FilePaths(object):
+    """
+    FilePaths is an auto-generated filename that cleans itself up.
=20
     Use this context manager to generate filenames and ensure that the f=
ile
     gets deleted::
=20
-        with TestFilePath('test.img') as img_path:
+        with FilePaths(['test.img']) as img_path:
             qemu_img('create', img_path, '1G')
         # migration_sock_path is automatically deleted
-    '''
-    def __init__(self, name):
-        filename =3D '{0}-{1}'.format(os.getpid(), name)
-        self.path =3D os.path.join(test_dir, filename)
+    """
+    def __init__(self, names):
+        self.paths =3D []
+        for name in names:
+            self.paths.append(os.path.join(test_dir, file_pattern(name))=
)
=20
     def __enter__(self):
-        return self.path
+        return self.paths
=20
     def __exit__(self, exc_type, exc_val, exc_tb):
         try:
-            os.remove(self.path)
+            for path in self.paths:
+                os.remove(path)
         except OSError:
             pass
         return False
=20
+class FilePath(FilePaths):
+    """
+    FilePath is a specialization of FilePaths that takes a single filena=
me.
+    """
+    def __init__(self, name):
+        super(FilePath, self).__init__([name])
+
+    def __enter__(self):
+        return self.paths[0]
=20
 def file_path_remover():
     for path in reversed(file_path_remover.paths):
@@ -407,7 +421,7 @@ def file_path(*names):
=20
     paths =3D []
     for name in names:
-        filename =3D '{0}-{1}'.format(os.getpid(), name)
+        filename =3D file_pattern(name)
         path =3D os.path.join(test_dir, filename)
         file_path_remover.paths.append(path)
         paths.append(path)
--=20
2.21.0


