Received: from eggs.gnu.org ([2001:4830:134:3::10]:57903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eI4BD-0001fw-M2
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 21:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eI4B8-0001Kl-Nn
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 21:57:27 -0500
References: <1511408266-4139-1-git-send-email-jasowang@redhat.com>
	<20171123105934.GC26022@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7c6f12d7-8670-2a7b-0e9a-6f6c0ec92759@redhat.com>
Date: Fri, 24 Nov 2017 10:57:11 +0800
MIME-Version: 1.0
In-Reply-To: <20171123105934.GC26022@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.11] virtio-net: don't touch virtqueue
 if vm is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com



On 2017=E5=B9=B411=E6=9C=8823=E6=97=A5 18:59, Stefan Hajnoczi wrote:
> On Thu, Nov 23, 2017 at 11:37:46AM +0800, Jason Wang wrote:
>> Guest state should not be touched if VM is stopped, unfortunately we
>> didn't check running state and tried to drain tx queue unconditionally
>> in virtio_net_set_status(). A crash was then noticed as a migration
>> destination when user type quit after virtqueue state is loaded but
>> before region cache is initialized. In this case,
>> virtio_net_drop_tx_queue_data() tries to access the uninitialized
>> region cache.
>>
>> Fix this by only dropping tx queue data when vm is running.
> hw/virtio/virtio.c:virtio_load() does the following:
>
>    for (i =3D 0; i < num; i++) {
>        if (vdev->vq[i].vring.desc) {
>            uint16_t nheads;
>
>            /*
>             * VIRTIO-1 devices migrate desc, used, and avail ring addre=
sses so
>             * only the region cache needs to be set up.  Legacy devices=
 need
>             * to calculate used and avail ring addresses based on the d=
esc
>             * address.
>             */
>            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>                virtio_init_region_cache(vdev, i);
>            } else {
>                virtio_queue_update_rings(vdev, i);
>            }
>
> So the region caches should be initialized after virtqueue state is
> loaded.
>
> It's unclear to me which code path triggers this issue.  Can you add a
> backtrace or an explanation?
>
> Thanks,
> Stefan

Migration coroutine was yield before region cache was initialized. The=20
backtrace looks like:

#0=C2=A0 qio_channel_yield (ioc=3D0x55555758d000, condition=3DG_IO_IN) at=
=20
io/channel.c:432
#1=C2=A0 0x0000555555b209c3 in channel_get_buffer (opaque=3D0x55555758d00=
0,=20
buf=3D0x555556f7c048 "", pos=3D1657701385, size=3D32768)
 =C2=A0=C2=A0=C2=A0 at migration/qemu-file-channel.c:83
#2=C2=A0 0x0000555555b1f4a3 in qemu_fill_buffer (f=3D0x555556f7c010) at=20
migration/qemu-file.c:293
#3=C2=A0 0x0000555555b1fd42 in qemu_peek_byte (f=3D0x555556f7c010, offset=
=3D0) at=20
migration/qemu-file.c:553
#4=C2=A0 0x0000555555b1fd94 in qemu_get_byte (f=3D0x555556f7c010) at=20
migration/qemu-file.c:566
#5=C2=A0 0x0000555555b1ffef in qemu_get_be32 (f=3D0x555556f7c010) at=20
migration/qemu-file.c:646
#6=C2=A0 0x0000555555b1d002 in qemu_get_be32s (f=3D0x555556f7c010,=20
pv=3D0x555557d6578c) at=20
/home/devel/git/qemu/include/migration/qemu-file-types.h:78
#7=C2=A0 0x0000555555b1da0d in get_uint32 (f=3D0x555556f7c010,=20
pv=3D0x555557d6578c, size=3D4, field=3D0x555556503ea0 <__compound_literal=
.0+416>)
 =C2=A0=C2=A0=C2=A0 at migration/vmstate-types.c:241
#8=C2=A0 0x0000555555b1c0b5 in vmstate_load_state (f=3D0x555556f7c010,=20
vmsd=3D0x555556375b60 <vmstate_virtio_pci_modern_queue_state>,=20
opaque=3D0x555557d6577c,
 =C2=A0=C2=A0=C2=A0 version_id=3D1) at migration/vmstate.c:140
