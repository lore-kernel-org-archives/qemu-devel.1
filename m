Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A0BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A1A22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A1A22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Msx-00035R-Gd
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i0Mpf-0006LA-PD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i0Mpe-0001ED-EW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:23:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i0Mpe-0001DZ-8q; Wed, 21 Aug 2019 05:23:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C62B1801172;
 Wed, 21 Aug 2019 09:23:05 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5B895C22C;
 Wed, 21 Aug 2019 09:23:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 11:22:52 +0200
Message-Id: <20190821092252.26541-5-david@redhat.com>
In-Reply-To: <20190821092252.26541-1-david@redhat.com>
References: <20190821092252.26541-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 21 Aug 2019 09:23:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 4/4] s390x/tcg: MOVE (MVC): Fault-safe
 handling
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

MVC can cross page boundaries. In case we fault on the second page, we
already partially copied data. If we have overlaps, we would
trigger a fault after having partially moved data, eventually having
our original data already overwritten. When continuing after the fault,
we would try to move already modified data, not the original data -
very bad.

glibc started to use MVC for forward memmove() and is able to trigger
exectly this corruption (via rpmbuild and rpm). Fedora 31 (rawhide)
currently fails to install as we trigger rpm database corruptions due to
this bug.

Let's properly probe for read/write access in case we cross page
boundaries. In case we don't cross boundaries, the first accesses will
trigger the fault.

We'll have to do the same for other instructions (like MVCLE), too. But
the more I look at the other MOVE variantes the more issues I find, so
let's handle MVC for now only.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index bf7dfcdc7a..44001ec21a 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -104,6 +104,11 @@ static inline void cpu_stsize_data_ra(CPUS390XState =
*env, uint64_t addr,
     }
 }
=20
+static inline bool is_single_page_access(uint64_t addr, uint32_t size)
+{
+    return (addr & TARGET_PAGE_MASK) =3D=3D ((addr + size - 1) & TARGET_=
PAGE_MASK);
+}
+
 static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
                         uint32_t l, uintptr_t ra)
 {
@@ -310,6 +315,10 @@ static uint32_t do_helper_mvc(CPUS390XState *env, ui=
nt32_t l, uint64_t dest,
     /* MVC always copies one more byte than specified - maximum is 256 *=
/
     l++;
=20
+    if (unlikely(!is_single_page_access(dest, l))) {
+        probe_write_access(env, dest, l, ra);
+    }
+
     /*
      * "When the operands overlap, the result is obtained as if the oper=
ands
      * were processed one byte at a time". Only non-overlapping or forwa=
rd
@@ -317,7 +326,14 @@ static uint32_t do_helper_mvc(CPUS390XState *env, ui=
nt32_t l, uint64_t dest,
      */
     if (dest =3D=3D src + 1) {
         fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l, ra);
-    } else if (dest < src || src + l <=3D dest) {
+        return env->cc_op;
+    }
+
+    if (unlikely(!is_single_page_access(src, l))) {
+        probe_read_access(env, src, l, ra);
+    }
+
+    if (dest < src || src + l <=3D dest) {
         fast_memmove(env, dest, src, l, ra);
     } else {
         for (i =3D 0; i < l; i++) {
--=20
2.21.0


