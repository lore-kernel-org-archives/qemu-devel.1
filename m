Received: from eggs.gnu.org ([209.51.188.92]:54385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr7Va-0005Vp-0z
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gr7Ix-0002l9-Qt
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:26:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gr7Ix-0002kA-Kr
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:26:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so292691wmb.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 12:26:51 -0800 (PST)
References: <20190205174207.9278-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a92b808f-3e84-0e99-b36c-de77d55b5975@redhat.com>
Date: Tue, 5 Feb 2019 21:26:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190205174207.9278-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 2/5/19 6:42 PM, Peter Maydell wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
