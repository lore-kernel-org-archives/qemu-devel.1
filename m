Received: from eggs.gnu.org ([2001:4830:134:3::10]:43845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqum-0000ex-Nq
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWquj-0003kC-VH
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:36 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:44212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWquj-0003js-QG
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:33 -0500
Received: by mail-qk0-x244.google.com with SMTP id v188so3317864qkh.11
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:49:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:49:21 -0300
Message-Id: <20180103214925.16677-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 0/4] sdbus: testing sdcards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This RFC series intends to add a sdcard test in C using the libqos.

As I intended to explain previous series threads, I want a way to
access slave devices via their bus rather than the bus master (SDHCI
in this case).
This way I can be sure the slave behaves correctly, then I can test
the host master device.

After spending too long different devices, I came back to the original
idea than using QMP is the simplest way to do it.

- patch 1 adds a QMP command to run commands on the bus,
- patch 2 exposes the libqos sdbus API,
- patch 3 intends to implement the previous API for the QMP command
(the API is here since I tried few other devices before, as you can see in [1])
  it is way broken and leaks lot of qobjects, but worked enough to verify the
  previous series (SDCard: improve SPI, introduce new Specs)
- patch 4 is the WIP qtest I started to backport from my previous python qtests

Since v1:
- dropped Python
- prefix QMP command with 'x-debug-' (Kevin Wolf)

Regards,

Phil.

some pain shared here:
[1]: http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg00080.html

Based-on: 20180103212436.15762-26-f4bug@amsat.org

Philippe Mathieu-Daudé (4):
  sdbus: add a QMP command to access a SDBus
  libqos: add a sdbus API
  libqos: implement sdbus QMP driver
  tests: add some sdcard qtest

 qapi-schema.json         |  41 +++++++++++++
 tests/libqos/sdbus.h     |  45 ++++++++++++++
 hw/sd/sdbus-qmp.c        |  65 ++++++++++++++++++++
 stubs/qmp_sdbus.c        |  12 ++++
 tests/libqos/sdbus-qmp.c | 130 ++++++++++++++++++++++++++++++++++++++++
 tests/libqos/sdbus.c     |  74 +++++++++++++++++++++++
 tests/sdbus-test.c       | 151 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/sd/Makefile.objs      |   2 +-
 stubs/Makefile.objs      |   1 +
 tests/Makefile.include   |   3 +
 10 files changed, 523 insertions(+), 1 deletion(-)
 create mode 100644 tests/libqos/sdbus.h
 create mode 100644 hw/sd/sdbus-qmp.c
 create mode 100644 stubs/qmp_sdbus.c
 create mode 100644 tests/libqos/sdbus-qmp.c
 create mode 100644 tests/libqos/sdbus.c
 create mode 100644 tests/sdbus-test.c

-- 
2.15.1
