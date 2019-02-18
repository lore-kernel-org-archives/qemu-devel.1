Received: from eggs.gnu.org ([209.51.188.92]:52461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqW-00077l-UW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqW-0006t4-5r
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:24 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:52 +0100
Message-Id: <20190218111153.22681-10-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
References: <20190218111153.22681-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/10] s390x/kvm: add tracepoint to ioeventfd
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Trace when assigning/unassigning.

Message-Id: <20190212153025.25425-1-cohuck@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c        | 2 ++
 target/s390x/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 15fdc168e1c5..19530fb94e5a 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1886,6 +1886,8 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *=
notifier, uint32_t sch,
         .addr =3D sch,
         .len =3D 8,
     };
+    trace_kvm_assign_subch_ioeventfd(kick.fd, kick.addr, assign,
+                                     kick.datamatch);
     if (!kvm_check_extension(kvm_state, KVM_CAP_IOEVENTFD)) {
         return -ENOSYS;
     }
diff --git a/target/s390x/trace-events b/target/s390x/trace-events
index a84e316e4937..e509b08799c6 100644
--- a/target/s390x/trace-events
+++ b/target/s390x/trace-events
@@ -14,6 +14,7 @@ ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: ch=
sc command 0x%04x, len 0x
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
 kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
 kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) =
"Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
+kvm_assign_subch_ioeventfd(int fd, uint32_t addr, bool assign, int datam=
atch) "fd: %d sch: @0x%x assign: %d vq: %d"
=20
 # target/s390x/cpu.c
 cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" =
PRIu8
--=20
2.17.2
