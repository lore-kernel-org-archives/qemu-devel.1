Received: from eggs.gnu.org ([2001:4830:134:3::10]:59645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fFov2-0003AS-3H
	for qemu-devel@nongnu.org; Mon, 07 May 2018 18:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fFouz-0000QO-FW
	for qemu-devel@nongnu.org; Mon, 07 May 2018 18:47:44 -0400
Received: from mail-by2nam01on0058.outbound.protection.outlook.com
	([104.47.34.58]:59894
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fFouz-0000Op-0o
	for qemu-devel@nongnu.org; Mon, 07 May 2018 18:47:41 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 7 May 2018 22:47:36 +0000
Message-ID: <BL0PR12MB24680A8B8EAAD6C75BB53B3D959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-2-git-send-email-babu.moger@amd.com>
	<20180507190501.GA13350@localhost.localdomain>
	<BL0PR12MB24682009D5F23F48755C2A7F959B0@BL0PR12MB2468.namprd12.prod.outlook.com>
	<20180507212726.GK13350@localhost.localdomain>
In-Reply-To: <20180507212726.GK13350@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 1/9] i386: Helpers to encode cache
 information consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "geoff@hostfission.com" <geoff@hostfission.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "kash@tripleback.net" <kash@tripleback.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcel@redhat.com" <marcel@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Monday, May 7, 2018 4:27 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: geoff@hostfission.com; kvm@vger.kernel.org; mst@redhat.com;
> kash@tripleback.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> marcel@redhat.com; pbonzini@redhat.com; rth@twiddle.net
> Subject: Re: [Qemu-devel] [PATCH v7 1/9] i386: Helpers to encode cache
> information consistently
>=20
> On Mon, May 07, 2018 at 09:14:27PM +0000, Moger, Babu wrote:
> > Eduardo,
> >    Thanks for all the comments. Will respond to each one separately.
> >
> > > -----Original Message-----
> > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > Sent: Monday, May 7, 2018 2:05 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: mst@redhat.com; marcel@redhat.com; pbonzini@redhat.com;
> > > rth@twiddle.net; mtosatti@redhat.com; geoff@hostfission.com;
> > > kash@tripleback.net; qemu-devel@nongnu.org; kvm@vger.kernel.org
> > > Subject: Re: [Qemu-devel] [PATCH v7 1/9] i386: Helpers to encode cach=
e
> > > information consistently
> > >
> > > Hi,
> > >
> > > I was about to apply this because I assumed it was the same patch
> > > I sent in March, but then I found this:
> > >
> > > On Thu, Apr 26, 2018 at 11:26:41AM -0500, Babu Moger wrote:
> > > > From: Eduardo Habkost <ehabkost@redhat.com>
> > > >
> > > > Instead of having a collection of macros that need to be used in
> > > > complex expressions to build CPUID data, define a CPUCacheInfo
> > > > struct that can hold information about a given cache.  Helper
> > > > functions will take a CPUCacheInfo struct as input to encode
> > > > CPUID leaves for a cache.
> > > >
> > > > This will help us ensure consistency between cache information
> > > > CPUID leaves, and make the existing inconsistencies in CPUID info
> > > > more visible.
> > > >
> > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > > [...]
> > > > -#define L2_ASSOCIATIVITY      16
> > > [...]
> > > >  /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 *=
/
> > > > +static CPUCacheInfo l2_cache_amd =3D {
> > > [...]
> > > > +    .associativity =3D 8,
> > > [...]
> > > > +};
> > > [...]
> > > >      case 0x80000006:
> > > [...]
> > > > -        *ecx =3D (L2_SIZE_KB_AMD << 16) | \
> > > > -               (AMD_ENC_ASSOC(L2_ASSOCIATIVITY) << 12) | \
> > > > -               (L2_LINES_PER_TAG << 8) | (L2_LINE_SIZE);
> > > [...]
> > > > +        encode_cache_cpuid80000006(&l2_cache_amd,
> > > > +                                   cpu->enable_l3_cache ? &l3_cach=
e : NULL,
> > > > +                                   ecx, edx);
> > > [...]
> > >
> > > The structs added by this patch are supposed to represent the
> > > legacy cache sizes, and must match the old code.  My original
> > > patch set l2_cache_amd.associativity=3D16 because of that.
> > >
> > > This patch changes 0x80000006 from associativity=3D16 to
> > > associativity=3D8.  Why?
> >
> > The original code had a bug here.   The associativity should have been =
8.
> > My earlier response from the thread
> > http://patchwork.ozlabs.org/patch/884880/
> >
> > This should have been 8-way. This is a bug. Will fix.
> > This should have been (AMD_ENC_ASSOC(L2_ASSOCIATIVITY_AMD) <<
> 12)
>=20
> If we want to change the associativity, we must keep the old
> values on older machine-types, which was the whole purpose of the
> "legacy-cache" property.
>=20
> I suggest using the new X86CPUDefinition::cache_info field if you
> want to make AMD CPUs report different associativity.

Ok. Sure. I will change it. Thanks

>=20
> --
> Eduardo
