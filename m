Received: from eggs.gnu.org ([2001:4830:134:3::10]:49673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxvd5-00085D-1b
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxvd3-0005gv-R5
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:14:43 -0400
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
	<20170411120504.GJ4516@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58fea8c2-deb7-b9fa-e6d8-d1ea158ed500@redhat.com>
Date: Tue, 11 Apr 2017 08:14:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170411120504.GJ4516@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XDL4nkgjEOiQGsgFLrMV0QAKFghGv0c4P"
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
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XDL4nkgjEOiQGsgFLrMV0QAKFghGv0c4P
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <58fea8c2-deb7-b9fa-e6d8-d1ea158ed500@redhat.com>
Subject: Re: [Qemu-block] Making QMP 'block-job-cancel' transactionable
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
 <0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
 <20170411120504.GJ4516@noname.str.redhat.com>
In-Reply-To: <20170411120504.GJ4516@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 07:05 AM, Kevin Wolf wrote:

>=20
> Note that job completion/cancellation aren't synchronous QMP commands.
> The job works something like this, where '...' means that the VM can ru=
n
> and submit new writes etc.:
>=20
> 1. Start job: mirror_start
> ...
> 2. Bulk has completed: BLOCK_JOB_READY event
> ...
> 3. Request completion/cancellation: block-job-completet/cancel
> ...
> 4. Actual completion/cancellation: BLOCK_JOB_COMPLETED
>=20
> The last one is the actual job completion that we want to be atomic for=

> a group of nodes. Just making step 3 atomic (which is what including
> block-job-complete/cancel in transaction would mean) doesn't really buy=

> us anything because the data will still change between step 3 and 4.

But as long as the data changes between steps 3 and 4 are written to
only one of the two devices, rather than both, then the disk contents
atomicity is guaranteed at the point where we stopped the mirroring (ie.
during step 3).

>=20
> Now step 4 is reached for each job individually, and unless you stop th=
e
> VM (or at least the processing of I/O requests), I don't see how you
> could reach it at the same time for all jobs.

The fact that the jobs complete independently (based on different
amounts of data to flush) is not problematic, if we are still guaranteed
that issuing the request altered the graph so that future writes by the
guest only go to one side, and the delay in closing is only due to
flushing write requests that pre-dated the job end request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XDL4nkgjEOiQGsgFLrMV0QAKFghGv0c4P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7Na3AAoJEKeha0olJ0NqiEMIAIyTUT9v0uCoGiol8xYsQAgf
nf6l7QcYJHwD81dpTIT8n9EV4e/QdFeSOjZI0DXDn2/qtXjaFgyulClRdPVrGNx6
v3/JgX9wIE4iGDpGlert18eIDPyyVCBLE3YQw/l/inuxIM+N5g1yyKS9py0wW40K
wGec3K0fZ4LLBWuJ3LLnLoy/4c6XlTkahfU/RgikpDiqdKng6k2/kboLszYeK1E9
XVGAV3QFBKga+Ht4v807hIs8ivqEhAPl1rt4zcUK+RvAYsC5t5ndA6WxFf5Hpz/j
7DhHp2kb0/BnccYl+bWzPcjlbw2NOekU1dqLLIuWLqDbVUyY+QOMXc/9G59RHgQ=
=Byuw
-----END PGP SIGNATURE-----

--XDL4nkgjEOiQGsgFLrMV0QAKFghGv0c4P--
