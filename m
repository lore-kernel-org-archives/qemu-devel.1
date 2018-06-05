Received: from eggs.gnu.org ([2001:4830:134:3::10]:47305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fQECx-0007t4-Tc
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fQECu-0007cX-OT
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:49:15 -0400
Received: from mail-sn1nam01on0086.outbound.protection.outlook.com
	([104.47.32.86]:53280
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fQECu-0007c5-Eg
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:49:12 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Tue, 5 Jun 2018 15:49:08 +0000
Message-ID: <BL0PR12MB2468544AC76BE854470EE26995660@BL0PR12MB2468.namprd12.prod.outlook.com>
References: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
	<1527176614-26271-4-git-send-email-babu.moger@amd.com>
	<20180605024620.GI3184@localhost.localdomain>
In-Reply-To: <20180605024620.GI3184@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 3/5] i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "geoff@hostfission.com" <geoff@hostfission.com>, "kash@tripleback.net" <kash@tripleback.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Monday, June 4, 2018 9:46 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> Subject: Re: [Qemu-devel] [PATCH v11 3/5] i386: Add support for
> CPUID_8000_001E for AMD
>=20
> On Thu, May 24, 2018 at 11:43:32AM -0400, Babu Moger wrote:
> > Add support for cpuid leaf CPUID_8000_001E. Build the config that close=
ly
> > match the underlying hardware. Please refer to the Processor
> Programming
> > Reference (PPR) for AMD Family 17h Model for more details.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  target/i386/cpu.c | 61
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 0d423e5..9f8bad9 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -429,6 +429,62 @@ static void
> encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
> >             (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
> >  }
> >
> > +/* Data structure to hold the configuration info for a given core inde=
x */
> > +struct core_topology {
> > +    /* core complex id of the current core index */
> > +    int ccx_id;
> > +    /* Adjusted core id for this core index in the topology */
>=20
> What's an "adjusted core id"?

When you build the topology, "adjusted core id" is the core index inside th=
e core complex.
There can be max 4 cores in a core complex, so this id can be 0, 1, 2, 3.  =
I will change the name to ccx_core_index;=20
>=20
> > +    int core_id;
> > +    /* Node id for this core index */
> > +    int node_id;
> > +    /* Number of nodes in this config, 0 based */
> > +    int num_nodes;
>=20
> I suggest making num_nodes carry the actual number of nodes, and
> using (num_nodes - 1) when building CPUID data.

Sure. Will do
>=20
> > +};
> > +
> > +/*
> > + * Build the configuration closely match the EPYC hardware. Using the
> EPYC
> > + * hardware configuration values (MAX_CCX, MAX_CORES_IN_CCX,
> MAX_CORES_IN_NODE)
> > + * right now. This could change in future.
> > + * nr_cores : Total number of cores in the config
> > + * core_id  : Core index of the current CPU
> > + * topo     : Data structure to hold all the config info for this core=
 index
> > + */
> > +static void build_core_topology(int nr_cores, int core_id,
> > +                                struct core_topology *topo)
> > +{
> > +    int nodes, cores_in_ccx;
> > +
> > +    /* First get the number of nodes required */
> > +    nodes =3D nodes_in_socket(nr_cores);
> > +
> > +    cores_in_ccx =3D cores_in_core_complex(nr_cores);
> > +
> > +    topo->node_id =3D core_id / (cores_in_ccx * MAX_CCX);
> > +    topo->ccx_id =3D (core_id % (cores_in_ccx * MAX_CCX)) / cores_in_c=
cx;
> > +    topo->core_id =3D core_id % cores_in_ccx;
> > +    /* num_nodes is 0 based, return n - 1 */
> > +    topo->num_nodes =3D nodes - 1;
> > +}
>=20
> Is this guaranteed to work with any nr_cores value, or only with
> a few specific values that match real hardware?

I have tested all the supported core values(1 to 32). All of them work fine=
.

>=20
>=20
>=20
> > +
> > +/* Encode cache info for CPUID[8000001E] */
> > +static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
> > +                                       uint32_t *eax, uint32_t *ebx,
> > +                                       uint32_t *ecx, uint32_t *edx)
> > +{
> > +    struct core_topology topo =3D {0};
> > +
> > +    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
> > +    *eax =3D cpu->apic_id;
> > +    if (cs->nr_threads - 1) {
> > +        *ebx =3D ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
> > +                (topo.ccx_id << 2) | topo.core_id;
> > +    } else {
> > +        *ebx =3D (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_=
id;
> > +    }
>=20
> This part confuses me a lot.  Where are those bit offsets in EBX
> defined?

Bit 7-0 is core id. This decodes to where in the topology the core is locat=
ed.
(2 bits for node,  2 bits for core complex and 3 bit index).
I will add those details in the comments.
=20
>=20
> Is this guaranteed to work with any cs->nr_cores value?
>=20
>=20
> > +    *ecx =3D (topo.num_nodes << 8) | (cpu->socket_id << 2) | topo.node=
_id;
>=20
> Like on EBX, I'm confused by the bit offsets.  Where are they
> defined?
>=20

Bit 7-0 is Node id.  This decodes to 1 bit for socket and 2 bits for node_i=
d.
I will add those details in comments.

> Probably it's safer to not allow TOPOEXT to be enabled if the CPU
> socket/core/thread topology configuration can't generate a sane
> node/core-complex topology.

Like I said before It may become too restrictive.  I have tested all the nu=
mbers (1 to 32).
They all appear to work ok.

>=20
>=20
> > +    *edx =3D 0;
> > +}
> > +
> >  /*
> >   * Definitions of the hardcoded cache entries we expose:
> >   * These are legacy cache values. If there is a need to change any
> > @@ -4122,6 +4178,11 @@ void cpu_x86_cpuid(CPUX86State *env,
> uint32_t index, uint32_t count,
> >              break;
> >          }
> >          break;
> > +    case 0x8000001E:
> > +        assert(cpu->core_id <=3D 255);
> > +        encode_topo_cpuid8000001e(cs, cpu,
> > +                                  eax, ebx, ecx, edx);
> > +        break;
> >      case 0xC0000000:
> >          *eax =3D env->cpuid_xlevel2;
> >          *ebx =3D 0;
> > --
> > 1.8.3.1
> >
> >
>=20
> --
> Eduardo
