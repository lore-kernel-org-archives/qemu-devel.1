Received: from eggs.gnu.org ([2001:4830:134:3::10]:38126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eExAn-0002Z4-0t
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eExAh-00088W-4G
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:52:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18537)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eExAg-000873-RV
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:52:03 -0500
Date: Wed, 15 Nov 2017 12:51:51 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171115125151.GG20349@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171115124602.12501-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171115124602.12501-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ps2: fix PS2Queue counter field type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Gerd Hoffmann <kraxel@redhat.com>, Cyrille Chatras <cyrille.chatras@orange.com>

On Wed, Nov 15, 2017 at 06:16:02PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> During Qemu guest migration, a destination process invokes ps2
> post_load function. In that, if 'rptr' and 'count' fields were
> tampered, it could lead to OOB access or infinite loop issues.
> Change their type to 'uint8_t' so they remain within bounds.

If you're concerned that someone is tampering with QEMU state
in transit during migration, then you're going to end up playing
whack-a-mole across the entire QEMU codebase IMHO. The answer
to the problem of tampering is to have encryption of the
migration data stream between both QEMU's. Thus QEMU on the
target merely has to trust QEMU on the source. If QEMU on the
source is itself compromised you've already lost and migration
won't make life any worse.

> 
> Reported-by: Cyrille Chatras <cyrille.chatras@orange.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/input/ps2.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index f388a23c8e..ce4b167084 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -90,7 +90,7 @@ typedef struct {
>      /* Keep the data array 256 bytes long, which compatibility
>       with older qemu versions. */
>      uint8_t data[256];
> -    int rptr, wptr, count;
> +    uint8_t rptr, wptr, count;
>  } PS2Queue;
>  
>  struct PS2State {
> @@ -1225,24 +1225,18 @@ static void ps2_common_reset(PS2State *s)
>  static void ps2_common_post_load(PS2State *s)
>  {
>      PS2Queue *q = &s->queue;
> -    int size;
> -    int i;
> -    int tmp_data[PS2_QUEUE_SIZE];
> +    uint8_t i, size;
> +    uint8_t tmp_data[PS2_QUEUE_SIZE];
>  
>      /* set the useful data buffer queue size, < PS2_QUEUE_SIZE */
>      size = q->count > PS2_QUEUE_SIZE ? 0 : q->count;
>  
>      /* move the queue elements to the start of data array */
> -    if (size > 0) {
> -        for (i = 0; i < size; i++) {
> -            /* move the queue elements to the temporary buffer */
> -            tmp_data[i] = q->data[q->rptr];
> -            if (++q->rptr == 256) {
> -                q->rptr = 0;
> -            }
> -        }
> -        memcpy(q->data, tmp_data, size);
> +    for (i = 0; i < size; i++) {
> +        tmp_data[i] = q->data[q->rptr++];
>      }
> +    memcpy(q->data, tmp_data, size);
> +
>      /* reset rptr/wptr/count */
>      q->rptr = 0;
>      q->wptr = size;
> @@ -1286,9 +1280,9 @@ static const VMStateDescription vmstate_ps2_common = {
>      .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_INT32(write_cmd, PS2State),
> -        VMSTATE_INT32(queue.rptr, PS2State),
> -        VMSTATE_INT32(queue.wptr, PS2State),
> -        VMSTATE_INT32(queue.count, PS2State),
> +        VMSTATE_UINT8(queue.rptr, PS2State),
> +        VMSTATE_UINT8(queue.wptr, PS2State),
> +        VMSTATE_UINT8(queue.count, PS2State),

This would surely break migration backwards compatibility. Any new QEMU
release accepting incoming migration from an old QEMU release will read
the wrong amount of data off the migration stream, and thus will ultimately
cause migraiton to fail.

>          VMSTATE_BUFFER(queue.data, PS2State),
>          VMSTATE_END_OF_LIST()
>      }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
