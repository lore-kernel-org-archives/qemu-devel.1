Received: from eggs.gnu.org ([2001:4830:134:3::10]:45147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQ0Pn-0004Jf-4j
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQ0Ph-0003gP-3Q
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:01:02 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Jun 2017 16:57:39 -0700
Message-ID: <cover.1498607452.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 0/4]  Windows runtime improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org

At Xilinx we have started to run our fork of QEMU on Windows and are
starting to distrubute this to customers. As part of this QEMU is
launched from an Eclipse based GUI on Windows hosts. This uncovered a
few performance issues in QEMU when running on CPU restricted machines.

What we see is that when QEMU is run on a machine where there aren't
enough spare CPUs on the host, QEMU is extreamly slow. We especially see
this when running our multi-architecture QEMU setup (MicroBlaze and ARM)
because we are running two QEMU instances as well as what else is
running on the machine.

Generally two instances of QEMU will never reach a Linux login prompt
when run on four host CPUs, but will reach the login prompt when run on
eight CPUs.

We investigated the issue and realised that it is mostly because QEMU
did not block and instead the IO thread just busy looped. This basically
locked up two CPUs (two QEMU instances) with IO threads not leaving
enough resources on the machine.

This patch series fixed the issue for us on our fork of QEMU. Our fork
is based on QEMU 2.8.1 and does not include MTTCG support. I have not
tested this on the mainline QEMU or with MTTCG. It is on my todo list to
see if I can repdouce the same issue on Windows with mainline QEMU. In
the meantime I wanted to send this series to see if anyone else has seen
Windows performance issues and if this helps with the problems. In order
to see the issue we had to do a full Linux boot, smaller baremetal
applications generally don't reproduce the same issue.

Also, most of these patches are editing the QEMU implementation of Glib,
obviously these fixes (if applicable) will need to be ported to Glib and
applied there as well. I just wanted to start here.

Alistair Francis (4):
  util/aio-win32: Only select on what we are actually waiting for
  util/oslib-win32: Remove invalid check
  util/oslib-win32: Fix up if conditional
  util/oslib-win32: Recursivly pass the timeout

 util/aio-win32.c   | 13 ++++++++++---
 util/oslib-win32.c | 25 +++++++++++++++++++------
 2 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.11.0
