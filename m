Received: from eggs.gnu.org ([2001:4830:134:3::10]:37828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF1Tn-0002t4-QJ
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 12:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF1Tk-0005Je-KV
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 12:28:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eF1Tk-0005IE-95
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 12:28:00 -0500
Date: Wed, 15 Nov 2017 19:27:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171115192404-mutt-send-email-mst@kernel.org>
References: <20171113192958.22953-1-marcandre.lureau@redhat.com>
	<20171113192958.22953-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171113192958.22953-4-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/5] fw_cfg: do DMA read operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, somlo@cmu.edu, qemu-devel@nongnu.org

On Mon, Nov 13, 2017 at 08:29:56PM +0100, Marc-Andr=E9 Lureau wrote:
> Modify fw_cfg_read_blob() to use DMA if the device supports it.
> Return errors, because the operation may fail.
>=20
> To avoid polling with unbound amount of time, the DMA operation is
> expected to complete within 200ms, or will return ETIME error.
>=20
> We may want to switch all the *buf addresses to use only kmalloc'ed
> buffers (instead of using stack/image addresses with dma=3Dfalse).
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Gabriel Somlo <somlo@cmu.edu>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 154 +++++++++++++++++++++++++++++++++=
+++-----
>  1 file changed, 137 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_=
cfg.c
> index 1f3e8545dab7..2ac4cd869fe6 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -33,6 +33,8 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> =20
>  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
>  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
> @@ -43,12 +45,26 @@ MODULE_LICENSE("GPL");
>  #define FW_CFG_ID         0x01
>  #define FW_CFG_FILE_DIR   0x19
> =20
> +#define FW_CFG_VERSION_DMA     0x02
> +#define FW_CFG_DMA_CTL_ERROR   0x01
> +#define FW_CFG_DMA_CTL_READ    0x02
> +#define FW_CFG_DMA_CTL_SKIP    0x04
> +#define FW_CFG_DMA_CTL_SELECT  0x08
> +#define FW_CFG_DMA_CTL_WRITE   0x10
> +#define FW_CFG_DMA_TIMEOUT     200 /* ms */
> +
>  /* size in bytes of fw_cfg signature */
>  #define FW_CFG_SIG_SIZE 4
> =20
>  /* fw_cfg "file name" is up to 56 characters (including terminating nu=
l) */
>  #define FW_CFG_MAX_FILE_PATH 56
> =20
> +/* platform device for dma mapping */
> +static struct device *dev;
> +
> +/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level d=
ir. */
> +static u32 fw_cfg_rev;
> +
>  /* fw_cfg file directory entry type */
>  struct fw_cfg_file {
>  	u32 size;
> @@ -57,6 +73,12 @@ struct fw_cfg_file {
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
> @@ -75,12 +97,93 @@ static inline u16 fw_cfg_sel_endianness(u16 key)
>  	return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
>  }
> =20
> +static inline bool fw_cfg_dma_enabled(void)
> +{
> +	return fw_cfg_rev & FW_CFG_VERSION_DMA && fw_cfg_reg_dma;
> +}
> +
> +static bool fw_cfg_wait_for_control(struct fw_cfg_dma *d, unsigned lon=
g timeout)
> +{
> +	ktime_t start;
> +	ktime_t stop;
> +
> +	start =3D ktime_get();
> +	stop =3D ktime_add(start, ms_to_ktime(timeout));
> +
> +	do {
> +		if ((be32_to_cpu(d->control) & ~FW_CFG_DMA_CTL_ERROR) =3D=3D 0)
> +			return true;
> +
> +		usleep_range(50, 100);

BTW it's not nice that this is uninterruptible. I think we need a
variant of usleep_range that is interruptible and call that here.
Thoughts?


> +	} while (ktime_before(ktime_get(), stop));
> +
> +	return false;
> +}
> +
> +static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 cont=
rol)
> +{
> +	dma_addr_t dma_addr =3D 0;
> +	struct fw_cfg_dma *d;
> +	dma_addr_t dma;
> +	ssize_t ret =3D length;
> +	enum dma_data_direction dir =3D
> +		(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0);
> +
> +	if (address && length) {
> +		dma_addr =3D dma_map_single(dev, address, length, dir);
> +		if (dma_mapping_error(NULL, dma_addr)) {
> +			WARN(1, "%s: failed to map address\n", __func__);
> +			return -EFAULT;
> +		}
> +	}
> +
> +	d =3D kmalloc(sizeof(*d), GFP_KERNEL | GFP_DMA);
> +	if (!d) {
> +		ret =3D -ENOMEM;
> +		goto end;
> +	}
> +
> +	dma =3D dma_map_single(dev, d, sizeof(*d), DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(NULL, dma)) {
> +		WARN(1, "%s: failed to map fw_cfg_dma\n", __func__);
> +		ret =3D -EFAULT;
> +		goto end;
> +	}
> +
> +	*d =3D (struct fw_cfg_dma) {
> +		.address =3D cpu_to_be64(dma_addr),
> +		.length =3D cpu_to_be32(length),
> +		.control =3D cpu_to_be32(control)
> +	};
> +
> +	iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
> +	iowrite32be(dma, fw_cfg_reg_dma + 4);
> +
> +	if (!fw_cfg_wait_for_control(d, FW_CFG_DMA_TIMEOUT)) {
> +		WARN(1, "%s: timeout", __func__);
> +		ret =3D -ETIME;
> +	} else if (be32_to_cpu(d->control) & FW_CFG_DMA_CTL_ERROR) {
> +		ret =3D -EIO;
> +	}
> +
> +	dma_unmap_single(dev, dma, sizeof(*d), DMA_BIDIRECTIONAL);
> +
> +end:
> +	kfree(d);
> +	if (dma_addr)
> +		dma_unmap_single(dev, dma_addr, length, dir);

So if host was delayed what this does is corrupt guest memory.
IMHO things are already bad, let's at least keep it mapped
and allocated. Also what will heppen on next access attempt?
Maybe we need to prevent further attempts.
And maybe fw cfg needs a reset register so we can recover
faster.



> +
> +	return ret;
> +}
> +
>  /* read chunk of given fw_cfg blob (caller responsible for sanity-chec=
k) */
> -static inline void fw_cfg_read_blob(u16 key,
> -				    void *buf, loff_t pos, size_t count)
> +static ssize_t fw_cfg_read_blob(u16 key,
> +				void *buf, loff_t pos, size_t count,
> +				bool dma)
>  {
>  	u32 glk =3D -1U;
>  	acpi_status status;
> +	ssize_t ret =3D count;
> =20
>  	/* If we have ACPI, ensure mutual exclusion against any potential
>  	 * device access by the firmware, e.g. via AML methods:
> @@ -90,17 +193,36 @@ static inline void fw_cfg_read_blob(u16 key,
>  		/* Should never get here */
>  		WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
>  		memset(buf, 0, count);
> -		return;
> +		return -EINVAL;
>  	}
> =20
>  	mutex_lock(&fw_cfg_dev_lock);
> -	iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> -	while (pos-- > 0)
> -		ioread8(fw_cfg_reg_data);
> -	ioread8_rep(fw_cfg_reg_data, buf, count);
> +	if (dma && fw_cfg_dma_enabled()) {
> +		if (pos =3D=3D 0) {
> +			ret =3D fw_cfg_dma_transfer(buf, count, key << 16
> +						  | FW_CFG_DMA_CTL_SELECT
> +						  | FW_CFG_DMA_CTL_READ);
> +		} else {
> +			iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> +			ret =3D fw_cfg_dma_transfer(NULL, pos, FW_CFG_DMA_CTL_SKIP);
> +			if (ret < 0)
> +				goto end;
> +			ret =3D fw_cfg_dma_transfer(buf, count,
> +						  FW_CFG_DMA_CTL_READ);
> +		}
> +	} else {
> +		iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> +		while (pos-- > 0)
> +			ioread8(fw_cfg_reg_data);
> +		ioread8_rep(fw_cfg_reg_data, buf, count);
> +	}
> +
> +end:
>  	mutex_unlock(&fw_cfg_dev_lock);
> =20
>  	acpi_release_global_lock(glk);
> +
> +	return ret;
>  }
> =20
>  /* clean up fw_cfg device i/o */
> @@ -192,7 +314,7 @@ static int fw_cfg_do_platform_probe(struct platform=
_device *pdev)
>  #endif
> =20
>  	/* verify fw_cfg device signature */
> -	fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE);
> +	fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE, false);
>  	if (memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) !=3D 0) {
>  		fw_cfg_io_cleanup();
>  		return -ENODEV;
> @@ -201,9 +323,6 @@ static int fw_cfg_do_platform_probe(struct platform=
_device *pdev)
>  	return 0;
>  }
> =20
> -/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level d=
ir. */
> -static u32 fw_cfg_rev;
> -
>  static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, =
char *buf)
>  {
>  	return sprintf(buf, "%u\n", fw_cfg_rev);
> @@ -351,8 +470,7 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *f=
ilp, struct kobject *kobj,
>  	if (count > entry->f.size - pos)
>  		count =3D entry->f.size - pos;
> =20
> -	fw_cfg_read_blob(entry->f.select, buf, pos, count);
> -	return count;
> +	return fw_cfg_read_blob(entry->f.select, buf, pos, count, true);
>  }
> =20
>  static struct bin_attribute fw_cfg_sysfs_attr_raw =3D {
> @@ -505,7 +623,7 @@ static int fw_cfg_register_dir_entries(void)
>  	struct fw_cfg_file *dir;
>  	size_t dir_size;
> =20
> -	fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count));
> +	fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count), false);
>  	count =3D be32_to_cpu(count);
>  	dir_size =3D count * sizeof(struct fw_cfg_file);
> =20
> @@ -513,7 +631,7 @@ static int fw_cfg_register_dir_entries(void)
>  	if (!dir)
>  		return -ENOMEM;
> =20
> -	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size);
> +	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size, true)=
;
> =20
>  	for (i =3D 0; i < count; i++) {
>  		dir[i].size =3D be32_to_cpu(dir[i].size);
> @@ -544,9 +662,10 @@ static int fw_cfg_sysfs_probe(struct platform_devi=
ce *pdev)
>  	 * one fw_cfg device exist system-wide, so if one was already found
>  	 * earlier, we might as well stop here.
>  	 */
> -	if (fw_cfg_sel_ko)
> +	if (dev)
>  		return -EBUSY;
> =20
> +	dev =3D &pdev->dev;
>  	/* create by_key and by_name subdirs of /sys/firmware/qemu_fw_cfg/ */
>  	err =3D -ENOMEM;
>  	fw_cfg_sel_ko =3D kobject_create_and_add("by_key", fw_cfg_top_ko);
> @@ -562,7 +681,7 @@ static int fw_cfg_sysfs_probe(struct platform_devic=
e *pdev)
>  		goto err_probe;
> =20
>  	/* get revision number, add matching top-level attribute */
> -	fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev));
> +	fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev), false=
);
>  	fw_cfg_rev =3D le32_to_cpu(fw_cfg_rev);
>  	err =3D sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
>  	if (err)
> @@ -587,6 +706,7 @@ static int fw_cfg_sysfs_probe(struct platform_devic=
e *pdev)
>  err_name:
>  	fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
>  err_sel:
> +	dev =3D NULL;
>  	return err;
>  }
> =20
> --=20
> 2.15.0.125.g8f49766d64
