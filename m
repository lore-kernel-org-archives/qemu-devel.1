Received: from eggs.gnu.org ([2001:4830:134:3::10]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e05b9-0000o8-8x
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e05b4-0005jR-CW
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:49:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e05b4-0005ie-5e
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:49:50 -0400
References: <20171004162543.12233-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <72e8546a-0101-b7f7-a2c9-574d03754562@redhat.com>
Date: Thu, 5 Oct 2017 14:49:43 +0200
MIME-Version: 1.0
In-Reply-To: <20171004162543.12233-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/tcg: initialize machine check queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com

On 04.10.2017 18:25, Cornelia Huck wrote:
> Just as for external interrupts and I/O interrupts, we need to
> initialize mchk_index during cpu reset.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Trying a device_add with a ccw device under tcg currently insta-crashes
> qemu. Probably nobody ever tried the crw machine check support that I
> hacked in...
> 
> Needs more work to avoid a guest kernel panic next; but let's pick the
> low-hanging fruit first.
> 
> ---
>  target/s390x/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 4e1823a3e0..3fdf9bae70 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -111,6 +111,7 @@ static void s390_cpu_initial_reset(CPUState *s)
>      for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
>          env->io_index[i] = -1;
>      }
> +    env->mchk_index = -1;
>  
>      /* tininess for underflow is detected before rounding */
>      set_float_detect_tininess(float_tininess_before_rounding,
> @@ -148,6 +149,7 @@ static void s390_cpu_full_reset(CPUState *s)
>      for (i = 0; i < ARRAY_SIZE(env->io_index); i++) {
>          env->io_index[i] = -1;
>      }
> +    env->mchk_index = -1;
>  
>      /* tininess for underflow is detected before rounding */
>      set_float_detect_tininess(float_tininess_before_rounding,
> 

Makes sense.

Reviewed-by: Thomas Huth <thuth@redhat.com>


PS: I wonder whether the common code of s390_cpu_initial_reset() and
s390_cpu_full_reset() should be put into a separate function? Or maybe
s390_cpu_full_reset() should call s390_cpu_initial_reset() ? At least
the code duplication here looks like we should do some clean up here...

 Thomas
