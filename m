Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71785CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D9820650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr9az883"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D9820650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcLG-0003zz-UV
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIq-00052W-Kr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIo-0000Jl-Dr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:29:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56640
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIo-0000JJ-8E
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ra0m6R0Jq8MJjj4NSDieXizCZ4KTnChLN5Wi+ZEnxA=;
 b=Tr9az883OlYmz2kxoodyFPs9tvxdH9Z/51deOfDZFgdvsflQowokl0uKKyf7iYAGkzjElA
 0cqUwuAhUpjm4nYzVCcmFK78xI65cVe+pIw0mQ/W+qcyYYbHtqOsm68dv1bs+tAFiznutx
 2XHbSr8kHREwIYf4onT89ulOPCLDQ2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-mONigV8WMFWAMMrrVUKASg-1; Thu, 24 Oct 2019 07:29:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 853E580183D;
 Thu, 24 Oct 2019 11:29:07 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC1852D5;
 Thu, 24 Oct 2019 11:29:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 25/25] virtiofsd: print log only when priority is high enough
Date: Thu, 24 Oct 2019 12:27:18 +0100
Message-Id: <20191024112718.34657-26-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mONigV8WMFWAMMrrVUKASg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

From: Eryu Guan <eguan@linux.alibaba.com>

Introduce "-o log_level=3D" command line option to specify current log
level (priority), valid values are "debug info warn err", e.g.

    ./virtiofsd -o log_level=3Ddebug ...

So only log priority higher than "debug" will be printed to
stderr/syslog. And the default level is info.

The "-o debug"/"-d" options are kept, and imply debug log level.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
dgilbert: Reworked for libfuse's log_func
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/fuse_log.c       |   4 ++
 contrib/virtiofsd/fuse_lowlevel.c  |  79 ++++++++++-------------
 contrib/virtiofsd/fuse_lowlevel.h  |   1 +
 contrib/virtiofsd/helper.c         |   9 ++-
 contrib/virtiofsd/passthrough_ll.c | 100 +++++++++++++----------------
 5 files changed, 91 insertions(+), 102 deletions(-)

diff --git a/contrib/virtiofsd/fuse_log.c b/contrib/virtiofsd/fuse_log.c
index 0d268ab014..b11f6d0c08 100644
--- a/contrib/virtiofsd/fuse_log.c
+++ b/contrib/virtiofsd/fuse_log.c
@@ -8,6 +8,10 @@
   See the file COPYING.LIB
 */
=20
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <syslog.h>
 #include "fuse_log.h"
=20
 #include <stdarg.h>
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index 8f9a59a34c..20f2190194 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -155,20 +155,17 @@ static int fuse_send_msg(struct fuse_session *se, str=
uct fuse_chan *ch,
 =09struct fuse_out_header *out =3D iov[0].iov_base;
=20
 =09out->len =3D iov_length(iov, count);
-=09if (se->debug) {
-=09=09if (out->unique =3D=3D 0) {
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n",
-=09=09=09=09out->error, out->len);
-=09=09} else if (out->error) {
-=09=09=09fuse_log(FUSE_LOG_DEBUG,
-=09=09=09=09"   unique: %llu, error: %i (%s), outsize: %i\n",
-=09=09=09=09(unsigned long long) out->unique, out->error,
-=09=09=09=09strerror(-out->error), out->len);
-=09=09} else {
-=09=09=09fuse_log(FUSE_LOG_DEBUG,
-=09=09=09=09"   unique: %llu, success, outsize: %i\n",
-=09=09=09=09(unsigned long long) out->unique, out->len);
-=09=09}
+=09if (out->unique =3D=3D 0) {
+=09=09fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n",
+=09=09=09   out->error, out->len);
+=09} else if (out->error) {
+=09=09fuse_log(FUSE_LOG_DEBUG, "   unique: %llu, error: %i (%s), outsize: =
%i\n",
+=09=09=09   (unsigned long long) out->unique,
+=09=09=09   out->error, strerror(-out->error),
+=09=09=09   out->len);
+=09} else {
+=09=09fuse_log(FUSE_LOG_DEBUG, "   unique: %llu, success, outsize: %i\n",
+=09=09=09   (unsigned long long) out->unique, out->len);
 =09}
