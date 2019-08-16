Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CA5C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E392063F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E392063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyXwy-0003gS-G4
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 04:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1hyXtG-00071U-A3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 04:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hyXtF-0003tx-68
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 04:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hyXtF-0003tR-0s; Fri, 16 Aug 2019 04:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 387C3369D3;
 Fri, 16 Aug 2019 08:47:16 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-249.ams2.redhat.com [10.36.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E621F6DF;
 Fri, 16 Aug 2019 08:47:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 10:47:03 +0200
Message-Id: <20190816084708.602-2-david@redhat.com>
In-Reply-To: <20190816084708.602-1-david@redhat.com>
References: <20190816084708.602-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 16 Aug 2019 08:47:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/6] s390x/mmu: Trace the right value if
 setting/getting the storage key fails
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

We want to trace the actual return value, not "0".

Fixes: 0f5f669147b5 (s390x: Enable new s390-storage-keys device)
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 6e9c4d6151..b236196802 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -422,7 +422,8 @@ int mmu_translate(CPUS390XState *env, target_ulong va=
ddr, int rw, uint64_t asc,
     *raddr =3D mmu_real2abs(env, *raddr);
=20
     if (r =3D=3D 0 && *raddr < ram_size) {
-        if (skeyclass->get_skeys(ss, *raddr / TARGET_PAGE_SIZE, 1, &key)=
) {
+        r =3D skeyclass->get_skeys(ss, *raddr / TARGET_PAGE_SIZE, 1, &ke=
y);
+        if (r) {
             trace_get_skeys_nonzero(r);
             return 0;
         }
@@ -435,7 +436,8 @@ int mmu_translate(CPUS390XState *env, target_ulong va=
ddr, int rw, uint64_t asc,
             key |=3D SK_C;
         }
=20
-        if (skeyclass->set_skeys(ss, *raddr / TARGET_PAGE_SIZE, 1, &key)=
) {
+        r =3D skeyclass->set_skeys(ss, *raddr / TARGET_PAGE_SIZE, 1, &ke=
y);
+        if (r) {
             trace_set_skeys_nonzero(r);
             return 0;
         }
--=20
2.21.0


