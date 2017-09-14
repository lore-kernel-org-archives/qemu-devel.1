Received: from eggs.gnu.org ([2001:4830:134:3::10]:38216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsIJo-0004dg-Tg
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsIJn-00079O-Ps
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:47:48 -0400
References: <20170913164424.32129-1-awg@digitalocean.com>
	<820405a5-32e9-43e4-f41f-184e3bbb00a7@redhat.com>
	<CAE9i+tAgVv5ebLMuHXK2mDHC0aCcpGKrOib+DzCgsGyFh9EbLg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <548bda9d-3f65-a58a-94ff-87083c1f1338@redhat.com>
Date: Wed, 13 Sep 2017 20:47:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9i+tAgVv5ebLMuHXK2mDHC0aCcpGKrOib+DzCgsGyFh9EbLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] rbd: Detect rbd image resizes
 and propagate them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adam Wolfe Gordon <awg@digitalocean.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/13/2017 05:36 PM, Adam Wolfe Gordon via Qemu-devel wrote:
> On Wed, Sep 13, 2017 at 2:53 PM, John Snow <jsnow@redhat.com> wrote:
>> On 09/13/2017 12:44 PM, Adam Wolfe Gordon wrote:
>>> Register a watcher with rbd so that we get notified when an image is
>>> resized. Propagate resizes to parent block devices so that guest devices
>>> get resized without user intervention.
>>>
>>> Signed-off-by: Adam Wolfe Gordon <awg@digitalocean.com>
>>> ---
>>> Hello!
>>>
>>> We are using this patch in production at DigitalOcean and have tested it fairly
>>> extensively. However, we use the same block device configuration everywhere, so
>>> I'd be interested to get an answer to the question I've left in the code:>
>>>> /* NOTE: This assumes there's only one layer between us and the
>>>>    block-backend. Is this always true? */
>>>
>>
>> Even if it were always true presently, the fact that the block layer
>> storage graph can be configured in arbitrary ways suggests that it might
>> not always be true in the future.
>>
>> Probably in practice MOST drives are configured like
>> [BB]<--[Format]<--[Protocol], but the block layer is adding a lot of fun
>> stuff like filter nodes for throttling or debugging, so it's probably
>> too much to assert that the length of the chain will ALWAYS be exactly two.
> 
> OK, thanks - that's exactly what I was wondering. I can add some code
> to traverse the parents until we get to the BB.
> 
>> Can I play dumb and ask what you are trying to accomplish? The concept
>> of a drive deciding to resize itself is not something I have a model for
>> understanding, presently...
> 
> Good question; I probably should have explained the use-case in the
> commit message.
> 
> We have a storage orchestration service that manages our ceph block
> storage clusters and doesn't interact directly with qemu. Volumes get
> resized through the orchestration service, which (after doing some

resized bigger, one hopes ...

> checks, updating external metadata, etc.) issues the resize via
> librbd. The drive doesn't exactly resize itself, but the trigger is
> out-of-band from any VM the drive may be attached to.

>From QEMU's POV, the drive resized itself! Facts on the ground may be
different, of course.

> 
> Previously, we would notify the VM of the resize by issuing a
> blockresize via qmp after doing the resize itself externally. That
> meant we were actually resizing the rbd image twice (though the second
> was, hopefully, a no-op). We occasionally had trouble with the resize
> issued by qemu getting stuck and blocking the qemu main thread.
> Detecting the out-of-band resize lets us avoid the extra rbd_resize
> call and means that we never modify an rbd image's metadata from qemu.
> 

Hm, I see... It sounds like you want an operation here that lets us
detect medium changes without actually attempting to orchestrate one.

It smells like you want the second half of bdrv_truncate without
actually issuing the call. Perhaps you could split this function into
its two halves, and in the event of an external resize being detected,
you could call the latter-half portion of bdrv_truncate.

...if the drive is configured to automatically detect those events, that
is. Conceivably not all resize events that QEMU *could* detect *should*
automatically result in guest-visible changes as soon as they occur.

--js
