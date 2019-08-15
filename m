Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA67C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D1420578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D1420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIrD-0002vQ-LN
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIit-0001aO-Td
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIip-0002GF-8l
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIip-0002Fy-3Q
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F9C58666C;
 Thu, 15 Aug 2019 16:35:30 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E868160F8C;
 Thu, 15 Aug 2019 16:35:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:39 +0100
Message-Id: <20190815163504.18937-9-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 15 Aug 2019 16:35:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/33] migration/postcopy: do_fixup is true when
 host_offset is non-zero
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

This means it is not necessary to spare an extra variable to hold this
condition. Use host_offset directly is fine.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190710050814.31344-3-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index da399f2c8a..255f289bbb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2962,7 +2962,6 @@ static void postcopy_chunk_hostpages_pass(Migration=
State *ms, bool unsent_pass,
     }
=20
     while (run_start < pages) {
-        bool do_fixup =3D false;
         unsigned long fixup_start_addr;
         unsigned long host_offset;
=20
@@ -2972,7 +2971,6 @@ static void postcopy_chunk_hostpages_pass(Migration=
State *ms, bool unsent_pass,
          */
         host_offset =3D run_start % host_ratio;
         if (host_offset) {
-            do_fixup =3D true;
             fixup_start_addr =3D run_start - host_offset;
             /*
              * This host page has gone, the next loop iteration starts
@@ -2994,7 +2992,6 @@ static void postcopy_chunk_hostpages_pass(Migration=
State *ms, bool unsent_pass,
              */
             host_offset =3D run_end % host_ratio;
             if (host_offset) {
-                do_fixup =3D true;
                 fixup_start_addr =3D run_end - host_offset;
                 /*
                  * This host page has gone, the next loop iteration star=
ts
@@ -3010,7 +3007,7 @@ static void postcopy_chunk_hostpages_pass(Migration=
State *ms, bool unsent_pass,
             }
         }
=20
-        if (do_fixup) {
+        if (host_offset) {
             unsigned long page;
=20
             /* Tell the destination to discard this page */
--=20
2.21.0


