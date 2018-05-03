Received: from eggs.gnu.org ([2001:4830:134:3::10]:37965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fEEQ9-0003QZ-BC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fEEQ6-0007HJ-9H
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:37:17 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f7d5b3a3-e7d2-bff0-07c4-42f474e8b133@redhat.com>
References: <20180426134305.642080-1-eblake@redhat.com>
	<20180426134305.642080-4-eblake@redhat.com>
	<w5136zgbve8.fsf@maestria.local.igalia.com>
	<f7d5b3a3-e7d2-bff0-07c4-42f474e8b133@redhat.com>
Date: Thu, 03 May 2018 15:36:34 +0200
Message-ID: <w5160447tel.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] block: Removed unused
 sector-based blocking I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri 27 Apr 2018 05:43:33 PM CEST, Eric Blake wrote:
>>> -static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *buf,
>>> -                      int nb_sectors, bool is_write, BdrvRequestFlags flags)
>>> -{
>>> -    QEMUIOVector qiov;
>>> -    struct iovec iov = {
>>> -        .iov_base = (void *)buf,
>>> -        .iov_len = nb_sectors * BDRV_SECTOR_SIZE,
>>> -    };
>>> -
>>> -    if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
>>> -        return -EINVAL;
>>> -    }
>> 
>> Do we have a check for BDRV_REQUEST_MAX_BYTES in the byte-based API?
>
> No, but we don't need one.  First, note that bs->bl.max_transfer is
> currently uint32_t, so right now, no driver can set it any larger than
> 4G

But note that the old limit was based on a signed integer.

BDRV_REQUEST_MAX_SECTORS is 2147483136 bytes (a bit less than 2GB).

For 32-bit integers, (INT_MAX - 1) & ~511 = 2147483136

Berto
