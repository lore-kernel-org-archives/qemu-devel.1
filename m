Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BFFC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7258206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgiayaqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7258206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9TL-0007y0-Lh
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ip9QA-00043w-L4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ip9Q9-0004bv-IZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ip9Q9-0004bc-ER
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578482561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pP+UUPL3KtjmGguKCUXvjDL7hdspl0SO6dUXr7IRjH8=;
 b=WgiayaqOlR2/mUHao/JKs6OULuXl7Me3VKJfHkqoxyxxrJ5w1aUfu98fy6btOn+e72xMW3
 iRCTstZIXqbomiO1SJZNgNNEHk+Y7cCvO+XDPAO0EWSKKUhwT7RxG/LCnA/lSCXxmbjvtl
 J6caOOesR1zpNbpncTC0BSITR94fzrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-ON9N0zpAORGcXPepnQtHKg-1; Wed, 08 Jan 2020 06:22:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5214184B1E1;
 Wed,  8 Jan 2020 11:22:38 +0000 (UTC)
Received: from localhost (ovpn-116-249.ams2.redhat.com [10.36.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09E297BA22;
 Wed,  8 Jan 2020 11:22:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] qemu-img: allow qemu-img measure --object without a
 filename
Date: Wed,  8 Jan 2020 11:22:19 +0000
Message-Id: <20200108112220.499180-4-stefanha@redhat.com>
In-Reply-To: <20200108112220.499180-1-stefanha@redhat.com>
References: <20200108112220.499180-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ON9N0zpAORGcXPepnQtHKg-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In most qemu-img sub-commands the --object option only makes sense when
there is a filename.  qemu-img measure is an exception because objects
may be referenced from the image creation options instead of an existing
image file.  Allow --object without a filename.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-img.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6233b8ca56..4f3e58f13b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4903,10 +4903,8 @@ static int img_measure(int argc, char **argv)
         filename =3D argv[optind];
     }
=20
-    if (!filename &&
-        (object_opts || image_opts || fmt || snapshot_name || sn_opts)) {
-        error_report("--object, --image-opts, -f, and -l "
-                     "require a filename argument.");
+    if (!filename && (image_opts || fmt || snapshot_name || sn_opts)) {
+        error_report("--image-opts, -f, and -l require a filename argument=
.");
         goto out;
     }
     if (filename && img_size !=3D UINT64_MAX) {
--=20
2.24.1


