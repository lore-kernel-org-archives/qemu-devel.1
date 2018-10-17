Received: from eggs.gnu.org ([2001:4830:134:3::10]:53458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiiA-0005yR-Ds
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii7-0002H3-JV
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCii7-0001FN-9J
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:51 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:05:05 +0200
Message-Id: <1539770707-7289-14-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/15] cpu: Provide a proper prototype for
 target_words_bigendian() in a header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

We've got three places already that provide a prototype for this
function in a .c file - that's ugly. Let's provide a proper prototype
in a header instead, with a proper description why this function should
not be used in most cases.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 exec.c             |  5 -----
 hw/virtio/virtio.c |  1 -
 include/qom/cpu.h  | 11 +++++++++++
 qom/cpu.c          |  1 -
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/exec.c b/exec.c
index d0821e6..5d99ef5 100644
--- a/exec.c
+++ b/exec.c
@@ -3906,11 +3906,6 @@ int qemu_target_page_bits_min(void)
 }
 #endif
=20
-/*
- * A helper function for the _utterly broken_ virtio device model to fin=
d out if
- * it's running on a big endian machine. Don't do this at home kids!
- */
-bool target_words_bigendian(void);
 bool target_words_bigendian(void)
 {
 #if defined(TARGET_WORDS_BIGENDIAN)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 94f5c8e..4e61944 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1169,7 +1169,6 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t v=
al)
     return 0;
 }
=20
-bool target_words_bigendian(void);
 static enum virtio_device_endian virtio_default_endian(void)
 {
     if (target_words_bigendian()) {
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index dc130cd..4e238b0 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -1085,6 +1085,17 @@ void cpu_exec_initfn(CPUState *cpu);
 void cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
=20
+/**
+ * target_words_bigendian:
+ * Returns true if the (default) endianness of the target is big endian,
+ * false otherwise. Note that in target-specific code, you can use
+ * TARGET_WORDS_BIGENDIAN directly instead. On the other hand, common
+ * code should normally never need to know about the endianness of the
+ * target, so please do *not* use this function unless you know very wel=
l
+ * what you are doing!
+ */
+bool target_words_bigendian(void);
+
 #ifdef NEED_CPU_H
=20
 #ifdef CONFIG_SOFTMMU
diff --git a/qom/cpu.c b/qom/cpu.c
index 92599f3..f774654 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -194,7 +194,6 @@ static bool cpu_common_debug_check_watchpoint(CPUStat=
e *cpu, CPUWatchpoint *wp)
     return true;
 }
=20
-bool target_words_bigendian(void);
 static bool cpu_common_virtio_is_big_endian(CPUState *cpu)
 {
     return target_words_bigendian();
--=20
1.8.3.1
