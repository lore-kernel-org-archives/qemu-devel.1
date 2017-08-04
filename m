Received: from eggs.gnu.org ([2001:4830:134:3::10]:44174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dddAf-000424-9E
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dddA2-0005Q8-OU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:01:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 04 Aug 2017 15:55:39 +0200
Message-ID: <87d18be8tg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Is blk_getlength() in find_image_format() and
 img_map() kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Have a look at find_image_format():

    if (blk_is_sg(file) || !blk_is_inserted(file) || blk_getlength(file) == 0) {
        *pdrv = &bdrv_raw;
        return ret;
    }

blk_getlength() can fail.  Shouldn't we error out then?

We pretty obviously should in img_map():

    length = blk_getlength(blk);
    while (curr.start + curr.length < length) {

Since I have to touch @length in the series I'm working on, I'll stick
in a fix.
