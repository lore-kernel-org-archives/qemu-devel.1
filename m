Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42199C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D3D2253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZ5imw87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D3D2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvy6-0005s1-J7
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itvwB-0003uV-Pw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itvwA-0004bZ-KS
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:59:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itvwA-0004bC-HJ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579622370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ud3/EKB5xqJnB3xGy/CWxF9HBqZ8hmG/5T5OxShfKE0=;
 b=MZ5imw87PLKxLGaKEK9OU9MTueNsVYY4GDTj7IUBwxXpxcPaFZXilwJL6a6n1VJjMN+Lba
 DpuHP0IzFTvmkVsxy+Te+bVjebB6XjyHyuEaA7L99zi/g/US8xFegrs3e2qT9o7iFOKJWl
 +TgzlFi34ud/Ozoo/c+il7iNUYp/UgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-q_DzYjmpMBK8yMscOAZlLA-1; Tue, 21 Jan 2020 10:59:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69622107ACC4;
 Tue, 21 Jan 2020 15:59:22 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45E7C8BE19;
 Tue, 21 Jan 2020 15:59:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] qemu-img: Fix convert -n -B for backing-less targets
Date: Tue, 21 Jan 2020 16:59:14 +0100
Message-Id: <20200121155915.98232-2-mreitz@redhat.com>
In-Reply-To: <20200121155915.98232-1-mreitz@redhat.com>
References: <20200121155915.98232-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: q_DzYjmpMBK8yMscOAZlLA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

s.target_has_backing does not reflect whether the target BDS has a
backing file; it only tells whether we should use a backing file during
conversion (specified by -B).

As such, if you use convert -n, the target does not necessarily actually
have a backing file, and then dereferencing out_bs->backing fails here.

When converting to an existing file, we should set
target_backing_sectors to a negative value, because first, as the
comment explains, this value is only used for optimization, so it is
always fine to do that.

Second, we use this value to determine where the target must be
initialized to zeroes (overlays are initialized to zero after the end of
their backing file).  When converting to an existing file, we cannot
assume that to be true.

Cc: qemu-stable@nongnu.org
Fixes: 351c8efff9ad809c822d55620df54d575d536f68
       ("qemu-img: Special post-backing convert handling")
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6233b8ca56..89a1d11781 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2503,7 +2503,7 @@ static int img_convert(int argc, char **argv)
         }
     }
=20
-    if (s.target_has_backing) {
+    if (s.target_has_backing && s.target_is_new) {
         /* Errors are treated as "backing length unknown" (which means
          * s.target_backing_sectors has to be negative, which it will
          * be automatically).  The backing file length is used only
--=20
2.24.1


