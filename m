Received: from eggs.gnu.org ([2001:4830:134:3::10]:47850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQw3q-0001Je-BB
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQw3n-0003hU-81
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:38:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQw3m-0003fi-V9
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:38:43 -0400
Date: Thu, 7 Jun 2018 11:38:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180607143835.GF7451@localhost.localdomain>
References: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
	<1528295806-90593-3-git-send-email-babu.moger@amd.com>
	<20180606220531.GC7451@localhost.localdomain>
	<DM5PR12MB2471DF38865A11BD0D08F8CE95640@DM5PR12MB2471.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB2471DF38865A11BD0D08F8CE95640@DM5PR12MB2471.namprd12.prod.outlook.com>
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
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Jun 07, 2018 at 02:24:18PM +0000, Moger, Babu wrote:
[...]
> > > +    /* On AMD systems, check if we can support topoext feature */
> > > +    if (IS_AMD_CPU(env) &&
> > > +        (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT)) {
> > > +        if (!topology_supports_topoext(cs->nr_cores, cs->nr_threads)) {
> > > +                /* Cannot support topoext */
> > > +                error_setg(errp, "CPU model does not support topoext feature "
> > > +                                 "with number of cores(%d) and threads(%d). "
> > > +                                 "Please configure -smp options properly.",
> > > +                                 cs->nr_cores, cs->nr_threads);
> > 
> > See error.h documentation:
> > 
> >  * Error reporting system loosely patterned after Glib's GError.
> >  *
> >  * Create an error:
> >  *     error_setg(&err, "situation normal, all fouled up");
> >  *
> >  * Create an error and add additional explanation:
> >  *     error_setg(&err, "invalid quark");
> >  *     error_append_hint(&err, "Valid quarks are up, down, strange, "
> >  *                       "charm, top, bottom.\n");
> >  *
> >  * Do *not* contract this to
> >  *     error_setg(&err, "invalid quark\n"
> >  *                "Valid quarks are up, down, strange, charm, top, bottom.");
> >  *
> > 
> > I suggest something like this:
> 
> Sure. I will make these changes. Thanks

Thanks.  Note that I have made a mistake below, by not including
a newline in error_append_hint().

Also, I'm not sure if it's better to mention the current value of
nr_cores in error_setg() or just in the error hint.  Markus, do
you have any suggestion?

> 
> > 
> > static bool topology_supports_topoext(int nr_cores, int nr_threads, Error
> > **errp)
> > {
> >     if (nr_cores > (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET))) {
> >         error_setg(errp, "TOPOEXT unsupported with %d cores per socket",
> > nr_cores);
> >         error_append_hint(errp, "TOPOEXT supports only up to %d cores per
> > socket",
> >                           (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
> >         return false;
> >     }
> >     if (nr_threads > 2) {
> >         error_setg(errp, "TOPOEXT unsupported with %d threads per core",
> > nr_threads);
> >         error_append_hint(errp, "TOPOEXT supports only up to 2 threads per
> > core");
> >                           (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET));
> >         return false;
> >     }
> >     return true;
> > }
> > 
> > static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> > {
> >     /* ... */
> >     if (IS_AMD_CPU(env) &&
> >         (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
> >         !topology_supports_topoext(cs->nr_cores, cs->nr_threads, errp)) {
> >             return;
> >     }
> >     /* ... */
> > }
> > 
> > --
> > Eduardo

-- 
Eduardo
