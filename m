Received: from eggs.gnu.org ([2001:4830:134:3::10]:50827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHjus-0001UK-Fi
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 00:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHjuo-0003QM-H9
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 00:19:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eHjuo-0003Pj-As
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 00:19:10 -0500
Date: Thu, 23 Nov 2017 07:19:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171123071842-mutt-send-email-mst@kernel.org>
References: <20171120095519.15214-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171120095519.15214-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/5] fw_cfg: add DMA operations &
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
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, somlo@cmu.edu, xiaolong.ye@intel.com

On Mon, Nov 20, 2017 at 10:55:14AM +0100, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> This series adds DMA operations support to the qemu fw_cfg kernel
> module and populates "etc/vmcoreinfo" with vmcoreinfo location
> details.
>=20
> Note: the support for this entry handling has been merged for upcoming
> qemu release (2.11).

Does not help. Still get crashes from ltp.

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
>  drivers/firmware/qemu_fw_cfg.c | 276 +++++++++++++++++++++++++++++++++=
+++-----
>  kernel/crash_core.c            |   1 +
>  2 files changed, 247 insertions(+), 30 deletions(-)
>=20
> --=20
> 2.15.0.277.ga3d2ad2c43
