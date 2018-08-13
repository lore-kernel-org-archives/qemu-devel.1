Received: from eggs.gnu.org ([2001:4830:134:3::10]:51982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpIFD-000809-Nc
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpIF9-0005k3-FE
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:11:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:47764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpIF9-0005jd-4E
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:11:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpIF6-0004Zw-KI
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 19:11:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 40CAB2E8525
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 19:11:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Aug 2018 18:58:16 -0000
From: Michele Denber <1785698@bugs.launchpad.net>
Reply-To: Bug 1785698 <1785698@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153358448492.29549.3601216229452882398.malonedeb@chaenomeles.canonical.com>
	<153414808571.8168.1723488818633453757.malone@wampee.canonical.com>
Message-Id: <5B71D4C8.7060006@gmx.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BBug_1785698=5D_Re=3A_Solaris_build_err?=
 =?utf-8?b?b3I6IHVua25vd24gdHlwZSBuYW1lIOKAmGdjcnlfZXJyb3JfdOKAmQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 08-13-2018 4:14 AM, Thomas Huth wrote:
> For providing a Solaris build machine, you best get in touch with Peter
> Maydell (see MAINTAINERS file for his mail address).
I notice he already checked in later in my inbox.  I'll reply to that there.
>
> Now for your build problems, it seems like "libgcrypt-config --cflags"
> already should add /opt/csw/include to the list of header search paths,
> so I wonder why the "#include <gcrypt.h>" does not pick up that file yet
> and you had to add "#include </opt/csw/include/gcrypt.h>" instead? Is
> there maybe another gcrypt.h file somewhere else on your system which
> conflicts with the one from /opt/csw/include ?
Well this is odd but I was poking around trying to resolve a bunch of =

syntax errors in the Makefiles.  This is usually the result of a wrong =

sh being called.  I've had some luck in the past building other things =

by adding a line "!#/usr/xpg4/bin/sh" at the top of the sh file but that =

trick did not work for qemu.  So I finally took the default sh, which is =

/usr/bin/sh (which is a link to /sbin/sh) and instead linked it directly =

to /usr/xpg4/bin/sh.  That immediately took care of all the syntax =

errors and the gcrypt error too.  I don't know why qemu is picky about =

POSIX, but there you have it.
>
> Concerning the "-lutil" problem - no clue where this is coming from.
> Could you maybe try to compile with "gmake V=3D1" and post the line where
> the executable is linked? Maybe that gives some more indication what is
> going on here...
This will probably make you cringe, but what I ended up doing was simply =

copying some random .so file in /opt/csw/lib and calling it libutil.so.  =

The linker then seemed happy and that error went away. I figure that if =

someone is actually using lutil I will get a runtime error, once I get =

it running, if I ever get it running. Then I'll be able to tell who is =

calling it and what they're trying to do.  It may be that no one is =

using it.  I saw some post on the web to the effect that lutil should =

just be commented out in Solaris.  I was unable to figure out from the =

linker error the source of lutil.

I now have a new problem: dtc/checks.c won't compile because it can't =

find strnlen.  So I put in #include <string.h>.  Still wouldn't =

compile.  So I looked in /usr/include/string.h and sure enough, strnlen =

is missing.  I'm like, what the heck?  So I ended up providing the =

source code of strnlen at the top of checks.c.  This was also a problem =

in fdt_ro.c.  It's that sort of thing.  Now it's compiling again.  I =

configured without any target options, so it's making everything.  And I =

forgot to give gmake a -j so it's taking a while.

             - Michele

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785698

Title:
  Solaris build error: unknown type name =E2=80=98gcry_error_t=E2=80=99

Status in QEMU:
  New

Bug description:
  Building qemu 2.12.0 on a Sun Oracle Enterprise M3000 SPARC64 VII,
  Solaris 10 Update 11, opencsw toolchain and gcc 7.3.0, gmake fails
  with a bunch of related errors all in cypher-gcrypt.c:

  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:32: error: =E2=
=80=98gcry_cipher_hd_t=E2=80=99 undeclared (first use in this function); di=
d you mean =E2=80=98gcry_cipher_info=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_encrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);                                ^~~~~~~~~=
~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_cipher_info
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:49: error: exp=
ected =E2=80=98)=E2=80=99 before =E2=80=98ctx=E2=80=99
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_encrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);                                         =
        ^~~
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:11: error: too=
 few arguments to function =E2=80=98gcry_cipher_encrypt=E2=80=99
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_encrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);           ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:566:5: note: declared here
  =C2=A0int gcry_cipher_encrypt (GcryCipherHd h,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_xts_decrypt=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:271:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_error_t err;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:32: error: =E2=
=80=98gcry_cipher_hd_t=E2=80=99 undeclared (first use in this function); di=
d you mean =E2=80=98gcry_cipher_info=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_decrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);                                ^~~~~~~~~=
~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_cipher_info
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:49: error: exp=
ected =E2=80=98)=E2=80=99 before =E2=80=98ctx=E2=80=99
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_decrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);                                         =
        ^~~
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:11: error: too=
 few arguments to function =E2=80=98gcry_cipher_decrypt=E2=80=99
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher_decrypt((gcry_cipher_hd=
_t)ctx, dst, length, src, length);           ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:571:5: note: declared here
  =C2=A0int gcry_cipher_decrypt (GcryCipherHd h,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_cipher_encrypt=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:284:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_error_t err;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:293:21: warning: p=
assing argument 1 of =E2=80=98xts_encrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xts_encrypt(ctx->ha=
ndle, ctx->tweakhandle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:73:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
  =C2=A0void xts_encrypt(const void *datactx,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:293:34: warning: p=
assing argument 2 of =E2=80=98xts_encrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xts_encrypt(ctx->ha=
ndle, ctx->tweakhandle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:73:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
  =C2=A0void xts_encrypt(const void *datactx,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:298:35: warning: p=
assing argument 1 of =E2=80=98gcry_cipher_encrypt=E2=80=99 makes pointer fr=
om integer without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher=
_encrypt(ctx->handle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:566:5: note: expected =E2=80=98GcryCipherHd {aka st=
ruct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
  =C2=A0int gcry_cipher_encrypt (GcryCipherHd h,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_cipher_decrypt=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:320:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_error_t err;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:329:21: warning: p=
assing argument 1 of =E2=80=98xts_decrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xts_decrypt(ctx->ha=
ndle, ctx->tweakhandle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:51:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
  =C2=A0void xts_decrypt(const void *datactx,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:329:34: warning: p=
assing argument 2 of =E2=80=98xts_decrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xts_decrypt(ctx->ha=
ndle, ctx->tweakhandle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:51:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
  =C2=A0void xts_decrypt(const void *datactx,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:334:35: warning: p=
assing argument 1 of =E2=80=98gcry_cipher_decrypt=E2=80=99 makes pointer fr=
om integer without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D gcry_cipher=
_decrypt(ctx->handle,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:571:5: note: expected =E2=80=98GcryCipherHd {aka st=
ruct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
  =C2=A0int gcry_cipher_decrypt (GcryCipherHd h,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_cipher_setiv=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:353:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_error_t err;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:365:19: warning: i=
mplicit declaration of function =E2=80=98gcry_cipher_setctr=E2=80=99; did y=
ou mean =E2=80=98gcry_cipher_setiv=E2=80=99? [-Wimplicit-function-declarati=
on]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0err =3D gcry_cipher_setctr(ctx->handle, iv, niv);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gcry_cipher_setiv
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:365:19: warning: n=
ested extern declaration of =E2=80=98gcry_cipher_setctr=E2=80=99 [-Wnested-=
externs]
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:372:13: warning: i=
mplicit declaration of function =E2=80=98gcry_cipher_reset=E2=80=99; did yo=
u mean =E2=80=98gcry_cipher_close=E2=80=99? [-Wimplicit-function-declaratio=
n]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0gcry_cipher_reset(ctx->handle);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0^~~~~~~~~~~~~~~~~
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0gcry_cipher_close
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:372:13: warning: n=
ested extern declaration of =E2=80=98gcry_cipher_reset=E2=80=99 [-Wnested-e=
xterns]
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:373:19: warning: p=
assing argument 1 of =E2=80=98gcry_cipher_ctl=E2=80=99 makes pointer from i=
nteger without a cast [-Wint-conversion]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0err =3D gcry_cipher_setiv(ctx->handle, iv, niv);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /export/home/denber/qemu-2.12.0/crypto/c=
ipher.c:153:
  /usr/include/gcrypt.h:540:5: note: expected =E2=80=98GcryCipherHd {aka st=
ruct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
  =C2=A0int gcry_cipher_ctl( GcryCipherHd h, int cmd, void *buffer, size_t =
buflen);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^~~~~~~~~~~~~~~
  gmake: *** [/export/home/denber/qemu-2.12.0/rules.mak:67: crypto/cipher.o=
] Error 1

  ---------------------------------------------------------------------

  I do have libgcrypt, libgcrypt_dev, and libgcrypt_utils installed from
  opencsw.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785698/+subscriptions
