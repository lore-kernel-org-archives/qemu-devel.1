Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE08C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314F321655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPD4posC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314F321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSDH-0007So-LE
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW7-0006Vu-HX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW4-0002zV-Tm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRW4-0002yV-NK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Zqi5/jFqIDm3GPFykFghobJzPtUPuCNYfqNSDyhswc=;
 b=LPD4posCCqnv4eMuX6ICezyQJyu0vuHtxJS1c8cqrjQ21SqyyLcoUCqd30Ow3feVuNTDG5
 iyMytjGRXpBQrmMHFNrgffUUt0P5QQNYITO2rnzh1TLOBAx5PSpijsH/P9J/JVnbnt/+N7
 u/EdPAmBlst8VZbHKijW+bIvsHesQtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-kt1hg9eRMnG8YnqQ-zuc8A-1; Thu, 12 Dec 2019 11:40:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47937107ACE4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:37 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BC3360BE1;
 Thu, 12 Dec 2019 16:40:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 058/104] virtiofsd: print log only when priority is high enough
Date: Thu, 12 Dec 2019 16:38:18 +0000
Message-Id: <20191212163904.159893-59-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kt1hg9eRMnG8YnqQ-zuc8A-1
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

From: Eryu Guan <eguan@linux.alibaba.com>

Introduce "-o log_level=3D" command line option to specify current log
level (priority), valid values are "debug info warn err", e.g.

    ./virtiofsd -o log_level=3Ddebug ...

So only log priority higher than "debug" will be printed to
stderr/syslog. And the default level is info.

The "-o debug"/"-d" options are kept, and imply debug log level.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
dgilbert: Reworked for libfuse's log_func
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_log.c       |   4 ++
 tools/virtiofsd/fuse_lowlevel.c  |  75 ++++++++------------
 tools/virtiofsd/fuse_lowlevel.h  |   1 +
 tools/virtiofsd/helper.c         |  10 ++-
 tools/virtiofsd/passthrough_ll.c | 118 +++++++++++++------------------
 5 files changed, 92 insertions(+), 116 deletions(-)

diff --git a/tools/virtiofsd/fuse_log.c b/tools/virtiofsd/fuse_log.c
index 11345f9ec8..79a18a7aaa 100644
--- a/tools/virtiofsd/fuse_log.c
+++ b/tools/virtiofsd/fuse_log.c
@@ -8,6 +8,10 @@
  * See the file COPYING.LIB
  */
=20
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <syslog.h>
 #include "fuse_log.h"
=20
 #include <stdarg.h>
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index f3c8bdf7cb..0abb369b3d 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -158,19 +158,17 @@ static int fuse_send_msg(struct fuse_session *se, str=
uct fuse_chan *ch,
     struct fuse_out_header *out =3D iov[0].iov_base;
=20
     out->len =3D iov_length(iov, count);
-    if (se->debug) {
-        if (out->unique =3D=3D 0) {
-            fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n", ou=
t->error,
-                     out->len);
-        } else if (out->error) {
-            fuse_log(FUSE_LOG_DEBUG,
-                     "   unique: %llu, error: %i (%s), outsize: %i\n",
-                     (unsigned long long)out->unique, out->error,
-                     strerror(-out->error), out->len);
-        } else {
-            fuse_log(FUSE_LOG_DEBUG, "   unique: %llu, success, outsize: %=
i\n",
-                     (unsigned long long)out->unique, out->len);
-        }
+    if (out->unique =3D=3D 0) {
+        fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n", out->e=
rror,
+                 out->len);
+    } else if (out->error) {
+        fuse_log(FUSE_LOG_DEBUG,
+                 "   unique: %llu, error: %i (%s), outsize: %i\n",
+                 (unsigned long long)out->unique, out->error,
+                 strerror(-out->error), out->len);
+    } else {
+        fuse_log(FUSE_LOG_DEBUG, "   unique: %llu, success, outsize: %i\n"=
,
+                 (unsigned long long)out->unique, out->len);
     }
