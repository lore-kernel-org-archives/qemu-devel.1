Received: from eggs.gnu.org ([2001:4830:134:3::10]:60176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0Bbb-0005tH-Em
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 14:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0Bba-0004BJ-BA
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 14:42:31 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d0Bba-0004AQ-4j
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 14:42:30 -0400
Received: by mail-wr0-x230.google.com with SMTP id o21so88121901wrb.2
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 11:42:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170415192930.1443-1-bobby.prani@gmail.com>
References: <20170415192930.1443-1-bobby.prani@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Apr 2017 19:42:08 +0100
Message-ID: <CAFEAcA-JrBV6Vi21NRPk25u+NuiLG-untt7qbnqfdtd96f63TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] timer.h: Provide monotonic time for ARM
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 15 April 2017 at 20:29, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Tested and confirmed that the stretch i386 debian qcow2 image on a
> raspberry pi 2 works.
>
> Fixes: LP#: 893208 <https://bugs.launchpad.net/qemu/+bug/893208/>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  include/qemu/timer.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index e1742f2f3d..14c9558da4 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -1015,6 +1015,16 @@ static inline int64_t cpu_get_host_ticks(void)
>      return cur - ofs;
>  }
>
> +#elif defined(__arm__) || defined(__aarch64__)
> +
> +/* ARM does not have a user-space readble cycle counter available.
> + * This is a compromise to get monotonically increasing time.
> + */
> +static inline int64_t cpu_get_host_ticks(void)
> +{
> +    return get_clock();
> +}

This doesn't look like it should be ARM-specific. Is it
better than the current default implementation? If so,
why not make this the default implementation?

> +
>  #else
>  /* The host CPU doesn't have an easily accessible cycle counter.
>     Just return a monotonically increasing value.  This will be
> --
> 2.11.0

The comment here says that our default is already a monotonically
increasing implementation -- is it wrong, or is there some other
advantage of your version?

thanks
-- PMM
