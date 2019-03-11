Received: from eggs.gnu.org ([209.51.188.92]:60820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODb-00077K-Ag
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODa-0003FI-C6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODZ-00033z-BV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:02 -0400
Received: by mail-wr1-x430.google.com with SMTP id o7so5914227wrp.12
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:22 +0100
Message-Id: <1552323335-46779-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 18/31] accel: Allow to build QEMU without TCG
 or KVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>

From: Anthony PERARD <anthony.perard@citrix.com>

Instead of deny build of QEMU without a default accelerator, simply
report an error when the user haven't passed -accel or -machine accel=
and TCG and KVM isn't builtin.

./configure already check that at least one accelerator is available.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/accel.c b/accel/accel.c
index 68b6d56..0d5b370 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -91,7 +91,9 @@ void configure_accelerator(MachineState *ms, const char *progname)
 #elif defined(CONFIG_KVM)
             accel = "kvm";
 #else
-#error "No default accelerator available"
+            error_report("No accelerator selected and"
+                         " no default accelerator available");
+            exit(1);
 #endif
         }
     }
-- 
1.8.3.1
