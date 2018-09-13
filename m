Received: from eggs.gnu.org ([2001:4830:134:3::10]:33189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g0GnU-0002om-6I
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1g0GnT-0002s8-Ek
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:51:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Sep 2018 09:51:43 +0800
From: yuchenlin <yuchenlin@synology.com>
In-Reply-To: <20180912115421.GJ2526@lemon.usersys.redhat.com>
References: <20180828031751.29507-1-yuchenlin@synology.com>
	<20180912115421.GJ2526@lemon.usersys.redhat.com>
Message-ID: <7ab961d4c1879d319236e6c7a60fdc38@synology.com>
Subject: Re: [Qemu-devel] [PATCH] vmdk: align end of file to a sector
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

On 2018-09-12 19:54, Fam Zheng wrote:
> On Tue, 08/28 11:17, yuchenlin@synology.com wrote:
>> From: yuchenlin <yuchenlin@synology.com>
>> 
>> There is a rare case which the size of last compressed cluster
>> is larger than the cluster size, which will cause the file is
>> not aligned at the sector boundary.
>> 
>> Signed-off-by: yuchenlin <yuchenlin@synology.com>
>> ---
>>  block/vmdk.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index a9d0084e36..a8ae7c65d2 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -1698,6 +1698,24 @@ static int coroutine_fn
>>  vmdk_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>>                             uint64_t bytes, QEMUIOVector *qiov)
>>  {
>> +    if (bytes == 0) {
>> +        /* align end of file to a sector boundary. */
>> +        BDRVVmdkState *s = bs->opaque;
>> +        int i, ret;
>> +        int64_t length;
>> +
>> +        for (i = 0; i < s->num_extents; i++) {
>> +            length = bdrv_getlength(s->extents[i].file->bs);
>> +            if (length < 0) {
>> +                return length;
>> +            }
> 
> Could you add "length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);" to 
> show the
> intention more clearly?
> 
> Fam
> 

Thank you for your effort, I will do it.

yuchenlin

>> +            ret = bdrv_truncate(s->extents[i].file, length, 
>> PREALLOC_MODE_OFF, NULL);
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
>> 2.17.0
>> 
