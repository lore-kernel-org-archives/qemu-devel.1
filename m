Received: from eggs.gnu.org ([2001:4830:134:3::10]:40651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduLh-0001re-H6
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduLg-000085-Gv
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:54:33 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57252)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduLg-00007r-8l
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:54:32 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 23 Jan 2018 11:54:32 +0300
Message-ID: <20180123085432.3419.84711.stgit@pasha-VirtualBox>
In-Reply-To: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
References: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v5 13/24] kvm: remove BQL lock/unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

BQL now is used only for waiting for IO events.
This patch also removes lock/unlock from kvm module.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 accel/kvm/kvm-all.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9628512..d708c7f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1861,7 +1861,6 @@ int kvm_cpu_exec(CPUState *cpu)
         return EXCP_HLT;
     }
 
-    qemu_mutex_unlock_iothread();
     cpu_exec_start(cpu);
     do {
         MemTxAttrs attrs;
@@ -1992,7 +1991,6 @@ int kvm_cpu_exec(CPUState *cpu)
     } while (ret == 0);
 
     cpu_exec_end(cpu);
-    qemu_mutex_lock_iothread();
 
     if (ret < 0) {
         cpu_dump_state(cpu, stderr, fprintf, CPU_DUMP_CODE);
