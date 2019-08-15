Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A556C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB0120578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB0120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIqi-0002h3-31
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjk-0002h9-Ca
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjf-0003G0-58
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIje-0003Fg-UG
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41BFF8666C;
 Thu, 15 Aug 2019 16:36:22 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 007F23737;
 Thu, 15 Aug 2019 16:36:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:51 +0100
Message-Id: <20190815163504.18937-21-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 15 Aug 2019 16:36:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 20/33] migration/postcopy: simplify calculation
 of run_start and fixup_start_addr
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

The purpose of the calculation is to find a HostPage which is partially
dirty.

  * fixup_start_addr points to the start of the HostPage to discard
  * run_start points to the next HostPage to check

While in the middle stage, there would two cases for run_start:

  * aligned with HostPage means this is not partially dirty
  * not aligned means this is partially dirty

When it is aligned, no work and calculation is necessary. run_start
already points to the start of next HostPage and is ready to continue.

When it is not aligned, the calculation could be simplified with:

  * fixup_start_addr =3D QEMU_ALIGN_DOWN(run_start, host_ratio)
  * run_start =3D QEMU_ALIGN_UP(run_start, host_ratio)

By doing so, run_start always points to the next HostPage to check.
fixup_start_addr always points to the HostPage to discard.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190806004648.8659-2-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f428639af5..d2184c3cfc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2955,7 +2955,6 @@ static void postcopy_chunk_hostpages_pass(Migration=
State *ms, bool unsent_pass,
     }
=20
     while (run_start < pages) {
-        unsigned long fixup_start_addr;
         unsigned long host_offset;
=20
         /*
@@ -2963,45 +2962,26 @@ static void postcopy_chunk_hostpages_pass(Migrati=
onState *ms, bool unsent_pass,
          * page, then we need to fixup this host page.
          */
         host_offset =3D run_start % host_ratio;
-        if (host_offset) {
-            fixup_start_addr =3D run_start - host_offset;
-            /*
-             * This host page has gone, the next loop iteration starts
-             * from after the fixup
-             */
-            run_start =3D fixup_start_addr + host_ratio;
-        } else {
+        if (!host_offset) {
             /* Find the end of this run */
-            unsigned long run_end;
             if (unsent_pass) {
-                run_end =3D find_next_bit(unsentmap, pages, run_start + =
1);
+                run_start =3D find_next_bit(unsentmap, pages, run_start =
+ 1);
             } else {
-                run_end =3D find_next_zero_bit(bitmap, pages, run_start =
+ 1);
+                run_start =3D find_next_zero_bit(bitmap, pages, run_star=
t + 1);
             }
             /*
              * If the end isn't at the start of a host page, then the
              * run doesn't finish at the end of a host page
              * and we need to discard.
              */
-            host_offset =3D run_end % host_ratio;
-            if (host_offset) {
-                fixup_start_addr =3D run_end - host_offset;
-                /*
-                 * This host page has gone, the next loop iteration star=
ts
-                 * from after the fixup
-                 */
-                run_start =3D fixup_start_addr + host_ratio;
-            } else {
-                /*
-                 * No discards on this iteration, next loop starts from
-                 * next sent/dirty page
-                 */
-                run_start =3D run_end + 1;
-            }
+            host_offset =3D run_start % host_ratio;
         }
=20
         if (host_offset) {
             unsigned long page;
+            unsigned long fixup_start_addr =3D QEMU_ALIGN_DOWN(run_start=
,
+                                                             host_ratio)=
;
+            run_start =3D QEMU_ALIGN_UP(run_start, host_ratio);
=20
             /* Tell the destination to discard this page */
             if (unsent_pass || !test_bit(fixup_start_addr, unsentmap)) {
--=20
2.21.0


