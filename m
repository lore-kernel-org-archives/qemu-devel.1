Received: from eggs.gnu.org ([2001:4830:134:3::10]:52215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVka-0006d5-3g
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVkV-0002by-RU
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:05:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTVkV-0002bV-IM
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:04:55 -0400
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
	<20170707152918.23086-11-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <514bf953-81b7-d379-db20-0cb2af29094b@redhat.com>
Date: Fri, 7 Jul 2017 11:04:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170707152918.23086-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iC82xXNNIRmGXghRc4DRmJeWlhkBsne2b"
Subject: Re: [Qemu-devel] [PATCH v3 10/10] nbd: use generic trace subsystem
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
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iC82xXNNIRmGXghRc4DRmJeWlhkBsne2b
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 den@openvz.org
Message-ID: <514bf953-81b7-d379-db20-0cb2af29094b@redhat.com>
Subject: Re: [PATCH v3 10/10] nbd: use generic trace subsystem instead of
 TRACE macro
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
 <20170707152918.23086-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 10:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Let NBD use the trace mechanisms already present in qemu. Now you can
> use the -trace optino of qemu, or the -T/--trace option of qemu-img,

s/optino/option/

> qemu-io, and qemu-nbd, to select nbd traces. For qemu, the QMP commands=

> trace-event-{get,set}-state can also toggle tracing on the fly.
>=20
> Example:
>    qemu-nbd --trace 'nbd_*' <image file> # enables all nbd traces
>=20
> Recompilation with CFLAGS=3D-DDEBUG_NBD is no more needed, furthermore,=

> DEBUG_NBD macro is removed from the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  Makefile.objs      |  1 +
>  nbd/client.c       | 70 ++++++++++++++++++++++++----------------------=
--------
>  nbd/nbd-internal.h | 19 ---------------
>  nbd/server.c       | 67 ++++++++++++++++++++++++----------------------=
-----
>  nbd/trace-events   | 58 ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 121 insertions(+), 94 deletions(-)
>  create mode 100644 nbd/trace-events

We may still come up with further tweaks, but I have a series that I
plan on posting on top of this, so I'm fine if it goes in as-is (with
the commit message typo fixed).

Reviewed-by: Eric Blake <eblake@redhat.com>

> @@ -342,12 +341,12 @@ static int nbd_receive_query_exports(QIOChannel *=
ioc,
>  {
>      bool foundExport =3D false;
> =20
> -    TRACE("Querying export list for '%s'", wantname);
> +    trace_nbd_receive_query_exports_start(wantname);
>      if (nbd_send_option_request(ioc, NBD_OPT_LIST, 0, NULL, errp) < 0)=
 {
>          return -1;
>      }
> =20
> -    TRACE("Reading available export names");
> +    trace_nbd_receive_query_exports_loop();

Not sure this one adds much useful information.

> @@ -462,7 +460,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>      }
> =20
>      magic =3D ldq_be_p(buf);
> -    TRACE("Magic is 0x%" PRIx64, magic);
> +    trace_nbd_receive_negotiate_magic(magic);
> =20
>      if (memcmp(buf, "NBDMAGIC", 8) !=3D 0) {
>          error_setg(errp, "Invalid magic received");
> @@ -474,7 +472,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>          goto fail;
>      }
>      magic =3D be64_to_cpu(magic);
> -    TRACE("Magic is 0x%" PRIx64, magic);
> +    trace_nbd_receive_negotiate_magic2(magic);

I still think you only need one trace function, called twice (rather
than two separate names with identical implementation)


> @@ -396,15 +396,15 @@ static int nbd_negotiate_options(NBDClient *clien=
t, Error **errp)
>          error_prepend(errp, "read failed: ");
>          return -EIO;
>      }
> -    TRACE("Checking client flags");
> +    trace_nbd_negotiate_options_flags();
>      be32_to_cpus(&flags);
>      if (flags & NBD_FLAG_C_FIXED_NEWSTYLE) {
> -        TRACE("Client supports fixed newstyle handshake");
> +        trace_nbd_negotiate_options_newstyle();
>          fixedNewstyle =3D true;
>          flags &=3D ~NBD_FLAG_C_FIXED_NEWSTYLE;
>      }
>      if (flags & NBD_FLAG_C_NO_ZEROES) {
> -        TRACE("Client supports no zeroes at handshake end");
> +        trace_nbd_negotiate_options_no_zeroes();

My followup series will merge these three into one trace (print the
value once, rather than one trace per bit)

> @@ -422,7 +422,7 @@ static int nbd_negotiate_options(NBDClient *client,=
 Error **errp)
>              error_prepend(errp, "read failed: ");
>              return -EINVAL;
>          }
> -        TRACE("Checking opts magic");
> +        trace_nbd_negotiate_options_check_magic();

Tracing the magic received might be useful.

> @@ -501,8 +501,8 @@ static int nbd_negotiate_options(NBDClient *client,=
 Error **errp)
>                                         &local_err);
> =20
>                  if (local_err !=3D NULL) {
> -                    TRACE("Reply to NBD_OPT_ABORT request failed: %s",=

> -                          error_get_pretty(local_err));
> +                    const char *error =3D error_get_pretty(local_err);=

> +                    trace_nbd_opt_abort_reply_failed(error);
>                      error_free(local_err);
>                  }

Overkill.  Who cares if sending the reply to NBD_OPT_ABORT fails.  I'll
clean that up in my followup series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iC82xXNNIRmGXghRc4DRmJeWlhkBsne2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX7EiAAoJEKeha0olJ0NqYx4IAJXgbQJ78njLaumKo9lM+k1A
MwGW6AzrWE1fuqDV3ZLDW1n2BowPwM6Qzc5o+tXkiNff3CkCBRBA0hxH8Fad2BmO
FcfSLfkgUzzPfRPDUbnngMzP+13rS28TgNhabShNz4m3ktgd0E2bbWbvUz0fq41L
9FdEqwhNwP+cCXyEbyt2FoOAsVw1G2xJ8sIK39NAKB4oEUoyi56fbLAJ6ZnZcznS
y8Oa/Kbz/kSw4zcTYcNHdOtaSLXOsCVfx12+bM66JEP+zWyBMs+60/zUjs4mZhLU
InOQHd+hWpBR9kWNMxba8VecWNCr72oO/tx+xOqPcKB0dT9I0bqRJ+Ai1zeGDjY=
=iWBD
-----END PGP SIGNATURE-----

--iC82xXNNIRmGXghRc4DRmJeWlhkBsne2b--
