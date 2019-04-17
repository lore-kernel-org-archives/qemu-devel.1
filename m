Received: from eggs.gnu.org ([209.51.188.92]:58106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGanm-0002nd-6O
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGanl-0007lq-CC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:58 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 16 Apr 2019 23:59:42 -0300
Message-Id: <20190417025944.16154-4-ehabkost@redhat.com>
In-Reply-To: <20190417025944.16154-1-ehabkost@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] linux-user: Use lookup_cpu_class()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The return value of cpu_get_model() is just a CPU model name and
never includes extra options.  We don't need to call
parse_cpu_option().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 linux-user/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 20e0f51cfa..d74108e05c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -592,6 +592,7 @@ int main(int argc, char **argv, char **envp)
     TaskState *ts;
     CPUArchState *env;
     CPUState *cpu;
+    CPUClass *cc;
     int optind;
     char **target_environ, **wrk;
     char **target_argv;
@@ -660,7 +661,8 @@ int main(int argc, char **argv, char **envp)
     if (cpu_model == NULL) {
         cpu_model = cpu_get_model(get_elf_eflags(execfd));
     }
-    cpu_type = parse_cpu_option(cpu_model);
+    cc = lookup_cpu_class(cpu_model, &error_fatal);
+    cpu_type = object_class_get_name(OBJECT_CLASS(cc));
 
     /* init tcg before creating CPUs and to get qemu_host_page_size */
     tcg_exec_init(0);
-- 
2.18.0.rc1.1.g3f1ff2140
