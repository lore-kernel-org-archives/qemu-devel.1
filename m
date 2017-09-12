Received: from eggs.gnu.org ([2001:4830:134:3::10]:55614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drp8J-0003Pe-NF
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drp8H-00044K-Uy
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:37:59 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:45581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drp8H-00042E-NI
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:37:57 -0400
Received: by mail-wm0-x22c.google.com with SMTP id f199so529740wme.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 10:37:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831082210.8362-6-stefanha@redhat.com>
References: <20170831082210.8362-1-stefanha@redhat.com>
	<20170831082210.8362-6-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 18:37:35 +0100
Message-ID: <CAFEAcA-HadCNoZc_WU50BxBHiGTsuTF9fWtXLTNZo02XVy52fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 05/15] throttle: Remove
 throttle_fix_bucket() / throttle_unfix_bucket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>

On 31 August 2017 at 09:22, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> From: Alberto Garcia <berto@igalia.com>
>
> The throttling code can change internally the value of bkt->max if it
> hasn't been set by the user. The problem with this is that if we want
> to retrieve the original value we have to undo this change first. This
> is ugly and unnecessary: this patch removes the throttle_fix_bucket()
> and throttle_unfix_bucket() functions completely and moves the logic
> to throttle_compute_wait().
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> Message-id: 5b0b9e1ac6eb208d709eddc7b09e7669a523bff3.1503580370.git.berto@igalia.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/throttle.c | 62 +++++++++++++++++++++------------------------------------
>  1 file changed, 23 insertions(+), 39 deletions(-)
>
> diff --git a/util/throttle.c b/util/throttle.c
> index bde56fe3de..4e80a7ea54 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -95,23 +95,36 @@ static int64_t throttle_do_compute_wait(double limit, double extra)
>  int64_t throttle_compute_wait(LeakyBucket *bkt)
>  {
>      double extra; /* the number of extra units blocking the io */
> +    double bucket_size;   /* I/O before throttling to bkt->avg */
> +    double burst_bucket_size; /* Before throttling to bkt->max */
>
>      if (!bkt->avg) {
>          return 0;
>      }
>
> -    /* If the bucket is full then we have to wait */
> -    extra = bkt->level - bkt->max * bkt->burst_length;
> +    if (!bkt->max) {
> +        /* If bkt->max is 0 we still want to allow short bursts of I/O
> +         * from the guest, otherwise every other request will be throttled
> +         * and performance will suffer considerably. */
> +        bucket_size = bkt->avg / 10;
> +        burst_bucket_size = 0;
> +    } else {
> +        /* If we have a burst limit then we have to wait until all I/O
> +         * at burst rate has finished before throttling to bkt->avg */
> +        bucket_size = bkt->max * bkt->burst_length;
> +        burst_bucket_size = bkt->max / 10;
> +    }
> +
> +    /* If the main bucket is full then we have to wait */
> +    extra = bkt->level - bucket_size;
>      if (extra > 0) {
>          return throttle_do_compute_wait(bkt->avg, extra);
>      }
>
> -    /* If the bucket is not full yet we have to make sure that we
> -     * fulfill the goal of bkt->max units per second. */
> +    /* If the main bucket is not full yet we still have to check the
> +     * burst bucket in order to enforce the burst limit */
>      if (bkt->burst_length > 1) {
> -        /* We use 1/10 of the max value to smooth the throttling.
> -         * See throttle_fix_bucket() for more details. */
> -        extra = bkt->burst_level - bkt->max / 10;
> +        extra = bkt->burst_level - burst_bucket_size;
>          if (extra > 0) {
>              return throttle_do_compute_wait(bkt->max, extra);
>          }

Coverity thinks there's a division-by-zero issue here: bkt->max could
be zero (we have a test for that up above), but we can here pass it
to throttle_do_compute_wait(), which uses it as a divisor.

Since this is all double arithmetic, the division isn't going
to cause a crash, but the implicit cast of the resulting infinity
to int64_t to return it is undefined behaviour.

This is CID 1381016.

thanks
-- PMM
