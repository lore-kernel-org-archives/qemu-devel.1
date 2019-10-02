Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB9EC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D685121D81
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D685121D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFidT-0004L7-0k
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFicW-0003nh-Dg
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFicV-00025S-GJ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFicR-00023w-Rg; Wed, 02 Oct 2019 13:40:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0A1FC049D59;
 Wed,  2 Oct 2019 17:40:54 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C3905C290;
 Wed,  2 Oct 2019 17:40:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests/162: Fix for newer Linux 5.3+
Date: Wed,  2 Oct 2019 19:40:52 +0200
Message-Id: <20191002174052.5773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 02 Oct 2019 17:40:54 +0000 (UTC)
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

Linux 5.3 has made 0.0.0.0/8 a working IPv4 subnet.  As such, "42" is
now a valid host, and the connection to it will (hopefully) time out
over a long period rather than quickly return with EINVAL.

So let us use a negative integer for testing that NBD will not crash
when it receives integer hosts.  This way, the connection will again
fail quickly and reliably.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/162     | 2 +-
 tests/qemu-iotests/162.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 2d719afbed..c0053ed975 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -46,7 +46,7 @@ echo '=3D=3D=3D NBD =3D=3D=3D'
 # NBD expects all of its arguments to be strings
=20
 # So this should not crash
-$QEMU_IMG info 'json:{"driver": "nbd", "host": 42}'
+$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}'
=20
 # And this should not treat @port as if it had not been specified
 # (We need to set up a server here, because the error message for "Conne=
ction
diff --git a/tests/qemu-iotests/162.out b/tests/qemu-iotests/162.out
index 3c5be2c569..5a00d36d17 100644
--- a/tests/qemu-iotests/162.out
+++ b/tests/qemu-iotests/162.out
@@ -1,7 +1,7 @@
 QA output created by 162
=20
 =3D=3D=3D NBD =3D=3D=3D
-qemu-img: Could not open 'json:{"driver": "nbd", "host": 42}': Failed to=
 connect socket: Invalid argument
+qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address r=
esolution failed for -1:10809: Name or service not known
 image: nbd://localhost:PORT
 image: nbd+unix://?socket=3D42
=20
--=20
2.21.0


