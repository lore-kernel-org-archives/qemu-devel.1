Received: from eggs.gnu.org ([2001:4830:134:3::10]:56069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPNa-0001w4-AY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPNV-0000Oq-Pn
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:26:10 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:39966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebPNV-0000OW-Hs
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:26:05 -0500
Received: by mail-ot0-x22d.google.com with SMTP id d10so13285945oti.7
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:26:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 11:25:44 +0000
Message-ID: <CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/53] Misc changes for 2017-01-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 January 2018 at 23:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9=
ff:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80111' into staging (2018-01-11 14:34:41 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to ff9adba50bf8a4c080b8aee9be2314ef179a7b5f:
>
>   ucontext: annotate coroutine stack for ASAN (2018-01-12 15:21:14 +0100)
>
> ----------------------------------------------------------------
> * QemuMutex tracing improvements (Alex)
> * ram_addr_t optimization (David)
> * SCSI fixes (Fam, Stefan, me)
> * do {} while (0) fixes (Eric)
> * KVM fix for PMU (Jan)
> * memory leak fixes from ASAN (Marc-Andr=C3=A9)
> * migration fix for HPET, icount, loadvm (Maria, Pavel)
> * hflags fixes (me, Tao)
> * block/iscsi uninitialized variable (Peter L.)
> * full support for GMainContexts in character devices (Peter Xu)
> * more boot-serial-test (Thomas)
> * Memory leak fix (Zhecheng)

Various build failures, I'm afraid:

x86-64/Linux/gcc:

configure produces an error message:

ERROR: ASAN build enabled, but ASAN header is too old.
       Without code annotation, the report may be inferior.

even though this configure did not explicitly request ASAN.
Then configure seems to exit successfully anyway, since the
build proceeds.

For some reason the build creates config-target.h a lot:

make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/alldbg=
'
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
  GEN     config-target.h
[snip more lines]
  GEN     config-target.h
  GEN     config-target.h
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
  GIT     ui/keycodemapdb dtc capstone
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/all'
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
  GEN     qapi-event.h
[etc]

Then it runs configure again, this time without the ERROR message,
and eventually fails with:

  CC      hw/display/exynos4210_fimd.o
/home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c: In
function =E2=80=98fimd_get_buffer_id=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c:1105:5:
error: case label does not reduce to an integer constant
     case FIMD_WINCON_BUF2_STAT:
     ^

On sparc64 host configure fails:

config-host.mak is out-of-date, running configure

ERROR: configure test passed without -Werror but failed with -Werror.
       This is probably a bug in the configure script. The failing command
       will be at the bottom of config.log.
       You can run configure with --disable-werror to bypass this check.

The bottom of config.log is:

cc -DHAS_LIBSSH2_SFTP_FSYNC -pthread -I/usr/include/glib-2.0
-I/usr/lib/sparc64-linux-gnu/glib-2.0/include -DNCURSES_WIDECHAR
-D_GNU_SOURCE -D_DEFAULT_SOURCE -I/usr/include/ncursesw -m64
-mcpu=3Dultrasparc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
-D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall
-Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing
-fno-common -fwrapv -Wexpansion-to-defined -Wendif-labels
-Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
-Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers -Wold-style-declaration -Wold-style-definition
-Wtype-limits -fstack-protector-strong -I/usr/include/p11-kit-1
-I/usr/include/libpng16 -I$(SRC_PATH)/capstone/include
-fsanitize=3Daddress -o config-temp/qemu-conf.exe
config-temp/qemu-conf.c -m64 -g
cc1: warning: -fsanitize=3Daddress not supported for this target
cc -Werror -DHAS_LIBSSH2_SFTP_FSYNC -pthread -I/usr/include/glib-2.0
-I/usr/lib/sparc64-linux-gnu/glib-2.0/include -DNCURSES_WIDECHAR
-D_GNU_SOURCE -D_DEFAULT_SOURCE -I/usr/include/ncursesw -m64
-mcpu=3Dultrasparc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
-D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall
-Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing
-fno-common -fwrapv -Wexpansion-to-defined -Wendif-labels
-Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
-Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers -Wold-style-declaration -Wold-style-definition
-Wtype-limits -fstack-protector-strong -I/usr/include/p11-kit-1
-I/usr/include/libpng16 -I$(SRC_PATH)/capstone/include
-fsanitize=3Daddress -o config-temp/qemu-conf.exe
config-temp/qemu-conf.c -m64 -g
cc1: error: -fsanitize=3Daddress not supported for this target [-Werror]


thanks
-- PMM
