Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5244DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F5321924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F5321924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwOI-0005wN-6N
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAvsa-0006i8-Ec
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAvlS-0000q3-M4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:42:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAvlS-0000ow-EP; Thu, 19 Sep 2019 08:42:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB4FF10C093C;
 Thu, 19 Sep 2019 12:42:25 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A00D25D6B2;
 Thu, 19 Sep 2019 12:42:21 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:40:56 +0200
Message-Id: <20190919124115.11510-16-cohuck@redhat.com>
In-Reply-To: <20190919124115.11510-1-cohuck@redhat.com>
References: <20190919124115.11510-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 19 Sep 2019 12:42:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/34] s390x/tcg: Always use MMU_USER_IDX for
 CONFIG_USER_ONLY
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Although we basically ignore the index all the time for CONFIG_USER_ONLY,
let's simply skip all the checks and always return MMU_USER_IDX in
cpu_mmu_index() and get_mem_index().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h       | 4 ++++
 target/s390x/translate.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 79202c098096..163dae13d710 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -328,6 +328,9 @@ extern const VMStateDescription vmstate_s390_cpu;
=20
 static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 {
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
     if (!(env->psw.mask & PSW_MASK_DAT)) {
         return MMU_REAL_IDX;
     }
@@ -351,6 +354,7 @@ static inline int cpu_mmu_index(CPUS390XState *env, b=
ool ifetch)
     default:
         abort();
     }
+#endif
 }
=20
 static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong=
 *pc,
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b0a2500e5f36..a3e43ff9ec0c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -318,6 +318,9 @@ static inline uint64_t ld_code4(CPUS390XState *env, u=
int64_t pc)
=20
 static int get_mem_index(DisasContext *s)
 {
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
     if (!(s->base.tb->flags & FLAG_MASK_DAT)) {
         return MMU_REAL_IDX;
     }
@@ -333,6 +336,7 @@ static int get_mem_index(DisasContext *s)
         tcg_abort();
         break;
     }
+#endif
 }
=20
 static void gen_exception(int excp)
--=20
2.20.1


