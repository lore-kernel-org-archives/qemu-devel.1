Received: from eggs.gnu.org ([2001:4830:134:3::10]:49956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eH8Ko-0005Yn-Hp
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eH8Kn-0000or-F8
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:11:30 -0500
References: <cover.1511230683.git.jcody@redhat.com>
	<1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
	<20171121105935.GB25265@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78d9e8ec-8d87-571d-9202-572a3190b959@redhat.com>
Date: Tue, 21 Nov 2017 14:11:07 +0100
MIME-Version: 1.0
In-Reply-To: <20171121105935.GB25265@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XDjfb0hr7Gx0qI3KEXoo8XEn9ExbWNXjA"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 2/4] coroutine: abort if we try
 to schedule or enter a pending coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XDjfb0hr7Gx0qI3KEXoo8XEn9ExbWNXjA
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 famz@redhat.com, kwolf@redhat.com
Message-ID: <78d9e8ec-8d87-571d-9202-572a3190b959@redhat.com>
Subject: Re: [PATCH v2 for-2.11 2/4] coroutine: abort if we try to schedule or
 enter a pending coroutine
References: <cover.1511230683.git.jcody@redhat.com>
 <1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
 <20171121105935.GB25265@stefanha-x1.localdomain>
In-Reply-To: <20171121105935.GB25265@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 21/11/2017 11:59, Stefan Hajnoczi wrote:
> On Mon, Nov 20, 2017 at 09:23:24PM -0500, Jeff Cody wrote:
>> @@ -438,6 +439,16 @@ fail:
>>  void aio_co_schedule(AioContext *ctx, Coroutine *co)
>>  {
>>      trace_aio_co_schedule(ctx, co);
>> +    const char *scheduled =3D atomic_read(&co->scheduled);
>> +
>> +    if (scheduled) {
>> +        fprintf(stderr,
>> +                "%s: Co-routine was already scheduled in '%s'\n",
>> +                __func__, scheduled);
>> +        abort();
>> +    }
>> +    atomic_set(&co->scheduled, __func__);
>=20
> According to docs/devel/atomics.txt atomic_set()/atomic_read() are
> weakly ordered.  They require memory barriers to provide guarantees
> about ordering.  Your patch doesn't include barriers or comments about
> where the implicit barriers are.
>=20
> The docs recommend using the following instead of
> atomic_read()/atomic_set() to get ordering:
>=20
>   typeof(*ptr) atomic_mb_read(ptr)
>   void         atomic_mb_set(ptr, val)

Even with atomic_mb_read/atomic_mb_set we should document what memory
ordering is required for correctness (i.e. what should be ordered
against what, or equivalently what operation has release/acquire semantic=
s).

My reasoning is that the NULL write to co->scheduled should be ordered
before a write of co (anywhere), but the same is true for co->ctx so the
NULL write is ordered by the smp_wmb in qemu_aio_coroutine_enter.  So
that is fine but it needs a comment.

Dually, the read should be ordered after a read of co, but that's
handled by the callers via atomic_rcu_read if they need the ordering.
No comment needed here I think.

What's left is the __func__ write, where atomic_mb_set should be used
indeed. Or, perhaps better:

    const char *scheduled =3D atomic_cmpxchg(&co->scheduled,
                                           NULL, __func__);
    if (scheduled) {
        ...
    }

=2E.. which also removes the atomic_read.

Thanks,

Paolo


--XDjfb0hr7Gx0qI3KEXoo8XEn9ExbWNXjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAloUJewACgkQv/vSX3jH
roMrwQf/e1Jj0UwFH8zEXqyv6WXuitNK4eDCCbiKAndeiOyxULnXeJEnD97anu5s
lgDZyz41WmbyHhZP3ysHZGqioQOiHEMtdVZdRaqcjGbFj+ZPjoe0W42yZkyRBr8g
VDthGACKxt5agrz1otFZAZjdSNeZ22IBqC9U/8b8fAanEklddNI99lMZ1qXxA7ws
TvcRWYlYgNtz8Amn99e3VxtVaHMemV5a2Rnc1vovS5jLvn3FcHB5/T1ARwlhAVAz
yCQVnBVWvOLzrgzN7we/Y1nUY618DzHm9mtQI2nmLiFRokzfVXIfUxHNZQTw9OC1
qbj4EO2tTDZXyCP/dxQaBcHpRFNgeg==
=ZmHO
-----END PGP SIGNATURE-----

--XDjfb0hr7Gx0qI3KEXoo8XEn9ExbWNXjA--
