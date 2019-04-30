Received: from eggs.gnu.org ([209.51.188.92]:38825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLaTc-0002a3-Em
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLaTb-0008DB-Ci
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:39:48 -0400
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
	<c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
	<4f41ed2c-b49b-e1f5-e9a3-ad08e16ac77e@redhat.com>
In-Reply-To: <4f41ed2c-b49b-e1f5-e9a3-ad08e16ac77e@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 14:37:51 -0700
Message-ID: <CAKmqyKOxQZAX2grABD5=YFAK=G-TGFRWbJ=PmgutNeosF7M7Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>

On Tue, Apr 30, 2019 at 2:16 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 4/30/19 3:25 PM, Eric Blake wrote:
> > On 4/30/19 3:08 PM, Alistair Francis wrote:
> >> Fix this warning when building with GCC9 on Fedora 30:
> >> In function =E2=80=98strncpy=E2=80=99,
> >>     inlined from =E2=80=98unix_connect_saddr.isra.0=E2=80=99 at util/q=
emu-sockets.c:925:5:
> >> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin=
_strncpy=E2=80=99 specified bound 108 equals destination size [-Werror=3Dst=
ringop-truncation]
> >>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos =
(__dest));
> >>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> >> In function =E2=80=98strncpy=E2=80=99,
> >>     inlined from =E2=80=98unix_listen_saddr.isra.0=E2=80=99 at util/qe=
mu-sockets.c:880:5:
> >>
>
> >> -    strncpy(un.sun_path, path, sizeof(un.sun_path));
> >> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
> >
> > NACK. Linux allows you to use the full width of un.sun_path (a NUL
> > terminator is required if you copy less than that, but not if you use
> > the full width). Rather, we may need to mark path as a potential
> > nonstring to silence the warning, or use memcpy instead of strncpy, or
> > some other workaround.  (Sadly, this is one of those odd places where
> > strncpy is actually the right function to use, but there are so many
> > other places where strncpy is used incorrectly that it has turned into =
a
> > battle to use it here)
>
> We don't have control over un (that's from the libc system headers), but
> does adding the QEMU_NONSTRING attribute to our declaration of path
> serve to silence the warning?

I don't think that would fix it, I'll double check though.

>
> In short, I think most of this series should look at the use of the
> QEMU_NONSTRING macro, as that macro goes hand-in-hand with strncpy() for
> informing the compiler exactly when we know that we are copying
> something that has fixed length and may or may not be NUL-terminated.

I have changed the series to use memcpy() and QEMU_NONSTRING. I'll
send a v2 out soon with all your comments addressed.

Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
