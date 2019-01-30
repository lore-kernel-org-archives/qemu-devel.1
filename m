Received: from eggs.gnu.org ([209.51.188.92]:33335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gorHI-0004ep-1N
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gorHG-0007cu-5h
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:55:47 -0500
References: <20190129143800.88563-1-vsementsov@virtuozzo.com>
	<20190129143800.88563-2-vsementsov@virtuozzo.com>
	<0cc0ace6-c260-85db-3e0b-21d8f7e39005@redhat.com>
	<1152f912-5912-29c3-cf75-1656293f5891@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eeb11886-51ec-2749-5451-29f8a382b63a@redhat.com>
Date: Wed, 30 Jan 2019 08:55:18 -0600
MIME-Version: 1.0
In-Reply-To: <1152f912-5912-29c3-cf75-1656293f5891@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6uLeCQgkLqm3ILqlAZ2GpIu0wpcPXODgE"
Subject: Re: [Qemu-devel] [PATCH 1/2] block: enhance QEMUIOVector structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6uLeCQgkLqm3ILqlAZ2GpIu0wpcPXODgE
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Message-ID: <eeb11886-51ec-2749-5451-29f8a382b63a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: enhance QEMUIOVector structure
References: <20190129143800.88563-1-vsementsov@virtuozzo.com>
 <20190129143800.88563-2-vsementsov@virtuozzo.com>
 <0cc0ace6-c260-85db-3e0b-21d8f7e39005@redhat.com>
 <1152f912-5912-29c3-cf75-1656293f5891@virtuozzo.com>
In-Reply-To: <1152f912-5912-29c3-cf75-1656293f5891@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/30/19 3:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.01.2019 0:35, Eric Blake wrote:
>> On 1/29/19 8:37 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Add a possibility of embedded iovec, for cases when we need only one
>>> local iov.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   include/qemu/iov.h | 41 ++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 40 insertions(+), 1 deletion(-)

>> POSIX does not guarantee that iov_base occurs prior to iov_len in stru=
ct
>> iovec; your code is therefore rather fragile and would fail to compile=

>> if we encounter a libc where iov_len is positioned differently than in=

>> glibc, tripping the first assertion.  For an offset other than 0, you
>> could declare:
>>    char [offsetof(struct iovec, iov_len)] __pad;
>> to be more robust; but since C doesn't like 0-length array declaration=
s,
>> I'm not sure how you would cater to a libc where iov_len is at offset =
0,
>=20
> Hmm, tested a bit, and the only complain I can get is a warning about 0=
-sized
> array when option -pedantic is set. So, is it a real problem?

Even if we require the use of gcc extensions elsewhere, it doesn't hurt
to avoid them where it is easy.

>=20
> And we already have a lot of zero-sized arrays in Qemu, just look at
>   git grep '\w\+\s\+\w\+\[0\];' | grep -v return

And how many of those are the last entry in a struct?  A 0-size array at
the end is a common idiom for a flex-sized struct (without relying on
C99 VLA); a 0-size array in the middle of a struct is unusual.

>=20
>=20
> hm, or we can do like this:
>=20
> typedef struct QEMUIOVector {
>      struct iovec *iov;
>      int niov;
>      union {
>          struct {
>              int nalloc;
>              struct iovec local_iov;
>          };
>          struct {
>              char __pad[sizeof(int) + offsetof(struct iovec, iov_len)];=

>              size_t size;
>          };
>      };
> } QEMUIOVector;

Yes, that's a reasonable way to do it.

>=20
>=20
>> short of a configure probe and #ifdeffery, which feels like a bit much=

>> to manage (really, the point of the assert is that we don't have to
>> worry about an unusual libc having a different offset UNLESS the build=

>> fails, so no need to address a problem we aren't hitting yet).
>=20
> However, char __pad[offsetof(struct iovec, iov_len)]; seems useful and =
even
> more self-documented, so I'll use it in v2, if nobody minds.
>

We'll see how it looks, then.


>>> +        .iov_base =3D (void *)(buf),          \
>>
>> Why is the cast necessary?  Are we casting away const?

Answered in 2/2 - yes. But a comment about /* cast away const */ is usefu=
l.

>>  Since C already
>> allows assignment of any other (non-const) pointer to void* without a
>> cast, it looks superfluous.
>>
>>> +        .iov_len =3D len                      \
>>
>> Missing () around len.
>=20
> For style? What the thing len should be to break it without ()?

Although we are unlikely to hit this given our coding conventions,
remember that '=3D' has higher precedence than ',', for this contorted
example (and yes, it's contorted because you can't pass the comma
operator through to a macro without either supplying your own (), which
defeats the demonstration, or relying on a helper macro such as
raw_pair() here):

$ cat foo.c
struct s {
    int i;
};
#define raw_pair(a, b) a, b
#define A(arg) { .i =3D (arg) }
#define B(arg) { .i =3D arg }

int
main(int argc, char **argv)
{
    struct s s1 =3D A(raw_pair(1, 2));
    struct s s2 =3D B(raw_pair(4, 8));
    return s1.i + s2.i;
}
$ gcc -o foo foo.c
foo.c: In function =E2=80=98main=E2=80=99:
foo.c:12:33: warning: excess elements in struct initializer
     struct s s2 =3D B(raw_pair(4, 8));
                                 ^
foo.c:6:23: note: in definition of macro =E2=80=98B=E2=80=99
 #define B(arg) { .i =3D arg }
                       ^~~
foo.c:12:21: note: in expansion of macro =E2=80=98raw_pair=E2=80=99
     struct s s2 =3D B(raw_pair(4, 8));
                     ^~~~~~~~
foo.c:12:33: note: (near initialization for =E2=80=98s2=E2=80=99)
     struct s s2 =3D B(raw_pair(4, 8));
                                 ^
foo.c:6:23: note: in definition of macro =E2=80=98B=E2=80=99
 #define B(arg) { .i =3D arg }
                       ^~~
foo.c:12:21: note: in expansion of macro =E2=80=98raw_pair=E2=80=99
     struct s s2 =3D B(raw_pair(4, 8));
                     ^~~~~~~~
$ ./foo; echo $?
6

which says that for A() using the (), there were no warnings and the
second value was assigned (-Wall changes that, complaining about unused
value of the left side of the comma operator - but that's okay); but for
B() without (), there was a diagnostic even without -Wall about too many
initializers, and the first value was assigned.

>> Why both a macro and a function that uses the macro?=20

Also answered in 2/2 - the macro is for variable declarations; the
function is for runtime code such as for-loops that start with an
uninitialized declaration and have to reinitialize things. They also
differ in that one takes a struct, the other takes a pointer to a struct.=



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6uLeCQgkLqm3ILqlAZ2GpIu0wpcPXODgE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxRutYACgkQp6FrSiUn
Q2o/7Af3SRi7+B8TR5oGELJbOlCWr47mTt5067B2XXzDUMLFNQE6lTPYyPdkJ5L0
kAaRLOx8CQMFrcv+4YW1kiSQdoHsJ0WICO6drLTb9P/WYFZq4wmjSxqZXMhK6X4x
4OxPWO+v08+39jNlZ+tpfGdo6prcJs5D2Lk3QQYmU8y5r1lLKZUJ8BxPQegsLHrE
Wl8+JTkb9CQOsDW6Rh4ksVLhk917HEYjE+yL4OnSP2G+eRCAUpqbam/C/2mWV8+x
TVYa5a/7FZE6nZeONiiGoYpoWOO/0ytctAUyQ5pUhwSeTrMktfEPF+bd2tTukeIA
xuHPU51v9cXmgjNtSyBmyqEw7rUs
=4o1r
-----END PGP SIGNATURE-----

--6uLeCQgkLqm3ILqlAZ2GpIu0wpcPXODgE--
