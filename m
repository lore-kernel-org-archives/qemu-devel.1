Received: from eggs.gnu.org ([2001:4830:134:3::10]:49469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eF0Y0-0002aO-Uf
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 11:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eF0Y0-0008OU-01
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 11:28:20 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
	<97df2225-908c-e817-8364-2454f1451768@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <1dae35e5-390f-cfbe-fbd1-8c993517d596@virtuozzo.com>
Date: Wed, 15 Nov 2017 19:28:05 +0300
MIME-Version: 1.0
In-Reply-To: <97df2225-908c-e817-8364-2454f1451768@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] qcow2: multiple clusters write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Pavel Butsykin <pbutsykin@virtuozzo.com>

On 15/11/2017 6:11 PM, Max Reitz wrote:
> On 2017-11-14 11:16, Anton Nefedov wrote:
>> From: Pavel Butsykin <pbutsykin@virtuozzo.com>
>>
>> At the moment, qcow2_co_pwritev_compressed can process the requests size
>> less than or equal to one cluster. This patch added possibility to write
>> compressed data in the QCOW2 more than one cluster. The implementation
>> is simple, we just split large requests into separate clusters and write
>> using existing functionality. For unaligned requests we use a workaround
>> and do write data without compression.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/qcow2.c | 77 +++++++++++++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 56 insertions(+), 21 deletions(-)
> 
> On one hand, it might be better to do this centrally somewhere in
> block/io.c.  On the other, that would require more work because it would
> probably mean having to introduce another field in BlockLimits, and it
> wouldn't do much -- because qcow (v1) is, well, qcow v1...  And vmdk
> seems to completely not care about this single cluster limitation.  So
> for now we probably wouldn't even gain anything by doing this in block/io.c.
> 
> So long story short, it's OK to do this locally in qcow2, yes.
> 

[..]

>> +        qemu_iovec_reset(&hd_qiov);
>> +        chunk_size = MIN(bytes, s->cluster_size);
>> +        qemu_iovec_concat(&hd_qiov, qiov, curr_off, chunk_size);
>> +
>> +        ret = qcow2_co_pwritev_cluster_compressed(bs, offset + curr_off,
>> +                                                  chunk_size, &hd_qiov);
>> +        if (ret == -ENOTSUP) {
> 
> Why this?  I mean, I can see the appeal, but then we should probably
> actually return -ENOTSUP somewhere (e.g. for unaligned clusters and the
> like) -- and we should not abort if offset_into_cluster(s, cluster) is
> true, but we should write the header uncompressed and compress the main
> bulk.
> 
> Max
> 

Right, sorry, missed this part when porting the patch.

I think this needs to be removed (and the commit message fixed
accordingly).
Returning an error, rather than silently falling back to uncompressed
seems preferable to me. "Compressing writers" (backup, img convert and
now stream) are aware that they have to cluster-align, and if they fail
to do so that means there is an error somewhere.
If it won't return an error anymore, then the unaligned tail shouldn't
either. So we can end up 'letting' the callers send small unaligned
requests which will never get compressed.

/Anton

>> +            ret = qcow2_co_pwritev(bs, offset + curr_off, chunk_size,
>> +                                   &hd_qiov, 0);