=20
 =09if (fuse_lowlevel_is_virtio(se)) {
@@ -1663,9 +1660,8 @@ static void do_interrupt(fuse_req_t req, fuse_ino_t n=
odeid,
 =09=09return;
 =09}
=20
-=09if (se->debug)
-=09=09fuse_log(FUSE_LOG_DEBUG, "INTERRUPT: %llu\n",
-=09=09=09(unsigned long long) arg->unique);
+=09fuse_log(FUSE_LOG_DEBUG, "INTERRUPT: %llu\n",
+=09=09 (unsigned long long) arg->unique);
=20
 =09req->u.i.unique =3D arg->unique;
=20
@@ -1878,13 +1874,11 @@ static void do_init(fuse_req_t req, fuse_ino_t node=
id,
 =09=09}
 =09}
=20
-=09if (se->debug) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "INIT: %u.%u\n", arg->major, arg->minor);
-=09=09if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "flags=3D0x%08x\n", arg->flags);
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "max_readahead=3D0x%08x\n",
-=09=09=09=09arg->max_readahead);
-=09=09}
+=09fuse_log(FUSE_LOG_DEBUG, "INIT: %u.%u\n", arg->major, arg->minor);
+=09if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
+=09=09fuse_log(FUSE_LOG_DEBUG, "flags=3D0x%08x\n", arg->flags);
+=09=09fuse_log(FUSE_LOG_DEBUG, "max_readahead=3D0x%08x\n",
+=09=09=09   arg->max_readahead);
 =09}
 =09se->conn.proto_major =3D arg->major;
 =09se->conn.proto_minor =3D arg->minor;
@@ -2070,19 +2064,17 @@ static void do_init(fuse_req_t req, fuse_ino_t node=
id,
 =09if (se->conn.proto_minor >=3D 23)
 =09=09outarg.time_gran =3D se->conn.time_gran;
=20
-=09if (se->debug) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major, outarg.mi=
nor);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   flags=3D0x%08x\n", outarg.flags);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   max_readahead=3D0x%08x\n",
-=09=09=09outarg.max_readahead);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   max_write=3D0x%08x\n", outarg.max_write=
);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   max_background=3D%i\n",
-=09=09=09outarg.max_background);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   congestion_threshold=3D%i\n",
-=09=09=09outarg.congestion_threshold);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   time_gran=3D%u\n",
-=09=09=09outarg.time_gran);
-=09}
+=09fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major, outarg.minor=
);
+=09fuse_log(FUSE_LOG_DEBUG, "   flags=3D0x%08x\n", outarg.flags);
+=09fuse_log(FUSE_LOG_DEBUG, "   max_readahead=3D0x%08x\n",
+=09=09   outarg.max_readahead);
+=09fuse_log(FUSE_LOG_DEBUG, "   max_write=3D0x%08x\n", outarg.max_write);
+=09fuse_log(FUSE_LOG_DEBUG, "   max_background=3D%i\n",
+=09=09   outarg.max_background);
+=09fuse_log(FUSE_LOG_DEBUG, "   congestion_threshold=3D%i\n",
+=09=09   outarg.congestion_threshold);
+=09fuse_log(FUSE_LOG_DEBUG, "   time_gran=3D%u\n",
+=09=09   outarg.time_gran);
 =09if (arg->minor < 5)
 =09=09outargsize =3D FUSE_COMPAT_INIT_OUT_SIZE;
 =09else if (arg->minor < 23)
