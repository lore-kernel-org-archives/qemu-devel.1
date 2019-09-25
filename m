Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC88C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3517521D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3517521D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8qf-0003CP-1R
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iD8nc-0000c0-2O
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iD8na-0004ZK-TY
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iD8na-0004Yo-O4
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 008F0306731D;
 Wed, 25 Sep 2019 15:01:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-251.ams2.redhat.com
 [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3DD15C21F;
 Wed, 25 Sep 2019 15:01:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, richardw.yang@linux.intel.com,
 alex.benee@linaro.org
Subject: [PULL 2/9] migration/postcopy: not necessary to do discard when
 canonicalizing bitmap
Date: Wed, 25 Sep 2019 16:01:23 +0100
Message-Id: <20190925150130.12303-3-dgilbert@redhat.com>
In-Reply-To: <20190925150130.12303-1-dgilbert@redhat.com>
References: <20190925150130.12303-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 25 Sep 2019 15:01:46 +0000 (UTC)
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

From: Wei Yang <richardw.yang@linux.intel.com>

All pages, either partially sent or partially dirty, will be discarded in
postcopy_send_discard_bm_ram(), since we update the unsentmap to be
unsentmap =3D unsentmap | dirty in ram_postcopy_send_discard_bitmap().

This is not necessary to do discard when canonicalizing bitmap. And by
doing so, we separate the page discard into two individual steps:

  * canonicalize bitmap
  * discard page

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190819061843.28642-2-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 01df326767..57d1a4627e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2928,7 +2928,7 @@ static int postcopy_each_ram_send_discard(Migration=
State *ms)
 }
=20
 /**
- * postcopy_chunk_hostpages_pass: canocalize bitmap in hostpages
+ * postcopy_chunk_hostpages_pass: canonicalize bitmap in hostpages
  *
  * Helper for postcopy_chunk_hostpages; it's called twice to
  * canonicalize the two bitmaps, that are similar, but one is
@@ -2991,18 +2991,6 @@ static void postcopy_chunk_hostpages_pass(Migratio=
nState *ms, bool unsent_pass,
                                                              host_ratio)=
;
             run_start =3D QEMU_ALIGN_UP(run_start, host_ratio);
=20
-            /* Tell the destination to discard this page */
-            if (unsent_pass || !test_bit(fixup_start_addr, unsentmap)) {
-                /* For the unsent_pass we:
-                 *     discard partially sent pages
-                 * For the !unsent_pass (dirty) we:
-                 *     discard partially dirty pages that were sent
-                 *     (any partially sent pages were already discarded
-                 *     by the previous unsent_pass)
-                 */
-                postcopy_discard_send_range(ms, fixup_start_addr, host_r=
atio);
-            }
-
             /* Clean up the bitmap */
             for (page =3D fixup_start_addr;
                  page < fixup_start_addr + host_ratio; page++) {
--=20
2.21.0


