Received: from eggs.gnu.org ([2001:4830:134:3::10]:38215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIYjt-00048W-OV
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIYjs-0003aT-Oe
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:07:33 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIYjs-0003aJ-JZ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:07:32 -0400
Received: by mail-ot0-x244.google.com with SMTP id l12-v6so18139450oth.6
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 05:07:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d7ad3d7d-ef06-536f-2b59-96358d70a3a4@linux.ibm.com>
References: <CAFEAcA93DU7H73F-3Xd_4eP6MCZn-JHWMMeqVtyDHoMWYBXHiA@mail.gmail.com>
	<20180515103229.6684fbe9.cohuck@redhat.com>
	<d7ad3d7d-ef06-536f-2b59-96358d70a3a4@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 13:07:11 +0100
Message-ID: <CAFEAcA_aH_oVbZnoFWWtJRGOqVDzr1NA9m1A1AVyqhKWQ-Fxpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15 May 2018 at 13:00, Halil Pasic <pasic@linux.ibm.com> wrote:
> To sum it up, my take on the whole is the diff below. I can convert
> it to a proper patch if we agree that's the way to go.
>
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Tue, 15 May 2018 13:57:44 +0200
> Subject: [PATCH] WIP: cleanup virtio notify
>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index e51fbefd23..22078605d1 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1003,10 +1003,8 @@ static void virtio_ccw_notify(DeviceState *d,
> uint16_t vector)
>      SubchDev *sch = ccw_dev->sch;
>      uint64_t indicators;
>
> -    /* queue indicators + secondary indicators */
> -    if (vector >= VIRTIO_QUEUE_MAX + 64) {
> -        return;
> -    }
> +    /* vector == VIRTIO_QUEUE_MAX means configuration change */
> +    assert(vector <= VIRTIO_QUEUE_MAX);
>
>      if (vector < VIRTIO_QUEUE_MAX) {
>          if (!dev->indicators) {

This will not be sufficient to satisfy Coverity, because
VIRTIO_QUEUE_MAX is 1024, and that is way too big to use as
a shift count, and that's the only check that Coverity can see
on the code path leading into the "1ULL << vector" code.

If it's not possible to get here with a vector that's 64 or more,
you need to
    assert(vector < NR_CLASSIC_INDICATOR_BITS);
somewhere.

thanks
-- PMM
