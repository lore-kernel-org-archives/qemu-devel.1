Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF64AC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A1D2087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A1D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQIP-0000pg-St
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hsQFJ-0003al-Cp
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hsQFH-0006jY-Hl
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:24:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hsQF8-0006dq-DV; Tue, 30 Jul 2019 07:24:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6EED1308FBAF;
 Tue, 30 Jul 2019 11:24:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-75.ams2.redhat.com
 [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62F1C6092F;
 Tue, 30 Jul 2019 11:24:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 13:24:23 +0200
Message-Id: <20190730112425.21497-3-kwolf@redhat.com>
In-Reply-To: <20190730112425.21497-1-kwolf@redhat.com>
References: <20190730112425.21497-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 30 Jul 2019 11:24:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/4] Fixes: add read-zeroes to 051.out
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

The patch "iotests: Set read-zeroes on in null block driver for Valgrind"
with the commit ID a6862418fec4072 needs the change in 051.out when
compared against on the s390 system.

Fixes: a6862418fec40727b392c86dc13d9ec980efcb15
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/051.out | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 8993835b94..554c5ca90a 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -149,23 +149,23 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on
=20
 =3D=3D=3D Cache modes =3D=3D=3D
=20
-Testing: -drive driver=3Dnull-co,cache=3Dnone
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dnone
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
-Testing: -drive driver=3Dnull-co,cache=3Ddirectsync
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Ddirectsync
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
-Testing: -drive driver=3Dnull-co,cache=3Dwriteback
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwriteback
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
-Testing: -drive driver=3Dnull-co,cache=3Dwritethrough
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dwritethrough
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
-Testing: -drive driver=3Dnull-co,cache=3Dunsafe
+Testing: -drive driver=3Dnull-co,read-zeroes=3Don,cache=3Dunsafe
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
--=20
2.20.1


