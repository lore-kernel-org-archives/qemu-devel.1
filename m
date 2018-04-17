Received: from eggs.gnu.org ([2001:4830:134:3::10]:35333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8ZUD-00069R-3M
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8ZU9-0006SX-64
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:54:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8ZU8-0006Qh-SU
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:54:01 -0400
Date: Tue, 17 Apr 2018 19:53:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180417225354.GI29865@localhost.localdomain>
References: <20171010003951-mutt-send-email-mst@kernel.org>
	<20171010083143.GA30015@redhat.com>
	<CAJ+F1CLGJLXYnJ8SnrbVkWc6bdU2geYKeEaKrxWaYBhXwA=Opg@mail.gmail.com>
	<20171010150628.GI30015@redhat.com>
	<20171010180110.GI3246@localhost.localdomain>
	<20171015044800-mutt-send-email-mst@kernel.org>
	<20171020184820.GP2942@localhost.localdomain>
	<a5ff2864-f794-e728-5be1-0c1e58d9f163@redhat.com>
	<20180417211126.GD29865@localhost.localdomain>
	<f822d32f-5d0f-aa42-95a8-46afd4923d45@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f822d32f-5d0f-aa42-95a8-46afd4923d45@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/7] hw/misc: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Dave Anderson <anderson@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Martin Kletzander <mkletzan@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Tue, Apr 17, 2018 at 06:31:57PM -0400, Cole Robinson wrote:
> On 04/17/2018 05:11 PM, Eduardo Habkost wrote:
> > On Tue, Apr 17, 2018 at 03:12:03PM -0400, Cole Robinson wrote:
> > [...]
> >> Reviving this... did any follow up changes happen?
> >>
> >> Marc-Andr=E9 patched virt-manager a few months back to enable -devic=
e
> >> vmcoreinfo for new VMs:
> >>
> >> https://www.redhat.com/archives/virt-tools-list/2018-February/msg000=
20.html
> >>
> >> And I see there's at least a bug tracking adding this to openstack f=
or
> >> new VMs:
> >>
> >> https://bugzilla.redhat.com/show_bug.cgi?id=3D1555276
> >>
> >> If this feature doesn't really have any downsides, it would be nice =
to
> >> get this tied to new machine types. Saves a lot of churn for higher
> >> levels of the stack
> >=20
> > I understand this would be nice to have considering the existing
> > stacks, but at the same time I would like the rest of the
> > stack(s) to really try to not depend on QEMU machine-types to
> > define policy/defaults.
> >=20
> > Every feature that is hidden behind an opaque machine-type name
> > and not visible in the domain XML and QEMU command-line increases
> > the risk of migration and compatibility bugs.
> >=20
>=20
> What exactly is the migration compatibility issue with turning on the
> equivalent of -device vmcoreinfo for -M *-2.13+ ? Possibly prevents
> backwards migration to older qemu but is that even a goal?

I mean the extra migration compatibility code that needs to be
maintained on older machine-types.  It's extra maintenance burden
on both upstream and downstream QEMU trees.


>=20
> > This was being discussed in a mail thread at:
> > https://www.mail-archive.com/ovirt-devel@redhat.com/msg01196.html
> >=20
> > Quoting Daniel, on that thread:
> >=20
> > ] Another case is the pvpanic device - while in theory that could
> > ] have been enabled by default for all guests, by QEMU or a config
> > ] generator library, doing so is not useful on its own. The hard
> > ] bit of the work is adding code to the mgmt app to choose the
> > ] action for when pvpanic triggers, and code to handle the results
> > ] of that action.
> >=20
> > From that comment, I understand that simply making QEMU create a
> > pvpanic device by default on pc-2.13+ won't be useful at all?
> >=20
>=20
> This qemu-devel thread was about -device vmcoreinfo though, not pvpanic=
.
> vmcoreinfo doesn't need anything else to work AFAICT and shouldn't need
> any explicit config, heck it doesn't even have any -device properties.
>=20
> Like Dan says pvpanic isn't a 'just works' thing, and I know for window=
s
> VMs it shows up in device manager which has considerations for things
> like SVVP. I think vmcoreinfo doesn't have the same impact
>=20

Oops, nevermind.  I confused both.


> There are some guest visible things that we have turned on for new
> machine types in the past, pveoi and x2apic comes to mind.

Yes, we have tons of guest-visible things that we tie to the
machine-type.  What I'm looking for is a solution to make this
less frequent in the future.

--=20
Eduardo
