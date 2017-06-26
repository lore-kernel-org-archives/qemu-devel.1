Received: from eggs.gnu.org ([2001:4830:134:3::10]:45804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPTZd-0001h7-HJ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dPTZa-0001Rh-DJ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:57:01 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dPTZa-0001QS-3K
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:56:58 -0400
Received: by mail-wm0-x22d.google.com with SMTP id b184so451019wme.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 05:56:56 -0700 (PDT)
Date: Mon, 26 Jun 2017 13:56:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170626125651.GA7776@stefanha-x1.localdomain>
References: <20170622140827.GA29936@stefanha-x1.localdomain>
	<20170623001313.n6cms5sunwuqnf4h@hz-desktop>
	<20170623095522.GB12689@stefanha-x1.localdomain>
	<20170626020501.xq54xlnqmhika3zw@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20170626020501.xq54xlnqmhika3zw@hz-desktop>
Subject: Re: [Qemu-devel] NVDIMM live migration broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 10:05:01AM +0800, Haozhong Zhang wrote:
> On 06/23/17 10:55 +0100, Stefan Hajnoczi wrote:
> > On Fri, Jun 23, 2017 at 08:13:13AM +0800, haozhong.zhang@intel.com wrot=
e:
> > > On 06/22/17 15:08 +0100, Stefan Hajnoczi wrote:
> > > > I tried live migrating a guest with NVDIMM on qemu.git/master (edf8=
bc984):
> > > >=20
> > > >   $ qemu -M accel=3Dkvm,nvdimm=3Don -m 1G,slots=3D4,maxmem=3D8G -cp=
u host \
> > > >          -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=
=3Dnvdimm.dat,size=3D1G \
> > > > 	 -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1 \
> > > > 	 -drive if=3Dvirtio,file=3Dtest.img,format=3Draw
> > > >=20
> > > >   $ qemu -M accel=3Dkvm,nvdimm=3Don -m 1G,slots=3D4,maxmem=3D8G -cp=
u host \
> > > >          -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=
=3Dnvdimm.dat,size=3D1G \
> > > > 	 -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1 \
> > > > 	 -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
> > > > 	 -incoming tcp::1234
> > > >=20
> > > >   (qemu) migrate tcp:127.0.0.1:1234
> > > >=20
> > > > The guest kernel panics or hangs every time on the destination.  It
> > > > happens as long as the nvdimm device is present - I didn't even mou=
nt it
> > > > inside the guest.
> > > >=20
> > > > Is migration expected to work?
> > >=20
> > > Yes, I tested on QEMU 2.8.0 several months ago and it worked. I'll
> > > have a look at this issue.
> >=20
> > Great, thanks!
> >=20
> > David Gilbert suggested the following on IRC, it sounds like a good
> > starting point for debugging:
> >=20
> > Launch the destination QEMU with -S (vcpus will be paused) and after
> > migration has completed, compare the NVDIMM contents on source and
> > destination.
> >=20
>=20
> Which host and guest kernel are you testing? Is any workload running
> in guest when migration?
>=20
> I just tested QEMU commit edf8bc984 with host/guest kernel 4.8.0, and
> could not reproduce the issue.

I can still reproduce the problem on qemu.git edf8bc984.

My guest kernel is fairly close to yours.  The host kernel is newer.

Host kernel: 4.11.6-201.fc25.x86_64
Guest kernel: 4.8.8-300.fc25.x86_64

Command-line:

  qemu-system-x86_64 \
      -enable-kvm \
      -cpu host \
      -machine pc,nvdimm \
      -m 1G,slots=3D4,maxmem=3D8G \
      -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=3Dnvdimm.da=
t,size=3D1G \
      -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1 \
      -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
      -display none \
      -serial stdio \
      -monitor unix:/tmp/monitor.sock,server,nowait

Start migration at the guest login prompt.  You don't need to log in or
do anything inside the guest.

There seems to be a guest RAM corruption because I get different
backtraces inside the guest every time.

The problem goes away if I remove -device nvdimm.

Here is an example backtrace:

[   28.577138] BUG: Bad rss-counter state mm:ffff9a21fd38aec0 idx:0 val:2605
[   28.577954] BUG: Bad rss-counter state mm:ffff9a21fd38aec0 idx:1 val:503
[   28.578646] BUG: non-zero nr_ptes on freeing mm: 73
[   28.579133] BUG: non-zero nr_pmds on freeing mm: 4
[   28.579932] BUG: unable to handle kernel paging request at ffff9a2100000=
000
[   28.581174] IP: [<ffffffffbe227723>] __kmalloc+0xc3/0x1f0
[   28.582015] PGD 3327c067 PUD 0=20
[   28.582549] Oops: 0000 [#1] SMP
[   28.583032] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6=
table_raw ip6table_mangle ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_=
nat_ipv6 ip6table_security iptable_raw iptable_mangle iptable_nat nf_conntr=
ack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_security eb=
table_filter ebtables ip6table_filter ip6_tables bochs_drm ttm drm_kms_help=
er snd_pcsp dax_pmem nd_pmem crct10dif_pclmul dax nd_btt crc32_pclmul ppdev=
 snd_pcm ghash_clmulni_intel drm e1000 snd_timer snd soundcore acpi_cpufreq=
 joydev i2c_piix4 tpm_tis parport_pc tpm_tis_core parport qemu_fw_cfg tpm n=
fit xfs libcrc32c virtio_blk crc32c_intel virtio_pci serio_raw virtio_ring =
virtio ata_generic pata_acpi
[   28.592394] CPU: 0 PID: 573 Comm: systemd-journal Not tainted 4.8.8-300.=
fc25.x86_64 #1
[   28.593124] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
[   28.594208] task: ffff9a21f67e5b80 task.stack: ffff9a21fd0c0000
[   28.594752] RIP: 0010:[<ffffffffbe227723>]  [<ffffffffbe227723>] __kmall=
oc+0xc3/0x1f0
[   28.595485] RSP: 0018:ffff9a21fd0c3740  EFLAGS: 00010046
[   28.595976] RAX: ffff9a2100000000 RBX: 0000000002080020 RCX: 00000000000=
0007f
[   28.596644] RDX: 0000000000010bf2 RSI: 0000000000000000 RDI: 00000000000=
1c980
[   28.597311] RBP: ffff9a21fd0c3770 R08: ffff9a21ffc1c980 R09: 00000000020=
80020
[   28.597971] R10: ffff9a2100000000 R11: 0000000000000008 R12: 00000000020=
80020
[   28.598637] R13: 0000000000000030 R14: ffff9a21fe0018c0 R15: ffff9a21fe0=
018c0
[   28.599301] FS:  00007fd95ae4c700(0000) GS:ffff9a21ffc00000(0000) knlGS:=
0000000000000000
[   28.600050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.600587] CR2: ffff9a2100000000 CR3: 000000003715f000 CR4: 00000000003=
406f0
[   28.601250] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   28.601908] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   28.602574] Stack:
[   28.602754]  ffffffffc03dde4d 0000000000000003 ffff9a21fd0c38e0 00000000=
0000001c
[   28.603493]  ffff9a21f6cfb000 ffff9a21fd0c38c8 ffff9a21fd0c3788 ffffffff=
c03dde4d
[   28.604217]  0000000000000003 ffff9a21fd0c3800 ffffffffc03de043 ffff9a21=
fd0c38c8
[   28.604942] Call Trace:
[   28.605185]  [<ffffffffc03dde4d>] ? alloc_indirect.isra.14+0x1d/0x50 [vi=
rtio_ring]
[   28.605890]  [<ffffffffc03dde4d>] alloc_indirect.isra.14+0x1d/0x50 [virt=
io_ring]
[   28.606561]  [<ffffffffc03de043>] virtqueue_add_sgs+0x1c3/0x4a0 [virtio_=
ring]
[   28.607086]  [<ffffffffc040165c>] __virtblk_add_req+0xbc/0x220 [virtio_b=
lk]
[   28.607614]  [<ffffffffbe3fbb3d>] ? find_next_zero_bit+0x1d/0x20
[   28.608060]  [<ffffffffbe3c2e57>] ? __bt_get.isra.6+0xd7/0x1c0
[   28.608506]  [<ffffffffc040195d>] virtio_queue_rq+0x12d/0x290 [virtio_bl=
k]
[   28.609013]  [<ffffffffbe3c06b3>] __blk_mq_run_hw_queue+0x233/0x380
[   28.609565]  [<ffffffffbe3b2101>] ? blk_run_queue+0x21/0x40
[   28.610087]  [<ffffffffbe3c045b>] blk_mq_run_hw_queue+0x8b/0xb0
[   28.610649]  [<ffffffffbe3c1926>] blk_sq_make_request+0x216/0x4d0
[   28.611225]  [<ffffffffbe3b5782>] generic_make_request+0xf2/0x1d0
[   28.611796]  [<ffffffffbe3b58dd>] submit_bio+0x7d/0x150
[   28.612297]  [<ffffffffbe1c6797>] ? __test_set_page_writeback+0x107/0x220
[   28.612952]  [<ffffffffc045b644>] xfs_submit_ioend.isra.14+0x84/0xd0 [xf=
s]
[   28.613617]  [<ffffffffc045bbfe>] xfs_do_writepage+0x26e/0x5f0 [xfs]
[   28.614219]  [<ffffffffbe1c8425>] write_cache_pages+0x205/0x530
[   28.614789]  [<ffffffffc045b990>] ? xfs_aops_discard_page+0x140/0x140 [x=
fs]
[   28.615460]  [<ffffffffc045b73b>] xfs_vm_writepages+0xab/0xd0 [xfs]
[   28.616052]  [<ffffffffbe1c940e>] do_writepages+0x1e/0x30
[   28.616569]  [<ffffffffbe1ba5c6>] __filemap_fdatawrite_range+0xc6/0x100
[   28.617192]  [<ffffffffbe1ba741>] filemap_write_and_wait_range+0x41/0x90
[   28.617832]  [<ffffffffc0465c23>] xfs_file_fsync+0x63/0x1d0 [xfs]
[   28.618415]  [<ffffffffbe285289>] vfs_fsync_range+0x49/0xa0
[   28.618940]  [<ffffffffbe28533d>] do_fsync+0x3d/0x70
[   28.619411]  [<ffffffffbe2855d0>] SyS_fsync+0x10/0x20
[   28.619887]  [<ffffffffbe003c57>] do_syscall_64+0x67/0x160
[   28.620410]  [<ffffffffbe802861>] entry_SYSCALL64_slow_path+0x25/0x25
[   28.621017] Code: 49 83 78 10 00 4d 8b 10 0f 84 ce 00 00 00 4d 85 d2 0f =
84 c5 00 00 00 49 63 47 20 49 8b 3f 4c 01 d0 40 f6 c7 0f 0f 85 1a 01 00 00 =
<48> 8b 18 48 8d 4a 01 4c 89 d0 65 48 0f c7 0f 0f 94 c0 84 c0 74=20
[   28.623292] RIP  [<ffffffffbe227723>] __kmalloc+0xc3/0x1f0
[   28.623712]  RSP <ffff9a21fd0c3740>
[   28.623975] CR2: ffff9a2100000000
[   28.624275] ---[ end trace 60d3c1e57c22eb41 ]---

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUQSTAAoJEJykq7OBq3PIhy8IAIS7aDrhAVdd5Sw15F1R6e+W
qgL4Xc+plQv9+xQuqXeK9LfR25VehWTzYFlkApBsRzGkYwIZpAWQXZTiluRQCf+b
yYkK7kJISbCGY9RuifcSbZNX3Ia5PJkDszIzHDQdox7RoigxaWtbzsqF5LuwKx2b
Uymn4LjfFZmw+W4DesPs4ZaesyvO921h3Gk4Bz9BotVd+K1eYwfTkOodPZo6NB2v
s0Z1riHcY+XUfSi8+BIdzGf1pmHM70BA2dSne4CSZhYstHMif8A0bDOBVc8W+3Tq
pt/q69gUffgcFusV78fj5UAIC5Z7nk+MpP3+YlQFixqyNZuu1y3Fvvv7eb0CY7M=
=2Aep
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
