Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C05DC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455502086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455502086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFzML-0001L2-EI
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 07:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iFzLf-0000wC-0b
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iFzLd-0004q5-Ir
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iFzLd-0004p7-DW
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:32:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CEF130ADBA1;
 Thu,  3 Oct 2019 11:32:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-64.ams2.redhat.com [10.36.117.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06A8060BF3;
 Thu,  3 Oct 2019 11:32:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Subject: [PATCH] kvm: Initialize kvm_physical_log_clear ret local variable
Date: Thu,  3 Oct 2019 13:32:26 +0200
Message-Id: <20191003113226.27515-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 03 Oct 2019 11:32:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If there is no slot in the section ret is not initialized. This triggers
a compilation error at caller site.

error: =E2=80=98ret=E2=80=99 may be used uninitialized in this function
[-Werror=3Dmaybe-uninitialized]
     if (r < 0) {

Fixes: 84516e5b8d ("kvm: clear dirty bitmaps from all overlapping memslot=
s")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index aabe097c41..e2605da22e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -712,7 +712,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *=
kml,
     KVMState *s =3D kvm_state;
     uint64_t start, size, offset, count;
     KVMSlot *mem;
-    int ret, i;
+    int ret =3D 0, i;
=20
     if (!s->manual_dirty_log_protect) {
         /* No need to do explicit clear */
--=20
2.20.1


