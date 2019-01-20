Received: from eggs.gnu.org ([209.51.188.92]:58730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1glECI-0002pg-78
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1glECG-0002Tm-9u
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:35:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1glECC-0002On-2T
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:35:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sun, 20 Jan 2019 14:34:48 +0000
Message-Id: <20190120143452.21683-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] arm: microbit Non-Volatile Memory
 Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim@groklearning.com, jusual@mail.ru, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

This series adds the Non-Volatile Memory Controller, which controls acces=
s to
the User Information Control Registers (UICR), Factory Information Contro=
l
Registers (FICR), and flash memory.

This is the last piece of microbit work needed to make basic programs lik=
e
Micropython "Hello world" work under QEMU.

Originally sent as part of Steffen's longer microbit device emulation ser=
ies, I
extracted this and deferred it until later because cleanups were necessar=
y:

 * Use memory_region_flush_rom_device() to dirty/invalidate memory [Peter=
]
   ^--- Paolo: I CCed you on this new memory API
 * Fix device-introspect-test segfault due to missing owner when initiali=
zing
   FICR and UICR memory regions [Peter]
 * Fix off-by-one assertion checks [Peter]
 * Fix missing whitespace at end of comment [Peter]
 * Clear UICR on reset - we'd need a block device for true non-volatility
   [Peter]

Stefan Hajnoczi (1):
  memory: add memory_region_flush_rom_device()

Steffen G=C3=B6rtz (3):
  hw/nvram/nrf51_nvm: Add nRF51 non-volatile memories
  arm: Instantiate NRF51 special NVM's and NVMC
  tests/microbit-test: Add tests for nRF51 NVMC

 hw/nvram/Makefile.objs       |   1 +
 include/exec/memory.h        |  18 ++
 include/hw/arm/nrf51_soc.h   |   2 +
 include/hw/nvram/nrf51_nvm.h |  64 ++++++
 exec.c                       |  12 ++
 hw/arm/nrf51_soc.c           |  41 ++--
 hw/nvram/nrf51_nvm.c         | 381 +++++++++++++++++++++++++++++++++++
 tests/microbit-test.c        |  97 +++++++++
 8 files changed, 604 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/nvram/nrf51_nvm.h
 create mode 100644 hw/nvram/nrf51_nvm.c

--=20
2.20.1
