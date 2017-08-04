Received: from eggs.gnu.org ([2001:4830:134:3::10]:54988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ddd0h-00008F-LV
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ddbmS-0007Ot-1X
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:34:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <8760e3mst2.fsf@dusky.pond.sub.org>
Date: Fri, 04 Aug 2017 14:31:19 +0200
In-Reply-To: <8760e3mst2.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 04 Aug 2017 14:16:41 +0200")
Message-ID: <87pocbjyzs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Is the use of bdrv_getlength() in parallels.c kosher?
 (was: Is the use of bdrv_getlength() in handle_aiocb_write_zeroes()
 kosher?)
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

Same question for allocate_clusters() in parallels.c, commit 5a41e1f,
modified in commit ddd2ef2:

    if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_SECTOR_BITS) {

bdrv_getlength() can fail.  Does it do the right thing then?  For what
it's worth, the comparison of its value is signed.

There's another one in parallels_open():

    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs),
                          PREALLOC_MODE_OFF, NULL) != 0) {
        s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
    }
