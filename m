Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B41C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42611206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2yVqiAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42611206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittaF-0006dR-Um
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsgL-0002WE-He
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsgH-0004KC-Jf
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsgH-0004Jt-F6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7I+V95tfiGdmTIs1NMqsbZqtH1qQn4wQdyfjZFiICug=;
 b=D2yVqiAcR6TTwdJI6oKuYuib1uU+Q88lxCttkNVwlwI4L3MPjBjPq+NlB2fg0E/FpLRh5h
 +rpdwFulS/iHb1M5v/xexWQg/Tt34ZYLUUikWU4OERRs/yjcUPzX6HPx66J/jE4giemUqZ
 ITDOCQDgiwhsi4Wqp5/zGA1LGE9yepQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-mXxodNsMO4KontWDWEjeIg-1; Tue, 21 Jan 2020 07:30:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F5D6801A04;
 Tue, 21 Jan 2020 12:30:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E764A60BE0;
 Tue, 21 Jan 2020 12:30:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 070/109] virtiofsd: passthrough_ll: control readdirplus
Date: Tue, 21 Jan 2020 12:23:54 +0000
Message-Id: <20200121122433.50803-71-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: mXxodNsMO4KontWDWEjeIg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Miklos Szeredi <mszeredi@redhat.com>

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 tools/virtiofsd/helper.c         | 3 +++
 tools/virtiofsd/passthrough_ll.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index c8cb88afdd..36eb273d8e 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -154,6 +154,9 @@ void fuse_cmdline_help(void)
            "                               allowed (default: 10)\n"
            "    -o norace                  disable racy fallback\n"
            "                               default: false\n"
+           "    -o readdirplus|no_readdirplus\n"
+           "                               enable/disable readirplus\n"
+           "                               default: readdirplus\n"
           );
 }
=20
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index ae364a4825..b15633a044 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -117,6 +117,8 @@ struct lo_data {
     double timeout;
     int cache;
     int timeout_set;
+    int readdirplus_set;
+    int readdirplus_clear;
     struct lo_inode root; /* protected by lo->mutex */
     struct lo_map ino_map; /* protected by lo->mutex */
     struct lo_map dirp_map; /* protected by lo->mutex */
@@ -140,6 +142,8 @@ static const struct fuse_opt lo_opts[] =3D {
     { "cache=3Dauto", offsetof(struct lo_data, cache), CACHE_NORMAL },
     { "cache=3Dalways", offsetof(struct lo_data, cache), CACHE_ALWAYS },
     { "norace", offsetof(struct lo_data, norace), 1 },
+    { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
+    { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
     FUSE_OPT_END
 };
 static bool use_syslog =3D false;
@@ -478,7 +482,8 @@ static void lo_init(void *userdata, struct fuse_conn_in=
fo *conn)
         fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
         conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
     }
-    if (lo->cache =3D=3D CACHE_NEVER) {
+    if ((lo->cache =3D=3D CACHE_NEVER && !lo->readdirplus_set) ||
+        lo->readdirplus_clear) {
         fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
         conn->want &=3D ~FUSE_CAP_READDIRPLUS;
     }
--=20
2.24.1


