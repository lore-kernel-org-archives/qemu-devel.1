Received: from eggs.gnu.org ([2001:4830:134:3::10]:58692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeBhU-0006Gp-9Q
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 22:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeBgg-0005ai-Rk
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 22:26:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eeBgf-0005Wz-Vf
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 22:25:22 -0500
Date: Wed, 24 Jan 2018 11:25:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180124032505.GD8001@xz-mi>
References: <20180123164041.30339-1-marcandre.lureau@redhat.com>
	<20180123164041.30339-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180123164041.30339-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 2/4] fw_cfg: do DMA read operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, bhe@redhat.com, slp@redhat.com, mst@redhat.com, somlo@cmu.edu, xiaolong.ye@intel.com, qemu-devel@nongnu.org

On Tue, Jan 23, 2018 at 05:40:39PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Modify fw_cfg_read_blob() to use DMA if the device supports it.
> Return errors, because the operation may fail.
>=20
> The DMA operation is expected to run synchronously with today qemu,
> but the specification states that it may become async, so we run
> "control" field check in a loop for eventual changes.
>=20
> We may want to switch all the *buf addresses to use only kmalloc'ed
> buffers (instead of using stack/image addresses with dma=3Dfalse).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 131 +++++++++++++++++++++++++++++++++=
+-------
>  1 file changed, 111 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_=
cfg.c
> index 740df0df2260..686f0e839858 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -33,6 +33,7 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/delay.h>
> =20
>  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
>  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
> @@ -43,12 +44,22 @@ MODULE_LICENSE("GPL");
>  #define FW_CFG_ID         0x01
>  #define FW_CFG_FILE_DIR   0x19
> =20
> +#define FW_CFG_VERSION_DMA     0x02
> +#define FW_CFG_DMA_CTL_ERROR   0x01
> +#define FW_CFG_DMA_CTL_READ    0x02
> +#define FW_CFG_DMA_CTL_SKIP    0x04
> +#define FW_CFG_DMA_CTL_SELECT  0x08
> +#define FW_CFG_DMA_CTL_WRITE   0x10
> +
>  /* size in bytes of fw_cfg signature */
>  #define FW_CFG_SIG_SIZE 4
> =20
>  /* fw_cfg "file name" is up to 56 characters (including terminating nu=
l) */
>  #define FW_CFG_MAX_FILE_PATH 56
> =20
> +/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level d=
ir. */
> +static u32 fw_cfg_rev;
> +
>  /* fw_cfg file directory entry type */
>  struct fw_cfg_file {
>  	u32 size;
> @@ -57,6 +68,12 @@ struct fw_cfg_file {
>  	char name[FW_CFG_MAX_FILE_PATH];
>  };
> =20
> +struct fw_cfg_dma {
> +	u32 control;
> +	u32 length;
> +	u64 address;
> +} __packed;
> +
>  /* fw_cfg device i/o register addresses */
>  static bool fw_cfg_is_mmio;
>  static phys_addr_t fw_cfg_p_base;
> @@ -75,12 +92,68 @@ static inline u16 fw_cfg_sel_endianness(u16 key)
>  	return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
>  }
> =20
> +static inline bool fw_cfg_dma_enabled(void)
> +{
> +	return fw_cfg_rev & FW_CFG_VERSION_DMA && fw_cfg_reg_dma;
> +}
> +
> +/* qemu fw_cfg device is sync today, but spec says it may become async=
 */
> +static void fw_cfg_wait_for_control(struct fw_cfg_dma *d)
> +{
> +	do {
> +		u32 ctrl =3D be32_to_cpu(READ_ONCE(d->control));
> +
> +		if ((ctrl & ~FW_CFG_DMA_CTL_ERROR) =3D=3D 0)
> +			return;
> +
> +		usleep_range(50, 100);
> +	} while (true);
> +}
> +
> +static ssize_t fw_cfg_dma_transfer(struct device *dev,
> +				void *address, u32 length, u32 control)
> +{
> +	phys_addr_t dma;
> +	struct fw_cfg_dma *d =3D NULL;
> +	ssize_t ret =3D length;
> +
> +	d =3D kmalloc(sizeof(*d), GFP_KERNEL);
> +	if (!d) {
> +		ret =3D -ENOMEM;
> +		goto end;
> +	}
> +
> +	*d =3D (struct fw_cfg_dma) {
> +		.address =3D cpu_to_be64(virt_to_phys(address)),
> +		.length =3D cpu_to_be32(length),
> +		.control =3D cpu_to_be32(control)
> +	};
> +
> +	dma =3D virt_to_phys(d);
> +
> +	iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
> +	iowrite32be(dma, fw_cfg_reg_dma + 4);

We can do it with iowrite64be(virt_to_phys(d)) too?  In all cases I
think it's good enough and no worth for a repost.

For the DMA transfer part:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

--=20
Peter Xu
