Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E06DC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3359D20652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3359D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLV92-00039w-El
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:58:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuq-00081W-GY
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuo-00024n-A6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUud-0001uR-Vs; Tue, 30 Apr 2019 11:43:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D35F5308621B;
	Tue, 30 Apr 2019 15:43:18 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AD294C7;
	Tue, 30 Apr 2019 15:43:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:29 +0200
Message-Id: <20190430154244.30083-13-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 30 Apr 2019 15:43:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/27] iotests: Perform the correct test in 082
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
Message-ID: <20190430154229.JJBJxYytMDIKN6c65GYJsj3jII9lWKL6xC4ZGu2rSsY@z>

From: Max Reitz <mreitz@redhat.com>

In the "amend" section of 082, we perform a single "convert" test
(namely "convert -o help").  That does not make sense, especially
because we have done exactly that "convert" test earlier in 082 already.

Replacing "convert" by "amend" yields an error, which is correct because
there is no point in "amend" having a default format.  The user has to
either specify the format, or give a file for qemu-img to probe.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/082     | 5 ++++-
 tests/qemu-iotests/082.out | 5 ++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index d0afa46e9a..278511dba4 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -212,7 +212,10 @@ run_qemu_img amend -f $IMGFMT -o backing_file=3D"$TE=
ST_IMG" -o ,, -o help "$TEST_I
=20
 # Leave out everything that isn't needed
 run_qemu_img amend -f $IMGFMT -o help
-run_qemu_img convert -o help
+
+# amend requires specifying either a format explicitly, or a file
+# which it can probe
+run_qemu_img amend -o help
=20
 # Try help option for a format that does not support amendment
 run_qemu_img amend -f bochs -o help
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index d36938da9b..9a23b68511 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -831,9 +831,8 @@ Creation options for 'qcow2':
=20
 Note that not all of these options may be amendable.
=20
-Testing: convert -o help
-Supported options:
-  size=3D<size>            - Virtual disk size
+Testing: amend -o help
+qemu-img: Expecting one image file name
=20
 Testing: amend -f bochs -o help
 qemu-img: Format driver 'bochs' does not support option amendment
--=20
2.20.1


