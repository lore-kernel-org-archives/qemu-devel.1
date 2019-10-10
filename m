Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E190ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561AD214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561AD214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXct-0004te-V6
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWra-0007E8-Ci
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrW-0008OF-D3
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrS-0008Mi-Ol; Thu, 10 Oct 2019 07:44:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 04B44308FE8F;
 Thu, 10 Oct 2019 11:44:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AF3510098FB;
 Thu, 10 Oct 2019 11:44:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 27/36] iotests: Disable 125 on broken XFS versions
Date: Thu, 10 Oct 2019 13:42:51 +0200
Message-Id: <20191010114300.7746-28-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 10 Oct 2019 11:44:02 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

And by that I mean all XFS versions, as far as I can tell.  All details
are in the comment below.

We never noticed this problem because we only read the first number from
qemu-img info's "disk size" output -- and that is effectively useless,
because qemu-img prints a human-readable value (which generally includes
a decimal point).  That will be fixed in the next patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190925183231.11196-3-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/125 | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index df328a63a6..0ef51f1e21 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -49,6 +49,46 @@ if [ -z "$TEST_IMG_FILE" ]; then
     TEST_IMG_FILE=3D$TEST_IMG
 fi
=20
+# Test whether we are running on a broken XFS version.  There is this
+# bug:
+
+# $ rm -f foo
+# $ touch foo
+# $ block_size=3D4096 # Your FS's block size
+# $ fallocate -o $((block_size / 2)) -l $block_size foo
+# $ LANG=3DC xfs_bmap foo | grep hole
+#         1: [8..15]: hole
+#
+# The problem is that the XFS driver rounds down the offset and
+# rounds up the length to the block size, but independently.  As
+# such, it only allocates the first block in the example above,
+# even though it should allocate the first two blocks (because our
+# request is to fallocate something that touches both the first
+# two blocks).
+#
+# This means that when you then write to the beginning of the
+# second block, the disk usage of the first two blocks grows.
+#
+# That is precisely what fallocate() promises, though: That when you
+# write to an area that you have fallocated, no new blocks will have
+# to be allocated.
+
+touch "$TEST_IMG_FILE"
+# Assuming there is no FS with a block size greater than 64k
+fallocate -o 65535 -l 2 "$TEST_IMG_FILE"
+len0=3D$(get_image_size_on_host)
+
+# Write to something that in theory we have just fallocated
+# (Thus, the on-disk size should not increase)
+poke_file "$TEST_IMG_FILE" 65536 42
+len1=3D$(get_image_size_on_host)
+
+if [ $len1 -gt $len0 ]; then
+    _notrun "the test filesystem's fallocate() is broken"
+fi
+
+rm -f "$TEST_IMG_FILE"
+
 # Generally, we create some image with or without existing preallocation=
 and
 # then resize it. Then we write some data into the image and verify that=
 its
 # size does not change if we have used preallocation.
--=20
2.21.0


