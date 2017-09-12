Received: from eggs.gnu.org ([2001:4830:134:3::10]:55881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drtCO-00020A-IZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drtCL-0005pl-Rv
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:58:28 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:42590)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drtCL-0005pB-Gf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:58:25 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 00:58:14 +0300
Message-Id: <150525349438.15988.10881535098471062952.stgit@frigg.lan>
In-Reply-To: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 14/22] exec: Add function to synchronously
 flush TB on a stopped vCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 accel/stubs/tcg-stub.c    |    3 +++
 accel/tcg/translate-all.c |    7 +++++++
 include/exec/exec-all.h   |    1 +
 3 files changed, 11 insertions(+)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 5dd480b1a2..5226c4a8a4 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -20,3 +20,6 @@
 void tb_flush(CPUState *cpu)
 {
 }
+void tb_flush_sync(CPUState *cpu)
+{
+}
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2d1ed06065..a334ac4ccb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -929,6 +929,13 @@ done:
     tb_unlock();
 }
=20
+void tb_flush_sync(CPUState *cpu)
+{
+    unsigned tb_flush_count =3D atomic_mb_read(&tcg_ctx.tb_ctx.tb_flush_=
count);
+    assert(cpu =3D=3D current_cpu);
+    do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
+}
+
 void tb_flush(CPUState *cpu)
 {
     if (tcg_enabled()) {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 673fc066d0..3f38186a5e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -358,6 +358,7 @@ struct TranslationBlock {
=20
 void tb_free(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
+void tb_flush_sync(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
                                    target_ulong cs_base, uint32_t flags)=
;
