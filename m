Received: from eggs.gnu.org ([2001:4830:134:3::10]:36678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpe6P-0000fa-8l
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpe6I-00031S-Rj
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:27:01 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:55283)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpe6I-00030f-EH
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:26:54 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 20:26:43 +0300
Message-Id: <150471880362.24907.17816085971167173217.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 01/20] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 MAINTAINERS         |    6 ++
 docs/instrument.txt |  174 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 180 insertions(+)
 create mode 100644 docs/instrument.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index ccee28b12d..edb313c632 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1480,6 +1480,12 @@ F: scripts/tracetool/
 F: docs/tracing.txt
 T: git git://github.com/stefanha/qemu.git tracing
=20
+Event instrumentation
+M: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+M: Stefan Hajnoczi <stefanha@redhat.com>
+S: Maintained
+F: docs/instrument.txt
+
 Checkpatch
 S: Odd Fixes
 F: scripts/checkpatch.pl
diff --git a/docs/instrument.txt b/docs/instrument.txt
new file mode 100644
index 0000000000..c43ca9c6d0
--- /dev/null
+++ b/docs/instrument.txt
@@ -0,0 +1,174 @@
+=3D Event instrumentation =3D
+
+=3D=3D Introduction =3D=3D
+
+Event instrumentation allows users to execute their own host-native code=
 on a
+set of pre-defined events provided by QEMU. QEMU also exposes other
+functionality to peek/poke at the guest state (e.g., memory or registers=
), as
+well as interacting with tracing events. For those familiar with the ter=
m, this
+provides dynamic binary instrumentation, works on all QEMU-supported
+architectures, as well as works in both 'user' (standalone application) =
and
+'system' (full-system emulation) modes.
+
+Look at the headers installed by QEMU on the "qemu-instr" directory for =
further
+information beyond this document.
+
+
+=3D=3D Loading an instrumentation library =3D=3D
+
+Instrumentation code can be bundled into a dynamic library, which can be=
 later
+loaded into QEMU:
+
+* Using the command-line "-instr" argument.
+
+* Using the "instr-load" and "instr-unload" commands in the HMP and QMP
+  interfaces.
+
+
+=3D=3D Example =3D=3D
+
+1. Configure QEMU with event instrumentation:
+
+    # instrument guest_cpu_enter and guest_mem_before
+    mkdir -p /path/to/qemu-build
+    cd /path/to/qemu-build
+    /path/to/qemu-source/configure \
+      --enable-instrument \
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
+    =20
+    #include <qemu-instr/control.h>         /* manipulate events */
+    #include <qemu-instr/trace.h>           /* manipulate tracing */
+    #include <qemu-instr/visibility.h>      /* symbol visibility */
+    =20
+    /* the address for the memory access is not known at translation tim=
e */
+    void guest_mem_before_trans(QICPU vcpu_trans, QITCGv_cpu vcpu_exec,
+                                QITCGv vaddr, QIMemInfo info)
+    {
+        printf("%s: %p %p %p %d %d %d %d\n", __func__, vcpu_trans, vcpu_=
exec, vaddr,
+               1 << info.size_shift, info.sign_extend, info.endianness, =
info.store);
+        if (info.store) {
+            /* generate at execution time only for memory writes */
+            qi_event_gen_guest_mem_before_exec(vcpu_exec, vaddr, info);
+        }
+    }
+    =20
+    /* called when QEMU executes a memory access */
+    void guest_mem_before_exec(QICPU vcpu, uint64_t vaddr, QIMemInfo inf=
o)
+    {
+        if (info.store) {
+            /* if called by TCG code, we'll only get writes (see above) =
*/
+            printf("%s: %p %lx %d %d %d %d\n", __func__, vcpu, vaddr,
+                   1 << info.size_shift, info.sign_extend, info.endianne=
ss, info.store);
+        }
+    }
+    =20
+    /* called every time QEMU hotplugs a CPU */
+    void guest_cpu_enter(QICPU vcpu)
+    {
+        printf("%s: %p\n", __func__, vcpu);
+    =20
+        /* disable instrumentation and tracing after the first call */
+        static bool found =3D false;
+        if (found) {
+            qi_event_set_guest_cpu_enter(NULL);
+            QITraceEvent *ev =3D qi_trace_event_name("guest_cpu_enter");
+            assert(ev);
+            qi_trace_event_set_state_dynamic(ev, true);
+        } else {
+            found =3D true;
+        }
+    }
+    =20
+    static void fini(void *data)
+    {
+        /* diable all tracing events */
+        QITraceEventIter iter;
+        qi_trace_event_iter_init(&iter, NULL);
+        QITraceEvent *ev;
+        while ((ev =3D qi_trace_event_iter_next(&iter)) !=3D NULL) {
+            if (qi_trace_event_get_state_static(ev)) {
+                qi_trace_event_set_state_dynamic(ev, false);
+            }
+        }
+    =20
+        /* instrumentation callbacks are automatically reset by QEMU */
+    }
+    =20
+    /* mandatory initialization function */
+    QI_VPUBLIC int main(int argc, const char **argv)
+    {
+        int i;
+        printf("init!\n");
+        printf("    argc :: %d\n", argc);
+        for (i =3D 0; i < argc; i++) {
+            printf("            -> %s\n", argv[i]);
+        }
+    =20
+        qi_set_fini(fini, NULL);
+    =20
+        /* instrument and trace events */
+        QITraceEvent *ev;
+    =20
+        qi_event_set_guest_cpu_enter(guest_cpu_enter);
+        ev =3D qi_trace_event_name("guest_cpu_enter");
+        assert(ev);
+        qi_trace_event_set_state_dynamic(ev, true);
+    =20
+        qi_event_set_guest_mem_before_trans(guest_mem_before_trans);
+        ev =3D qi_trace_event_name("guest_mem_before_trans");
+        assert(ev);
+        qi_trace_event_set_state_dynamic(ev, true);
+    =20
+        qi_event_set_guest_mem_before_exec(guest_mem_before_exec);
+        ev =3D qi_trace_event_name("guest_mem_before_exec");
+        assert(ev);
+        qi_trace_event_set_state_dynamic(ev, true);
+    =20
+        return 0;
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
