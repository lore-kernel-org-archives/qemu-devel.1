Received: from eggs.gnu.org ([2001:4830:134:3::10]:54202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1elI6n-0000SS-Ee
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1elI6l-00071R-Ma
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:41:41 -0500
References: <20180210082925.1888-1-king.wang@huawei.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0118a0bd-18fe-a71c-68be-17c950f2945d@redhat.com>
Date: Mon, 12 Feb 2018 12:41:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180210082925.1888-1-king.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu aborted in ide_restart_bh after migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang King <king.wang@huawei.com>, qemu-devel@nongnu.org
Cc: weifuqiang@huawei.com, "Denis V. Lunev" <den@openvz.org>, Qemu-block <qemu-block@nongnu.org>



On 02/10/2018 03:29 AM, Wang King wrote:
> Empty IDE CD-ROM configured on the VM:
>     <disk type=3D'file' device=3D'cdrom'>
>       <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'threads'/=
>
>       <target dev=3D'hdb' bus=3D'ide'/>
>       <readonly/>
>       <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' u=
nit=3D'1'/>
>     </disk>
> Make migration for this VM, then qemu aborted in ide_restart_bh. IDESta=
te expect
> end_transfer_func equal to ide_atapi_cmd, but it refer to ide_dummy_tra=
nsfer_stop.
> I have no idea about this, can anyone help me?
>=20

Do you have an easy way to reproduce this? 2.8.1 is a bit old at this
point, but I don't think we've changed anything in the IDE emulator
substantively since then, so I'm curious to see if I can get this to
reproduce.

I'm surprised an empty CD-ROM would cause this, though, since it
shouldn't really have any commands in-flight that might get us to a
weird edge case, so I want to take a close look at this.

Denis Lunev noted some issues with migration that I couldn't solve at
the time either. A reproducer would be fantastic.

> qemu version is 2.8.1
> (gdb) bt
> #0  0x00007fcff7c4b157 in raise () from /usr/lib64/libc.so.6
> #1  0x00007fcff7c4c848 in abort () from /usr/lib64/libc.so.6
> #2  0x00007fcff7c441c6 in __assert_fail_base () from /usr/lib64/libc.so=
.6
> #3  0x00007fcff7c44272 in __assert_fail () from /usr/lib64/libc.so.6
> #4  0x00000000006207ab in ide_restart_bh (opaque=3D0x38b3430) at hw/ide=
/core.c:2570
> #5  0x0000000000763a6f in aio_bh_poll (ctx=3Dctx@entry=3D0x234f940) at =
async.c:115
> #6  0x0000000000770948 in aio_dispatch (ctx=3D0x234f940) at aio_posix.c=
:303
> #7  0x00000000007638e1 in aio_ctx_dispatch (source=3D<optimized out>, c=
allback=3D<optimized out>, user_data=3D<optimized out>) at async.c:254
> #8  0x00007fcff8e6799a in g_main_context_dispatch () from /usr/lib64/li=
bglib-2.0.so.0
> #9  0x000000000076e606 in glib_pollfds_poll () at main_loop.c:228
> #10 0x000000000076e6ab in os_host_main_loop_wait (timeout=3D0) at main_=
loop.c:273
> #11 0x000000000076e7d5 in main_loop_wait (nonblocking=3Dnonblocking@ent=
ry=3D0) at main_loop.c:521
> #12 0x000000000056b911 in main_loop () at vl.c:2089
> #13 0x0000000000420805 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:4964
> (gdb) f 4
> #4  0x00000000006207ab in ide_restart_bh (opaque=3D0x38b3430)
> 2570            assert(s->end_transfer_func =3D=3D ide_atapi_cmd);
> (gdb) p *bus
> $7 =3D {qbus =3D {obj =3D {class =3D 0x2313a30, free =3D 0x0, propertie=
s =3D 0x3871520, ref =3D 2, parent =3D 0x38b2b00}, parent =3D 0x38b2b00, =
name =3D 0x3980af0 "ide.0", hotplug_handler =3D 0x0, max_index =3D 1, rea=
lized =3D true,
>     children =3D {tqh_first =3D 0x349e050, tqh_last =3D 0x349e060}, sib=
ling =3D {le_next =3D 0x0, le_prev =3D 0x38b3d68}}, master =3D 0x0, slave=
 =3D 0x349e3c0, ifs =3D {{bus =3D 0x38b3430, unit =3D 0 '\000', drive_kin=
d =3D IDE_HD,
>       cylinders =3D 0, heads =3D 0, sectors =3D 0, chs_trans =3D 0, nb_=
sectors =3D 0, mult_sectors =3D 16, identify_set =3D 0, identify_data =3D=
 '\000' <repeats 511 times>, drive_serial =3D 1,
>       drive_serial_str =3D '\000' <repeats 20 times>, drive_model_str =3D=
 '\000' <repeats 40 times>, wwn =3D 0, feature =3D 0 '\000', error =3D 1 =
'\001', nsector =3D 0, sector =3D 0 '\000', lcyl =3D 96 '`',
>       hcyl =3D 0 '\000', hob_feature =3D 0 '\000', hob_nsector =3D 0 '\=
000', hob_sector =3D 0 '\000', hob_lcyl =3D 0 '\000', hob_hcyl =3D 0 '\00=
0', select =3D 160 '\240', status =3D 80 'P', lba48 =3D 0 '\000', blk =3D=
 0x0,
>       version =3D "\000\000\000\000\000\000\000\000", events =3D {eject=
_request =3D false, new_media =3D false}, sense_key =3D 0 '\000', asc =3D=
 0 '\000', tray_open =3D false, tray_locked =3D false,
>       cdrom_changed =3D 0 '\000', packet_transfer_size =3D 0, elementar=
y_transfer_size =3D 0, io_buffer_index =3D 0, lba =3D 0, cd_sector_size =3D=
 0, atapi_dma =3D 0, acct =3D {bytes =3D 0, start_time_ns =3D 0,
>         type =3D BLOCK_ACCT_READ}, pio_aiocb =3D 0x0, iov =3D {iov_base=
 =3D 0x0, iov_len =3D 0}, qiov =3D {iov =3D 0x0, niov =3D 0, nalloc =3D 0=
, size =3D 0}, buffered_requests =3D {lh_first =3D 0x0}, io_buffer_offset=
 =3D 0,
>       io_buffer_size =3D 0, sg =3D {sg =3D 0x0, nsg =3D 0, nalloc =3D 0=
, size =3D 0, dev =3D 0x0, as =3D 0x0}, req_nb_sectors =3D 0, end_transfe=
r_func =3D 0x61b780 <ide_dummy_transfer_stop>,
>       data_ptr =3D 0x7fcffd126800 "\377\377\377\377", data_end =3D 0x7f=
cffd126800 "\377\377\377\377", io_buffer =3D 0x7fcffd126800 "\377\377\377=
\377", io_buffer_total_len =3D 131076, cur_io_buffer_offset =3D 0,
>       cur_io_buffer_len =3D 0, end_transfer_fn_idx =3D 0 '\000', sector=
_write_timer =3D 0x39e5c60, irq_count =3D 0, ext_error =3D 0 '\000', mdat=
a_size =3D 0, mdata_storage =3D 0x0, media_changed =3D 0,
>       dma_cmd =3D IDE_DMA_READ, smart_enabled =3D 0 '\000', smart_autos=
ave =3D 0 '\000', smart_errors =3D 0, smart_selftest_count =3D 0 '\000', =
smart_selftest_data =3D 0x39e6000 "", ncq_queues =3D 0}, {bus =3D 0x38b34=
30,
>       unit =3D 1 '\001', drive_kind =3D IDE_CD, cylinders =3D 0, heads =
=3D 0, sectors =3D 0, chs_trans =3D 0, nb_sectors =3D 0, mult_sectors =3D=
 16, identify_set =3D 1,
>       identify_data =3D "\300\205", '\000' <repeats 18 times>, "MQ0000 =
2", ' ' <repeats 12 times>, "\003\000\000\002\004\000.2+5    EQUMD DVR-MO=
", ' ' <repeats 28 times>, "\000\000\001\000\000\003\000\000\000\000\000\=
000\a", '\000' <repeats 17 times>, "\a\000\a\000\003\000\264\000\264\000,=
\001\264\000\000\000\000\000\036\000\036", '\000' <repeats 15 times>, "\0=
36", '\000' <repeats 15 times>, "?", '\000' <repeats 334 times>, drive_se=
rial =3D 2, drive_serial_str =3D "QM00002", '\000' <repeats 13 times>, dr=
ive_model_str =3D "QEMU DVD-ROM", '\000' <repeats 28 times>, wwn =3D 0, f=
eature =3D 0 '\000', error =3D 0 '\000', nsector =3D 3,
>       sector =3D 0 '\000', lcyl =3D 18 '\022', hcyl =3D 0 '\000', hob_f=
eature =3D 0 '\000', hob_nsector =3D 3 '\003', hob_sector =3D 0 '\000', h=
ob_lcyl =3D 0 '\000', hob_hcyl =3D 0 '\000', select =3D 176 '\260',
>       status =3D 80 'P', lba48 =3D 0 '\000', blk =3D 0x2498650, version=
 =3D "2.5+\000\000\000\000", events =3D {eject_request =3D false, new_med=
ia =3D false}, sense_key =3D 2 '\002', asc =3D 58 ':', tray_open =3D fals=
e,
>       tray_locked =3D false, cdrom_changed =3D 0 '\000', packet_transfe=
r_size =3D 0, elementary_transfer_size =3D 0, io_buffer_index =3D 0, lba =
=3D 0, cd_sector_size =3D 0, atapi_dma =3D 0, acct =3D {bytes =3D 0,
>         start_time_ns =3D 0, type =3D BLOCK_ACCT_READ}, pio_aiocb =3D 0=
x0, iov =3D {iov_base =3D 0x0, iov_len =3D 0}, qiov =3D {iov =3D 0x0, nio=
v =3D 0, nalloc =3D 0, size =3D 0}, buffered_requests =3D {lh_first =3D 0=
x0},
>       io_buffer_offset =3D 0, io_buffer_size =3D 0, sg =3D {sg =3D 0x0,=
 nsg =3D 0, nalloc =3D 0, size =3D 0, dev =3D 0x0, as =3D 0x0}, req_nb_se=
ctors =3D 0, end_transfer_func =3D 0x61b780 <ide_dummy_transfer_stop>,
>       data_ptr =3D 0x7fcff03ca800 "\377\377\377\377", data_end =3D 0x7f=
cff03ca800 "\377\377\377\377", io_buffer =3D 0x7fcff03ca800 "\377\377\377=
\377", io_buffer_total_len =3D 131076, cur_io_buffer_offset =3D 0,
>       cur_io_buffer_len =3D 0, end_transfer_fn_idx =3D 0 '\000', sector=
_write_timer =3D 0x39e5ca0, irq_count =3D 0, ext_error =3D 0 '\000', mdat=
a_size =3D 0, mdata_storage =3D 0x0, media_changed =3D 0,
>       dma_cmd =3D IDE_DMA_READ, smart_enabled =3D 1 '\001', smart_autos=
ave =3D 1 '\001', smart_errors =3D 0, smart_selftest_count =3D 0 '\000', =
smart_selftest_data =3D 0x39e7000 "", ncq_queues =3D 0}}, bh =3D 0x0,
>   bus_id =3D 0, max_units =3D 2, dma =3D 0x38b45f0, unit =3D 1 '\001', =
cmd =3D 8 '\b', irq =3D 0x39e5ce0, error_status =3D 0, retry_unit =3D 1 '=
\001', retry_sector_num =3D -1, retry_nsector =3D 2, portio_list =3D {
>     ports =3D 0xe61a20 <ide_portio_list>, owner =3D 0x0, address_space =
=3D 0x23527e0, nr =3D 1, regions =3D 0x3980b10, opaque =3D 0x38b3430, nam=
e =3D 0x8d2724 "ide", flush_coalesced_mmio =3D false}, portio2_list =3D {
>     ports =3D 0xe619c0 <ide_portio2_list>, owner =3D 0x0, address_space=
 =3D 0x23527e0, nr =3D 1, regions =3D 0x39b3400, opaque =3D 0x38b3430, na=
me =3D 0x8d2724 "ide", flush_coalesced_mmio =3D false}, vmstate =3D 0x39e=
5eb0}
> (gdb) p *(BMDMAState*)0x38b45f0
> $9 =3D {dma =3D {ops =3D 0xd51280 <bmdma_ops>, iov =3D {iov_base =3D 0x=
0, iov_len =3D 0}, qiov =3D {iov =3D 0x0, niov =3D 0, nalloc =3D 0, size =
=3D 0}, aiocb =3D 0x0}, cmd =3D 0 '\000', status =3D 4 '\004', addr =3D 0=
, bus =3D 0x38b3430,
>   cur_addr =3D 0, cur_prd_last =3D 0, cur_prd_addr =3D 0, cur_prd_len =3D=
 0, dma_cb =3D 0x0, addr_ioport =3D {parent_obj =3D {class =3D 0x2327d00,=
 free =3D 0x0, properties =3D 0x3871180, ref =3D 1, parent =3D 0x38b2b00}=
,
>     romd_mode =3D true, ram =3D false, subpage =3D false, readonly =3D =
false, rom_device =3D false, flush_coalesced_mmio =3D false, global_locki=
ng =3D true, dirty_log_mask =3D 0 '\000', ram_block =3D 0x0, owner =3D 0x=
38b2b00,
>     iommu_ops =3D 0x0, ops =3D 0xe8c8c0 <bmdma_addr_ioport_ops>, opaque=
 =3D 0x38b45f0, container =3D 0x38b4b20, size =3D 0x000000000000000000000=
00000000004, addr =3D 4,
>     destructor =3D 0x46fc40 <memory_region_destructor_none>, align =3D =
0, terminates =3D true, ram_device =3D false, enabled =3D true, warning_p=
rinted =3D false, vga_logging_count =3D 0 '\000', alias =3D 0x0,
>     alias_offset =3D 0, priority =3D 0, subregions =3D {tqh_first =3D 0=
x0, tqh_last =3D 0x38b46f8}, subregions_link =3D {tqe_next =3D 0x38b4750,=
 tqe_prev =3D 0x38b4a98}, coalesced =3D {tqh_first =3D 0x0, tqh_last =3D =
0x38b4718},
>     name =3D 0x38e90c0 "bmdma", ioeventfd_nb =3D 0, ioeventfds =3D 0x0,=
 iommu_notify =3D {lh_first =3D 0x0}, iommu_notify_flags =3D IOMMU_NOTIFI=
ER_NONE}, extra_io =3D {parent_obj =3D {class =3D 0x2327d00, free =3D 0x0=
,
>       properties =3D 0x3871060, ref =3D 1, parent =3D 0x38b2b00}, romd_=
mode =3D true, ram =3D false, subpage =3D false, readonly =3D false, rom_=
device =3D false, flush_coalesced_mmio =3D false, global_locking =3D true=
,
>     dirty_log_mask =3D 0 '\000', ram_block =3D 0x0, owner =3D 0x38b2b00=
, iommu_ops =3D 0x0, ops =3D 0xd516c0 <piix_bmdma_ops>, opaque =3D 0x38b4=
5f0, container =3D 0x38b4b20, size =3D 0x00000000000000000000000000000004=
,
>     addr =3D 0, destructor =3D 0x46fc40 <memory_region_destructor_none>=
, align =3D 0, terminates =3D true, ram_device =3D false, enabled =3D tru=
e, warning_printed =3D false, vga_logging_count =3D 0 '\000', alias =3D 0=
x0,
>     alias_offset =3D 0, priority =3D 0, subregions =3D {tqh_first =3D 0=
x0, tqh_last =3D 0x38b47f8}, subregions_link =3D {tqe_next =3D 0x0, tqe_p=
rev =3D 0x38b4708}, coalesced =3D {tqh_first =3D 0x0, tqh_last =3D 0x38b4=
818},
>     name =3D 0x38b6af0 "piix-bmdma", ioeventfd_nb =3D 0, ioeventfds =3D=
 0x0, iommu_notify =3D {lh_first =3D 0x0}, iommu_notify_flags =3D IOMMU_N=
OTIFIER_NONE}, irq =3D 0x285c930, migration_compat_status =3D 36 '$',
>   migration_retry_unit =3D 1 '\001', migration_retry_sector_num =3D -1,=
 migration_retry_nsector =3D 2, pci_dev =3D 0x38b2b00}
> (gdb)
>=20

--=20
=E2=80=94js
