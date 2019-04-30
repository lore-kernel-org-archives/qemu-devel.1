Received: from eggs.gnu.org ([209.51.188.92]:59926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZwr-0004rd-3R
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZwp-0003WC-VG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:05:57 -0400
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
	<8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
In-Reply-To: <8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 14:04:00 -0700
Message-ID: <CAKmqyKNOmjxJqqi9rvL=8zH6ePfTpHGiurBeq8Q2Q9A-fk2qFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
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

On Tue, Apr 30, 2019 at 1:40 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 4/30/19 3:09 PM, Alistair Francis wrote:
> > Fix this warning when building with GCC9 on Fedora 30:
> > In function =E2=80=98strncpy=E2=80=99,
> >     inlined from =E2=80=98sys_uname=E2=80=99 at /home/alistair/qemu/lin=
ux-user/uname.c:94:3:
> > /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 output may be truncated copying 64 bytes from a string of =
length 64 [-Werror=3Dstringop-truncation]
> >   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  linux-user/uname.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/linux-user/uname.c b/linux-user/uname.c
> > index 313b79dbad..293b2238f2 100644
> > --- a/linux-user/uname.c
> > +++ b/linux-user/uname.c
> > @@ -90,6 +90,11 @@ int sys_uname(struct new_utsname *buf)
> >     * struct linux kernel uses).
> >     */
> >
> > +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wstringop-truncation"
> > +#endif
>
> Why do we need the pragma?
>
> > +
> >    memset(buf, 0, sizeof(*buf));
>
> We are prezeroing the entire field, at which point...
>
> >    COPY_UTSNAME_FIELD(buf->sysname, uts_buf.sysname);
> >    COPY_UTSNAME_FIELD(buf->nodename, uts_buf.nodename);
>
> ...using strncpy() for a shorter string is wasteful (we're writing the
> tail end twice), and for a long string is warning-prone.  Why not
> rewrite COPY_UTSNAME_FIELD() to use memcpy() for the MIN(strlen(src),
> __NEW_UTS_LEN) and drop the write of the trailing NUL, since it will
> already be NUL from your memset()?

I'm happy to do that, I'll change it to memcpy().

Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
