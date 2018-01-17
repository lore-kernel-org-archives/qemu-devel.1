Received: from eggs.gnu.org ([2001:4830:134:3::10]:55868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpv0-0005q5-MP
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuw-0000n9-Im
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuw-0000km-9d
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:22 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:36 +0100
Message-Id: <1516203816-19374-25-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 24/24] cpu: get rid of cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

There aren't any users of the helper left, remove it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <richard.henderson@linaro.org>
CC: "Emilio G. Cota" <cota@braap.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
CC: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
---
 include/qom/cpu.h | 11 -----------
 qom/cpu.c         | 25 ++-----------------------
 2 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 93bd546..5446040 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -673,17 +673,6 @@ CPUState *cpu_create(const char *typename);
 const char *cpu_parse_cpu_model(const char *typename, const char *cpu_mo=
del);
=20
 /**
- * cpu_generic_init:
- * @typename: The CPU base type.
- * @cpu_model: The model string including optional parameters.
- *
- * Instantiates a CPU, processes optional parameters and realizes the CP=
U.
- *
- * Returns: A #CPUState or %NULL if an error occurred.
- */
-CPUState *cpu_generic_init(const char *typename, const char *cpu_model);
-
-/**
  * cpu_has_work:
  * @cpu: The vCPU to check.
  *
diff --git a/qom/cpu.c b/qom/cpu.c
index e42d9a7..7ab7c36 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -90,14 +90,6 @@ const char *cpu_parse_cpu_model(const char *typename, =
const char *cpu_model)
     return cpu_type;
 }
=20
-CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
-{
-    /* TODO: all callers of cpu_generic_init() need to be converted to
-     * call cpu_parse_features() only once, before calling cpu_generic_i=
nit().
-     */
-    return cpu_create(cpu_parse_cpu_model(typename, cpu_model));
-}
-
 bool cpu_paging_enabled(const CPUState *cpu)
 {
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
@@ -335,22 +327,9 @@ static ObjectClass *cpu_common_class_by_name(const c=
har *cpu_model)
 static void cpu_common_parse_features(const char *typename, char *featur=
es,
                                       Error **errp)
 {
-    char *featurestr; /* Single "key=3Dvalue" string being parsed */
     char *val;
-    static bool cpu_globals_initialized;
-
-    /* TODO: all callers of ->parse_features() need to be changed to
-     * call it only once, so we can remove this check (or change it
-     * to assert(!cpu_globals_initialized).
-     * Current callers of ->parse_features() are:
-     * - cpu_generic_init()
-     */
-    if (cpu_globals_initialized) {
-        return;
-    }
-    cpu_globals_initialized =3D true;
-
-    featurestr =3D features ? strtok(features, ",") : NULL;
+    /* Single "key=3Dvalue" string being parsed */
+    char *featurestr =3D features ? strtok(features, ",") : NULL;
=20
     while (featurestr) {
         val =3D strchr(featurestr, '=3D');
--=20
2.7.4
