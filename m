Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eF3AM-0004c1-41
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eF3AL-0000Mb-8g
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:16:06 -0500
References: <20171115090947.29883-1-kchamart@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0b29e074-6548-d42e-12ab-67419342773e@redhat.com>
Date: Wed, 15 Nov 2017 14:15:57 -0500
MIME-Version: 1.0
In-Reply-To: <20171115090947.29883-1-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qapi: block-core: Clarify
 events emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com



On 11/15/2017 04:09 AM, Kashyap Chamarthy wrote:
> When you cancel an in-progress live block operation with QMP
> `block-job-cancel`, it emits the event: BLOCK_JOB_CANCELLED.  However,
> when `block-job-cancel` is issued after `drive-mirror` has indicated (by
> emitting the event BLOCK_JOB_READY) that the source and destination
> remain synchronized:
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
> that synchronization has successfully ended (and the destination has a
> point-in-time copy, which is at the time of cancel).
> 
> So add a small note to this effect.  (Thanks: Max Reitz for reminding
> me of this on IRC.)
> 

I suppose this difference probably isn't covered in what was the
bitmaps.md doc file (we don't bother covering mirror there, only
backup); is it covered sufficiently in live-block-operations.rst ?

--js
