Received: from eggs.gnu.org ([2001:4830:134:3::10]:34335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7omq-0001Zz-Kk
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7omn-00058p-HB
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:57:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7omn-00057G-7C
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:57:37 -0400
References: <1493966082-9352-1-git-send-email-armbru@redhat.com>
	<20170508164230.GD22428@stefanha-x1.localdomain>
	<79237b29-3f53-64c7-413a-4451562292ff@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <407b1b2a-d58f-256f-925a-02a5dce759d8@redhat.com>
Date: Mon, 8 May 2017 14:57:31 -0500
MIME-Version: 1.0
In-Reply-To: <79237b29-3f53-64c7-413a-4451562292ff@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ktGuFjwceBAricB9xx6cjahnxqwlqittK"
Subject: Re: [Qemu-devel] [PULL v2 00/28] QAPI patches for 2017-05-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ktGuFjwceBAricB9xx6cjahnxqwlqittK
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <407b1b2a-d58f-256f-925a-02a5dce759d8@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 00/28] QAPI patches for 2017-05-04
References: <1493966082-9352-1-git-send-email-armbru@redhat.com>
 <20170508164230.GD22428@stefanha-x1.localdomain>
 <79237b29-3f53-64c7-413a-4451562292ff@redhat.com>
In-Reply-To: <79237b29-3f53-64c7-413a-4451562292ff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 01:09 PM, Eric Blake wrote:
> On 05/08/2017 11:42 AM, Stefan Hajnoczi wrote:
>> On Fri, May 05, 2017 at 08:34:42AM +0200, Markus Armbruster wrote:
>>> [v2]: Fix trailing space, note tweaks to PATCH 12 properly in the
>>>
>>> commit message=20
>>> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01=
fd4d60:
>>>
>>>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into =
staging (2017-05-02 15:16:29 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-05-04-v2
>>
>> make check fails when I apply this series:
>>
>>   GTESTER tests/test-char
>>   GTester: last random seed: R02S47a681e3e741223084711f7aacacb19a
>>   GTester: last random seed: R02S739de30ffeb0f93caedc22b2863f60a7
>=20
> I tried bisecting, and I hit compilation failures during:
>=20
>     sockets: Rename SocketAddress to SocketAddressLegacy
>=20
> chardev/char-socket.c: In function =E2=80=98qmp_chardev_open_socket=E2=80=
=99:
> chardev/char-socket.c:948:13: error: implicit declaration of function
> =E2=80=98qapi_free_SocketAddress=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
>              qapi_free_SocketAddress(s->addr);
>              ^~~~~~~~~~~~~~~~~~~~~~~

For this one, I got past by squashing in:


diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 6b89209..1b99344 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -945,7 +945,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
                 goto error;
             }

-            qapi_free_SocketAddress(s->addr);
+            qapi_free_SocketAddressLegacy(s->addr);
             s->addr =3D socket_local_address(sioc->fd, errp);
             update_disconnected_filename(s);

@@ -1051,7 +1051,7 @@ char_socket_get_addr(Object *obj, Visitor *v,
const char *name,
 {
     SocketChardev *s =3D SOCKET_CHARDEV(obj);

-    visit_type_SocketAddress(v, name, &s->addr, errp);
+    visit_type_SocketAddressLegacy(v, name, &s->addr, errp);
 }

 static bool


>=20
>=20
> and
>     sockets: Rename SocketAddressFlat to SocketAddress
>=20
> chardev/char-socket.c: In function =E2=80=98qmp_chardev_open_socket=E2=80=
=99:
> chardev/char-socket.c:948:37: error: passing argument 1 of
> =E2=80=98qapi_free_SocketAddress=E2=80=99 from incompatible pointer typ=
e
> [-Werror=3Dincompatible-pointer-types]
>              qapi_free_SocketAddress(s->addr);
>                                      ^

For this one, I squashed in:

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 69e6de6..8a321a1 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -945,7 +945,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
                 goto error;
             }

-            qapi_free_SocketAddressLegacy(s->addr);
+            qapi_free_SocketAddress(s->addr);
             s->addr =3D socket_local_address(sioc->fd, errp);
             update_disconnected_filename(s);

@@ -1051,7 +1051,7 @@ char_socket_get_addr(Object *obj, Visitor *v,
const char *name,
 {
     SocketChardev *s =3D SOCKET_CHARDEV(obj);

-    visit_type_SocketAddressLegacy(v, name, &s->addr, errp);
+    visit_type_SocketAddress(v, name, &s->addr, errp);
 }

 static bool
diff --git a/tests/test-char.c b/tests/test-char.c
index 773a1c3..124d0c5 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -291,7 +291,7 @@ static void char_socket_test(void)
     Chardev *chr =3D qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowa=
it");
     Chardev *chr_client;
     QObject *addr;
-    QDict *qdict, *data;
+    QDict *qdict;
     const char *port;
     SocketIdleData d =3D { .chr =3D chr };
     CharBackend be;
@@ -306,8 +306,7 @@ static void char_socket_test(void)

     addr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_abo=
rt);
     qdict =3D qobject_to_qdict(addr);
-    data =3D qdict_get_qdict(qdict, "data");
-    port =3D qdict_get_str(data, "port");
+    port =3D qdict_get_str(qdict, "port");
     tmp =3D g_strdup_printf("tcp:127.0.0.1:%s", port);
     QDECREF(qdict);

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index ad3ce65..bee3646 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1369,7 +1369,12 @@ SocketAddressLegacy
*socket_address_crumple(SocketAddress *addr_flat)

 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 {
-    SocketAddress *addr =3D g_new(SocketAddress, 1);
+    SocketAddress *addr;
+
+    if (!addr_legacy) {
+        return NULL;
+    }
+    addr =3D g_new(SocketAddress, 1);

     switch (addr_legacy->type) {
     case SOCKET_ADDRESS_LEGACY_KIND_INET:


That was enough to get me back to a working 'make check'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ktGuFjwceBAricB9xx6cjahnxqwlqittK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEM2rAAoJEKeha0olJ0NqpPAH/A95flds+AegJS2UZgN6TYQm
ePOc28ZPUVau2NyvgHDj5m6AGdsivNBYZmdFciGXGMr0I+T69K1AJLslaWRtivOw
cF0XU/vcC5pfKkPla8Rr217l2Pb9qWPjFBEvLnD+jVsdJ4CqJ//eMKbpXZnFfNz3
YDEONeMHquqa5WRpGVCqij+XKMX9NYzF5W/6WLVVUOQYN+mcMF+wGm3+VKR9taaw
zgiKehK/CvZ9XnozG2DQWu63qqYx2o2VND8gjXvm3HinlryNFMTFzNIECcu2s9Vo
Y2n0UgFxczpw21OUSlcpkOqLJhXAXFWWQ9Mbh1qE4QIJRgM9u+LhOXTo18vrDfA=
=TBEb
-----END PGP SIGNATURE-----

--ktGuFjwceBAricB9xx6cjahnxqwlqittK--
