Received: from eggs.gnu.org ([2001:4830:134:3::10]:56031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHtqx-0008Lg-8S
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHtqt-0000ym-5z
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:23:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHtqs-0000xy-So
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:23:31 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-20-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ca6625b0-1be4-fa44-f6fe-da935621d6b3@redhat.com>
Date: Mon, 5 Jun 2017 10:23:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-20-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rlE9UGKlNrTbPcgDaVfacDtEOJLFFi4s0"
Subject: Re: [Qemu-devel] [PATCH 19/19] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rlE9UGKlNrTbPcgDaVfacDtEOJLFFi4s0
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <ca6625b0-1be4-fa44-f6fe-da935621d6b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 19/19] nbd: use generic trace subsystem
 instead of TRACE macro
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-20-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-20-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Stefan as trace maintainer]

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  Makefile.objs      |  1 +
>  nbd/client.c       | 77 ++++++++++++++++++++++++----------------------=
------
>  nbd/nbd-internal.h | 19 -------------
>  nbd/server.c       | 79 ++++++++++++++++++++++++++--------------------=
--------
>  nbd/trace-events   | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 141 insertions(+), 102 deletions(-)
>  create mode 100644 nbd/trace-events

I like where you're headed with this one.

Can you please include an example command line usage in the commit
message of how you are enabling the traces (the old way was to recompile
with CFLAGS=3D-DDEBUG_NBD; the new way no longer requires recompilation,
but listing a formula for easy tracing as part of the commit message
can't hurt).  And if I'm correct, we already have the same command-line
tracing framework hooked up for all of qemu-nbd, qemu-io, and qemu
proper, right?

> @@ -453,8 +452,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>      int rc;
>      bool zeroes =3D true;
> =20
> -    TRACE("Receiving negotiation tlscreds=3D%p hostname=3D%s.",

Most trace messages don't have a trailing '.'; you can remove this one
as part of moving it to trace-events.

> @@ -477,7 +475,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>          goto fail;
>      }
> =20
> -    TRACE("Magic is %s", nbd_magic_to_string(print_buf, buf, 9));
> +    trace_nbd_receive_negotiate_magic(nbd_magic_to_string(print_buf, b=
uf, 9));
> =20
>      if (memcmp(buf, "NBDMAGIC", 8) !=3D 0) {

See my review on 18/19; I think it is sufficient to trace an 8-byte hex
number, instead of trying to string-ize things.  Yeah, the magic number
happens to be an ASCII string, but treating it as a number is no real
loss of information.

>          error_setg(errp, "Invalid magic received");
> @@ -489,7 +487,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>          goto fail;
>      }
>      magic =3D be64_to_cpu(magic);
> -    TRACE("Magic is 0x%" PRIx64, magic);
> +    trace_nbd_receive_negotiate_magic2(magic);

In fact, I think you only need one trace function for tracing an 8-byte
magic number, that can be called from more than one spot.

> @@ -501,15 +499,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const =
char *name, uint16_t *flags,
>              goto fail;
>          }
>          globalflags =3D be16_to_cpu(globalflags);
> -        TRACE("Global flags are %" PRIx32, globalflags);
> +        trace_nbd_receive_negotiate_server_flags(
> +            globalflags,
> +            !!(globalflags & NBD_FLAG_FIXED_NEWSTYLE),
> +            !!(globalflags & NBD_FLAG_NO_ZEROES));

Why do we have to trace particular bits within the flags, when we are
already tracing the flags as a whole?  It is just redundant information
(yes, it makes it a bit harder to read the trace to learn whether a
given flag is set when you only have the hex number, but I don't think
that is a real loss).

>          if (globalflags & NBD_FLAG_FIXED_NEWSTYLE) {
>              fixedNewStyle =3D true;
> -            TRACE("Server supports fixed new style");
>              clientflags |=3D NBD_FLAG_C_FIXED_NEWSTYLE;
>          }
>          if (globalflags & NBD_FLAG_NO_ZEROES) {
>              zeroes =3D false;
> -            TRACE("Server supports no zeroes");
>              clientflags |=3D NBD_FLAG_C_NO_ZEROES;
>          }

I agree with dropping these two TRACE() in favor of the overall trace of
the flags above (this exercise is a good place to figure out where
TRACE() was too chatty).

> @@ -580,7 +579,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>              goto fail;
>          }
>          *size =3D be64_to_cpu(s);
> -        TRACE("Size is %" PRIu64, *size);
> +        trace_nbd_receive_negotiate_export_size(*size);
> =20
>          if (read_sync(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
>              error_prepend(errp, "Failed to read export flags");
> @@ -597,7 +596,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>          goto fail;
>      }
> =20
> -    TRACE("Size is %" PRIu64 ", export flags %" PRIx16, *size, *flags)=
;
> +    trace_nbd_receive_negotiate_size_flags(*size, *flags);

Can we share the same trace for these two callers, by having the first
one use trace_nbd_receive_negotiate_size_flags(*size, 0)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rlE9UGKlNrTbPcgDaVfacDtEOJLFFi4s0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNXdsAAoJEKeha0olJ0NqgFYH/jaEr2+f7CTGW1+thQxR3Z5j
R+9Dm0DeiUTcQLjoWo9LjHHRVpp7pyB1pqiwgHqJ1dx0zdUZ41qEtM5b7Ejuejjb
9ntpLFppxZqOZU/YvCJ3WovLm6wWxPiwRKmhb2FcT6GHI9hMXycmqWzh55kKs3oH
b5RZ+/syfuiJ3He3+iGJLKpq5TJCGtakc9F8V4PDTofEctjQA09SWlhlg4T4IONG
f86Ysf/7yFVj6K7/l7LB+VfSJVaGKwlQu+ZKVnnuCeGkl5DsZLm2U7DvK/xy53io
ihcplzFnYnlx8ax/PoNNjCt9gksOQTOPU7x2XU2P6yxTsdj4KVU971jz+neGkAM=
=JfJW
-----END PGP SIGNATURE-----

--rlE9UGKlNrTbPcgDaVfacDtEOJLFFi4s0--
