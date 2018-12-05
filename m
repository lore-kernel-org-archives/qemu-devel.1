Received: from eggs.gnu.org ([2001:4830:134:3::10]:39489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gUakz-0006Wu-Ja
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gUag5-0004lY-Ea
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:09:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1gUag1-0004S0-Ej
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:09:34 -0500
Date: Wed, 5 Dec 2018 18:09:16 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20181205170916.GK799@angien.pipo.sk>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<CAKPgXcE1zoFiBgbEqn6VAdsQuR7GfCNTn+pHgekH1XwLAdq-ig@mail.gmail.com>
	<154402670926.16620.2184992513838364109@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
Content-Disposition: inline
In-Reply-To: <154402670926.16620.2184992513838364109@sif>
Subject: Re: [Qemu-devel] [libvirt] [RFC 0/2] Attempt to implement the
 standby feature for assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, libvir-list@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 10:18:29 -0600, Michael Roth wrote:
> Quoting Sameeh Jubran (2018-10-25 13:01:10)
> > On Thu, Oct 25, 2018 at 5:06 PM Sameeh Jubran <sameeh@daynix.com> wrote:
> > > From: Sameeh Jubran <sjubran@redhat.com>
> > > Migration support:
> > >
> > > Pre migration or during setup phase of the migration we should send an
> > > unplug request to the guest to unplug the primary device. I haven't h=
ad
> > > the chance to implement that part yet but should do soon. Do you know
> > > what's the best approach to do so? I wanted to have a callback to the
> > > virtio-net device which tries to send an unplug request to the guest =
and
> > > if succeeds then the migration continues. It needs to handle the case=
 where
> > > the migration fails and then it has to replug the primary device back.
> > I think that the "add_migration_state_change_notifier" API call can be =
used
> > from within the virtio-net device to achieve this, what do you think?
>=20
> I think it would be good to hear from the libvirt folks (on Cc:) on this =
as
> having QEMU unplug a device without libvirt's involvement seems like it
> could cause issues. Personally I think it seems cleaner to just have QEMU
> handle the 'hidden' aspects of the device and leave it to QMP/libvirt to =
do
> the unplug beforehand. On the libvirt side I could imagine adding an opti=
on
> like virsh migrate --switch-to-standby-networking or something along
> that line to do it automatically (if we decide doing it automatically is
> even needed on that end).

I remember talking about this approach some time ago.

In general the migration itself is a very complex process which has too
many places where it can fail. The same applies to device hotunplug.
This series proposes to merge those two together into an even more
complex behemoth.

Few scenarios which don't have clear solution come into my mind:
- Since unplug request time is actually unbounded. The guest OS may
  arbitrarily reject it or execute it at any later time, migration may get
  stuck in a halfway state without any clear rollback or failure scenario.

- After migration, device hotplug may fail for whatever reason, leaving
  networking crippled and again no clear single-case rollback scenario.

Then there's stuff which requires libvirt/management cooperation
- picking of the network device on destination
- making sure that the device is present etc.

=46rom managements point of view, bundling all this together is really not
a good idea since it creates a very big matrix of failure scenarios. In
general even libvirt will prefer that upper layer management drives this
externally, since any rolback scenario will result in a policy decision
of what to do in certain cases, and what timeouts to pick.


--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlwIBjgACgkQHGwCByjY
1Gp41g/+LkWN48EyqYiL9DW6pktnVKMVEUzlJJ5LspHPsQsiE+268H/wvf0DFQ0A
0L/WRzNoSIiqbvEQperCYwMM+lhoBv6xfS6XQqx9N9tsBJdS1WVagY3r3gaNC1uq
+/1HcytVLJDfrdy8JQA+zW2ozx33SFpOLv47MbdaG4Pb9qzcSRXFKzLxdfBFR3r5
ok7Sd+DWq/vH8oF25qm7/SABUgKWrJHClHLB1nWDB4XPanWW5x16hjxRReLAVx+R
0kmVcN3r6mcSi4R90yqOe+1vE2I76jqiPk8s/xx+OwdAYZ0d+xovCqbdq7OXM0PE
7QAdVoqmNJ0AZSMmv9uu+fvi/xtVmihyAEUlAW4Ljgjbqj0VfG/MBgPs/NkngBcW
0HGUMO5eJPAY/Lk+RqpdPPH8eELlr+NbUD6NJ1TCbUblhDuO5S/uDYzhXhHQdNXs
sWxeNTRTYJySleU6M2f/nqxd/QHU8HToDgz2a3KEd61zt9JZZtBK6yMCBwi2eE4c
8Dc3Vy9YQbQhzG9ixtxUZK1m7aLnjpGb7ffp79z31zsRjA+UcfUsUbjfWcuPQigc
8Tu+ICbYQPWV94E9KjnTNqkV2Q3t0rj9LOLVsRHOGDVz8c/sJrcRIuhQDwplenth
rArM97S0vBoG+On3bHHF+0gZ7kT1KLIqTRJ/TgY9TnUSIXTV2OI=
=VtdQ
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--
