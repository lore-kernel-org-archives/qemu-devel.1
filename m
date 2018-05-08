Received: from eggs.gnu.org ([2001:4830:134:3::10]:36281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fG4Yy-0003jr-Nl
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fG4Yv-0002U6-In
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:30:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fG4Yv-0002TV-BT
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:29:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w48FTpbp004489
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 11:29:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hucw0nsfs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 11:29:56 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 8 May 2018 11:29:54 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue,  8 May 2018 11:29:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1525793375-15367-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests: fix tpm-crb tpm-tis tests race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, berrange@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

No need to close the TPM data socket on the emulator end, qemu will
close it after a SHUTDOWN. This avoids a race between close() and
read() in the TPM data thread.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tests/tpm-emu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
index 4dada76..8c2bd53 100644
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
2.5.5
