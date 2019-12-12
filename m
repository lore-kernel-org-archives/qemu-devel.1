Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1153DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10E821655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZFLQ7YJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10E821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSFq-0003Oy-IC
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWB-0006cL-Sx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWA-0003Bd-Qs
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWA-0003Ak-HM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vm85j66IltQCXExFgd1+RioUfVQTx62vadIJZy4Eo6I=;
 b=LZFLQ7YJN1nsnBL3fa6B0sHKMimj1NJ947BUhPAoz82LojQddk5RxQWBvZZdI0Wau462n5
 sNy8KZQhfFUPQmxqN3ganns9q33QRW2Pmifurx4NYepPPDy7egO678gXgOu7ooBKk5lkPB
 HAhoKvXRGKc5Lea2OdvA/BvfHdqDt10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-WNBeU_9aOea8ykyopDn8fg-1; Thu, 12 Dec 2019 11:40:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 478FE800D54
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EED660BE1;
 Thu, 12 Dec 2019 16:40:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 062/104] virtiofsd: Handle hard reboot
Date: Thu, 12 Dec 2019 16:38:22 +0000
Message-Id: <20191212163904.159893-63-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: WNBeU_9aOea8ykyopDn8fg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Handle a
  mount
  hard reboot (without unmount)
  mount

we get another 'init' which FUSE doesn't normally expect.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 2d1d1a2e59..45125ef66a 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2436,7 +2436,21 @@ void fuse_session_process_buf_int(struct fuse_sessio=
n *se,
             goto reply_err;
         }
     } else if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_INIT)=
 {
-        goto reply_err;
+        if (fuse_lowlevel_is_virtio(se)) {
+            /*
+             * TODO: This is after a hard reboot typically, we need to do
+             * a destroy, but we can't reply to this request yet so
+             * we can't use do_destroy
+             */
+            fuse_log(FUSE_LOG_DEBUG, "%s: reinit\n", __func__);
+            se->got_destroy =3D 1;
+            se->got_init =3D 0;
+            if (se->op.destroy) {
+                se->op.destroy(se->userdata);
+            }
+        } else {
+            goto reply_err;
+        }
     }
=20
     err =3D EACCES;
--=20
2.23.0


