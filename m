Received: from eggs.gnu.org ([2001:4830:134:3::10]:35764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJHyO-0008U6-AQ
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJHyN-00038L-Hs
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:53:16 -0500
Date: Mon, 27 Nov 2017 12:53:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171127115307.GB4903@localhost.localdomain>
References: <20171121115253.14923-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121115253.14923-1-kchamart@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 for-2.11] QAPI & interop:
 Clarify events emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com

Am 21.11.2017 um 12:52 hat Kashyap Chamarthy geschrieben:
> When you cancel an in-progress 'mirror' job (or "active `block-commit`")
> with QMP `block-job-cancel`, it emits the event: BLOCK_JOB_CANCELLED.
> However, when `block-job-cancel` is issued *after* `drive-mirror` has
> indicated (via the event BLOCK_JOB_READY) that the source and
> destination have reached synchronization:
> 
>     [...] # Snip `drive-mirror` invocation & outputs
>     {
>       "execute":"block-job-cancel",
>       "arguments":{
>         "device":"virtio0"
>       }
>     }
> 
>     {"return": {}}
> 
> It (`block-job-cancel`) will counterintuitively emit the event
> 'BLOCK_JOB_COMPLETED':
> 
>     {
>       "timestamp":{
>         "seconds":1510678024,
>         "microseconds":526240
>       },
>       "event":"BLOCK_JOB_COMPLETED",
>       "data":{
>         "device":"virtio0",
>         "len":41126400,
>         "offset":41126400,
>         "speed":0,
>         "type":"mirror"
>       }
>     }
> 
> But this is expected behaviour, where the _COMPLETED event indicates
> that synchronization has successfully ended (and the destination now has
> a point-in-time copy, which is at the time of cancel).
> 
> So add a small note to this effect in 'block-core.json'.  While at it,
> also update the "Live disk synchronization -- drive-mirror and
> blockdev-mirror" section in 'live-block-operations.rst'.
> 
> (Thanks: Max Reitz for reminding me of this caveat on IRC.)
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

> +(1) Issuing the command ``block-job-cancel`` (after it emits the event
> +    ``BLOCK_JOB_COMPLETED``) will create a point-in-time (which is at
> +    the time of *triggering* the cancel command) copy of the entire disk
>      image chain (or only the top-most image, depending on the ``sync``
> -    mode).
> +    mode), contained in the target image [E]. One use case for this is
> +    live storage migration.

As commented on v4, I dropped the last sentence here for now. Please
suggest an unambiguous wording if you'd prefer to keep it.

Thanks, applied to the block branch.

Kevin
