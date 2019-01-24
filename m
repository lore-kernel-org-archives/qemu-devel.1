Received: from eggs.gnu.org ([209.51.188.92]:44343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmeSK-00019M-0W
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:50:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmeSI-00015f-MP
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:50:03 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 24 Jan 2019 13:49:04 +0100
Message-Id: <20190124124906.16653-4-laurent@vivier.eu>
In-Reply-To: <20190124124906.16653-1-laurent@vivier.eu>
References: <20190124124906.16653-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/5] ppc: e6500 registers SPR 604 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Jon Diekema <jon.diekema@ge.com>

From: Jon Diekema <jon.diekema@ge.com>

When using the e6500 CPU, QEMU generates a fatal error after
complaining about registering SPR 604 twice.

Building and testing with commit
9b2e891ec5ccdb4a7d583b77988848282606fdea shows the issue:

qemu-system-ppc64 --version
QEMU emulator version 3.1.50 (v3.1.0-456-g9b2e891ec5-dirty)
Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers

qemu-system-ppc64 -M none -cpu e6500
Error: Trying to register SPR 604 (25c) twice !

Signed-off-by: Jon Diekema <jon.diekema@ge.com>
Message-Id: <CALvuzg43uSodseEHjNaRcPFBKKPTY2mcppUbYgiLL=QO9RxX_Q@mail.gmail.com>
[removed duplicated mail header in the commit message]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/ppc/translate_init.inc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index ade06cc773..59e0b86762 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -4947,14 +4947,6 @@ static void init_proc_e500(CPUPPCState *env, int version)
     }
 
     if (version == fsl_e6500) {
-        spr_register(env, SPR_BOOKE_SPRG8, "SPRG8",
-                     SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, &spr_write_generic,
-                     0x00000000);
-        spr_register(env, SPR_BOOKE_SPRG9, "SPRG9",
-                     SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, &spr_write_generic,
-                     0x00000000);
         /* Thread identification */
         spr_register(env, SPR_TIR, "TIR",
                      SPR_NOACCESS, SPR_NOACCESS,
-- 
2.20.1
