Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZeZe-0003p1-Sa
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZeZd-0005Z5-0C
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:15:22 -0500
References: <76a29a1e-7fdb-37a8-9f79-df618d385b05@virtuozzo.com>
	<9e11cf33-cbe1-9fd5-f265-180e4e14dfa7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6a2d73cc-5042-54c8-364d-18d273547f27@virtuozzo.com>
Date: Thu, 11 Jan 2018 18:15:04 +0300
MIME-Version: 1.0
In-Reply-To: <9e11cf33-cbe1-9fd5-f265-180e4e14dfa7@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] qcow2 autoloading bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

11.01.2018 17:43, Eric Blake wrote:
> On 01/11/2018 08:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>> # @autoload: the bitmap will be automatically loaded when the image it
>> is stored
>> #            in is opened. This flag may only be specified for persistent
>> #            bitmaps. Default is false for block-dirty-bitmap-add.
>> (Since: 2.10)
>>
>> so, if we consider only enabled bitmaps it is ok to direct map autoload
>> <=> auto.
>>
>> But now we've faced into necessity of load/store disabled bitmaps.
>>
>> Current behavior is definitely wrong: user sets autoload flag for
>> disabled bitmap, but on next
>> Qemu start the bitmap will be autoloaded and enabled.
> Can we make it an error to set autoload to true when requesting a
> disabled bitmap? Or can we not even request a disabled bitmap?

currently, autoload is set on bitmap creation, so it is always enabled 
at this time.

>
>>
>> Proposed solution:
>>   - deprecate @autoload flag for bitmap creation, ignore it
> Is there ever a case where you'd create an enabled persistent
> dirty-tracking bitmap, but not want it to be re-enabled the next time
> the image is created?

looks like we do not. For now we use only persistent+autoload.

> Your argument for ignoring/deleting the parameter
> is that you can decide whether to set the "auto" flag solely based on
> whether the bitmap is both persistent and enabled, without needing any
> additional user input?

The main point is that, when we want to load/store disabled bitmaps this
parameter is confusing: In user's point of view it's ok to have autoloading
disabled bitmap, which he wants to be autoloaded and disabled on next Qemu
start. So, to maintain this flag (autoload) for disabled bitmaps, we 
will need
to add some additional flag "disabled" to Qcow2 spec, to make it possible to
have "auto" but "disabled" bitmaps. And we will have to change qcow2 "auto"
specification, to consider "disabled" bit set in parallel. But all this 
looks
superfluous for now. We already have type "dirty tracking bitmaps" in qcow2
spec for dirty bitmaps. So, for now, "auto" flag set on "dirty tracking
bitmaps" means that it is enabled. It is logical to assume that all other
"dirty tracking bitmaps" are disabled.

On the other hand, "autoloading" is a bad property for disabled bitmap 
at all.
Disabled bitmap is simpler than enabled (or "auto") bitmap, it doesn't 
require
any care like "auto" bitmap. So, it is more natural to let Qemu decide 
to load
or not any disabled bitmaps.



>
>>   - save persistent enabled bitmaps with "auto" flag
>>   - save persistent disabled bitmaps without "auto" flag
>>   - on Qemu start load all bitmaps, mapping "auto" flag state to
>> "enabled" state.
> So if I follow the argument, the state of the 'auto' flag stored into
> the file on BDS close (often at qemu exit) is based on whether the
> bitmap was currently enabled, and the user can then control whether to
> enable/disable the bitmap on the fly to control whether the 'auto' flag
> is stored; thus, having the flag at creation time is redundant.

Yes.

>
>>
>> Note: we may store a lot of disabled bitmaps in qcow2 image, but loading
>> them all into RAM may be
>> inefficient. Actually such bitmap will be needed only on demand (for
>> export through nbd or
>> making some kind of backup). So in future it may be optimized by "lazy
>> load" of disabled bitmaps,
>> postponing their actual load up to first read or enabling. This
>> optimization doesn't need changing
>> of qapi or qcow2 format (at first sight).
>>
>>
>> Note2: now there is no way to disable/enable bitmaps, but there is a
>>    [PATCH for-2.12 0/4] qmp dirty bitmap API
>> with big conversation, but I hope, I'll post a new version with a small
>> fix soon and it will be merged.
> In other words, you can incorporate your QAPI tweaks proposed here into
> your respin of that series.
>

right idea, I'll do so, just wait a bit for others to comment here.

-- 
Best regards,
Vladimir
