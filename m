Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1e0AVG-0002jl-DP
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1e0AVC-0004iu-Ee
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:04:10 -0400
Received: from mailpro.odiso.net ([89.248.211.110]:60438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1e0AVC-0004bO-7g
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:04:06 -0400
Date: Thu, 5 Oct 2017 20:03:35 +0200 (CEST)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <1275246042.1286537.1507226615699.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <20170920060933.11593-1-w.bumiller@proxmox.com>
References: <20170920060933.11593-1-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: fix descriptor counting in
 virtqueue_pop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: pbonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>

Hi,

has somebody reviewed this patch ?

I'm also able de reproduce the vm crash like the proxmox user.
This patch is fixing it for me too.

Regards,

Alexandre


----- Mail original -----
De: "Wolfgang Bumiller" <w.bumiller@proxmox.com>
=C3=80: "qemu-devel" <qemu-devel@nongnu.org>
Cc: "pbonzini" <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Envoy=C3=A9: Mercredi 20 Septembre 2017 08:09:33
Objet: [Qemu-devel] [PATCH] virtio: fix descriptor counting in virtqueue_po=
p

While changing the s/g list allocation, commit 3b3b0628=20
also changed the descriptor counting to count iovec entries=20
as split by cpu_physical_memory_map(). Previously only the=20
actual descriptor entries were counted and the split into=20
the iovec happened afterwards in virtqueue_map().=20
Count the entries again instead to avoid erroneous=20
"Looped descriptor" errors.=20

Reported-by: Hans Middelhoek <h.middelhoek@ospito.nl>=20
Link: https://forum.proxmox.com/threads/vm-crash-with-memory-hotplug.35904/=
=20
Fixes: 3b3b0628217e ("virtio: slim down allocation of VirtQueueElements")=
=20
Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>=20
---=20
hw/virtio/virtio.c | 6 +++---=20
1 file changed, 3 insertions(+), 3 deletions(-)=20

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c=20
index 890b4d7eb7..33bb770177 100644=20
--- a/hw/virtio/virtio.c=20
+++ b/hw/virtio/virtio.c=20
@@ -834,7 +834,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)=20
int64_t len;=20
VirtIODevice *vdev =3D vq->vdev;=20
VirtQueueElement *elem =3D NULL;=20
- unsigned out_num, in_num;=20
+ unsigned out_num, in_num, elem_entries;=20
hwaddr addr[VIRTQUEUE_MAX_SIZE];=20
struct iovec iov[VIRTQUEUE_MAX_SIZE];=20
VRingDesc desc;=20
@@ -852,7 +852,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)=20
smp_rmb();=20

/* When we start there are none of either input nor output. */=20
- out_num =3D in_num =3D 0;=20
+ out_num =3D in_num =3D elem_entries =3D 0;=20

max =3D vq->vring.num;=20

@@ -922,7 +922,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)=20
}=20

/* If we've got too many, that implies a descriptor loop. */=20
- if ((in_num + out_num) > max) {=20
+ if (++elem_entries > max) {=20
virtio_error(vdev, "Looped descriptor");=20
goto err_undo_map;=20
}=20
--=20
2.11.0=20
