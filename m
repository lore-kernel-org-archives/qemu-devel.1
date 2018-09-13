Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g0MLc-0004Ja-1q
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g0MLb-0005uy-3a
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:47:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Sep 2018 15:47:21 +0800
From: yuchenlin <yuchenlin@synology.com>
In-Reply-To: <20180913025413.GA22356@lemon.usersys.redhat.com>
References: <20180913023134.3853-1-yuchenlin@synology.com>
	<20180913025413.GA22356@lemon.usersys.redhat.com>
Message-ID: <bb2481b8c9855a818c1228136102a518@synology.com>
Subject: Re: [Qemu-devel] [PATCH v2] vmdk: align end of file to a sector
 boundary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 2018-09-13 10:54, Fam Zheng wrote:
> On Thu, 09/13 10:31, yuchenlin@synology.com wrote:
>> From: yuchenlin <yuchenlin@synology.com>
>> 
>> There is a rare case which the size of last compressed cluster
>> is larger than the cluster size, which will cause the file is
>> not aligned at the sector boundary.
> 
> The code looks good to me. Can you also explain why it is important to 
> align
> file size to sector boundary in the comment?
> 
> Fam
> 

In my opinion, there are three reasons to do it. First, if vmdk doesn't 
align at the sector boundary, there may be many undefined behaviors, 
such as in vbox it will show VMDK: Compressed image is corrupted 
'88-disk1.vmdk' (VERR_ZIP_CORRUPTED) when we try to import an ova with 
unaligned vmdk. Second, all the cluster_sector is aligned
to sector, the last one should be like this, too. Third, it ease reading 
with sector based I/Os.

What do you think?

yuchenlin

>> 
>> Signed-off-by: yuchenlin <yuchenlin@synology.com>
>> ---
>> v1 -> v2:
>> * Add more detail comment.
>> * Add QEMU_ALIGN_UP to show the intention more clearly.
>> * Add newline in the end of bdrv_truncate.
>> 
>> thanks
>> 
>>  block/vmdk.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>> 
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index a9d0084e36..2c9e86d98f 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -1698,6 +1698,27 @@ static int coroutine_fn
>>  vmdk_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>>                             uint64_t bytes, QEMUIOVector *qiov)
>>  {
>> +    if (bytes == 0) {
>> +        /* The caller will write bytes 0 to signal EOF.
>> +         * When receive it, we align EOF to a sector boundary. */
>> +        BDRVVmdkState *s = bs->opaque;
>> +        int i, ret;
>> +        int64_t length;
>> +
>> +        for (i = 0; i < s->num_extents; i++) {
>> +            length = bdrv_getlength(s->extents[i].file->bs);
>> +            if (length < 0) {
>> +                return length;
>> +            }
>> +            length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
>> +            ret = bdrv_truncate(s->extents[i].file, length,
>> +                                PREALLOC_MODE_OFF, NULL);
>> +            if (ret < 0) {
>> +                return ret;
>> +            }
>> +        }
>> +        return 0;
>> +    }
>>      return vmdk_co_pwritev(bs, offset, bytes, qiov, 0);
>>  }
>> 
>> --
>> 2.18.0
>> 
