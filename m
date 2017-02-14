Received: from eggs.gnu.org ([2001:4830:134:3::10]:37633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdh13-0005ZK-46
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdh12-0002Df-1j
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 12:35:49 -0500
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
	<20170203094018.15493-12-vsementsov@virtuozzo.com>
	<72ced0d7-1ec1-c1e2-362f-f010d6d942e7@redhat.com>
	<35954e87-8c8f-0747-15e4-e65838384dc2@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <095026e0-24fc-e020-0f45-09fe3124a267@redhat.com>
Date: Tue, 14 Feb 2017 12:35:41 -0500
MIME-Version: 1.0
In-Reply-To: <35954e87-8c8f-0747-15e4-e65838384dc2@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/24] block: introduce persistent dirty
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02/14/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.02.2017 02:20, John Snow wrote:
>> On 02/03/2017 04:40 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> +void bdrv_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error
>>> **errp)
>>> +{
>>> +    BlockDriver *drv = bs->drv;
>>> +
>>> +    if (!bdrv_has_persistent_bitmaps(bs)) {
>>> +        return;
>>> +    }
>>> +
>>> +    if (!drv) {
>>> +        error_setg_errno(errp, ENOMEDIUM,
>>> +                         "Can't store persistent bitmaps to %s",
>>> +                         bdrv_get_device_or_node_name(bs));
>>> +        return;
>>> +    }
>>> +
>>> +    if (!drv->bdrv_store_persistent_dirty_bitmaps) {
>>> +        error_setg_errno(errp, ENOTSUP,
>>> +                         "Can't store persistent bitmaps to %s",
>>> +                         bdrv_get_device_or_node_name(bs));
>>> +        return;
>>> +    }
>>> +
>> I suppose this is for the case for where we have added a persistent
>> bitmap during runtime, but the driver does not support it?
>>
>> I'd rather fail this type of thing earlier if possible, but I'm not that
>> far in your series yet.
> 
> qmp bitmap add checks for availability of
> drv->bdrv_can_store_new_dirty_bitmap,
> and loaded bitmaps of course should be attached to bds with appropriate
> driver.
> So, it is mostly a paranoic check.
> 

OK, understood. Not a problem, then.

--js
