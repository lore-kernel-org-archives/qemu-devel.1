Received: from eggs.gnu.org ([209.51.188.92]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grK7I-0002oy-EP
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grK7G-0004Ah-R0
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:07:40 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:54943)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1grK7E-00048L-R6
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:07:38 -0500
References: <20190205174207.9278-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <15cf1d40-52e8-90db-71df-8d8f881c6c7e@vivier.eu>
Date: Wed, 6 Feb 2019 11:07:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190205174207.9278-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Check sscanf return value in
 open_net_route()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, patches@linaro.org

On 05/02/2019 18:42, Peter Maydell wrote:
> Coverity warns (CID 1390634) that open_net_route() is not
> checking the return value from sscanf(), which means that
> it might then use values that aren't initialized.
> 
> Errors here should in general not happen since we're passing
> an assumed-good /proc/net/route from the host kernel, but
> if we do fail to parse a line then just skip it in the output
> we pass to the guest.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b5786d4fc1f..894678aa8b4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6762,9 +6762,15 @@ static int open_net_route(void *cpu_env, int fd)
>          char iface[16];
>          uint32_t dest, gw, mask;
>          unsigned int flags, refcnt, use, metric, mtu, window, irtt;
> -        sscanf(line, "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
> -                     iface, &dest, &gw, &flags, &refcnt, &use, &metric,
> -                     &mask, &mtu, &window, &irtt);
> +        int fields;
> +
> +        fields = sscanf(line,
> +                        "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
> +                        iface, &dest, &gw, &flags, &refcnt, &use, &metric,
> +                        &mask, &mtu, &window, &irtt);
> +        if (fields != 11) {
> +            continue;
> +        }
>          dprintf(fd, "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
>                  iface, tswap32(dest), tswap32(gw), flags, refcnt, use,
>                  metric, tswap32(mask), mtu, window, irtt);
> 


Applied to my linux-user branch.

Thanks,
Laurent
