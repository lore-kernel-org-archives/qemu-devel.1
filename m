Received: from eggs.gnu.org ([209.51.188.92]:40839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvl-0005PQ-Rh
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvk-0004H7-Vg
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hAsvk-0004Gi-OM
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:36 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  1 Apr 2019 11:08:27 +0200
Message-Id: <20190401090827.20793-6-armbru@redhat.com>
In-Reply-To: <20190401090827.20793-1-armbru@redhat.com>
References: <20190401090827.20793-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/5] accel: Unbreak accelerator fallback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, kwolf@redhat.com, imammedo@redhat.com

When the user specifies a list of accelerators, we pick the first one
that initializes successfully.  Recent commit 1a3ec8c1564 broke that.
Reproducer:

    $ qemu-system-x86_64 --machine accel=3Dxen:tcg
    xencall: error: Could not obtain handle on privileged command interfa=
ce: No such file or directory
    xen be core: xen be core: can't open xen interface
    can't open xen interface
    qemu-system-x86_64: failed to initialize Xen: Operation not permitted
    qemu-system-x86_64: /home/armbru/work/qemu/qom/object.c:436: object_s=
et_accelerator_compat_props: Assertion `!object_compat_props[0]' failed.

Root cause: we register accelerator compat properties even when the
accelerator fails.  The failed assertion is
object_set_accelerator_compat_props() telling us off.  Fix by calling
it only for the accelerator that succeeded.

Fixes: 1a3ec8c1564f51628cce10d435a2e22559ea29fd
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 accel/accel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/accel.c b/accel/accel.c
index 8deb475b5d..454fef9d92 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -65,8 +65,9 @@ static int accel_init_machine(AccelClass *acc, MachineS=
tate *ms)
         ms->accelerator =3D NULL;
         *(acc->allowed) =3D false;
         object_unref(OBJECT(accel));
+    } else {
+        object_set_accelerator_compat_props(acc->compat_props);
     }
-    object_set_accelerator_compat_props(acc->compat_props);
     return ret;
 }
=20
--=20
2.17.2
