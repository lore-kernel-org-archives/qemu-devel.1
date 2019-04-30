Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7203FC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B092081C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B092081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVHO-0001yJ-GP
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:06:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUus-000845-Ff
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUup-00026N-Md
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuk-0001vR-4q; Tue, 30 Apr 2019 11:43:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 116EB3086234;
	Tue, 30 Apr 2019 15:43:20 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2DBE64C7;
	Tue, 30 Apr 2019 15:43:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:30 +0200
Message-Id: <20190430154244.30083-14-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 30 Apr 2019 15:43:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/27] qemu-img: Make create hint at protocol
 options
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430154230.qQImm27b1mOwzswpcHG31qMequv_D2uCpHvDYCtGTFs@z>

From: Max Reitz <mreitz@redhat.com>

qemu-img create allows giving just a format and "-o help" to get a list
of the options supported by that format.  Users may not realize that the
protocol level may offer even more options, which they only get to see
by specifying a filename.

This patch adds a note to hint at that fact.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 | 13 ++++++++++++-
 tests/qemu-iotests/082.out | 20 ++++++++++++++++----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index d7fe546b85..ddd55ab291 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -267,9 +267,20 @@ static int print_block_option_help(const char *filen=
ame, const char *fmt)
         create_opts =3D qemu_opts_append(create_opts, proto_drv->create_=
opts);
     }
=20
-    printf("Supported options:\n");
+    if (filename) {
+        printf("Supported options:\n");
+    } else {
+        printf("Supported %s options:\n", fmt);
+    }
     qemu_opts_print_help(create_opts, false);
     qemu_opts_free(create_opts);
+
+    if (!filename) {
+        printf("\n"
+               "The protocol level may support further options.\n"
+               "Specify the target filename to include those options.\n"=
);
+    }
+
     return 0;
 }
=20
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 9a23b68511..7e25706813 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -242,7 +242,7 @@ Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t=
.qcow2 -o ,, -o help TEST_DIR
 qemu-img: Invalid option list: ,,
=20
 Testing: create -f qcow2 -o help
-Supported options:
+Supported qcow2 options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
@@ -263,10 +263,16 @@ Supported options:
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
+The protocol level may support further options.
+Specify the target filename to include those options.
+
 Testing: create -o help
-Supported options:
+Supported raw options:
   size=3D<size>            - Virtual disk size
=20
+The protocol level may support further options.
+Specify the target filename to include those options.
+
 Testing: create -f bochs -o help
 qemu-img: Format driver 'bochs' does not support image creation
=20
@@ -516,7 +522,7 @@ Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/=
t.qcow2 -o ,, -o help TEST_DI
 qemu-img: Invalid option list: ,,
=20
 Testing: convert -O qcow2 -o help
-Supported options:
+Supported qcow2 options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
@@ -537,10 +543,16 @@ Supported options:
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
+The protocol level may support further options.
+Specify the target filename to include those options.
+
 Testing: convert -o help
-Supported options:
+Supported raw options:
   size=3D<size>            - Virtual disk size
=20
+The protocol level may support further options.
+Specify the target filename to include those options.
+
 Testing: convert -O bochs -o help
 qemu-img: Format driver 'bochs' does not support image creation
=20
--=20
2.20.1


