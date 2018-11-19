Received: from eggs.gnu.org ([2001:4830:134:3::10]:41435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gOoXW-0003JJ-Gt
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gOoXU-0003Vy-0d
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:44:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gOoXT-0003Ru-Po
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:44:51 -0500
Date: Tue, 20 Nov 2018 00:14:46 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <154226612321.706352.2726376089201743065.stgit@bahia.lan>
Message-ID: <nycvar.YSQ.7.76.1811192358020.17923@xnncv>
References: <154226612321.706352.2726376089201743065.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] 9p: take write lock on fid path updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, zhibin hu <noirfate@gmail.com>

+-- On Thu, 15 Nov 2018, Greg Kurz wrote --+
| Recent commit 5b76ef50f62079a fixed a race where v9fs_co_open2() could
| possibly overwrite a fid path with v9fs_path_copy() while it is being
| accessed by some other thread, ie, use-after-free that can be detected
| by ASAN with a custom 9p client.
| 
| It turns out that the same can happen at several locations where
| v9fs_path_copy() is used to set the fid path. The fix is again to
| take the write lock.
| 
| Cc: P J P <ppandit@redhat.com>
| Reported-by: zhibin hu <noirfate@gmail.com>
| Signed-off-by: Greg Kurz <groug@kaod.org>
| ---
|  hw/9pfs/9p.c |   15 +++++++++++++++
|  1 file changed, 15 insertions(+)
| 
| diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
| index eef289e394d4..267a25533b77 100644
| --- a/hw/9pfs/9p.c
| +++ b/hw/9pfs/9p.c
| @@ -1391,7 +1391,9 @@ static void coroutine_fn v9fs_walk(void *opaque)
|              err = -EINVAL;
|              goto out;
|          }
| +        v9fs_path_write_lock(s);
|          v9fs_path_copy(&fidp->path, &path);
| +        v9fs_path_unlock(s);
|      } else {
|          newfidp = alloc_fid(s, newfid);
|          if (newfidp == NULL) {
| @@ -2160,6 +2162,7 @@ static void coroutine_fn v9fs_create(void *opaque)
|      V9fsString extension;
|      int iounit;
|      V9fsPDU *pdu = opaque;
| +    V9fsState *s = pdu->s;
|  
|      v9fs_path_init(&path);
|      v9fs_string_init(&name);
| @@ -2200,7 +2203,9 @@ static void coroutine_fn v9fs_create(void *opaque)
|          if (err < 0) {
|              goto out;
|          }
| +        v9fs_path_write_lock(s);
|          v9fs_path_copy(&fidp->path, &path);
| +        v9fs_path_unlock(s);
|          err = v9fs_co_opendir(pdu, fidp);
|          if (err < 0) {
|              goto out;
| @@ -2216,7 +2221,9 @@ static void coroutine_fn v9fs_create(void *opaque)
|          if (err < 0) {
|              goto out;
|          }
| +        v9fs_path_write_lock(s);
|          v9fs_path_copy(&fidp->path, &path);
| +        v9fs_path_unlock(s);
|      } else if (perm & P9_STAT_MODE_LINK) {
|          int32_t ofid = atoi(extension.data);
|          V9fsFidState *ofidp = get_fid(pdu, ofid);
| @@ -2234,7 +2241,9 @@ static void coroutine_fn v9fs_create(void *opaque)
|              fidp->fid_type = P9_FID_NONE;
|              goto out;
|          }
| +        v9fs_path_write_lock(s);
|          v9fs_path_copy(&fidp->path, &path);
| +        v9fs_path_unlock(s);
|          err = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
|          if (err < 0) {
|              fidp->fid_type = P9_FID_NONE;
| @@ -2272,7 +2281,9 @@ static void coroutine_fn v9fs_create(void *opaque)
|          if (err < 0) {
|              goto out;
|          }
| +        v9fs_path_write_lock(s);
|          v9fs_path_copy(&fidp->path, &path);
| +        v9fs_path_unlock(s);
|      } else if (perm & P9_STAT_MODE_NAMED_PIPE) {
|          err = v9fs_co_mknod(pdu, fidp, &name, fidp->uid, -1,
|                              0, S_IFIFO | (perm & 0777), &stbuf);
| @@ -2283,7 +2294,9 @@ static void coroutine_fn v9fs_create(void *opaque)
|          if (err < 0) {
|              goto out;
|          }
| +        v9fs_path_write_lock(s);
|          v9fs_path_copy(&fidp->path, &path);
| +        v9fs_path_unlock(s);
|      } else if (perm & P9_STAT_MODE_SOCKET) {
|          err = v9fs_co_mknod(pdu, fidp, &name, fidp->uid, -1,
|                              0, S_IFSOCK | (perm & 0777), &stbuf);
| @@ -2294,7 +2307,9 @@ static void coroutine_fn v9fs_create(void *opaque)
|          if (err < 0) {
|              goto out;
|          }
| +        v9fs_path_write_lock(s);
|          v9fs_path_copy(&fidp->path, &path);
| +        v9fs_path_unlock(s);
|      } else {
|          err = v9fs_co_open2(pdu, fidp, &name, -1,
|                              omode_to_uflags(mode)|O_CREAT, perm, &stbuf);
| 

Looks okay.
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
