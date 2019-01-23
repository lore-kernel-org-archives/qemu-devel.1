Received: from eggs.gnu.org ([209.51.188.92]:34720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZh-0001g8-TZ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZf-0007RB-QJ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:01 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:48 +0100
Message-Id: <20190123101458.12478-9-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 08/18] vl: Set machine ram_size,
 maxram_size and ram_slots earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

The machine RAM attributes will need to be analyzed during the
configure_accelerator() process. especially kvm_type() arm64
machine callback will use them to know how many IPA/GPA bits are
needed to model the whole RAM range. So let's assign those machine
state fields before calling configure_accelerator.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v4: new
---
 vl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index bc9fbec654..844267201e 100644
--- a/vl.c
+++ b/vl.c
@@ -4321,6 +4321,9 @@ int main(int argc, char **argv, char **envp)
     machine_opts =3D qemu_get_machine_opts();
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine=
,
                      &error_fatal);
+    current_machine->ram_size =3D ram_size;
+    current_machine->maxram_size =3D maxram_size;
+    current_machine->ram_slots =3D ram_slots;
=20
     configure_accelerator(current_machine, argv[0]);
=20
@@ -4518,9 +4521,6 @@ int main(int argc, char **argv, char **envp)
     replay_checkpoint(CHECKPOINT_INIT);
     qdev_machine_init();
=20
-    current_machine->ram_size =3D ram_size;
-    current_machine->maxram_size =3D maxram_size;
-    current_machine->ram_slots =3D ram_slots;
     current_machine->boot_order =3D boot_order;
=20
     /* parse features once if machine provides default cpu_type */
--=20
2.20.1
