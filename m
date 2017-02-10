Received: from eggs.gnu.org ([2001:4830:134:3::10]:33732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ccA62-0005RB-26
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ccA60-000536-Nz
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:14:38 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ccA60-0004za-BO
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:14:36 -0500
Received: by mail-lf0-x243.google.com with SMTP id q89so2799703lfi.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 04:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-7-marcandre.lureau@redhat.com>
	<3ce84650-5d49-4db3-b71a-b71a37c0bd98@redhat.com>
	<1174725609.1298917.1486497835239.JavaMail.zimbra@redhat.com>
	<637397de-f396-c8f4-fb23-b5387d2077d0@redhat.com>
In-Reply-To: <637397de-f396-c8f4-fb23-b5387d2077d0@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 Feb 2017 12:14:22 +0000
Message-ID: <CAJ+F1CKa2GiJbYycLEuykFkSc5bRi6OsSK4Fd0tK=bTQ4F8c2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Fri, Feb 10, 2017 at 4:18 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 07/02/2017 21:03, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > ----- Original Message -----
> >>
> >>
> >> On 02/02/2017 15:51, Marc-Andr=C3=A9 Lureau wrote:
> >>> +    if (QTAILQ_IN_USE(chr, next)) {
> >>> +        QTAILQ_REMOVE(&chardevs, chr, next);
> >>> +    }
> >>> +    if (OBJECT(chr)->parent) {
> >>> +        object_unparent(OBJECT(chr));
> >>> +    } else {
> >>> +        object_unref(OBJECT(chr));
> >>> +    }
> >>
> >> What's the case where the "else" is used?  Probably qemu_chr_delete
> >> callers should be changed to use object_unparent or object_unref
> directly.
> >
> > I thought about that, but calling object_unparent() seems weird,
> > since callers aren't much aware of the fact that chardev are added or
> not to a
> > container (useless distinction imho). I wish the last object_unref()
> > would automatically unparent, if the object has a parent. Would that be
> > acceptable?
>
> There is a distinction between the two.  The idea is that unparent
> removes all persistent references in the object tree, while unref only
> removes transient references.  So for example unparent will detach a
> device from its bus.  Unparent is basically exploiting the object tree
> in order to simplify the handling of reference cycles.
>
> Once you add an object with object_property_add_child, you probably
> should remove any transient references you have (such as the one you got
> with object_new) and from that point on use object_unparent only.
>

But if you unparent with the last ref, you remove the burden of knowing if
the object has been parented from the user. I don't see why that would
conflict with object_unparent(), you could still unparent(), and keep the
object referenced somewhere else. The two are not incompatible to me.
Afaik, most widget/hierarchy API work like that, the last unref will
implicitely unparent.

--=20
Marc-Andr=C3=A9 Lureau
