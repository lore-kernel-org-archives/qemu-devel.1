Received: from eggs.gnu.org ([2001:4830:134:3::10]:38443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQSW-0004Un-Mw
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwQSV-0000Nu-Ts
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:45:36 -0400
Date: Fri, 7 Apr 2017 10:45:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407094525.GJ13602@stefanha-x1.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<fcdfe9c672ecdb179264187e0671b5432fced4c4.1491416061.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <fcdfe9c672ecdb179264187e0671b5432fced4c4.1491416061.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/9] block: do not set BDS
 read_only if copy_on_read enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2017 at 02:28:44PM -0400, Jeff Cody wrote:
> @@ -1173,7 +1171,18 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>          if (ret < 0) {
>              goto fail;
>          }
> -        bdrv_set_read_only(bs, false);
> +        ret = bdrv_set_read_only(bs, false, &local_err);
> +        if (ret < 0) {
> +            error_propagate(errp, local_err);
> +            goto fail;
> +        }

I realized later in the series why you are doing this.

The error code path introduces a resource leak: enable_write_target()
has already been called and isn't cleaned up by the fail label.

It would be cleaner to check that bs is writable before calling
enable_write_target().

Stefan

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY51+1AAoJEJykq7OBq3PIzqwH/iyhxdshwloPzjx+YAbqILL3
0HLxwXABJKKR1oF5ljoQmbkRM8FmkRzsTgpcfdthsIcdIvLdkb5LZByKgWfA7WvW
fINzQxSIRPQt5uIvqyyQ6A1HCOoA9PEf9dbBpBqFCjWuQUTSIRN6qov0Aw5DVz3L
PczJxpVGtwL2ytpesFsyFbxLcZb4AsDnLehydYXu131JEdmc4pDcmhEEkoW16mQ4
OAN/L+Pm9aq/otBeTh0+OXEQFr6jA7nEDJ5ldyqkIoa13IvxyYdGbAItwDjC3MBa
g5Kx+1lnEu8fhXEvx446lBLgvW/oq9wgnLVj2Zlkx9lF4yC2w6CHOtNp0zuS5hA=
=KiRS
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
