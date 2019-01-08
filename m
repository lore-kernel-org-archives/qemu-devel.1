Received: from eggs.gnu.org ([209.51.188.92]:37814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthd-0003rr-Ih
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggthc-0006ae-Ev
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggthc-0006XM-88
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:04 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  8 Jan 2019 16:53:50 +0100
Message-Id: <20190108155354.8591-2-kraxel@redhat.com>
In-Reply-To: <20190108155354.8591-1-kraxel@redhat.com>
References: <20190108155354.8591-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] hw/usb: fix mistaken de-initialization of
 CCID state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

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

Fixes: 7dea29e4af1
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181221134115.27973-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
