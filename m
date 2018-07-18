Received: from eggs.gnu.org ([2001:4830:134:3::10]:39490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffnsi-0005q8-7D
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffnsf-0003YS-6I
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:56:44 -0400
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:40548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffnsf-0003Y8-0u
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 10:56:41 -0400
Received: by mail-vk0-x234.google.com with SMTP id s23-v6so2647844vks.7
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 07:56:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09124b32-2571-2b6f-f10f-4c542683b1e7@amsat.org>
Date: Wed, 18 Jul 2018 11:56:35 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] spice/qlx: atomic-alignment error with clang-7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>

Using clang-7 (Debian) on x86_64 to build v3.0.0-rc1.

Not a regression, it was probably always there:

$ ./configure --cc=clang-7 && make hw/display/qxl.o
hw/display/qxl.c:1884:19: error: misaligned or large atomic operation
may incur significant performance penalty [-Werror,-Watomic-alignment]
    old_pending = atomic_fetch_or(&d->ram->int_pending, le_events);
                  ^
include/qemu/atomic.h:206:34: note: expanded from macro 'atomic_fetch_or'
#define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST)
                                 ^
1 error generated.

static void qxl_send_events(PCIQXLDevice *d, uint32_t events)
{
    uint32_t old_pending;
    uint32_t le_events = cpu_to_le32(events);
    ...
    old_pending = atomic_fetch_or(&d->ram->int_pending, le_events);
    if ((old_pending & le_events) == le_events) {
        return;
    }
    ...
}

Having:

typedef struct PCIQXLDevice {
    QXLRam *ram;
    ...
} PCIQXLDevice;

And from <spice/qxl_dev.h>:

typedef struct SPICE_ATTR_PACKED QXLRam {
    uint32_t magic;
    uint32_t int_pending;
    uint32_t int_mask;
    uint8_t log_buf[QXL_LOG_BUF_SIZE];
    ...
} QXLRam;

Any idea how this could get fixed?

Thanks

Phil.
