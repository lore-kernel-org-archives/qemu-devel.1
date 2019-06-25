Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC41C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A010F205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A010F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfsug-0001t1-Tz
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 17:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41518)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfsrK-00088X-Va
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfsrJ-0003pn-P1
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfsrH-0003gm-Cs; Tue, 25 Jun 2019 17:20:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B16930821BE;
 Tue, 25 Jun 2019 21:20:06 +0000 (UTC)
Received: from localhost (ovpn-204-63.brq.redhat.com [10.40.204.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1349B10018F9;
 Tue, 25 Jun 2019 21:20:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 25 Jun 2019 23:19:51 +0200
Message-Id: <20190625211955.15664-2-mreitz@redhat.com>
In-Reply-To: <20190625211955.15664-1-mreitz@redhat.com>
References: <20190625211955.15664-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 25 Jun 2019 21:20:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/5] iotests: Add -display none to the qemu
 options
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

Without this argument, qemu will print an angry message about not being
able to connect to a display server if $DISPLAY is not set.  For me,
that breaks iotests.supported_formats() because it thus only sees
["Could", "not", "connect"] as the supported formats.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f925606cc5..f2a0df8af2 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -581,13 +581,13 @@ export QEMU_PROG=3D"$(type -p "$QEMU_PROG")"
=20
 case "$QEMU_PROG" in
     *qemu-system-arm|*qemu-system-aarch64)
-        export QEMU_OPTIONS=3D"-nodefaults -machine virt,accel=3Dqtest"
+        export QEMU_OPTIONS=3D"-nodefaults -display none -machine virt,a=
ccel=3Dqtest"
         ;;
     *qemu-system-tricore)
-        export QEMU_OPTIONS=3D"-nodefaults -machine tricore_testboard,ac=
cel=3Dqtest"
+        export QEMU_OPTIONS=3D"-nodefaults -display none -machine tricor=
e_testboard,accel=3Dqtest"
         ;;
     *)
-        export QEMU_OPTIONS=3D"-nodefaults -machine accel=3Dqtest"
+        export QEMU_OPTIONS=3D"-nodefaults -display none -machine accel=3D=
qtest"
         ;;
 esac
=20
--=20
2.21.0


