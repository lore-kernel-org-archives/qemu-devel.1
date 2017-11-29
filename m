Received: from eggs.gnu.org ([2001:4830:134:3::10]:58194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK1QQ-0000tx-G6
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eK1QK-0007xU-Kr
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:25:14 -0500
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ccb7f4a-b576-349f-655c-f741ec3a0dff@redhat.com>
Date: Wed, 29 Nov 2017 13:24:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171129120018.GB2601@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DXvDqUOmhA48SOVcSeUT1QcvSBrb1GIQR"
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
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DXvDqUOmhA48SOVcSeUT1QcvSBrb1GIQR
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com
Message-ID: <7ccb7f4a-b576-349f-655c-f741ec3a0dff@redhat.com>
Subject: Re: Block layer complexity: what to do to keep it under control?
References: <20171129035502.GD8889@lemon>
 <20171129120018.GB2601@stefanha-x1.localdomain>
In-Reply-To: <20171129120018.GB2601@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29/11/2017 13:00, Stefan Hajnoczi wrote:
> We are at a point where code review isn't finding certain bugs because
> no single person knows all the assumptions.  Previously the problem was=

> contained because maintainers spotted problems before patches were
> merged.
>=20
> This is not primarily a documentation problem though.  We cannot
> document our way out of this because no single person (patch author or
> code reviewer) can know or check everything anymore due to the scale.
>=20
> I think it's a (lack of) design problem because we have many incomplete=

> abstractions like block jobs, IOThreads, block graph, image locking,
> etc.  They do not cover all possibly states and interactions today.
> Extending them leads to complex bugs.

I think the main interactions are:

1) block graph modifications and drain.  This has always been a carnage.
 Implementing BlockBackend isolation instead of drain would probably be
a starting point to fix it, because IIRC there are extremely few cases
where we really need "drain" semantics.

2) block jobs and coroutines.  Block jobs were too clever about
coroutines.  Using a simplified API is going to fix this problem.
Ideally, if you're not in a coroutine "co", the only coroutine APIs you
should use on "co" are:

- aio_co_enter/qemu_coroutine_enter (start a coroutine, respectively on
another AioContext or this context);

- aio_co_schedule/aio_co_wake (restart a coroutine that has yielded,
respectively on a given AioContext or its own original.

3) block jobs and drain.  This is related to (1) because drain can
terminate jobs and in turn that can cause block graph modifications.
I'm not even sure it's a separate issue.


Regarding documentation, the include file documentation is good for
coroutines and block jobs.  But it's bad for block graph modification
APIs, and even for coroutines + block jobs the docs/devel documentation
could be improved *and* it's ugly that we're not generating anything
readable from include file documentation, to go with docs/devel.

Paolo

> A little progress has been made with defining higher-level APIs for
> block drivers and block jobs.  This way they either don't deal with
> low-level details of the concurrency and event loop models (e.g.
> bdrv_coroutine_enter()) or there is an interface that prompts them to
> integrate properly like bdrv_attach/detach_aio_context().
>=20
> Event loops and coroutines are good but they should not be used directl=
y
> by block drivers and block jobs.  We need safe, high-level APIs that
> implement commonly-used operations.



--DXvDqUOmhA48SOVcSeUT1QcvSBrb1GIQR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAloepw4ACgkQv/vSX3jH
roMoWwf+LGF9qRy2vr4ewUUz6qiHrdhBSoPxJxSlTYQ1lTNk4g37fwvXOnpncQbn
kXWczFRni8r4BauxHyNXBGJEYRAw6UscnXULGYsDwpwxVf3kBTYCGKEqlIw5kRic
eVzUdbcNNNL/QtYYRcl8eCm2/us4OpFieQK/Da8MmJdgsJ6Cbhvmnqa/RAJFCT6s
PPXMxEM3vQhgST/rSgfBexRDF2zQbzjeWJuOvuFrN6mJq+wJ/gLCHG8+jGfyPgcd
NRzrfySt7luGM23G6lUb0nfwij0n3ZTFyC8MyRr1CiqzPvRGNs1g0IM0DRRQHfOb
4pZlL7vZtWHGaMQKllaZ4suigUgrbQ==
=ENGr
-----END PGP SIGNATURE-----

--DXvDqUOmhA48SOVcSeUT1QcvSBrb1GIQR--
