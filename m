Received: from eggs.gnu.org ([2001:4830:134:3::10]:40868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIU-0001cC-67
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIS-0002jm-Do
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:10 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:10 -0500
Message-Id: <20180723201748.25573-2-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/99] tests: fix tpm-crb tpm-tis tests race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

No need to close the TPM data socket on the emulator end, qemu will
close it after a SHUTDOWN. This avoids a race between close() and
read() in the TPM data thread.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 7647d5c6b5e3b3f36a6e0441c81ae3fe797eb233)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/tpm-emu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
index 4dada76834..8c2bd53cad 100644
--- a/tests/tpm-emu.c
+++ b/tests/tpm-emu.c
@@ -125,7 +125,7 @@ void *tpm_emu_ctrl_thread(void *data)
         case CMD_SHUTDOWN: {
             ptm_res res = 0;
             qio_channel_write(ioc, (char *)&res, sizeof(res), &error_abort);
-            qio_channel_close(s->tpm_ioc, &error_abort);
+            /* the tpm data thread is expected to finish now */
             g_thread_join(s->emu_tpm_thread);
             break;
         }
-- 
2.17.1
