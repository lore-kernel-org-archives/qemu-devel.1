Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C4BC49ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 01:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9468320863
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 01:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9468320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8EBs-0001dk-Je
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 21:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i8EAG-00012Q-V7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i8EAD-0007pS-My
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1i8EAD-0007p4-Ho
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:44:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4BD7C308213F;
 Thu, 12 Sep 2019 01:44:48 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-203.bos.redhat.com [10.18.17.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 002F210018FF;
 Thu, 12 Sep 2019 01:44:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 21:44:42 -0400
Message-Id: <20190912014442.5757-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 12 Sep 2019 01:44:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] docker: add sanitizers back to clang build
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fedora23 is but a distant twinkle.
The sanitizer works again, and even if not,
we have --enable-sanitizers now.

---

The problem is that I do see some ASAN warnings:

  TEST    check-qtest-aarch64: tests/device-introspect-test

Direct leak of 2272 byte(s) in 48 object(s) allocated from:
    #0 0x55aea5598b4e in calloc (/tmp/qemu-test/build/aarch64-softmmu/qem=
u-system-aarch64+0x19a9b4e)
    #1 0x7f783ff11ce0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55ce0)

Direct leak of 864 byte(s) in 18 object(s) allocated from:
    #0 0x55aea5598b4e in calloc (/tmp/qemu-test/build/aarch64-softmmu/qem=
u-system-aarch64+0x19a9b4e)
    #1 0x7f783ff11ce0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55ce0)
    #2 0x55aea712b379 in object_initialize_with_type /tmp/qemu-test/src/q=
om/object.c:467:5


I'd run it again, but it took eight years to get to that point,
it's late and I'm tired.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/test-clang | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index 324e341cea..db9e6970b7 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -17,11 +17,7 @@ requires clang
=20
 cd "$BUILD_DIR"
=20
-OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang"
-# -fsanitize=3Dundefined is broken on Fedora 23, skip it for now
-# See also: https://bugzilla.redhat.com/show_bug.cgi?id=3D1263834
-#OPTS=3D"$OPTS --extra-cflags=3D-fsanitize=3Dundefined \
-    #--extra-cflags=3D-fno-sanitize=3Dfloat-divide-by-zero"
+OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang --enable-sanitize=
rs"
 build_qemu $OPTS
 check_qemu
 install_qemu
--=20
2.21.0


