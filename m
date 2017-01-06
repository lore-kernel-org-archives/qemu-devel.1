Received: from eggs.gnu.org ([2001:4830:134:3::10]:43573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cPaXH-0004ON-9B
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cPaXE-0006ER-Nw
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:50:47 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:39027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cPaXE-0006Du-FJ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 14:50:44 -0500
Date: Fri, 6 Jan 2017 14:50:42 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <879157803.3629382.1483732242164.JavaMail.zimbra@redhat.com>
In-Reply-To: <eb000893-3982-016f-e4dc-81ce0f50b6ce@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-2-marcandre.lureau@redhat.com>
	<eb000893-3982-016f-e4dc-81ce0f50b6ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/20] tests: fix linking test-char on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

Hi

----- Original Message -----
> On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> > test-char.exe needs main-loop.o symbols, among others. Linking with
> > $(test-block-obj-y) brings what's necessary. We could try to eventually
> > strip to the minimum if needed.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/Makefile.include | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Can I have a bit more background? I'm guessing this doesn't fix an
> actual failure at the moment (probably due to one of the other files
> dragging in stuff indirectly), but rather cleans up a latent problem
> that would otherwise be exposed with patches later in the series (where
> splitting files means the stuff is no longer dragged in indirectly, so
> we need to mention it explicitly)?

It does fix current linking failure:
x86_64-w64-mingw32-g++ -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/pix=
man-1  -I/home/elmarco/src/qemu/dtc/libfdt -Werror -mms-bitfields -I/usr/x8=
6_64-w64-mingw32/sys-root/mingw/include/glib-2.0 -I/usr/x86_64-w64-mingw32/=
sys-root/mingw/lib/glib-2.0/include -I/usr/x86_64-w64-mingw32/sys-root/ming=
w/include  -m64 -mcx16 -mthreads -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_=
AND_MEAN -DWINVER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFI=
LE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strin=
gs -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-l=
abels -Wno-shift-negative-value -Wmissing-include-dirs -Wempty-body -Wneste=
d-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -=
Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-protect=
or-strong  -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/libpng16  -I/ho=
me/elmarco/src/qemu/tests -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g  -=
Wl,--nxcompat -Wl,--no-seh -Wl,--dynamicbase -Wl,--warn-common -m64 -g  -o =
tests/test-char.exe tests/test-char.o qemu-char.o qemu-timer.o io/channel.o=
 io/channel-buffer.o io/channel-command.o io/channel-file.o io/channel-sock=
et.o io/channel-tls.o io/channel-watch.o io/channel-websock.o io/channel-ut=
il.o io/task.o crypto/init.o crypto/hash.o crypto/hash-glib.o crypto/hmac.o=
 crypto/hmac-glib.o crypto/aes.o crypto/desrfb.o crypto/cipher.o crypto/tls=
creds.o crypto/tlscredsanon.o crypto/tlscredsx509.o crypto/tlssession.o cry=
pto/secret.o crypto/random-platform.o crypto/pbkdf.o crypto/ivgen.o crypto/=
ivgen-essiv.o crypto/ivgen-plain.o crypto/ivgen-plain64.o crypto/afsplit.o =
crypto/xts.o crypto/block.o crypto/block-qcow.o crypto/block-luks.o qom/obj=
ect.o qom/container.o qom/qom-qobject.o qom/object_interfaces.o  libqemuuti=
l.a libqemustub.a /home/elmarco/src/qemu/winb/version.o  -L/usr/x86_64-w64-=
mingw32/sys-root/mingw/lib -lgthread-2.0 -lglib-2.0 -lintl  -lwinmm -lws2_3=
2 -liphlpapi  -lz -lz=20
qemu-char.o: In function `win_chr_free':
/home/elmarco/src/qemu/qemu-char.c:2149: undefined reference to `qemu_del_p=
olling_cb'
/home/elmarco/src/qemu/qemu-char.c:2151: undefined reference to `qemu_del_p=
olling_cb'
qemu-char.o: In function `win_stdio_thread':
/home/elmarco/src/qemu/qemu-char.c:2568: undefined reference to `qemu_del_w=
ait_object'
qemu-char.o: In function `qemu_chr_open_stdio':
/home/elmarco/src/qemu/qemu-char.c:2661: undefined reference to `qemu_add_w=
ait_object'
/home/elmarco/src/qemu/qemu-char.c:2646: undefined reference to `qemu_add_w=
ait_object'
/home/elmarco/src/qemu/qemu-char.c:2696: undefined reference to `qemu_del_w=
ait_object'
/home/elmarco/src/qemu/qemu-char.c:2691: undefined reference to `qemu_del_w=
ait_object'
qemu-char.o: In function `win_chr_pipe_init':
/home/elmarco/src/qemu/qemu-char.c:2413: undefined reference to `qemu_add_p=
olling_cb'
qemu-char.o: In function `win_chr_init':
/home/elmarco/src/qemu/qemu-char.c:2215: undefined reference to `qemu_add_p=
olling_cb'
qemu-char.o: In function `win_stdio_wait_func':
/home/elmarco/src/qemu/qemu-char.c:2512: undefined reference to `qemu_del_w=
ait_object'
collect2: error: ld returned 1 exit status
/home/elmarco/src/qemu/rules.mak:109: recipe for target 'tests/test-char.ex=
e' failed
make: *** [tests/test-char.exe] Error 1

I can add this linking error to the commit log if it helps.

>=20
> Even mentioning _which_ main-loop.o symbol to be grepping for in
> test-char.c might be helpful to the review.

It's from qemu-char.c.

>=20
> >=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 4841d582a1..a8f3d12e49 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -489,7 +489,7 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o
> > $(test-util-obj-y)
> >  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o
> >  $(test-qom-obj-y)
> >  tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o
> >  $(test-qom-obj-y)
> > =20
> > -tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o
> > $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y)
> > +tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o
> > $(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)
>=20
> At any rate, test-block-obj-y is simply test-io-obj-y plus the
> additional block-obj-y, so you're merely adding an additional dependency
> on block-obj-y files.  While a nicer commit message may help, I don't
> see any technical problem in the change, so here's a weak:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>=20
>=20
