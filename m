Received: from eggs.gnu.org ([209.51.188.92]:54815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj4to-00075w-7s
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj4tn-0006AU-9P
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:15:40 -0500
Date: Mon, 14 Jan 2019 16:15:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190114161525.GA32304@stefanha-x1.localdomain>
References: <20190109110144.18633-1-stefanha@redhat.com>
	<w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
	<20190111132416.GI5010@dhcp-200-186.str.redhat.com>
	<w51pnt3qo27.fsf@maestria.local.igalia.com>
	<20190114133553.GE7038@stefanha-x1.localdomain>
	<w51won7480o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <w51won7480o.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 03:40:39PM +0100, Alberto Garcia wrote:
> On Mon 14 Jan 2019 02:35:53 PM CET, Stefan Hajnoczi wrote:
> > On Fri, Jan 11, 2019 at 03:14:08PM +0100, Alberto Garcia wrote:
> >> On Fri 11 Jan 2019 02:24:16 PM CET, Kevin Wolf wrote:
> >> >> >> The following QMP command leads to a crash when iothreads are us=
ed:
> >> >> >>
> >> >> >>   { 'execute': 'device_del', 'arguments': {'id': 'data'} }
> >> >> >
> >> >> > How did you reproduce this? Do you have a test case?
> >> >>=20
> >> >> Ok, I finally reproduced it, the patch looks good to me.
> >> >
> >> > Can it be turned into a qemu-iotests case or is it too complicated f=
or
> >> > that?
> >>=20
> >> I can reproduce the problem reliably with this:
> >>=20
> >> { "execute": "qmp_capabilities" }
> >> { "execute": "blockdev-add",
> >>   "arguments": {"driver": "null-co", "node-name": "hd0"}}
> >> { "execute": "object-add",
> >>   "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> >> { "execute": "device_add",
> >>   "arguments": {"id": "scsi0", "driver": "virtio-scsi-pci",
> >>                 "iothread": "iothread0"}}
> >> { "execute": "device_add",
> >>   "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
> >> { "execute": "block_set_io_throttle",
> >>   "arguments": {"id": "scsi-hd0", "bps": 0, "bps_rd": 0, "bps_wr": 0,
> >>                 "iops": 1000, "iops_rd": 0, "iops_wr": 0}}
> >> { "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
> >>=20
> >> But this doesn't crash if I put it in an iotest.
> >
> > I've been able to reproduce this in an iotest, please see v2 of this
> > series.
>=20
> That iotest doesn't crash for me :-?

Does my iotest pass for you?

On my machine the diff fails because signal 11 killed QEMU (and this
prints a warning to the test output).

Stefan

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPLWdAAoJEJykq7OBq3PIYHoH/RX75f1DDxVdyo6KFPRxz1m0
VkQBarTXGOxBOUX6uKQg15iuRz5bGBfmjjqCDpXSwh0C2hFs6IqG3a1ovzqiDH7x
n20lorYb/dyEva+et7xBgPhEsDD4HaUPIFvMaxz6PKYx5qyU/I/HbUr7aUiB2PH9
i1AgfV911miRSg8lDM/RBrH6F1ab37adVS6gjRv99Onw7c6sbaxvQTFnI7qOi+RS
GaK5g2aK7imPuhGvdgq1dme1LDBCZ3dxsBq7bwIgwZDVp/FgMRx/uzHXCaqsGdlg
kU1oeaAzM7Bl4RreQq66D876AKceeOZudEq61a/YtNqEh+j4YaqMCmuIrvcrtOQ=
=5NHN
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
