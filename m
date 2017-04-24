Received: from eggs.gnu.org ([2001:4830:134:3::10]:34921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d2awv-0007wo-MU
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d2awq-0005rm-NK
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:10:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3518
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d2awp-0005rI-PX
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:10:24 -0400
From: wangyunjian <wangyunjian@huawei.com>
Date: Mon, 24 Apr 2017 10:10:05 +0000
Message-ID: <34EFBCA9F01B0748BEB6B629CE643AE60BB38A97@DGGEMA505-MBS.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [BUG] QEMU crashes with dpdk virtio pmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: wangyunjian <wangyunjian@huawei.com>, caihe <caihe@huawei.com>

Qemu crashes, with pre-condition:
vm xml config with multiqueue, and the vm's driver virtio-net support multi=
-queue

reproduce steps:
i. start dpdk testpmd in VM with the virtio nic
ii. stop testpmd
iii. reboot the VM

This commit "f9d6dbf0  remove virtio queues if the guest doesn't support mu=
ltiqueue" is introduced.

Qemu version: QEMU emulator version 2.9.50 (v2.9.0-137-g32c7e0a)
VM DPDK version:  DPDK-1.6.1

Call Trace:
#0  0x00007f60881fe5d7 in raise () from /usr/lib64/libc.so.6
#1  0x00007f60881ffcc8 in abort () from /usr/lib64/libc.so.6
#2  0x00007f608823e2f7 in __libc_message () from /usr/lib64/libc.so.6
#3  0x00007f60882456d3 in _int_free () from /usr/lib64/libc.so.6
#4  0x00007f608900158f in g_free () from /usr/lib64/libglib-2.0.so.0
#5  0x00007f6088fea32c in iter_remove_or_steal () from /usr/lib64/libglib-2=
.0.so.0
#6  0x00007f608edc0986 in object_property_del_all (obj=3D0x7f6091e74800) at=
 qom/object.c:410
#7  object_finalize (data=3D0x7f6091e74800) at qom/object.c:467
#8  object_unref (obj=3Dobj@entry=3D0x7f6091e74800) at qom/object.c:903
#9  0x00007f608eaf1fd3 in phys_section_destroy (mr=3D0x7f6091e74800) at git=
/qemu/exec.c:1154
#10 phys_sections_free (map=3D0x7f6090b72bb0) at git/qemu/exec.c:1163
#11 address_space_dispatch_free (d=3D0x7f6090b72b90) at git/qemu/exec.c:251=
4
#12 0x00007f608ee91ace in call_rcu_thread (opaque=3D<optimized out>) at uti=
l/rcu.c:272
#13 0x00007f6089b0ddc5 in start_thread () from /usr/lib64/libpthread.so.0
#14 0x00007f60882bf71d in clone () from /usr/lib64/libc.so.6

Call Trace:
#0  0x00007fdccaeb9790 in ?? ()
#1  0x00007fdcd82d09fc in object_property_del_all (obj=3D0x7fdcdb8acf60) at=
 qom/object.c:405
#2  object_finalize (data=3D0x7fdcdb8acf60) at qom/object.c:467
#3  object_unref (obj=3Dobj@entry=3D0x7fdcdb8acf60) at qom/object.c:903
#4  0x00007fdcd8001fd3 in phys_section_destroy (mr=3D0x7fdcdb8acf60) at git=
/qemu/exec.c:1154
#5  phys_sections_free (map=3D0x7fdcdc86aa00) at git/qemu/exec.c:1163
#6  address_space_dispatch_free (d=3D0x7fdcdc86a9e0) at git/qemu/exec.c:251=
4
#7  0x00007fdcd83a1ace in call_rcu_thread (opaque=3D<optimized out>) at uti=
l/rcu.c:272
#8  0x00007fdcd301ddc5 in start_thread () from /usr/lib64/libpthread.so.0
#9  0x00007fdcd17cf71d in clone () from /usr/lib64/libc.so.6
