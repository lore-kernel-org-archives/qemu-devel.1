Received: from eggs.gnu.org ([2001:4830:134:3::10]:51333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eKnt7-0004sm-1T
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eKnsJ-0004zg-8F
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:10:04 -0500
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:46158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eKnsI-0004yk-Uj
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:09:15 -0500
Received: from player694.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id EF796112272
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 11:11:36 +0100 (CET)
Date: Fri, 1 Dec 2017 11:11:22 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171201111122.25e43169@bahia.lan>
In-Reply-To: <20171201054125.25749-1-david@gibson.dropbear.id.au>
References: <20171201054125.25749-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] spapr: Include "pre-plugged"
 DIMMS in ram size calculation at reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri,  1 Dec 2017 16:41:25 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:
> At guest reset time, we allocate a hash page table (HPT) for the guest
> based on the guest's RAM size.  If dynamic HPT resizing is not available we
> use the maximum RAM size, if it is we use the current RAM size.
> 
> But the "current RAM size" calculation is incorrect - we just use the
> "base" ram_size from the machine structure.  This doesn't include any
> pluggable DIMMs that are already plugged at reset time.
> 
> This means that if you try to start a 'pseries' machine with a DIMM
> specified on the command line that's much larger than the "base" RAM size,
> then the guest will get a woefully inadequate HPT.  This can lead to a
> guest freeze during boot as it runs out of HPT space during initial MMU
> setup.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Yeah I could easily reproduce the issue with:

-m 256M,maxmem=9G,slots=1 \
-object memory-backend-ram,id=ram0,size=8G \
-device pc-dimm,id=dimm0,memdev=ram0

and this patch indeed fixes the issue.

BTW, we already had a similar miscalculation of the current RAM size in
h_resize_hpt_prepare() that was addressed with commit db50f280cf5f7. Maybe
worth consolidating the calculation in some helper ?

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

and

Tested-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a471de6cab..1ac7eb0f8c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1386,7 +1386,10 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
>              && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
>          hpt_shift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size);
>      } else {
> -        hpt_shift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->ram_size);
> +        uint64_t current_ram_size;
> +
> +        current_ram_size = MACHINE(spapr)->ram_size + get_plugged_memory_size();
> +        hpt_shift = spapr_hpt_shift_for_ramsize(current_ram_size);
>      }
>      spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
>  
