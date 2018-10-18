Received: from eggs.gnu.org ([2001:4830:134:3::10]:39519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEZS-0000s7-Mj
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEZR-00022M-Se
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:07:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:03:57 -0300
Message-Id: <20181018200422.4358-21-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/45] memory-device: improve "range conflicts"
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Handle id=3D=3DNULL better and indicate that we are dealing with memory
devices.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181005092024.14344-4-david@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/mem/memory-device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 7c706fadfc..0624184c40 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -175,7 +175,8 @@ uint64_t memory_device_get_free_addr(MachineState *ms=
, const uint64_t *hint,
         if (ranges_overlap(md_addr, md_size, new_addr, size)) {
             if (hint) {
                 const DeviceState *d =3D DEVICE(md);
-                error_setg(errp, "address range conflicts with '%s'", d-=
>id);
+                error_setg(errp, "address range conflicts with memory de=
vice"
+                           " id=3D'%s'", d->id ? d->id : "(unnamed)");
                 goto out;
             }
             new_addr =3D QEMU_ALIGN_UP(md_addr + md_size, align);
--=20
2.18.0.rc1.1.g3f1ff2140
