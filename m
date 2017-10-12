Received: from eggs.gnu.org ([2001:4830:134:3::10]:40565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2kP2-0006VC-0R
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2kOv-0005tj-Fi
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:48:22 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:55874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2kOv-0005tV-84
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:48:17 -0400
Received: by mail-pf0-x22c.google.com with SMTP id 17so6564900pfn.12
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 13:48:17 -0700 (PDT)
References: <cover.1503467674.git.shorne@gmail.com>
	<88d5624e0d2f52db9072fcb36406baadf31d96bd.1503467674.git.shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96862cfe-263b-78fc-e471-ed04966791f8@linaro.org>
Date: Thu, 12 Oct 2017 13:48:13 -0700
MIME-Version: 1.0
In-Reply-To: <88d5624e0d2f52db9072fcb36406baadf31d96bd.1503467674.git.shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] target/openrisc: Make coreid and
 numcores configurable in state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: Openrisc <openrisc@lists.librecores.org>, Richard Henderson <rth@twiddle.net>

On 08/22/2017 10:57 PM, Stafford Horne wrote:
> Previously coreid and numcores were hard coded as 0 and 1 respectively
> as OpenRISC QEMU did not have multicore support.
> 
> Multicore support is now being added so these registers need to have
> configured values.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  hw/openrisc/openrisc_sim.c   | 3 +++
>  target/openrisc/cpu.h        | 3 +++
>  target/openrisc/machine.c    | 7 +++++--
>  target/openrisc/sys_helper.c | 4 ++--
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index e1eeffc490..44a657753d 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -110,6 +110,9 @@ static void openrisc_sim_init(MachineState *machine)
>  
>      for (n = 0; n < smp_cpus; n++) {
>          cpu = cpu_openrisc_init(cpu_model);
> +        cpu->env.coreid = n;
> +        cpu->env.numcores = smp_cpus;

This duplicates cpu->parent_obj.cpu_index.  Also c.f. max_cpus vs smp_cpus; the
latter can change via hot-plug.

> @@ -104,8 +104,8 @@ static const VMStateInfo vmstate_sr = {
>  
>  static const VMStateDescription vmstate_env = {
>      .name = "env",
> -    .version_id = 6,
> -    .minimum_version_id = 6,
> +    .version_id = 7,
> +    .minimum_version_id = 7,
>      .post_load = env_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
> @@ -152,6 +152,9 @@ static const VMStateDescription vmstate_env = {
>          VMSTATE_UINT32(picmr, CPUOpenRISCState),
>          VMSTATE_UINT32(picsr, CPUOpenRISCState),
>  
> +        VMSTATE_UINT32(coreid, CPUOpenRISCState),
> +        VMSTATE_UINT32(numcores, CPUOpenRISCState),

If you use the above directly you don't need to save/restore these yourself.

>      case TO_SPR(0, 128): /* COREID */
> -        return 0;
> +        return env->coreid;

>      case TO_SPR(0, 129): /* NUMCORES */
> -        return 1;
> +        return env->numcores;

Just use the global variable directly here, IMO.


r~
