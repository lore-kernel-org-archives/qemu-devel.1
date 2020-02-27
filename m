Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5A1C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1271A2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hi/HyCiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1271A2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MaY-0004UH-4q
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j7MYw-0001m0-KW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j7MYv-0000T7-9x
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:03:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j7MYv-0000Sj-5L
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582822980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB42dRl0LlscnacMEzUBk9LawgSO8o4BEQBgFsoNVOo=;
 b=hi/HyCiT9eU0RNJCyKrr4aysCXeQdioRVSfNqrH+7+MHh11gbNTnB0UTqvhi4RDj19rXmT
 6Ju3Ximo/P+VA6x9qJXheaexN/3/4XF04Pe0wBZgvlgvJAE5ZhA6iwaLyDTAmPMy1EFSnN
 185yTE8F/Z2ZNIokavonIE2zZTBqJK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-YR-PcMy0NOK6H-QRPp5-NQ-1; Thu, 27 Feb 2020 12:02:56 -0500
X-MC-Unique: YR-PcMy0NOK6H-QRPp5-NQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7E7E190D358;
 Thu, 27 Feb 2020 17:02:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 450E95DA75;
 Thu, 27 Feb 2020 17:02:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] qemu-img: Fix check's leak/corruption fix report
Date: Thu, 27 Feb 2020 18:02:49 +0100
Message-Id: <20200227170251.86113-2-mreitz@redhat.com>
In-Reply-To: <20200227170251.86113-1-mreitz@redhat.com>
References: <20200227170251.86113-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are two problems with qemu-img check's report on how many leaks
and/or corruptions have been fixed:

(1) ImageCheck.has_leaks_fixed and ImageCheck.has_corruptions_fixed are
only true when ImageCheck.leaks or ImageCheck.corruptions (respectively)
are non-zero.  qcow2's check implementation will set the latter to zero
after it has fixed leaks and corruptions, though, so leaks-fixed and
corruptions-fixed are actually never reported after successful repairs.
We should always report them when they are non-zero, just like all the
other fields of ImageCheck.

(2) After something has been fixed and we run the check a second time,
leaks_fixed and corruptions_fixed are taken from the first run; but
has_leaks_fixed and has_corruptions_fixed are not.  The second run
actually cannot fix anything, so with (1) fixed, has_leaks_fixed and
has_corruptions_fixed will always be false here.  (With (1) unfixed,
they will at least be false on successful runs, because then the number
of leaks and corruptions found in the second run should be 0.)
We should save has_leaks_fixed and has_corruptions_fixed just like we
save leaks_fixed and corruptions_fixed.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7b7087dd60..c7567e1979 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -647,9 +647,9 @@ static int collect_image_check(BlockDriverState *bs,
     check->leaks                    =3D result.leaks;
     check->has_leaks                =3D result.leaks !=3D 0;
     check->corruptions_fixed        =3D result.corruptions_fixed;
-    check->has_corruptions_fixed    =3D result.corruptions !=3D 0;
+    check->has_corruptions_fixed    =3D result.corruptions_fixed !=3D 0;
     check->leaks_fixed              =3D result.leaks_fixed;
-    check->has_leaks_fixed          =3D result.leaks !=3D 0;
+    check->has_leaks_fixed          =3D result.leaks_fixed !=3D 0;
     check->image_end_offset         =3D result.image_end_offset;
     check->has_image_end_offset     =3D result.image_end_offset !=3D 0;
     check->total_clusters           =3D result.bfi.total_clusters;
@@ -803,9 +803,12 @@ static int img_check(int argc, char **argv)
=20
     if (check->corruptions_fixed || check->leaks_fixed) {
         int corruptions_fixed, leaks_fixed;
+        bool has_leaks_fixed, has_corruptions_fixed;
=20
         leaks_fixed         =3D check->leaks_fixed;
+        has_leaks_fixed     =3D check->has_leaks_fixed;
         corruptions_fixed   =3D check->corruptions_fixed;
+        has_corruptions_fixed =3D check->has_corruptions_fixed;
=20
         if (output_format =3D=3D OFORMAT_HUMAN) {
             qprintf(quiet,
@@ -822,7 +825,9 @@ static int img_check(int argc, char **argv)
         ret =3D collect_image_check(bs, check, filename, fmt, 0);
=20
         check->leaks_fixed          =3D leaks_fixed;
+        check->has_leaks_fixed      =3D has_leaks_fixed;
         check->corruptions_fixed    =3D corruptions_fixed;
+        check->has_corruptions_fixed =3D has_corruptions_fixed;
     }
=20
     if (!ret) {
--=20
2.24.1


