Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD3C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F17214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F17214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxxXa-0002Jk-Dy
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 13:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hxxV1-0007uY-Dr
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hxxV0-0005Al-Es
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:55:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hxxV0-0005AS-AE
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:55:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A16DB11A0F;
 Wed, 14 Aug 2019 17:55:49 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B164909EE;
 Wed, 14 Aug 2019 17:55:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	mst@redhat.com
Date: Wed, 14 Aug 2019 18:55:33 +0100
Message-Id: <20190814175535.2023-2-dgilbert@redhat.com>
In-Reply-To: <20190814175535.2023-1-dgilbert@redhat.com>
References: <20190814175535.2023-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 14 Aug 2019 17:55:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/3] memory: Align MemoryRegionSections
 fields
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
Cc: peter.maydell@linaro.org, maxime.coquelin@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

MemoryRegionSection includes an Int128 'size' field;
on some platforms the compiler causes an alignment of this to
a 128bit boundary, leaving 8 bytes of dead space.
This deadspace can be filled with junk.

Move the size field to the top avoiding unnecessary alignment.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 606250172a..a74a58c289 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -487,10 +487,10 @@ static inline FlatView *address_space_to_flatview(A=
ddressSpace *as)
  * @nonvolatile: this section is non-volatile
  */
 struct MemoryRegionSection {
+    Int128 size;
     MemoryRegion *mr;
     FlatView *fv;
     hwaddr offset_within_region;
-    Int128 size;
     hwaddr offset_within_address_space;
     bool readonly;
     bool nonvolatile;
--=20
2.21.0


