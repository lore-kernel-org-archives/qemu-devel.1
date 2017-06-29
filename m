Received: from eggs.gnu.org ([2001:4830:134:3::10]:44776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dQO0l-0002Cc-F4
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dQO0k-0005AK-6O
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:12:47 -0400
References: <1498475064-39816-1-git-send-email-sochin.jiang@huawei.com>
	<d2c26bda-b166-cc2b-8596-ad48783e7e7c@redhat.com>
From: "sochin.jiang" <sochin.jiang@huawei.com>
Message-ID: <45c08e29-ae42-4fc8-9e25-36ee257e5b5c@huawei.com>
Date: Thu, 29 Jun 2017 09:12:18 +0800
MIME-Version: 1.0
In-Reply-To: <d2c26bda-b166-cc2b-8596-ad48783e7e7c@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] mirror: fix the inconsistent AioContext
 problem in the backing BDSs during mirroring.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

Oh，I got it, thanks.


Sochin


On 2017/6/29 6:33, Max Reitz wrote:
> On 2017-06-26 13:04, sochin.jiang wrote:
>> From: "sochin.jiang" <sochin.jiang@huawei.com>
>>
>>  mirror_complete opens the backings, BDSs of the new open backings should have a
>>  same AioContext with the top when using iothreads, fix the code to guarantee this,
>>  also avoiding unexpected qemu exit(assert fails in bdrv_attach_child).
> Thanks! The functional change looks good to me. I'll see to add an
> iotest to cover this case.
>
> Some notes: There shouldn't be any spaces at the front of these lines,
> and every line should be limited to 72 characters.
>
> Also, the commit message should not end in a full stop (and it's good to
> keep it short).
>
> I've reworded a bit of the commit message (and shortened the title*) and
> applied it to my block branch:
>
> https://github.com/XanClic/qemu/commits/block
>
> Max
>
> [1] I've shortened it to "mirror: Fix inconsistent backing AioContext
> for after mirroring". I usually try to fit the title into 50 characters
> (because that's what the default vim highlighting is proposing...), so
> for reference, I would have made it something like "block: Align backing
> BDS's AioContext with overlay" -- if it had been my patch. Since it was
> yours, I'm fine with commit titles longer than 50 characters (although
> they really should not exceed 72).
>
>> Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
>> ---
>>  block.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/block.c b/block.c
>> index 6943962..b312fe6 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2185,6 +2185,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>>          ret = -EINVAL;
>>          goto free_exit;
>>      }
>> +    bdrv_set_aio_context(backing_hd, bdrv_get_aio_context(bs));
>>  
>>      /* Hook up the backing file link; drop our reference, bs owns the
>>       * backing_hd reference now */
>>
>
