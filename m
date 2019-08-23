Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E63C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3238621726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3238621726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53699 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i16Xh-0002sF-6b
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 06:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i16UM-0006dG-T7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i16UL-0008Ar-Cb
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:08:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i16UL-0008A8-6S; Fri, 23 Aug 2019 06:08:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7BBC0309B688;
 Fri, 23 Aug 2019 10:08:08 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 732065D6B2;
 Fri, 23 Aug 2019 10:08:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 12:07:37 +0200
Message-Id: <20190823100741.9621-6-david@redhat.com>
In-Reply-To: <20190823100741.9621-1-david@redhat.com>
References: <20190823100741.9621-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 23 Aug 2019 10:08:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 5/9] mips/tcg: Call probe_write() for
 CONFIG_USER_ONLY as well
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

Let's call it also for CONFIG_USER_ONLY. While at it, add a FIXME and get
rid of one local variable.

MIPS code probably needs a bigger refactoring in regards of
ensure_writable_pages(), similar to s390x, so for example, watchpoints
can be handled reliably later. The actually accessed addresses should
be probed only, not full pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/mips/op_helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index f88a3ab904..221e8bb1d7 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -4536,16 +4536,14 @@ static inline void ensure_writable_pages(CPUMIPSS=
tate *env,
                                          int mmu_idx,
                                          uintptr_t retaddr)
 {
-#if !defined(CONFIG_USER_ONLY)
-    target_ulong page_addr;
+    /* FIXME: Probe the actual accesses (pass and use a size) */
     if (unlikely(MSA_PAGESPAN(addr))) {
         /* first page */
         probe_write(env, addr, 0, mmu_idx, retaddr);
         /* second page */
-        page_addr =3D (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-        probe_write(env, page_addr, 0, mmu_idx, retaddr);
+        addr =3D (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+        probe_write(env, addr, 0, mmu_idx, retaddr);
     }
-#endif
 }
=20
 void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
--=20
2.21.0


