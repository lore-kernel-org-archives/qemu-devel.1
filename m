Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D6C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD4220656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqPsZOUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD4220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVmK-0004Ep-H0
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ipVi0-0005cJ-CJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ipVhy-0006hK-1h
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:10:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ipVhx-0006fG-PY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578568233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pP+UUPL3KtjmGguKCUXvjDL7hdspl0SO6dUXr7IRjH8=;
 b=IqPsZOUfTjj0+1yru9/hHu/zPTacTcBBBZFQbyH1Y+A3lprnQPnO4JupYFaFQajXvAlhjg
 9sptlIeXiCPUG553naYvGGZ4cNoxs5rabglNMntc+hQM2Cx96VWMWVP07QgvftcdV/jAlJ
 jE5ipAYaIMbqpGgIeQVSRkNcJ8f7aEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-MA3g_YOWN6qlgdMKvijqEA-1; Thu, 09 Jan 2020 06:10:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3FA8800C75;
 Thu,  9 Jan 2020 11:10:30 +0000 (UTC)
Received: from localhost (unknown [10.36.118.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A78FA19E9C;
 Thu,  9 Jan 2020 11:10:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] qemu-img: allow qemu-img measure --object without a
 filename
Date: Thu,  9 Jan 2020 11:10:11 +0000
Message-Id: <20200109111012.559052-4-stefanha@redhat.com>
In-Reply-To: <20200109111012.559052-1-stefanha@redhat.com>
References: <20200109111012.559052-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: MA3g_YOWN6qlgdMKvijqEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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


