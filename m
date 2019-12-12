Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C93C00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA87A22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mch92OSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA87A22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRWx-00070Q-2Y
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUo-0004o1-6s
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUk-0000kH-Jv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRUk-0000in-E4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JzN9sNvOHSiz/JRxL+DvuNd4yNQ0lyac/TBSEh9c/JE=;
 b=Mch92OSyxBmfZHqijjEz6WvONBjfPvZGl4Fr2y1tSrDVpj9LE6ZMo6Z9ykfDM9Kx9jXYhB
 AIPyNczGo/bN9BO6+TXBNhELi4a42OSSTsGZoKnHzXFwDv7TV7UyhfgfVByM1B4nv+5hQr
 uVwsRmfLOEEi5+wTqFBa2GhFU1MFAJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-18d-ZhedOo-sYubwuv2VFw-1; Thu, 12 Dec 2019 11:39:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19E371800D63
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:14 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41FAF60BE1;
 Thu, 12 Dec 2019 16:39:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 002/104] virtiofsd: Pull in kernel's fuse.h
Date: Thu, 12 Dec 2019 16:37:22 +0000
Message-Id: <20191212163904.159893-3-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 18d-ZhedOo-sYubwuv2VFw-1
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Update scripts/update-linux-headers.sh to add fuse.h and
use it to pull in fuse.h from the kernel; from v5.5-rc1

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/standard-headers/linux/fuse.h | 891 ++++++++++++++++++++++++++
 scripts/update-linux-headers.sh       |   1 +
 2 files changed, 892 insertions(+)
 create mode 100644 include/standard-headers/linux/fuse.h

