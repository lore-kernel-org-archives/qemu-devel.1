Received: from eggs.gnu.org ([2001:4830:134:3::10]:55327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxvsQ-0002Ij-NL
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxvsP-0004jA-Pm
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:30:34 -0400
Date: Tue, 11 Apr 2017 15:30:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411133017.GL4516@noname.str.redhat.com>
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
	<20170411120504.GJ4516@noname.str.redhat.com>
	<58fea8c2-deb7-b9fa-e6d8-d1ea158ed500@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <58fea8c2-deb7-b9fa-e6d8-d1ea158ed500@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.04.2017 um 15:14 hat Eric Blake geschrieben:
> On 04/11/2017 07:05 AM, Kevin Wolf wrote:
> > Note that job completion/cancellation aren't synchronous QMP commands.
> > The job works something like this, where '...' means that the VM can run
> > and submit new writes etc.:
> >=20
> > 1. Start job: mirror_start
> > ...
> > 2. Bulk has completed: BLOCK_JOB_READY event
> > ...
> > 3. Request completion/cancellation: block-job-completet/cancel
> > ...
> > 4. Actual completion/cancellation: BLOCK_JOB_COMPLETED
> >=20
> > The last one is the actual job completion that we want to be atomic for
> > a group of nodes. Just making step 3 atomic (which is what including
> > block-job-complete/cancel in transaction would mean) doesn't really buy
> > us anything because the data will still change between step 3 and 4.
>=20
> But as long as the data changes between steps 3 and 4 are written to
> only one of the two devices, rather than both, then the disk contents
> atomicity is guaranteed at the point where we stopped the mirroring (ie.
> during step 3).

But that's not how things work. Essentially requesting completion means
that the next time that source and target are in sync, we complete the
block job. This means that still new copying requests can be issued
before the job actually completes (and it's even likely to happen).

> > Now step 4 is reached for each job individually, and unless you stop the
> > VM (or at least the processing of I/O requests), I don't see how you
> > could reach it at the same time for all jobs.
>=20
> The fact that the jobs complete independently (based on different
> amounts of data to flush) is not problematic, if we are still guaranteed
> that issuing the request altered the graph so that future writes by the
> guest only go to one side, and the delay in closing is only due to
> flushing write requests that pre-dated the job end request.

This is not easily possible without implementing something like a backup
job for the final stage of the mirror job... Otherwise the guest can
always overwrite a sector that is still marked dirty and then that new
sector will definitely be copied still.

Kevin

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY7NppAAoJEH8JsnLIjy/WU8IP/jW+BUq2XBsVM/e8BrCW69ZY
VI/Hwwzia4ti56piovCsDVFemBABzn2LEnijeJdBcMjihIciExlp90R0WHIvIXD6
SVVrV+JW4Er/jLIT+OQoD+z2OaEM/z7LwAKa3wzGUmfX689SF8mOWTTabdLRAmlx
1c5ztIGGI1txsdL2BVw/U0K8c+KMBKTkITi+TV8FK4qomkvPKzrbKua55Vu4a1jM
fdEdpOcZNXrfGQL2EKZW6WwkzN0G39EPfJ5aQdyPw7Q21hSYBLcOYqdeayXHe2kE
gpLqpJkoeXRduUDd91QKwwFWmgM99Nnb811EMoAAy5bn2kW/138DRZABv8CUJ6x1
6wXj7BJl7tbIN3D80hHsKkBCKvTye2wVxCinLrGcDJzgueyEveplgBGy6ofByUWg
ZX58YjRkUdIvNgLet/cL/kcPIsbYUb4dC123+WNB6Zs/4yOqD6GLjPKvbJ3Zbdgt
NaffBZNjyVqxXCI57vcGafBKQH/+rU1rhMJlZriyGL/g+vAVA9VGHQMFB1cIdR2U
MnXMIucaErWzFxQJTxb24ZnxQ7dGxCIT2ThvFTBB11rN6TkLiGE0FmBPUuIX3bDr
lPs+52aiuQOT6T6rhhBv5EE3w1RoJbcP8t8tilwCvuPx1858Glmy0fypLxmRZ1Wv
fV4eDH/Nw8S+oITxccUs
=Iiru
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
