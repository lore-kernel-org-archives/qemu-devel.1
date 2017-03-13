Received: from eggs.gnu.org ([2001:4830:134:3::10]:46318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cnWCb-0007g6-Jv
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cnWCY-0005me-Un
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cnWCY-0005mF-MV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:04:18 -0400
Date: Mon, 13 Mar 2017 14:04:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170313140412.25bd9056@t450s.home>
In-Reply-To: <7E46909764FA294A89910244A6F5B5A68F31F542@DGGEMA506-MBS.china.huawei.com>
References: <7E46909764FA294A89910244A6F5B5A68F31F542@DGGEMA506-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Host kernel panic when shutdown the pass-through
 QLogic HBA Card VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gaofeng (GaoFeng, Euler)" <visen.gao@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, weifuqiang <weifuqiang@huawei.com>

On Wed, 8 Mar 2017 10:05:20 +0000
"Gaofeng (GaoFeng, Euler)" <visen.gao@huawei.com> wrote:

> The pass-through VM make the host kernel panic when it shutdown.
> I read the kernel code and find the reason of panic is :
> BUG_ON(domain_type_is_vm_or_si(domain));
> in domain_get_iommu function.

So it seems that __intel_map_single() found the device unexpectedly
mapped to the wrong domain type.
=20
> The normal logic does not come to this function, it should be return when=
 __intel_map_single call function iommu_no_mapping.

Are you saying you booted the host with iommu=3Dpt?  If so, we'd expect
to take the else branch in iommu_no_mapping() which would reattach the
device to the si_domain and invoke a printk (which I don't see below).

> I tried the qemu-2.8.0 upstream version, without this problem.
> Is there have some patch fix this bug after qemu-2.6.0?

I'm not sure how the QEMU version is going to change the behavior here
since we're looking at how the VM iommu domain is detached from the
device and we get the device re-attached to a new domain.  Is this
issue repeatable?

> Qemu version=EF=BC=9A2.6.0
> Libvirt: 1.3.4
> VM OS: rhel-server-7.1-x86_64
> Host Kernel version: 3.10.0-327
> PCI Device=EF=BC=9A
> 0002:82:00.0 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel =
to PCI Express HBA (rev 02)
> 0002:82:00.1 Fibre Channel: QLogic Corp. ISP2532-based 8Gb Fibre Channel =
to PCI Express HBA (rev 02)
>=20
> 0002:82:00.0 and 0002:82:00.1 in the same iommu_group.
[snip]
> Dump info=EF=BC=9A
> [40473.205379] qla2xxx 0002:82:00.0: enabling device (0400 -> 0402)
> [40473.205867] qla2xxx [0002:82:00.0]-001d: : Found an ISP2532 irq 73 iob=
ase 0xffffc9016c222000.
> [40473.216686] ------------[ cut here ]------------
> [40473.223384] kernel BUG at drivers/iommu/intel-iommu.c:598!
> [40473.230916] invalid opcode: 0000 [#1] SMP
> [40473.239620] collected_len =3D 625223, LOG_BUF_LEN_LOCAL =3D 1048576
> [40473.316996] kbox: no notify die func register. no need to notify
> [40473.325313] do nothing after die!
> [40473.330993] Modules linked in: qla2xxx scsi_transport_fc scsi_tgt ext4=
 jbd2 dev_connlimit(O) hotpatch(OE) bum(O) ip_set nfnetlink prio(O) nat(O) =
vport_vxlan(O) openvswitch(O) nf_defrag_ipv6 gre signo_catch(O) kboxdriver(=
O) pmcint(O) kbox(O) ipmi_devintf ipmi_si ipmi_msghandler iTCO_wdt iTCO_ven=
dor_support kvm_intel(O) kvm(O) coretemp intel_rapl crc32_pclmul crc32c_int=
el ghash_clmulni_intel ixgbe(O) aesni_intel lrw gf128mul glue_helper ablk_h=
elper cryptd pcspkr vxlan ip6_udp_tunnel udp_tunnel vfat fat igb ptp pps_co=
re i2c_algo_bit dca sb_edac edac_core i2c_i801 i2c_core ses enclosure sg sh=
pchp lpc_ich mfd_core mei_me mei wmi nf_conntrack_ipv4 nf_defrag_ipv4 vhost=
_net(O) tun(O) vhost(O) macvtap macvlan vfio_pci irqbypass vfio_iommu_type1=
 vfio xt_sctp nf_conntrack_proto_sctp nf_nat_proto_sctp nf_nat
> [40473.431127]  nf_conntrack sctp libcrc32c ip_tables ext3 mbcache jbd sd=
_mod crc_t10dif crct10dif_generic crct10dif_pclmul crct10dif_common ahci li=
bahci libata usb_storage megaraid_sas dm_mod [last unloaded: scsi_tgt]
> [40473.463456] CPU: 180 PID: 3910 Comm: kworker/180:1 Tainted: G         =
  OE  ---- -------   3.10.0-327.44.58.19_7.x86_64 #1
> [40473.484945] Hardware name: To be filled by O.E.M. 9032/IT91SMUB, BIOS =
BLXSV105 07/05/2016
> [40473.498740] Workqueue: events work_for_cpu_fn
> [40473.508815] task: ffff921f51fff300 ti: ffff921f50ed0000 task.ti: ffff9=
21f50ed0000
> [40473.522274] RIP: 0010:[<ffffffff8150f904>]  [<ffffffff8150f904>] domai=
n_get_iommu+0x44/0x50
> [40473.536839] RSP: 0018:ffff921f50ed3bb0  EFLAGS: 00010202
> [40473.548450] RAX: 0000000000000000 RBX: ffff9a1f51b5f098 RCX: 000000000=
0000000
> [40473.561971] RDX: 0000000000000000 RSI: ffff921f50065dc0 RDI: ffff8a1f4=
5257200
> [40473.575460] RBP: ffff921f50ed3bf8 R08: 0000000000019620 R09: ffffc9000=
147d620
> [40473.589074] R10: ffffffff8150e805 R11: ffffea287d401940 R12: 000000000=
0000000
> [40473.602811] R13: 00000a1f4adc6000 R14: ffff8a1f45257200 R15: 000000000=
0002000
> [40473.616629] FS:  0000000000000000(0000) GS:ffffc90001464000(0000) knlG=
S:0000000000000000
> [40473.631594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [40473.644306] CR2: 00007fb8b2fff7b0 CR3: 000000000295a000 CR4: 000000000=
01407e0
> [40473.658592] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [40473.672952] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [40473.687339] Stack:
> [40473.696624]  ffffffff81512b18 0000000000000000 ffffffffffffffff 000000=
0000002000
> [40473.711487]  ffff921f4adc6000 0000000000002000 ffff9a1f51b5f098 ffff92=
1f4fdc01f8
> [40473.726250]  0000000000000001 ffff921f50ed3c38 ffffffff81512d42 302d5d=
302e30303a
> [40473.741050]  ffff921f4fdc0000 ffff921f50ed3d30 ffff921f50ed3d28 000000=
0000000200
> [40473.755827]  0000000000000800 ffff921f50ed3cc0 ffffffffa0770025 000000=
0000000010
> [40473.770564]  00000000c79f7266 00000000c79f7266 0000000100000000 000000=
0000000000
> [40473.785250]  ffff921f4fdc0368 ffff921f4fdc0360 0000000000000282 000000=
00c79f7266
> [40473.799919]  00000000c79f7266 ffff9a1f51b5f000 0000000000000800 000000=
0000000200
> [40473.814468]  ffff9a1f51b5f000 ffff921f4fdc0000 ffff921f50ed3dc8 ffffff=
ffa0775285
> [40473.828917]  ffffc9016c222000 ffff921f7fff0000 ffffffff7ffe0000 000004=
0600000008
> [40473.843229]  ffff921f00200000 ffffffff00000100 ffff921f00000800 ffffc9=
000147a8c0
> [40473.857397]  0000000000000001 ffff921f50ed3d68 ffffffff810c27b6 000000=
0000000000
> [40473.871442]  0000000000000000 ffff921f51fff300 ffff921f51fff368 ffffc9=
000147a8c0
> [40473.885331]  ffffc9000147a840 0000000000000001 0000000000000001 000000=
00c79f7266
> [40473.899132]  ffff9a1f51b5f098 0000000000000004 ffff9a1f51b5f140 000000=
0000000202
> [40473.912778]  0000000000000001 00000000c79f7266 ffff9a1f51b5f000 000000=
0000000000
> [40473.926260]  ffffffffa07f2000 ffff9a1f51b5f098 0000000000002d00 ffff92=
1f50ed3e00
> [40473.939662]  ffffffff81335095 ffffc9000147a840 ffff9b1f22edfd20 ffff92=
1f5203bd80
> [40473.952919]  ffffc9000147a080 ffffc9000147ea00 ffff921f50ed3e18 ffffff=
ff8109a6e4
> [40473.966072]  ffff9b1f22edfd20 ffff921f50ed3e60 ffffffff8109dbdb 000000=
0050ed3e60
> [40473.979156]  0000000000000000 ffffc9000147a098 ffff921f5203bdb0 ffff92=
1f51fff300
> [40473.992179]  ffff921f5203bd80 ffffc9000147a080 ffff921f50ed3ec0 ffffff=
ff8109eb23
> [40474.005085]  ffff921f50ed3fd8 0000000000016840 ffff921f51fff300 ffff92=
1f51fff300
> [40474.017918]  ffff921f51fff300 ffff921f51c5bd38 ffff921f5203bd80 ffffff=
ff8109e890
> [40474.030657] Call Trace:
> [40474.038219]  [<ffffffff81512b18>] ? __intel_map_single+0x68/0x1b0

Perhaps add some debugging here to figure out why iommu_no_mapping()
isn't working as you expect.  Thanks,

Alex

> [40474.049506]  [<ffffffff81512d42>] intel_alloc_coherent+0xa2/0x120
> [40474.060793]  [<ffffffffa0770025>] qla2x00_mem_alloc+0xb5/0xf90 [qla2xx=
x]
> [40474.072703]  [<ffffffffa0775285>] qla2x00_probe_one+0x935/0x2340 [qla2=
xxx]
> [40474.084750]  [<ffffffff810c27b6>] ? dequeue_entity+0x106/0x520
> [40474.095763]  [<ffffffff81335095>] local_pci_probe+0x45/0xa0
> [40474.106439]  [<ffffffff8109a6e4>] work_for_cpu_fn+0x14/0x20
> [40474.117027]  [<ffffffff8109dbdb>] process_one_work+0x17b/0x470
> [40474.127818]  [<ffffffff8109eb23>] worker_thread+0x293/0x400
> [40474.138349]  [<ffffffff8109e890>] ? rescuer_thread+0x400/0x400
> [40474.149195]  [<ffffffff810a60ef>] kthread+0xcf/0xe0
> [40474.158983]  [<ffffffff810a6020>] ? kthread_create_on_node+0x140/0x140
> [40474.170387]  [<ffffffff81653ed8>] ret_from_fork+0x58/0x90
> [40474.180629]  [<ffffffff810a6020>] ? kthread_create_on_node+0x140/0x140
> [40474.191988] Code: e5 e8 c1 3c e0 ff 85 c0 78 1d 3b 05 cf 66 a2 00 7d 1=
5 48 8b 15 e6 66 a2 00 48 98 5d 48 8b 04 c2 c3 66 0f 1f 44 00 00 31 c0 5d c=
3 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5
> [40474.227505] RIP  [<ffffffff8150f904>] domain_get_iommu+0x44/0x50
> [40474.238770]  RSP <ffff921f50ed3bb0>
> [40474.257815] ---[ end trace bc0bf1f504b05a96 ]---
> [40474.277513] Kernel panic - not syncing: Fatal exception
> [40474.297684] die even has been record!
>=20
