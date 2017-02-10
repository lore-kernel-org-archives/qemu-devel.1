Received: from eggs.gnu.org ([2001:4830:134:3::10]:44049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ccAnU-0001Vx-W4
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ccAnT-0003Uv-2p
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:59:33 -0500
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:36669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ccAnS-0003U2-GI
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:59:30 -0500
Received: by mail-lf0-x22c.google.com with SMTP id z134so20793311lff.3
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 04:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-7-marcandre.lureau@redhat.com>
	<3ce84650-5d49-4db3-b71a-b71a37c0bd98@redhat.com>
	<1174725609.1298917.1486497835239.JavaMail.zimbra@redhat.com>
	<637397de-f396-c8f4-fb23-b5387d2077d0@redhat.com>
	<CAJ+F1CKa2GiJbYycLEuykFkSc5bRi6OsSK4Fd0tK=bTQ4F8c2w@mail.gmail.com>
	<1fdabefe-a492-3c1c-3387-20ad1bc52f9f@redhat.com>
In-Reply-To: <1fdabefe-a492-3c1c-3387-20ad1bc52f9f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 Feb 2017 12:59:15 +0000
Message-ID: <CAJ+F1C+akemEHSGSiy9ym4hs2KqiU4dGU3JCMoJMpKoXp_+s1g@mail.gmail.com>
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

On Fri, Feb 10, 2017 at 4:26 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
> >
> > But if you unparent with the last ref, you remove the burden of knowing
> > if the object has been parented from the user. I don't see why that
> > would conflict with object_unparent(), you could still unparent(), and
> > keep the object referenced somewhere else.
>
> Isn't that exactly why you want them to be different?  unparent can do
> much more than unref, for example in the case of a device it will also
> unrealize it and destroy all buses underneath it.  Because the device
>

Shouldn't the last unref also unrealize/destroy everything?


> and bus have a circular reference, you cannot trigger the magic unparent
> behavior just by unref'ing the device.
>

Whoo, we have circular references on purposes? Is this lifecycle documented
somewhere? I wonder the rationale behind it.


>
> There are just two cases:
>
> - destruction immediately after creation, e.g. on error: new/unref
>
> - successful creation: new/add_child/unref, unparent when deleting
>

> and it's simpler to remember these two than to add magic behavior.
>
>
That doesn't change the problem, the user may not know if the object is
parented. So you have to pass this information along.



> > The two are not incompatible
> > to me. Afaik, most widget/hierarchy API work like that, the last unref
> > will implicitely unparent.
>
> LibreOffice's has some similarity with QOM, search for "dispose" at
> https://people.gnome.org/~michael/blog/2015-08-05-under-the-hood-5-0.html
>
> I don't see much parallel with the discussion here except that they had a
complicated model and tried to simplify it. That's what I also try to do.
--=20
Marc-Andr=C3=A9 Lureau
