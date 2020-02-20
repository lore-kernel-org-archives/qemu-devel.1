Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40595C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A657207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeNFbwra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A657207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oZt-0007yx-7L
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oS9-0003yh-5i
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oS8-0007dN-3W
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42998
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oS7-0007c0-Up
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582215207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZxh2QIKv+rwCE1aHIlFEa2Fw2OaGQEvH1Pxdw3tUPM=;
 b=EeNFbwraEP4zTMRzMa3g6/0cfP29rSFNpcLcSj+aI8U7eLDPX3hAO7ZXlvCk7hrImsYVNp
 01yeGX0vrygVD/z3OUeVkCAe5oi1U+Q4H+ZJSKm46+eHaaq4YNYi3zPuOMmQmRuNouDGGR
 WnelVKot1wSSwMJTkRztT+gNxGvQ6PE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-4zZhL8nNNhm0a3zR39MXbg-1; Thu, 20 Feb 2020 11:13:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B7A4DB60;
 Thu, 20 Feb 2020 16:13:21 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B9C919756;
 Thu, 20 Feb 2020 16:13:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/18] qemu-img: Fix convert -n -B for backing-less targets
Date: Thu, 20 Feb 2020 17:07:07 +0100
Message-Id: <20200220160710.533297-16-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4zZhL8nNNhm0a3zR39MXbg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
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
Message-Id: <20200121155915.98232-2-mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 0faf2cd2f5..804630a368 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2523,7 +2523,7 @@ static int img_convert(int argc, char **argv)
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


