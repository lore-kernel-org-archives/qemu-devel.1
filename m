Received: from eggs.gnu.org ([2001:4830:134:3::10]:36917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccAHh-0003RW-00
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccAHd-00009O-RL
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:26:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ccAHd-00009C-Ir
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:26:37 -0500
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-7-marcandre.lureau@redhat.com>
	<3ce84650-5d49-4db3-b71a-b71a37c0bd98@redhat.com>
	<1174725609.1298917.1486497835239.JavaMail.zimbra@redhat.com>
	<637397de-f396-c8f4-fb23-b5387d2077d0@redhat.com>
	<CAJ+F1CKa2GiJbYycLEuykFkSc5bRi6OsSK4Fd0tK=bTQ4F8c2w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1fdabefe-a492-3c1c-3387-20ad1bc52f9f@redhat.com>
Date: Fri, 10 Feb 2017 13:26:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKa2GiJbYycLEuykFkSc5bRi6OsSK4Fd0tK=bTQ4F8c2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/22] char: add a /chardevs container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org



On 10/02/2017 13:14, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Feb 10, 2017 at 4:18 AM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>=20
>=20
>     On 07/02/2017 21:03, Marc-Andr=C3=A9 Lureau wrote:
>     > Hi
>     >
>     > ----- Original Message -----
>     >>
>     >>
>     >> On 02/02/2017 15:51, Marc-Andr=C3=A9 Lureau wrote:
>     >>> +    if (QTAILQ_IN_USE(chr, next)) {
>     >>> +        QTAILQ_REMOVE(&chardevs, chr, next);
>     >>> +    }
>     >>> +    if (OBJECT(chr)->parent) {
>     >>> +        object_unparent(OBJECT(chr));
>     >>> +    } else {
>     >>> +        object_unref(OBJECT(chr));
>     >>> +    }
>     >>
>     >> What's the case where the "else" is used?  Probably qemu_chr_del=
ete
>     >> callers should be changed to use object_unparent or object_unref
>     directly.
>     >
>     > I thought about that, but calling object_unparent() seems weird,
>     > since callers aren't much aware of the fact that chardev are adde=
d
>     or not to a
>     > container (useless distinction imho). I wish the last object_unre=
f()
>     > would automatically unparent, if the object has a parent. Would
>     that be
>     > acceptable?
>=20
>     There is a distinction between the two.  The idea is that unparent
>     removes all persistent references in the object tree, while unref o=
nly
>     removes transient references.  So for example unparent will detach =
a
>     device from its bus.  Unparent is basically exploiting the object t=
ree
>     in order to simplify the handling of reference cycles.
>=20
>     Once you add an object with object_property_add_child, you probably
>     should remove any transient references you have (such as the one yo=
u got
>     with object_new) and from that point on use object_unparent only.
>=20
>=20
> But if you unparent with the last ref, you remove the burden of knowing
> if the object has been parented from the user. I don't see why that
> would conflict with object_unparent(), you could still unparent(), and
> keep the object referenced somewhere else.

Isn't that exactly why you want them to be different?  unparent can do
much more than unref, for example in the case of a device it will also
unrealize it and destroy all buses underneath it.  Because the device
and bus have a circular reference, you cannot trigger the magic unparent
behavior just by unref'ing the device.

There are just two cases:

- destruction immediately after creation, e.g. on error: new/unref

- successful creation: new/add_child/unref, unparent when deleting

and it's simpler to remember these two than to add magic behavior.

> The two are not incompatible
> to me. Afaik, most widget/hierarchy API work like that, the last unref
> will implicitely unparent.

LibreOffice's has some similarity with QOM, search for "dispose" at
https://people.gnome.org/~michael/blog/2015-08-05-under-the-hood-5-0.html

Paolo