=20
     if (fuse_lowlevel_is_virtio(se)) {
@@ -1664,10 +1662,8 @@ static void do_interrupt(fuse_req_t req, fuse_ino_t =
nodeid,
         return;
     }
=20
-    if (se->debug) {
-        fuse_log(FUSE_LOG_DEBUG, "INTERRUPT: %llu\n",
-                 (unsigned long long)arg->unique);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "INTERRUPT: %llu\n",
+             (unsigned long long)arg->unique);
=20
     req->u.i.unique =3D arg->unique;
=20
@@ -1903,13 +1899,10 @@ static void do_init(fuse_req_t req, fuse_ino_t node=
id,
         }
     }
=20
-    if (se->debug) {
-        fuse_log(FUSE_LOG_DEBUG, "INIT: %u.%u\n", arg->major, arg->minor);
-        if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
-            fuse_log(FUSE_LOG_DEBUG, "flags=3D0x%08x\n", arg->flags);
-            fuse_log(FUSE_LOG_DEBUG, "max_readahead=3D0x%08x\n",
-                     arg->max_readahead);
-        }
+    fuse_log(FUSE_LOG_DEBUG, "INIT: %u.%u\n", arg->major, arg->minor);
+    if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
+        fuse_log(FUSE_LOG_DEBUG, "flags=3D0x%08x\n", arg->flags);
+        fuse_log(FUSE_LOG_DEBUG, "max_readahead=3D0x%08x\n", arg->max_read=
ahead);
     }
     se->conn.proto_major =3D arg->major;
     se->conn.proto_minor =3D arg->minor;
@@ -2118,19 +2111,14 @@ static void do_init(fuse_req_t req, fuse_ino_t node=
id,
     outarg.congestion_threshold =3D se->conn.congestion_threshold;
     outarg.time_gran =3D se->conn.time_gran;
=20
-    if (se->debug) {
-        fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major,
-                 outarg.minor);
-        fuse_log(FUSE_LOG_DEBUG, "   flags=3D0x%08x\n", outarg.flags);
-        fuse_log(FUSE_LOG_DEBUG, "   max_readahead=3D0x%08x\n",
-                 outarg.max_readahead);
-        fuse_log(FUSE_LOG_DEBUG, "   max_write=3D0x%08x\n", outarg.max_wri=
te);
-        fuse_log(FUSE_LOG_DEBUG, "   max_background=3D%i\n",
-                 outarg.max_background);
-        fuse_log(FUSE_LOG_DEBUG, "   congestion_threshold=3D%i\n",
-                 outarg.congestion_threshold);
-        fuse_log(FUSE_LOG_DEBUG, "   time_gran=3D%u\n", outarg.time_gran);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major, outarg.mino=
r);
+    fuse_log(FUSE_LOG_DEBUG, "   flags=3D0x%08x\n", outarg.flags);
+    fuse_log(FUSE_LOG_DEBUG, "   max_readahead=3D0x%08x\n", outarg.max_rea=
dahead);
+    fuse_log(FUSE_LOG_DEBUG, "   max_write=3D0x%08x\n", outarg.max_write);
+    fuse_log(FUSE_LOG_DEBUG, "   max_background=3D%i\n", outarg.max_backgr=
ound);
+    fuse_log(FUSE_LOG_DEBUG, "   congestion_threshold=3D%i\n",
+             outarg.congestion_threshold);
+    fuse_log(FUSE_LOG_DEBUG, "   time_gran=3D%u\n", outarg.time_gran);
=20
     send_reply_ok(req, &outarg, outargsize);
 }
