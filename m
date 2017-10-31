Received: from eggs.gnu.org ([2001:4830:134:3::10]:51037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugv-00040w-AB
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugu-0000YX-Ck
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:45 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45346)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugu-0000Xx-4d
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:44 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:26:44 +0300
Message-ID: <20171031112644.10516.1734.stgit@pasha-VirtualBox>
In-Reply-To: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 19/26] cpu-exec: reset exit flag before
 calling cpu_exec_nocache
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

This patch resets icount_decr.u32.high before calling cpu_exec_nocache
when exception is pending. Exception is caused by the first instruction
in the block and it cannot be executed without resetting the flag.

Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 accel/tcg/cpu-exec.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 35d0240..aaa9c2d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -500,6 +500,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     } else if (replay_has_exception()
                && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
         /* try to cause an exception pending in the log */
+        atomic_set(&cpu->icount_decr.u16.high, 0);
         cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()), true);
         *ret = -1;
         return true;
