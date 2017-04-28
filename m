Received: from eggs.gnu.org ([2001:4830:134:3::10]:49985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d48aT-0001eL-1q
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d48aP-0006Ex-0b
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:17:41 -0400
Received: from mail-ve1eur01on0122.outbound.protection.outlook.com
	([104.47.1.122]:41370
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1d48aO-0006EP-CQ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:17:36 -0400
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <73ecd486-2d5c-e204-1588-a0b6324ba77b@virtuozzo.com>
Date: Fri, 28 Apr 2017 19:17:27 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] RFC: some problems with bdrv_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Hello, All!

Recently we have experienced problems with very slow
bdrv_get_block_status call, which is massive called f.e.
from mirror_run().

The problem was narrowed down to slow lseek64() system
call, which can take 1-2-3 seconds.

root@s158 ~]# strace -f -p 77048 -T  -e lseek
Process 77048 attached with 14 threads
[pid 77053] lseek(23, 6359613440, SEEK_DATA) = 6360276992 <1.250323>
[pid 77053] lseek(23, 6360334336, SEEK_DATA) = 6360334336 <0.000021>
[pid 77053] lseek(23, 6360334336, SEEK_HOLE) = 6360412160 <0.007850>
[pid 77053] lseek(23, 6360465408, SEEK_DATA) = 6360596480 <0.244460>
[pid 77053] lseek(23, 6360596480, SEEK_DATA) = 6360596480 <0.000012>
[pid 77053] lseek(23, 6360596480, SEEK_HOLE) = 6361440256 <0.009102>
[pid 77053] lseek(23, 6361448448, SEEK_DATA) = 6362243072 <1.482338>
[pid 77053] lseek(23, 6361710592, SEEK_DATA) = 6362243072 <0.987192>
[pid 77053] lseek(23, 6362300416, SEEK_DATA) = 6362300416 <0.000012>
[pid 77053] lseek(23, 6362300416, SEEK_HOLE) = 6363058176 <0.008983>
[pid 77053] lseek(23, 6363086848, SEEK_DATA) = 6364467200 <2.554859>
[pid 77053] lseek(23, 6363807744, SEEK_DATA) = 6364467200 <1.220386>
[pid 77053] lseek(23, 6364528640, SEEK_DATA) = 6364528640 <0.000012>
[pid 77053] lseek(23, 6364528640, SEEK_HOLE) = 6365327360 <0.007906>
[pid 77053] lseek(23, 6365380608, SEEK_DATA) = 6366162944 <1.442824>
[pid 77053] lseek(23, 6365904896, SEEK_DATA) = 6366162944 <0.478188>
[pid 77053] lseek(23, 6366167040, SEEK_DATA) = 6366167040 <0.000013>
[pid 77053] lseek(23, 6366167040, SEEK_HOLE) = 6367002624 <0.009230>
[pid 77053] lseek(23, 6367019008, SEEK_DATA^CProcess 77048 detached


The process eats 100% in system time.

The problem comes from this branch of the code

bdrv_co_get_block_status
    .......
    if (bs->file &&
        (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
        (ret & BDRV_BLOCK_OFFSET_VALID)) {
        int file_pnum;

        ret2 = bdrv_co_get_block_status(bs->file, ret >> BDRV_SECTOR_BITS,
                                        *pnum, &file_pnum);
        if (ret2 >= 0) {
            /* Ignore errors.  This is just providing extra information, it
             * is useful but not necessary.
             */
            if (!file_pnum) {
                /* !file_pnum indicates an offset at or beyond the EOF;
it is
                 * perfectly valid for the format block driver to point
to such
                 * offsets, so catch it and mark everything as zero */
                ret |= BDRV_BLOCK_ZERO;
            } else {
                /* Limit request to the range reported by the protocol
driver */
                *pnum = file_pnum;
                ret |= (ret2 & BDRV_BLOCK_ZERO);
            }
        }
    }

which was added in the commit

commit 5daa74a6ebce7543aaad178c4061dc087bb4c705
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Sep 4 19:00:38 2013 +0200

    block: look for zero blocks in bs->file
   
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

without much details.

Frankly speaking, this optimization should not give much.
If upper layer format (QCOW2) says that we have data
here, then nowadays in 99.9% we do have the data.
Meanwhile this branch can cause problems. We would
need block cleared entirely to get the benefit for most
cases in mirror and backup operations.

At my opinion it worth to drop this at all.

Guys, do you have any opinion?

Den

P.S. The kernel is one based on RedHat 3.10.0-514. The same
      problem was observed in 3.10.0-327 too.
