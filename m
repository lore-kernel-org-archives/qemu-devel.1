Received: from eggs.gnu.org ([2001:4830:134:3::10]:58823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh01-0002Pu-P4
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh00-0002iV-Is
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmh00-0002i1-Ac
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:56 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:49 +0400
Message-Id: <20170311132256.22951-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/21] qga: add and populate VMDumpInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Get various addresses and informations that can be useful for qemu to
generate dumps, and provide enough details for KASLR kernels to be
exploitable by tools like crash.

phys-base: the physical address where the kernel is loaded
vmcoreinfo: can be used to read the guest vmcoreinfo ELF note
_text: can be used to compute the kaslr offset (not needed when vmcoreinf=
o)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/main.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 134 insertions(+)

diff --git a/qga/main.c b/qga/main.c
index beff041340..1c39895baa 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -65,6 +65,14 @@ typedef struct GAPersistentState {
     int64_t fd_counter;
 } GAPersistentState;
=20
+typedef struct VMDumpInfo {
+    bool has_phys_base;
+    uint64_t phys_base;
+    bool has_text;
+    uint64_t text;
+    char *vmcoreinfo;
+} VMDumpInfo;
+
 struct GAState {
     JSONMessageParser parser;
     GMainLoop *main_loop;
@@ -90,6 +98,7 @@ struct GAState {
 #endif
     gchar *pstate_filepath;
     GAPersistentState pstate;
+    VMDumpInfo vmdump;
 };
=20
 struct GAState *ga_state;
@@ -1357,6 +1366,128 @@ static int run_agent(GAState *s, GAConfig *config=
)
     return EXIT_SUCCESS;
 }
=20
+#define __START_KERNEL_map    0xffffffff80000000UL
+
+static void update_vmdump_info(GAState *s)
+{
+#ifndef _WIN32
+    char *vmcoreinfo =3D NULL;
+    char *iomem =3D NULL;
+    char *kallsyms =3D NULL;
+    gsize len;
+    GError *err =3D NULL;
+#ifdef __x86_64__
+    guint64 kernel_code_start, text_start, phys_base;
+    char *tmp, *line, *eol;
+
+    if (!g_file_get_contents("/proc/iomem", &iomem, &len, &err)) {
+        g_critical("Failed to read /proc/iomem: %s", err->message);
+        g_clear_error(&err);
+        goto end;
+    }
+    if (!iomem[len] =3D=3D '\0') {
+        g_critical("iomem is not null-terminated");
+        goto end;
+    }
+
+    for (line =3D iomem; line !=3D NULL; line =3D eol ? eol + 1 : NULL) =
{
+        eol =3D strstr(line, "\n");
+        if (eol) {
+            *eol =3D '\0';
+        }
+        tmp =3D strstr(line, " : Kernel code");
+        if (!tmp || *(tmp + 14) !=3D '\0') {
+            continue;
+        } else {
+            break;
+        }
+    }
+
+    if (line =3D=3D NULL) {
+        g_critical("failed to find kernel_code_start");
+        goto end;
+    } else {
+        tmp =3D strstr(line, "-");
+        if (!tmp) {
+            g_critical("no -");
+            goto end;
+        }
+        *tmp =3D '\0';
+        kernel_code_start =3D g_ascii_strtoull(g_strstrip(line), &tmp, 1=
6);
+        if (*tmp !=3D '\0') {
+            g_critical("failed to parse hex value");
+            goto end;
+        }
+    }
+
+    if (!g_file_get_contents("/proc/kallsyms", &kallsyms, &len, &err)) {
+        g_critical("Failed to read /proc/kallsyms: %s", err->message);
+        g_clear_error(&err);
+        goto end;
+    }
+    if (!kallsyms[len] =3D=3D '\0') {
+        g_critical("iomem is not null-terminated");
+        goto end;
+    }
+
+    for (line =3D kallsyms; line !=3D NULL; line =3D eol ? eol + 1 : NUL=
L) {
+        eol =3D strstr(line, "\n");
+        if (eol) {
+            *eol =3D '\0';
+        }
+        tmp =3D strstr(line, " T _text");
+        if (!tmp || *(tmp + 8) !=3D '\0') {
+            continue;
+        } else {
+            *tmp =3D '\0';
+            break;
+        }
+    }
+
+    if (line =3D=3D NULL) {
+        g_critical("failed to find _text");
+        goto end;
+    } else {
+        text_start =3D g_ascii_strtoull(g_strstrip(line), &tmp, 16);
+        if (*tmp !=3D '\0') {
+            g_critical("failed to parse hex value");
+            goto end;
+        }
+    }
+
+    phys_base =3D kernel_code_start - (text_start - __START_KERNEL_map);
+    g_debug("_text: %lx, kernel_code_start: %lx",
+            text_start, kernel_code_start);
+    g_debug("-> phys_base: %lx", phys_base);
+    g_debug("vmcoreinfo: %s", vmcoreinfo);
+
+    s->vmdump.has_phys_base =3D true;
+    s->vmdump.phys_base =3D phys_base;
+    s->vmdump.has_text =3D true;
+    s->vmdump.text =3D text_start;
+#endif /* x86_64 */
+
+    if (!g_file_get_contents("/sys/kernel/vmcoreinfo",
+                             &vmcoreinfo, &len, &err)) {
+        g_critical("Failed to read vmcoreinfo: %s", err->message);
+        g_clear_error(&err);
+        goto end;
+    }
+    if (!vmcoreinfo[len] =3D=3D '\0') {
+        g_critical("vmcoreinfo is not null-terminated");
+        goto end;
+    }
+
+    s->vmdump.vmcoreinfo =3D vmcoreinfo;
+    vmcoreinfo =3D NULL;
+
+end:
+    g_free(vmcoreinfo);
+    g_free(kallsyms);
+    g_free(iomem);
+#endif
+}
+
 int main(int argc, char **argv)
 {
     int ret =3D EXIT_SUCCESS;
@@ -1364,6 +1495,8 @@ int main(int argc, char **argv)
     GAConfig *config =3D g_new0(GAConfig, 1);
     int listen_fd;
=20
+    update_vmdump_info(s);
+
     config->log_level =3D G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
=20
     qga_qmp_init_marshal(&ga_commands);
@@ -1460,6 +1593,7 @@ end:
     if (s->main_loop) {
         g_main_loop_unref(s->main_loop);
     }
+    g_free(s->vmdump.vmcoreinfo);
     g_free(s);
=20
     return ret;
--=20
2.12.0.191.gc5d8de91d
