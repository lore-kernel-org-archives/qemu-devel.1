Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D15C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA377214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1LKs6RX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA377214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSTV-0004Hv-GD
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWG-0006ji-LF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWF-0003Kx-Iv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52710
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWF-0003KK-F4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/hWGAU/5Vx3DA/N5Me7w+WyPvIOWW5nS/z7ZikQLvE=;
 b=S1LKs6RXfYf8g8FX8yIN5XhO9TaQaCclEJlUk2I0FMh21PdyflvBdddGb1W7ZuKW1F4+8I
 Homk7ahupErLEU2i1/L280LTioEBQS0f2k/qMTKc5EEX0I42bqb4Z367uRa9kA1kstLAn5
 2v+6nlF4XLCRHYr3iz/I0HmaSMwgXTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-0QC7nvyMNbav8ubtWTFo5Q-1; Thu, 12 Dec 2019 11:40:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2B111800D45
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0496D60BE1;
 Thu, 12 Dec 2019 16:40:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 066/104] virtiofsd: passthrough_ll: add renameat2 support
Date: Thu, 12 Dec 2019 16:38:26 +0000
Message-Id: <20191212163904.159893-67-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0QC7nvyMNbav8ubtWTFo5Q-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Miklos Szeredi <mszeredi@redhat.com>

No glibc support yet, so use syscall().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 91d3120033..bed2270141 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1083,7 +1083,17 @@ static void lo_rename(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
     }
=20
     if (flags) {
+#ifndef SYS_renameat2
         fuse_reply_err(req, EINVAL);
+#else
+        res =3D syscall(SYS_renameat2, lo_fd(req, parent), name,
+                      lo_fd(req, newparent), newname, flags);
+        if (res =3D=3D -1 && errno =3D=3D ENOSYS) {
+            fuse_reply_err(req, EINVAL);
+        } else {
+            fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+        }
+#endif
         return;
     }
=20
--=20
2.23.0


