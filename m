Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68064C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331B422522
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDZ+NGQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331B422522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiqx-0003TC-Aa
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufey-00069r-Qb
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufex-00009j-Na
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufex-00009K-Kb
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dp4GreLUjRX8OdN+BXxczHvI9YCaaBlKuOswvS9jdOo=;
 b=FDZ+NGQ7rxomYR8dCkmSypYiKeDO4cQW8EEzXT6d1pQcSOuD4l3eQ08RvV4qqrYXUSletL
 H4nqR2C9LRkDwpLvJ8h3w9/Lhm6j7E4rT7RybxXkd5XREiHezNELZWpe7fPx/yIZ1LCltP
 W6okuv30nshGChBSs1X3UyMGXPWgk5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-984KJabkO5SLQ7fZHU7X-A-1; Thu, 23 Jan 2020 11:48:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9C08190D37B
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31CBA19C69;
 Thu, 23 Jan 2020 16:48:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 098/108] virtiofsd: passthrough_ll: Use cache_readdir for
 directory open
Date: Thu, 23 Jan 2020 16:46:20 +0000
Message-Id: <20200123164630.91498-99-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 984KJabkO5SLQ7fZHU7X-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Since keep_cache(FOPEN_KEEP_CACHE) has no effect for directory as
described in fuse_common.h, use cache_readdir(FOPNE_CACHE_DIR) for
diretory open when cache=3Dalways mode.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 4c61ac5065..79b8b71a4f 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1523,7 +1523,7 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t ino=
,
=20
     fi->fh =3D fh;
     if (lo->cache =3D=3D CACHE_ALWAYS) {
-        fi->keep_cache =3D 1;
+        fi->cache_readdir =3D 1;
     }
     fuse_reply_open(req, fi);
     return;
--=20
2.24.1


