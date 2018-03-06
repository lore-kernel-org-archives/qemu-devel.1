Received: from eggs.gnu.org ([2001:4830:134:3::10]:55936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etEz6-0005St-NQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etEz3-0007RL-B8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:58:36 -0500
Date: Tue, 6 Mar 2018 15:58:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306155829.GL31045@stefanha-x1.localdomain>
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180207125037.13510-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z1OTrj3C7qypP14j"
Content-Disposition: inline
In-Reply-To: <20180207125037.13510-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: add block latency histogram
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org


--Z1OTrj3C7qypP14j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 03:50:37PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 8225308904..74fe3fe9c4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -451,6 +451,74 @@
>             'status': 'DirtyBitmapStatus'} }
> =20
>  ##
> +# @BlockLatencyHistogramInfo:
> +#
> +# Block latency histogram.
> +#
> +# @latency: list of latency points in microseconds. Matches the @latency

The meaning of "point" is unclear here.  I think the term "interval
boundary" is clearer, but an example may help to illustrate this.  The
field could also be renamed to "intervals".

> +#           parameter from the last call to block-latency-histogram-set =
for the
> +#           given device.

The fastest NVMe devices are specified at 10 microsecond latency or
less.  The software stack adds latency on top of that, but using
microseconds as units here may not be future-proof.

I suggest using nanoseconds, just in case.

> +#
> +# @read: list of read-request counts corresponding to latency region.
> +#        len(@read) =3D len(@latency) + 1
> +#        @read[0] corresponds to latency region [0, @latency[0])

"latency region" =3D=3D "bin" or "interval" in histogram terminology

> +#        for 0 < i < len(@latency): @read[i] corresponds to latency regi=
on
> +#            [@latency[i-1], @latency[i])
> +#        @read.last_element corresponds to latency region
> +#            [@latency.last_element, +inf)
> +#
> +# @write: list of write-request counts (see @read semantics)
> +#
> +# @flush: list of flush-request counts (see @read semantics)
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockLatencyHistogramInfo',
> +  'data': {'latency': ['uint64'],
> +           'read': ['uint64'],
> +           'write': ['uint64'],
> +           'flush': ['uint64'] } }
> +
> +##
> +# @block-latency-histogram-set:
> +#
> +# Remove old latency histogram (if exist) and (optionally) create a new =
one.

s/if exist/if present/

> +# Add a latency histogram to block device. If a latency histogram already
> +# exists for the device it will be removed and a new one created. The la=
tency
> +# histogram may be queried through query-blockstats.
> +# Set, restart or clear latency histogram.
> +#
> +# @device: device name to set latency histogram for.

query-blockstats also works on nodes, so this command must work not just
on devices but on named nodes too.

> +# @latency: If unspecified, the latency histogram will be removed (if ex=
ists).
> +#           Otherwise it should be list of latency points in microsecond=
s. Old
> +#           latency histogram will be removed (if exists) and a new one =
will be
> +#           created. The sequence must be ascending, elements must be gr=
eater
> +#           than zero. Histogram latency regions would be
> +#           [0, @latency[0]), ..., [@latency[i], @latency[i+1]), ...,
> +#           [@latency.last_element, +inf)

Reworded:

  @intervals: An optional list of interval boundary values in
	      nanoseconds, all greater than zero and in ascending order.
	      The list [10, 50, 100] produces the following histogram
	      bins: [0, 10), [10, 50), [50, 100), [100, +inf).  If the
	      field is absent the existing latency histogram is removed
	      from the device (if present).

--Z1OTrj3C7qypP14j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanrqlAAoJEJykq7OBq3PIqU0H/2nBd59bQtb0QYgUaTkA365+
uIVzWBVETlbVJOvDJNBbbuFx9RfFTNy1N7uX8YVmxx0Dq+0HdVQrVockwynnzOMV
3Ci1CP/sCSWYY0Tph/dPFqvEuWQGKGJNPK8lGb7/slW+OgjAFr1TSw/3EzeLXzNy
il3SuGkVxjwdxZ5cBpJ3ZYPaZAnOagDOYicUS13tBuur+VBBSAEoAqxpJf0UrqCd
KY6yof0aTPEUf+dujX52xuo68oFZ8JO2HRQculOtguAIGNdsrhrQ4pCkEkibxMM4
hXyKRQL8Dxw6JclJwgRDZlOCJkw1wW1kvIyGj7YI8Wg3XYo8vJndPNh4NG4h4tI=
=tpvb
-----END PGP SIGNATURE-----

--Z1OTrj3C7qypP14j--
