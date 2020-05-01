Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F8C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8072166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXMrURoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8072166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUbBS-0002yB-Hs
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUb87-0006eZ-T5
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUb86-00007s-3T
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUb85-00005h-LZ
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588360520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7tlgW/RV4oirjcdS6rirP8fOn1hpnptskhP1fFJ9kE=;
 b=XXMrURoRGSKNJwXcx+zg1qEPQVwsXD2lDMC/8NMuwHp2f42eai3EiHpfRCVhFk4t58Trdd
 Bz33EirmjXXivNaNq+5mFH/Uhn/Lfb0sHBO67x+DNW9PnJy9ZsqUW+KXqFloIOQjGSugVT
 h7rdegeUYiAfKMA1SCLNNCoQCkSbSgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-7GzpNJYTNVys9wAnzSwwLA-1; Fri, 01 May 2020 15:15:15 -0400
X-MC-Unique: 7GzpNJYTNVys9wAnzSwwLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3BBBA0C06;
 Fri,  1 May 2020 19:15:14 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-191.ams2.redhat.com
 [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE2641002382;
 Fri,  1 May 2020 19:15:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, yavrahami@paloaltonetworks.com,
 mszeredi@redhat.com, mreitz@redhat.com
Subject: [PULL 2/6] virtiofsd: stay below fs.file-max sysctl value
 (CVE-2020-10717)
Date: Fri,  1 May 2020 20:14:56 +0100
Message-Id: <20200501191500.126432-3-dgilbert@redhat.com>
In-Reply-To: <20200501191500.126432-1-dgilbert@redhat.com>
References: <20200501191500.126432-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:22:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The system-wide fs.file-max sysctl value determines how many files can
be open.  It defaults to a value calculated based on the machine's RAM
size.  Previously virtiofsd would try to set RLIMIT_NOFILE to 1,000,000
and this allowed the FUSE client to exhaust the number of open files
system-wide on Linux hosts with less than 10 GB of RAM!

Take fs.file-max into account when choosing the default RLIMIT_NOFILE
value.

Fixes: CVE-2020-10717
Reported-by: Yuval Avrahami <yavrahami@paloaltonetworks.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200501140644.220940-3-stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/helper.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index dc59f38af0..00a1ef666a 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -176,7 +176,8 @@ void fuse_cmdline_help(void)
            "                               default: no_xattr\n"
            "    --rlimit-nofile=3D<num>      set maximum number of file de=
scriptors\n"
            "                               (0 leaves rlimit unchanged)\n"
-           "                               default: 1,000,000 if the curre=
nt rlimit is lower\n"
+           "                               default: min(1000000, fs.file-m=
ax - 16384)\n"
+           "                                        if the current rlimit =
is lower\n"
            );
 }
=20
@@ -199,9 +200,32 @@ static int fuse_helper_opt_proc(void *data, const char=
 *arg, int key,
=20
 static unsigned long get_default_rlimit_nofile(void)
 {
+    g_autofree gchar *file_max_str =3D NULL;
+    const rlim_t reserved_fds =3D 16384; /* leave at least this many fds f=
ree */
     rlim_t max_fds =3D 1000000; /* our default RLIMIT_NOFILE target */
+    rlim_t file_max;
     struct rlimit rlim;
=20
+    /*
+     * Reduce max_fds below the system-wide maximum, if necessary.  This
+     * ensures there are fds available for other processes so we don't
+     * cause resource exhaustion.
+     */
+    if (!g_file_get_contents("/proc/sys/fs/file-max", &file_max_str,
+                             NULL, NULL)) {
+        fuse_log(FUSE_LOG_ERR, "can't read /proc/sys/fs/file-max\n");
+        exit(1);
+    }
+    file_max =3D g_ascii_strtoull(file_max_str, NULL, 10);
+    if (file_max < 2 * reserved_fds) {
+        fuse_log(FUSE_LOG_ERR,
+                 "The fs.file-max sysctl is too low (%lu) to allow a "
+                 "reasonable number of open files.\n",
+                 (unsigned long)file_max);
+        exit(1);
+    }
+    max_fds =3D MIN(file_max - reserved_fds, max_fds);
+
     if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
         fuse_log(FUSE_LOG_ERR, "getrlimit(RLIMIT_NOFILE): %m\n");
         exit(1);
--=20
2.26.2


