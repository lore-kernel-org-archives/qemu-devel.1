Received: from eggs.gnu.org ([2001:4830:134:3::10]:58990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fIGak-00005n-P0
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fIGag-00075Q-Dm
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:44:54 -0400
Received: from mail-co1nam03on0609.outbound.protection.outlook.com
	([2a01:111:f400:fe48::609]:47376
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fIGag-00072U-31
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:44:50 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Mon, 14 May 2018 16:44:44 +0000
Message-ID: <SN1PR12MB247774F4CB4D4A8AD05D3A1F959C0@SN1PR12MB2477.namprd12.prod.outlook.com>
References: <20180510204148.11687-1-babu.moger@amd.com>
	<20180510204148.11687-4-babu.moger@amd.com>
	<20180511192145.GV25013@localhost.localdomain>
	<BL0PR12MB24682473432EF64021381FAB959F0@BL0PR12MB2468.namprd12.prod.outlook.com>
	<20180511204759.GP13350@localhost.localdomain>
In-Reply-To: <20180511204759.GP13350@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 3/8] i386: Add new property to control
 cache info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "geoff@hostfission.com" <geoff@hostfission.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "kash@tripleback.net" <kash@tripleback.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>



> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Friday, May 11, 2018 3:48 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: geoff@hostfission.com; kvm@vger.kernel.org; mst@redhat.com;
> kash@tripleback.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> pbonzini@redhat.com; rth@twiddle.net
> Subject: Re: [Qemu-devel] [PATCH v8 3/8] i386: Add new property to contro=
l
> cache info
>=20
> On Fri, May 11, 2018 at 08:21:50PM +0000, Moger, Babu wrote:
> >
> > > -----Original Message-----
> > > From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> > > Sent: Friday, May 11, 2018 2:22 PM
> > > To: Moger, Babu <Babu.Moger@amd.com>
> > > Cc: mst@redhat.com; marcel.apfelbaum@gmail.com;
> pbonzini@redhat.com;
> > > rth@twiddle.net; mtosatti@redhat.com; qemu-devel@nongnu.org;
> > > kvm@vger.kernel.org; geoff@hostfission.com; kash@tripleback.net
> > > Subject: Re: [PATCH v8 3/8] i386: Add new property to control cache i=
nfo
> > >
> > > On Thu, May 10, 2018 at 03:41:43PM -0500, Babu Moger wrote:
> > > > The property legacy-cache will be used to control the cache
> information.
> > > > If user passes "-cpu legacy-cache" then older information will
> > > > be displayed even if the hardware supports new information.
> Otherwise
> > > > use the statically loaded cache definitions if available.
> > > >
> > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > > > ---
> > > >  include/hw/i386/pc.h |  8 ++++
> > > >  target/i386/cpu.c    | 97 ++++++++++++++++++++++++++++++++------
> -----
> > > -
> > > >  target/i386/cpu.h    |  5 +++
> > > >  3 files changed, 84 insertions(+), 26 deletions(-)
> > > >
> > > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > > index 2e834e6ded..df15deefca 100644
> > > > --- a/include/hw/i386/pc.h
> > > > +++ b/include/hw/i386/pc.h
> > > > @@ -304,6 +304,14 @@ int e820_add_entry(uint64_t, uint64_t,
> uint32_t);
> > > >  int e820_get_num_entries(void);
> > > >  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> > > >
> > > > +#define PC_COMPAT_2_12 \
> > > > +    HW_COMPAT_2_12 \
> > > > +    {\
> > > > +        .driver   =3D TYPE_X86_CPU,\
> > > > +        .property =3D "legacy-cache",\
> > > > +        .value    =3D "on",\
> > > > +    },
> > >
> > > This isn't enough if the pc-*-2.12 machine-type isn't using the
> > > macro.
> > >
> > > Before we do this, we need a commit similar to commit
> > > df47ce8af4a5, but adding pc-*-2.13 machine-types.
> >
> > Ok. Sure. I think I got it. Will add pc-*-2.13 machine-types in v9 seri=
es.
>=20
> Thanks.  If you submit v9, please use the x86-next tree as base
> so you don't need to resubmit the patches that I have already
> queued.  See MAINTAINERS for the git URL.

Submitted v9 version on top of you x86-next tree.  Thanks

>=20
> --
> Eduardo
