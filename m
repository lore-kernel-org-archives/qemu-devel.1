Received: from eggs.gnu.org ([2001:4830:134:3::10]:50810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH6jW-0002IX-5j
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 06:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH6jV-00040V-9j
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 06:28:54 -0500
Date: Tue, 21 Nov 2017 11:07:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171121110729.GC25265@stefanha-x1.localdomain>
References: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510851298-59922-2-git-send-email-anton.nefedov@virtuozzo.com>
	<20171120145311.GG4516@stefanha-x1.localdomain>
	<e40d3c39-e97d-b168-4573-f167dc6faa1e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <e40d3c39-e97d-b168-4573-f167dc6faa1e@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qcow2: multiple clusters write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>, mreitz@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2017 at 06:03:00PM +0300, Denis V. Lunev wrote:
> On 11/20/2017 05:53 PM, Stefan Hajnoczi wrote:
> > On Thu, Nov 16, 2017 at 07:54:55PM +0300, Anton Nefedov wrote:
> >> From: Pavel Butsykin <pbutsykin@virtuozzo.com>
> >>
> >> At the moment, qcow2_co_pwritev_compressed can process the requests size
> >> less than or equal to one cluster. This patch added possibility to write
> >> compressed data in the QCOW2 more than one cluster. The implementation
> >> is simple, we just split large requests into separate clusters and write
> >> using existing functionality.
> >>
> >> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> >> ---
> >>  block/qcow2.c | 73 ++++++++++++++++++++++++++++++++++++++++++-----------------
> >>  1 file changed, 52 insertions(+), 21 deletions(-)
> > Kevin: qcow2_alloc_compressed_cluster_offset() sets up an L2 table entry
> > before doing the compressed data write.  Can the following scenario
> > occur if there is another request racing with the compressed write?
> >
> > 1. Compressed cluster L2 table entry added to qcow2 in-memory cache
> > 2. Another request forces cached L2 table to be written to disk
> > 3. Power failure or crash before compressed data is written
> >
> > Now there is an L2 table entry pointing to garbage data.  This violates
> > qcow2's data integrity model.
> >
> > I'm not sure if compressed writes are safe...  It may have been okay for
> > qemu-img convert but the risk is increased when running a VM.
> qemu-img is now multi-coroutine, thus the danger is exactly the same.

Yes, the the problem is exactly the same but users delete incomplete
output files when qemu-img covert is interrupted due to power failure.
That's probably why it hasn't been a priority to fix this qcow2 code
path.

Stefan

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaFAjxAAoJEJykq7OBq3PIkrYIAMTvBP+u7yL2ksMYTyi9/3CO
NqZP6BwHzpoR1SF23ZqPuogOvNKw/IFeca0kY1+6CZC80o6jWAFVS498ieIbgrhX
gj4f1cvVZq/PokjbvSHSS5u9fV/XK7unqtIhKhAD2VJ4dC1Vd32yfLfveBsgoZF1
FFE2JsrurTJI6K9s8X/xRSiljL0UXCsau8xltdxo+2XZVH/3QagjGzR62UJj5D7s
ChngUNfNCYnVBwwXMX2uyTxJhw8bwmnRzE1tZBfpt2E1TOvmvh57Zpy2fPuViBMv
leTM+SA5GglwIcuA/CCegm+yVfx4Jr+A8mbUsWYV9QHTfijX2CJPTQIIcA6xkGE=
=HmA0
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
