Received: from eggs.gnu.org ([2001:4830:134:3::10]:51248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZx1b-0004Nk-QF
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZx1Z-0007mD-Jo
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:01:59 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZx1Z-0007lm-DE
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:01:57 -0500
Received: by mail-wr1-x441.google.com with SMTP id t6so1453386wrr.12
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 04:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA89ZxboWWDn3iDh_8u-ejMKjhWmmA_ckLMH7si+yU_icw@mail.gmail.com>
In-Reply-To: <CAFEAcA89ZxboWWDn3iDh_8u-ejMKjhWmmA_ckLMH7si+yU_icw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 20 Dec 2018 16:01:44 +0400
Message-ID: <CAJ+F1CKhFNo9UGuuvcV0ErFoQmHSCxO6jUfo6et3vT9wD4e21A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/64] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

On Wed, Dec 19, 2018 at 11:45 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>
> On Tue, 18 Dec 2018 at 23:04, Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
> >
> > The following changes since commit e85c577158a2e8e252414959da9ef15c12ee=
c63d:
> >
> >   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2=
018-12-17' into staging (2018-12-18 14:31:06 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> >
> > for you to fetch changes up to 4c2b5ca1b5dd42bb96e954db7a46ebe39fd24620=
:
> >
> >   slirp: Mark debugging calls as unlikely (2018-12-18 23:44:35 +0100)
> >
> > ----------------------------------------------------------------
> > Abstract away slirp toward a libslirp
>
> This fails to compile (all platforms):
>
> For the windows builds, a compile failure in slirp.c:
> /home/petmay01/qemu-for-merges/net/slirp.c: In function 'net_slirp_init':
> /home/petmay01/qemu-for-merges/net/slirp.c:302:10: error: implicit
> declaration of function 'inet_pton'
> [-Werror=3Dimplicit-function-declaration]
>      if (!inet_pton(AF_INET6, vprefix6, &ip6_prefix)) {
>           ^
> /home/petmay01/qemu-for-merges/net/slirp.c:302:5: error: nested extern
> declaration of 'inet_pton' [-Werror=3Dnested-externs]
>      if (!inet_pton(AF_INET6, vprefix6, &ip6_prefix)) {
>      ^
>

This one is easy, it needs "build-sys: require Vista API by default
globally" series that Paolo has been sending in his last pullreqs.

> On Linux (x86-64 and other host archs) a link failure:
>
>   LINK    arm-softmmu/qemu-system-arm
> ../slirp/ncsi.o: In function `ncsi_input':
> /home/petmay01/linaro/qemu-for-merges/slirp/ncsi.c:166: undefined
> reference to `slirp_output'
> ../slirp/slirp.o: In function `arp_input':
> /home/petmay01/linaro/qemu-for-merges/slirp/slirp.c:835: undefined
> reference to `slirp_output'
> ../slirp/slirp.o: In function `if_encap4':
> /home/petmay01/linaro/qemu-for-merges/slirp/slirp.c:935: undefined
> reference to `slirp_output'
> ../slirp/slirp.o: In function `if_encap':
> /home/petmay01/linaro/qemu-for-merges/slirp/slirp.c:1021: undefined
> reference to `slirp_output'
> collect2: error: ld returned 1 exit status
> Makefile:199: recipe for target 'qemu-system-arm' failed
>

Hmm, weird linker error. Could you give some details on your build environm=
ent?

> It also manages to provoke an internal linker error on freebsd:
>
> /usr/bin/ld: error in ../slirp/socket.o(.eh_frame); no .eh_frame_hdr
> table will be created.
> /usr/bin/ld: ../slirp/socket.o: invalid string offset 1416 >=3D 978 for
> section `.strtab'
> /usr/bin/ld: ../slirp/socket.o: invalid relocation type 38
> /usr/bin/ld: BFD 2.17.50 [FreeBSD] 2007-07-03 assertion fail
> /usr/src/gnu/usr.bin/binutils/libbfd/../../../../contrib/binutils/bfd/elf=
64-x86-
> 64.c:276
> /usr/bin/ld: ../slirp/socket.o: invalid relocation type 51
> /usr/bin/ld: BFD 2.17.50 [FreeBSD] 2007-07-03 assertion fail
> /usr/src/gnu/usr.bin/binutils/libbfd/../../../../contrib/binutils/bfd/elf=
64-x86-64.c:276
> /usr/bin/ld: ../slirp/socket.o: invalid relocation type 57
> [enormous long list of similar messages]
> /usr/bin/ld: ../slirp/socket.o: invalid relocation type 8248
> /usr/bin/ld: BFD 2.17.50 [FreeBSD] 2007-07-03 assertion fail
> /usr/src/gnu/usr.bin/binutils/libbfd/../../../../contrib/binutils/bfd/elf=
64-x86-
> 64.c:276
> /usr/bin/ld: BFD 2.17.50 [FreeBSD] 2007-07-03 internal error, aborting
> at /usr/src/gnu/usr.bin/binutils/libbfd/../../../../contrib/binutils/b
> fd/reloc.c line 5288 in bfd_byte
> *bfd_generic_get_relocated_section_contents(bfd *, struct
> bfd_link_info *, struct bfd_link_order *, bfd_byte
>  *, bfd_boolean, asymbol **)
>
> /usr/bin/ld: Please report this bug.

make vm-build-freebsd passes here... weirder

>
> c++: error: linker command failed with exit code 1 (use -v to see invocat=
ion)
>
> On NetBSD, a different slirp.c compiler error building the bsd-user
> target:
> In file included from ../slirp/slirp.c:31:0:
> /var/tmp/qemu-test.nLOQbq/include/hw/hw.h:6:2: error: #error Cannot
> include hw/hw.h from user emulation
>  #error Cannot include hw/hw.h from user emulation
>   ^
>

make vm-build-netbsd passes here too...

> On OpenBSD, a rather uninformative linker error:
> /usr/bin/ld: final link failed: Nonrepresentable section on output
> collect2: error: ld returned 1 exit status

make vm-build-openbsd fails here however with the:
"Cannot include hw/hw.h from user emulation" (interesting, no? ;)

Eh, git blame:
062e552 Anthony Liguori        2009-01-08 19:27 +0000   31=E2=94=82 #includ=
e "hw/hw.h"

-#include "hw/hw.h"
+#include "migration/vmstate.h"
+#include "migration/qemu-file-types.h"

Seems to solve it. I will send a seperate patch.

> On OSX, the clang version of the same issue as Linux:
> Undefined symbols for architecture x86_64:
>   "_slirp_output", referenced from:
>       _ncsi_input in ncsi.o
>       _slirp_input in slirp.o
>       _if_encap in slirp.o
> ld: symbol(s) not found for architecture x86_64
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
>

I don't have a mac, but all those linker errors look related.

I don't get why it sometime succeeds to link, but there is an obvious
mistake in "build-sys: use a seperate slirp-obj-y && slirp.mo" (Sam,
you should squash that fix)

diff --git a/Makefile.target b/Makefile.target
index 37e2fc449b..39f72e81be 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -182,13 +182,13 @@ dummy :=3D $(call unnest-vars,.., \
                slirp-obj-y)
 target-obj-y :=3D $(target-obj-y-save)
 all-obj-y +=3D $(common-obj-y)
-all-obj-y +=3D $(slirp-obj-y)
 all-obj-y +=3D $(target-obj-y)
 all-obj-y +=3D $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
 all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
+all-obj-$(CONFIG_SOFTMMU) +=3D $(slirp-obj-y)

--
Marc-Andr=C3=A9 Lureau
