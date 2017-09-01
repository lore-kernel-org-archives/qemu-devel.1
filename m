Received: from eggs.gnu.org ([2001:4830:134:3::10]:40741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTr-0007rQ-WB
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTo-0002v4-RI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnTo-0002uS-MN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:02:53 -0300
Message-Id: <20170901150317.10380-6-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/29] qom: cpu: fix parsed feature string length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

since commit ( 9262685b cpu: Factor out cpu_generic_init() )
features parsed by it were truncated only to the 1st feature
after CPU name due to fact that

   featurestr =3D strtok(NULL, ",");
   cc->parse_features(cpu, featurestr, &err);

would extract exactly one feature and parse_features() callback
would parse it and only it leaving the rest of features ignored.

Reuse approach from x86 custom impl. i.e. replace strtok() token
parsing with g_strsplit(), which would split feature string in
2 parts name and features list and pass the later to
parse_features() callback.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1503592308-93913-2-git-send-email-imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qom/cpu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index e6210d5949..deb8880930 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -55,28 +55,26 @@ bool cpu_exists(int64_t id)
=20
 CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
 {
-    char *str, *name, *featurestr;
     CPUState *cpu =3D NULL;
     ObjectClass *oc;
     CPUClass *cc;
     Error *err =3D NULL;
+    gchar **model_pieces;
=20
-    str =3D g_strdup(cpu_model);
-    name =3D strtok(str, ",");
+    model_pieces =3D g_strsplit(cpu_model, ",", 2);
=20
-    oc =3D cpu_class_by_name(typename, name);
+    oc =3D cpu_class_by_name(typename, model_pieces[0]);
     if (oc =3D=3D NULL) {
-        g_free(str);
+        g_strfreev(model_pieces);
         return NULL;
     }
=20
     cc =3D CPU_CLASS(oc);
-    featurestr =3D strtok(NULL, ",");
     /* TODO: all callers of cpu_generic_init() need to be converted to
      * call parse_features() only once, before calling cpu_generic_init(=
).
      */
-    cc->parse_features(object_class_get_name(oc), featurestr, &err);
-    g_free(str);
+    cc->parse_features(object_class_get_name(oc), model_pieces[1], &err)=
;
+    g_strfreev(model_pieces);
     if (err !=3D NULL) {
         goto out;
     }
--=20
2.13.5
