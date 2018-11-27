Received: from eggs.gnu.org ([2001:4830:134:3::10]:46819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfg-0002bY-Hf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZff-0004S1-OW
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZff-0004Rm-Hf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:38 +0400
Message-Id: <20181127092801.21777-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 05/28] 9p: fix QEMU crash when
 renaming files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Greg Kurz <groug@kaod.org>, P J P <ppandit@redhat.com>, zhibin hu <noirfate@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Greg Kurz <groug@kaod.org>

When using the 9P2000.u version of the protocol, the following shell
command line in the guest can cause QEMU to crash:

    while true; do rm -rf aa; mkdir -p a/b & touch a/b/c & mv a aa; done

With 9P2000.u, file renaming is handled by the WSTAT command. The
v9fs_wstat() function calls v9fs_complete_rename(), which calls
v9fs_fix_path() for every fid whose path is affected by the change.
The involved calls to v9fs_path_copy() may race with any other access
to the fid path performed by some worker thread, causing a crash like
shown below:

Thread 12 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555a25da2 in local_open_nofollow (fs_ctx=3D0x555557d958b8, path=3D=
0x0,
 flags=3D65536, mode=3D0) at hw/9pfs/9p-local.c:59
59          while (*path && fd !=3D -1) {
(gdb) bt
#0  0x0000555555a25da2 in local_open_nofollow (fs_ctx=3D0x555557d958b8,
 path=3D0x0, flags=3D65536, mode=3D0) at hw/9pfs/9p-local.c:59
#1  0x0000555555a25e0c in local_opendir_nofollow (fs_ctx=3D0x555557d958b8=
,
 path=3D0x0) at hw/9pfs/9p-local.c:92
#2  0x0000555555a261b8 in local_lstat (fs_ctx=3D0x555557d958b8,
 fs_path=3D0x555556b56858, stbuf=3D0x7fff84830ef0) at hw/9pfs/9p-local.c:=
185
#3  0x0000555555a2b367 in v9fs_co_lstat (pdu=3D0x555557d97498,
 path=3D0x555556b56858, stbuf=3D0x7fff84830ef0) at hw/9pfs/cofile.c:53
#4  0x0000555555a1e9e2 in v9fs_stat (opaque=3D0x555557d97498)
 at hw/9pfs/9p.c:1083
#5  0x0000555555e060a2 in coroutine_trampoline (i0=3D-669165424, i1=3D327=
67)
 at util/coroutine-ucontext.c:116
#6  0x00007fffef4f5600 in __start_context () at /lib64/libc.so.6
#7  0x0000000000000000 in  ()
(gdb)

The fix is to take the path write lock when calling v9fs_complete_rename(=
),
like in v9fs_rename().

Impact:  DoS triggered by unprivileged guest users.

Fixes: CVE-2018-19489
Cc: P J P <ppandit@redhat.com>
Reported-by: zhibin hu <noirfate@gmail.com>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 267a25533b..bdf7919abf 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2855,6 +2855,7 @@ static void coroutine_fn v9fs_wstat(void *opaque)
     struct stat stbuf;
     V9fsFidState *fidp;
     V9fsPDU *pdu =3D opaque;
+    V9fsState *s =3D pdu->s;
=20
     v9fs_stat_init(&v9stat);
     err =3D pdu_unmarshal(pdu, offset, "dwS", &fid, &unused, &v9stat);
@@ -2920,7 +2921,9 @@ static void coroutine_fn v9fs_wstat(void *opaque)
         }
     }
     if (v9stat.name.size !=3D 0) {
+        v9fs_path_write_lock(s);
         err =3D v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
+        v9fs_path_unlock(s);
         if (err < 0) {
             goto out;
         }
--=20
2.20.0.rc1