@@ -2370,13 +2362,12 @@ void fuse_session_process_buf_int(struct fuse_sessi=
on *se,
 =09in =3D fuse_mbuf_iter_advance(&iter, sizeof(*in));
 =09assert(in); /* caller guarantees the input buffer is large enough */
=20
-=09if (se->debug) {
-=09=09fuse_log(FUSE_LOG_DEBUG,
-=09=09=09"unique: %llu, opcode: %s (%i), nodeid: %llu, insize: %zu, pid: %=
u\n",
-=09=09=09(unsigned long long) in->unique,
-=09=09=09opname((enum fuse_opcode) in->opcode), in->opcode,
-=09=09=09(unsigned long long) in->nodeid, buf->size, in->pid);
-=09}
+=09fuse_log(FUSE_LOG_DEBUG,
+=09=09 "unique: %llu, opcode: %s (%i), nodeid: %llu, insize: %zu, pid: %u\=
n",
+=09=09 (unsigned long long) in->unique,
+=09=09 opname((enum fuse_opcode) in->opcode), in->opcode,
+=09=09 (unsigned long long) in->nodeid, buf->size,
+=09=09 in->pid);
=20
 =09req =3D fuse_ll_alloc_req(se);
 =09if (req =3D=3D NULL) {
diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_low=
level.h
index 112596caaf..49cf5b22ff 100644
--- a/contrib/virtiofsd/fuse_lowlevel.h
+++ b/contrib/virtiofsd/fuse_lowlevel.h
@@ -1799,6 +1799,7 @@ struct fuse_cmdline_opts {
 =09int print_capabilities;
 =09int clone_fd;
 =09int syslog;
+=09int log_level;
 =09unsigned int max_idle_threads;
 };
=20
diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
index b1e45aee05..d9eb9ff62c 100644
--- a/contrib/virtiofsd/helper.c
+++ b/contrib/virtiofsd/helper.c
@@ -29,7 +29,6 @@
 #define FUSE_HELPER_OPT_VALUE(t, p, v) \
 =09{ t, offsetof(struct fuse_cmdline_opts, p), v }
=20
-
 static const struct fuse_opt fuse_helper_opts[] =3D {
 =09FUSE_HELPER_OPT("-h",=09=09show_help),
 =09FUSE_HELPER_OPT("--help",=09show_help),
@@ -54,6 +53,10 @@ static const struct fuse_opt fuse_helper_opts[] =3D {
 =09FUSE_HELPER_OPT("clone_fd",=09clone_fd),
 =09FUSE_HELPER_OPT("max_idle_threads=3D%u", max_idle_threads),
 =09FUSE_HELPER_OPT("--syslog",=09syslog),
+=09FUSE_HELPER_OPT_VALUE("log_level=3Ddebug", log_level, FUSE_LOG_DEBUG),
+=09FUSE_HELPER_OPT_VALUE("log_level=3Dinfo", log_level, FUSE_LOG_INFO),
+=09FUSE_HELPER_OPT_VALUE("log_level=3Dwarn", log_level, FUSE_LOG_WARNING),
+=09FUSE_HELPER_OPT_VALUE("log_level=3Derr", log_level, FUSE_LOG_ERR),
 =09FUSE_OPT_END
 };
=20
@@ -143,7 +146,9 @@ void fuse_cmdline_help(void)
 =09       "    -o clone_fd                use separate fuse device fd for =
each thread\n"
 =09       "                               (may improve performance)\n"
 =09       "    -o max_idle_threads        the maximum number of idle worke=
r threads\n"
-=09       "                               allowed (default: 10)\n");
+=09       "                               allowed (default: 10)\n"
+=09       "    -o log_level=3D<level>       log level, default to \"info\"=
\n"
+=09       "                               level could be one of \"debug, i=
nfo, warn, err\"\n");
 }
=20
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index b413687720..8ad41b1072 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -36,6 +36,7 @@
=20
 #include "fuse_virtio.h"
 #include "fuse_lowlevel.h"
+#include "fuse_log.h"
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -153,6 +154,7 @@ static const struct fuse_opt lo_opts[] =3D {
 =09FUSE_OPT_END
 };
 static bool use_syslog =3D false;
+static int current_log_level;
=20
 static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n);
=20
@@ -446,11 +448,6 @@ static int lo_fd(fuse_req_t req, fuse_ino_t ino)
 =09return inode ? inode->fd : -1;
 }
=20
-static bool lo_debug(fuse_req_t req)
-{
-=09return lo_data(req)->debug !=3D 0;
-}
-
 static void lo_init(void *userdata,
 =09=09    struct fuse_conn_info *conn)
 {
@@ -461,13 +458,11 @@ static void lo_init(void *userdata,
=20
 =09if (lo->writeback &&
 =09    conn->capable & FUSE_CAP_WRITEBACK_CACHE) {
-=09=09if (lo->debug)
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "lo_init: activating writeback\n");
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_init: activating writeback\n");
 =09=09conn->want |=3D FUSE_CAP_WRITEBACK_CACHE;
 =09}
 =09if (lo->flock && conn->capable & FUSE_CAP_FLOCK_LOCKS) {
-=09=09if (lo->debug)
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
 =09=09conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
 =09}
 }
