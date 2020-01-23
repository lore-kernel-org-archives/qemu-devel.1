Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9885AC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B7D20661
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqg8dhEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B7D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucqC-0003Ct-3u
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub8o-00021N-2L
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub8m-0004ym-39
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32555
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub8l-0004xj-93
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcJ+qIvPBd+NE8+Obl+5mSiGYqc48+K+DQe87dF439I=;
 b=cqg8dhEYFp60W5/twaJczu9GGzGmpUnkMhWSxOG2zWSIFSWCfl4e+ZpCCTtfRFjAfU6iyP
 SBTpGtdoNoBswGPUhPe4JoUuJ8eT06nLQMtVwOfTyrxHBWL6DT6RkqOEOvf7GWJGdcDeTS
 pNI19KGTCtOH2HhcyPjsTqSKlZI8hUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-IVPCZl_ZP7OECa6mcKVqGA-1; Thu, 23 Jan 2020 06:59:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80947800D5E
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:07 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB4281CB;
 Thu, 23 Jan 2020 11:59:06 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 016/111] virtiofsd: Add options for virtio
Date: Thu, 23 Jan 2020 11:57:06 +0000
Message-Id: <20200123115841.138849-17-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: IVPCZl_ZP7OECa6mcKVqGA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Add options to specify parameters for virtio-fs paths, i.e.

   ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_i.h        |  1 +
 tools/virtiofsd/fuse_lowlevel.c | 11 ++++++++---
 tools/virtiofsd/helper.c        | 14 +++++++-------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index bae06992e0..26b1a7da88 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -63,6 +63,7 @@ struct fuse_session {
     struct fuse_notify_req notify_list;
     size_t bufsize;
     int error;
+    char *vu_socket_path;
 };
=20
 struct fuse_chan {
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 8552cfb8af..17e8718283 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2115,8 +2115,11 @@ reply_err:
     }
=20
 static const struct fuse_opt fuse_ll_opts[] =3D {
-    LL_OPTION("debug", debug, 1), LL_OPTION("-d", debug, 1),
-    LL_OPTION("--debug", debug, 1), LL_OPTION("allow_root", deny_others, 1=
),
+    LL_OPTION("debug", debug, 1),
+    LL_OPTION("-d", debug, 1),
+    LL_OPTION("--debug", debug, 1),
+    LL_OPTION("allow_root", deny_others, 1),
+    LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
     FUSE_OPT_END
 };
=20
@@ -2132,7 +2135,9 @@ void fuse_lowlevel_help(void)
      * These are not all options, but the ones that are
      * potentially of interest to an end-user
      */
-    printf("    -o allow_root          allow access by root\n");
+    printf(
+        "    -o allow_root              allow access by root\n"
+        "    --socket-path=3DPATH         path for the vhost-user socket\n=
");
 }
=20
 void fuse_session_destroy(struct fuse_session *se)
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 9333691525..676032e71f 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -127,13 +127,13 @@ static const struct fuse_opt conn_info_opt_spec[] =3D=
 {
=20
 void fuse_cmdline_help(void)
 {
-    printf(
-        "    -h   --help            print help\n"
-        "    -V   --version         print version\n"
-        "    -d   -o debug          enable debug output (implies -f)\n"
-        "    -f                     foreground operation\n"
-        "    -o max_idle_threads    the maximum number of idle worker thre=
ads\n"
-        "                           allowed (default: 10)\n");
+    printf("    -h   --help                print help\n"
+           "    -V   --version             print version\n"
+           "    -d   -o debug              enable debug output (implies -f=
)\n"
+           "    -f                         foreground operation\n"
+           "    -o max_idle_threads        the maximum number of idle work=
er "
+           "threads\n"
+           "                               allowed (default: 10)\n");
 }
=20
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
--=20
2.24.1


