Received: from eggs.gnu.org ([2001:4830:134:3::10]:55666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgod-0007Qa-Aj
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgoY-0001hq-AP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:41 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:37994)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZgoX-0001gp-PS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:38 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:06:26 +0300
Message-Id: <150091598647.30739.2420187318162958941.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/13] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 docs/devel/tracing.txt   |    9 ++
 docs/instrumentation.txt |  264 ++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 273 insertions(+)
 create mode 100644 docs/instrumentation.txt

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 5768a0b7a2..17fcd12469 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -439,3 +439,12 @@ If the translating vCPU has address 0xc1 and code is=
 later executed by vCPU
     baz_trans cpu=3D0xc1 a=3D0xd3
     // at guest code execution
     baz_exec cpu=3D0xc2 a=3D0xd3
+
+=3D=3D=3D "instrument" =3D=3D=3D
+
+When compiling QEMU with trace instrumentation enabled, the "instrument"
+property lets you provide your own implementation for that trace event. =
This
+implementation can override and/or wrap the backend-specific tracing cod=
e
+(regardless of the tracing backend).
+
+See "docs/instrumentation.txt" for more information.
diff --git a/docs/instrumentation.txt b/docs/instrumentation.txt
new file mode 100644
index 0000000000..3d650ed09e
--- /dev/null
+++ b/docs/instrumentation.txt
@@ -0,0 +1,264 @@
+=3D Trace instrumentation =3D
+
+=3D=3D Introduction =3D=3D
+
+Trace instrumentation allows users to execute their own code when QEMU r=
aises
+one of its tracing events (see "docs/devel/tracing.txt"). This is more e=
fficient
+than instrumenting events with the "dtrace" backend, since the user will=
 run
+native instrumentation code and has more options to interact with the dy=
namic
+tracing and instrumentation facilities of QEMU.
+
+When applied to guest code events (i.e., those with the "guest_" prefix,=
 like
+guest memory accesses), this turns QEMU into a fairly efficient and gues=
t
+architecture-agnostic dynamic binary instrumentation framework. It works=
 on all
+QEMU-supported architectures, as well as works in both 'user' (standalon=
e
+application) and 'system' (full-system emulation) modes.
+
+Look at the headers installed by QEMU on the "qemu-instr" directory for =
further
+information beyond this document.
+
+
+=3D=3D Selecting the events to instrument =3D=3D
+
+You must first select which events must be instrumentable before compili=
ng QEMU
+by prefixing them with the "instrument" property, and removing the "disa=
ble"
+property if it is present.
+
+To get the full list of files defining events:
+
+    find /path/to/qemu-source -name trace-events
+
+To avoid modifying QEMU's sources, you can pass the "--with-instrument-e=
vents"
+argument to configure with one event name per line.
+
+
+=3D=3D Instrumenting guest code =3D=3D
+
+QEMU emulates all guest instructions when executing in TCG mode (as oppo=
sed to
+using native hardware virtualization with KVM). Instructions are decompi=
led and
+translated into the intermediate TCG language. Then, the TCG compiler tr=
anslates
+TCG code into the native host code that QEMU will execute.
+
+All events relating to guest code are named "guest_*". In addition, all =
events
+with the "tcg" property (see "docs/devel/tracing.txt") can be instrument=
ed at
+two levels:
+
+* Translation
+
+  Raised when generating TCG code (e.g., translate a memory access instr=
uction
+  from the guest).
+
+  Note: This level only exists for events with the "tcg" property.
+
+* Execution
+
+  Raised when executing the native host code generated by the TCG compil=
er
+  (e.g., execute a memory access instruction from the guest).
+
+  Note: All events without the "tcg" property are raised at execution ti=
me
+        (e.g., CPU hotplug).
+
+Note: Events with the "tcg" property (e.g., 'guest_mem_before') are inte=
rnally
+      translated into two events to differentiate the translation and ex=
ecution
+      levels (e.g., 'guest_mem_before_trans' and 'guest_mem_before_exec'=
).
+
+Note: All guest events have a "Mode" and "Target" line describing when t=
hey are
+      available (e.g., TCG, KVM, etc.).
+
+
+=3D=3D Setting instrumentation callbacks =3D=3D
+
+Function qi_ctrl_event_set() in "qemu-instr/control.h" can be used to se=
t the
+instrumentation callback on each event to a user-specified function. Hea=
der
+"qemu-instr/events.h" provides the event identifiers and some pre-define=
d
+callbacks:
+
+* QI_EVENT_${EVENT}
+
+  Event identifier, passed to functions in "qemu-instr/control.h".
+
+* qi_event_${event}_nop
+
+  Do nothing.
+
+* qi_event_${event}_trace
+
+  Trace the event using whatever tracing backend QEMU has been configure=
d with.
+
+* qi_event_${event}_gen_exec
+
+  Generate TCG code to raise the corresponding event when the TCG-genera=
ted code
+  is executed. Otherwise, the event will not be instrumented at executio=
n time,
+  resulting in zero-overhead when executing the guest code.
+
+  Only available for translation-time events.
+
+* qi_event_${event}_trace_and_gen_exec
+
+  Combines 'qi_event_${event}_trace' and 'qi_event_${event}_gen_exec' in=
 a
