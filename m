Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F267C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC6C222EA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHt6wSQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC6C222EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaRM-0003fq-5z
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kIaPj-00032v-Qa
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kIaPc-0002d2-Ly
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600274161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=W1ytmFSBleq3Ztl7Z5u0ZaSVzoh6l0BIYX6BqebCjg8=;
 b=EHt6wSQGYvMrE0YYp58DeQnQea6DwKd53uOuXpeyIV00BlnmlBbLF3/RQ/Qb5AsxsYLpv4
 uwj3x3XNu3OOvmIIvAdv9WTFaIeOp0h18VZi/w73ziPVZgPX3dsSR7b/kqbCOoWFOkMwzg
 owUFpFcEZum0JQTG7tZULM5U9lfOn0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-FAVoQAjjPP2vj7i5ZxSg4A-1; Wed, 16 Sep 2020 12:35:58 -0400
X-MC-Unique: FAVoQAjjPP2vj7i5ZxSg4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAEA418BA285
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:35:57 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-139.rdu2.redhat.com [10.10.116.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C3711002D42;
 Wed, 16 Sep 2020 16:35:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 8AE262209FD; Wed, 16 Sep 2020 12:35:53 -0400 (EDT)
Date: Wed, 16 Sep 2020 12:35:53 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtiofsd: Add support for FUSE_HANDLE_KILLPRIV_V2
Message-ID: <20200916163553.GA39212@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds basic support for FUSE_HANDLE_KILLPRIV_V2. virtiofsd
can enable/disable this by specifying option "-o killpriv_v2/no_killpriv_v2".
By default this is enabled as long as client supports it.

I have posted corresponding kernel patches here.

https://www.redhat.com/archives/virtio-fs/2020-September/msg00054.html

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 include/standard-headers/linux/fuse.h |  10 ++-
 tools/virtiofsd/fuse_common.h         |  10 +++
 tools/virtiofsd/fuse_lowlevel.c       |  10 ++-
 tools/virtiofsd/fuse_lowlevel.h       |   1 +
 tools/virtiofsd/passthrough_ll.c      | 116 ++++++++++++++++++++++++--
 5 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index 26e7de1b43..744498bc5a 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -338,6 +338,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_HANDLE_KILLPRIV_V2	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
@@ -413,6 +414,13 @@ struct fuse_file_lock {
  */
 #define FUSE_FSYNC_FDATASYNC	(1 << 0)
 
+/**
+ * Open flags
+ * FUSE_OPEN_KILL_PRIV: Kill suid/sgid/security.capability. sgid is cleared
+ *                      only if file has group execute permission.
+ */
+#define FUSE_OPEN_KILL_PRIV    (1 << 0)
+
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
@@ -579,7 +587,7 @@ struct fuse_setattr_in {
 
 struct fuse_open_in {
 	uint32_t	flags;
-	uint32_t	unused;
+	uint32_t	open_flags;
 };
 
 struct fuse_create_in {
diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index aa7e6ed31a..a8d8217687 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -352,6 +352,16 @@ struct fuse_file_info {
  */
 #define FUSE_CAP_NO_OPENDIR_SUPPORT (1 << 24)
 
+/**
+ * Indicates that the filesystem is responsible for unsetting
+ * setuid and setgid bits when a file is written, truncated, or
+ * its owner is changed. setuid/setgid is cleared on WRITE/truncate
+ * only if caller does not have CAP_FSETID. For WRITE requests
+ * this is communicated through write flag FUSE_WRITE_KILL_PRIV.
+ *
+ */
+#define FUSE_CAP_HANDLE_KILLPRIV_V2 (1 << 27)
+
 /**
  * Ioctl flags
  *
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index a34a611a90..90afffd6de 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -881,7 +881,7 @@ static void do_setattr(fuse_req_t req, fuse_ino_t nodeid,
                       FUSE_SET_ATTR_GID | FUSE_SET_ATTR_SIZE |
                       FUSE_SET_ATTR_ATIME | FUSE_SET_ATTR_MTIME |
                       FUSE_SET_ATTR_ATIME_NOW | FUSE_SET_ATTR_MTIME_NOW |
-                      FUSE_SET_ATTR_CTIME;
+                      FUSE_SET_ATTR_CTIME | FUSE_SET_ATTR_KILL_PRIV;
 
         req->se->op.setattr(req, nodeid, &stbuf, arg->valid, fi);
     } else {
@@ -1118,6 +1118,7 @@ static void do_open(fuse_req_t req, fuse_ino_t nodeid,
 
     memset(&fi, 0, sizeof(fi));
     fi.flags = arg->flags;
+    fi.kill_priv = arg->open_flags & FUSE_OPEN_KILL_PRIV;
 
     if (req->se->op.open) {
         req->se->op.open(req, nodeid, &fi);
@@ -2081,6 +2082,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
             bufsize = max_bufsize;
         }
     }
+    if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
+        se->conn.capable |= FUSE_CAP_HANDLE_KILLPRIV_V2;
+    }
 #ifdef HAVE_SPLICE
 #ifdef HAVE_VMSPLICE
     se->conn.capable |= FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
@@ -2218,6 +2222,10 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
         outarg.map_alignment = ffsl(sysconf(_SC_PAGE_SIZE)) - 1;
     }
 
+    if (se->conn.want & FUSE_CAP_HANDLE_KILLPRIV_V2) {
+        outarg.flags |= FUSE_HANDLE_KILLPRIV_V2;
+    }
+
     fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major, outarg.minor);
     fuse_log(FUSE_LOG_DEBUG, "   flags=0x%08x\n", outarg.flags);
     fuse_log(FUSE_LOG_DEBUG, "   max_readahead=0x%08x\n", outarg.max_readahead);
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowlevel.h
index d488b88882..fdc256b5ce 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -145,6 +145,7 @@ struct fuse_forget_data {
 #define FUSE_SET_ATTR_ATIME_NOW (1 << 7)
 #define FUSE_SET_ATTR_MTIME_NOW (1 << 8)
 #define FUSE_SET_ATTR_CTIME (1 << 10)
+#define FUSE_SET_ATTR_KILL_PRIV (1 << 14)
 
 /*
  * Request methods and replies
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 6514674f04..33f74a1a46 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -170,6 +170,7 @@ struct lo_data {
 
     /* An O_PATH file descriptor to /proc/self/fd/ */
     int proc_self_fd;
+    int user_killpriv_v2, killpriv_v2;
 };
 
 static const struct fuse_opt lo_opts[] = {
@@ -192,6 +193,8 @@ static const struct fuse_opt lo_opts[] = {
     { "no_shared", offsetof(struct lo_data, shared), 0 },
     { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
     { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
+    { "killpriv_v2", offsetof(struct lo_data, user_killpriv_v2), 1 },
+    { "no_killpriv_v2", offsetof(struct lo_data, user_killpriv_v2), 0 },
     FUSE_OPT_END
 };
 static bool use_syslog = false;
@@ -588,6 +591,30 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
         fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling readdirplus\n");
         conn->want &= ~FUSE_CAP_READDIRPLUS;
     }
+
+    if (lo->user_killpriv_v2 == 1) {
+        /* User explicitly asked for this option. Enable it unconditionally.
+         * If connection does not have this capability, it should fail
+         * in fuse_lowlevel.c
+         */
+        fuse_log(FUSE_LOG_DEBUG, "lo_init: enabling killpriv_v2\n");
+        conn->want |= FUSE_CAP_HANDLE_KILLPRIV_V2;
+	lo->killpriv_v2 = 1;
+    } else if (lo->user_killpriv_v2 == -1 &&
+               conn->capable & FUSE_CAP_HANDLE_KILLPRIV_V2) {
+        /* User did not specify a value for killpriv_v2. By default enable it
+         * if connection offers this capability */
+        fuse_log(FUSE_LOG_DEBUG, "lo_init: enabling killpriv_v2\n");
+        conn->want |= FUSE_CAP_HANDLE_KILLPRIV_V2;
+        lo->killpriv_v2 = 1;
+    } else {
+        /* Either user specified to disable killpriv_v2, or connection does
+         * not offer this capability. Disable killpriv_v2 in both the cases
+         */
+        fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling killpriv_v2\n");
+        conn->want &= ~FUSE_CAP_HANDLE_KILLPRIV_V2;
+        lo->killpriv_v2 = 0;
+    }
 }
 
 static int64_t *version_ptr(struct lo_data *lo, struct lo_inode *inode)
@@ -686,6 +713,14 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
         uid_t uid = (valid & FUSE_SET_ATTR_UID) ? attr->st_uid : (uid_t)-1;
         gid_t gid = (valid & FUSE_SET_ATTR_GID) ? attr->st_gid : (gid_t)-1;
 
+        /* if fc->killpriv_v2 is set, change of ownership should clear
+         * suid/sgid/caps.
+         *
+         * TODO: On ext4/xfs above works with fchownat() call without
+         * doing anything extra. If there are filesystem where this
+         * does not work, virtiofsd needs to take care of this.
+         */
+
         res = fchownat(ifd, "", uid, gid, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
         if (res == -1) {
             goto out_err;
@@ -693,7 +728,18 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
     }
     if (valid & FUSE_SET_ATTR_SIZE) {
         int truncfd;
-
+        bool kill_priv = lo->killpriv_v2 && (valid & FUSE_SET_ATTR_KILL_PRIV);
+        bool cap_fsetid_dropped = false;
+
+        /* if fc->killpriv_v2 is set, change of size should clear caps
+         * always. suid should be cleared if FUSE_SETATTR_KILL_PRIV is
+         * set. And sgid should be cleared if FUSE_SETATTR_KILL_PRIV is
+         * set as well as group execute permission is on.
+         *
+         * TODO: On ext4/xfs above works with truncate() call without
+         * doing anything extra. If there are filesystem where this
+         * does not work, virtiofsd needs to take care of this.
+         */
         if (fi) {
             truncfd = fd;
         } else {
@@ -704,12 +750,26 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
             }
         }
 
+        if (kill_priv) {
+            res = drop_effective_cap("FSETID", &cap_fsetid_dropped);
+            if (res != 0) {
+                lo_inode_put(lo, &inode);
+                fuse_reply_err(req, res);
+            }
+        }
         res = ftruncate(truncfd, attr->st_size);
+        saverr = errno;
+        if (cap_fsetid_dropped) {
+            res = gain_effective_cap("FSETID");
+            if(res) {
+                fuse_log(FUSE_LOG_ERR, "Failed to gain CAP_FSETID\n");
+            }
+        }
         if (!fi) {
-            saverr = errno;
             close(truncfd);
-            errno = saverr;
         }
+
+        errno = saverr;
         if (res == -1) {
             goto out_err;
         }
@@ -1943,20 +2003,45 @@ static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
 
 static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
 {
-    int fd;
+    int fd, ret, saverr;
     ssize_t fh;
     char buf[64];
     struct lo_data *lo = lo_data(req);
+    bool cap_fsetid_dropped = false;
 
-    fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d)\n", ino,
-             fi->flags);
+    fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d, kill_priv=%d)"
+             "\n", ino, fi->flags, fi->kill_priv);
 
     update_open_flags(lo->writeback, fi);
 
     sprintf(buf, "%i", lo_fd(req, ino));
+
+    /*
+     * fi->kill_priv is set if file server opted for killpriv_v2 feature
+     * and client did open(O_TRUNC) and caller did not have CAP_FSETID.
+     * In that case suid/sgid/security.capability needs to be killed
+     * according to certain rules. Dropping capability does right thing
+     * on ext4/xfs already.
+     */
+    if (fi->kill_priv) {
+        ret = drop_effective_cap("FSETID", &cap_fsetid_dropped);
+        if (ret != 0) {
+            fuse_reply_err(req, ret);
+            return;
+        }
+    }
+
     fd = openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
+    saverr = errno;
+    if (cap_fsetid_dropped) {
+        ret = gain_effective_cap("FSETID");
+        if (ret) {
+            fuse_log(FUSE_LOG_ERR, "Failed to gain CAP_FSETID\n");
+        }
+    }
+
     if (fd == -1) {
-        return (void)fuse_reply_err(req, errno);
+        return (void)fuse_reply_err(req, saverr);
     }
 
     pthread_mutex_lock(&lo->mutex);
@@ -2091,8 +2176,20 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t ino,
     out_buf.buf[0].pos = off;
 
     fuse_log(FUSE_LOG_DEBUG,
-             "lo_write_buf(ino=%" PRIu64 ", size=%zd, off=%lu)\n", ino,
-             out_buf.buf[0].size, (unsigned long)off);
+             "lo_write_buf(ino=%" PRIu64 ", size=%zd, off=%lu kill_priv=%d)\n",
+             ino, out_buf.buf[0].size, (unsigned long)off, fi->kill_priv);
+
+    /*
+     * If lo->killpriv_v2 is set, then we are supposed to kill caps
+     * and also kill suid/sgid if fi->kill_priv is set. Current
+     * common filesystem ext4/xfs already drop security.capability
+     * on WRITE. So we don't have to do anything special.
+     *
+     * TODO: If we are running on to of a file system which does not
+     * remove caps on WRITE, then we will have to remove it ourselves
+     * explicitly. Same is true for removing SUID/SGID if CAP_FSETID
+     * is not there.
+     */
 
     /*
      * If kill_priv is set, drop CAP_FSETID which should lead to kernel
@@ -3210,6 +3307,7 @@ int main(int argc, char *argv[])
         .writeback = 0,
         .posix_lock = 1,
         .proc_self_fd = -1,
+        .user_killpriv_v2 = -1,
     };
     struct lo_map_elem *root_elem;
     int ret = -1;
-- 
2.25.4


