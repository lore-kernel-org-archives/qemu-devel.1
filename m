Received: from eggs.gnu.org ([2001:4830:134:3::10]:56521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daclC-0003SM-UH
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dacl8-0006dT-S4
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:59:03 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:52022)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dacl8-0006d8-9q
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:58:58 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 27 Jul 2017 09:58:50 +0300
Message-Id: <150113873031.25904.2885171804743103875.stgit@frigg.lan>
In-Reply-To: <150113848793.25904.12006041120076726256.stgit@frigg.lan>
References: <150113848793.25904.12006041120076726256.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 1/5] hypertrace: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 docs/devel/tracing.txt |    3 +
 docs/hypertrace.txt    |  225 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 228 insertions(+)
 create mode 100644 docs/hypertrace.txt

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 5768a0b7a2..9178a308da 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -5,6 +5,9 @@
 This document describes the tracing infrastructure in QEMU and how to us=
e it
 for debugging, profiling, and observing execution.
=20
+See "docs/hypertrace.txt" to correlate guest tracing events with those i=
n the
+QEMU host.
+
 =3D=3D Quickstart =3D=3D
=20
 1. Build with the 'simple' trace backend:
diff --git a/docs/hypertrace.txt b/docs/hypertrace.txt
new file mode 100644
index 0000000000..c3715db25b
--- /dev/null
+++ b/docs/hypertrace.txt
@@ -0,0 +1,225 @@
+=3D Hypertrace channel =3D
+
+Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.
+See the COPYING file in the top-level directory.
+
+
+The hypertrace channel allows guest code to emit events in QEMU (the hos=
t) using
+its tracing infrastructure (see "docs/trace.txt"). This works in both 's=
ystem'
+and 'user' modes. Therefore, hypertrace is to tracing what hypercalls ar=
e to
+system calls.
+
+The hypertrace channel can be used for various purposes:
+
+* Using guest code semantics to guide which QEMU events to trace at each=
 point
+  in time. The example "Quick guide" below shows how to use this to iden=
tify
+  "regions of interest" in your guest code. It then uses these regions t=
o trace
+  QEMU's behaviour during their execution, without paying the price of t=
racing
+  events outside the interest regions.
+
+* Mark "progress points" in guest code (e.g., processed client requests,
+  scheduled processes, etc), so that they can be easily traced and corre=
lated
+  between QEMU's various tracing events and the guest's own tracing
+  infrastructure (e.g., Linux's tracepoints).
+
+* You can also use regions of interest and progress points on the guest =
code to
+  time the performance of new TCG optimizations. Each hypertrace event c=
omes
+  with a host timestamp, making it easy to compare the host execution ti=
mes of
+  interesting guest code.
+
+Hypertrace features:
+
+* Works with 'system' and 'user' mode.
+
+* Minimal setup for the guest; QEMU provides support guest code librarie=
s that
+  work out of the box.
+
+* Independent of guest architecture; the guest code uses accesses to spe=
cial
+  memory regions, as opposed to redefining instruction semantics.
+
+* Negligible guest overhead; emitting a hypertrace event requires a sing=
le guest
+  memory access, making it as unobtrusive as possible.
+
+Warning: The hypertrace channel in 'system' mode only works in systems w=
ith
+support for PCI. You can get the list of guests with PCI support with 'g=
rep
+pci.mak default-configs/*'.
+
+
+=3D=3D Quick guide =3D=3D
+
+This shows an example of using the hypertrace channel to trace the guest=
 memory
+accesses only in a specific guest code region, which is identified by ca=
lls to
+the hypertrace channel.
+
+We are going to trace memory accesses to disk using QEMU's "log" backend=
, and
+will use QEMU's "dtrace" backend (SystemTap) to ensure memory accesses a=
re only
+traced in the guest code region of interest. The first time the guest co=
de
+invokes the hypertrace channel, we will start tracing the
+"guest_mem_before_exec" event using dtrace, and then will disable it the=
 second
+time around.
+
+Tracing is done with "log" because it is more efficient than using "dtra=
ce" in
+high-volume events like memory accesses.
+
+1. Set the tracing backends and number of arguments for the hypertrace e=
vents:
+
+    mkdir /tmp/qemu-build
+    cd /tmp/qemu-build
+    /path/to/qemu-source/configure              \
+        --enable-trace-backends=3Ddtrace,log      \
+        --with-hypertrace-args=3D4                \
+        --prefix=3D/tmp/qemu-install
+    make -j install
+
+2. Compile QEMU:
+
+    make -C /tmp/qemu-build install -j
+
+3. Compile the guest support code:
+
+    make -C /tmp/qemu-build/x86_64-linux-user/hypertrace/guest
+    make -C /tmp/qemu-build/x86_64-softmmu/hypertrace/guest
+
+   If you need to cross-compile the guest library, set the 'CC' variable=
:
+
+    make -C /tmp/qemu-build/mipsel-linux-user/hypertrace/guest CC=3Dmips=
el-gnu-linux-gcc
+
+4. Create a guest application that interacts with the hypertrace channel=
:
+
+    cat > /tmp/my-hypertrace.c <<\EOF
+    #include <stdio.h>
+    #include <errno.h>
+    #include <stdlib.h>
+    #include <string.h>
+    #include <qemu-hypertrace.h>
+   =20
+   =20
+    int main(int argc, char **argv)
+    {
+        char *base =3D NULL;
+        if (argc > 1) {
+            base =3D argv[1];
+        }
+   =20
+        /* In 'user' mode this path must be the same we will use to star=
t QEMU. */
+        if (qemu_hypertrace_init(base) !=3D 0) {
+            perror("error: qemu_hypertrace_init");
+            abort();
+        }
+   =20
+        /* Set additional event arguments (unused in this example) */
+        uint64_t client  =3D 0;
+        uint64_t *data =3D qemu_hypertrace_data(client);
+        data[0] =3D 0xcafe;
+        data[1] =3D 0xdead;
+        data[2] =3D 0xbeef;
+   =20
+        /* Emit event to start tracing */
+        qemu_hypertrace(client, 1);
+
+        /* Computation in between that we want to trace */
+        printf("Some computation...\n");
+
+        /* Emit event to stop tracing */
+        qemu_hypertrace(client, 0);
+    }
+    EOF
+
+    gcc -o /tmp/my-hypertrace-user /tmp/my-hypertrace.c                 =
                \
