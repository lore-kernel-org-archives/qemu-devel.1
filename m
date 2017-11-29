Received: from eggs.gnu.org ([2001:4830:134:3::10]:55571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJr6F-0001Sb-F7
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJr6B-000322-DH
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:23:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eJr6B-00031p-5v
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:23:39 -0500
Date: Wed, 29 Nov 2017 03:23:33 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171129032314-mutt-send-email-mst@kernel.org>
References: <20171123140206.3911-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171123140206.3911-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 0/5] fw_cfg: add DMA operations &
 etc/vmcoreinfo support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, somlo@cmu.edu, xiaolong.ye@intel.com, qemu-devel@nongnu.org

On Thu, Nov 23, 2017 at 03:02:01PM +0100, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> This series adds DMA operations support to the qemu fw_cfg kernel
> module and populates "etc/vmcoreinfo" with vmcoreinfo location
> details.
>=20
> Note: the support for this entry handling has been merged for upcoming
> qemu release (2.11).

I parked this on vhost branch, part of linux-next.

> v8:
> - fix ltp again: bring back kmalloc() for DMA memory (see "What memory
>   is DMA'able?" limitations in Documentation/DMA-API-HOWTO.txt)
>   Interestingly, it didn't fail when the module was linked in..
>=20
> v7:
> - add a patch to fix driver remove()
> - remove DMA operatiom timeout (qemu finishes sync today)
> - synchronize the DMA transfer before reading from CPU
> - removed kmalloc() use static allocation instead
> - drop some r-b tags
>=20
> v6:
> - change acpi_acquire_global_lock() error to return EINVAL
>   (instead of EBUSY)
> - replace 0 as pointer argument for NULL
> - add Gabriel r-b/a-b tags
>=20
> v5:
> - resent to CC kdump people on the paddr_vmcoreinfo_note() export patch
>=20
> v4:
> - export paddr_vmcoreinfo_note() to fix fw_cfg.ko build
> - fix build with !CONFIG_CRASH_CORE
> - replace the unbounded yield() loop with a usleep_range() loop and a
>   200ms timeout
> - do not write vmcoreinfo entry when running the kdump kernel (D. Hatay=
ama)
> - drop the experimental sysfs write support patch from this series
>=20
> v3: (thanks kbuild)
> - add "fw_cfg: fix the command line module name" patch
> - fix build of "fw_cfg: add DMA register" with CONFIG_FW_CFG_SYSFS_CMDL=
INE=3Dy
> - fix 'Wshift-count-overflow'
>=20
> v2:
> - use platform device for dma mapping
> - add etc/vmcoreinfo patch
> - some code cleanups
>=20
> Marc-Andr=E9 Lureau (5):
>   fw_cfg: fix driver remove
>   fw_cfg: add DMA register
>   fw_cfg: do DMA read operation
>   crash: export paddr_vmcoreinfo_note()
>   fw_cfg: write vmcoreinfo details
>=20
>  drivers/firmware/qemu_fw_cfg.c | 283 +++++++++++++++++++++++++++++++++=
+++-----
>  kernel/crash_core.c            |   1 +
>  2 files changed, 254 insertions(+), 30 deletions(-)
>=20
> --=20
> 2.15.0.277.ga3d2ad2c43
