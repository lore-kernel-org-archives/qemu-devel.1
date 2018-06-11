Received: from eggs.gnu.org ([2001:4830:134:3::10]:38071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSTNm-0000hv-BX
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSTNh-0002Ic-2F
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:25:41 -0400
Received: from mail-eopbgr690058.outbound.protection.outlook.com
	([40.107.69.58]:27680
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fSTNg-0002Gs-Mx
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:25:36 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 11 Jun 2018 20:25:32 +0000
Message-ID: <DM5PR12MB24718C2709BB60179BAD2F9495780@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-3-git-send-email-babu.moger@amd.com>
In-Reply-To: <1528498581-131037-3-git-send-email-babu.moger@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v13 2/5] i386: Introduce auto_topoext bit
 to manage topoext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>

Hi Eduardo,
Planning  to make couple of changes after testing and review.  Let me know =
if I missed something.
Will wait for your feedback before the next revision.

> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
> On Behalf Of Babu Moger
> Sent: Friday, June 8, 2018 5:56 PM
> To: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; ehabkost@redhat.com; mtosatti@redhat.com
> Cc: qemu-devel@nongnu.org; kvm@vger.kernel.org; Moger, Babu
> <Babu.Moger@amd.com>; kash@tripleback.net; geoff@hostfission.com
> Subject: [PATCH v13 2/5] i386: Introduce auto_topoext bit to manage
> topoext
>=20
> Introduce the auto_topoext bit to to control topoext feature.
>=20
> Also add new field auto_topoext(in X86CPUDefinition). This will
> be used to enable topoext on newer CPU models where topoext can
> be supported.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  include/hw/i386/pc.h |  4 ++++
>  target/i386/cpu.c    | 12 ++++++++++++
>  target/i386/cpu.h    |  5 +++++
>  3 files changed, 21 insertions(+)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 04d1f8c..cc30ec3 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -303,6 +303,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *,
> uint64_t *);
>          .driver   =3D TYPE_X86_CPU,\
>          .property =3D "legacy-cache",\
>          .value    =3D "on",\
> +    },{\
> +        .driver   =3D TYPE_X86_CPU,\
> +        .property =3D "auto-topoext",\
> +        .value    =3D "off",\
>      },

We don't need this.  We are already setting this false in x86_cpu_propertie=
s.
But we need to set it "on" for EPYC on PC_COMPAT_3_0 whenever we define it.=
=20
That will be a separate patch. Correct?

>=20
>  #define PC_COMPAT_2_11 \
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 86fb1a4..d3411ed 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1283,6 +1283,8 @@ struct X86CPUDefinition {
>      FeatureWordArray features;
>      const char *model_id;
>      CPUCaches *cache_info;
> +    /* Set it if topoext can be enabled in CPU models */
> +    int auto_topoext;
>  };
>=20
>  static CPUCaches epyc_cache_info =3D {
> @@ -3517,6 +3519,9 @@ static void x86_cpu_load_def(X86CPU *cpu,
> X86CPUDefinition *def, Error **errp)
>      /* legacy-cache defaults to 'off' if CPU model provides cache info *=
/
>      cpu->legacy_cache =3D !def->cache_info;
>=20
> +    /* Set auto_topoext if both machine property and CPU model supports =
it
> */
> +    cpu->auto_topoext =3D  cpu->auto_topoext & def->auto_topoext;

This could be more appropriate like this.

 cpu->auto_topoext =3D  cpu->auto_topoext && def->auto_topoext;

> +
>      /* Special cases not set in the X86CPUDefinition structs: */
>      /* TODO: in-kernel irqchip for hvf */
>      if (kvm_enabled()) {
> @@ -5382,6 +5387,13 @@ static Property x86_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
>=20
>      /*
> +     * auto-topoext property will be used to enable topoext feature.
> +     * This will be disabled on all the older CPU models. Will be
> +     * enabled on newer CPU modeles which can support topology extention=
.
> +     */
> +     DEFINE_PROP_BOOL("auto-topoext", X86CPU, auto_topoext, false),
> +
> +    /*
>       * From "Requirements for Implementing the Microsoft
>       * Hypervisor Interface":
>       * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-
> windows/reference/tlfs
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 89c82be..8783d36 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1409,6 +1409,11 @@ struct X86CPU {
>       */
>      bool legacy_cache;
>=20
> +    /* Compatibility bits to enable topoext feature on all newer machine=
s
> +     * Disabled on older machines. Enabled on newer CPU models
> +     */
> +    bool auto_topoext;
> +
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>=20
> --
> 1.8.3.1
