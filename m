Received: from eggs.gnu.org ([2001:4830:134:3::10]:37688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVL-00031J-3D
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVI-0005rh-FY
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHZVI-0005jU-6L
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 612073DD47
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 19:16:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Oct 2018 20:16:20 +0100
Message-Id: <20181030191620.32168-9-armbru@redhat.com>
In-Reply-To: <20181030191620.32168-1-armbru@redhat.com>
References: <20181030191620.32168-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/8] vl: Avoid crash when -mon is underspecified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

A quick coredump on an incomplete command line:
./x86_64-softmmu/qemu-system-x86_64 -mon mode=3Dcontrol,pretty=3Don

 #0  0x00007ffff723d9e4 in g_str_hash () at /lib64/libglib-2.0.so.0
 #1  0x00007ffff723ce38 in g_hash_table_lookup () at /lib64/libglib-2.0.s=
o.0
 #2  0x0000555555cc0073 in object_class_property_find (klass=3D0x5555566a=
94b0, name=3D0x0, errp=3D0x0) at qom/object.c:1135
 #3  0x0000555555cc004b in object_class_property_find (klass=3D0x5555566a=
9440, name=3D0x0, errp=3D0x0) at qom/object.c:1129
 #4  0x0000555555cbfe6e in object_property_find (obj=3D0x5555568348c0, na=
me=3D0x0, errp=3D0x0) at qom/object.c:1080
 #5  0x0000555555cc183d in object_resolve_path_component (parent=3D0x5555=
568348c0, part=3D0x0) at qom/object.c:1762
 #6  0x0000555555d82071 in qemu_chr_find (name=3D0x0) at chardev/char.c:8=
02
 #7  0x00005555559d77cb in mon_init_func (opaque=3D0x0, opts=3D0x5555566b=
65a0, errp=3D0x0) at vl.c:2291

Fix it to instead fail gracefully.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181023213600.364086-1-eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/vl.c b/vl.c
index 7d9bcf442e..0a5cc9aa75 100644
--- a/vl.c
+++ b/vl.c
@@ -2318,6 +2318,10 @@ static int mon_init_func(void *opaque, QemuOpts *o=
pts, Error **errp)
         flags |=3D MONITOR_USE_PRETTY;
=20
     chardev =3D qemu_opt_get(opts, "chardev");
+    if (!chardev) {
+        error_report("chardev is required");
+        exit(1);
+    }
     chr =3D qemu_chr_find(chardev);
     if (chr =3D=3D NULL) {
         error_setg(errp, "chardev \"%s\" not found", chardev);
--=20
2.17.2
