Received: from eggs.gnu.org ([2001:4830:134:3::10]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFGCM-0000FF-GB
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFGCL-0006ma-7q
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:11:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eFGCL-0006kr-1Y
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:11:01 -0500
References: <20171116075155.22378-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <658ecab6-1f09-0c94-c89e-55f71c37309a@redhat.com>
Date: Thu, 16 Nov 2017 10:10:52 +0100
MIME-Version: 1.0
In-Reply-To: <20171116075155.22378-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] ps2: check PS2Queue pointers in
 post_load routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Cyrille Chatras <cyrille.chatras@orange.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 16/11/2017 08:51, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> During Qemu guest migration, a destination process invokes ps2
> post_load function. In that, if 'rptr' and 'count' values were
> invalid, it could lead to OOB access or infinite loop issue.
> Add check to avoid it.
> 
> Reported-by: Cyrille Chatras <cyrille.chatras@orange.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/input/ps2.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> Update: avoid changing field type, add range check on values
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02815.html
> 
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index f388a23c8e..de171a28dd 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -1225,24 +1225,21 @@ static void ps2_common_reset(PS2State *s)
>  static void ps2_common_post_load(PS2State *s)
>  {
>      PS2Queue *q = &s->queue;
> -    int size;
> -    int i;
> -    int tmp_data[PS2_QUEUE_SIZE];
> +    uint8_t i, size;
> +    uint8_t tmp_data[PS2_QUEUE_SIZE];

Hi Prasad,

you don't need to change the invalid values to sane ones.  Instead, make
ps2_common_post_load return an int (just like the .post_load member of
VMStateDescription).  You can then detect out of range count/rptr/wptr
and return -1 for bad indices.

In the callers,

	ps2_common_post_load(ps2);

	return 0;

can then become simply

	return ps2_common_post_load(ps2);

Thanks,

Paolo

>      /* set the useful data buffer queue size, < PS2_QUEUE_SIZE */
> -    size = q->count > PS2_QUEUE_SIZE ? 0 : q->count;
> +    size = (q->count < 0 || q->count > PS2_QUEUE_SIZE) ? 0 : q->count;
>  
>      /* move the queue elements to the start of data array */
> -    if (size > 0) {
> -        for (i = 0; i < size; i++) {
> -            /* move the queue elements to the temporary buffer */
> -            tmp_data[i] = q->data[q->rptr];
> -            if (++q->rptr == 256) {
> -                q->rptr = 0;
> -            }
> +    for (i = 0; i < size; i++) {
> +        if (q->rptr < 0 || q->rptr >= sizeof(q->data)) {
> +            q->rptr = 0;
>          }
> -        memcpy(q->data, tmp_data, size);
> +        tmp_data[i] = q->data[q->rptr++];
>      }
> +    memcpy(q->data, tmp_data, size);
> +
>      /* reset rptr/wptr/count */
>      q->rptr = 0;
>      q->wptr = size;
> 
