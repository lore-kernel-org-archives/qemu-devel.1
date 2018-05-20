Received: from eggs.gnu.org ([2001:4830:134:3::10]:47620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKIEY-0007pI-KG
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKIEV-0002Jx-HY
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:54:22 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:58 +0300
Message-Id: <7647d5c6b5e3b3f36a6e0441c81ae3fe797eb233.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/22] tests: fix tpm-crb tpm-tis tests race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

No need to close the TPM data socket on the emulator end, qemu will
close it after a SHUTDOWN. This avoids a race between close() and
read() in the TPM data thread.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/tpm-emu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
index 4dada76834..8c2bd53cad 100644
--- a/tests/tpm-emu.c
+++ b/tests/tpm-emu.c
@@ -125,7 +125,7 @@ void *tpm_emu_ctrl_thread(void *data)
         case CMD_SHUTDOWN: {
             ptm_res res =3D 0;
             qio_channel_write(ioc, (char *)&res, sizeof(res), &error_abo=
rt);
-            qio_channel_close(s->tpm_ioc, &error_abort);
+            /* the tpm data thread is expected to finish now */
             g_thread_join(s->emu_tpm_thread);
             break;
         }
--=20
2.11.0
