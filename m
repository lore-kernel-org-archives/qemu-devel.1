Received: from eggs.gnu.org ([2001:4830:134:3::10]:55160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOkAC-0001Nu-HR
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOkAB-00016F-Fn
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:32:16 -0400
Date: Fri, 1 Jun 2018 14:32:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601133202.GS8687@stefanha-x1.localdomain>
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FYef6pHvFBuPZp1D"
Content-Disposition: inline
In-Reply-To: <1527801443-30620-1-git-send-email-ari@tuxera.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>


--FYef6pHvFBuPZp1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 12:17:19AM +0300, Ari Sundholm wrote:
> From: Aapo Vienamo <aapo@tuxera.com>

Thanks for the patch!

> Implements a block device write logging system, similar to Linux kernel
> device mapper dm-log-writes. The write operations that are performed
> on a block device are logged to a file or another block device. The
> write log format is identical to the dm-log-writes format. Currently,
> log markers are not supported.
>=20
> This functionality can be used for fail-safe and fs consistency
> testing. By implementing it in qemu, tests utilizing write logs can be
> be used to test non-Linux drivers and older kernels.

This patch doesn't implement the same semantics as dm-log-writes, where
only completed writes are logged to make fs consistency testing easier.
If you intend to use it for this purpose, shouldn't it act the same way
as dm-log-writes?

> The implementation is based on the blkverify and blkdebug block drivers.

This functionality overlaps with existing block drivers.  In the
long-term people want to observe I/O requests in various ways beyond
what the dm-log-writes offers.  Therefore I'd like to suggest a
different approach that extends the quorum driver instead:

Add a read-pattern=3Dfirst parameter to the block/quorum.c driver so it
only reads from the first child.  QEMU can be launched with quorum and
NBD so that writes and flushes are mirrored to the external NBD server.

Any file format or online analysis can be implemented in the NBD server.
There are a number of NBD plugins here:
https://github.com/libguestfs/nbdkit

I think sending the writes and flushes over NBD is more flexible.

--FYef6pHvFBuPZp1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbEUrSAAoJEJykq7OBq3PIgWYH/1bUCJNUj2FVQ0Cx6cB2WMGq
Rabq9KteE4aHGnPknQ5EBO9m2+xkRrG9ITyYWGlm2vQ+umlDr2Sjav9Q/QC/+STq
UB1PjprO58Gt8rqNhCeamvFnLDxNmRihYqB3A4arKZvRmI+9nHzBmNITEa0ynU9O
oKMleu/uwCKO88RHVDAo/iHPSS2xjT1GI2E2b8xYIQeqq5QVIDq6qANlY4hzRRpk
LEuQaCmFZhyOsvIGA1vUiDjg/lOlfrf2QPlOPq97qjqHE5XGrWUj/u9w++td7gym
DYEHnaHWyK8PxRxUBZR1RoT4bPc5EYMJvvYhRhqgwyfkyE1itiH/+eAbEnjzNG4=
=81D3
-----END PGP SIGNATURE-----

--FYef6pHvFBuPZp1D--
