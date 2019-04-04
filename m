Received: from eggs.gnu.org ([209.51.188.92]:57839)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<3ZXylXAYKCt4LEPTONGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--lepton.bounces.google.com>)
	id 1hBtDq-0002s7-1d
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<3ZXylXAYKCt4LEPTONGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--lepton.bounces.google.com>)
	id 1hBtDo-00074F-6U
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:39:26 -0400
Received: from mail-it1-x149.google.com ([2607:f8b0:4864:20::149]:37597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<3ZXylXAYKCt4LEPTONGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--lepton.bounces.google.com>)
	id 1hBtDm-0006so-1o
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:39:22 -0400
Received: by mail-it1-x149.google.com with SMTP id q203so1039452itb.2
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 20:39:19 -0700 (PDT)
Date: Wed,  3 Apr 2019 20:39:11 -0700
Message-Id: <20190404033912.47006-1-lepton@google.com>
Mime-Version: 1.0
From: Tao Wu <lepton@google.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Proof of concept for GPU forwarding for Linux guest on
 Linux host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>

Hi,

This is a proof of concept of GPU forwarding for Linux guest on Linux host.
I'd like to get comments and suggestions from community before I put more
time on it. To summarize what it is:

1. It's a solution to bring GPU acceleration for Linux vm guest on Linux host.
It could works with different GPU although the current proof of concept only
works with Intel GPU.

2. This shows as a kernel patch. The actual qemu diff is nested in 
tools/forward/qemu.diff

3. The basic idea is: under Linux, most applications use GPU acceleration with
help of MESA library. And MESA library interacts with kernel GPU driver by
operating on some special character device file exported by kernel GPU driver.
MESA library opens some special files in system and operations on GPU are done
by ioctl/mmap system call and regular memory operations.

We just write a kernel driver for guest Linux kernel and let it exports same
interface to user space like the real Linux GPU kernel driver. So it's an API proxy
between host and VM guest. We just proxy API at system call level. 

4. Some nasty things was done in guest kernel as a quick dirty hack so we don't need
to touch user space (wayland/mesa etc) now.

5. You can check tools/forward/README for instructions.

Thanks!

Tao Wu (1):
  proof of concept for GPU forwarding

 arch/x86/configs/x86_64_defconfig      |    5 +
 drivers/char/Makefile                  |    1 +
 drivers/char/forwarder/Makefile        |    8 +
 drivers/char/forwarder/forwarder.h     |  103 ++
 drivers/char/forwarder/forwarder_drv.c | 2104 ++++++++++++++++++++++++
 fs/open.c                              |   18 +
 include/uapi/linux/virtwl.h            |   64 +
 tools/forward/Makefile                 |    2 +
 tools/forward/README                   |   58 +
 tools/forward/qemu.diff                | 1117 +++++++++++++
 tools/forward/wayland-proxy-main.c     |   58 +
 tools/forward/wayland-proxy.c          |  297 ++++
 12 files changed, 3835 insertions(+)
 create mode 100644 drivers/char/forwarder/Makefile
 create mode 100644 drivers/char/forwarder/forwarder.h
 create mode 100644 drivers/char/forwarder/forwarder_drv.c
 create mode 100644 include/uapi/linux/virtwl.h
 create mode 100644 tools/forward/Makefile
 create mode 100644 tools/forward/README
 create mode 100644 tools/forward/qemu.diff
 create mode 100644 tools/forward/wayland-proxy-main.c
 create mode 100644 tools/forward/wayland-proxy.c

-- 
2.21.0.392.gf8f6787159e-goog
