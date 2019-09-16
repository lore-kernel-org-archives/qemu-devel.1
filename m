Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A35C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2720220650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2720220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9rg8-0003xt-JH
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i9rX2-0003Fu-IS
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i9rX1-0000QM-5g
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:59:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i9rX0-0000Ps-Uu; Mon, 16 Sep 2019 09:59:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 40C377FDCA;
 Mon, 16 Sep 2019 13:59:06 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-103.ams2.redhat.com [10.36.117.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BA0110018FF;
 Mon, 16 Sep 2019 13:59:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:57:52 +0200
Message-Id: <20190916135806.1269-16-david@redhat.com>
In-Reply-To: <20190916135806.1269-1-david@redhat.com>
References: <20190916135806.1269-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 16 Sep 2019 13:59:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 15/29] s390x/tcg: Always use MMU_USER_IDX
 for CONFIG_USER_ONLY
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index 79202c0980..163dae13d7 100644
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
index b0a2500e5f..a3e43ff9ec 100644
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
2.21.0


