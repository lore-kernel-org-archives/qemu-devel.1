Received: from eggs.gnu.org ([2001:4830:134:3::10]:38546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsWc2-0008Uj-U0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsWc0-0004BO-4t
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:03:33 -0400
References: <20170912203119.24166-1-eblake@redhat.com>
	<20170912203119.24166-12-eblake@redhat.com>
	<8db498fd-6f7f-ee78-da44-8e0087243ef1@redhat.com>
	<228fb135-f4d4-9a35-18c9-584dc3354bb5@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7c39548e-260c-db40-d9a5-061165dd36d6@redhat.com>
Date: Thu, 14 Sep 2017 12:03:15 -0400
MIME-Version: 1.0
In-Reply-To: <228fb135-f4d4-9a35-18c9-584dc3354bb5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 11/20] dirty-bitmap: Change
 bdrv_dirty_iter_next() to report byte offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>



On 09/14/2017 07:58 AM, Eric Blake wrote:
> On 09/13/2017 07:15 PM, John Snow wrote:
>>
>>
>> On 09/12/2017 04:31 PM, Eric Blake wrote:
>>> Thanks to recent cleanups, most callers were scaling a return value
>>> of sectors into bytes (the exception, in qcow2-bitmap, will be
>>> converted to byte-based iteration later).  Update the interface to
>>> do the scaling internally instead.
>>>
>>> In qcow2-bitmap, the code was specifically checking for an error
>>> to be -1; it is more robust to treat all negative values as an
>>> error, but at the same time it is also easy enough to ensure we
>>> return -1 (and not -512) on error.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>>
>> This patch now smells like a bugfix and a separate incremental feature
>> enhancement.
> 
> There is no bug without this patch; more of a fix to avoid a latent

Ah, you're right, I see. Please take the RB.

> regression from happening in further changes.  In v6, I (accidentally)
> had bdrv_dirty_iter_next() temporarily returning -512 instead of -1 on
> failure; changing the qcow2 code to treat all negatives instead of
> precisely -1 as error is enough to avoid that regression, but so also is
> fixing bdrv_dirty_iter_next() to always return -1 on failure.  This
> patch does both, rather than either fix in isolation, but that means we
> don't need a backport.
> 
>>
>> Do we need to backport the error-checking to a possible 2.10.1?
>>
>> If no:
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>
> 
