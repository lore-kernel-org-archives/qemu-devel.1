Received: from eggs.gnu.org ([2001:4830:134:3::10]:59158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIa9N-0003yP-Og
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIa9J-0001Ct-R9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:37:57 -0400
Date: Tue, 15 May 2018 15:37:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180515153749.280c2ee7.cohuck@redhat.com>
In-Reply-To: <d7ad3d7d-ef06-536f-2b59-96358d70a3a4@linux.ibm.com>
References: <CAFEAcA93DU7H73F-3Xd_4eP6MCZn-JHWMMeqVtyDHoMWYBXHiA@mail.gmail.com>
	<20180515103229.6684fbe9.cohuck@redhat.com>
	<d7ad3d7d-ef06-536f-2b59-96358d70a3a4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] virtio-ccw.c vs larger
 VIRTIO_QUEUE_MAX (coverity warning CID 1390619)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 15 May 2018 14:00:30 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 05/15/2018 10:32 AM, Cornelia Huck wrote:
> > On Mon, 14 May 2018 19:12:27 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:

> >> (Other odd code in that function:
> >>      vector = 0;
> >>      [...]
> >>      indicators |= 1ULL << vector;
> >> is that really supposed to ignore the input vector number?)  
> 
> This is why the vector >= VIRTIO_QUEUE_MAX + 64 does not make sense. I
> think this should be simplified. Overwriting the vector with zero and
> doing the shift is just nonsensical.

Yes, that would only make sense if we did a vector -= VIRTIO_QUEUE_MAX
instead.

History time :)

Originally, we defined a single 64 bit area for notifications, matching
virtqueues bit-for-queue, and simply saved the bit/virtqueue number in
the vector value. Then, we realized that we were missing configuration
notifications... solution was to define a second notification area,
also 64 bit for convenience (and in case we had missed yet another
notification mechanism). So, we had the following 'vector':

primary (queue) indicators   secondary indicators
0          ..           63   64       ..      127

with the two parts registered separately, and 65..127 unused. This
persisted through introduction of adapter interrupts (making the first
part 64 bit in a bitfield somewhere) and increasing the number of
virtqueues (making the first part even more bits in a bitfield
somewhere).

The rationale for the 'max virtqueues + 64' check is that the
guest always registers the full 64 bit for the second part (and that we
might want some more bits in there in the future -- which never
happened). In reality, a notification beyond max virtqueues + 1 means
that qemu has lost its way somewhere and is doing weird things.

> 
> To sum it up, my take on the whole is the diff below. I can convert
> it to a proper patch if we agree that's the way to go.

> ----------------------------8<---------------------------------------
> 
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Tue, 15 May 2018 13:57:44 +0200
> Subject: [PATCH] WIP: cleanup virtio notify
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>   hw/s390x/virtio-ccw.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index e51fbefd23..22078605d1 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1003,10 +1003,8 @@ static void virtio_ccw_notify(DeviceState *d,
> uint16_t vector) SubchDev *sch = ccw_dev->sch;
>       uint64_t indicators;
> 
> -    /* queue indicators + secondary indicators */
> -    if (vector >= VIRTIO_QUEUE_MAX + 64) {
> -        return;
> -    }
> +    /* vector == VIRTIO_QUEUE_MAX means configuration change */

"vector < VIRTIO_QUEUE_MAX: notification for a virtqueue
vector == VIRTIO_QUEUE_MAX: configuration change notification
bits beyond that are unused and should never be notified for"

?

> +    assert(vector <= VIRTIO_QUEUE_MAX);
> 
>       if (vector < VIRTIO_QUEUE_MAX) {
>           if (!dev->indicators) {
> @@ -1042,12 +1040,11 @@ static void virtio_ccw_notify(DeviceState *d,
> uint16_t vector) if (!dev->indicators2) {
>               return;
>           }
> -        vector = 0;
>           indicators = address_space_ldq(&address_space_memory,
>                                          dev->indicators2->addr,
>                                          MEMTXATTRS_UNSPECIFIED,
>                                          NULL);
> -        indicators |= 1ULL << vector;
> +        indicators |= 1ULL;
>           address_space_stq(&address_space_memory,
> dev->indicators2->addr, indicators, MEMTXATTRS_UNSPECIFIED, NULL);
>           css_conditional_io_interrupt(sch);

I'm ok with that; but as Peter mentioned, you also need to assert on
vector < 64 in the classic indicator case.
