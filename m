Received: from eggs.gnu.org ([2001:4830:134:3::10]:51315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKoj8-0004Wq-Cx
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKoj7-00036c-FA
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:03:50 -0500
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
	<20171130141954.GC14748@stefanha-x1.localdomain>
	<20171201101644.GB11092@lemon>
	<20171201140833.GB12803@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f67de9f9-dfe6-ae9a-d2ea-b4ae5e309757@redhat.com>
Date: Fri, 1 Dec 2017 18:03:24 +0100
MIME-Version: 1.0
In-Reply-To: <20171201140833.GB12803@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gu60LdBM8NoO4JX3NDjxId4KlkPBI0MGu"
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gu60LdBM8NoO4JX3NDjxId4KlkPBI0MGu
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jcody@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <f67de9f9-dfe6-ae9a-d2ea-b4ae5e309757@redhat.com>
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it under
 control?
References: <20171129035502.GD8889@lemon>
 <20171129120018.GB2601@stefanha-x1.localdomain>
 <20171130094709.GA20286@lemon>
 <20171130141954.GC14748@stefanha-x1.localdomain>
 <20171201101644.GB11092@lemon>
 <20171201140833.GB12803@stefanha-x1.localdomain>
In-Reply-To: <20171201140833.GB12803@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Just my 2 cents on the language topic, as in general I agree completely
with Stefan.

On 01/12/2017 15:08, Stefan Hajnoczi wrote:
> Rust's threading model is 1:1.  Besides mutexes it also has channels
> (looks similar to Go and communicating sequential processes-style
> channels).
>=20
> It is probably not feasible to make each I/O request a thread (i.e. 1M
> IOPS means creating/destroying 1M threads/sec).  There would have to be=

> some machinery like a request queue and a thread pool to process
> requests.  That way requests can be held before those that are ready to=

> be executed can run as threads.  Hmm...this sounds similar to what we
> have.

Yes, we would probably use coroutines anyway even if using Rust
(wrapping them in a Rust library).

There could still be important gains in readability and type-safety, for
example if the type checker could guarantee that internal qcow2
functions are called with a lock taken.  I'm afraid however that this
would require much stronger Rust knowledge than we can acquire quickly,
and that we would end up with just as much technical debt (without even
realizing it).

Luckily, several benefits don't require a full rewrite or language switch=
:

- readability from RAII-style code.  If this is important enough, we
could actually use GCC __attribute__((cleanup)) or, heaven forbid,
slowly introduce C++ in QEMU's code base.

- compile-time checks.  For this we can also use clang's
-Wthread-safety.  (GCC doesn't have it yet).

- lack of templates/generics; for example commit 2bb5c936c5 ("curl: do
not do aio_poll when waiting for a free CURLState", 2017-05-16)
open-codes a "CoQueue that's protected by a QemuMutex rather than a
CoMutex"; templates would provide an elegant solution without code
duplication.  Generics could also be used to decouple abstract data
types from the block layer and to unit-test them easily (e.g.
Graph<BlockDriverState, BdrvChildRole>), but: 1) it may be just my very
limited knowledge of the BDS graph code; 2) we couldn't do this anyway
without first understanding the deficiencies of our C implementation
(for example with respect to missing bdrv_ref/unref).

In all cases, the lessons that we learn fixing the C code or slowly
including a little bit of C++ _could_ help with a later larger-scale swit=
ch.

> The important thing is this:
>=20
> Coroutines with a single event loop (current model in QEMU) are simpler=

> than threads.  Why?  Because coroutine code is atomic with respect to
> other coroutines in the same event loop.  Only yield points or nested
> event loops allow other coroutines to execute.  That means less explici=
t
> synchronization is necessary.
>=20
> When the block layer goes multiqueue this advantage will be lost and
> coroutine code will have to synchronize explicitly just like threaded
> code.  Coroutines will remain lighter weight than threads and will allo=
w
> M:N threading to be configured via IOThreads.
>=20
> I'm not hopeful that dropping coroutines helps and I don't see that Rus=
t
> brings anything new to the table here.  I do like other aspects of Rust=

> and am open to using it for new code.

Same here.  Just like fixing the C code provides a good foundation for a
language switch, some more battle-tested code could be converted from
QEMU to Rust, in order to get familiar with it and probe whether the
benefits are real.  Maybe the memory API could be a good candidate; it
certainly would benefit from generics.

Paolo


--Gu60LdBM8NoO4JX3NDjxId4KlkPBI0MGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlohi18ACgkQv/vSX3jH
roNaHgf+MLcQ5TKbCXXcRuf1yaQggT2O282CYrtNOj5T0Pcd5HPXYCt3EETcouRS
fhovCiKg+UE4fch4se3fO0+xDscjDvcGa3tRTkxNIRumhwSPvYkaAOhKi4ySg5mn
sS17YvNgLJEaNoSLaQjzFpC6pui3KStnzvsyAgn2vIpMItlDWp8T1EG+MbBKL0QE
ToCxIpL8V57ceyNrZ1VVbXM3cewyeJQvnPOfwqUcwq5b2wtWP97LyC2sy3FpMhWZ
Cx4136YGpSLSj6r9MGC26pg3VUNjc/+COLA9lVqPa50SUjvRVZxcWuz32NGScqKB
ivcq1RcWZESz7gHCqlyUqUfKVIhJDg==
=Na6r
-----END PGP SIGNATURE-----

--Gu60LdBM8NoO4JX3NDjxId4KlkPBI0MGu--
