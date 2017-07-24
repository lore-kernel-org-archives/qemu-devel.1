Received: from eggs.gnu.org ([2001:4830:134:3::10]:47722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZac4-0001u0-Ej
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZac3-00016u-GY
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:29:20 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZac3-00016I-9n
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:29:19 -0400
Received: by mail-wm0-x233.google.com with SMTP id t201so14653185wmt.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 03:29:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500309462-12792-1-git-send-email-peter.maydell@linaro.org>
References: <1500309462-12792-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 11:28:57 +0100
Message-ID: <CAFEAcA9yup9CQzst6m14oO+7JHZ2F0mkrsnUN5LLx++=9ctqMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] hw/display/sm501: Don't use
 vmstate_register_ram_global()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

Ping for review, please? Would be nice to get this into rc0.

thanks
-- PMM

On 17 July 2017 at 17:37, Peter Maydell <peter.maydell@linaro.org> wrote:
> The sm501 device uses vmstate_register_ram_global() to register its
> memory region for migration.  This means it gets a name that is
> assumed to be global to the whole system, which in turn means that if
> you create two of the device we assert because of the duplication:
>
> qemu-system-ppc -device sm501 -device sm501
> RAMBlock "sm501.local" already registered, abort!
> Aborted (core dumped)
>
> Changing this to just use memory_region_init_ram()'s automatic
> registration of the memory region with a device-local name fixes
> this.  The downside is that it breaks migration compatibility, but
> luckily we only added migration support to this device in the 2.10
> release cycle so we haven't released a QEMU version with the broken
> implementation.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Recent refactoring that renamed the old "memory_region_init_ram"
> to memory_region_init_ram_nomigrate" made this bug a bit easier
> to find via grep...
>
>  hw/display/sm501.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index af792c5..9aa515b 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1578,9 +1578,8 @@ static void sm501_init(SM501State *s, DeviceState *dev,
>                    s->local_mem_size_index);
>
>      /* local memory */
> -    memory_region_init_ram_nomigrate(&s->local_mem_region, OBJECT(dev), "sm501.local",
> +    memory_region_init_ram(&s->local_mem_region, OBJECT(dev), "sm501.local",
>                             get_local_mem_size(s), &error_fatal);
> -    vmstate_register_ram_global(&s->local_mem_region);
>      memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VGA);
>      s->local_mem = memory_region_get_ram_ptr(&s->local_mem_region);
>
> --P
