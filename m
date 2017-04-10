Received: from eggs.gnu.org ([2001:4830:134:3::10]:49125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxUtO-0000gZ-BZ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxUtN-0002ZK-G6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:41:46 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxUtN-0002Z4-9d
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:41:45 -0400
Received: by mail-wr0-x235.google.com with SMTP id c55so70122599wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 01:41:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170408150524.2870-1-shah.suramya@gmail.com>
References: <20170408150524.2870-1-shah.suramya@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 09:41:23 +0100
Message-ID: <CAFEAcA_Gyo4DwWyCvC7BsHeQLeRASSyxhJxt8a+6Jknr0gta1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/core: fix segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 April 2017 at 16:05, Suramya Shah <shah.suramya@gmail.com> wrote:
> Reproducer:
>  $i386-softmmu/qemu-system-i386 -S -machine isapc,accel=tcg -device amd-iommu
> Segmentation fault (core dumped)
>
> Partial bt:
> #0  bus_add_child (child=0x555556d4e520, bus=0x0) at hw/core/qdev.c:88
> #1  qdev_set_parent_bus (dev=0x555556d4e520, bus=bus@entry=0x0)
> at hw/core/qdev.c:119
>
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
>  hw/core/qdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 1e7fb33..07a211b 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -84,7 +84,11 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>  {
>      char name[32];
>      BusChild *kid = g_malloc0(sizeof(*kid));
> -
> +
> +    if (!bus) {
> +        error_report("bus not found ");
> +        exit(0);
> +    }
>      kid->index = bus->max_index++;
>      kid->child = child;
>      object_ref(OBJECT(kid->child));

Thanks for the patch, but this doesn't look like the right way to fix
this. Exiting with an error in a low-level function like this is not
really any better than crashing. This function is not supposed to
be called with a NULL bus pointer, so the question is: why is that
happening? Something in one of the calling functions, probably
several layers up the stack, has a bug. To fix this bug we need to
look at that code and identify why it is trying to add the child
device to a NULL bus and what bus it ought to be putting it on
instead.

thanks
-- PMM
