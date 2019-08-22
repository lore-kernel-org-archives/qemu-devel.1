Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB5AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A8F20856
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A8F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0niG-00068X-8E
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i0nc7-0008UW-AT
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i0nc6-0004EH-Cu
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:58:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1i0nc6-0004Dy-4y; Thu, 22 Aug 2019 09:58:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 755F62BFDC;
 Thu, 22 Aug 2019 13:58:53 +0000 (UTC)
Received: from localhost (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C30135D9E5;
 Thu, 22 Aug 2019 13:58:50 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 15:58:34 +0200
Message-Id: <20190822135839.32340-4-cohuck@redhat.com>
In-Reply-To: <20190822135839.32340-1-cohuck@redhat.com>
References: <20190822135839.32340-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 22 Aug 2019 13:58:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/7] s390x/mmu: Trace the right value if
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We want to trace the actual return value, not "0".

Fixes: 0f5f669147b5 ("s390x: Enable new s390-storage-keys device")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190816084708.602-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mmu_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 7a563110f016..6cf74502ef1e 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -423,7 +423,8 @@ int mmu_translate(CPUS390XState *env, target_ulong va=
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
@@ -436,7 +437,8 @@ int mmu_translate(CPUS390XState *env, target_ulong va=
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
2.20.1


