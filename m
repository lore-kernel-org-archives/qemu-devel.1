Received: from eggs.gnu.org ([209.51.188.92]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1guQBb-0005Vz-Bo
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1guQBa-0004gi-9P
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:12:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1guQBV-0004Xr-Pk
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:12:51 -0500
References: <20190213234907.24173-1-jsnow@redhat.com>
	<20190213234907.24173-4-jsnow@redhat.com>
	<6202dabc-0079-90cb-8b7a-39f8ae6c817c@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <778d2114-f56b-9d16-baab-e17d34aa46a6@redhat.com>
Date: Thu, 14 Feb 2019 18:12:36 -0500
MIME-Version: 1.0
In-Reply-To: <6202dabc-0079-90cb-8b7a-39f8ae6c817c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 3/3] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org



On 2/14/19 10:46 AM, Eric Blake wrote:
> On 2/13/19 5:49 PM, John Snow wrote:
>> When bitmaps are persistent, they may incur a disk read or write when bitmaps
>> are added or removed. For configurations like virtio-dataplane, failing to
>> acquire this lock will abort QEMU when disk IO occurs.
>>
>> We used to acquire aio_context as part of the bitmap lookup, so re-introduce
>> the lock for just the cases that have an IO penalty. Commit 2119882c removed
>> these locks, and I failed to notice this when we committed fd5ae4cc, so this
>> has been broken since persistent bitmaps were introduced.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1672010
>> Reported-By: Aihua Liang <aliang@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Message-id: 20190213195501.7790-2-jsnow@redhat.com
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  blockdev.c | 26 ++++++++++++++++++++------
>>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
>>      bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
>>      if (bitmap == NULL) {
>> -        return;
>> +        goto out
> 
> Embarrassing enough that I missed this syntax error in spite of my R-b,
> but even more embarrassing that we have a pull request that has
> obviously not been compiled. At least patchew called it out.

Hm, yes, I swore I *did* compile and test this, but it clearly must have
been on the outdated patch.

> 
> We're not in enough of a rush to need this PR to land this week, so I
> won't try to post a v2 on your behalf, but will instead wait for your
> return next week.
> 

Was trying to stay ahead of my long weekend instead of carrying these
patches forever. Please forgive the error.

--js
