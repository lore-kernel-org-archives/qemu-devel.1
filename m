Received: from eggs.gnu.org ([2001:4830:134:3::10]:51595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoX9c-0004JF-VJ
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoX9c-0005CR-0D
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:22:00 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-12-kwolf@redhat.com>
	<ab90d9c1-ea99-9a21-7303-e26af2796d22@redhat.com>
	<20180221102954.GA4196@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cc255826-ca6b-eeb8-6a2d-45eddedc0bde@redhat.com>
Date: Wed, 21 Feb 2018 10:21:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180221102954.GA4196@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/27] block: x-blockdev-create QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/21/2018 04:29 AM, Kevin Wolf wrote:

>>> +++ b/include/block/block_int.h
>>> @@ -130,6 +130,8 @@ struct BlockDriver {
>>>        int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
>>>                              Error **errp);
>>>        void (*bdrv_close)(BlockDriverState *bs);
>>> +    int coroutine_fn (*bdrv_co_create)(BlockdevCreateOptions *opts,
>>> +                                       Error **errp);
>>
>> I know we haven't been very good in the past, but can you add a comment here
>> on the contract that drivers are supposed to obey when implementing this
>> callback?
> 
> Anything specific you want to see here?
> 
> Essentially the meaning of BlockdevCreateOptions depends on the driver
> and is documented in the QAPI schema, how Error works is common
> knowledge, and I don't see much else to explain here.
> 
> I mean, I can add something like "Creates an image. See the QAPI
> documentation for BlockdevCreateOptions for details." if you think this
> is useful. But is it?

I guess my concern is whether this interface MUST overwrite any existing 
data in order to convert existing storage into a newly-created image of 
this driver's type (even if the overwritten data previously probed as a 
different image type), or if it is only called at a point when any 
existing data would be probed as raw, or any other useful tidbits that a 
driver might need to know in implementing it.  But if all you can think 
of is "See QAPI for BlockdevCreateOptions for details", then yeah, 
that's not worth a comment.

> 
>>> +    /* Call callback if it exists */
>>> +    if (!drv->bdrv_co_create) {
>>> +        error_setg(errp, "Driver does not support blockdev-create");
>>
>> Should this error message refer to 'x-blockdev-create' in the short term?
> 
> Hm, it would be more correct. On the other hand, I'm almost sure we'd
> forget to rename it back when we remove the x- prefix...

Good point.  And being an x- prefix implies that inconsistency may be 
expected (not to mention short-lived, if we promote the interface); 
while being consistent now but risking long-term inconsistency down the 
road when it actually becomes a stable interface is indeed worse.  So 
keep this message as-is.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
