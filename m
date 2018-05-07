Received: from eggs.gnu.org ([2001:4830:134:3::10]:40045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fFpo6-0006ta-EM
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fFpo2-0006rP-FQ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:44:38 -0400
Received: from mail-bl2nam02on0058.outbound.protection.outlook.com
	([104.47.38.58]:9504
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fFpo2-0006r5-9w
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:44:34 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 7 May 2018 23:44:31 +0000
Message-ID: <BL0PR12MB2468B701C4DF796ABF9EAD3D959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-8-git-send-email-babu.moger@amd.com>
	<20180507193944.GF13350@localhost.localdomain>
In-Reply-To: <20180507193944.GF13350@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 7/9] i386: Add support for
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
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "geoff@hostfission.com" <geoff@hostfission.com>, "kash@tripleback.net" <kash@tripleback.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Monday, May 7, 2018 2:40 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel@redhat.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> Subject: Re: [Qemu-devel] [PATCH v7 7/9] i386: Add support for
> CPUID_8000_001E for AMD
>=20
> On Thu, Apr 26, 2018 at 11:26:47AM -0500, Babu Moger wrote:
> > Populate threads/core_id/apic_ids/socket_id when CPUID_EXT3_TOPOEXT
> > feature is supported. This is required to support hyperthreading featur=
e
> > on AMD CPUs. This is supported via CPUID_8000_001E extended functions.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > ---
> >  target/i386/cpu.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 1024b09..1b15023 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -315,6 +315,12 @@ static uint32_t
> encode_cache_cpuid80000005(CPUCacheInfo *cache)
> >                           (((CORES_IN_CMPLX - 1) * 2) + 1)  : \
> >                           (CORES_IN_CMPLX - 1))
> >
> > +/* Definitions used on CPUID Leaf 0x8000001E */
> > +#define EXTENDED_APIC_ID(threads, socket_id, core_id, thread_id) \
> > +                        ((threads) ? \
> > +                         ((socket_id << 6) | (core_id << 1) | thread_i=
d) : \
> > +                         ((socket_id << 6) | core_id))
>=20
> I suggest moving this to i386/topology.h.


Ok. Will do that.

>=20
>=20
> > +
> >  /*
> >   * Encode cache info for CPUID[0x80000006].ECX and
> CPUID[0x80000006].EDX
> >   * @l3 can be NULL.
> > @@ -4105,6 +4111,14 @@ void cpu_x86_cpuid(CPUX86State *env,
> uint32_t index, uint32_t count,
> >              break;
> >          }
> >          break;
> > +    case 0x8000001E:
> > +        assert(cpu->core_id <=3D 255);
>=20
> Where's the code that ensures this assert() line can't be
> triggered by any command-line configuration?

I did not understand this. Can you please elaborate. Thanks=20

>=20
> > +        *eax =3D EXTENDED_APIC_ID((cs->nr_threads - 1),
> > +               cpu->socket_id, cpu->core_id, cpu->thread_id);
> > +        *ebx =3D (cs->nr_threads - 1) << 8 | cpu->core_id;
> > +        *ecx =3D cpu->socket_id;
> > +        *edx =3D 0;
> > +        break;
> >      case 0xC0000000:
> >          *eax =3D env->cpuid_xlevel2;
> >          *ebx =3D 0;
> > --
> > 2.7.4
> >
> >
>=20
> --
> Eduardo
