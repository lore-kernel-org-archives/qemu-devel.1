Received: from eggs.gnu.org ([2001:4830:134:3::10]:36190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7zdA-0004wB-8J
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7zd6-0001qS-8P
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:32:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d7zd5-0001qB-Vo
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:32:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493966082-9352-1-git-send-email-armbru@redhat.com>
	<20170508164230.GD22428@stefanha-x1.localdomain>
	<79237b29-3f53-64c7-413a-4451562292ff@redhat.com>
	<407b1b2a-d58f-256f-925a-02a5dce759d8@redhat.com>
Date: Tue, 09 May 2017 09:32:14 +0200
In-Reply-To: <407b1b2a-d58f-256f-925a-02a5dce759d8@redhat.com> (Eric Blake's
	message of "Mon, 8 May 2017 14:57:31 -0500")
Message-ID: <87vapa1o5d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/28] QAPI patches for 2017-05-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 05/08/2017 01:09 PM, Eric Blake wrote:
>> On 05/08/2017 11:42 AM, Stefan Hajnoczi wrote:
>>> On Fri, May 05, 2017 at 08:34:42AM +0200, Markus Armbruster wrote:
>>>> [v2]: Fix trailing space, note tweaks to PATCH 12 properly in the
>>>>
>>>> commit message=20
>>>> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01f=
d4d60:
>>>>
>>>>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into s=
taging (2017-05-02 15:16:29 +0100)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-05-04-v2
>>>
>>> make check fails when I apply this series:
>>>
>>>   GTESTER tests/test-char
>>>   GTester: last random seed: R02S47a681e3e741223084711f7aacacb19a
>>>   GTester: last random seed: R02S739de30ffeb0f93caedc22b2863f60a7
>>=20
>> I tried bisecting, and I hit compilation failures during:
>>=20
>>     sockets: Rename SocketAddress to SocketAddressLegacy
>>=20
>> chardev/char-socket.c: In function =E2=80=98qmp_chardev_open_socket=E2=
=80=99:
>> chardev/char-socket.c:948:13: error: implicit declaration of function
>> =E2=80=98qapi_free_SocketAddress=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>>              qapi_free_SocketAddress(s->addr);
>>              ^~~~~~~~~~~~~~~~~~~~~~~
>
> For this one, I got past by squashing in:
>
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 6b89209..1b99344 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -945,7 +945,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>                  goto error;
>              }
>
> -            qapi_free_SocketAddress(s->addr);
> +            qapi_free_SocketAddressLegacy(s->addr);
>              s->addr =3D socket_local_address(sioc->fd, errp);
>              update_disconnected_filename(s);
>
> @@ -1051,7 +1051,7 @@ char_socket_get_addr(Object *obj, Visitor *v,
> const char *name,
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(obj);
>
> -    visit_type_SocketAddress(v, name, &s->addr, errp);
> +    visit_type_SocketAddressLegacy(v, name, &s->addr, errp);
>  }
>
>  static bool

For completeness:

  @@ -1078,7 +1078,7 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
       cc->chr_add_watch =3D tcp_chr_add_watch;
       cc->chr_update_read_handler =3D tcp_chr_update_read_handler;

  -    object_class_property_add(oc, "addr", "SocketAddress",
  +    object_class_property_add(oc, "addr", "SocketAddressLegacy",
                                 char_socket_get_addr, NULL,
                                 NULL, NULL, &error_abort);


To be reverted in the next patch, like the other two.

>
>
>>=20
>>=20
>> and
>>     sockets: Rename SocketAddressFlat to SocketAddress
>>=20
>> chardev/char-socket.c: In function =E2=80=98qmp_chardev_open_socket=E2=
=80=99:
>> chardev/char-socket.c:948:37: error: passing argument 1 of
>> =E2=80=98qapi_free_SocketAddress=E2=80=99 from incompatible pointer type
>> [-Werror=3Dincompatible-pointer-types]
>>              qapi_free_SocketAddress(s->addr);
>>                                      ^
>
> For this one, I squashed in:
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 69e6de6..8a321a1 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -945,7 +945,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>                  goto error;
>              }
>
> -            qapi_free_SocketAddressLegacy(s->addr);
> +            qapi_free_SocketAddress(s->addr);
>              s->addr =3D socket_local_address(sioc->fd, errp);
>              update_disconnected_filename(s);
>
> @@ -1051,7 +1051,7 @@ char_socket_get_addr(Object *obj, Visitor *v,
> const char *name,
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(obj);
>
> -    visit_type_SocketAddressLegacy(v, name, &s->addr, errp);
> +    visit_type_SocketAddress(v, name, &s->addr, errp);
>  }
>
>  static bool

Matching revert here.

> diff --git a/tests/test-char.c b/tests/test-char.c
> index 773a1c3..124d0c5 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -291,7 +291,7 @@ static void char_socket_test(void)
>      Chardev *chr =3D qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowa=
it");
>      Chardev *chr_client;
>      QObject *addr;
> -    QDict *qdict, *data;
> +    QDict *qdict;
>      const char *port;
>      SocketIdleData d =3D { .chr =3D chr };
>      CharBackend be;
> @@ -306,8 +306,7 @@ static void char_socket_test(void)
>
>      addr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_abo=
rt);
>      qdict =3D qobject_to_qdict(addr);
> -    data =3D qdict_get_qdict(qdict, "data");
> -    port =3D qdict_get_str(data, "port");
> +    port =3D qdict_get_str(qdict, "port");
>      tmp =3D g_strdup_printf("tcp:127.0.0.1:%s", port);
>      QDECREF(qdict);
>

This one demonstrates why direct use of QDict sucks: neither grep nor
the compiler help you with refactoring, only the debugger does.
Visitors are much friendlier there.

Going forward, I'd like to see less manual rummaging in QDicts.  If you
need efficiency, use C structs.  If you need the malleability of
QObject, use visitors.

> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index ad3ce65..bee3646 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1369,7 +1369,12 @@ SocketAddressLegacy
> *socket_address_crumple(SocketAddress *addr_flat)
>
>  SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
>  {
> -    SocketAddress *addr =3D g_new(SocketAddress, 1);
> +    SocketAddress *addr;
> +
> +    if (!addr_legacy) {
> +        return NULL;
> +    }
> +    addr =3D g_new(SocketAddress, 1);
>
>      switch (addr_legacy->type) {
>      case SOCKET_ADDRESS_LEGACY_KIND_INET:
>
>
> That was enough to get me back to a working 'make check'.

Needed because ChardevUdp member local is optional.

I searched the changes between this pull request's base and current
master for additional traps, but couldn't find any.

New pull request coming.  Thanks!
