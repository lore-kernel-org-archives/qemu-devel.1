Received: from eggs.gnu.org ([2001:4830:134:3::10]:38799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cELRF-0000ZR-Ry
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cELRB-0000rh-Pa
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:30:05 -0500
Received: from mail.kernel.org ([198.145.29.136]:47278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cELRB-0000rA-Jq
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:30:01 -0500
Date: Tue, 6 Dec 2016 11:29:55 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20161206190956.6a096808@Igors-MacBook-Pro.local>
Message-ID: <alpine.DEB.2.10.1612061115140.6598@sstabellini-ThinkPad-X260>
References: <20161201170624.26496-1-lersek@redhat.com>
	<20161201170624.26496-4-lersek@redhat.com>
	<20161206124906.76a41896@nial.brq.redhat.com>
	<3da2baa9-9fa6-7802-fe56-afa02a892a07@redhat.com>
	<20161206190956.6a096808@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v4 3/7] fw-cfg: expose "file_slots"
 parameter in fw_cfg_init_io_dma()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Gabriel L. Somlo" <somlo@cmu.edu>, Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, sstabellini@kernel.org, anthony.perard@citrix.com, xen-devel@lists.xensource.com

On Tue, 6 Dec 2016, Igor Mammedov wrote:
> > First, to my knowledge, Xen does not use fw_cfg. The following call
> > chains depend on (!xen_enabled()):
> maybe not, it's just grep gave me:
>   xen_load_linux() -> fw_cfg_init_io()
> maybe it's dead code now

[...]

> > 
> > pc_init1() | pc_q35_init()
> >   if (!xen_enabled()):
> >     pc_memory_init()
> >       bochs_bios_init()
> >         fw_cfg_init_io_dma()


We have a couple of idiosyncrasies with Xen support in QEMU; this is one
of them.

Xen doesn't use fw_cfg, because hvmloader [1][2] runs in guest context
before SeaBios setting things up, including ACPI tables. So usually we
don't need it. However direct kernel boot is done via xen_load_linux
which is based on fw_cfg. So when kernel= and ramdisk= are specified in
a Xen HVM config file (which is not common), they are passed to QEMU as
-kernel and -initrd, then QEMU ends up using fw_cfg to load the kernel
in the guest. That's the only use case we have for it at the moment.

Direct kernel boot with Xen HVM guests is not tested by OSSTest (Xen
Project CI loop), as a consequence it broke in the past without anybody
noticing.

[1]: http://xenbits.xenproject.org/gitweb/?p=xen.git;a=tree;f=tools/firmware/hvmloader;h=069e29fa3820364c69c95798d56ef097148fddd2;hb=HEAD
[2]: https://wiki.xenproject.org/wiki/Hvmloader
