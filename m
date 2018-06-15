Received: from eggs.gnu.org ([2001:4830:134:3::10]:57956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTscP-00076w-FM
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTscM-00056L-6j
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:34:37 -0400
Received: from mail-sn1nam01on0055.outbound.protection.outlook.com
	([104.47.32.55]:21067
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTscL-00055f-U5
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:34:34 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Fri, 15 Jun 2018 17:34:30 +0000
Message-ID: <DM5PR12MB2471CC9A8FE01A13F4DD03B0957C0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1529082947-60001-1-git-send-email-babu.moger@amd.com>
	<1529082947-60001-2-git-send-email-babu.moger@amd.com>
In-Reply-To: <1529082947-60001-2-git-send-email-babu.moger@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v15 1/3] i386: Fix up the Node id for
 CPUID_8000_001E
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>



> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
> On Behalf Of Babu Moger
> Sent: Friday, June 15, 2018 12:16 PM
> To: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; ehabkost@redhat.com
> Cc: qemu-devel@nongnu.org; mtosatti@redhat.com; kvm@vger.kernel.org;
> kash@tripleback.net; geoff@hostfission.com; Moger, Babu
> <Babu.Moger@amd.com>
> Subject: [PATCH v15 1/3] i386: Fix up the Node id for CPUID_8000_001E
>=20
> This is part of topoext support. To keep the compatibility, we need
> to support all the combination of nr_cores and nr_threads currently
> supported. With this combination, we might end up with more nodes than
> we can support with real hardware. We need to fix up the node id to
> accommodate more nodes here. We can achieve this by shifting the bits.
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7a4484b..5246be4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -19,6 +19,7 @@
>=20
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qemu/bitops.h"
>=20
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> @@ -472,6 +473,8 @@ static void encode_topo_cpuid8000001e(CPUState
> *cs, X86CPU *cpu,
>                                         uint32_t *ecx, uint32_t *edx)
>  {
>      struct core_topology topo =3D {0};
> +    unsigned long nodes;
> +    int shift;
>=20
>      build_core_topology(cs->nr_cores, cpu->core_id, &topo);
>      *eax =3D cpu->apic_id;
> @@ -504,7 +507,25 @@ static void encode_topo_cpuid8000001e(CPUState
> *cs, X86CPU *cpu,
>       *         2  Socket id
>       *       1:0  Node id
>       */
> -    *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
> topo.node_id;
> +    if (topo.num_nodes <=3D 4) {
> +        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
> +                topo.node_id;
> +    } else {
> +        /*
> +         * Node id fix up. Actual hardware supports up to 4 nodes. But w=
ith
> +         * more than 32 cores, we may end up with more than 4 nodes.
> +         * Node id is a combination of socket id and node id. Only requi=
rement
> +         * here is that this number should be unique accross the system.
> +         * Shift the socket id to accommodate more nodes. We dont expect
> both
> +         * socket id and node id to be big number at the same time. This=
 is not
> +         * an ideal config but we need to to support it. Max bit we can =
have
> +         * here is 8.
> +         */
> +        nodes =3D topo.num_nodes - 1;
> +        shift =3D find_last_bit(&nodes, 8);
> +        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << shift)=
 |

Sorry. There is a bug here.  This should be (cpu->socket_id << (shift + 1) =
). I will fix it.  Let me know the rest of the code.


> +                topo.node_id;
> +    }
>      *edx =3D 0;
>  }
>=20
> --
> 1.8.3.1
