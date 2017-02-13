Received: from eggs.gnu.org ([2001:4830:134:3::10]:46895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cdGrU-0003xr-Ua
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cdGrQ-0000qs-Gc
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:40:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cdGrQ-0000pb-8J
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:40:08 -0500
Date: Mon, 13 Feb 2017 14:40:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170213144002.65b8f81d@nial.brq.redhat.com>
In-Reply-To: <20170213145827-mutt-send-email-mst@kernel.org>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<88aaebda-29dd-a77a-1b78-7d0d6f911a76@redhat.com>
	<20170210172107-mutt-send-email-mst@kernel.org>
	<20170210171659.111aedda@nial.brq.redhat.com>
	<20170210181852.zp6sg2d4k2p3xhbd@hawk.localdomain>
	<d902a6b9-4a46-9010-b597-5e98388d10f4@suse.de>
	<20170213120036.7712fccb@nial.brq.redhat.com>
	<20170213145827-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/10] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, ben@skyportsystems.com, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 13 Feb 2017 15:00:22 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Feb 13, 2017 at 12:00:36PM +0100, Igor Mammedov wrote:
> > On Fri, 10 Feb 2017 19:27:21 +0100
> > Andreas F=C3=A4rber <afaerber@suse.de> wrote:
> >  =20
> > > Am 10.02.2017 um 19:18 schrieb Andrew Jones: =20
> > > > On Fri, Feb 10, 2017 at 05:16:59PM +0100, Igor Mammedov wrote:   =20
> > > >> On Fri, 10 Feb 2017 17:31:33 +0200
> > > >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >>   =20
> > > >>> On Fri, Feb 10, 2017 at 11:12:13AM +0100, Laszlo Ersek wrote:   =
=20
> > > >>>> On 02/05/17 10:11, ben@skyportsystems.com wrote:     =20
> > > >>>>> From: Ben Warren <ben@skyportsystems.com>   =20
> > > >> [...]
> > > >>   =20
> > > >>>>
> > > >>>> - or else, add another boolean property to vmgenid, one that par=
allels
> > > >>>> "dma-enabled" of "fw-cfg" precisely, in HW_COMPAT*. Then simply =
fail
> > > >>>> realize() when this property is false.     =20
> > > >>>
> > > >>> That's probably the easiest way. x-fw-cfg-dma-enabled.
> > > >>> Won't delay merging because of this, can be done with
> > > >>> patch on top.   =20
> > > >> (not related to this series)
> > > >>
> > > >> I've thought that there still were no consensus on x-foo prefix,
> > > >> not to mention that x- might be legitimate prefix for some propert=
ies.
*1

> > > >>
> > > >> Maybe we should add a flag to property like INTERNAL_PROPERTY
> > > >> and then set it explicitly on for internal stuff.
> > > >>
> > > >> That way we could cleanly exclude internal properties from
> > > >>  -device foo,help and make sure that user won't set them from CLI.
> > > >> I'd even volunteer to add this API to Object   =20
> > > >=20
> > > > Yes, please. I know of a property or two where it would be nice to
> > > > have that flag.   =20
> > >=20
> > > Apart from documentation, what effect would such a flag have?
> > >=20
> > > With QOM I don't really see "internal" as being a thing: Besides -dev=
ice
> > > and the likes, we expose qom-set operation and -global option, and I
> > > don't think it makes sense to restrict the latter two. For -device,
> > > "realized" is a property I would classify as non-user maybe. =20
> > I'd propose to start with this flag hiding/forbiding usage of
> > property in following interfaces:
> >=20
> >   * -device
> >   * -device foo,help
> >   * device_add
> >=20
> > With docs mentioning that usage of hidden properties with
> >  -globals/qom-set isn't recommended. =20
>=20
> I'm not sure I agree. These properties can be useful e.g. for debugging,
> the only issue is we don't guarantee to support them across QEMU
> releases. If you won't want something exposed to users, don't make it a
> property at all.
Property approach is cleaner especially in cases where
it's used to tie together generic with target-specific code
+ automatically makes feature introspect-able via qom-get
(I've used it for debugging to poke into object properties
without need for gdb).
Replacing property with direct function call makes one
to create stubs (I've seen Paolo working on removing stubs)
for targets that do not implement it or uglifying headers with
target specific ifdefs.

> Producing a warning when a property starting with x- is set
> might not be a bad idea.
I don't like x- prefix for above [1] and
we already have a bunch of properties that shouldn't be
user settable that makes x- convention inconsistent.
so how about following:
   * -device foo,help:
       * hide non user flagged properties or
       *less preferable mark them as non stable/supportable
   * issue warning in case such property is used
     with -device/device_add
   * since it's warning we could probably put it in -globals as well
     so user would notice probable misuse
 =20

> > >=20
> > > Regards,
> > > Andreas
> > >  =20
>=20
