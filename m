Received: from eggs.gnu.org ([2001:4830:134:3::10]:51333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqgCK-00059w-1X
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqgCJ-0001ig-4D
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:25:40 -0500
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-15-mreitz@redhat.com>
	<20180227093430.GE25412@lemon.usersys.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <825a30f5-c48c-d454-1ef8-e793348215c4@redhat.com>
Date: Tue, 27 Feb 2018 08:25:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180227093430.GE25412@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/16] block/mirror: Add active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 02/27/2018 03:34 AM, Fam Zheng wrote:
> On Mon, 01/22 23:08, Max Reitz wrote:
>> @@ -1151,7 +1285,48 @@ static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
>>   static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
>>       uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
>>   {
>> -    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
>> +    MirrorOp *op = NULL;
>> +    MirrorBDSOpaque *s = bs->opaque;
>> +    QEMUIOVector bounce_qiov;
>> +    void *bounce_buf;
>> +    int ret = 0;
>> +    bool copy_to_target;
>> +
>> +    copy_to_target = s->job->ret >= 0 &&
>> +                     s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING;
>> +
>> +    if (copy_to_target) {
>> +        /* The guest might concurrently modify the data to write; but
>> +         * the data on source and destination must match, so we have
>> +         * to use a bounce buffer if we are going to write to the
>> +         * target now. */
>> +        bounce_buf = qemu_blockalign(bs, bytes);
>> +        iov_to_buf_full(qiov->iov, qiov->niov, 0, bounce_buf, bytes);
> 
> Quorum doesn't use a bounce buffer, so I think we can get away without it too: a
> guest concurrently modifying the buffer isn't a concern in practice.

Arguably, that's a bug in quorum.  We also use a bounce buffer for the 
same reason when encrypting.  We really do need to make sure that bits 
landing in more than one storage location come from the same point in time.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
