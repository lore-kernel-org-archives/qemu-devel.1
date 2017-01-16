Received: from eggs.gnu.org ([2001:4830:134:3::10]:37298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT4ns-0002xv-FK
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 05:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT4np-0000AR-6O
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 05:46:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT4no-0000AM-UI
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 05:46:17 -0500
Date: Mon, 16 Jan 2017 10:46:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170116104613.GB12351@stefanha-x1.localdomain>
References: <20170112114612.14520-1-stefanha@redhat.com>
	<fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
	<20170113120240.GB9142@stefanha-x1.localdomain>
	<75cb767b-2850-4a87-50fc-d957e3a793ac@cardoe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <75cb767b-2850-4a87-50fc-d957e3a793ac@cardoe.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio: revert
 virtio_queue_set_notification() nesting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Goldstein <cardoe@cardoe.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 09:15:49AM -0600, Doug Goldstein wrote:
> On 1/13/17 6:02 AM, Stefan Hajnoczi wrote:
> > On Thu, Jan 12, 2017 at 10:57:53AM -0600, Doug Goldstein wrote:
> >> On 1/12/17 5:46 AM, Stefan Hajnoczi wrote:
> >>> The virtio_queue_set_notification() nesting introduced for AioContext=
 polling
> >>> raised an assertion with virtio-net (even in non-polling mode).  Conv=
erting
> >>> virtio-net and virtio-crypto to use virtio_queue_set_notification() i=
n a
> >>> nesting fashion would be invasive and isn't worth it.
> >>>
> >>> Patch 1 contains the revert to resolve the bug that Doug noticed.
> >>>
> >>> Patch 2 is a less efficient but safe alternative.
> >>>
> >>> Stefan Hajnoczi (2):
> >>>   Revert "virtio: turn vq->notification into a nested counter"
> >>>   virtio: disable notifications again after poll succeeded
> >>>
> >>>  hw/virtio/virtio.c | 21 +++++++++------------
> >>>  1 file changed, 9 insertions(+), 12 deletions(-)
> >>>
> >>
> >> So I just gave this series a whirl and it fixes the assert but causes
> >> another issue for me. While iPXE is getting a DHCP address the screen
> >> immediately flashes over to the UEFI shell. Its like a timeout is
> >> getting hit and just dropping me to the shell.
> >=20
> > Sounds like an separate problem.
> >=20
> > Stefan
> >=20
>=20
> Is there any debug output that I can provide to help troubleshoot it?
> I've built 23425cc and UEFI via OVMF is able to get an IP address via
> DHCP inside of iPXE. I've also taken master and only applied the first
> patch in this series (the revert) and it too works. Its only when I add
> the 2nd patch into the mix or don't revert out the "virtio: turn
> vq->notification into a nested counter" patch that it fails.

The code in Patch 2 should not be executed in your QEMU configuration,
so I wonder how Patch 2 can cause the DHCP failure.

Please verify as follows:

  $ gdb --args path/to/qemu-system-x86_64 ...
  (gdb) handle SIGUSR1 noprint nostop pass
  (gdb) handle SIGPIPE noprint nostop pass
  (gdb) b virtio_queue_host_notifier_aio_poll_begin
  (gdb) r

I predict the breakpoint will not be hit.

Stefan

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfKR1AAoJEJykq7OBq3PIc38IAJy55Fea1L0gaaJTofpKp906
yLMIUnU+SbH02Kql2m7AZVIceTmX9AvCnshEsli7qKodYF4EIeR9P3Lef6EynDXW
eF4b8WTIv8wy1JBWTmwPVJ69XoPAK6KOYpVXW6a2mSTQC6eGJ524ZpKSU6wfdWdH
c5Rh0IDpsP5gMzD2fJXQ/Evtcv3ed8XjJcL5H2ZLRinGDqMqC1RjnK+OBVA7R97t
cYQVrLlneln8CDjeIpf7qOEfozc+U6O8N0pRkIjZ/43FdSaHTZzqQ0aM1TmoR4xv
MHrfEM0Ux5H1UdrfpvEqdpT+4TJmA505FOF4eHIv2m/t/KZZCUZl5MW/bwaWykg=
=ViDw
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
