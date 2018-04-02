Received: from eggs.gnu.org ([2001:4830:134:3::10]:47057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2zze-0008Ox-T2
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 09:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2zzd-00071Y-LK
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 09:59:30 -0400
References: <20180329231837.1914680-1-eblake@redhat.com>
	<84116abb-5af9-a017-898e-435e089d2304@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0819f7c2-0657-a996-1761-2b81d594ea61@redhat.com>
Date: Mon, 2 Apr 2018 08:59:14 -0500
MIME-Version: 1.0
In-Reply-To: <84116abb-5af9-a017-898e-435e089d2304@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xi9g8gPRMKmUiUcHDtqeotCJ5BTBYdgeG"
Subject: Re: [Qemu-devel] [PATCH for-2.12] nbd/client: Correctly handle bad
 server REP_META_CONTEXT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xi9g8gPRMKmUiUcHDtqeotCJ5BTBYdgeG
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <0819f7c2-0657-a996-1761-2b81d594ea61@redhat.com>
Subject: Re: [PATCH for-2.12] nbd/client: Correctly handle bad server
 REP_META_CONTEXT
References: <20180329231837.1914680-1-eblake@redhat.com>
 <84116abb-5af9-a017-898e-435e089d2304@virtuozzo.com>
In-Reply-To: <84116abb-5af9-a017-898e-435e089d2304@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2018 11:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.03.2018 02:18, Eric Blake wrote:
>> It's never a good idea to blindly read for size bytes as
>> returned by the server without first validating that the size
>> is within bounds; a malicious or buggy server could cause us
>> to hang or get out of sync from reading further messages.
>>
>> It may be smarter to try and teach the client to cope with
>> unexpected context ids by silently ignoring them instead of
>> hanging up on the server, but for now, if the server doesn't
>> reply with exactly the one context we expect, it's easier to
>> just give up - however, if we give up for any reason other
>> than an I/O failure, we might as well try to politely tell
>> the server we are quitting rather than continuing.

>> @@ -651,6 +651,14 @@ static int
>> nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *name;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t len;
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reply.length !=3D size=
of(received_id) + context_len) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_setg(errp, "Failed to negotiate meta context '%s',
>> server "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "answered=
 with unexpected length %u", context,
>=20
> uint32_t, is it worth PRIu32 ? Or %u is absolutely portable in this cas=
e?

For trace-events, casting uint32_t to unsigned int is always safe, at
which point using %u is less typing (because the trace goes through a
function prototype conversion).  But when directly printing a uint32_t,
you are correct that some oddball 32-bit platforms might have uint32_t
be long, which would then trigger needless warnings if we don't use
PRIu32.  So I'll fix that.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reply.len=
gth);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb=
d_send_opt_abort(ioc);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> hmm, after this check, len variable is not actually needed, we can use
> context_len
>=20

Okay, I'm squashing this in:

diff --git i/nbd/client.c w/nbd/client.c
index 4ee1d9a4a2c..dd0174b036e 100644
--- i/nbd/client.c
+++ w/nbd/client.c
@@ -649,11 +649,10 @@ static int
nbd_negotiate_simple_meta_context(QIOChannel *ioc,

     if (reply.type =3D=3D NBD_REP_META_CONTEXT) {
         char *name;
-        size_t len;

         if (reply.length !=3D sizeof(received_id) + context_len) {
             error_setg(errp, "Failed to negotiate meta context '%s',
server "
-                       "answered with unexpected length %u", context,
+                       "answered with unexpected length %" PRIu32, conte=
xt,
                        reply.length);
             nbd_send_opt_abort(ioc);
             return -1;
@@ -664,13 +663,13 @@ static int
nbd_negotiate_simple_meta_context(QIOChannel *ioc,
         }
         be32_to_cpus(&received_id);

-        len =3D reply.length - sizeof(received_id);
-        name =3D g_malloc(len + 1);
-        if (nbd_read(ioc, name, len, errp) < 0) {
+        reply.length -=3D sizeof(received_id);
+        name =3D g_malloc(reply.length + 1);
+        if (nbd_read(ioc, name, reply.length, errp) < 0) {
             g_free(name);
             return -1;
         }
-        name[len] =3D '\0';
+        name[reply.length] =3D '\0';
         if (strcmp(context, name)) {
             error_setg(errp, "Failed to negotiate meta context '%s',
server "
                        "answered with different context '%s'", context,


>> @@ -690,6 +699,12 @@ static int
>> nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reply.type !=3D NBD_REP_ACK) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp=
, "Unexpected reply type %" PRIx32 " expected
>> %x",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reply.type, NBD_REP_ACK)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_send_opt_abort(ioc);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (reply.length) {
>=20
> this check is very common for REP_ACK, it may be better to move it to
> nbd_handle_reply_err... (and rename this function? and=C2=A0 combine it=

> somehow with _option_request() and _option_reply()?)
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Unexpect=
ed length to ACK response");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_send_opt_abort(ioc);
>=20
> hmm, looks like we want nbd_send_opt_abort() before most of return -1.
> Looks like it lacks some generalization, may be want to send it at some=

> common point..
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>=20
> mostly, just ideas for future refactoring, so:

Indeed, any refactoring we do in that area belongs in 2.13 patches.

> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks; I'm including this in my NBD pull request today.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Xi9g8gPRMKmUiUcHDtqeotCJ5BTBYdgeG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrCNzIACgkQp6FrSiUn
Q2qFrwgAihDKvrYgByz8O3yYwZlsG7Kx3lC89lfXxU4mcwhO8lAOcOITFLEgrYsY
+hl840VmCS1YIQEs0LWiDPxHx6dC6Ecp2An/UuMhE0t3qyzqG9KhAT2uBXZ5iPFs
556MWNp8AGTNUfcUwRBf0wWktwAWP5NQ+u0Nzzg6A+dv9UUJm32x3SIZrbTd8xxh
jLDiyZkNY5novUjpUz6mYFazlLNmPuKhtUKNBpRmJH23L5HRQYaN4jopFUhIUtLN
B2iG1+ODaaK9du5K015ymMpzoapCILRubZXw1NBXcRK1ZvNemP5I6ayeB8xtJgWA
bziQ/uNGoxrIXLyHiuR0mKpH6WII3Q==
=12DJ
-----END PGP SIGNATURE-----

--Xi9g8gPRMKmUiUcHDtqeotCJ5BTBYdgeG--
