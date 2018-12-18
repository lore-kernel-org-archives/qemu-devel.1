Received: from eggs.gnu.org ([2001:4830:134:3::10]:47226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDSe-0003ab-He
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDSb-0006hc-VB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:52 -0500
Received: from mail.ispras.ru ([83.149.199.45]:55808)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gZDSb-0006gi-Fl
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:22:49 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 18 Dec 2018 14:22:50 +0300
Message-ID: <20181218112250.11727.72640.stgit@pasha-VirtualBox>
In-Reply-To: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 20/20] replay: document development rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This patch introduces docs/devel/replay.txt which describes the rules
that should be followed to make virtual devices usable in record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgauk@ispras.ru>
---
 docs/devel/replay.txt |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 docs/devel/replay.txt

diff --git a/docs/devel/replay.txt b/docs/devel/replay.txt
new file mode 100644
index 0000000..61dac1b
--- /dev/null
+++ b/docs/devel/replay.txt
@@ -0,0 +1,45 @@
+Record/replay mechanism, that could be enabled through icount mode, expects
+the virtual devices to satisfy the following requirements.
+
+The main idea behind this document is that everything that affects
+the guest state during execution in icount mode should be deterministic.
+
+Timers
+======
+
+All virtual devices should use virtual clock for timers that change the guest
+state. Virtual clock is deterministic, therefore such timers are deterministic
+too.
+
+Virtual devices can also use realtime clock for the events that do not change
+the guest state directly. When the clock ticking should depend on VM execution
+speed, use virtual ext clock. It is not deterministic, but its speed depends
+on the guest execution. This clock is used by the virtual devices (e.g.,
+slirp routing device) that lie outside the replayed guest.
+
+Bottom halves
+=============
+
+Bottom half callbacks, that affect the guest state, should be invoked through
+replay_bh_schedule_event or replay_bh_schedule_oneshot_event functions.
+Their invocations are saved in record mode and synchronized with the existing
+log in replay mode.
+
+Saving/restoring the VM state
+=============================
+
+All fields in the device state structure (including virtual timers)
+should be restored by loadvm to the same values they had before savevm.
+
+Avoid accessing other devices' state, because the order of saving/restoring
+is not defined. It means that you should not call functions like
+'update_irq' in post_load callback. Save everything explicitly to avoid
+the dependencies that may make restoring the VM state non-deterministic.
+
+Stopping the VM
+===============
+
+Stopping the guest should not interfere with its state (with the exception
+of the network connections, that could be broken by the remote timeouts).
+VM can be stopped at any moment of replay by the user. Restarting the VM
+after that stop should not break the replay by the unneeded guest state change.
