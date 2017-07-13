Received: from eggs.gnu.org ([2001:4830:134:3::10]:51549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3p-0001N7-PL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3o-00032A-NZ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:45 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3o-0002zq-GN
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:44 -0400
Received: by mail-wr0-x241.google.com with SMTP id 77so9410398wrb.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:34 +0200
Message-Id: <1499955874-10954-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 41/41] translate-all: remove redundant
 !tcg_enabled check in dump_exec_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This check is redundant because it is already performed by the only
caller of dump_exec_info -- the caller was updated by b7da97eef
("monitor: Check whether TCG is enabled before running the "info jit"
code").

Checking twice wouldn't necessarily be too bad, but here the check also
returns with tb_lock held. So we can either do the check before tb_lock is
acquired, or just get rid of it. Given that it is redundant, I am going
for the latter option.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/translate-all.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 0caf80d..4e1831c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1851,11 +1851,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
 
     tb_lock();
 
-    if (!tcg_enabled()) {
-        cpu_fprintf(f, "TCG not enabled\n");
-        return;
-    }
-
     target_code_size = 0;
     max_target_code_size = 0;
     cross_page = 0;
-- 
1.8.3.1
