Received: from eggs.gnu.org ([2001:4830:134:3::10]:44344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fQvpx-0007f8-7X
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fQvpt-000548-7c
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:24:25 -0400
Received: from mail-dm3nam03on0042.outbound.protection.outlook.com
	([104.47.41.42]:42496
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fQvps-00053c-UR
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:24:21 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Thu, 7 Jun 2018 14:24:18 +0000
Message-ID: <DM5PR12MB2471DF38865A11BD0D08F8CE95640@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
	<1528295806-90593-3-git-send-email-babu.moger@amd.com>
	<20180606220531.GC7451@localhost.localdomain>
In-Reply-To: <20180606220531.GC7451@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v12 2/4] i386: Verify if topoext feature
 can be supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Wednesday, June 6, 2018 5:06 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: mst@redhat.com; marcel.apfelbaum@gmail.com; pbonzini@redhat.com;
> rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; kash@tripleback.net; geoff@hostfission.com
> Subject: Re: [PATCH v12 2/4] i386: Verify if topoext feature can be suppo=
rted
>=20
> On Wed, Jun 06, 2018 at 10:36:44AM -0400, Babu Moger wrote:
> > topoext feature cannot be supported in certain cases
> > with large number of cores or threads. Add the check.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  target/i386/cpu.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 86fb1a4..fc5c66d 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -509,6 +509,20 @@ static void encode_topo_cpuid8000001e(CPUState
> *cs, X86CPU *cpu,
> >  }
> >
> >  /*
> > + * Check if we can support this topology
> > + * Fail if number of cores are beyond the supported config
> > + * or nr_threads is more than 2
> > + */
> > +static int topology_supports_topoext(int nr_cores, int nr_threads)
> > +{
> > +    if ((nr_cores > (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET))
> ||
> > +        (nr_threads > 2)) {
> > +        return 0;
> > +    }
> > +    return 1;
> > +}
> > +
> > +/*
> >   * Definitions of the hardcoded cache entries we expose:
> >   * These are legacy cache values. If there is a need to change any
> >   * of these values please use builtin_x86_defs
> > @@ -4941,6 +4955,19 @@ static void x86_cpu_realizefn(DeviceState *dev,
> Error **errp)
> >
> >      qemu_init_vcpu(cs);
> >
> > +    /* On AMD systems, check if we can support topoext feature */
> > +    if (IS_AMD_CPU(env) &&
> > +        (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT)) {
> > +        if (!topology_supports_topoext(cs->nr_cores, cs->nr_threads)) =
{
> > +                /* Cannot support topoext */
> > +                error_setg(errp, "CPU model does not support topoext f=
eature "
> > +                                 "with number of cores(%d) and threads=
(%d). "
> > +                                 "Please configure -smp options proper=
ly.",
> > +                                 cs->nr_cores, cs->nr_threads);
>=20
> See error.h documentation:
>=20
>  * Error reporting system loosely patterned after Glib's GError.
>  *
>  * Create an error:
>  *     error_setg(&err, "situation normal, all fouled up");
>  *
>  * Create an error and add additional explanation:
>  *     error_setg(&err, "invalid quark");
>  *     error_append_hint(&err, "Valid quarks are up, down, strange, "
>  *                       "charm, top, bottom.\n");
>  *
>  * Do *not* contract this to
>  *     error_setg(&err, "invalid quark\n"
>  *                "Valid quarks are up, down, strange, charm, top, bottom=
.");
>  *
>=20
> I suggest something like this:

Sure. I will make these changes. Thanks

>=20
> static bool topology_supports_topoext(int nr_cores, int nr_threads, Error
> **errp)
> {
>     if (nr_cores > (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET))) {
>         error_setg(errp, "TOPOEXT unsupported with %d cores per socket",
> nr_cores);
>         error_append_hint(errp, "TOPOEXT supports only up to %d cores per
> socket",
>                           (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
>         return false;
>     }
>     if (nr_threads > 2) {
>         error_setg(errp, "TOPOEXT unsupported with %d threads per core",
> nr_threads);
>         error_append_hint(errp, "TOPOEXT supports only up to 2 threads pe=
r
> core");
>                           (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
>         return false;
>     }
>     return true;
> }
>=20
> static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> {
>     /* ... */
>     if (IS_AMD_CPU(env) &&
>         (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
>         !topology_supports_topoext(cs->nr_cores, cs->nr_threads, errp)) {
>             return;
>     }
>     /* ... */
> }
>=20
> --
> Eduardo
