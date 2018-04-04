Received: from eggs.gnu.org ([2001:4830:134:3::10]:46427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fbZ-00027t-3T
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fbU-0001Ti-ME
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:25:25 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3fbU-0001T9-2N
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:25:20 -0400
Received: by mail-wm0-x244.google.com with SMTP id x82so41010860wmg.1
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:25:19 -0700 (PDT)
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1519324303-5674-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519324303-5674-6-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Wed, 04 Apr 2018 11:25:17 +0100
Message-ID: <87r2nvclpu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] hw/mips_cpc: kick a VP when putting
 it into Run state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Miodrag Dinic <miodrag.dinic@mips.com>
>
> While testing mttcg VP0 could get stuck in a loop waiting for other
> VPs to come up (which never actually happens). To fix this, kick VPs
> while they are being powered up by Cluster Power Controller in an
> async task which is triggered once the host thread is being spawned.
>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/misc/mips_cpc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
> index 6d34574..712d842 100644
> --- a/hw/misc/mips_cpc.c
> +++ b/hw/misc/mips_cpc.c
> @@ -30,6 +30,14 @@ static inline uint64_t cpc_vp_run_mask(MIPSCPCState *c=
pc)
>      return (1ULL << cpc->num_vp) - 1;
>  }
>
> +static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
> +{
> +    MIPSCPCState *cpc =3D (MIPSCPCState *) data.host_ptr;
> +
> +    cpu_reset(cs);
> +    cpc->vp_running |=3D 1ULL << cs->cpu_index;
> +}
> +
>  static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_run)
>  {
>      CPUState *cs =3D first_cpu;
> @@ -37,8 +45,13 @@ static void cpc_run_vp(MIPSCPCState *cpc, uint64_t vp_=
run)
>      CPU_FOREACH(cs) {
>          uint64_t i =3D 1ULL << cs->cpu_index;
>          if (i & vp_run & ~cpc->vp_running) {
> -            cpu_reset(cs);
> -            cpc->vp_running |=3D i;
> +            /*
> +             * To avoid racing with a CPU we are just kicking off.
> +             * We do the final bit of preparation for the work in
> +             * the target CPUs context.
> +             */
> +            async_safe_run_on_cpu(cs, mips_cpu_reset_async_work,
> +                                  RUN_ON_CPU_HOST_PTR(cpc));
>          }
>      }
>  }


--
Alex Benn=C3=A9e
