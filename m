Received: from eggs.gnu.org ([2001:4830:134:3::10]:49917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK2cV-0000Ai-6t
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK2cU-0005K2-BK
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:41:47 -0500
Date: Wed, 29 Nov 2017 14:41:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171129134130.GC3753@localhost.localdomain>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<7ccb7f4a-b576-349f-655c-f741ec3a0dff@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <7ccb7f4a-b576-349f-655c-f741ec3a0dff@redhat.com>
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it
 under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com, mreitz@redhat.com, eblake@redhat.com


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.11.2017 um 13:24 hat Paolo Bonzini geschrieben:
> On 29/11/2017 13:00, Stefan Hajnoczi wrote:
> > We are at a point where code review isn't finding certain bugs because
> > no single person knows all the assumptions.  Previously the problem was
> > contained because maintainers spotted problems before patches were
> > merged.
> >=20
> > This is not primarily a documentation problem though.  We cannot
> > document our way out of this because no single person (patch author or
> > code reviewer) can know or check everything anymore due to the scale.
> >=20
> > I think it's a (lack of) design problem because we have many incomplete
> > abstractions like block jobs, IOThreads, block graph, image locking,
> > etc.  They do not cover all possibly states and interactions today.
> > Extending them leads to complex bugs.
>=20
> I think the main interactions are:
>=20
> 1) block graph modifications and drain.  This has always been a carnage.
>  Implementing BlockBackend isolation instead of drain would probably be
> a starting point to fix it, because IIRC there are extremely few cases
> where we really need "drain" semantics.

I think it's not just specifically drain, but nested event loops in
general. Drain is just more prominent because it recursively affects the
whole tree and actively waits for callbacks, so if anything can go
wrong, it will certainly affect drain, too.

The big problem I see here is that we have never defined in which places
or under which conditions it's allowed to make changes to the graph.
This means that callers never know when to use an extra bdrv_ref/unref
pair, when to expect that child references change in the middle of the
operation etc.

Maybe what we need there is some coroutine locks that make sure that
e.g. a block job completion simply has to wait until a drain has
completed before the graph change is actually executed. We need to make
sure that these locks don't deadlock the drain operation, but as long as
these things run in a separate coroutine (like the block job coroutine),
it should be okay.

Kevin

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaHrkKAAoJEH8JsnLIjy/WLz8P/1QTea+Fv6BTpRbkFCBWjjZY
hhj2rsT1X+tb91fPe2rSYx+O0aCOr+Fr3A6Y3fExEgGlLAQXoPfd0NTMk06lOjlB
enmszQ3YnFZqVnvdp1VrDSO01NmnYs5TyrUQr6fL08qhB65ZRu0/njpumNIBV0Nh
soMHuOdjo5Cu8f9z7DUBt53P2/1B3I4HqJcf+3TiPN24qJtB980ZbLc1Bl07TFhY
ZuRowEctTc94P9C3utc3knUzqgmK3rfG8Df82YQvTs0HLNsE67D/l+usnq8eL8Z2
qK3vVItI4ngNVb4u2IuKOmCeCni5gvXLpoZ5oVceZPMydjmb6eaDovGqObASRY/l
mEIXhkiCiJ92R7voEKn7eX+XSqQ1vi4TFyDCEdeXghMjhtZo+eWDz4hin1wAEozY
JfGrMs1n8rz9AlIcS8eQ2KKvrkt6nin09BOcC45uFLVGY1xBbNzV5bjdGvYeQe+2
vzbAze1YJtfQ0jwvn+y+WIyqPxtLTe2N7shf0UPI0tNB69OIoGvSckSUNgFHpOFj
EHeFhOH0NhrBUefudbqTiUqkZbZeLFORdY2qwEJfOn1JeDjLacZl8PjgWSwvY3fm
HYAOVhn8es1Ur+QtlxHRvSyhYK8S6kG2UNk4itZTgNpkkXIcuRgGpTpRsmLP7u9S
2hO+UAG5vvvgzVkcsf+F
=1HvR
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
