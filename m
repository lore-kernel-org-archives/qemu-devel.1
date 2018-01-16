Received: from eggs.gnu.org ([2001:4830:134:3::10]:39547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ebKSn-0000Ho-Nl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ebKSm-0001tH-ED
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:11:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ebKSm-0001t4-45
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:11:12 -0500
Date: Tue, 16 Jan 2018 14:11:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180116061102.GA7031@xz-mi>
References: <20180115085528.32663-1-peterx@redhat.com>
	<CAMxuvax0N5qf5DN5tkmvSEkVcGXMQzfBAY+MxLqJGEttYQnuKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvax0N5qf5DN5tkmvSEkVcGXMQzfBAY+MxLqJGEttYQnuKQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: don't use DMA mapping for fw_cfg
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Baoquan He <bhe@redhat.com>

On Mon, Jan 15, 2018 at 12:22:48PM +0100, Marc-Andre Lureau wrote:
> Hi
>=20
> On Mon, Jan 15, 2018 at 9:55 AM, Peter Xu <peterx@redhat.com> wrote:
> > fw_cfg device does not need IOMMU protection, so use physical address=
es
> > always.  That's how QEMU implements fw_cfg.  Otherwise we'll see call
> > traces during boot when vIOMMU is enabled in guest:
> >
> > [    1.018306] ------------[ cut here ]------------
> > [    1.018314] WARNING: CPU: 1 PID: 1 at drivers/firmware/qemu_fw_cfg=
.c:152 fw_cfg_dma_transfer+0x399/0x500
> > [    1.018315] fw_cfg_dma_transfer: failed to map fw_cfg_dma
> > [    1.018316] Modules linked in:
> > [    1.018320] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.10.0-827.e=
l7.x86_64 #1
> > [    1.018321] Hardware name: Red Hat KVM, BIOS 1.11.0-1.el7 04/01/20=
14
> > [    1.018322] Call Trace:
> > [    1.018330]  [<ffffffffafcf6b3a>] dump_stack+0x19/0x1b
> > [    1.018334]  [<ffffffffaf68fff8>] __warn+0xd8/0x100
> > [    1.018336]  [<ffffffffaf69007f>] warn_slowpath_fmt+0x5f/0x80
> > [    1.018338]  [<ffffffffafb67329>] fw_cfg_dma_transfer+0x399/0x500
> > [    1.018340]  [<ffffffffafb6753c>] fw_cfg_read_blob+0xac/0x1c0
> > [    1.018342]  [<ffffffffafb67720>] fw_cfg_register_dir_entries+0x80=
/0x450
> > [    1.018344]  [<ffffffffafb67d02>] fw_cfg_sysfs_probe+0x212/0x3f0
> > [    1.018347]  [<ffffffffafa70352>] platform_drv_probe+0x42/0x110
> > [    1.018350]  [<ffffffffafa6e002>] driver_probe_device+0xc2/0x3e0
> > [    1.018352]  [<ffffffffafa6e3f3>] __driver_attach+0x93/0xa0
> > [    1.018354]  [<ffffffffafa6e360>] ? __device_attach+0x40/0x40
> > [    1.018359]  [<ffffffffafa6bbd3>] bus_for_each_dev+0x73/0xc0
> > [    1.018362]  [<ffffffffafa6d97e>] driver_attach+0x1e/0x20
> > [    1.018364]  [<ffffffffafa6d420>] bus_add_driver+0x200/0x2d0
> > [    1.018366]  [<ffffffffb03c2041>] ? firmware_map_add_early+0x58/0x=
58
> > [    1.018368]  [<ffffffffafa6ea84>] driver_register+0x64/0xf0
> > [    1.018370]  [<ffffffffafa7013a>] __platform_driver_register+0x4a/=
0x50
> > [    1.018372]  [<ffffffffb03c2075>] fw_cfg_sysfs_init+0x34/0x61
> > [    1.018376]  [<ffffffffaf602108>] do_one_initcall+0xb8/0x230
> > [    1.018379]  [<ffffffffb036b34a>] kernel_init_freeable+0x17a/0x219
> > [    1.018381]  [<ffffffffb036ab19>] ? initcall_blacklist+0xb0/0xb0
> > [    1.018383]  [<ffffffffafce5b30>] ? rest_init+0x80/0x80
> > [    1.018385]  [<ffffffffafce5b3e>] kernel_init+0xe/0xf0
> > [    1.018388]  [<ffffffffafd08898>] ret_from_fork+0x58/0x90
> > [    1.018390]  [<ffffffffafce5b30>] ? rest_init+0x80/0x80
> > [    1.018392] ---[ end trace d00a5b71608a8f59 ]---
> >
> > Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1533367
> > Fixes: e90cb816599b ("fw_cfg: do DMA read operation", 2017-11-28)
> > CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > --
> >
> > This is based on tree:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?=
h=3Dvhost
> >
> > Please review, thanks.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> The DMA business is confusing, sadly I didn't get much clue what I was
> supposed to do. What I can say:
>=20
> Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks for confirming this.

>=20
> Should the series be removed from Michael tree and I squash your fix &
> send a v10?
>=20
> Fwiw, "fw_cfg: write vmcoreinfo details" should also be fixed to
> allocate memory (unless your approach fixes that?)

Yes, IMHO this patch should also work for writes (though not tested).

Thanks,

--=20
Peter Xu
