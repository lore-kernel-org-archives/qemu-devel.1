Received: from eggs.gnu.org ([2001:4830:134:3::10]:42884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKqUF-0005uF-My
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKqUA-0004fd-Mv
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:24:19 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKqUA-0004fT-Cc
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:24:14 -0400
Received: by mail-wr0-x233.google.com with SMTP id q97so155719684wrb.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 11:24:12 -0700 (PDT)
Date: Tue, 13 Jun 2017 19:24:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170613182408.GA27294@stefanha-x1.localdomain>
References: <1497350121-15256-1-git-send-email-gi-oh.kim@profitbricks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <1497350121-15256-1-git-send-email-gi-oh.kim@profitbricks.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio-blk: drain block before cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gioh Kim <gi-oh.kim@profitbricks.com>
Cc: pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 12:35:21PM +0200, Gioh Kim wrote:
> Hi,
>=20
> I'd like to report one use-after-free problem which is found by AddressSa=
nitizer.
> My company provides virtualization server with Qemu-2.7.
> If customer commands Disk hot-unplug on Web-based application,
> the application sends "device_del" and "drive_del" commands to qemu proce=
ss via QMP.
> It usually works fine.
> But I found a corner case like following.
> 1. Customer commands Disk hot-unplug via Web-based application.
> 2. The application sends "device_del" that sometimes takes unpredictable =
time.
> 3. There are some inflight IOs
> 4. Customer does reboot or shutdown the guest OS
> 4. Qemu process generates segfault.
>=20
> If a disk is unplugged with "device_del" and "drive_del" commands,
> qemu does not generate problem. But if only "device_del" command are fini=
shed and
> guest os reboots, qemu generates segfault.
> I can reproduce that case easily with following commands
> 1. generate heavy IO on disk in Guest OS
> 2. run "device_del" on the qemu monitor
> 3. run "system_reboot" on the qemu monitor
>=20
> According to AdressSanitizer, VirtQueue is freed by virtio_cleanup but de=
referenced
> by asynchronous request. I think asynchronous requests should be finished
> before virtio_cleanup, so I added blk_drain() before virtio_cleanup.
>=20
> Following is configure options I used to build qemu with AddressSanitizer.
> ./configure --target-list=3Dx86_64-softmmu --extra-cflags=3D"-fsanitize=
=3Daddress -fno-omit-frame-pointer" --enable-debug
>=20
> Following is the report of AddressSanitizer.
>=20
> ------------------------------------- 8< --------------------------------=
--------
> =3D=3D8801=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> =3D=3D8801=3D=3DWARNING: ASan is ignoring requested __asan_handle_no_retu=
rn: stack top: 0x7ffc984da000; bottom 0x7fa524363000; size: 0x005774177000 =
(375609847808)
> False positive error reports may follow
> For details see http://code.google.com/p/address-sanitizer/issues/detail?=
id=3D189
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D8801=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0=
x7fa5240ab82c at pc 0x55ccd7bffb76 bp 0x7fa524364590 sp 0x7fa524364580
> READ of size 2 at 0x7fa5240ab82c thread T0
>     #0 0x55ccd7bffb75 in virtqueue_fill /home/gohkim/work/tools/qemu/hw/v=
irtio/virtio.c:284
>     #1 0x55ccd7bffe46 in virtqueue_push /home/gohkim/work/tools/qemu/hw/v=
irtio/virtio.c:308
>     #2 0x55ccd7b66c74 in virtio_blk_req_complete /home/gohkim/work/tools/=
qemu/hw/block/virtio-blk.c:58
>     #3 0x55ccd7b67154 in virtio_blk_rw_complete /home/gohkim/work/tools/q=
emu/hw/block/virtio-blk.c:121
>     #4 0x55ccd83852b9 in blk_aio_complete block/block-backend.c:923
>     #5 0x55ccd8385a73 in blk_aio_write_entry block/block-backend.c:984
>     #6 0x55ccd84c7d68 in coroutine_trampoline util/coroutine-ucontext.c:78
>     #7 0x7fa5702d45cf  (/lib/x86_64-linux-gnu/libc.so.6+0x495cf)
>=20
> 0x7fa5240ab82c is located 44 bytes inside of 131072-byte region [0x7fa524=
0ab800,0x7fa5240cb800)
> freed by thread T0 here:
>     #0 0x7fa573f876aa in __interceptor_free (/usr/lib/x86_64-linux-gnu/li=
basan.so.2+0x986aa)
>     #1 0x55ccd7c07fa4 in virtio_cleanup /home/gohkim/work/tools/qemu/hw/v=
irtio/virtio.c:1678
>     #2 0x55ccd7b6c585 in virtio_blk_device_unrealize /home/gohkim/work/to=
ols/qemu/hw/block/virtio-blk.c:948
>     #3 0x55ccd7c09734 in virtio_device_unrealize /home/gohkim/work/tools/=
qemu/hw/virtio/virtio.c:1950
>     #4 0x55ccd7eb9bb7 in device_set_realized hw/core/qdev.c:964
>     #5 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #6 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #7 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #8 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #9 0x55ccd7ec1395 in bus_set_realized hw/core/bus.c:181
>     #10 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #11 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #12 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #13 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #14 0x55ccd7eb9a8a in device_set_realized hw/core/qdev.c:956
>     #15 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #16 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #17 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #18 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #19 0x55ccd7eba820 in device_unparent hw/core/qdev.c:1099
>     #20 0x55ccd82bf50b in object_finalize_child_property qom/object.c:1362
>     #21 0x55ccd82bb3c6 in object_property_del_child qom/object.c:422
>     #22 0x55ccd82bb601 in object_unparent qom/object.c:441
>     #23 0x55ccd7e221f1 in acpi_pcihp_eject_slot hw/acpi/pcihp.c:139
>     #24 0x55ccd7e22301 in acpi_pcihp_update_hotplug_bus hw/acpi/pcihp.c:1=
52
>     #25 0x55ccd7e22600 in acpi_pcihp_update hw/acpi/pcihp.c:176
>     #26 0x55ccd7e22628 in acpi_pcihp_reset hw/acpi/pcihp.c:182
>     #27 0x55ccd7e1fc10 in piix4_reset hw/acpi/piix4.c:363
>     #28 0x55ccd7da4ebd in qemu_devices_reset /home/gohkim/work/tools/qemu=
/vl.c:1713
>     #29 0x55ccd7c28354 in pc_machine_reset /home/gohkim/work/tools/qemu/h=
w/i386/pc.c:2178
>=20
> previously allocated by thread T0 here:
>     #0 0x7fa573f87b49 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/=
libasan.so.2+0x98b49)
>     #1 0x7fa5718575d0 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.=
0+0x4f5d0)
>     #2 0x55ccd7b6bfa5 in virtio_blk_device_realize /home/gohkim/work/tool=
s/qemu/hw/block/virtio-blk.c:910
>     #3 0x55ccd7c09500 in virtio_device_realize /home/gohkim/work/tools/qe=
mu/hw/virtio/virtio.c:1927
>     #4 0x55ccd7eb9690 in device_set_realized hw/core/qdev.c:918
>     #5 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #6 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #7 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #8 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #9 0x55ccd81b1b5c in virtio_blk_pci_realize hw/virtio/virtio-pci.c:18=
97
>     #10 0x55ccd81b14df in virtio_pci_realize hw/virtio/virtio-pci.c:1799
>     #11 0x55ccd805e2c5 in pci_qdev_realize hw/pci/pci.c:1966
>     #12 0x55ccd81b17db in virtio_pci_dc_realize hw/virtio/virtio-pci.c:18=
52
>     #13 0x55ccd7eb9690 in device_set_realized hw/core/qdev.c:918
>     #14 0x55ccd82c1bef in property_set_bool qom/object.c:1853
>     #15 0x55ccd82be535 in object_property_set qom/object.c:1087
>     #16 0x55ccd82c454f in object_property_set_qobject qom/qom-qobject.c:27
>     #17 0x55ccd82be810 in object_property_set_bool qom/object.c:1156
>     #18 0x55ccd7d8141e in qdev_device_add /home/gohkim/work/tools/qemu/qd=
ev-monitor.c:618
>     #19 0x55ccd7dab462 in device_init_func /home/gohkim/work/tools/qemu/v=
l.c:2316
>     #20 0x55ccd84bd18c in qemu_opts_foreach util/qemu-option.c:1116
>     #21 0x55ccd7db2bdb in main /home/gohkim/work/tools/qemu/vl.c:4507
>     #22 0x7fa5702ababf in __libc_start_main (/lib/x86_64-linux-gnu/libc.s=
o.6+0x20abf)
>=20
> SUMMARY: AddressSanitizer: heap-use-after-free /home/gohkim/work/tools/qe=
mu/hw/virtio/virtio.c:284 virtqueue_fill
> Shadow bytes around the buggy address:
>   0x0ff52480d6b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ff52480d6c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ff52480d6d0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ff52480d6e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ff52480d6f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> =3D>0x0ff52480d700: fd fd fd fd fd[fd]fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d710: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d720: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d730: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d740: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   0x0ff52480d750: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Heap right redzone:      fb
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack partial redzone:   f4
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
> =3D=3D8801=3D=3DABORTING
>=20
> [v1]: add braces to fix style error
>=20
> Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> ---
>  hw/block/virtio-blk.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 331d766..75b56ed 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -939,6 +939,9 @@ static void virtio_blk_device_unrealize(DeviceState *=
dev, Error **errp)
>      virtio_blk_data_plane_destroy(s->dataplane);
>      s->dataplane =3D NULL;
>      qemu_del_vm_change_state_handler(s->change);
> +    if (blk_bs(s->blk) && bdrv_requests_pending(blk_bs(s->blk))) {
> +        blk_drain(s->blk);
> +    }
>      blockdev_mark_auto_del(s->blk);
>      virtio_cleanup(vdev);
>  }

