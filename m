Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E858BC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93ED2063F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93ED2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyXv8-0000TE-Ey
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 04:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1hyXtN-0007CE-H2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 04:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hyXtL-0003za-U4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 04:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hyXtL-0003yk-Or; Fri, 16 Aug 2019 04:47:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BE34308A9BE;
 Fri, 16 Aug 2019 08:47:23 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-249.ams2.redhat.com [10.36.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1306E43FE2;
 Fri, 16 Aug 2019 08:47:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 10:47:06 +0200
Message-Id: <20190816084708.602-5-david@redhat.com>
In-Reply-To: <20190816084708.602-1-david@redhat.com>
References: <20190816084708.602-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 16 Aug 2019 08:47:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/6] s390x/tcg: Flush the TLB of all CPUs on
 SSKE and RRBE
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Whenever we modify a storage key, we should flush the TLBs of all CPUs,
so the MMU fault handling code can properly consider the changed storage
key (to e.g., properly set the reference and change bit on the next
accesses).

These functions are barely used in modern Linux guests, so the performanc=
e
implications are neglectable for now.

This is a preparation for better reference and change bit handling for
TCG, which will require more MMU changes.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 29d9eaa5b7..91ba2e03d9 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1815,6 +1815,11 @@ void HELPER(sske)(CPUS390XState *env, uint64_t r1,=
 uint64_t r2)
=20
     key =3D (uint8_t) r1;
     skeyclass->set_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
+   /*
+    * As we can only flush by virtual address and not all the entries
+    * that point to a physical address we have to flush the whole TLB.
+    */
+    tlb_flush_all_cpus_synced(env_cpu(env));
 }
=20
 /* reset reference bit extended */
@@ -1843,6 +1848,11 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t=
 r2)
     if (skeyclass->set_skeys(ss, r2 / TARGET_PAGE_SIZE, 1, &key)) {
         return 0;
     }
+   /*
+    * As we can only flush by virtual address and not all the entries
+    * that point to a physical address we have to flush the whole TLB.
+    */
+    tlb_flush_all_cpus_synced(env_cpu(env));
=20
     /*
      * cc
--=20
2.21.0


