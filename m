Received: from eggs.gnu.org ([2001:4830:134:3::10]:56543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez3LB-0004hQ-3V
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez3LA-0002kp-32
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:45:25 -0400
References: <20180322161226.29796-1-lvivier@redhat.com>
	<20180322161226.29796-5-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a2e612c-368c-bc36-a852-0ce29bc36ab4@redhat.com>
Date: Thu, 22 Mar 2018 11:45:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180322161226.29796-5-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] Remove unnecessary variables for
 function return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Markus Armbruster <armbru@redhat.com>

On 03/22/2018 11:12 AM, Laurent Vivier wrote:
> Re-run Coccinelle script scripts/coccinelle/return_directly.cocci
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

> +++ b/hw/arm/exynos4210.c
> @@ -156,12 +156,7 @@ void exynos4210_write_secondary(ARMCPU *cpu,
>   
>   static uint64_t exynos4210_calc_affinity(int cpu)
>   {
> -    uint64_t mp_affinity;
> -
> -    /* Exynos4210 has 0x9 as cluster ID */
> -    mp_affinity = (0x9 << ARM_AFF1_SHIFT) | cpu;
> -
> -    return mp_affinity;
> +    return (0x9 << ARM_AFF1_SHIFT) | cpu;

Unchanged by this rewrite, but since this is converting a signed 32-bit 
int to an unsigned 64-bit value, are we sure that the upper 32 bits are 
always set correctly?  (Using unsigned values earlier in the expression 
would require less head-scratching on whether it is correct).  Any 
changes should be a separate fix by the file's maintainer.


> +++ b/hw/misc/mos6522.c
> @@ -176,12 +176,8 @@ static void mos6522_set_sr_int(MOS6522State *s)
>   
>   static uint64_t mos6522_get_counter_value(MOS6522State *s, MOS6522Timer *ti)
>   {
> -    uint64_t d;
> -
> -    d = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time,
> +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time,
>                    ti->frequency, NANOSECONDS_PER_SECOND);

Coccinelle missed that indentation is now off here.

> +++ b/hw/ppc/pnv_lpc.c
> @@ -125,25 +125,15 @@ static int pnv_lpc_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom_offset)
>   static bool opb_read(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
>                        int sz)
>   {
> -    bool success;
> -
> -    /* XXX Handle access size limits and FW read caching here */
> -    success = !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
> +    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
>                                   data, sz, false);

and here.

> +++ b/target/xtensa/translate.c
> @@ -1272,11 +1272,8 @@ XtensaOpcodeOps *
>   xtensa_find_opcode_ops(const XtensaOpcodeTranslators *t,
>                          const char *name)
>   {
> -    XtensaOpcodeOps *ops;
> -
> -    ops = bsearch(name, t->opcode, t->num_opcodes,
> +    return bsearch(name, t->opcode, t->num_opcodes,
>                     sizeof(XtensaOpcodeOps), compare_opcode_ops);

and here


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