diff --git a/include/standard-headers/linux/fuse.h b/include/standard-heade=
rs/linux/fuse.h
new file mode 100644
index 0000000000..f4df0a40f6
--- /dev/null
+++ b/include/standard-headers/linux/fuse.h
@@ -0,0 +1,891 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Cl=
ause) */
+/*
+    This file defines the kernel interface of FUSE
+    Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
+
+    This program can be distributed under the terms of the GNU GPL.
+    See the file COPYING.
+
+    This -- and only this -- header file may also be distributed under
+    the terms of the BSD Licence as follows:
+
+    Copyright (C) 2001-2007 Miklos Szeredi. All rights reserved.
+
+    Redistribution and use in source and binary forms, with or without
+    modification, are permitted provided that the following conditions
+    are met:
+    1. Redistributions of source code must retain the above copyright
+       notice, this list of conditions and the following disclaimer.
+    2. Redistributions in binary form must reproduce the above copyright
+       notice, this list of conditions and the following disclaimer in the
+       documentation and/or other materials provided with the distribution=
.
+
+    THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
+    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PUR=
POSE
+    ARE DISCLAIMED.  IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
+    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUEN=
TIAL
+    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOOD=
S
+    OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, ST=
RICT
+    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY =
WAY
+    OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+    SUCH DAMAGE.
+*/
+
+/*
+ * This file defines the kernel interface of FUSE
+ *
+ * Protocol changelog:
+ *
+ * 7.1:
+ *  - add the following messages:
+ *      FUSE_SETATTR, FUSE_SYMLINK, FUSE_MKNOD, FUSE_MKDIR, FUSE_UNLINK,
+ *      FUSE_RMDIR, FUSE_RENAME, FUSE_LINK, FUSE_OPEN, FUSE_READ, FUSE_WRI=
TE,
+ *      FUSE_RELEASE, FUSE_FSYNC, FUSE_FLUSH, FUSE_SETXATTR, FUSE_GETXATTR=
,
+ *      FUSE_LISTXATTR, FUSE_REMOVEXATTR, FUSE_OPENDIR, FUSE_READDIR,
+ *      FUSE_RELEASEDIR
+ *  - add padding to messages to accommodate 32-bit servers on 64-bit kern=
els
+ *
+ * 7.2:
+ *  - add FOPEN_DIRECT_IO and FOPEN_KEEP_CACHE flags
+ *  - add FUSE_FSYNCDIR message
+ *
+ * 7.3:
+ *  - add FUSE_ACCESS message
+ *  - add FUSE_CREATE message
+ *  - add filehandle to fuse_setattr_in
+ *
+ * 7.4:
+ *  - add frsize to fuse_kstatfs
+ *  - clean up request size limit checking
+ *
+ * 7.5:
+ *  - add flags and max_write to fuse_init_out
+ *
+ * 7.6:
+ *  - add max_readahead to fuse_init_in and fuse_init_out
+ *
+ * 7.7:
+ *  - add FUSE_INTERRUPT message
+ *  - add POSIX file lock support
+ *
+ * 7.8:
+ *  - add lock_owner and flags fields to fuse_release_in
+ *  - add FUSE_BMAP message
+ *  - add FUSE_DESTROY message
+ *
+ * 7.9:
+ *  - new fuse_getattr_in input argument of GETATTR
+ *  - add lk_flags in fuse_lk_in
+ *  - add lock_owner field to fuse_setattr_in, fuse_read_in and fuse_write=
_in
+ *  - add blksize field to fuse_attr
+ *  - add file flags field to fuse_read_in and fuse_write_in
+ *  - Add ATIME_NOW and MTIME_NOW flags to fuse_setattr_in
+ *
+ * 7.10
+ *  - add nonseekable open flag
+ *
+ * 7.11
+ *  - add IOCTL message
+ *  - add unsolicited notification support
+ *  - add POLL message and NOTIFY_POLL notification
+ *
+ * 7.12
+ *  - add umask flag to input argument of create, mknod and mkdir
+ *  - add notification messages for invalidation of inodes and
+ *    directory entries
+ *
+ * 7.13
+ *  - make max number of background requests and congestion threshold
+ *    tunables
+ *
+ * 7.14
+ *  - add splice support to fuse device
+ *
+ * 7.15
+ *  - add store notify
+ *  - add retrieve notify
+ *
+ * 7.16
+ *  - add BATCH_FORGET request
+ *  - FUSE_IOCTL_UNRESTRICTED shall now return with array of 'struct
+ *    fuse_ioctl_iovec' instead of ambiguous 'struct iovec'
+ *  - add FUSE_IOCTL_32BIT flag
+ *
+ * 7.17
+ *  - add FUSE_FLOCK_LOCKS and FUSE_RELEASE_FLOCK_UNLOCK
+ *
+ * 7.18
+ *  - add FUSE_IOCTL_DIR flag
+ *  - add FUSE_NOTIFY_DELETE
+ *
+ * 7.19
+ *  - add FUSE_FALLOCATE
+ *
+ * 7.20
+ *  - add FUSE_AUTO_INVAL_DATA
+ *
+ * 7.21
+ *  - add FUSE_READDIRPLUS
+ *  - send the requested events in POLL request
+ *
+ * 7.22
+ *  - add FUSE_ASYNC_DIO
+ *
+ * 7.23
+ *  - add FUSE_WRITEBACK_CACHE
+ *  - add time_gran to fuse_init_out
+ *  - add reserved space to fuse_init_out
+ *  - add FATTR_CTIME
+ *  - add ctime and ctimensec to fuse_setattr_in
+ *  - add FUSE_RENAME2 request
+ *  - add FUSE_NO_OPEN_SUPPORT flag
+ *
+ *  7.24
+ *  - add FUSE_LSEEK for SEEK_HOLE and SEEK_DATA support
+ *
+ *  7.25
+ *  - add FUSE_PARALLEL_DIROPS
+ *
+ *  7.26
+ *  - add FUSE_HANDLE_KILLPRIV
+ *  - add FUSE_POSIX_ACL
+ *
+ *  7.27
+ *  - add FUSE_ABORT_ERROR
+ *
+ *  7.28
+ *  - add FUSE_COPY_FILE_RANGE
+ *  - add FOPEN_CACHE_DIR
+ *  - add FUSE_MAX_PAGES, add max_pages to init_out
+ *  - add FUSE_CACHE_SYMLINKS
+ *
+ *  7.29
+ *  - add FUSE_NO_OPENDIR_SUPPORT flag
+ *
+ *  7.30
+ *  - add FUSE_EXPLICIT_INVAL_DATA
+ *  - add FUSE_IOCTL_COMPAT_X32
+ *
+ *  7.31
+ *  - add FUSE_WRITE_KILL_PRIV flag
+ *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
+ *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ */
+
+#ifndef _LINUX_FUSE_H
+#define _LINUX_FUSE_H
+
+#include <stdint.h>
+
+/*
+ * Version negotiation:
+ *
+ * Both the kernel and userspace send the version they support in the
+ * INIT request and reply respectively.
+ *
+ * If the major versions match then both shall use the smallest
+ * of the two minor versions for communication.
+ *
+ * If the kernel supports a larger major version, then userspace shall
+ * reply with the major version it supports, ignore the rest of the
+ * INIT message and expect a new INIT message from the kernel with a
+ * matching major version.
+ *
+ * If the library supports a larger major version, then it shall fall
+ * back to the major protocol version sent by the kernel for
+ * communication and reply with that major version (and an arbitrary
+ * supported minor version).
+ */
+
+/** Version number of this interface */
+#define FUSE_KERNEL_VERSION 7
+
+/** Minor version number of this interface */
+#define FUSE_KERNEL_MINOR_VERSION 31
+
+/** The node ID of the root inode */
+#define FUSE_ROOT_ID 1
+
+/* Make sure all structures are padded to 64bit boundary, so 32bit
+   userspace works under 64bit kernels */
+
+struct fuse_attr {
+=09uint64_t=09ino;
+=09uint64_t=09size;
+=09uint64_t=09blocks;
+=09uint64_t=09atime;
+=09uint64_t=09mtime;
+=09uint64_t=09ctime;
+=09uint32_t=09atimensec;
+=09uint32_t=09mtimensec;
+=09uint32_t=09ctimensec;
+=09uint32_t=09mode;
+=09uint32_t=09nlink;
+=09uint32_t=09uid;
+=09uint32_t=09gid;
+=09uint32_t=09rdev;
+=09uint32_t=09blksize;
+=09uint32_t=09padding;
+};
+
+struct fuse_kstatfs {
+=09uint64_t=09blocks;
+=09uint64_t=09bfree;
+=09uint64_t=09bavail;
+=09uint64_t=09files;
+=09uint64_t=09ffree;
+=09uint32_t=09bsize;
+=09uint32_t=09namelen;
+=09uint32_t=09frsize;
+=09uint32_t=09padding;
+=09uint32_t=09spare[6];
+};
+
+struct fuse_file_lock {
+=09uint64_t=09start;
+=09uint64_t=09end;
+=09uint32_t=09type;
+=09uint32_t=09pid; /* tgid */
+};
+
+/**
+ * Bitmasks for fuse_setattr_in.valid
+ */
+#define FATTR_MODE=09(1 << 0)
+#define FATTR_UID=09(1 << 1)
+#define FATTR_GID=09(1 << 2)
+#define FATTR_SIZE=09(1 << 3)
+#define FATTR_ATIME=09(1 << 4)
+#define FATTR_MTIME=09(1 << 5)
+#define FATTR_FH=09(1 << 6)
+#define FATTR_ATIME_NOW=09(1 << 7)
+#define FATTR_MTIME_NOW=09(1 << 8)
+#define FATTR_LOCKOWNER=09(1 << 9)
+#define FATTR_CTIME=09(1 << 10)
+
+/**
+ * Flags returned by the OPEN request
+ *
+ * FOPEN_DIRECT_IO: bypass page cache for this open file
+ * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
+ * FOPEN_NONSEEKABLE: the file is not seekable
+ * FOPEN_CACHE_DIR: allow caching this directory
+ * FOPEN_STREAM: the file is stream-like (no file position at all)
+ */
+#define FOPEN_DIRECT_IO=09=09(1 << 0)
+#define FOPEN_KEEP_CACHE=09(1 << 1)
+#define FOPEN_NONSEEKABLE=09(1 << 2)
+#define FOPEN_CACHE_DIR=09=09(1 << 3)
+#define FOPEN_STREAM=09=09(1 << 4)
+
+/**
+ * INIT request/reply flags
+ *
+ * FUSE_ASYNC_READ: asynchronous read requests
+ * FUSE_POSIX_LOCKS: remote locking for POSIX file locks
+ * FUSE_FILE_OPS: kernel sends file handle for fstat, etc... (not yet supp=
orted)
+ * FUSE_ATOMIC_O_TRUNC: handles the O_TRUNC open flag in the filesystem
+ * FUSE_EXPORT_SUPPORT: filesystem handles lookups of "." and ".."
+ * FUSE_BIG_WRITES: filesystem can handle write size larger than 4kB
+ * FUSE_DONT_MASK: don't apply umask to file mode on create operations
+ * FUSE_SPLICE_WRITE: kernel supports splice write on the device
+ * FUSE_SPLICE_MOVE: kernel supports splice move on the device
+ * FUSE_SPLICE_READ: kernel supports splice read on the device
+ * FUSE_FLOCK_LOCKS: remote locking for BSD style file locks
+ * FUSE_HAS_IOCTL_DIR: kernel supports ioctl on directories
+ * FUSE_AUTO_INVAL_DATA: automatically invalidate cached pages
+ * FUSE_DO_READDIRPLUS: do READDIRPLUS (READDIR+LOOKUP in one)
+ * FUSE_READDIRPLUS_AUTO: adaptive readdirplus
+ * FUSE_ASYNC_DIO: asynchronous direct I/O submission
+ * FUSE_WRITEBACK_CACHE: use writeback cache for buffered writes
+ * FUSE_NO_OPEN_SUPPORT: kernel supports zero-message opens
+ * FUSE_PARALLEL_DIROPS: allow parallel lookups and readdir
+ * FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on write/chown/t=
runc
+ * FUSE_POSIX_ACL: filesystem supports posix acls
+ * FUSE_ABORT_ERROR: reading the device after abort returns ECONNABORTED
+ * FUSE_MAX_PAGES: init_out.max_pages contains the max number of req pages
+ * FUSE_CACHE_SYMLINKS: cache READLINK responses
+ * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
+ * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit requ=
est
+ * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ */
+#define FUSE_ASYNC_READ=09=09(1 << 0)
+#define FUSE_POSIX_LOCKS=09(1 << 1)
+#define FUSE_FILE_OPS=09=09(1 << 2)
+#define FUSE_ATOMIC_O_TRUNC=09(1 << 3)
+#define FUSE_EXPORT_SUPPORT=09(1 << 4)
+#define FUSE_BIG_WRITES=09=09(1 << 5)
+#define FUSE_DONT_MASK=09=09(1 << 6)
+#define FUSE_SPLICE_WRITE=09(1 << 7)
+#define FUSE_SPLICE_MOVE=09(1 << 8)
+#define FUSE_SPLICE_READ=09(1 << 9)
+#define FUSE_FLOCK_LOCKS=09(1 << 10)
+#define FUSE_HAS_IOCTL_DIR=09(1 << 11)
+#define FUSE_AUTO_INVAL_DATA=09(1 << 12)
+#define FUSE_DO_READDIRPLUS=09(1 << 13)
+#define FUSE_READDIRPLUS_AUTO=09(1 << 14)
+#define FUSE_ASYNC_DIO=09=09(1 << 15)
+#define FUSE_WRITEBACK_CACHE=09(1 << 16)
+#define FUSE_NO_OPEN_SUPPORT=09(1 << 17)
+#define FUSE_PARALLEL_DIROPS    (1 << 18)
+#define FUSE_HANDLE_KILLPRIV=09(1 << 19)
+#define FUSE_POSIX_ACL=09=09(1 << 20)
+#define FUSE_ABORT_ERROR=09(1 << 21)
+#define FUSE_MAX_PAGES=09=09(1 << 22)
+#define FUSE_CACHE_SYMLINKS=09(1 << 23)
+#define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
+#define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
+#define FUSE_MAP_ALIGNMENT=09(1 << 26)
+
+/**
+ * CUSE INIT request/reply flags
+ *
+ * CUSE_UNRESTRICTED_IOCTL:  use unrestricted ioctl
+ */
+#define CUSE_UNRESTRICTED_IOCTL=09(1 << 0)
+
+/**
+ * Release flags
+ */
+#define FUSE_RELEASE_FLUSH=09(1 << 0)
+#define FUSE_RELEASE_FLOCK_UNLOCK=09(1 << 1)
+
+/**
+ * Getattr flags
+ */
+#define FUSE_GETATTR_FH=09=09(1 << 0)
+
+/**
+ * Lock flags
+ */
+#define FUSE_LK_FLOCK=09=09(1 << 0)
+
+/**
+ * WRITE flags
+ *
+ * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
+ * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
+ * FUSE_WRITE_KILL_PRIV: kill suid and sgid bits
+ */
+#define FUSE_WRITE_CACHE=09(1 << 0)
+#define FUSE_WRITE_LOCKOWNER=09(1 << 1)
+#define FUSE_WRITE_KILL_PRIV=09(1 << 2)
+
+/**
+ * Read flags
+ */
+#define FUSE_READ_LOCKOWNER=09(1 << 1)
+
+/**
+ * Ioctl flags
+ *
+ * FUSE_IOCTL_COMPAT: 32bit compat ioctl on 64bit machine
+ * FUSE_IOCTL_UNRESTRICTED: not restricted to well-formed ioctls, retry al=
lowed
+ * FUSE_IOCTL_RETRY: retry with new iovecs
+ * FUSE_IOCTL_32BIT: 32bit ioctl
+ * FUSE_IOCTL_DIR: is a directory
+ * FUSE_IOCTL_COMPAT_X32: x32 compat ioctl on 64bit machine (64bit time_t)
+ *
+ * FUSE_IOCTL_MAX_IOV: maximum of in_iovecs + out_iovecs
+ */
+#define FUSE_IOCTL_COMPAT=09(1 << 0)
+#define FUSE_IOCTL_UNRESTRICTED=09(1 << 1)
+#define FUSE_IOCTL_RETRY=09(1 << 2)
+#define FUSE_IOCTL_32BIT=09(1 << 3)
+#define FUSE_IOCTL_DIR=09=09(1 << 4)
+#define FUSE_IOCTL_COMPAT_X32=09(1 << 5)
+
+#define FUSE_IOCTL_MAX_IOV=09256
+
+/**
+ * Poll flags
+ *
+ * FUSE_POLL_SCHEDULE_NOTIFY: request poll notify
+ */
+#define FUSE_POLL_SCHEDULE_NOTIFY (1 << 0)
+
+/**
+ * Fsync flags
+ *
+ * FUSE_FSYNC_FDATASYNC: Sync data only, not metadata
+ */
+#define FUSE_FSYNC_FDATASYNC=09(1 << 0)
+
+enum fuse_opcode {
+=09FUSE_LOOKUP=09=09=3D 1,
+=09FUSE_FORGET=09=09=3D 2,  /* no reply */
+=09FUSE_GETATTR=09=09=3D 3,
+=09FUSE_SETATTR=09=09=3D 4,
+=09FUSE_READLINK=09=09=3D 5,
+=09FUSE_SYMLINK=09=09=3D 6,
+=09FUSE_MKNOD=09=09=3D 8,
+=09FUSE_MKDIR=09=09=3D 9,
+=09FUSE_UNLINK=09=09=3D 10,
+=09FUSE_RMDIR=09=09=3D 11,
+=09FUSE_RENAME=09=09=3D 12,
+=09FUSE_LINK=09=09=3D 13,
+=09FUSE_OPEN=09=09=3D 14,
+=09FUSE_READ=09=09=3D 15,
+=09FUSE_WRITE=09=09=3D 16,
+=09FUSE_STATFS=09=09=3D 17,
+=09FUSE_RELEASE=09=09=3D 18,
+=09FUSE_FSYNC=09=09=3D 20,
+=09FUSE_SETXATTR=09=09=3D 21,
+=09FUSE_GETXATTR=09=09=3D 22,
+=09FUSE_LISTXATTR=09=09=3D 23,
+=09FUSE_REMOVEXATTR=09=3D 24,
+=09FUSE_FLUSH=09=09=3D 25,
+=09FUSE_INIT=09=09=3D 26,
+=09FUSE_OPENDIR=09=09=3D 27,
+=09FUSE_READDIR=09=09=3D 28,
+=09FUSE_RELEASEDIR=09=09=3D 29,
+=09FUSE_FSYNCDIR=09=09=3D 30,
+=09FUSE_GETLK=09=09=3D 31,
+=09FUSE_SETLK=09=09=3D 32,
+=09FUSE_SETLKW=09=09=3D 33,
+=09FUSE_ACCESS=09=09=3D 34,
+=09FUSE_CREATE=09=09=3D 35,
+=09FUSE_INTERRUPT=09=09=3D 36,
+=09FUSE_BMAP=09=09=3D 37,
+=09FUSE_DESTROY=09=09=3D 38,
+=09FUSE_IOCTL=09=09=3D 39,
+=09FUSE_POLL=09=09=3D 40,
+=09FUSE_NOTIFY_REPLY=09=3D 41,
+=09FUSE_BATCH_FORGET=09=3D 42,
+=09FUSE_FALLOCATE=09=09=3D 43,
+=09FUSE_READDIRPLUS=09=3D 44,
+=09FUSE_RENAME2=09=09=3D 45,
+=09FUSE_LSEEK=09=09=3D 46,
+=09FUSE_COPY_FILE_RANGE=09=3D 47,
+=09FUSE_SETUPMAPPING=09=3D 48,
+=09FUSE_REMOVEMAPPING=09=3D 49,
+
+=09/* CUSE specific operations */
+=09CUSE_INIT=09=09=3D 4096,
+
+=09/* Reserved opcodes: helpful to detect structure endian-ness */
+=09CUSE_INIT_BSWAP_RESERVED=09=3D 1048576,=09/* CUSE_INIT << 8 */
+=09FUSE_INIT_BSWAP_RESERVED=09=3D 436207616,=09/* FUSE_INIT << 24 */
+};
+
+enum fuse_notify_code {
+=09FUSE_NOTIFY_POLL   =3D 1,
+=09FUSE_NOTIFY_INVAL_INODE =3D 2,
+=09FUSE_NOTIFY_INVAL_ENTRY =3D 3,
+=09FUSE_NOTIFY_STORE =3D 4,
+=09FUSE_NOTIFY_RETRIEVE =3D 5,
+=09FUSE_NOTIFY_DELETE =3D 6,
+=09FUSE_NOTIFY_CODE_MAX,
+};
+
+/* The read buffer is required to be at least 8k, but may be much larger *=
/
+#define FUSE_MIN_READ_BUFFER 8192
+
+#define FUSE_COMPAT_ENTRY_OUT_SIZE 120
+
+struct fuse_entry_out {
+=09uint64_t=09nodeid;=09=09/* Inode ID */
+=09uint64_t=09generation;=09/* Inode generation: nodeid:gen must
+=09=09=09=09=09   be unique for the fs's lifetime */
+=09uint64_t=09entry_valid;=09/* Cache timeout for the name */
+=09uint64_t=09attr_valid;=09/* Cache timeout for the attributes */
+=09uint32_t=09entry_valid_nsec;
+=09uint32_t=09attr_valid_nsec;
+=09struct fuse_attr attr;
+};
+
+struct fuse_forget_in {
+=09uint64_t=09nlookup;
+};
+
+struct fuse_forget_one {
+=09uint64_t=09nodeid;
+=09uint64_t=09nlookup;
+};
+
+struct fuse_batch_forget_in {
+=09uint32_t=09count;
+=09uint32_t=09dummy;
+};
+
+struct fuse_getattr_in {
+=09uint32_t=09getattr_flags;
+=09uint32_t=09dummy;
+=09uint64_t=09fh;
+};
+
+#define FUSE_COMPAT_ATTR_OUT_SIZE 96
+
+struct fuse_attr_out {
+=09uint64_t=09attr_valid;=09/* Cache timeout for the attributes */
+=09uint32_t=09attr_valid_nsec;
+=09uint32_t=09dummy;
+=09struct fuse_attr attr;
+};
+
+#define FUSE_COMPAT_MKNOD_IN_SIZE 8
+
+struct fuse_mknod_in {
+=09uint32_t=09mode;
+=09uint32_t=09rdev;
+=09uint32_t=09umask;
+=09uint32_t=09padding;
+};
+
+struct fuse_mkdir_in {
+=09uint32_t=09mode;
+=09uint32_t=09umask;
+};
+
+struct fuse_rename_in {
+=09uint64_t=09newdir;
+};
+
+struct fuse_rename2_in {
+=09uint64_t=09newdir;
+=09uint32_t=09flags;
+=09uint32_t=09padding;
+};
+
+struct fuse_link_in {
+=09uint64_t=09oldnodeid;
+};
+
+struct fuse_setattr_in {
+=09uint32_t=09valid;
+=09uint32_t=09padding;
+=09uint64_t=09fh;
+=09uint64_t=09size;
+=09uint64_t=09lock_owner;
+=09uint64_t=09atime;
+=09uint64_t=09mtime;
+=09uint64_t=09ctime;
+=09uint32_t=09atimensec;
+=09uint32_t=09mtimensec;
+=09uint32_t=09ctimensec;
+=09uint32_t=09mode;
+=09uint32_t=09unused4;
+=09uint32_t=09uid;
+=09uint32_t=09gid;
+=09uint32_t=09unused5;
+};
+
+struct fuse_open_in {
+=09uint32_t=09flags;
+=09uint32_t=09unused;
+};
+
+struct fuse_create_in {
+=09uint32_t=09flags;
+=09uint32_t=09mode;
+=09uint32_t=09umask;
+=09uint32_t=09padding;
+};
+
+struct fuse_open_out {
+=09uint64_t=09fh;
+=09uint32_t=09open_flags;
+=09uint32_t=09padding;
+};
+
+struct fuse_release_in {
+=09uint64_t=09fh;
+=09uint32_t=09flags;
+=09uint32_t=09release_flags;
+=09uint64_t=09lock_owner;
+};
+
+struct fuse_flush_in {
+=09uint64_t=09fh;
+=09uint32_t=09unused;
+=09uint32_t=09padding;
+=09uint64_t=09lock_owner;
+};
+
+struct fuse_read_in {
+=09uint64_t=09fh;
+=09uint64_t=09offset;
+=09uint32_t=09size;
+=09uint32_t=09read_flags;
+=09uint64_t=09lock_owner;
+=09uint32_t=09flags;
+=09uint32_t=09padding;
+};
+
+#define FUSE_COMPAT_WRITE_IN_SIZE 24
+
+struct fuse_write_in {
+=09uint64_t=09fh;
+=09uint64_t=09offset;
+=09uint32_t=09size;
+=09uint32_t=09write_flags;
+=09uint64_t=09lock_owner;
+=09uint32_t=09flags;
+=09uint32_t=09padding;
+};
+
+struct fuse_write_out {
+=09uint32_t=09size;
+=09uint32_t=09padding;
+};
+
+#define FUSE_COMPAT_STATFS_SIZE 48
+
+struct fuse_statfs_out {
+=09struct fuse_kstatfs st;
+};
+
+struct fuse_fsync_in {
+=09uint64_t=09fh;
+=09uint32_t=09fsync_flags;
+=09uint32_t=09padding;
+};
+
+struct fuse_setxattr_in {
+=09uint32_t=09size;
+=09uint32_t=09flags;
+};
+
+struct fuse_getxattr_in {
+=09uint32_t=09size;
+=09uint32_t=09padding;
+};
+
+struct fuse_getxattr_out {
+=09uint32_t=09size;
+=09uint32_t=09padding;
+};
+
+struct fuse_lk_in {
+=09uint64_t=09fh;
+=09uint64_t=09owner;
+=09struct fuse_file_lock lk;
+=09uint32_t=09lk_flags;
+=09uint32_t=09padding;
+};
+
+struct fuse_lk_out {
+=09struct fuse_file_lock lk;
+};
+
+struct fuse_access_in {
+=09uint32_t=09mask;
+=09uint32_t=09padding;
+};
+
+struct fuse_init_in {
+=09uint32_t=09major;
+=09uint32_t=09minor;
+=09uint32_t=09max_readahead;
+=09uint32_t=09flags;
+};
+
+#define FUSE_COMPAT_INIT_OUT_SIZE 8
+#define FUSE_COMPAT_22_INIT_OUT_SIZE 24
+
+struct fuse_init_out {
+=09uint32_t=09major;
+=09uint32_t=09minor;
+=09uint32_t=09max_readahead;
+=09uint32_t=09flags;
+=09uint16_t=09max_background;
+=09uint16_t=09congestion_threshold;
+=09uint32_t=09max_write;
+=09uint32_t=09time_gran;
+=09uint16_t=09max_pages;
+=09uint16_t=09map_alignment;
+=09uint32_t=09unused[8];
+};
+
+#define CUSE_INIT_INFO_MAX 4096
+
+struct cuse_init_in {
+=09uint32_t=09major;
+=09uint32_t=09minor;
+=09uint32_t=09unused;
+=09uint32_t=09flags;
+};
+
+struct cuse_init_out {
+=09uint32_t=09major;
+=09uint32_t=09minor;
+=09uint32_t=09unused;
+=09uint32_t=09flags;
+=09uint32_t=09max_read;
+=09uint32_t=09max_write;
+=09uint32_t=09dev_major;=09=09/* chardev major */
+=09uint32_t=09dev_minor;=09=09/* chardev minor */
+=09uint32_t=09spare[10];
+};
+
+struct fuse_interrupt_in {
+=09uint64_t=09unique;
+};
+
+struct fuse_bmap_in {
+=09uint64_t=09block;
+=09uint32_t=09blocksize;
+=09uint32_t=09padding;
+};
+
+struct fuse_bmap_out {
+=09uint64_t=09block;
+};
+
+struct fuse_ioctl_in {
+=09uint64_t=09fh;
+=09uint32_t=09flags;
+=09uint32_t=09cmd;
+=09uint64_t=09arg;
+=09uint32_t=09in_size;
+=09uint32_t=09out_size;
+};
+
+struct fuse_ioctl_iovec {
+=09uint64_t=09base;
+=09uint64_t=09len;
+};
+
+struct fuse_ioctl_out {
+=09int32_t=09=09result;
+=09uint32_t=09flags;
+=09uint32_t=09in_iovs;
+=09uint32_t=09out_iovs;
+};
+
+struct fuse_poll_in {
+=09uint64_t=09fh;
+=09uint64_t=09kh;
+=09uint32_t=09flags;
+=09uint32_t=09events;
+};
+
+struct fuse_poll_out {
+=09uint32_t=09revents;
+=09uint32_t=09padding;
+};
+
+struct fuse_notify_poll_wakeup_out {
+=09uint64_t=09kh;
+};
+
+struct fuse_fallocate_in {
+=09uint64_t=09fh;
+=09uint64_t=09offset;
+=09uint64_t=09length;
+=09uint32_t=09mode;
+=09uint32_t=09padding;
+};
+
+struct fuse_in_header {
+=09uint32_t=09len;
+=09uint32_t=09opcode;
+=09uint64_t=09unique;
+=09uint64_t=09nodeid;
+=09uint32_t=09uid;
+=09uint32_t=09gid;
+=09uint32_t=09pid;
+=09uint32_t=09padding;
+};
+
+struct fuse_out_header {
+=09uint32_t=09len;
+=09int32_t=09=09error;
+=09uint64_t=09unique;
+};
+
+struct fuse_dirent {
+=09uint64_t=09ino;
+=09uint64_t=09off;
+=09uint32_t=09namelen;
+=09uint32_t=09type;
+=09char name[];
+};
+
+#define FUSE_NAME_OFFSET offsetof(struct fuse_dirent, name)
+#define FUSE_DIRENT_ALIGN(x) \
+=09(((x) + sizeof(uint64_t) - 1) & ~(sizeof(uint64_t) - 1))
+#define FUSE_DIRENT_SIZE(d) \
+=09FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET + (d)->namelen)
+
+struct fuse_direntplus {
+=09struct fuse_entry_out entry_out;
+=09struct fuse_dirent dirent;
+};
+
+#define FUSE_NAME_OFFSET_DIRENTPLUS \
+=09offsetof(struct fuse_direntplus, dirent.name)
+#define FUSE_DIRENTPLUS_SIZE(d) \
+=09FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET_DIRENTPLUS + (d)->dirent.namelen)
+
+struct fuse_notify_inval_inode_out {
+=09uint64_t=09ino;
+=09int64_t=09=09off;
+=09int64_t=09=09len;
+};
+
+struct fuse_notify_inval_entry_out {
+=09uint64_t=09parent;
+=09uint32_t=09namelen;
+=09uint32_t=09padding;
+};
+
+struct fuse_notify_delete_out {
+=09uint64_t=09parent;
+=09uint64_t=09child;
+=09uint32_t=09namelen;
+=09uint32_t=09padding;
+};
+
+struct fuse_notify_store_out {
+=09uint64_t=09nodeid;
+=09uint64_t=09offset;
+=09uint32_t=09size;
+=09uint32_t=09padding;
+};
+
+struct fuse_notify_retrieve_out {
+=09uint64_t=09notify_unique;
+=09uint64_t=09nodeid;
+=09uint64_t=09offset;
+=09uint32_t=09size;
+=09uint32_t=09padding;
+};
+
+/* Matches the size of fuse_write_in */
+struct fuse_notify_retrieve_in {
+=09uint64_t=09dummy1;
+=09uint64_t=09offset;
+=09uint32_t=09size;
+=09uint32_t=09dummy2;
+=09uint64_t=09dummy3;
+=09uint64_t=09dummy4;
+};
+
+/* Device ioctls: */
+#define FUSE_DEV_IOC_CLONE=09_IOR(229, 0, uint32_t)
+
+struct fuse_lseek_in {
+=09uint64_t=09fh;
+=09uint64_t=09offset;
+=09uint32_t=09whence;
+=09uint32_t=09padding;
+};
+
+struct fuse_lseek_out {
+=09uint64_t=09offset;
+};
+
+struct fuse_copy_file_range_in {
+=09uint64_t=09fh_in;
+=09uint64_t=09off_in;
+=09uint64_t=09nodeid_out;
+=09uint64_t=09fh_out;
+=09uint64_t=09off_out;
+=09uint64_t=09len;
+=09uint64_t=09flags;
+};
+
+#endif /* _LINUX_FUSE_H */
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers=
.sh
index f76d77363b..29c27f4681 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -186,6 +186,7 @@ rm -rf "$output/include/standard-headers/linux"
 mkdir -p "$output/include/standard-headers/linux"
 for i in "$tmpdir"/include/linux/*virtio*.h \
          "$tmpdir/include/linux/qemu_fw_cfg.h" \
+         "$tmpdir/include/linux/fuse.h" \
          "$tmpdir/include/linux/input.h" \
          "$tmpdir/include/linux/input-event-codes.h" \
          "$tmpdir/include/linux/pci_regs.h" \
--=20
2.23.0


