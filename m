Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A10C47409
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3512E2166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRmdti9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3512E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyw1x-0006ku-DX
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iyw13-0005PM-Qn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iyw12-0008BY-CG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:05:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34427
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iyw12-00089S-7W
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580814311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08HbxoNLn5MgjJt19dlUG/9EkTSAsokA/fRn5dIge0Q=;
 b=DRmdti9sgeQuVlnjv0BbOxLmglYfKZxyXZ3E/78jjWrcYAd7dGJydxWEJ0tBrGCesildfP
 GmNOZN+NbdOmA7swG7s7vWXjGWm1GxXnR/GH6VLrgWDqU1NwEw7cGQmjhgo8hj3vE0iIKY
 owNX7o9A5I3xB4lv9WjqTEby1+n5ZD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-AxM_gjyaPWOifUXDALTRxg-1; Tue, 04 Feb 2020 06:05:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62E6A184AEAA
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:05:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA7EB196AE;
 Tue,  4 Feb 2020 11:05:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PATCH 2/4] virtiofsd: fv_create_listen_socket error path socket leak
Date: Tue,  4 Feb 2020 11:04:59 +0000
Message-Id: <20200204110501.10731-3-dgilbert@redhat.com>
In-Reply-To: <20200204110501.10731-1-dgilbert@redhat.com>
References: <20200204110501.10731-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: AxM_gjyaPWOifUXDALTRxg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

If we fail when bringing up the socket we can leak the listen_fd;
in practice the daemon will exit so it's not really a problem.

Fixes: Coverity CID 1413121
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 80a6e929df..dd1c605dbf 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -916,6 +916,7 @@ static int fv_create_listen_socket(struct fuse_session =
*se)
     old_umask =3D umask(0077);
     if (bind(listen_sock, (struct sockaddr *)&un, addr_len) =3D=3D -1) {
         fuse_log(FUSE_LOG_ERR, "vhost socket bind: %m\n");
+        close(listen_sock);
         umask(old_umask);
         return -1;
     }
@@ -923,6 +924,7 @@ static int fv_create_listen_socket(struct fuse_session =
*se)
=20
     if (listen(listen_sock, 1) =3D=3D -1) {
         fuse_log(FUSE_LOG_ERR, "vhost socket listen: %m\n");
+        close(listen_sock);
         return -1;
     }
=20
--=20
2.24.1


