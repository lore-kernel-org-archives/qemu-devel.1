Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3041AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0699C20856
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0699C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0niB-00066n-QT
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i0ncN-0000Qa-2Z
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i0ncM-0004O5-0M
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:59:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1i0ncL-0004Ni-RN; Thu, 22 Aug 2019 09:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2BEC5102BB3D;
 Thu, 22 Aug 2019 13:59:09 +0000 (UTC)
Received: from localhost (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD49160619;
 Thu, 22 Aug 2019 13:59:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 15:58:38 +0200
Message-Id: <20190822135839.32340-8-cohuck@redhat.com>
In-Reply-To: <20190822135839.32340-1-cohuck@redhat.com>
References: <20190822135839.32340-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 22 Aug 2019 13:59:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/7] s390x/mmu: Better storage key reference and
 change bit handling
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Any access sets the reference bit. In case we have a read-fault, we
should not allow writes to the TLB entry if the change bit was not
already set.

This is a preparation for proper storage-key reference/change bit handlin=
g
in TCG and a fix for KVM whereby read accesses would set the change
bit (old KVM versions without the ioctl to carry out the translation).

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190816084708.602-6-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mmu_helper.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 40b6c1fc36a9..61654e07dec8 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -421,14 +421,28 @@ nodat:
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
2.20.1


