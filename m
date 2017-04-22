Received: from eggs.gnu.org ([2001:4830:134:3::10]:57021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d1mdi-000104-9o
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 00:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d1mdh-0005rh-Gt
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 00:27:18 -0400
MIME-Version: 1.0
In-Reply-To: <CAC2QTZbH_LYaEYr_p6wKbek8X0PFfoAJp=tC9dCBryyC_R6_Ow@mail.gmail.com>
References: <1491057878-27868-1-git-send-email-ashijeetacharya@gmail.com>
	<1491057878-27868-6-git-send-email-ashijeetacharya@gmail.com>
	<20170419130044.GB12781@lemon.lan>
	<CAC2QTZbH_LYaEYr_p6wKbek8X0PFfoAJp=tC9dCBryyC_R6_Ow@mail.gmail.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat, 22 Apr 2017 09:57:16 +0530
Message-ID: <CAC2QTZZmh5aUdNVF=b7J+1eFNarjT=sRWV8Jctq_tW+_w30WKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 5/6] vmdk: Set maximum bytes allocated
 in one cycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Fri, Apr 21, 2017 at 8:23 PM, Ashijeet Acharya
<ashijeetacharya@gmail.com> wrote:
> On Wed, Apr 19, 2017 at 6:30 PM, Fam Zheng <famz@redhat.com> wrote:
>> On Sat, 04/01 20:14, Ashijeet Acharya wrote:
>>> Set the maximum bytes allowed to get allocated at once to be not more
>>> than the extent size boundary to handle writes at two separate extents
>>> appropriately.
>>>
>>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>>> ---
>>>  block/vmdk.c | 13 +++++++++++--
>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/vmdk.c b/block/vmdk.c
>>> index a8babd7..9456ddd 100644
>>> --- a/block/vmdk.c
>>> +++ b/block/vmdk.c
>>> @@ -1767,6 +1767,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>>      int64_t offset_in_cluster, n_bytes;
>>>      uint64_t cluster_offset;
>>>      uint64_t bytes_done = 0;
>>> +    uint64_t extent_size;
>>>      VmdkMetaData m_data;
>>>      uint32_t total_alloc_clusters = 0;
>>>
>>> @@ -1782,9 +1783,17 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>>          if (!extent) {
>>>              return -EIO;
>>>          }
>>> +        extent_size = extent->end_sector * BDRV_SECTOR_SIZE;
>>
>> Maybe extent_end to be more accurate?
>
> Done
>
>>> +
>>>          offset_in_cluster = vmdk_find_offset_in_cluster(extent, offset);
>>> -        n_bytes = MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZE
>>> -                             - offset_in_cluster);
>>> +
>>> +        /* truncate n_bytes to first cluster because we need to perform COW */
>>
>> Makes sense, but shouldn't this be squashed into patch patch 3? Because it looks
>> like it is fixing an intermediate bug.
>
> Did you mean that I should merge this whole patch into patch 3? Maybe
> moving it before patch 3 rather than squashing it make more sense?

Instead I have moved it before patch 3 in v4

Ashijeet
