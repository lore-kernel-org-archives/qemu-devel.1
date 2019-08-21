Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5D9C3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B766422D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B766422D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MrQ-00009F-D6
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i0Mpb-0006DT-U3
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i0Mpa-0001BU-Jz
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:23:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i0Mpa-0001B0-Bn; Wed, 21 Aug 2019 05:23:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA571106BB20;
 Wed, 21 Aug 2019 09:23:01 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 069C25C22C;
 Wed, 21 Aug 2019 09:22:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 11:22:50 +0200
Message-Id: <20190821092252.26541-3-david@redhat.com>
In-Reply-To: <20190821092252.26541-1-david@redhat.com>
References: <20190821092252.26541-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 21 Aug 2019 09:23:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 2/4] s390x/tcg: Introduce probe_read_access()
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
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's introduce a helper to probe read access (by actually reading a
piece of data of every page) and add a comment why this might not be
100% safe in all scenarios. Once we actually run into that issue, we'll
have to think of something else.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/internal.h   |  2 ++
 target/s390x/mem_helper.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c243fa725b..bdb833c525 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -354,6 +354,8 @@ void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, u=
intptr_t ra);
=20
 /* mem_helper.c */
 target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
+void probe_read_access(CPUS390XState *env, uint64_t addr, uint64_t len,
+                       uintptr_t ra);
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra);
=20
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 7819aca15d..4e9d126e2c 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2612,6 +2612,40 @@ uint32_t HELPER(cu42)(CPUS390XState *env, uint32_t=
 r1, uint32_t r2, uint32_t m3)
                            decode_utf32, encode_utf16);
 }
=20
+/*
+ * Make sure the read access is permitted and TLB entries are created. I=
n
+ * very rare cases it might happen that the actual accesses might need
+ * new MMU translations. If the page tables were changed in between, we
+ * might still trigger a fault. However, this seems to barely happen, so=
 we
+ * can ignore this for now.
+ */
+void probe_read_access(CPUS390XState *env, uint64_t addr, uint64_t len,
+                       uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    if (!guest_addr_valid(addr) || !guest_addr_valid(addr + len - 1) ||
+        page_check_range(addr, len, PAGE_READ) < 0) {
+        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
+    }
+#else
+    while (len) {
+        const uint64_t pagelen =3D -(addr | -TARGET_PAGE_MASK);
+        const uint64_t curlen =3D MIN(pagelen, len);
+
+        cpu_ldub_data_ra(env, addr, ra);
+        addr =3D wrap_address(env, addr + curlen);
+        len -=3D curlen;
+    }
+#endif
+}
+
+/*
+ * Make sure the write access is permitted and TLB entries are created. =
In
+ * very rare cases it might happen that the actual accesses might need
+ * new MMU translations - especially, on LAP protected pages. If the pag=
e
+ * tables were changed in between, we might still trigger a fault. Howev=
er,
+ * this seems to barely happen, so we can ignore this for now.
+ */
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra)
 {
--=20
2.21.0


