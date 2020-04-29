Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD0DC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074D02087E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyNMlIc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074D02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTm8g-0002RR-7c
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTm7q-0001zE-1T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jTm7p-00060r-3P
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:47:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jTm7o-0005og-Kb
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588164458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2hyVXtBIZ5nsj6xHXRkKQNxCFdNeKoeT3XonE68maGE=;
 b=OyNMlIc9TyajdFGkLfWRNjhvCfVw9NJfJwoaNx3/uaT1sY8fUKjv5SR8bfaJEfJZXPfc6E
 Jka4+G5hsYsWVgkWshu8DTL8/WwyARas1CmTiTDhuE06ktgvPNggxZRNfTsNVktkdmIW9F
 7quesgv3evss1Za8OBhXdYYbgpVCXT0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-ue5Bss45NZCVNfWN1Qwg-w-1; Wed, 29 Apr 2020 08:47:37 -0400
X-MC-Unique: ue5Bss45NZCVNfWN1Qwg-w-1
Received: by mail-wr1-f69.google.com with SMTP id f4so1668838wrp.14
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 05:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ECN+P6CCFmZwUjw2WoWwRMDTufsKlIl5f+1ZGHAXC1c=;
 b=ryykIoeXkMxi4skW6M217FcS9YUqzzGkIPidUulYMimTrwXcrBVoHbvlZpprPg2oht
 kSFWnSU/kUgKLIBn2ebSIJUsnI3hgmcV/DF3h+vHKvfkNz3T2Mm8UpjgYMAEypIcwD4a
 RwuvK02RKJzUwyIYItE5U8llbm8vGtl57V00qBnSFB0YdNQpdHCd8pXbVDS1DcoiJo1Q
 lkhauPBM4Rp6TCWs8PabmGgXwkvyzFGVFqfmqAYRvO8o9MiiNohwN4zeyw21PJ92tMpx
 pa2IAAPK1eA75PYNVlydFb1na+JH3a2TnH9C8jxEYFDeyy1rKwrY/MrxRykSlomOgyTi
 drlA==
X-Gm-Message-State: AGi0PuYqfm6rZeQ88KW603nvvpa2Tvebv09OCddNPP7nj9oxxvpvQlKs
 tGGMq84dUCqT6X9rzj6csMec3dqmxv63aZWWeUKaztLXc8NAnG0G4y4p5z9XuzvvaggLZyVzzyT
 /OuyZM2fpolRDc74=
X-Received: by 2002:a05:600c:218e:: with SMTP id
 e14mr3299558wme.140.1588164455669; 
 Wed, 29 Apr 2020 05:47:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypI6Dn8fpfB5e+UgjD9jEZBgJA3iIrSB0pWcv/lF83HT1FBpL6q4FaOEcROAwE69rdxSE70fRw==
X-Received: by 2002:a05:600c:218e:: with SMTP id
 e14mr3299542wme.140.1588164455412; 
 Wed, 29 Apr 2020 05:47:35 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com
 (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
 by smtp.gmail.com with ESMTPSA id o6sm21813078wrw.63.2020.04.29.05.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 05:47:34 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtiofsd: jail lo->proc_self_fd
Date: Wed, 29 Apr 2020 14:47:33 +0200
Message-Id: <20200429124733.22488-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: virtio-fs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While it's not possible to escape the proc filesystem through
lo->proc_self_fd, it is possible to escape to the root of the proc
filesystem itself through "../..".

Use a temporary mount for opening lo->proc_self_fd, that has it's root at
/proc/self/fd/, preventing access to the ancestor directories.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 4c35c95b256c..bc9c44c760f4 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2536,6 +2536,8 @@ static void print_capabilities(void)
 static void setup_namespaces(struct lo_data *lo, struct fuse_session *se)
 {
     pid_t child;
+    char template[] =3D "virtiofsd-XXXXXX";
+    char *tmpdir;
=20
     /*
      * Create a new pid namespace for *child* processes.  We'll have to
@@ -2597,12 +2599,33 @@ static void setup_namespaces(struct lo_data *lo, st=
ruct fuse_session *se)
         exit(1);
     }
=20
+    tmpdir =3D mkdtemp(template);
+    if (!tmpdir) {
+        fuse_log(FUSE_LOG_ERR, "tmpdir(%s): %m\n", template);
+        exit(1);
+    }
+
+    if (mount("/proc/self/fd", tmpdir, NULL, MS_BIND, NULL) < 0) {
+        fuse_log(FUSE_LOG_ERR, "mount(/proc/self/fd, %s, MS_BIND): %m\n",
+                 tmpdir);
+        exit(1);
+    }
+
     /* Now we can get our /proc/self/fd directory file descriptor */
-    lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
+    lo->proc_self_fd =3D open(tmpdir, O_PATH);
     if (lo->proc_self_fd =3D=3D -1) {
-        fuse_log(FUSE_LOG_ERR, "open(/proc/self/fd, O_PATH): %m\n");
+        fuse_log(FUSE_LOG_ERR, "open(%s, O_PATH): %m\n", tmpdir);
         exit(1);
     }
+
+    if (umount2(tmpdir, MNT_DETACH) < 0) {
+        fuse_log(FUSE_LOG_ERR, "umount2(%s, MNT_DETACH): %m\n", tmpdir);
+        exit(1);
+    }
+
+    if (rmdir(tmpdir) < 0) {
+        fuse_log(FUSE_LOG_ERR, "rmdir(%s): %m\n", tmpdir);
+    }
 }
=20
 /*
--=20
2.21.1