@@ -789,9 +784,9 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
 =09}
 =09e->ino =3D inode->fuse_ino;
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
-=09=09=09(unsigned long long) parent, name, (unsigned long long) e->ino);
+=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
+=09=09 (unsigned long long) parent, name,
+=09=09 (unsigned long long) e->ino);
=20
 =09return 0;
=20
@@ -807,9 +802,7 @@ static void lo_lookup(fuse_req_t req, fuse_ino_t parent=
, const char *name)
 =09struct fuse_entry_param e;
 =09int err;
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_lookup(parent=3D%" PRIu64 ", name=3D%s)=
\n",
-=09=09=09parent, name);
+=09fuse_log(FUSE_LOG_DEBUG, "lo_lookup(parent=3D%" PRIu64 ", name=3D%s)\n"=
, parent, name);
=20
 =09/* Don't use is_safe_path_component(), allow "." and ".." for NFS expor=
t
 =09 * support.
@@ -911,9 +904,9 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino_t=
 parent,
 =09if (saverr)
 =09=09goto out;
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
-=09=09=09(unsigned long long) parent, name, (unsigned long long) e.ino);
+=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
+=09=09   (unsigned long long) parent, name,
+=09=09   (unsigned long long) e.ino);
=20
 =09fuse_reply_entry(req, &e);
 =09return;
@@ -1010,10 +1003,9 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, =
fuse_ino_t parent,
 =09pthread_mutex_unlock(&lo->mutex);
 =09e.ino =3D inode->fuse_ino;
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
-=09=09=09(unsigned long long) parent, name,
-=09=09=09(unsigned long long) e.ino);
+=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
+=09=09   (unsigned long long) parent, name,
+=09=09   (unsigned long long) e.ino);
=20
 =09fuse_reply_entry(req, &e);
 =09return;
@@ -1107,12 +1099,10 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_=
t ino, uint64_t nlookup)
 =09if (!inode)
 =09=09return;
=20
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
-=09=09=09(unsigned long long) ino,
-=09=09=09(unsigned long long) inode->refcount,
-=09=09=09(unsigned long long) nlookup);
-=09}
+=09fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
+=09=09(unsigned long long) ino,
+=09=09(unsigned long long) inode->refcount,
+=09=09(unsigned long long) nlookup);
=20
 =09unref_inode(lo, inode, nlookup);
 }
@@ -1364,9 +1354,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
 =09int err;
 =09struct lo_cred old =3D {};
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%s)=
\n",
-=09=09=09parent, name);
+=09fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%s)\n"=
, parent, name);
=20
 =09if (!is_safe_path_component(name)) {
 =09=09fuse_reply_err(req, EINVAL);
@@ -1439,9 +1427,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, s=
truct fuse_file_info *fi)
 =09char buf[64];
 =09struct lo_data *lo =3D lo_data(req);
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n",
-=09=09=09ino, fi->flags);
+=09fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n", in=
o, fi->flags);
=20
 =09/* With writeback cache, kernel may send read requests even
 =09   when userspace opened write-only */
