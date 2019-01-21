Received: from eggs.gnu.org ([209.51.188.92]:54517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glfvx-00070N-VJ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glfvw-0005Ub-Vp
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:12:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glfvw-0005U5-NU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:12:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so24896005wrr.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:12:36 -0800 (PST)
References: <20190121184314.14311-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <383fd07d-9c2a-a7b2-5b88-f9a411c8b91a@redhat.com>
Date: Mon, 21 Jan 2019 21:12:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190121184314.14311-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>
Cc: qemu-devel@nongnu.org, Luc Michel <luc.michel@greensocs.com>, patches@linaro.org

Hi Peter,

On 1/21/19 7:43 PM, Peter Maydell wrote:
> If we aren't going to create any RPUs, then don't create the
> rpu-cluster unit. This allows us to add an assertion to the
> cluster object that it contains at least one CPU, which helps
> to avoid bugs in creating clusters and putting CPUs in them.
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

Not related to this patch, but this check seems dangerous, i.e. using
"-smp 2" we get num_rpus=-2 which luckyly doesn't enter the for() loop.

>  
> +    if (num_rpus == 0) {

With the current codebase, you'd have to check for "num_rpus <= 0", ...

> +        /* Don't create rpu-cluster object if there's nothing to put in it */
> +        return;
> +    }
> +
>      object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
>                              sizeof(s->rpu_cluster), TYPE_CPU_CLUSTER,
>                              &error_abort, NULL);
> 

... because the rpu cluster is still created:

aarch64-softmmu/qemu-system-aarch64 -M xlnx-zcu102 -smp 2 -S -monitor stdio

(qemu) info qom-tree
/machine (xlnx-zcu102-machine)
  /peripheral (container)
  /soc (xlnx,zynqmp)
    /rpu-cluster (cpu-cluster)
    /apu-cluster (cpu-cluster)
      /apu-cpu[1] (cortex-a53-arm-cpu)
        /unnamed-gpio-in[1] (irq)
        /unnamed-gpio-in[3] (irq)
        /unnamed-gpio-in[2] (irq)
        /unnamed-gpio-in[0] (irq)
      /apu-cpu[0] (cortex-a53-arm-cpu)
        /unnamed-gpio-in[1] (irq)
        /unnamed-gpio-in[3] (irq)
        /unnamed-gpio-in[2] (irq)
        /unnamed-gpio-in[0] (irq)


What about this instead?

-- >8 --
@@ -451,10 +451,12 @@ static void xlnx_zynqmp_realize(DeviceState *dev,
Error **errp)
                     "RPUs just use -smp 6.");
     }

-    xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
+    if (smp_cpus > XLNX_ZYNQMP_NUM_APU_CPUS) {
+        xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
     }

     if (!s->boot_cpu_ptr) {
---

Regards,

Phil.
