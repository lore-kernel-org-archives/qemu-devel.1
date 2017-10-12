Received: from eggs.gnu.org ([2001:4830:134:3::10]:56402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lKo-000418-Bm
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lKn-0000V6-BD
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:48:06 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-5-vsementsov@virtuozzo.com>
	<2250c65b-e347-5404-10de-4da240487fb3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c47a1b0-fa4e-9c12-e425-64d7eed180ed@redhat.com>
Date: Thu, 12 Oct 2017 16:47:55 -0500
MIME-Version: 1.0
In-Reply-To: <2250c65b-e347-5404-10de-4da240487fb3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BJvcHKCl9sLA5rNhkNSnIEi1AVGWNCXvm"
Subject: Re: [Qemu-devel] [PATCH v3 04/13] nbd/server: structurize simple
 reply header sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BJvcHKCl9sLA5rNhkNSnIEi1AVGWNCXvm
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <3c47a1b0-fa4e-9c12-e425-64d7eed180ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/13] nbd/server: structurize simple
 reply header sending
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-5-vsementsov@virtuozzo.com>
 <2250c65b-e347-5404-10de-4da240487fb3@redhat.com>
In-Reply-To: <2250c65b-e347-5404-10de-4da240487fb3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:42 PM, Eric Blake wrote:
> On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Use packed structure instead of pointer arithmetics.
>=20

>> +    set_be_simple_reply(&simple_reply, system_errno_to_nbd_errno(repl=
y->error),
>> +                        reply->handle);
>> +
>=20
> ...but it always occurred immediately after another trace that has
> redundant information (well, the trace you kept shows pre- rather than
> post-translation of errno value to NBD wire value,

On second thought, tracing what gets sent over the wire is probably
nicer than what we had internally (especially if the client traces what
it receives - it's nice to match up values on both sides of the wire).

>=20
> With that change,
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

So here's what I'm squashing in:

diff --git i/nbd/server.c w/nbd/server.c
index 69cd2cda76..65c08fa1cc 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -1201,14 +1201,13 @@ static int
nbd_co_send_simple_reply(NBDRequestData *req, NBDReply *reply,
 {
     NBDClient *client =3D req->client;
     NBDSimpleReply simple_reply;
+    int nbd_err =3D system_errno_to_nbd_errno(reply->error);
     int ret;

     g_assert(qemu_in_coroutine());

-    trace_nbd_co_send_simple_reply(reply->handle, reply->error, len);
-
-    set_be_simple_reply(&simple_reply,
system_errno_to_nbd_errno(reply->error),
-                        reply->handle);
+    trace_nbd_co_send_simple_reply(reply->handle, nbd_err, len);
+    set_be_simple_reply(&simple_reply, nbd_err, reply->handle);

     qemu_co_mutex_lock(&client->send_lock);
     client->send_coroutine =3D qemu_coroutine_self();
diff --git i/nbd/trace-events w/nbd/trace-events
index 4d6f86c2d4..e27614f050 100644
--- i/nbd/trace-events
+++ w/nbd/trace-events
@@ -51,7 +51,6 @@ nbd_negotiate_old_style(uint64_t size, unsigned flags)
"advertising size %" PRIu
 nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags)
"advertising size %" PRIu64 " and flags 0x%x"
 nbd_negotiate_success(void) "Negotiation succeeded"
 nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type,
uint64_t from, uint32_t len) "Got request: { magic =3D 0x%" PRIx32 ",
=2Eflags =3D 0x%" PRIx16 ", .type =3D 0x%" PRIx16 ", from =3D %" PRIu64 "=
, len =3D
%" PRIu32 " }"
-nbd_send_reply(int32_t error, uint64_t handle) "Sending response to
client: { .error =3D %" PRId32 ", handle =3D %" PRIu64 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching
clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching
clients from AIO context %p\n"
 nbd_co_send_simple_reply(uint64_t handle, uint32_t error, int len)
"Send simple reply: handle =3D %" PRIu64 ", error =3D %" PRIu32 ", len =3D=
 %d"


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BJvcHKCl9sLA5rNhkNSnIEi1AVGWNCXvm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf4wwACgkQp6FrSiUn
Q2rh6QgAmew1SW/jvM4eNUpH5d9ZIbUH0dG5DR7/3cq30G8UAOmZ3GhjRgpeFyS9
OT9ewDzvF+1/WId2HKaMK9iePoCZ1YLUv/4R/c24o0YjEgj7gOx7VJuS5whc7unS
Tlt9GjnRNg0o9eWnb1VtFtQonG94bYOKG4qmyCCD/tohxJ5M4D0n/PG46CaOsriK
4Wpvv3Cv5cBRa6KjqdK5+eqULUpM7Wf3VW7DGrKH8eg27fahuX9VO9b2Ol9kaUKA
DA0KBKTOfI+DLyAlALeL6BBqDkYWQTNjNuRLBba7FQ14pyvm92HRKYHSYmYvE/iW
HZfzg2AW4ibrsXMTmHUDgxsO4Mhraw==
=9hYx
-----END PGP SIGNATURE-----

--BJvcHKCl9sLA5rNhkNSnIEi1AVGWNCXvm--