@@ -1543,9 +1529,8 @@ static void lo_read(fuse_req_t req, fuse_ino_t ino, s=
ize_t size,
 {
 =09struct fuse_bufvec buf =3D FUSE_BUFVEC_INIT(size);
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_read(ino=3D%" PRIu64 ", size=3D%zd, "
-=09=09=09"off=3D%lu)\n", ino, size, (unsigned long) offset);
+=09fuse_log(FUSE_LOG_DEBUG, "lo_read(ino=3D%" PRIu64 ", size=3D%zd, "
+=09=09   "off=3D%lu)\n", ino, size, (unsigned long) offset);
=20
 =09buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
 =09buf.buf[0].fd =3D lo_fi_fd(req, fi);
@@ -1567,9 +1552,8 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t i=
no,
 =09out_buf.buf[0].fd =3D lo_fi_fd(req, fi);
 =09out_buf.buf[0].pos =3D off;
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_write(ino=3D%" PRIu64 ", size=3D%zd, of=
f=3D%lu)\n",
-=09=09=09ino, out_buf.buf[0].size, (unsigned long) off);
+=09fuse_log(FUSE_LOG_DEBUG, "lo_write_buf(ino=3D%" PRIu64 ", size=3D%zd, o=
ff=3D%lu)\n",
+=09=09   ino, out_buf.buf[0].size, (unsigned long) off);
=20
 =09/*
 =09 * If kill_priv is set, drop CAP_FSETID which should lead to kernel
@@ -1662,10 +1646,8 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
 =09if (!lo_data(req)->xattr)
 =09=09goto out;
=20
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_getxattr(ino=3D%" PRIu64 ", name=3D%s s=
ize=3D%zd)\n",
-=09=09=09ino, name, size);
-=09}
+=09fuse_log(FUSE_LOG_DEBUG, "lo_getxattr(ino=3D%" PRIu64 ", name=3D%s size=
=3D%zd)\n",
+=09=09   ino, name, size);
=20
 =09if (inode->is_symlink) {
 =09=09/* Sorry, no race free way to getxattr on symlink. */
@@ -1734,10 +1716,7 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t =
ino, size_t size)
 =09if (!lo_data(req)->xattr)
 =09=09goto out;
=20
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_listxattr(ino=3D%" PRIu64 ", size=3D%zd=
)\n",
-=09=09=09ino, size);
-=09}
+=09fuse_log(FUSE_LOG_DEBUG, "lo_listxattr(ino=3D%" PRIu64 ", size=3D%zd)\n=
", ino, size);
=20
 =09if (inode->is_symlink) {
 =09=09/* Sorry, no race free way to listxattr on symlink. */
@@ -1806,10 +1785,9 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
 =09if (!lo_data(req)->xattr)
 =09=09goto out;
=20
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_setxattr(ino=3D%" PRIu64 ", name=3D%s v=
alue=3D%s size=3D%zd)\n",
-=09=09=09ino, name, value, size);
-=09}
+=09fuse_log(FUSE_LOG_DEBUG, "lo_setxattr(ino=3D%" PRIu64,
+=09=09 ", name=3D%s value=3D%s size=3D%zd)\n",
+=09=09 ino, name, value, size);
=20
 =09if (inode->is_symlink) {
 =09=09/* Sorry, no race free way to removexattr on symlink. */
@@ -1853,10 +1831,8 @@ static void lo_removexattr(fuse_req_t req, fuse_ino_=
t ino, const char *name)
 =09if (!lo_data(req)->xattr)
 =09=09goto out;
=20
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_removexattr(ino=3D%" PRIu64 ", name=3D%=
s)\n",
-=09=09=09ino, name);
-=09}
+=09fuse_log(FUSE_LOG_DEBUG, "lo_removexattr(ino=3D%" PRIu64 ", name=3D%s)\=
n",
+=09=09 ino, name);
=20
 =09if (inode->is_symlink) {
 =09=09/* Sorry, no race free way to setxattr on symlink. */
@@ -2147,6 +2123,9 @@ static void setup_nofile_rlimit(void)
 static void log_func(enum fuse_log_level level,
 =09=09     const char *fmt, va_list ap)
 {
+=09if (current_log_level < level)
+=09=09return;
+
 =09if (use_syslog) {
 =09=09int priority =3D LOG_ERR;
 =09=09switch (level) {
@@ -2227,8 +2206,17 @@ int main(int argc, char *argv[])
 =09if (fuse_opt_parse(&args, &lo, lo_opts, NULL)=3D=3D -1)
 =09=09return 1;
=20
+=09/*
+=09 * log_level is 0 if not configured via cmd options (0 is LOG_EMERG,
+=09 * and we don't use this log level).
+=09 */
+=09if (opts.log_level !=3D 0)
+=09=09current_log_level =3D opts.log_level;
 =09lo.debug =3D opts.debug;
+=09if (lo.debug)
+=09=09current_log_level =3D FUSE_LOG_DEBUG;
 =09lo.root.refcount =3D 2;
+
 =09if (lo.source) {
 =09=09struct stat stat;
 =09=09int res;
--=20
2.23.0


