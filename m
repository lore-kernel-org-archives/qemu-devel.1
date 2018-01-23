Received: from eggs.gnu.org ([2001:4830:134:3::10]:40608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduLe-0001nu-0l
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduLb-00005a-01
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:54:30 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57220)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduLa-00005M-Ny
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:54:26 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 23 Jan 2018 11:54:27 +0300
Message-ID: <20180123085427.3419.94697.stgit@pasha-VirtualBox>
In-Reply-To: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
References: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v5 12/24] hax: remove BQL lock/unlock
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
This patch also removes lock/unlock from hax module.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 target/i386/hax-all.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 934ec4a..54b1fc7 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -513,11 +513,9 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
 
         hax_vcpu_interrupt(env);
 
-        qemu_mutex_unlock_iothread();
         cpu_exec_start(cpu);
         hax_ret = hax_vcpu_run(vcpu);
         cpu_exec_end(cpu);
-        qemu_mutex_lock_iothread();
 
         /* Simply continue the vcpu_run if system call interrupted */
         if (hax_ret == -EINTR || hax_ret == -EAGAIN) {
