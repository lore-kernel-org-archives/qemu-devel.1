Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C66CC73C64
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 23:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3811C2082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 23:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3811C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkzY4-0000kR-7q
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 19:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48507)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hkzV8-0007CS-Vb
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 19:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hkzV6-0002sP-RC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 19:26:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hkzUy-0002eg-Ae; Tue, 09 Jul 2019 19:26:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B900307E040;
 Tue,  9 Jul 2019 23:26:07 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33D035B80B;
 Tue,  9 Jul 2019 23:26:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 19:25:39 -0400
Message-Id: <20190709232550.10724-8-jsnow@redhat.com>
In-Reply-To: <20190709232550.10724-1-jsnow@redhat.com>
References: <20190709232550.10724-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 09 Jul 2019 23:26:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 07/18] hbitmap: Fix merge when b is empty,
 and result is not an alias of a
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 John Snow <jsnow@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nobody calls the function like this currently, but we neither prohibit
or cope with this behavior. I decided to make the function cope with it.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 util/hbitmap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 7905212a8b..3b6acae42b 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -781,8 +781,9 @@ bool hbitmap_can_merge(const HBitmap *a, const HBitma=
p *b)
 }
=20
 /**
- * Given HBitmaps A and B, let A :=3D A (BITOR) B.
- * Bitmap B will not be modified.
+ * Given HBitmaps A and B, let R :=3D A (BITOR) B.
+ * Bitmaps A and B will not be modified,
+ *     except when bitmap R is an alias of A or B.
  *
  * @return true if the merge was successful,
  *         false if it was not attempted.
@@ -797,7 +798,13 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *=
b, HBitmap *result)
     }
     assert(hbitmap_can_merge(b, result));
=20
-    if (hbitmap_count(b) =3D=3D 0) {
+    if ((!hbitmap_count(a) && result =3D=3D b) ||
+        (!hbitmap_count(b) && result =3D=3D a)) {
+        return true;
+    }
+
+    if (!hbitmap_count(a) && !hbitmap_count(b)) {
+        hbitmap_reset_all(result);
         return true;
     }
=20
--=20
2.21.0


