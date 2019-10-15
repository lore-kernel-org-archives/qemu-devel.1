Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71246C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4362620854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4362620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKO4u-0000ND-HM
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNoH-0007D9-ML
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNoF-0000Hf-Lh
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNoD-0000Fu-7F; Tue, 15 Oct 2019 10:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64B53C0568FD;
 Tue, 15 Oct 2019 14:28:20 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEB2252FCC;
 Tue, 15 Oct 2019 14:28:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 16/21] iotests: Make 091 work with data_file
Date: Tue, 15 Oct 2019 16:27:24 +0200
Message-Id: <20191015142729.18123-17-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 15 Oct 2019 14:28:20 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The image end offset as reported by qemu-img check is different when
using an external data file; we do not care about its value here, so we
can just filter it.  Incidentally, common.rc already has _check_test_img
for us which does exactly that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/091     | 2 +-
 tests/qemu-iotests/091.out | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index f4b44659ae..0874fa84c8 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -101,7 +101,7 @@ echo "Check image pattern"
 ${QEMU_IO} -c "read -P 0x22 0 4M" "${TEST_IMG}" | _filter_testdir | _fil=
ter_qemu_io
=20
 echo "Running 'qemu-img check -r all \$TEST_IMG'"
-"${QEMU_IMG}" check -r all "${TEST_IMG}" 2>&1 | _filter_testdir | _filte=
r_qemu
+_check_test_img -r all
=20
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/091.out b/tests/qemu-iotests/091.out
index 5017f8c2d9..5ec7b00f13 100644
--- a/tests/qemu-iotests/091.out
+++ b/tests/qemu-iotests/091.out
@@ -23,6 +23,4 @@ read 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Running 'qemu-img check -r all $TEST_IMG'
 No errors were found on the image.
-80/16384 =3D 0.49% allocated, 0.00% fragmented, 0.00% compressed cluster=
s
-Image end offset: 5570560
 *** done
--=20
2.21.0