This is concerning because other storage controllers (virtio-scsi and
maybe non-virtio devices) may be affected too.

The null-co block driver can be used to artifically delay requests for
testing:

  -drive if=3Dvirtio,file.driver=3Dnull-co,file.read-zeroes=3Don,file.laten=
cy-ns=3D5000000000,format=3Draw

I'll try to reproduce your results tomorrow and look at the other
storage controllers.  Ideally we can fix the problem in a single place
instead of patching multiple emulated devices.

Stefan

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQC3IAAoJEJykq7OBq3PIAUgH/1dSVKOiwUI3MSrNHXB2asN1
K9V3oCqs1FCM9ryLt1UsTirYOWPSCm8yZsoL7cmemdvQvtJJePBEXubmvJJ9sWUe
u/qKnmeiNcryL558ss0MknqNEvcMz8sx7VQSjsbyA+xEZK83GqiW92Wv+6Xetx+w
TPKRYobUXj0MXXYC8G15HrskYVcYviFy3Hx+TaJz7THMUZUv/+1tk28dvzt8QBo9
AOSo2PRxG3rF1oe3fv/NXjqXc9Fy1jFbt5hwZBezoACCWcyneMHioeebk4qjLWnq
O9ibWoorKY71/frGPe0hyGXv9HqfuiN4+ieqqw1BcwhTsobNPrGOZl9lFmE1Z0k=
=iJ2d
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
