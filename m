Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D20C0650F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 07:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BD9206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 07:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BD9206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxngi-0005vx-2b
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 03:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1hxndo-0002Gb-IA
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 03:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hxndm-0004jE-Kj
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 03:24:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hxndm-0004iX-FY; Wed, 14 Aug 2019 03:24:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B08CF3082E8E;
 Wed, 14 Aug 2019 07:24:13 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-4.ams2.redhat.com [10.36.117.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF26460852;
 Wed, 14 Aug 2019 07:24:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 09:23:54 +0200
Message-Id: <20190814072355.15333-6-david@redhat.com>
In-Reply-To: <20190814072355.15333-1-david@redhat.com>
References: <20190814072355.15333-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 14 Aug 2019 07:24:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 v2 5/6] s390x/mmu: Better storage key
 reference and change bit handling
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any access sets the reference bit. In case we have a read-fault, we
should not allow writes to the TLB entry if the change bit was not
already set.

This is a preparation for proper storage-key reference/change bit handlin=
g
in TCG and a fix for KVM whereby read accesses would set the change
bit (old KVM versions without the ioctl to carry out the translation).

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index d22c6b9c81..6cc81a29b6 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -420,14 +420,28 @@ nodat:
             return 0;
         }
=20
-        if (*flags & PAGE_READ) {
-            key |=3D SK_R;
-        }
-
-        if (*flags & PAGE_WRITE) {
+        switch (rw) {
+        case MMU_DATA_LOAD:
+        case MMU_INST_FETCH:
+            /*
+             * The TLB entry has to remain write-protected on read-fault=
s if
+             * the storage key does not indicate a change already. Other=
wise
+             * we might miss setting the change bit on write accesses.
+             */
+            if (!(key & SK_C)) {
+                *flags &=3D ~PAGE_WRITE;
+            }
+            break;
+        case MMU_DATA_STORE:
             key |=3D SK_C;
+            break;
+        default:
+            g_assert_not_reached();
         }
=20
+        /* Any store/fetch sets the reference bit */
+        key |=3D SK_R;
+
         r =3D skeyclass->set_skeys(ss, *raddr / TARGET_PAGE_SIZE, 1, &ke=
y);
         if (r) {
             trace_set_skeys_nonzero(r);
--=20
2.21.0


