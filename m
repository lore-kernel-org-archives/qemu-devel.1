Received: from eggs.gnu.org ([2001:4830:134:3::10]:53890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dfRhj-00019E-O3
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dfRhe-00015G-ND
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:11:23 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e8abd17c-6003-6bf4-11da-309457467965@virtuozzo.com>
Date: Wed, 9 Aug 2017 17:11:02 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] block replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wency@cn.fujitsu.com
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>

Hi Wen!

I'm trying to understand block/replication code and have a question.

Why should we block the region from intersecting cow requests when read? 
If I understand correctly

regardless of writes to the secondary-disk we have consistent view of it 
through hidden-disk:

Even if we are intersecting with some writes to secondary-disk (and 
corresponding cow-requests), the

data in secondary disk will not be updated until backed up to 
hidden-disk, therefore, for read we have two

options:

1. read old data from secondary-disk (unallocated region in hidden-disk 
means data in secondary-disk is not updated yet)

2. read backed-up data from hidden-disk (data in secondary-disk may be 
already updated but we don't care)

(the whole region to read may consists of parts, corresponding to 1 or 
2, but this should be ok too)

Where am I wrong?


======

static coroutine_fn int replication_co_readv(BlockDriverState *bs,
                                              int64_t sector_num,
                                              int remaining_sectors,
                                              QEMUIOVector *qiov)
{
     BDRVReplicationState *s = bs->opaque;
     BdrvChild *child = s->secondary_disk;
     BlockJob *job = NULL;
     CowRequest req;
     int ret;

     if (s->mode == REPLICATION_MODE_PRIMARY) {
         /* We only use it to forward primary write requests */
         return -EIO;
}

     ret = replication_get_io_status(s);
     if (ret < 0) {
         return ret;
}

     if (child && child->bs) {
         job = child->bs->job;
}

     if (job) {
         uint64_t remaining_bytes = remaining_sectors * BDRV_SECTOR_SIZE;

backup_wait_for_overlapping_requests(child->bs->job,
                                              sector_num * 
BDRV_SECTOR_SIZE,
remaining_bytes);
         backup_cow_request_begin(&req, child->bs->job,
                                  sector_num * BDRV_SECTOR_SIZE,
remaining_bytes);
         ret = bdrv_co_readv(bs->file, sector_num, remaining_sectors,
qiov);
backup_cow_request_end(&req);
         goto out;
}

     ret = bdrv_co_readv(bs->file, sector_num, remaining_sectors, qiov);
out:
     return replication_return_value(s, ret);
}

-- 
Best regards,
Vladimir
