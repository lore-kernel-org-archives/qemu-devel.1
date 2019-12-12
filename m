Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A137BC00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7603B214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HC5dDoIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7603B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34827 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSRP-0001RN-7b
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX5-0007rX-00
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX3-0004vV-SC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRX3-0004ul-NY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5OzLXiuaEm9rsBZclFzC9sSXge9QS5piPP1Nh1UzqHM=;
 b=HC5dDoIgcCnK7uh3H7S44uvOu0LmPl8eALryOnbLtbjeHQB6Tk0UDmzvzjukOYuBnOqNPE
 XuBTo7YB/MYVH0G0wXRzLiuNwN4dUko5YggWTSU2c5od8sWt/AI5zk2rrHP2ggJcm13blU
 hBlroFXICEYsvbXqUNrEaQAUIN2a9T8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-V48IxQcPMaKVsvTKlWEoBA-1; Thu, 12 Dec 2019 11:41:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4397D800D5A
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:39 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB9560BE1;
 Thu, 12 Dec 2019 16:41:35 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 096/104] virtiofsd: Reset O_DIRECT flag during file open
Date: Thu, 12 Dec 2019 16:38:56 +0000
Message-Id: <20191212163904.159893-97-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: V48IxQcPMaKVsvTKlWEoBA-1
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

From: Vivek Goyal <vgoyal@redhat.com>

If an application wants to do direct IO and opens a file with O_DIRECT
in guest, that does not necessarily mean that we need to bypass page
cache on host as well. So reset this flag on host.

If somebody needs to bypass page cache on host as well (and it is safe to
do so), we can add a knob in daemon later to control this behavior.

I check virtio-9p and they do reset O_DIRECT flag.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index cf6b548eee..6b3d396b6f 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1705,6 +1705,13 @@ static void lo_create(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
         goto out;
     }
=20
+    /*
+     * O_DIRECT in guest should not necessarily mean bypassing page
+     * cache on host as well. If somebody needs that behavior, it
+     * probably should be a configuration knob in daemon.
+     */
+    fi->flags &=3D ~O_DIRECT;
+
     fd =3D openat(parent_inode->fd, name, (fi->flags | O_CREAT) & ~O_NOFOL=
LOW,
                 mode);
     err =3D fd =3D=3D -1 ? errno : 0;
@@ -1934,6 +1941,13 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
         fi->flags &=3D ~O_APPEND;
     }
=20
+    /*
+     * O_DIRECT in guest should not necessarily mean bypassing page
+     * cache on host as well. If somebody needs that behavior, it
+     * probably should be a configuration knob in daemon.
+     */
+    fi->flags &=3D ~O_DIRECT;
+
     sprintf(buf, "%i", lo_fd(req, ino));
     fd =3D openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
     if (fd =3D=3D -1) {
--=20
2.23.0