+  single call.
+
+  Only available for translation-time events.
+
+
+=3D=3D Loading an instrumentation library =3D=3D
+
+There are two ways two load an instrumentation library:
+
+* Using the command-line "-instr" argument.
+
+* Using the "instr-load" and "instr-unload" commands in the HMP and QMP
+  interfaces.
+
+
+=3D=3D=3D Example =3D=3D=3D
+
+1. Configure QEMU with the selected events to instrument:
+
+    # instrument guest_cpu_enter and guest_mem_before
+    cat >/tmp/my-events <<EOF
+    guest_cpu_enter
+    guest_mem_before
+    EOF
+    mkdir -p /path/to/qemu-build
+    cd /path/to/qemu-build
+    /path/to/qemu-source/configure \
+      --enable-trace-instrument \
+      --with-instrument-events=3D/tmp/my-events \
+      --prefix=3D/path/to/qemu-install
+
+2. Build and install QEMU:
+
+    make install
+
+3. Create the "Makefile" to build the instrumentation library:
+
+    mkdir -p /tmp/my-instrument
+   =20
+    cat > /tmp/my-instrument/Makefile <<EOF
+    QEMU_PATH=3D/tmp/qemu-install/
+   =20
+    CFLAGS +=3D -g
+    CFLAGS +=3D -O3
+    CFLAGS +=3D -Werror -Wall
+    CFLAGS +=3D -I$(QEMU_PATH)/include
+   =20
+    all: libtrace-instrument.la
+   =20
+    libtrace-instrument.la: instrument.lo
+            libtool --mode=3Dlink --tag=3DCC $(CC) -module -rpath /usr/l=
ocal/lib -o $@ $^
+   =20
+    %.lo: %.c
+            libtool --mode=3Dcompile --tag=3DCC $(CC) $(CFLAGS) -c $^
+   =20
+    clean:
+            $(RM) -f *.o *.so *.lo
+            $(RM) -Rf .libs
+    EOF
+
+4. Write your instrumentation library:
+
+    cat > /tmp/my-instrument/instrument.c <<EOF
+    #include <stdio.h>
+    #include <assert.h>
+   =20
+    #include <qemu-instr/events.h>      /* get event declarations */
+    #include <qemu-instr/control.h>     /* manipulate events */
+   =20
+    /* as documented in QEMU's event description */
+    struct mem_info {
+        uint8_t size_shift : 2;
+        bool    sign_extend: 1;
+        uint8_t endianness : 1;
+        bool    store      : 1;
+    };
+   =20
+    /* the address for the memory access is not known at translation tim=
e */
+    void guest_mem_before_trans(QICPU *cpu, QITCGv_cpu tcg_cpu,
+                                QITCGv vaddr, uint8_t info)
+    {
+        struct mem_info *mi =3D (struct mem_info*)&info;
+        qi_event_guest_mem_before_trans_trace(cpu, tcg_cpu, vaddr, info)=
;
+        if (mi->store) {
+            /* generate at execution time only for memory writes */
+            qi_event_guest_mem_before_trans_gen_exec(cpu, tcg_cpu, vaddr=
, info);
+        }
+    }
+   =20
+    /* called when QEMU executes a memory access */
+    void guest_mem_before_exec(QICPU *cpu, uint64_t vaddr, uint8_t info)
+    {
+        struct mem_info *mi =3D (struct mem_info*)&info;
+        if (mi->store) {
+            /* if called by TCG code, we'll only get writes (see above) =
*/
+            qi_event_guest_mem_before_exec_trace(cpu, vaddr, info);
+        }
+    }
+   =20
+    /* called every time QEMU hotplugs a CPU */
+    void guest_cpu_enter(QICPU *cpu)
+    {
+        /* call the original tracing routine */
+        qi_event_guest_cpu_enter_trace(cpu);
+   =20
+        /* disable instrumentation and tracing after the first call */
+        static bool found =3D false;
+        if (found) {
+            QIEvent *ev =3D QI_EVENT_GUEST_CPU_ENTER;
+            qi_ctrl_event_set(ev, NULL);
+            qi_trace_event_set_state_dynamic(ev, false);
+        } else {
+            found =3D true;
+        }
+    }
+   =20
+   =20
+    /* mandatory initialization callback */
+    void qi_init(int argc, const char **argv)
+    {
+        int i;
+        printf("init!\n");
+        printf("    argc :: %d\n", argc);
+        for (i =3D 0; i < argc; i++) {
+            printf("            -> %s\n", argv[i]);
+        }
+
+        /* instrument and trace events */
+        QIEvent *ev;
+
+        ev =3D QI_EVENT_GUEST_CPU_ENTER;
+        qi_ctrl_event_set(ev, guest_cpu_enter);
+        qi_trace_event_set_state_dynamic(ev, true);
+   =20
+        ev =3D QI_EVENT_GUEST_MEM_BEFORE_TRANS;
+        qi_ctrl_event_set(ev, guest_mem_before_trans);
+        qi_trace_event_set_state_dynamic(ev, true);
+   =20
+        ev =3D QI_EVENT_GUEST_MEM_BEFORE_EXEC;
+        qi_ctrl_event_set(ev, guest_mem_before_exec);
+        qi_trace_event_set_state_dynamic(ev, true);
+    }
+   =20
+    /* mandatory finalization callback */
+    void qi_fini(void)
+    {
+        fprintf(stderr, "fini!\n");
+   =20
+        /* ensure all tracing is disabled */
+        qi_trace_event_set_state_dynamic(QI_EVENT_GUEST_CPU_ENTER, false=
);
+        qi_trace_event_set_state_dynamic(QI_EVENT_GUEST_MEM_BEFORE_TRANS=
, false);
+        qi_trace_event_set_state_dynamic(QI_EVENT_GUEST_MEM_BEFORE_EXEC,=
 false);
+   =20
+        /* instrumentation callbacks are automatically reset by QEMU */
+    }
+    EOF
+
+5. Compile the instrumentation library:
+
+    make -C /tmp/my-instrument
+
+6. Start QEMU with the instrumentation library:
+
+    /tmp/qemu-install/bin/qemu-system-x86_64 \
+        -instr file=3D/tmp/my-dinstrument/.libs/libtrace-instrument.so, =
\
+               arg=3Dfoo,arg=3Dbar