+        /tmp/qemu-build/x86_64-linux-user/hypertrace/guest/libqemu-hyper=
trace-guest.a   \
+        -I/tmp/qemu-install/include -lpthread
+
+    gcc -o /tmp/my-hypertrace-softmmu /tmp/my-hypertrace.c              =
                \
+        /tmp/qemu-build/x86_64-softmmu/hypertrace/guest/libqemu-hypertra=
ce-guest.a      \
+        -I/tmp/qemu-install/include -lpthread
+
+5. Create a SystemTap script to control event tracing:
+
+    cat > /tmp/my-hypertrace-script.stp <<\EOF
+    #!/usr/bin/env stap
+   =20
+    %{
+    #include <linux/delay.h>
+    %}
+   =20
+    function enable_mem:long()
+    %{
+        /* Tell QEMU's monitor to enable tracing */
+        char *argv[4] =3D {"/bin/sh", "-c", "echo 'trace-event guest_mem=
_before_exec on' | telnet localhost 1234", NULL};
+        printk(KERN_ERR "enable\n");
+        call_usermodehelper(argv[0], argv, NULL, UMH_WAIT_EXEC);
+        /* Wait for changes to apply */
+        msleep(1000);
+        printk(KERN_ERR "enabled\n");
+        STAP_RETURN(0);
+    %}
+   =20
+    function disable_mem:long()
+    %{
+        char *argv[4] =3D {"/bin/sh", "-c", "echo 'trace-event guest_mem=
_before_exec off' | telnet localhost 1234", NULL};
+        printk(KERN_ERR "disable\n");
+        call_usermodehelper(argv[0], argv, NULL, UMH_WAIT_EXEC);
+        msleep(1000);
+        printk(KERN_ERR "disabled\n");
+        STAP_RETURN(0);
+    %}
+   =20
+    probe process("/tmp/qemu-install/bin/qemu-*").mark("guest_hypertrace=
")
+    {
+        if ($arg1 =3D=3D 1) {
+            enable_mem()
+        } else if ($arg1 =3D=3D 0) {
+            disable_mem()
+        }
+    }
+    EOF
+
+6. Run a guest system with access to QEMU's hypertrace:
+
+    stap -g /tmp/my-hypertrace-script.stp -c            \
+    '/tmp/qemu-install/bin/qemu-system-x86_64           \
+      -device hypertrace                                \
+      -monitor tcp:localhost:1234,server,nowait         \
+      -trace enable=3Dguest_hypertrace -D /dev/stdout     \
+      ...'
+
+   And inside the VM:
+
+    sudo /tmp/my-hypertrace-softmmu
+
+   The result will be something like this:
+
+    VNC server running on ::1:5900
+    23071@1473096085.744211:guest_hypertrace cpu=3D0x5602e1f49c10  arg1=3D=
1 arg2=3D0x000000000000cafe arg3=3D0x000000000000dead arg4=3D0x0000000000=
00beef
+    23071@1473096085.745763:guest_mem_before_trans cpu=3D0x5602e1f49c10 =
info=3D19
+    23071@1473096085.745907:guest_mem_before_trans cpu=3D0x5602e1f49c10 =
info=3D3
+    23071@1473096085.752368:guest_mem_before_trans cpu=3D0x5602e1f49c10 =
info=3D3
+    23071@1473096085.752384:guest_mem_before_trans cpu=3D0x5602e1f49c10 =
info=3D19
+    23071@1473096086.756117:guest_hypertrace cpu=3D0x5602e1f49c10  arg1=3D=
0 arg2=3D0x000000000000cafe arg3=3D0x000000000000dead arg4=3D0x0000000000=
00beef
+
+   To instead run a guest in 'user' mode with hypertrace (standalone gue=
st
+   applications):
+
+    /tmp/qemu-install/bin/qemu-x86_64          \
+      -hypertrace /tmp/hypertrace              \
+      -trace enable=3Dguest* -D /dev/stdout      \
+      /tmp/my-hypertrace-user /tmp/hypertrace
+
+
+=3D=3D Details =3D=3D
+
+To make it more efficient in terms of guest and host time, hypertrace pr=
ovides
+two different memory areas (channels).
+
+The control channel is used by the guest to tell QEMU that new data is r=
eady to
+be processed in the data channel. Writes to the control channel are inte=
rcepted
+by QEMU, which emits the "hypertrace" tracing event.
+
+The data channel is a regular memory buffer used by the guest to write
+additional event arguments before raising the event through the control =
channel.
+
+Both channels accept different "per-client offsets" to enable multiple g=
uest
+threads or CPUs to use the hypertrace channel without having to synchron=
ize
+(i.e., similar to what virtual devices achieve in SR-IOV).