@@ -2410,14 +2398,11 @@ void fuse_session_process_buf_int(struct fuse_sessi=
on *se,
     in =3D fuse_mbuf_iter_advance(&iter, sizeof(*in));
     assert(in); /* caller guarantees the input buffer is large enough */
=20
-    if (se->debug) {
-        fuse_log(FUSE_LOG_DEBUG,
-                 "unique: %llu, opcode: %s (%i), nodeid: %llu, insize: %zu=
, "
-                 "pid: %u\n",
-                 (unsigned long long)in->unique,
-                 opname((enum fuse_opcode)in->opcode), in->opcode,
-                 (unsigned long long)in->nodeid, buf->size, in->pid);
-    }
+    fuse_log(
+        FUSE_LOG_DEBUG,
+        "unique: %llu, opcode: %s (%i), nodeid: %llu, insize: %zu, pid: %u=
\n",
+        (unsigned long long)in->unique, opname((enum fuse_opcode)in->opcod=
e),
+        in->opcode, (unsigned long long)in->nodeid, buf->size, in->pid);
=20
     req =3D fuse_ll_alloc_req(se);
     if (req =3D=3D NULL) {
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index c67677732b..27f631d9fc 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1829,6 +1829,7 @@ struct fuse_cmdline_opts {
     int print_capabilities;
     int clone_fd;
     int syslog;
+    int log_level;
     unsigned int max_idle_threads;
 };
=20
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 2c64b10ebf..7b28507a38 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -33,7 +33,6 @@
         t, offsetof(struct fuse_cmdline_opts, p), v \
     }
=20
-
 static const struct fuse_opt fuse_helper_opts[] =3D {
     FUSE_HELPER_OPT("-h", show_help),
     FUSE_HELPER_OPT("--help", show_help),
@@ -56,6 +55,10 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
     FUSE_HELPER_OPT("clone_fd", clone_fd),
     FUSE_HELPER_OPT("max_idle_threads=3D%u", max_idle_threads),
     FUSE_HELPER_OPT("--syslog", syslog),
+    FUSE_HELPER_OPT_VALUE("log_level=3Ddebug", log_level, FUSE_LOG_DEBUG),
+    FUSE_HELPER_OPT_VALUE("log_level=3Dinfo", log_level, FUSE_LOG_INFO),
+    FUSE_HELPER_OPT_VALUE("log_level=3Dwarn", log_level, FUSE_LOG_WARNING)=
,
+    FUSE_HELPER_OPT_VALUE("log_level=3Derr", log_level, FUSE_LOG_ERR),
     FUSE_OPT_END
 };
=20
@@ -149,7 +152,10 @@ void fuse_cmdline_help(void)
            "                               (may improve performance)\n"
            "    -o max_idle_threads        the maximum number of idle work=
er "
            "threads\n"
-           "                               allowed (default: 10)\n");
+           "                               allowed (default: 10)\n"
+           "    -o log_level=3D<level>       log level, default to \"info\=
"\n"
+           "                               level could be one of \"debug, =
"
+           "info, warn, err\"\n");
 }
=20
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 9ede80af94..6f398a7ff2 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -36,6 +36,7 @@
  */
=20
 #include "fuse_virtio.h"
+#include "fuse_log.h"
 #include "fuse_lowlevel.h"
 #include <assert.h>
 #include <cap-ng.h>
@@ -140,6 +141,7 @@ static const struct fuse_opt lo_opts[] =3D {
     FUSE_OPT_END
 };
 static bool use_syslog =3D false;
+static int current_log_level;
=20
 static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n);
=20
@@ -458,11 +460,6 @@ static int lo_fd(fuse_req_t req, fuse_ino_t ino)
     return inode ? inode->fd : -1;
 }
=20
-static bool lo_debug(fuse_req_t req)
-{
-    return lo_data(req)->debug !=3D 0;
-}
-
 static void lo_init(void *userdata, struct fuse_conn_info *conn)
 {
     struct lo_data *lo =3D (struct lo_data *)userdata;
@@ -472,15 +469,11 @@ static void lo_init(void *userdata, struct fuse_conn_=
info *conn)
     }
