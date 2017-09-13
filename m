Received: from eggs.gnu.org ([2001:4830:134:3::10]:60140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsAaE-0004KR-0i
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsAaA-0005NQ-5H
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:32:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170913082817.24731-1-berto@igalia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <539c675e-ed87-728c-c9d0-058ae46eb018@amsat.org>
Date: Wed, 13 Sep 2017 13:31:58 -0300
MIME-Version: 1.0
In-Reply-To: <20170913082817.24731-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] throttle: Assert that bkt->max is valid in
 throttle_compute_wait()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>

Hi Alberto,

On 09/13/2017 05:28 AM, Alberto Garcia wrote:
> If bkt->max == 0 and bkt->burst_length > 1 then we could have a
> division by 0 in throttle_do_compute_wait(). That configuration is
> however not permitted and is already detected by throttle_is_valid(),
> but let's assert it in throttle_compute_wait() to make it explicit.

This is correct but I'm not sure this is enough, as 
throttle_compute_wait() is exported/public, however it seems testing is 
the only reason to export it.

Also I spent 10min looking at it thinking about how bkt->max is used, 
before to realize there should be a simpler way to write this (KISS).

Anyway I'm queuing your patch in my /static-analysis branch I plan to 
this week where I use a self-explanatory macro instead of assert() and 
will see if I can simplify it (note that I'm not a maintainer!).

Regards,

Phil.

> 
> Found by Coverity (CID: 1381016).
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   util/throttle.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/util/throttle.c b/util/throttle.c
> index 06bf916adc..b38e742da5 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -124,6 +124,7 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
>       /* If the main bucket is not full yet we still have to check the
>        * burst bucket in order to enforce the burst limit */
>       if (bkt->burst_length > 1) {
> +        assert(bkt->max > 0); /* see throttle_is_valid() */
>           extra = bkt->burst_level - burst_bucket_size;
>           if (extra > 0) {
>               return throttle_do_compute_wait(bkt->max, extra);
> 
