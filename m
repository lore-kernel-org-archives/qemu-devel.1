Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79796C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A3620B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A3620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huezu-0007Gd-A1
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52039)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1huevy-0002Wa-Ek
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1huevx-0000SW-Gu
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:30:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1huevx-0000SA-8k; Mon, 05 Aug 2019 11:30:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B834308FBA0;
 Mon,  5 Aug 2019 15:30:00 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32CA160C83;
 Mon,  5 Aug 2019 15:29:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:29:39 +0200
Message-Id: <20190805152947.28536-2-david@redhat.com>
In-Reply-To: <20190805152947.28536-1-david@redhat.com>
References: <20190805152947.28536-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 05 Aug 2019 15:30:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.2 v1 1/9] s390x/mmu: Better ASC selection
 in s390_cpu_get_phys_page_debug()
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
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's select the ASC before calling the function and use MMU_DATA_LOAD.
This is a preparation to:
- Remove the ASC magic depending on the access mode from mmu_translate
- Implement IEP support, where we could run into access exceptions
  trying to fetch instructions

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 13ae9909ad..08166558a0 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -58,7 +58,15 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vadd=
r vaddr)
         vaddr &=3D 0x7fffffff;
     }
=20
-    if (mmu_translate(env, vaddr, MMU_INST_FETCH, asc, &raddr, &prot, fa=
lse)) {
+    /*
+     * We want to read the code, however, not run into access exceptions
+     * (especially, IEP).
+     */
+    if (asc !=3D PSW_ASC_HOME) {
+        asc =3D PSW_ASC_PRIMARY;
+    }
+
+    if (mmu_translate(env, vaddr, MMU_DATA_LOAD, asc, &raddr, &prot, fal=
se)) {
         return -1;
     }
     return raddr;
--=20
2.21.0


