Received: from eggs.gnu.org ([2001:4830:134:3::10]:33127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaL3U-0002ED-Im
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gaL3R-0000Qr-6z
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:41:32 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 21 Dec 2018 13:41:15 +0000
Message-Id: <20181221134115.27973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/usb: fix mistaken de-initialization of CCID
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

In previous commit:

  commit 7dea29e4af17fc1d27478de9f8ea38144deac54a
  Author: Li Qiang <liq3ea@gmail.com>
  Date:   Fri Oct 19 03:50:36 2018 -0700

    hw: ccid-card-emulated: cleanup resource when realize in error path

The emulated_realize method was changed so that it jumps to a cleanup
label to de-initialize state upon error. This change failed to ensure
the success path exited the method before this point though. So the
mutexes are always destroyed even in normal operation. The result is
as crashtastic as expected:

$ qemu-system-x86_64 -usb -device usb-ccid,id=3Dccid0 -device ccid-card-e=
mulated,backend=3Dnss-emulated,id=3Dsmartcard0,bus=3Dccid0.0
qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock_impl: As=
sertion `mutex->initialized' failed.
Aborted (core dumped)

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/ccid-card-emulated.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 25976ed84f..e0457d305b 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -549,6 +549,8 @@ static void emulated_realize(CCIDCardState *base, Err=
or **errp)
     qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_t=
hread,
                        card, QEMU_THREAD_JOINABLE);
=20
+    return;
+
 out2:
     clean_event_notifier(card);
 out1:
--=20
2.19.2
