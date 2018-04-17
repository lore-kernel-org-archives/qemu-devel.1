Received: from eggs.gnu.org ([2001:4830:134:3::10]:53384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8Si8-0001Jv-G7
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8Si7-0005JZ-M5
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:00 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Apr 2018 17:39:39 +0200
Message-Id: <20180417153945.20737-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] atapi: change unlimited recursion to while
 loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org

Real hardware doesn't have an unlimited stack, so the unlimited
recursion in the ATAPI code smells a bit.  In fact, the call to
ide_transfer_start easily becomes a tail call with a small change
to the code (patch 5); however, we also need to turn the call back to
ide_atapi_cmd_reply_end into another tail call before turning the
(double) tail recursion into a while loop.

In particular, patch 1 ensures that the call to the end_transfer_func is
the last thing in ide_transfer_start.  To do so, it moves the write of
the PIO Setup FIS before the PIO transfer, which actually makes sense:
the FIS is sent by the device to inform the AHCI about the transfer,
so it cannot come after!  This is the main change from the RFC, and
it simplifies the rest of the series (the RFC had to introduce an
"end_transfer" callback just for writing the PIO Setup FIS).

I tested this manually with READ CD commands sent through sg_raw,
and the existing AHCI tests still pass.

Paolo Bonzini (6):
  ahci: move PIO Setup FIS before transfer, fix it for ATAPI commands
  ide: push end_transfer_func out of start_transfer callback, rename
    callback
  ide: call ide_cmd_done from ide_transfer_stop
  ide: make ide_transfer_stop idempotent
  atapi: call ide_set_irq before ide_transfer_start
  ide: introduce ide_transfer_start_norecurse

 hw/ide/ahci.c             | 30 ++++++++++++--------------
 hw/ide/atapi.c            | 44 +++++++++++++++++++++------------------
 hw/ide/core.c             | 39 +++++++++++++++++-----------------
 hw/ide/trace-events       |  2 +-
 include/hw/ide/internal.h |  4 +++-
 tests/libqos/ahci.c       | 30 ++++++++++++++++++++++----
 tests/libqos/ahci.h       |  2 ++
 7 files changed, 89 insertions(+), 62 deletions(-)

--=20
2.17.0
