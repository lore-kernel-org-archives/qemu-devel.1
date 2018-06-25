Received: from eggs.gnu.org ([2001:4830:134:3::10]:54260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvT-0001hM-0o
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvR-00036Q-UI
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvR-00035a-DI
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:15 -0300
Message-Id: <20180625222524.382-4-ehabkost@redhat.com>
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/12] i386: improve sorting of CPU model names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The current list of CPU model names output by "-cpu help" is sorted
alphabetically based on the internal QOM class name. The text that is
displayed, however, uses the CPU model name, which is equivalent to the
QOM class name, minus a suffix. Unfortunately that suffix has an effect
on the sort ordering, for example, causing the various Broadwell
variants to appear reversed:

  x86 486
  x86 Broadwell-IBRS        Intel Core Processor (Broadwell, IBRS)
  x86 Broadwell-noTSX-IBRS  Intel Core Processor (Broadwell, no TSX, IBRS
  x86 Broadwell-noTSX       Intel Core Processor (Broadwell, no TSX)
  x86 Broadwell             Intel Core Processor (Broadwell)
  x86 Conroe                Intel Celeron_4x0 (Conroe/Merom Class Core 2)

By sorting on the actual CPU model name text that is displayed, the
result is

  x86 486
  x86 Broadwell             Intel Core Processor (Broadwell)
  x86 Broadwell-IBRS        Intel Core Processor (Broadwell, IBRS)
  x86 Broadwell-noTSX       Intel Core Processor (Broadwell, no TSX)
  x86 Broadwell-noTSX-IBRS  Intel Core Processor (Broadwell, no TSX, IBRS=
)
  x86 Conroe                Intel Celeron_4x0 (Conroe/Merom Class Core 2)

This requires extra string allocations during sorting, but this is not a
concern given the usage scenario and the number of CPU models that exist.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180606165527.17365-3-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e1d7157d8c..19ac1e6569 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3351,15 +3351,19 @@ static gint x86_cpu_list_compare(gconstpointer a,=
 gconstpointer b)
     ObjectClass *class_b =3D (ObjectClass *)b;
     X86CPUClass *cc_a =3D X86_CPU_CLASS(class_a);
     X86CPUClass *cc_b =3D X86_CPU_CLASS(class_b);
-    const char *name_a, *name_b;
+    char *name_a, *name_b;
+    int ret;
=20
     if (cc_a->ordering !=3D cc_b->ordering) {
-        return cc_a->ordering - cc_b->ordering;
+        ret =3D cc_a->ordering - cc_b->ordering;
     } else {
-        name_a =3D object_class_get_name(class_a);
-        name_b =3D object_class_get_name(class_b);
-        return strcmp(name_a, name_b);
+        name_a =3D x86_cpu_class_get_model_name(cc_a);
+        name_b =3D x86_cpu_class_get_model_name(cc_b);
+        ret =3D strcmp(name_a, name_b);
+        g_free(name_a);
+        g_free(name_b);
     }
+    return ret;
 }
=20
 static GSList *get_sorted_cpu_model_list(void)
--=20
2.18.0.rc1.1.g3f1ff2140
