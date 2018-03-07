Received: from eggs.gnu.org ([2001:4830:134:3::10]:40612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etXLx-00010b-Az
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etXLw-000485-Bw
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:35:25 -0500
Date: Wed, 7 Mar 2018 11:35:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180307113507.GD16861@stefanha-x1.localdomain>
References: <20180306105354.15197-1-stefanha@redhat.com>
	<20180306110844.GC7139@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <20180306110844.GC7139@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] block: make BDRV_POLL_WHILE() re-entrancy
 safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 12:08:44PM +0100, Kevin Wolf wrote:
> Am 06.03.2018 um 11:53 hat Stefan Hajnoczi geschrieben:
> > Nested BDRV_POLL_WHILE() calls can occur.  Currently
> > assert(!bs_->wakeup) will fail when this happens.
> >=20
> > This patch converts bs->wakeup from bool to a counter.
> >=20
> > Nesting works correctly because outer BDRV_POLL_WHILE() callers evaluate
> > the condition again after the inner caller completes (invoking the inner
> > caller counts as aio_poll() progress).
> >=20
> > Reported-by: "fuweiwei (C)" <fuweiwei2@huawei.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Doesn't this conflict with your own AIO_WAIT_WHILE() patch?

Yes, I wanted this patch to be easy for Weiwei to test without
dependencies.

AIO_WAIT_WHILE() has just hit qemu.git/master, so I'll rebase and send a
v2.

Stefan

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJan85rAAoJEJykq7OBq3PIX+UH/R3cFyY65efvNY3ohjwwNxrr
o9ulQCIGykZ2R5zgY8OMhwJQuE5Zeb6A6MOSadZYImriyK2NEZN+92s7HOcEtnrR
uNgcujwJheASxsoXVS0B5fZUCR+tdCsgR9axadhSKIngUmad5ppLsJJhSV4EKxQq
67VwlOObJErumN6sx4a+MXGjXIZhSWV8H9tDzIJfi24QPHglga6OfiOvzeJ79exV
G15tGEblx93kBapJZXp9RrIIG5B7WC0CKg+KmvSPjzAZHvxDHyvqOm5z/nRfyQb7
MwYNGORzgFBBGZe0ztMBVmoXES6LuFXwg9SOEtNFq5WVCGX+pmGt/9gcvWBk2jo=
=9CLk
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
