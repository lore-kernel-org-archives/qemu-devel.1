Received: from eggs.gnu.org ([2001:4830:134:3::10]:58597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etF82-00031t-D9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etF81-0003e4-BM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:07:50 -0500
Date: Tue, 6 Mar 2018 16:07:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306160739.GN31045@stefanha-x1.localdomain>
References: <c0d7b993-b3b8-a753-21f5-e2257de27caf@kamp.de>
	<20180305114533.GI7910@stefanha-x1.localdomain>
	<0f1ec3c7-1157-e618-62f8-ffd5e08eb342@kamp.de>
	<20180305145215.GM3131@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AA9g+nFNFPYNJKiL"
Content-Disposition: inline
In-Reply-To: <20180305145215.GM3131@work-vm>
Subject: Re: [Qemu-devel] [Qemu-block] block migration and MAX_IN_FLIGHT_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, wency@cn.fujitsu.com, qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--AA9g+nFNFPYNJKiL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 02:52:16PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Lieven (pl@kamp.de) wrote:
> > Am 05.03.2018 um 12:45 schrieb Stefan Hajnoczi:
> > > On Thu, Feb 22, 2018 at 12:13:50PM +0100, Peter Lieven wrote:
> > >> I stumbled across the MAX_INFLIGHT_IO field that was introduced in 2=
015 and was curious what was the reason
> > >> to choose 512MB as readahead? The question is that I found that the =
source VM gets very unresponsive I/O wise
> > >> while the initial 512MB are read and furthermore seems to stay unrea=
sponsive if we choose a high migration speed
> > >> and have a fast storage on the destination VM.
> > >>
> > >> In our environment I modified this value to 16MB which seems to work=
 much smoother. I wonder if we should make
> > >> this a user configurable value or define a different rate limit for =
the block transfer in bulk stage at least?
> > > I don't know if benchmarks were run when choosing the value.  From the
> > > commit description it sounds like the main purpose was to limit the
> > > amount of memory that can be consumed.
> > >
> > > 16 MB also fulfills that criteria :), but why is the source VM more
> > > responsive with a lower value?
> > >
> > > Perhaps the issue is queue depth on the storage device - the block
> > > migration code enqueues up to 512 MB worth of reads, and guest I/O has
> > > to wait?
> >=20
> > That is my guess. Especially if the destination storage is faster we ba=
sically alsways have
> > 512 I/Os in flight on the source storage.
> >=20
> > Does anyone mind if the reduce that value to 16MB or do we need a bette=
r mechanism?
>=20
> We've got migration-parameters these days; you could connect it to one
> of those fairly easily I think.
> Try: grep -i 'cpu[-_]throttle[-_]initial'  for an example of one that's
> already there.
> Then you can set it to whatever you like.

It would be nice to solve the performance problem without adding a
tuneable.

On the other hand, QEMU has no idea what the queue depth of the device
is.  Therefore it cannot prioritize guest I/O over block migration I/O.

512 parallel requests is much too high.  Most parallel I/O benchmarking
is done at 32-64 queue depth.

I think that 16 parallel requests is a reasonable maximum number for a
background job.

We need to be clear though that the purpose of this change is unrelated
to the original 512 MB memory footprint goal.  It just happens to touch
the same constant but the goal is now to submit at most 16 I/O requests
in parallel to avoid monopolizing the I/O device.

Stefan

--AA9g+nFNFPYNJKiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanrzLAAoJEJykq7OBq3PI6bIH/i+nWWb4gWqQl/H7Mrams543
gF8sNNYaI6gF5yWPu+LjzYkYgf4Y1AamSvigPHV3U2SNWavuSZoqzKmd7QX0514I
mnue/dnVMs7HtSpbC0DneXetlZspFDBEA/ENKj9+AP9UdfzWiNWbfVPxf7wAvg60
VG3E4B4JXp35R9DLoHO80vGTITroqhYA8n8z0swqHujtRPxyg027+Hgh7lieG8cR
8nThBkgAUOT0eW4IZKNKG1DDrXMs+FlUWtzX7cnVgmJQBvlpl4OtUCElUdxjHFWF
m1gWROJiP11y85sA6jWA/YPzvCQq1WyPyEAtQ+Bc/2uaztJVzyZ00t+t5MrQcZY=
=8Ktl
-----END PGP SIGNATURE-----

--AA9g+nFNFPYNJKiL--
