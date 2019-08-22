Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC9BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E95D22CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E95D22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0new-0002No-GB
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i0ncL-0000Mt-8X
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i0ncK-0004N6-6f
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1i0ncK-0004Mu-1k; Thu, 22 Aug 2019 09:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5726A4E924;
 Thu, 22 Aug 2019 13:59:07 +0000 (UTC)
Received: from localhost (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD0735C21A;
 Thu, 22 Aug 2019 13:59:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 15:58:37 +0200
Message-Id: <20190822135839.32340-7-cohuck@redhat.com>
In-Reply-To: <20190822135839.32340-1-cohuck@redhat.com>
References: <20190822135839.32340-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 22 Aug 2019 13:59:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/7] s390x/tcg: Flush the TLB of all CPUs on
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20190816084708.602-5-david@redhat.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mem_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 29d9eaa5b725..91ba2e03d95c 100644
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
2.20.1


