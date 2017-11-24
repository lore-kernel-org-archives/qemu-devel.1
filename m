Received: from eggs.gnu.org ([2001:4830:134:3::10]:41570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIDqq-0004ce-G2
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIDqm-0003pv-E7
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:17:04 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:45898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eIDqm-0003oa-8q
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:17:00 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1434F8F218
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 14:16:57 +0100 (CET)
Date: Fri, 24 Nov 2017 14:16:44 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171124141644.6e7beac0@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20171124042325.28012-2-sjitindarsingh@gmail.com>
References: <20171124042325.28012-1-sjitindarsingh@gmail.com>
	<20171124042325.28012-2-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 1/2] target/ppc: Move setting of
 patb_entry on hash table init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Fri, 24 Nov 2017 15:23:24 +1100
Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:

> The patb_entry is used to store the location of the process table in
> guest memory. The msb is also used to indicate the mmu mode of the
> guest, that is patb_entry & 1 << 63 ? radix_mode : hash_mode.
> 
> Currently we set this to zero in spapr_setup_hpt_and_vrma() since if
> this function gets called then we know we're hash. However some code
> paths, such as setting up the hpt on incoming migration of a hash guest,
> call spapr_reallocate_hpt() directly bypassing this higher level
> function. Since we assume radix if the host is capable this results in
> the msb in patb_entry being left set so in spapr_post_load() we call
> kvmppc_configure_v3_mmu() and tell the host we're radix which as
> expected means addresses cannot be translated once we actually run the cpu.
> 
> To fix this move the zeroing of patb_entry into spapr_reallocate_hpt().
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6841bd294b..e7af47bab0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1373,6 +1373,8 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
>              DIRTY_HPTE(HPTE(spapr->htab, i));
>          }
>      }
> +    /* We're setting up a hash table, so that means we're not radix */
> +    spapr->patb_entry = 0;
>  }
>  
>  void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
> @@ -1392,8 +1394,6 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
>          spapr->rma_size = kvmppc_rma_size(spapr_node0_size(MACHINE(spapr)),
>                                            spapr->htab_shift);
>      }
> -    /* We're setting up a hash table, so that means we're not radix */
> -    spapr->patb_entry = 0;
>  }
>  
>  static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
