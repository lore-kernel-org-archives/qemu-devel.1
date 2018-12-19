Received: from eggs.gnu.org ([2001:4830:134:3::10]:52661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZhke-0004vR-8O
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZhkc-0003EA-VE
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:43:28 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZhkc-0003DS-Nv
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:43:26 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so2597643oia.4
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 11:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 19:43:14 +0000
Message-ID: <CAFEAcA89ZxboWWDn3iDh_8u-ejMKjhWmmA_ckLMH7si+yU_icw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/64] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Tue, 18 Dec 2018 at 23:04, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit e85c577158a2e8e252414959da9ef15c12eec63d:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-12-17' into staging (2018-12-18 14:31:06 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 4c2b5ca1b5dd42bb96e954db7a46ebe39fd24620:
>
>   slirp: Mark debugging calls as unlikely (2018-12-18 23:44:35 +0100)
>
> ----------------------------------------------------------------
> Abstract away slirp toward a libslirp

This fails to compile (all platforms):

For the windows builds, a compile failure in slirp.c:
/home/petmay01/qemu-for-merges/net/slirp.c: In function 'net_slirp_init':
/home/petmay01/qemu-for-merges/net/slirp.c:302:10: error: implicit
declaration of function 'inet_pton'
[-Werror=implicit-function-declaration]
     if (!inet_pton(AF_INET6, vprefix6, &ip6_prefix)) {
          ^
/home/petmay01/qemu-for-merges/net/slirp.c:302:5: error: nested extern
declaration of 'inet_pton' [-Werror=nested-externs]
     if (!inet_pton(AF_INET6, vprefix6, &ip6_prefix)) {
     ^

On Linux (x86-64 and other host archs) a link failure:

  LINK    arm-softmmu/qemu-system-arm
../slirp/ncsi.o: In function `ncsi_input':
/home/petmay01/linaro/qemu-for-merges/slirp/ncsi.c:166: undefined
reference to `slirp_output'
../slirp/slirp.o: In function `arp_input':
/home/petmay01/linaro/qemu-for-merges/slirp/slirp.c:835: undefined
reference to `slirp_output'
../slirp/slirp.o: In function `if_encap4':
/home/petmay01/linaro/qemu-for-merges/slirp/slirp.c:935: undefined
reference to `slirp_output'
../slirp/slirp.o: In function `if_encap':
/home/petmay01/linaro/qemu-for-merges/slirp/slirp.c:1021: undefined
reference to `slirp_output'
collect2: error: ld returned 1 exit status
Makefile:199: recipe for target 'qemu-system-arm' failed

It also manages to provoke an internal linker error on freebsd:

/usr/bin/ld: error in ../slirp/socket.o(.eh_frame); no .eh_frame_hdr
table will be created.
/usr/bin/ld: ../slirp/socket.o: invalid string offset 1416 >= 978 for
section `.strtab'
/usr/bin/ld: ../slirp/socket.o: invalid relocation type 38
/usr/bin/ld: BFD 2.17.50 [FreeBSD] 2007-07-03 assertion fail
/usr/src/gnu/usr.bin/binutils/libbfd/../../../../contrib/binutils/bfd/elf64-x86-
64.c:276
/usr/bin/ld: ../slirp/socket.o: invalid relocation type 51
/usr/bin/ld: BFD 2.17.50 [FreeBSD] 2007-07-03 assertion fail
/usr/src/gnu/usr.bin/binutils/libbfd/../../../../contrib/binutils/bfd/elf64-x86-64.c:276
/usr/bin/ld: ../slirp/socket.o: invalid relocation type 57
[enormous long list of similar messages]
/usr/bin/ld: ../slirp/socket.o: invalid relocation type 8248
/usr/bin/ld: BFD 2.17.50 [FreeBSD] 2007-07-03 assertion fail
/usr/src/gnu/usr.bin/binutils/libbfd/../../../../contrib/binutils/bfd/elf64-x86-
64.c:276
/usr/bin/ld: BFD 2.17.50 [FreeBSD] 2007-07-03 internal error, aborting
at /usr/src/gnu/usr.bin/binutils/libbfd/../../../../contrib/binutils/b
fd/reloc.c line 5288 in bfd_byte
*bfd_generic_get_relocated_section_contents(bfd *, struct
bfd_link_info *, struct bfd_link_order *, bfd_byte
 *, bfd_boolean, asymbol **)

/usr/bin/ld: Please report this bug.

c++: error: linker command failed with exit code 1 (use -v to see invocation)

On NetBSD, a different slirp.c compiler error building the bsd-user
target:
In file included from ../slirp/slirp.c:31:0:
/var/tmp/qemu-test.nLOQbq/include/hw/hw.h:6:2: error: #error Cannot
include hw/hw.h from user emulation
 #error Cannot include hw/hw.h from user emulation
  ^

On OpenBSD, a rather uninformative linker error:
/usr/bin/ld: final link failed: Nonrepresentable section on output
collect2: error: ld returned 1 exit status

On OSX, the clang version of the same issue as Linux:
Undefined symbols for architecture x86_64:
  "_slirp_output", referenced from:
      _ncsi_input in ncsi.o
      _slirp_input in slirp.o
      _if_encap in slirp.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)

thanks
-- PMM
