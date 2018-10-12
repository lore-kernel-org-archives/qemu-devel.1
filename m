Received: from eggs.gnu.org ([2001:4830:134:3::10]:42340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAzda-0002LH-SP
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAzdZ-0002dx-Ja
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:46:02 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:35995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAzdZ-0002aP-6W
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:46:01 -0400
Received: by mail-oi1-x232.google.com with SMTP id p125-v6so10204996oic.3
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 08:45:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181012123851.30856-1-kraxel@redhat.com>
References: <20181012123851.30856-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 16:45:37 +0100
Message-ID: <CAFEAcA_fibacs0NzpMX-wtcTw2GnqNuGE1kBLeXznBq7nks4hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Vga 20181012 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 12 October 2018 at 13:38, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a5b:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10' into staging (2018-10-11 10:43:37 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20181012-pull-request
>
> for you to fetch changes up to b398f03c60bb5739ae68c161c315c7cce8ef2fde:
>
>   hw/display/cirrus_vga: Move "isa-cirrus-vga" device into a separate file (2018-10-12 13:50:38 +0200)
>
> ----------------------------------------------------------------
> vga: config tweaks, edid updates, qxl bugfix.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (4):
>   display: add separate config option for bochs-display
>   bochs-display: wire up edid support
>   qxl: check qxl_phys2virt return value
>   i2c: switch ddc to use the new edid generator
>
> Thomas Huth (1):
>   hw/display/cirrus_vga: Move "isa-cirrus-vga" device into a separate
>     file

Hi. This generates new clang runtime sanitizer errors:

QTEST_QEMU_BINARY=sh4-softmmu/qemu-system-sh4 QTEST_QEMU_IMG=qemu-img
MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
gtester -k --verbose -m=quick tests/endianness-test tests/qmp-test
tests/qmp-cmd-test tests/device-introspect-test tests/cdrom-test
tests/machine-none-test tests/qom-test tests/test-hmp
TEST: tests/endianness-test... (pid=19412)
  /sh4/endianness/r2d:
/home/petmay01/linaro/qemu-for-merges/hw/display/edid-generate.c:226:5:
runtime error: store to misaligned address 0x55bc89d7cffe for type
'uint32_t' (aka 'unsigned int'), which requires 4 byte alignment
0x55bc89d7cffe: note: pointer points here
 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00
             ^

which are caused by this line in edid_desc_timing():

    *(uint32_t *)(desc) = cpu_to_le32(clock / 10000);

Casting to some pointer type like this is almost never right;
you want instead to just use one of our existing utility
functions for "store to arbitrary memory with correct
endianness and handling alignment". In this case that's
    stl_le_p(desc, clock / 10000);

This also failed to pass 'make check' on SPARC with lots of
bus errors, which are almost certainly the same misaligned
access problem.

There seem to be other instances of the problem in the
same file, eg
    *(uint16_t *)(edid +  8) = cpu_to_be16(vendor_id);
    *(uint16_t *)(edid + 10) = cpu_to_le16(model_nr);
    *(uint32_t *)(edid + 12) = cpu_to_le32(serial_nr);


Could you fix all these and resubmit, please?

thanks
-- PMM
