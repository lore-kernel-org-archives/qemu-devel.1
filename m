Received: from eggs.gnu.org ([2001:4830:134:3::10]:36092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dWzWC-0003n8-KJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dWzWB-0004WN-LJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:28:32 -0400
Message-ID: <1500272899.2284.0.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 17 Jul 2017 16:28:19 +1000
In-Reply-To: <1500048838-16802-1-git-send-email-clg@kaod.org>
References: <1500048838-16802-1-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix CPU hotplug when radix is
 enabled (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 2017-07-14 at 18:13 +0200, Cédric Le Goater wrote:
> But when a guest initializes radix mode, it issues a
> H_REGISTER_PROC_TBL
> to update the LPCR of all CPUs. Hot-plugged CPUs inherit from the
> same
> setting under KVM but not under TCG. So, Let's check for radix and
> update
> the default LPCR to keep new CPUs in sync.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> ---
>  target/ppc/translate_init.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate_init.c
> b/target/ppc/translate_init.c
> index 8b9807665dd5..8776e9b0f8fa 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9014,8 +9014,16 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu,
> PPCVirtualHypervisor *vhyp)
>          /* By default we choose legacy mode and switch to new hash
> or radix
>           * when a register process table hcall is made. So disable
> process
>           * tables and guest translation shootdown by default
> +         *
> +         * Hot-plugged CPUs inherit from the guest radix setting
> under
> +         * KVM but not under TCG. Update the default LPCR to keep
> new
> +         * CPUs in sync when radix is enabled.
>           */
> -        lpcr->default_value &= ~(LPCR_UPRT | LPCR_GTSE);
> +        if (ppc64_radix_guest(cpu)) {
> +            lpcr->default_value |= LPCR_UPRT | LPCR_GTSE;

Since we can't do radix without GTSE, I guess for now at least RADIX
implies GTSE.

> +        } else {
> +            lpcr->default_value &= ~(LPCR_UPRT | LPCR_GTSE);
> +        }
>          lpcr->default_value |= LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
> LPCR_DEE |
>                                 LPCR_OEE;
>          break;
