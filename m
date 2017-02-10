Received: from eggs.gnu.org ([2001:4830:134:3::10]:47059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccB01-00063E-S9
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccAzx-00007y-S0
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:12:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ccAzx-00007o-MP
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:12:25 -0500
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-7-marcandre.lureau@redhat.com>
	<3ce84650-5d49-4db3-b71a-b71a37c0bd98@redhat.com>
	<1174725609.1298917.1486497835239.JavaMail.zimbra@redhat.com>
	<637397de-f396-c8f4-fb23-b5387d2077d0@redhat.com>
	<CAJ+F1CKa2GiJbYycLEuykFkSc5bRi6OsSK4Fd0tK=bTQ4F8c2w@mail.gmail.com>
	<1fdabefe-a492-3c1c-3387-20ad1bc52f9f@redhat.com>
	<CAJ+F1C+akemEHSGSiy9ym4hs2KqiU4dGU3JCMoJMpKoXp_+s1g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <351188b2-37a4-6a01-37e3-126e186e016d@redhat.com>
Date: Fri, 10 Feb 2017 14:12:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+akemEHSGSiy9ym4hs2KqiU4dGU3JCMoJMpKoXp_+s1g@mail.gmail.com>
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



On 10/02/2017 13:59, Marc-Andr=C3=A9 Lureau wrote:
>     > But if you unparent with the last ref, you remove the burden of k=
nowing
>     > if the object has been parented from the user. I don't see why th=
at
>     > would conflict with object_unparent(), you could still unparent()=
, and
>     > keep the object referenced somewhere else.
>=20
>     Isn't that exactly why you want them to be different?  unparent can=
 do
>     much more than unref, for example in the case of a device it will a=
lso
>     unrealize it and destroy all buses underneath it.  Because the devi=
ce
>=20
> Shouldn't the last unref also unrealize/destroy everything?

How could someone say they have the "last unref"?  They didn't get that
reference from anywhere, the reference is owned by the parent object's
child property.

>     and bus have a circular reference, you cannot trigger the magic unp=
arent
>     behavior just by unref'ing the device.
>=20
> Whoo, we have circular references on purposes? Is this lifecycle
> documented somewhere? I wonder the rationale behind it.

The same as Libreoffice: we had a model with no reference counting (just
"qdev_free") and we tried to adapt it to QOM's reference counting model,
in our case by exploiting the object tree.

>     There are just two cases:
>=20
>     - destruction immediately after creation, e.g. on error: new/unref
>=20
>     - successful creation: new/add_child/unref, unparent when deleting
>=20
>     and it's simpler to remember these two than to add magic behavior.
>=20
> That doesn't change the problem, the user may not know if the object is
> parented.

If the user got a reference for himself via object_ref or object_new, it
must use object_unref.

If the user wants to remove public knowledge of an object, then they
must use object_unparent.  If the object is not parented, there's a
violation of QOM rules somewhere.

Paolo
