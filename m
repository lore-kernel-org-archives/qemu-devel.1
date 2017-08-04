Received: from eggs.gnu.org ([2001:4830:134:3::10]:38242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ddcrF-0002RV-C2
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ddbi2-00078M-Nr
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:29:12 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 04 Aug 2017 14:16:41 +0200
Message-ID: <8760e3mst2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Is the use of bdrv_getlength() in
 handle_aiocb_write_zeroes() kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

Denis, you added this in commit d50d822:

#ifdef CONFIG_FALLOCATE
    if (s->has_fallocate && aiocb->aio_offset >= bdrv_getlength(aiocb->bs)) {
        int ret = do_fallocate(s->fd, 0, aiocb->aio_offset, aiocb->aio_nbytes);
        if (ret == 0 || ret != -ENOTSUP) {
            return ret;
        }
        s->has_fallocate = false;
    }
#endif

bdrv_getlength() can fail.  Does it do the right thing then?  For what
it's worth, the comparison of its value is signed.
