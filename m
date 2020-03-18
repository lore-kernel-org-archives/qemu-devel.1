Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B0C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D626208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJRCa2yI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D626208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfLD-0007wa-Va
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jEfFi-0007zh-Cs
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jEfFh-0004H8-4N
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jEfFh-0004GE-0V
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584563120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+RAYyaC3HNbqMXrtUZdk3F7z6WrSOvH7OzdrSALIcU=;
 b=UJRCa2yIqR6Tf4S9uLkdLyXkqDLDqJHirr92I7DwyQiAm9HoIXGW5Yuj7M+5JbmEZKDE5y
 n/Sl1zbTsJQT0IdbCJIjVX7a2ApYgEoAG1ghSqyEyW+hm4bZ2nwcfkNISO1Py7+eqkq6GS
 dZlROSx976B58SnSFzEhwyQ3idKeUA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-ZhMNYcrSP0WiioMP4an9AQ-1; Wed, 18 Mar 2020 16:25:17 -0400
X-MC-Unique: ZhMNYcrSP0WiioMP4an9AQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7143A899C2;
 Wed, 18 Mar 2020 20:24:52 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBE4760BF1;
 Wed, 18 Mar 2020 20:24:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, jsnow@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 04/11] hbitmap: unpublish hbitmap_iter_skip_words
Date: Wed, 18 Mar 2020 16:23:34 -0400
Message-Id: <20200318202341.6961-5-jsnow@redhat.com>
In-Reply-To: <20200318202341.6961-1-jsnow@redhat.com>
References: <20200318202341.6961-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Function is internal and even commented as internal. Drop its
definition from .h file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20200205112041.6003-4-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/hbitmap.h | 7 -------
 util/hbitmap.c         | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index ab227b117f..15837a0e2d 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -297,13 +297,6 @@ void hbitmap_free(HBitmap *hb);
  */
 void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t first=
);
=20
-/* hbitmap_iter_skip_words:
- * @hbi: HBitmapIter to operate on.
- *
- * Internal function used by hbitmap_iter_next and hbitmap_iter_next_word.
- */
-unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi);
-
 /* hbitmap_next_zero:
  *
  * Find next not dirty bit within selected range. If not found, return -1.
diff --git a/util/hbitmap.c b/util/hbitmap.c
index a368dc5ef7..26145d4b9e 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -104,7 +104,7 @@ struct HBitmap {
 /* Advance hbi to the next nonzero word and return it.  hbi->pos
  * is updated.  Returns zero if we reach the end of the bitmap.
  */
-unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi)
+static unsigned long hbitmap_iter_skip_words(HBitmapIter *hbi)
 {
     size_t pos =3D hbi->pos;
     const HBitmap *hb =3D hbi->hb;
--=20
2.21.1


