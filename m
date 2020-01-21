Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A13E206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hlp/sz0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A13E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittXX-000364-Va
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsgC-0002KT-Nc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsg9-0004H6-L6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsg9-0004Gr-HH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XG59HiCsPYMxCTvZuMiKrb5fJDd+xBXQwTIWqB+SWFE=;
 b=Hlp/sz0LjQPLgWSfCrMyamgJ58QyaeP2s+YBOvbTggiEaPpgdCeneElafaC+rqWI9s8WTd
 M6FTUXdAzhvK+mE3W/OLSEgjNhalz01cU6yG2QXd8zpVwtLfm6BoTPagXr/zpjcMtdxgz7
 DtiooIaghZkEksP34jzFpWsJ+tFtRdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Zv9AfLTjM4qa3arCsNsv_g-1; Tue, 21 Jan 2020 07:30:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98296DB8F;
 Tue, 21 Jan 2020 12:30:40 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5548E60BE0;
 Tue, 21 Jan 2020 12:30:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 069/109] virtiofsd: passthrough_ll: disable readdirplus on
 cache=never
Date: Tue, 21 Jan 2020 12:23:53 +0000
Message-Id: <20200121122433.50803-70-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Zv9AfLTjM4qa3arCsNsv_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Miklos Szeredi <mszeredi@redhat.com>

...because the attributes sent in the READDIRPLUS reply would be discarded
anyway.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 6f3ad14141..ae364a4825 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -478,6 +478,10 @@ static void lo_init(void *userdata, struct fuse_conn_i=
nfo *conn)
         fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
         conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
     }
+    if (lo->cache =3D=3D CACHE_NEVER) {
+        fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
+        conn->want &=3D ~FUSE_CAP_READDIRPLUS;
+    }
 }
=20
 static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
--=20
2.24.1