#9=C2=A0 0x0000555555b1c090 in vmstate_load_state (f=3D0x555556f7c010,=20
vmsd=3D0x555556375bc0 <vmstate_virtio_pci_modern_state_sub>,=20
opaque=3D0x555557d604a0,
 =C2=A0=C2=A0=C2=A0 version_id=3D1) at migration/vmstate.c:137
#10 0x0000555555b1cce5 in vmstate_subsection_load (f=3D0x555556f7c010,=20
vmsd=3D0x555556375c20 <vmstate_virtio_pci>, opaque=3D0x555557d604a0)
 =C2=A0=C2=A0=C2=A0 at migration/vmstate.c:453
#11 0x0000555555b1c199 in vmstate_load_state (f=3D0x555556f7c010,=20
vmsd=3D0x555556375c20 <vmstate_virtio_pci>, opaque=3D0x555557d604a0,=20
version_id=3D1)
 =C2=A0=C2=A0=C2=A0 at migration/vmstate.c:160
#12 0x0000555555b00aa0 in virtio_pci_load_extra_state (d=3D0x555557d604a0=
,=20
f=3D0x555556f7c010) at hw/virtio/virtio-pci.c:161
#13 0x00005555558651ab in get_extra_state (f=3D0x555556f7c010,=20
pv=3D0x555557d68610, size=3D0, field=3D0x5555563cd0e0 <__compound_literal=
.4>)
 =C2=A0=C2=A0=C2=A0 at /home/devel/git/qemu/hw/virtio/virtio.c:1808
#14 0x0000555555b1c0b5 in vmstate_load_state (f=3D0x555556f7c010,=20
vmsd=3D0x5555562b7fe0 <vmstate_virtio_extra_state>, opaque=3D0x555557d686=
10,=20
version_id=3D1)
 =C2=A0=C2=A0=C2=A0 at migration/vmstate.c:140
#15 0x0000555555b1cce5 in vmstate_subsection_load (f=3D0x555556f7c010,=20
vmsd=3D0x5555562b8160 <vmstate_virtio>, opaque=3D0x555557d68610)
 =C2=A0=C2=A0=C2=A0 at migration/vmstate.c:453
#16 0x0000555555b1c199 in vmstate_load_state (f=3D0x555556f7c010,=20
vmsd=3D0x5555562b8160 <vmstate_virtio>, opaque=3D0x555557d68610, version_=
id=3D1)
 =C2=A0=C2=A0=C2=A0 at migration/vmstate.c:160
#17 0x0000555555865cc3 in virtio_load (vdev=3D0x555557d68610,=20
f=3D0x555556f7c010, version_id=3D11) at=20
/home/devel/git/qemu/hw/virtio/virtio.c:2110
#18 0x0000555555865705 in virtio_device_get (f=3D0x555556f7c010,=20
opaque=3D0x555557d68610, size=3D0, field=3D0x5555563ca4a0 <__compound_lit=
eral.5>)
 =C2=A0=C2=A0=C2=A0 at /home/devel/git/qemu/hw/virtio/virtio.c:1974
#19 0x0000555555b1c0b5 in vmstate_load_state (f=3D0x555556f7c010,=20
vmsd=3D0x5555562b6ae0 <vmstate_virtio_net>, opaque=3D0x555557d68610,=20
version_id=3D11)
 =C2=A0=C2=A0=C2=A0 at migration/vmstate.c:140
#20 0x0000555555b15d20 in vmstate_load (f=3D0x555556f7c010,=20
se=3D0x555557e81400) at migration/savevm.c:748
#21 0x0000555555b1827b in qemu_loadvm_section_start_full=20
(f=3D0x555556f7c010, mis=3D0x555556564a40 <mis_current>) at=20
migration/savevm.c:1903
#22 0x0000555555b185d5 in qemu_loadvm_state_main (f=3D0x555556f7c010,=20
mis=3D0x555556564a40 <mis_current>) at migration/savevm.c:1998
#23 0x0000555555b187fc in qemu_loadvm_state (f=3D0x555556f7c010) at=20
migration/savevm.c:2077
#24 0x0000555555b0c0af in process_incoming_migration_co (opaque=3D0x0) at=
=20
migration/migration.c:327
#25 0x0000555555cc1d06 in coroutine_trampoline (i0=3D1469933216, i1=3D218=
45)=20
at util/coroutine-ucontext.c:79
#26 0x00007ffff39d95d0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#27 0x00007fffffffd2f0 in ?? ()
#28 0x0000000000000000 in ?? ()
