Received: from eggs.gnu.org ([209.51.188.92]:49407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghZ1m-0001Cn-Cf
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghZ1l-00005q-2p
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:38 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:46363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1ghZ1k-0008SH-97
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:36 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Thu, 10 Jan 2019 15:01:17 +0300
Message-Id: <20190110120120.9943-2-yury-kotov@yandex-team.ru>
In-Reply-To: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] migration: add RAMBlock's offset validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: wrfsh@yandex-team.ru

RAM migration has a RAMBlock validation stage (flag RAM_SAVE_FLAG_MEM_SIZ=
E).
In this stage QEMU checks further information about RAMBlock:
1. Presence (by idstr),
2. Length (trying to resize, when differs),
3. Optional page size.

This patch adds a check for RAMBlock's offset. Currently we check it duri=
ng
RAM pages loading - every RAM page has an offset in its header. But there=
 is a
case when we don't send RAM pages (see below).

The following commits introduce a capability (ignore-external) to skip so=
me
RAM blocks from migration. In such case the migration stream contains onl=
y
meta information about RAM blocks to validate them. So, the only way to c=
heck
block's offset is to send it explicitly.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/ram.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 7e7deec4d8..39629254e1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3171,6 +3171,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
         if (migrate_postcopy_ram() && block->page_size !=3D qemu_host_pa=
ge_size) {
             qemu_put_be64(f, block->page_size);
         }
+        qemu_put_be64(f, block->offset);
     }
=20
     rcu_read_unlock();
@@ -4031,7 +4032,7 @@ static int ram_load(QEMUFile *f, void *opaque, int =
version_id)
=20
     seq_iter++;
=20
-    if (version_id !=3D 4) {
+    if (version_id < 4) {
         ret =3D -EINVAL;
     }
=20
@@ -4132,6 +4133,16 @@ static int ram_load(QEMUFile *f, void *opaque, int=
 version_id)
                             ret =3D -EINVAL;
                         }
                     }
+                    if (version_id >=3D 5) {
+                        ram_addr_t offset;
+                        offset =3D qemu_get_be64(f);
+                        if (block->offset !=3D offset) {
+                            error_report("Mismatched RAM block offset %s=
 "
+                                         "%" PRId64 "!=3D %" PRId64,
+                                         id, offset, (uint64_t)block->of=
fset);
+                            ret =3D -EINVAL;
+                        }
+                    }
                     ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
                                           block->idstr);
                 } else {
@@ -4363,5 +4374,5 @@ static SaveVMHandlers savevm_ram_handlers =3D {
 void ram_mig_init(void)
 {
     qemu_mutex_init(&XBZRLE.lock);
-    register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, &ram_s=
tate);
+    register_savevm_live(NULL, "ram", 0, 5, &savevm_ram_handlers, &ram_s=
tate);
 }
--=20
2.20.1
