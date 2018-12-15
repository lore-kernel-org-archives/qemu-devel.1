Received: from eggs.gnu.org ([2001:4830:134:3::10]:59352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYHKb-0007St-7Z
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 16:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYHKa-0006d0-6D
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 16:18:41 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:45716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYHKZ-0006cL-P9
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 16:18:40 -0500
Received: by mail-oi1-x22b.google.com with SMTP id y1so7327028oie.12
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 13:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20181214031923.29527-1-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 15 Dec 2018 21:18:26 +0000
Message-ID: <CAFEAcA-7irqz__ZywybEORVtZiZgRGESFJaxdZShrKruuOACGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/32] tcg patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 14 Dec 2018 at 03:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 2d894e48362ad2a576fca929dcca1787f43a8af6:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2018-12-13 17:50:45 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20181213
>
> for you to fetch changes up to 99f70ba5b6b4566509b2069a8d29c6686b8115de:
>
>   xxhash: match output against the original xxhash32 (2018-12-13 18:56:11 -0600)
>
> ----------------------------------------------------------------
> - Remove retranslation remenents
> - Return success from patch_reloc
> - Preserve 32-bit values as zero-extended on x86_64
> - Make bswap during memory ops as optional
> - Cleanup xxhash

This didn't pass 'make check' on sparc64 host.
It looks like the handful of tests that exercise TCG
in the process of doing what they do failed, and there
was a tcg assert in there too:
ERROR:/home/pm215/qemu/tests/bios-tables-test.c:607:test_smbios_structs:
assertion failed: (test_bit(data->required_struct_types[i],
struct_bitmap))
ERROR:/home/pm215/qemu/tests/bios-tables-test.c:607:test_smbios_structs:
assertion failed: (test_bit(data->required_struct_types[i],
struct_bitmap))
  /x86_64/pxe/ipv4/pc/e1000:
qemu-system-x86_64: /home/pm215/qemu/tcg/sparc/tcg-target.inc.c:319:
patch_reloc: Assertion `check_fit_ptr(value, 13)' failed.
ERROR:/home/pm215/qemu/tests/boot-sector.c:161:boot_sector_test:
assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
ERROR:/home/pm215/qemu/tests/boot-sector.c:161:boot_sector_test:
assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
ERROR:/home/pm215/qemu/tests/boot-sector.c:161:boot_sector_test:
assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
ERROR:/home/pm215/qemu/tests/boot-sector.c:161:boot_sector_test:
assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
ERROR:/home/pm215/qemu/tests/vmgenid-test.c:104:read_guid_from_memory:
assertion failed: (vmgenid_addr)
ERROR:/home/pm215/qemu/tests/vmgenid-test.c:104:read_guid_from_memory:
assertion failed: (vmgenid_addr)

So I suspect there's a sparc TCG issue here.

On s390 I also saw
ERROR:/home/linux1/qemu/tests/migration-test.c:355:migrate_set_parameter:
assertion failed: (qdict_haskey(rsp, "return"))

but that may be an unrelated intermittent.

thanks
-- PMM
