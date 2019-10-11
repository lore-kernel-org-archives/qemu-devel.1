Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EFECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5143B2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5143B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIquZ-0007Nt-5a
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIqtB-0005gV-Vg
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIqtA-000435-MQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIqt8-00041q-11; Fri, 11 Oct 2019 05:07:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FE5A1017C11;
 Fri, 11 Oct 2019 09:07:05 +0000 (UTC)
Received: from localhost (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4F665D6C8;
 Fri, 11 Oct 2019 09:07:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests/028: Fix for long $TEST_DIRs
Date: Fri, 11 Oct 2019 11:07:02 +0200
Message-Id: <20191011090702.29721-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 11 Oct 2019 09:07:05 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For long test image paths, the order of the "Formatting" line and the
"(qemu)" prompt after a drive_backup HMP command may be reversed.  It is
not well-defined anyway, so just silence everything and wait until we
get a prompt.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/028     | 6 ++++--
 tests/qemu-iotests/028.out | 1 -
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 71301ec6e5..da3187719a 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -119,8 +119,10 @@ fi
 # Silence output since it contains the disk image path and QEMU's readli=
ne
 # character echoing makes it very hard to filter the output. Plus, there
 # is no telling how many times the command will repeat before succeeding=
.
-_send_qemu_cmd $h "drive_backup disk ${TEST_IMG}.copy" "(qemu)" >/dev/nu=
ll
-_send_qemu_cmd $h "" "Formatting" | _filter_img_create
+# Furthermore, the order of the "Formatting" line and the "(qemu)" promp=
t
+# is undefined.
+_send_qemu_cmd $h "drive_backup disk ${TEST_IMG}.copy" "Formatting" >/de=
v/null
+_send_qemu_cmd $h "" "(qemu)" >/dev/null
 qemu_cmd_repeat=3D20 _send_qemu_cmd $h "info block-jobs" "No active jobs=
" >/dev/null
 _send_qemu_cmd $h "info block-jobs" "No active jobs"
 _send_qemu_cmd $h 'quit' ""
diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
index 7d54aeb003..37aed84436 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -468,7 +468,6 @@ No errors were found on the image.
=20
 block-backup
=20
-Formatting 'TEST_DIR/t.IMGFMT.copy', fmt=3DIMGFMT size=3D4294968832 back=
ing_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 (qemu) info block-jobs
 No active jobs
 =3D=3D=3D IO: pattern 195
--=20
2.21.0


