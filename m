Received: from eggs.gnu.org ([2001:4830:134:3::10]:53628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ercPf-0002wS-Cn
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 23:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ercPe-0006bq-6c
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 23:35:19 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:39569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ercPd-0006Zp-Ux
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 23:35:18 -0500
Received: by mail-lf0-x242.google.com with SMTP id f75so11593209lfg.6
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 20:35:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e2a29860b0eb2591e16a83178e305828d1b0b730.1519950018.git.alistair.francis@xilinx.com>
References: <e2a29860b0eb2591e16a83178e305828d1b0b730.1519950018.git.alistair.francis@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Mar 2018 20:34:45 -0800
Message-ID: <CAKmqyKOcSA0wqWrsRMXMv2E+Jb+MnYkD_h16NbEmxYohVJoj-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] target/arm: Fix the A53 L2CTLR typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Mar 1, 2018 at 4:20 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> The cortex A53 TRM specifices that bits 24 and 25 of the L2CTLR register
> specify the number of cores present and not the number of processors. We
> have correctly been reporting the number of cores, so just fix the
> comment to match the TRM.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Ah! This isn't actually what I want, I want something more like this (untested):

commit ce9d9795ebff42e1f742e7dc3786e52524807c65
Author: Alistair Francis <alistair@alistair23.me>
Date:   Thu Mar 1 20:19:23 2018 -0800

    target/arm: Report the number of cores in the cluster

    Previously we assumed that we only has a single cluster, which meant we
    could get away with reporting smp_cpus to the guest. There are cases
    where we have two clusters (Xilinx's ZynqMP is a good example) so
    reporting the number of smp_cpus is incorrect. Instead count the cores
    in the cluster.

    Signed-off-by: Alistair Francis <alistair@alistair23.me>

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9743bdc..e7b1f3c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -42,8 +42,24 @@ static inline void unset_feature(CPUARMState *env,
int feature)
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    /* Number of processors is in [25:24]; otherwise we RAZ */
-    return (smp_cpus - 1) << 24;
+    CPUState *cpu;
+    CPUState *cpu_prev = NULL;
+    int num_cores = 0;
+
+    /* Figure out the number of cores in the cluster */
+    for (cpu = first_cpu; cpu; cpu = CPU_NEXT(cpu)) {
+        /* Only increase the core count if the CPU we are on is the same
+         * class as the caller and the previous cpu.
+         */
+        if ((CPU_GET_CLASS(cpu) == CPU_GET_CLASS(cpu_prev)) &&
+            (CPU_GET_CLASS(cpu) == CPU_GET_CLASS(CPU(env)))) {
+            num_cores++;
+        }
+        cpu_prev = cpu;
+    }
+
+    /* Number of cores is in [25:24]; otherwise we RAZ */
+    return num_cores << 24;
 }
 #endif

I'll send a patch tomorrow after testing.

Alistair

> ---
>
>  target/arm/cpu64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 9743bdc8c3..aac1746efe 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -42,7 +42,7 @@ static inline void unset_feature(CPUARMState *env, int feature)
>  #ifndef CONFIG_USER_ONLY
>  static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    /* Number of processors is in [25:24]; otherwise we RAZ */
> +    /* Number of cores is in [25:24]; otherwise we RAZ */
>      return (smp_cpus - 1) << 24;
>  }
>  #endif
> --
> 2.14.1
>
