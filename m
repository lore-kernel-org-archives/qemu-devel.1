Received: from eggs.gnu.org ([2001:4830:134:3::10]:44707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1essI6-0001Y8-MY
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1essI4-0007vY-FX
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:44:42 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1essI4-0007vE-Ai
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:44:40 -0500
Received: by mail-oi0-x241.google.com with SMTP id c83so12360384oib.1
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 07:44:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180303143823.27055-6-richard.henderson@linaro.org>
References: <20180303143823.27055-1-richard.henderson@linaro.org>
	<20180303143823.27055-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 15:44:19 +0000
Message-ID: <CAFEAcA_Fp4nvXDW+UucRw=vEF8DwniwsfhnC0KdumBA8OF294Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 5/5] aarch64-linux-user: Add
 support for SVE signal frame records
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 3 March 2018 at 14:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Depending on the currently selected size of the SVE vector registers,
> we can either store the data within the "standard" allocation, or we
> may beedn to allocate additional space with an EXTRA record.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/signal.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 192 insertions(+), 18 deletions(-)

> +static int alloc_sigframe_space(int this_size, target_sigframe_layout *l)
> +{
> +    /* Make sure there will always be space for the end marker.  */
> +    const int std_size = sizeof(struct target_rt_sigframe)
> +                         - sizeof(struct target_aarch64_ctx);
> +    int this_loc = l->total_size;
> +
> +    if (l->extra_base) {
> +        /* Once we have begun an extra space, all allocations go there.  */
> +        l->extra_size += this_size;
> +    } else if (this_size + this_loc > std_size) {
> +        /* This allocation does not fit in the standard space.  */

I think strictly this runs into trouble if it lets us put something
in the standard space that runs right up to the end marker and
doesn't leave space for the extra marker, and then the next thing
can't put in the extra marker. But this won't happen in practice,
so I don't think we really need to try to handle that.

> +        /* Allocate the extra record.  */
> +        l->extra_ofs = this_loc;
> +        l->total_size += sizeof(struct target_extra_context);
> +
> +        /* Allocate the standard end record.  */
> +        l->std_end_ofs = l->total_size;
> +        l->total_size += sizeof(struct target_aarch64_ctx);
> +
> +        /* Allocate the requested record.  */
> +        l->extra_base = this_loc = l->total_size;
> +        l->extra_size = this_size;
> +    }
> +    l->total_size += this_size;
> +
> +    return this_loc;
> +}

thanks
-- PMM
