Received: from eggs.gnu.org ([2001:4830:134:3::10]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dtyFp-0000YL-5n
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dtyFl-000899-T9
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:46:37 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:55717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dtyFl-000842-NO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:46:33 -0400
Received: from player711.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 274D67E578
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 17:46:26 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 18 Sep 2017 17:46:18 +0200
Message-ID: <150574930075.27635.3945832472060840946.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: fix readdir() for 9p2000.u
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Dakinevich <jan.dakinevich@gmail.com>

If the client is using 9p2000.u, the following occurs:

$ cd ${virtfs_shared_dir}
$ mkdir -p a/b/c
$ ls a/b
ls: cannot access 'a/b/a': No such file or directory
ls: cannot access 'a/b/b': No such file or directory
a  b  c

instead of the expected:

$ ls a/b
c

This is a regression introduced by commit f57f5878578a;
local_name_to_path() now resolves ".." and "." in paths,
and v9fs_do_readdir_with_stat()->stat_to_v9stat() then
copies the basename of the resulting path to the response.
With the example above, this means that "." and ".." are
turned into "b" and "a" respectively...

Actually, the name we need to pass is the d_name field of
the dirent.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

Hi Jan,

I found this will testing your patches. I'd appreciate if you could
review this. Then I'll push all these patches to 9p-next and send
a pull request.

Thanks,

--
Greg

 hw/9pfs/9p.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 0a37c8bd1361..0474e9e787c0 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1748,6 +1748,9 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         if (err < 0) {
             break;
         }
+        v9fs_path_free(&path);
+
+        v9fs_path_sprintf(&path, "%s", dent->d_name);
         err = stat_to_v9stat(pdu, &path, &stbuf, &v9stat);
         if (err < 0) {
             break;
