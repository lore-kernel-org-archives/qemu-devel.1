Received: from eggs.gnu.org ([2001:4830:134:3::10]:43539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cWI8K-0003Ta-GC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cWI8F-0000Ko-ME
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:36:44 -0500
Received: from clearmind.me ([178.32.49.9]:54933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cWI8F-0000Ke-F8
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:36:39 -0500
Date: Wed, 25 Jan 2017 08:37:44 +0100
From: Alessandro Di Federico <ale+qemu@clearmind.me>
In-Reply-To: <CAJ+F1C+G2Ud8BzDPdTmT8hg6BZ-QcAQSpxHbYGhgPkrcrwTY4Q@mail.gmail.com>
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
	<20170121084600.5860-4-ale+qemu@clearmind.me>
	<CAJ+F1C+G2Ud8BzDPdTmT8hg6BZ-QcAQSpxHbYGhgPkrcrwTY4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1cWIB1-0000hV-AY@clearmind.me>
Sender: ale@clearmind.me
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] Introduce libtcg infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, 24 Jan 2017 10:08:56 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

>
> > * If there's at least a *-libtcg, compile everything as position
> >   independent code.
>=20
> why not limit it to libtcg code?
>=20

At least we have to enable it on "common" object files (those compiled
only once, independently from the current target), therefore I see
little benefit in compiling without PIC other object files.
I also think it might be a good idea to switch to PIE executables
altogether.

>=20
> > * In case we're building libtcg, install the output binary in the
> >   $PREFIX/lib directory instead of $PREFIX/bin.
> > =20
>=20
> If it's installed globally, I think we have to deal with versioning,
> common prefix, and list of visible symbols.
>=20

Yeah, for symbol visibility I was thinking to force all the symbols to
be hidden except for those in tcg.c, which would have a `tcg_` prefix.
I didn't think about versioning yet.

>=20
> What's the plan with this tcg.c? Shouldn't the functions be stubs or
> library user callbacks?
>=20
> What is test() doing?
>=20
> Please add a libtcg test under tests/ (even minimal, like a basic
> translate/dump).
>=20

This patch was to get a first round of opinions. The test function was
only supposed to reference some functions I know I'll use to make sure
that I'm linking in all the required object files.
In the next set of patches I'll provide something that actually does
something.

>=20
> >
> >  ifdef CONFIG_USER_ONLY
> > +ifdef CONFIG_LIBTCG
> > +# libtcg
> > +QEMU_PROG=3Dlibtcg-$(TARGET_NAME)$(DSOSUF)
> > +QEMU_PROG_BUILD =3D $(QEMU_PROG)
> > +QEMU_CFLAGS+=3D-fPIC
> > +
> > +# Change the install directory
> > +PROGS_INSTALL_DIR :=3D $(libdir)
> > =20
>=20
> okay, we may want to rename it to something like QEMU_BUILD perhaps
>=20

You mean the QEMU_PROG_BUILD? ACK.

>
> >  install: all
> > +ifdef CONFIG_LIBTINYCODE
> > +       $(INSTALL_DATA) $(SRC_PATH)/tcg/tcg-opc.h
> > $(SRC_PATH)/libtcg/tcg.h "$(DESTDIR)$(includedir)"
> > +endif
> > =20
>=20
> LIBTINYCODE/LIBTCG?
>=20

Leftover from my internal version.

>
> > -crypto-obj-y +=3D aes.o
> > +crypto-obj-$(call lnot,$(CONFIG_LIBTCG)) +=3D aes.o
> > =20
>=20
> why that change?
>=20

aes.o was being linked in, but we don't use it in LIBTCG. Maybe this
should be fixed in an higher level.

>=20
> > diff --git a/libtcg/tcg.h b/libtcg/tcg.h
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > =20
>=20
> What is this empty file for?
>=20

Just a placeholder for the header file to install. This patch goal was
to show all the changes to the build system.

Thanks for the comments.

--
Alessandro Di Federico
PhD student at Politecnico di Milano
