Received: from eggs.gnu.org ([2001:4830:134:3::10]:39824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d2ynV-0007mU-Rh
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d2ynR-0007tj-M1
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:38:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3909
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d2ynR-0007p5-2D
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:38:17 -0400
From: wangyunjian <wangyunjian@huawei.com>
Date: Tue, 25 Apr 2017 11:37:53 +0000
Message-ID: <34EFBCA9F01B0748BEB6B629CE643AE60BB3AC7D@DGGEMA505-MBS.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [BUG] QEMU crashes with dpdk virtio pmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, caihe <caihe@huawei.com>, wangyunjian <wangyunjian@huawei.com>

The q->tx_bh will free in virtio_net_del_queue() function, when remove virt=
io queues=20
if the guest doesn't support multiqueue. But it might be still referenced b=
y others (eg . virtio_net_set_status()),
which need so set NULL.

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7d091c9..98bd683 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1522,9 +1522,12 @@ static void virtio_net_del_queue(VirtIONet *n, int i=
ndex)
     if (q->tx_timer) {
         timer_del(q->tx_timer);
         timer_free(q->tx_timer);
+        q->tx_timer =3D NULL;
     } else {
         qemu_bh_delete(q->tx_bh);
+        q->tx_bh =3D NULL;
     }
+    q->tx_waiting =3D 0;
     virtio_del_queue(vdev, index * 2 + 1);
 }

From: wangyunjian=20
Sent: Monday, April 24, 2017 6:10 PM
To: qemu-devel@nongnu.org; Michael S. Tsirkin <mst@redhat.com>; 'Jason Wang=
' <jasowang@redhat.com>
Cc: wangyunjian <wangyunjian@huawei.com>; caihe <caihe@huawei.com>
Subject: [Qemu-devel][BUG] QEMU crashes with dpdk virtio pmd=20

Qemu crashes, with pre-condition:
vm xml config with multiqueue, and the vm's driver virtio-net support multi=
-queue

reproduce steps:
i. start dpdk testpmd in VM with the virtio nic
ii. stop testpmd
iii. reboot the VM

This commit "f9d6dbf0=A0 remove virtio queues if the guest doesn't support =
multiqueue" is introduced.

Qemu version: QEMU emulator version 2.9.50 (v2.9.0-137-g32c7e0a)
VM DPDK version: =A0DPDK-1.6.1

Call Trace:
#0=A0 0x00007f60881fe5d7 in raise () from /usr/lib64/libc.so.6
#1=A0 0x00007f60881ffcc8 in abort () from /usr/lib64/libc.so.6
#2=A0 0x00007f608823e2f7 in __libc_message () from /usr/lib64/libc.so.6
#3=A0 0x00007f60882456d3 in _int_free () from /usr/lib64/libc.so.6
#4=A0 0x00007f608900158f in g_free () from /usr/lib64/libglib-2.0.so.0
#5=A0 0x00007f6088fea32c in iter_remove_or_steal () from /usr/lib64/libglib=
-2.0.so.0
#6=A0 0x00007f608edc0986 in object_property_del_all (obj=3D0x7f6091e74800) =
at qom/object.c:410
#7=A0 object_finalize (data=3D0x7f6091e74800) at qom/object.c:467
#8=A0 object_unref (obj=3Dobj@entry=3D0x7f6091e74800) at qom/object.c:903
#9=A0 0x00007f608eaf1fd3 in phys_section_destroy (mr=3D0x7f6091e74800) at g=
it/qemu/exec.c:1154
#10 phys_sections_free (map=3D0x7f6090b72bb0) at git/qemu/exec.c:1163
#11 address_space_dispatch_free (d=3D0x7f6090b72b90) at git/qemu/exec.c:251=
4
#12 0x00007f608ee91ace in call_rcu_thread (opaque=3D<optimized out>) at uti=
l/rcu.c:272
#13 0x00007f6089b0ddc5 in start_thread () from /usr/lib64/libpthread.so.0
#14 0x00007f60882bf71d in clone () from /usr/lib64/libc.so.6

Call Trace:
#0=A0 0x00007fdccaeb9790 in ?? ()
#1=A0 0x00007fdcd82d09fc in object_property_del_all (obj=3D0x7fdcdb8acf60) =
at qom/object.c:405
#2=A0 object_finalize (data=3D0x7fdcdb8acf60) at qom/object.c:467
#3=A0 object_unref (obj=3Dobj@entry=3D0x7fdcdb8acf60) at qom/object.c:903
#4=A0 0x00007fdcd8001fd3 in phys_section_destroy (mr=3D0x7fdcdb8acf60) at g=
it/qemu/exec.c:1154
#5=A0 phys_sections_free (map=3D0x7fdcdc86aa00) at git/qemu/exec.c:1163
#6=A0 address_space_dispatch_free (d=3D0x7fdcdc86a9e0) at git/qemu/exec.c:2=
514
#7=A0 0x00007fdcd83a1ace in call_rcu_thread (opaque=3D<optimized out>) at u=
til/rcu.c:272
#8=A0 0x00007fdcd301ddc5 in start_thread () from /usr/lib64/libpthread.so.0
#9=A0 0x00007fdcd17cf71d in clone () from /usr/lib64/libc.so.6
