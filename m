Received: from eggs.gnu.org ([2001:4830:134:3::10]:38283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ahj-0002AF-37
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ahh-0007WC-Sr
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:47:51 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:44567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6ahh-0007UU-MS
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:47:49 -0400
Received: by mail-ot0-x244.google.com with SMTP id p33-v6so5608631otp.11
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 04:47:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180412101858.21304-1-clg@kaod.org>
References: <20180412101858.21304-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 12:47:28 +0100
Message-ID: <CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Eric Blake <eblake@redhat.com>

On 12 April 2018 at 11:18, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On the POWER9 processor, the XIVE interrupt controller can control
> interrupt sources using MMIO to trigger events, to EOI or to turn off
> the sources. Priority management and interrupt acknowledgment is also
> controlled by MMIO in the presenter sub-engine.
>
> These MMIO regions are exposed to guests in QEMU with a set of 'ram
> device' memory mappings, similarly to VFIO, and the VMAs are populated
> dynamically with the appropriate pages using a fault handler.
>
> But, these regions are an issue for migration. We need to discard the
> associated RAMBlocks from the RAM state on the source VM and let the
> destination VM rebuild the memory mappings on the new host in the
> post_load() operation just before resuming the system.
>
> To achieve this goal, the following introduces a new helper,
> ram_block_is_migratable(), which identifies RAMBlocks to discard on
> the source. Some checks are also performed on the destination to make
> sure nothing invalid was sent.

David suggested on IRC that we would want a flag on the ramblock
for "not migratable", because there are other uses for "don't
migrate this" than just "is this a ram device".

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>
>  I am not sure we want to taker into account patchew complaint :
>
>    ERROR: braces {} are necessary for all arms of this statement
>    #52: FILE: migration/ram.c:203:
>    +        if (ram_block_is_migratable(block))
>    [...]
>
>    total: 1 errors, 0 warnings, 136 lines checked
>
>  migration/ram.c | 52 ++++++++++++++++++++++++++++++++++++++++++---------=
-
>  1 file changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 0e90efa09236..32371950865b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -188,6 +188,21 @@ void ramblock_recv_bitmap_set_range(RAMBlock *rb, vo=
id *host_addr,
>  }
>
>  /*
> + * Identifies RAM blocks which should be discarded from migration. For
> + * the moment, it only applies to blocks backed by a 'ram_device'
> + * memory region.
> + */
> +static inline bool ram_block_is_migratable(RAMBlock *block)
> +{
> +    return !memory_region_is_ram_device(block->mr);
> +}
> +
> +/* Should be holding either ram_list.mutex, or the RCU lock. */
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +    RAMBLOCK_FOREACH(block)                            \
> +        if (ram_block_is_migratable(block))

This will mishandle some uses, like:

    if (foo)
        RAMBLOCK_FOREACH_MIGRATABLE(block)
            stuff;
    else
        morestuff;

as the if() inside the macro will capture the else clause.
(The lack of braces in the calling code would be against our
coding style, of course, so not very likely.)

Eric, is there a 'standard' trick for this? I thought of
maybe

#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
    RAMBLOCK_FOREACH(block)                            \
        if (!ram_block_is_migratable(block)) {} else

?

thanks
-- PMM
