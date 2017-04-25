Received: from eggs.gnu.org ([2001:4830:134:3::10]:45962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2zB7-0000se-EQ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2zB4-0002v7-OI
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:02:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2zB4-0002ur-Eq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:02:42 -0400
References: <34EFBCA9F01B0748BEB6B629CE643AE60BB3AC7D@DGGEMA505-MBS.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <766978f5-8eae-7293-8fb4-2a7a568d301f@redhat.com>
Date: Tue, 25 Apr 2017 20:02:23 +0800
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60BB3AC7D@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [BUG] QEMU crashes with dpdk virtio pmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangyunjian <wangyunjian@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: caihe <caihe@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>



On 2017=E5=B9=B404=E6=9C=8825=E6=97=A5 19:37, wangyunjian wrote:
> The q->tx_bh will free in virtio_net_del_queue() function, when remove =
virtio queues
> if the guest doesn't support multiqueue. But it might be still referenc=
ed by others (eg . virtio_net_set_status()),
> which need so set NULL.
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7d091c9..98bd683 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1522,9 +1522,12 @@ static void virtio_net_del_queue(VirtIONet *n, i=
nt index)
>       if (q->tx_timer) {
>           timer_del(q->tx_timer);
>           timer_free(q->tx_timer);
> +        q->tx_timer =3D NULL;
>       } else {
>           qemu_bh_delete(q->tx_bh);
> +        q->tx_bh =3D NULL;
>       }
> +    q->tx_waiting =3D 0;
>       virtio_del_queue(vdev, index * 2 + 1);
>   }

Thanks a lot for the fix.

Two questions:

- If virtio_net_set_status() is the only function that may access tx_bh,=20
it looks like setting tx_waiting to zero is sufficient?
- Can you post a formal patch for this?

Thanks

> From: wangyunjian
> Sent: Monday, April 24, 2017 6:10 PM
> To: qemu-devel@nongnu.org; Michael S. Tsirkin <mst@redhat.com>; 'Jason =
Wang' <jasowang@redhat.com>
> Cc: wangyunjian <wangyunjian@huawei.com>; caihe <caihe@huawei.com>
> Subject: [Qemu-devel][BUG] QEMU crashes with dpdk virtio pmd
>
> Qemu crashes, with pre-condition:
> vm xml config with multiqueue, and the vm's driver virtio-net support m=
ulti-queue
>
> reproduce steps:
> i. start dpdk testpmd in VM with the virtio nic
> ii. stop testpmd
> iii. reboot the VM
>
> This commit "f9d6dbf0  remove virtio queues if the guest doesn't suppor=
t multiqueue" is introduced.
>
> Qemu version: QEMU emulator version 2.9.50 (v2.9.0-137-g32c7e0a)
> VM DPDK version:  DPDK-1.6.1
>
> Call Trace:
> #0  0x00007f60881fe5d7 in raise () from /usr/lib64/libc.so.6
> #1  0x00007f60881ffcc8 in abort () from /usr/lib64/libc.so.6
> #2  0x00007f608823e2f7 in __libc_message () from /usr/lib64/libc.so.6
> #3  0x00007f60882456d3 in _int_free () from /usr/lib64/libc.so.6
> #4  0x00007f608900158f in g_free () from /usr/lib64/libglib-2.0.so.0
> #5  0x00007f6088fea32c in iter_remove_or_steal () from /usr/lib64/libgl=
ib-2.0.so.0
> #6  0x00007f608edc0986 in object_property_del_all (obj=3D0x7f6091e74800=
) at qom/object.c:410
> #7  object_finalize (data=3D0x7f6091e74800) at qom/object.c:467
> #8  object_unref (obj=3Dobj@entry=3D0x7f6091e74800) at qom/object.c:903
> #9  0x00007f608eaf1fd3 in phys_section_destroy (mr=3D0x7f6091e74800) at=
 git/qemu/exec.c:1154
> #10 phys_sections_free (map=3D0x7f6090b72bb0) at git/qemu/exec.c:1163
> #11 address_space_dispatch_free (d=3D0x7f6090b72b90) at git/qemu/exec.c=
:2514
> #12 0x00007f608ee91ace in call_rcu_thread (opaque=3D<optimized out>) at=
 util/rcu.c:272
> #13 0x00007f6089b0ddc5 in start_thread () from /usr/lib64/libpthread.so=
.0
> #14 0x00007f60882bf71d in clone () from /usr/lib64/libc.so.6
>
> Call Trace:
> #0  0x00007fdccaeb9790 in ?? ()
> #1  0x00007fdcd82d09fc in object_property_del_all (obj=3D0x7fdcdb8acf60=
) at qom/object.c:405
> #2  object_finalize (data=3D0x7fdcdb8acf60) at qom/object.c:467
> #3  object_unref (obj=3Dobj@entry=3D0x7fdcdb8acf60) at qom/object.c:903
> #4  0x00007fdcd8001fd3 in phys_section_destroy (mr=3D0x7fdcdb8acf60) at=
 git/qemu/exec.c:1154
> #5  phys_sections_free (map=3D0x7fdcdc86aa00) at git/qemu/exec.c:1163
> #6  address_space_dispatch_free (d=3D0x7fdcdc86a9e0) at git/qemu/exec.c=
:2514
> #7  0x00007fdcd83a1ace in call_rcu_thread (opaque=3D<optimized out>) at=
 util/rcu.c:272
> #8  0x00007fdcd301ddc5 in start_thread () from /usr/lib64/libpthread.so=
.0
> #9  0x00007fdcd17cf71d in clone () from /usr/lib64/libc.so.6
>
>