=20
     if (lo->writeback && conn->capable & FUSE_CAP_WRITEBACK_CACHE) {
-        if (lo->debug) {
-            fuse_log(FUSE_LOG_DEBUG, "lo_init: activating writeback\n");
-        }
+        fuse_log(FUSE_LOG_DEBUG, "lo_init: activating writeback\n");
         conn->want |=3D FUSE_CAP_WRITEBACK_CACHE;
     }
     if (lo->flock && conn->capable & FUSE_CAP_FLOCK_LOCKS) {
-        if (lo->debug) {
-            fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
-        }
+        fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
         conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
     }
 }
@@ -823,10 +816,8 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
     }
     e->ino =3D inode->fuse_ino;
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
-                 (unsigned long long)parent, name, (unsigned long long)e->=
ino);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n", (unsigned long long)pa=
rent,
+             name, (unsigned long long)e->ino);
=20
     return 0;
=20
@@ -843,10 +834,8 @@ static void lo_lookup(fuse_req_t req, fuse_ino_t paren=
t, const char *name)
     struct fuse_entry_param e;
     int err;
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG, "lo_lookup(parent=3D%" PRIu64 ", name=3D%=
s)\n",
-                 parent, name);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "lo_lookup(parent=3D%" PRIu64 ", name=3D%s)\n=
", parent,
+             name);
=20
     /*
      * Don't use is_safe_path_component(), allow "." and ".." for NFS expo=
rt
@@ -954,10 +943,8 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino_=
t parent,
         goto out;
     }
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
-                 (unsigned long long)parent, name, (unsigned long long)e.i=
no);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n", (unsigned long long)pa=
rent,
+             name, (unsigned long long)e.ino);
=20
     fuse_reply_entry(req, &e);
     return;
@@ -1057,10 +1044,8 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, =
fuse_ino_t parent,
     pthread_mutex_unlock(&lo->mutex);
     e.ino =3D inode->fuse_ino;
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
-                 (unsigned long long)parent, name, (unsigned long long)e.i=
no);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n", (unsigned long long)pa=
rent,
+             name, (unsigned long long)e.ino);
=20
     fuse_reply_entry(req, &e);
     return;
@@ -1154,11 +1139,9 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_t=
 ino, uint64_t nlookup)
         return;
     }
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
-                 (unsigned long long)ino, (unsigned long long)inode->refco=
unt,
-                 (unsigned long long)nlookup);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
+             (unsigned long long)ino, (unsigned long long)inode->refcount,
+             (unsigned long long)nlookup);
=20
     unref_inode(lo, inode, nlookup);
 }
@@ -1428,10 +1411,8 @@ static void lo_create(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
     int err;
     struct lo_cred old =3D {};
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%=
s)\n",
-                 parent, name);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%s)\n=
", parent,
+             name);
=20
     if (!is_safe_path_component(name)) {
         fuse_reply_err(req, EINVAL);
@@ -1508,10 +1489,8 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
     char buf[64];
     struct lo_data *lo =3D lo_data(req);
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n=
", ino,
-                 fi->flags);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n", i=
no,
+             fi->flags);
=20
     /*
      * With writeback cache, kernel may send read requests even
@@ -1626,12 +1605,10 @@ static void lo_read(fuse_req_t req, fuse_ino_t ino,=
 size_t size, off_t offset,
 {
     struct fuse_bufvec buf =3D FUSE_BUFVEC_INIT(size);
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG,
-                 "lo_read(ino=3D%" PRIu64 ", size=3D%zd, "
-                 "off=3D%lu)\n",
-                 ino, size, (unsigned long)offset);
-    }
+    fuse_log(FUSE_LOG_DEBUG,
+             "lo_read(ino=3D%" PRIu64 ", size=3D%zd, "
+             "off=3D%lu)\n",
+             ino, size, (unsigned long)offset);
=20
     buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
     buf.buf[0].fd =3D lo_fi_fd(req, fi);
@@ -1653,11 +1630,9 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t =
ino,
     out_buf.buf[0].fd =3D lo_fi_fd(req, fi);
     out_buf.buf[0].pos =3D off;
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG,
-                 "lo_write(ino=3D%" PRIu64 ", size=3D%zd, off=3D%lu)\n", i=
no,
-                 out_buf.buf[0].size, (unsigned long)off);
-    }
+    fuse_log(FUSE_LOG_DEBUG,
+             "lo_write_buf(ino=3D%" PRIu64 ", size=3D%zd, off=3D%lu)\n", i=
no,
+             out_buf.buf[0].size, (unsigned long)off);
=20
     /*
      * If kill_priv is set, drop CAP_FSETID which should lead to kernel
@@ -1756,11 +1731,8 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
         goto out;
     }
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG,
-                 "lo_getxattr(ino=3D%" PRIu64 ", name=3D%s size=3D%zd)\n",=
 ino, name,
-                 size);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "lo_getxattr(ino=3D%" PRIu64 ", name=3D%s siz=
e=3D%zd)\n",
+             ino, name, size);
=20
     if (inode->is_symlink) {
         /* Sorry, no race free way to getxattr on symlink. */
