Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDCCC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 07:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C807320874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 07:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C807320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i29r0-000566-JX
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 03:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i29my-0000Aq-UJ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 03:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i29mx-0002qe-2d
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 03:51:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i29mw-0002qB-TI; Mon, 26 Aug 2019 03:51:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2425410576DD;
 Mon, 26 Aug 2019 07:51:42 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-227.ams2.redhat.com [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBD1260C80;
 Mon, 26 Aug 2019 07:51:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 09:51:09 +0200
Message-Id: <20190826075112.25637-5-david@redhat.com>
In-Reply-To: <20190826075112.25637-1-david@redhat.com>
References: <20190826075112.25637-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 26 Aug 2019 07:51:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/7] tcg: Enforce single page access in
 probe_write()
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's enforce the interface restriction.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/tcg/cputlb.c    | 2 ++
 accel/tcg/user-exec.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7fc7aa9482..09fe4cdcc4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1088,6 +1088,8 @@ void probe_write(CPUArchState *env, target_ulong ad=
dr, int size, int mmu_idx,
     CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr =3D tlb_addr_write(entry);
=20
+    g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
+
     if (unlikely(!tlb_hit(tlb_addr, addr))) {
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 68f4425cbc..b25a342eaa 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -194,6 +194,8 @@ void probe_write(CPUArchState *env, target_ulong addr=
, int size, int mmu_idx,
     CPUState *cpu =3D env_cpu(env);
     CPUClass *cc;
=20
+    g_assert(-(addr | TARGET_PAGE_MASK) >=3D size);
+
     if (!guest_addr_valid(addr) ||
         page_check_range(addr, size, PAGE_WRITE) < 0) {
         cc =3D CPU_GET_CLASS(cpu);
--=20
2.21.0


