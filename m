Received: from eggs.gnu.org ([2001:4830:134:3::10]:44998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1elxMj-0007q4-Os
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1elxMe-0004zO-MJ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:44:53 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:37693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1elxMe-0004vd-Ey
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:44:48 -0500
Received: from player157.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 88AA811BD6A
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 14:44:46 +0100 (CET)
Date: Wed, 14 Feb 2018 14:44:41 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180214144441.3a1de326@bahia.lan>
In-Reply-To: <20180214065135.11633-1-sjitindarsingh@gmail.com>
References: <20180214065135.11633-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V2 1/3]
 ppc/spapr-caps: Change migration macro to take full spapr-cap name
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

On Wed, 14 Feb 2018 17:51:33 +1100
Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:

> Change the macro that generates the vmstate migration field and the needed
> function for the spapr-caps to take the full spapr-cap name. This has
> the benefit of meaning this instance will be picked up when greping
> for the spapr-caps and making it more obvious what this macro is doing.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_caps.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 62efdaee38..e69d308560 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -350,34 +350,34 @@ int spapr_caps_post_migration(sPAPRMachineState *spapr)
>  }
>  
>  /* Used to generate the migration field and needed function for a spapr cap */
> -#define SPAPR_CAP_MIG_STATE(cap, ccap)                  \
> -static bool spapr_cap_##cap##_needed(void *opaque)      \
> +#define SPAPR_CAP_MIG_STATE(sname, cap)                 \
> +static bool spapr_cap_##sname##_needed(void *opaque)    \
>  {                                                       \
>      sPAPRMachineState *spapr = opaque;                  \
>                                                          \
> -    return spapr->cmd_line_caps[SPAPR_CAP_##ccap] &&    \
> -           (spapr->eff.caps[SPAPR_CAP_##ccap] !=        \
> -            spapr->def.caps[SPAPR_CAP_##ccap]);         \
> +    return spapr->cmd_line_caps[cap] &&                 \
> +           (spapr->eff.caps[cap] !=                     \
> +            spapr->def.caps[cap]);                      \
>  }                                                       \
>                                                          \
> -const VMStateDescription vmstate_spapr_cap_##cap = {    \
> -    .name = "spapr/cap/" #cap,                          \
> +const VMStateDescription vmstate_spapr_cap_##sname = {  \
> +    .name = "spapr/cap/" #sname,                        \
>      .version_id = 1,                                    \
>      .minimum_version_id = 1,                            \
> -    .needed = spapr_cap_##cap##_needed,                 \
> +    .needed = spapr_cap_##sname##_needed,               \
>      .fields = (VMStateField[]) {                        \
> -        VMSTATE_UINT8(mig.caps[SPAPR_CAP_##ccap],       \
> +        VMSTATE_UINT8(mig.caps[cap],                    \
>                        sPAPRMachineState),               \
>          VMSTATE_END_OF_LIST()                           \
>      },                                                  \
>  }
>  
> -SPAPR_CAP_MIG_STATE(htm, HTM);
> -SPAPR_CAP_MIG_STATE(vsx, VSX);
> -SPAPR_CAP_MIG_STATE(dfp, DFP);
> -SPAPR_CAP_MIG_STATE(cfpc, CFPC);
> -SPAPR_CAP_MIG_STATE(sbbc, SBBC);
> -SPAPR_CAP_MIG_STATE(ibs, IBS);
> +SPAPR_CAP_MIG_STATE(htm, SPAPR_CAP_HTM);
> +SPAPR_CAP_MIG_STATE(vsx, SPAPR_CAP_VSX);
> +SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
> +SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
> +SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
> +SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>  
>  void spapr_caps_reset(sPAPRMachineState *spapr)
>  {
