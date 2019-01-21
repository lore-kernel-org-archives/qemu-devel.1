Received: from eggs.gnu.org ([209.51.188.92]:46237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1glfJQ-0003Ab-Nm
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1glfJP-00013K-V3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:32:48 -0500
Date: Mon, 21 Jan 2019 11:32:03 -0800
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20190121193203.GB19750@toto>
References: <20190121184314.14311-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121184314.14311-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] xlnx-zynqmp: Don't create rpu-cluster if
 there are no RPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair@alistair23.me>

On Mon, Jan 21, 2019 at 06:43:14PM +0000, Peter Maydell wrote:
> If we aren't going to create any RPUs, then don't create the
> rpu-cluster unit. This allows us to add an assertion to the
> cluster object that it contains at least one CPU, which helps
> to avoid bugs in creating clusters and putting CPUs in them.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is a preparatory patch that is necessary for the series
> "[PATCH v3 0/4] tcg: support heterogenous CPU clusters"
> (20190121152218.9592-1-peter.maydell@linaro.org)
> in order to avoid the xlnx-zcu102 board asserting if started with
> fewer than 5 CPUs.
> 
>  hw/arm/xlnx-zynqmp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 370b0e44a38..16cba433cb7 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -178,6 +178,11 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>      int i;
>      int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
>  
> +    if (num_rpus == 0) {
> +        /* Don't create rpu-cluster object if there's nothing to put in it */
> +        return;
> +    }
> +
>      object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
>                              sizeof(s->rpu_cluster), TYPE_CPU_CLUSTER,
>                              &error_abort, NULL);
> -- 
> 2.20.1
> 
