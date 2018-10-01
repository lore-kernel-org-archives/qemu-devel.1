Received: from eggs.gnu.org ([2001:4830:134:3::10]:56749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g71oZ-0000sa-DE
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g71oY-0004ql-Hs
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:16:59 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:38591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g71oY-0004l3-4l
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:16:58 -0400
Received: by mail-ot1-x334.google.com with SMTP id h15-v6so13887814otj.5
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 10:16:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001152917.24789-1-pbonzini@redhat.com>
References: <20181001152917.24789-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Oct 2018 18:16:36 +0100
Message-ID: <CAFEAcA9mhSgQbkDg0AohZuUF4pc7xUvXq-BHY3Cbn-nas2eKxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/79] Misc patches for 2018-09-30
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

On 1 October 2018 at 16:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 042938f46e1c477419d1931381fdadffaa49d4=
5e:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0926a' into staging (2018-09-28 17:07:23 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 72d09800e7b85fa1a14b88d341ca8c042d236cba:
>
>   hw/scsi/mptendian: Avoid taking address of fields in packed structs (20=
18-10-01 17:28:02 +0200)
>
> ----------------------------------------------------------------
> * configure fix for environment variables (Daniel)
> * fix memory leaks (Alex)
> * x86_64 MTTCG fixes (Emilio)
> * introduce atomic64 (Emilio)
> * Fix for virtio hang (Fam, myself)
> * SH serial port fix (Geert)
> * Deprecate rotation_rate for scsi-block (Fam)
> * Extend memory-backend-file availability to all POSIX hosts (Hikaru)
> * Memory API cleanups and fixes (Igor, Li Qiang, Peter, Philippe)
> * MSI/IOMMU fix (Jan)
> * Socket reconnection fixes (Marc-Andr=C3=A9)
> * icount fixes (Emilio, myself)
> * QSP fixes for Coverity (myself)
> * Some record/replay improovements (Pavel)
> * Packed struct fixes (Peter)
> * Windows dump fixes and elf2dmp (Viktor)
> * kvmclock fix (Yongji)
>
> ----------------------------------------------------------------

Hi; compile failures due to format string issues, I'm afraid:

/home/petmay01/qemu-for-merges/hw/mips/mips_r4k.c: In function 'load_kernel=
':
/home/petmay01/qemu-for-merges/hw/mips/mips_r4k.c:139:47: error:
format '%li' expects argument of type 'long int', but argument 5 has
type 'int64_t {aka long long int}' [-Werror=3Dformat=3D]
         snprintf((char *)params_buf + 8, 256, "rd_start=3D0x%" PRIx64 "
rd_size=3D%li %s",
                                               ^
cc1: all warnings being treated as errors

/home/petmay01/qemu-for-merges/hw/mips/mips_malta.c: In function 'load_kern=
el':
/home/petmay01/qemu-for-merges/hw/mips/mips_malta.c:1073:42: error:
format '%li' expects argument of type 'long int', but argument 5 has
type 'int64_t {aka long long int}' [-Werror=3Dformat=3D]
         prom_set(prom_buf, prom_index++, "rd_start=3D0x%" PRIx64 "
rd_size=3D%li %s",
                                          ^

I also saw this in the freebsd VM test:

MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
gtester -k --verbose -m=3Dquick tests/test-char
TEST: tests/test-char... (pid=3D15938)
  /char/null:                                                          OK
  /char/invalid:                                                       OK
  /char/ringbuf:                                                       OK
  /char/mux:                                                           OK
  /char/stdio:                                                         OK
  /char/pipe:                                                          OK
  /char/file:                                                          OK
  /char/file-fifo:                                                     OK
  /char/udp:                                                           OK
  /char/serial:                                                        OK
  /char/hotswap:                                                       OK
  /char/socket/basic:                                                  OK
  /char/socket/reconnect:                                              FAIL
GTester: last random seed: R02S615917be6302ea7de5d0fc9c58149953
(pid=3D16010)
  /char/socket/fdpass:                                                 OK
FAIL: tests/test-char
**
ERROR:tests/test-char.c:353:char_socket_test_common: assertion failed:
(object_property_get_bool(OBJECT(chr_client), "connected",
&error_abort))
gmake: *** [/var/tmp/qemu-test.YRve5C/tests/Makefile.include:925:
check-tests/test-char] Error 1


Haven't seen that before, so maybe it's something in this patchset;
it could be a pre-existing intermittent though I suppose.

thanks
-- PMM
