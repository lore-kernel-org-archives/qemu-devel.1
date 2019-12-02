Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF648C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88777215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="el4RgTSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88777215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibigf-0002zv-Bs
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibifL-0001Zo-Vu
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibifK-0004qU-Nh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:10:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibifK-0004q1-Jd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XYnrDHQuNid2efQL6vsAnPFCip/0nDxjoyWa3bMnsPI=;
 b=el4RgTSq/GmUN7H67KFvLPA1zT4zJ6ZycWGUVXeU3C9S3eMNAwapsLL5kkE5GOYLhbbi2Z
 T3Zu1lCMx526Uqu+X0s1TJrXU3L3mPjEwSHjWSZtQV1IZTTMRu7SxzQo6c+JejT3XNPpiv
 NiHDQzWnEinq5OEGkDvO7/RustsRpwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-xfOTKXOtMWGY2CzVSZe3vg-1; Mon, 02 Dec 2019 05:10:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 028CB100551D;
 Mon,  2 Dec 2019 10:10:47 +0000 (UTC)
Received: from thuth.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EB3819C68;
 Mon,  2 Dec 2019 10:10:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Subject: [PATCH v4 0/6] Enable more iotests during "make check-block"
Date: Mon,  2 Dec 2019 11:10:33 +0100
Message-Id: <20191202101039.8981-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xfOTKXOtMWGY2CzVSZe3vg-1
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As discussed here:

 https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00697.html

and here:

 https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01388.html

it would be good to have some more valuable iotests enabled in the
"auto" group to get better iotest coverage during "make check".

Since these Python-based tests require a QEMU that features a 'virtio-blk'
device, we can only run the Python tests if this device is available. With
binaries like qemu-system-tricore, the Python-based tests will be skipped.

v4:
 - The check for 'virtio-blk' is now done in the tests/qemu-iotests/check
   script instead of tests/check-block.sh (to avoid to duplicate the code
   that searches for the right QEMU binary - and we can also still run
   the shell-based tests this way).
 - Added the new patch to check for the availability of virtio devices in
   the iotests 127 and 267.
 - The patch that drops test 130 from the "auto" group has already been
   merged and thus been dropped from this series.

v3:
 - Test 183 fails on Patchew, so I removed it from the "auto" group
   again

v2:
 - Checked the iotests with NetBSD, too (now that Eduardo has
   re-activated Gerd's patches for creating NetBSD VM images)
 - Use 'openbsd' instead of 'openbsd6'
 - Use 'grep -q' instead of 'grep' for grep'ing silently
 - Added the patch to disable 130 from the "auto" group


John Snow (1):
  iotests: remove 'linux' from default supported platforms

Thomas Huth (5):
  iotests: Test 041 only works on certain systems
  iotests: Test 183 does not work on macOS and OpenBSD
  iotests: Check for the availability of the required devices in 267 and
    127
  iotests: Skip Python-based tests if QEMU does not support virtio-blk
  iotests: Enable more tests in the 'auto' group to improve test
    coverage

 tests/qemu-iotests/041        |  3 ++-
 tests/qemu-iotests/127        |  2 ++
 tests/qemu-iotests/183        |  1 +
 tests/qemu-iotests/267        |  2 ++
 tests/qemu-iotests/check      |  8 ++++++--
 tests/qemu-iotests/common.rc  | 14 ++++++++++++++
 tests/qemu-iotests/group      | 14 +++++++-------
 tests/qemu-iotests/iotests.py | 16 +++++++++++-----
 8 files changed, 45 insertions(+), 15 deletions(-)

--=20
2.18.1