@@ -1834,10 +1806,8 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t =
ino, size_t size)
         goto out;
     }
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG, "lo_listxattr(ino=3D%" PRIu64 ", size=3D%=
zd)\n",
-                 ino, size);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "lo_listxattr(ino=3D%" PRIu64 ", size=3D%zd)\=
n", ino,
+             size);
=20
     if (inode->is_symlink) {
         /* Sorry, no race free way to listxattr on symlink. */
@@ -1911,11 +1881,8 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
         goto out;
     }
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG,
-                 "lo_setxattr(ino=3D%" PRIu64 ", name=3D%s value=3D%s size=
=3D%zd)\n",
-                 ino, name, value, size);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "lo_setxattr(ino=3D%" PRIu64,
+             ", name=3D%s value=3D%s size=3D%zd)\n", ino, name, value, siz=
e);
=20
     if (inode->is_symlink) {
         /* Sorry, no race free way to removexattr on symlink. */
@@ -1960,10 +1927,8 @@ static void lo_removexattr(fuse_req_t req, fuse_ino_=
t ino, const char *name)
         goto out;
     }
=20
-    if (lo_debug(req)) {
-        fuse_log(FUSE_LOG_DEBUG, "lo_removexattr(ino=3D%" PRIu64 ", name=
=3D%s)\n",
-                 ino, name);
-    }
+    fuse_log(FUSE_LOG_DEBUG, "lo_removexattr(ino=3D%" PRIu64 ", name=3D%s)=
\n", ino,
+             name);
=20
     if (inode->is_symlink) {
         /* Sorry, no race free way to setxattr on symlink. */
@@ -2285,6 +2250,10 @@ static void setup_nofile_rlimit(void)
=20
 static void log_func(enum fuse_log_level level, const char *fmt, va_list a=
p)
 {
+    if (current_log_level < level) {
+        return;
+    }
+
     if (use_syslog) {
         int priority =3D LOG_ERR;
         switch (level) {
@@ -2383,8 +2352,19 @@ int main(int argc, char *argv[])
         return 1;
     }
=20
+    /*
+     * log_level is 0 if not configured via cmd options (0 is LOG_EMERG,
+     * and we don't use this log level).
+     */
+    if (opts.log_level !=3D 0) {
+        current_log_level =3D opts.log_level;
+    }
     lo.debug =3D opts.debug;
+    if (lo.debug) {
+        current_log_level =3D FUSE_LOG_DEBUG;
+    }
     lo.root.refcount =3D 2;
+
     if (lo.source) {
         struct stat stat;
         int res;
--=20
2.23.0


