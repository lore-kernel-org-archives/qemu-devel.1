Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6666AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDEA208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiYrxtPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDEA208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKiw-0001Ck-AR
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmKel-00011e-1I
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:18:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmKej-0006H7-0o
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592587100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=39LY6zwHpBop9k1GBKeTNcptDY6I2N59MV1dShpsMwA=;
 b=eiYrxtPX51b3SWVWdFjIuecYKSxsFqvKM8GTJkZFxpRzTh4W1bRpvPTtgNOGHA4F4HOJ5N
 BcUWcLgYUnLBmtMhpqxlF9zNIDIzPLSdf5GhCGiDjIM5QgxgwYCBfSCydOYdG9XwTrlZ/3
 KLiF6/YBOM8ioG2KzU+AeLeny5ZcsYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-izLRoqZ9NcSO5RlkEZwoww-1; Fri, 19 Jun 2020 13:18:18 -0400
X-MC-Unique: izLRoqZ9NcSO5RlkEZwoww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72C0D107ACCA
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 17:18:17 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-215.ams2.redhat.com
 [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB91119D7B;
 Fri, 19 Jun 2020 17:18:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, virtio-fs@redhat.com, stefanha@redhat.com,
 vgoyal@redhat.com
Subject: [PATCH] virtiofsd: Allow capability restriction to be turned off
Date: Fri, 19 Jun 2020 18:18:09 +0100
Message-Id: <20200619171809.30984-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Commit a59feb483b8fae24d043 dropped most capabilities at startup,
since in most cases virtiofsd doesn't need them.  Unfortunately we found
a case that needs CAP_SYS_ADMIN - setting trusted extended attributes.
It's rare to need it, and the clean fix for it is going to be more
complicated, but as a way for existing users to continue, allow the
capability restriction to be turned off by adding

  -o no_restrictcaps

We still drop the capabilities by default since this seems much safer;
even if we don't have an explicit problem to fix.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/virtiofsd.rst         | 3 +++
 tools/virtiofsd/helper.c         | 3 +++
 tools/virtiofsd/passthrough_ll.c | 8 +++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 378594c422..8819d7d19e 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -81,6 +81,9 @@ Options
     Enable/disable extended attributes (xattr) on files and directories.  The
     default is ``no_xattr``.
 
+  * restrictcaps|no_restrictcaps\n"
+    Restrict capabilities at startup.  The default is ``restrictcaps``.
+
 .. option:: --socket-path=PATH
 
   Listen on vhost-user UNIX domain socket at PATH.
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 00a1ef666a..51ed9fbed0 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -174,6 +174,9 @@ void fuse_cmdline_help(void)
            "                               default: no_writeback\n"
            "    -o xattr|no_xattr          enable/disable xattr\n"
            "                               default: no_xattr\n"
+           "    -o restrictcaps|no_restrictcaps\n"
+           "                               restrict capabilities at startup\n"
+           "                               default: restrictcaps\n"
            "    --rlimit-nofile=<num>      set maximum number of file descriptors\n"
            "                               (0 leaves rlimit unchanged)\n"
            "                               default: min(1000000, fs.file-max - 16384)\n"
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 2ce7c96085..8dee657b19 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -144,6 +144,7 @@ struct lo_data {
     int flock;
     int posix_lock;
     int xattr;
+    int restrictcaps;
     char *source;
     double timeout;
     int cache;
@@ -170,6 +171,8 @@ static const struct fuse_opt lo_opts[] = {
     { "no_posix_lock", offsetof(struct lo_data, posix_lock), 0 },
     { "xattr", offsetof(struct lo_data, xattr), 1 },
     { "no_xattr", offsetof(struct lo_data, xattr), 0 },
+    { "restrictcaps", offsetof(struct lo_data, restrictcaps), 1 },
+    { "no_restrictcaps", offsetof(struct lo_data, restrictcaps), 0 },
     { "timeout=%lf", offsetof(struct lo_data, timeout), 0 },
     { "timeout=", offsetof(struct lo_data, timeout_set), 1 },
     { "cache=none", offsetof(struct lo_data, cache), CACHE_NONE },
@@ -2615,7 +2618,9 @@ static void setup_sandbox(struct lo_data *lo, struct fuse_session *se,
     setup_namespaces(lo, se);
     setup_mounts(lo->source);
     setup_seccomp(enable_syslog);
-    setup_capabilities();
+    if (lo->restrictcaps) {
+        setup_capabilities();
+    }
 }
 
 /* Set the maximum number of open file descriptors */
@@ -2764,6 +2769,7 @@ int main(int argc, char *argv[])
         .writeback = 0,
         .posix_lock = 1,
         .proc_self_fd = -1,
+        .restrictcaps = 1,
     };
     struct lo_map_elem *root_elem;
     int ret = -1;
-- 
2.26.2


