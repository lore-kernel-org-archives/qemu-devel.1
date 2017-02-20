Received: from eggs.gnu.org ([2001:4830:134:3::10]:36939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsingharora@gmail.com>) id 1cfiS1-0002YD-0E
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 02:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsingharora@gmail.com>) id 1cfiRz-0005bq-Vy
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 02:32:01 -0500
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 20 Feb 2017 18:31:46 +1100
Message-ID: <20170220073146.GC661@balbir.ozlabs.ibm.com>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
	<1487563478-22265-4-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487563478-22265-4-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 03/10]
 target/ppc/POWER9: Adapt LPCR handling for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

On Mon, Feb 20, 2017 at 03:04:31PM +1100, Suraj Jitindar Singh wrote:
> The logical partitioning control register controls a threads operation
> based on the partition it is currently executing. Add new definitions and
> update the mask used when writing to the LPCR based on the POWER9 spec.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  target/ppc/cpu.h            | 18 ++++++++++++++++++
>  target/ppc/mmu-hash64.c     |  8 ++++++++
>  target/ppc/translate_init.c | 24 ++++++++++++++++++------
>  3 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index bb96dd5..425e79d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -384,12 +384,19 @@ struct ppc_slb_t {
>  #define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)
>  #define LPCR_VRMASD_SHIFT (63 - 16)
>  #define LPCR_VRMASD       (0x1full << LPCR_VRMASD_SHIFT)
> +/* P9: Power-saving mode Exit Cause Enable (Upper Section) Mask */
> +#define LPCR_PECE_U_SHIFT (63 - 19)
> +#define LPCR_PECE_U_MASK  (0x7ull << LPCR_PECE_U_SHIFT)
> +#define LPCR_HVEE         (1ull << (63 - 17)) /* Hypervisor Virt Exit Enable */
>  #define LPCR_RMLS_SHIFT   (63 - 37)
>  #define LPCR_RMLS         (0xfull << LPCR_RMLS_SHIFT)
>  #define LPCR_ILE          (1ull << (63 - 38))
>  #define LPCR_AIL_SHIFT    (63 - 40)      /* Alternate interrupt location */
>  #define LPCR_AIL          (3ull << LPCR_AIL_SHIFT)
> +#define LPCR_UPRT         (1ull << (63 - 41)) /* Use Process Table */
> +#define LPCR_EVIRT        (1ull << (63 - 42)) /* Enhanced Virtualisation */
>  #define LPCR_ONL          (1ull << (63 - 45))
> +#define LPCR_LD           (1ull << (63 - 46)) /* Large Decrementer */
>  #define LPCR_P7_PECE0     (1ull << (63 - 49))
>  #define LPCR_P7_PECE1     (1ull << (63 - 50))
>  #define LPCR_P7_PECE2     (1ull << (63 - 51))
> @@ -398,11 +405,22 @@ struct ppc_slb_t {
>  #define LPCR_P8_PECE2     (1ull << (63 - 49))
>  #define LPCR_P8_PECE3     (1ull << (63 - 50))
>  #define LPCR_P8_PECE4     (1ull << (63 - 51))
> +/* P9: Power-saving mode Exit Cause Enable (Lower Section) Mask */
> +#define LPCR_PECE_L_SHIFT (63 - 51)
> +#define LPCR_PECE_L_MASK  (0x1full << LPCR_PECE_L_SHIFT)
> +#define LPCR_PDEE         (1ull << (63 - 47)) /* Privileged Doorbell Exit EN */
> +#define LPCR_HDEE         (1ull << (63 - 48)) /* Hyperv Doorbell Exit Enable */
> +#define LPCR_EEE          (1ull << (63 - 49)) /* External Exit Enable        */
> +#define LPCR_DEE          (1ull << (63 - 50)) /* Decrementer Exit Enable     */
> +#define LPCR_OEE          (1ull << (63 - 51)) /* Other Exit Enable           */
>  #define LPCR_MER          (1ull << (63 - 52))
> +#define LPCR_GTSE         (1ull << (63 - 53)) /* Guest Translation Shootdown */
>  #define LPCR_TC           (1ull << (63 - 54))
> +#define LPCR_HEIC         (1ull << (63 - 59)) /* HV Extern Interrupt Control */
>  #define LPCR_LPES0        (1ull << (63 - 60))
>  #define LPCR_LPES1        (1ull << (63 - 61))
>  #define LPCR_RMI          (1ull << (63 - 62))
> +#define LPCR_HVICE        (1ull << (63 - 62)) /* HV Virtualisation Int Enable */
>  #define LPCR_HDICE        (1ull << (63 - 63))

This patch is missing

#define LPCR_HR	(1ull << (63 - 43))	/* HV uses Radix Tree Translation */

See arch/powerpc/include/asm/reg.h in the Linux kernel. 

Balbir Singh.
