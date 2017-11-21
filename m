Received: from eggs.gnu.org ([2001:4830:134:3::10]:35263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHBLV-00007T-5f
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHBLR-0007nU-0k
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:24:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eHBLQ-0007n8-Nx
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:24:20 -0500
Date: Tue, 21 Nov 2017 18:24:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171121181012-mutt-send-email-mst@kernel.org>
References: <20171120095519.15214-1-marcandre.lureau@redhat.com>
	<20171120095519.15214-4-marcandre.lureau@redhat.com>
	<20171120232407-mutt-send-email-mst@kernel.org>
	<1367386885.43304805.1511263066456.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1367386885.43304805.1511263066456.JavaMail.zimbra@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 3/5] fw_cfg: do DMA read operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, somlo@cmu.edu, xiaolong ye <xiaolong.ye@intel.com>

On Tue, Nov 21, 2017 at 06:17:46AM -0500, Marc-Andr=E9 Lureau wrote:
> > > @@ -57,6 +72,12 @@ struct fw_cfg_file {
> > >  	char name[FW_CFG_MAX_FILE_PATH];
> > >  };
> > > =20
> > > +struct fw_cfg_dma {
> > > +	u32 control;
> > > +	u32 length;
> > > +	u64 address;
> > > +} __packed;
> > > +
> > >  /* fw_cfg device i/o register addresses */
> > >  static bool fw_cfg_is_mmio;
> > >  static phys_addr_t fw_cfg_p_base;
> >=20
> > Drop __packed please. It causes many gcc versions to do insane things=
.
> > Can be a patch on top.
>=20
> Oh? I think __packed should translate to __attribute__((packed)) (inclu=
de/linux/compiler-gcc.h), there would be serious problems if gcc "do insa=
ne things" with it.

On some architectures it generates unnecessarily large code. E.g. it
assumes structure address might not be aligned.

> >=20
> >=20
> > > @@ -75,12 +96,79 @@ static inline u16 fw_cfg_sel_endianness(u16 key=
)
> > >  	return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
> > >  }
> > > =20
> > > +static inline bool fw_cfg_dma_enabled(void)
> > > +{
> > > +	return fw_cfg_rev & FW_CFG_VERSION_DMA && fw_cfg_reg_dma;
> > > +}
> > > +
> > > +/* qemu fw_cfg device is sync today, but spec says it may become a=
sync */
> > > +static void fw_cfg_wait_for_control(struct fw_cfg_dma *d, dma_addr=
_t dma)
> > > +{
> > > +	do {
> > > +		dma_sync_single_for_cpu(dev, dma, sizeof(*d), DMA_FROM_DEVICE);
> > > +		if ((be32_to_cpu(d->control) & ~FW_CFG_DMA_CTL_ERROR) =3D=3D 0)
> > > +			return;
> > > +
> > > +		usleep_range(50, 100);
> >=20
> > And since in practice we never get to this line,
> > maybe we should just go back to yield here.
>=20
> Or cond_resched() ?
>=20
> >=20
> > > +	} while (true);
> > > +}
> > > +
> > > +static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 =
control)
> > > +{
> > > +	dma_addr_t dma_addr =3D 0;
> > > +	static struct fw_cfg_dma d;
> > > +	dma_addr_t dma;
> > > +	ssize_t ret =3D length;
> > > +	enum dma_data_direction dir =3D
> > > +		(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0);
> > > +
> > > +	if (address && length) {
> > > +		dma_addr =3D dma_map_single(dev, address, length, dir);
> > > +		if (dma_mapping_error(NULL, dma_addr)) {
> > > +			WARN(1, "%s: failed to map address\n", __func__);
> > > +			return -EFAULT;
> > > +		}
> > > +	}
> > > +
> > > +	d =3D (struct fw_cfg_dma) {
> > > +		.address =3D cpu_to_be64(dma_addr),
> > > +		.length =3D cpu_to_be32(length),
> > > +		.control =3D cpu_to_be32(control)
> > > +	};
> > > +
> > > +	dma =3D dma_map_single(dev, &d, sizeof(d), DMA_BIDIRECTIONAL);
> > > +	if (dma_mapping_error(NULL, dma)) {
> > > +		WARN(1, "%s: failed to map fw_cfg_dma\n", __func__);
> > > +		ret =3D -EFAULT;
> > > +		goto end;
> > > +	}
> > > +
> > > +	iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
> > > +	iowrite32be(dma, fw_cfg_reg_dma + 4);
> > > +
> > > +	fw_cfg_wait_for_control(&d, dma);
> > > +
> > > +	if (be32_to_cpu(d.control) & FW_CFG_DMA_CTL_ERROR) {
> > > +		ret =3D -EIO;
> > > +	}
> > > +
> > > +	dma_unmap_single(dev, dma, sizeof(d), DMA_BIDIRECTIONAL);
> > > +
> > > +end:
> > > +	if (dma_addr)
> > > +		dma_unmap_single(dev, dma_addr, length, dir);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  /* read chunk of given fw_cfg blob (caller responsible for sanity-=
check)
> > >  */
> > > -static inline void fw_cfg_read_blob(u16 key,
> > > -				    void *buf, loff_t pos, size_t count)
> > > +static ssize_t fw_cfg_read_blob(u16 key,
> > > +				void *buf, loff_t pos, size_t count,
> > > +				bool dma)
> > >  {
> > >  	u32 glk =3D -1U;
> > >  	acpi_status status;
> > > +	ssize_t ret =3D count;
> > > =20
> > >  	/* If we have ACPI, ensure mutual exclusion against any potential
> > >  	 * device access by the firmware, e.g. via AML methods:
> > > @@ -90,17 +178,36 @@ static inline void fw_cfg_read_blob(u16 key,
> > >  		/* Should never get here */
> > >  		WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
> > >  		memset(buf, 0, count);
> > > -		return;
> > > +		return -EINVAL;
> > >  	}
> > > =20
> > >  	mutex_lock(&fw_cfg_dev_lock);
> > > -	iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> > > -	while (pos-- > 0)
> > > -		ioread8(fw_cfg_reg_data);
> > > -	ioread8_rep(fw_cfg_reg_data, buf, count);
> > > +	if (dma && fw_cfg_dma_enabled()) {
> > > +		if (pos =3D=3D 0) {
> > > +			ret =3D fw_cfg_dma_transfer(buf, count, key << 16
> > > +						  | FW_CFG_DMA_CTL_SELECT
> > > +						  | FW_CFG_DMA_CTL_READ);
> > > +		} else {
> > > +			iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> > > +			ret =3D fw_cfg_dma_transfer(NULL, pos, FW_CFG_DMA_CTL_SKIP);
> > > +			if (ret < 0)
> > > +				goto end;
> > > +			ret =3D fw_cfg_dma_transfer(buf, count,
> > > +						  FW_CFG_DMA_CTL_READ);
> > > +		}
> > > +	} else {
> > > +		iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> > > +		while (pos-- > 0)
> > > +			ioread8(fw_cfg_reg_data);
> > > +		ioread8_rep(fw_cfg_reg_data, buf, count);
> > > +	}
> > > +
> > > +end:
> > >  	mutex_unlock(&fw_cfg_dev_lock);
> > > =20
> > >  	acpi_release_global_lock(glk);
> > > +
> > > +	return ret;
> > >  }
> > > =20
> > >  /* clean up fw_cfg device i/o */
> > > @@ -192,7 +299,7 @@ static int fw_cfg_do_platform_probe(struct
> > > platform_device *pdev)
> > >  #endif
> > > =20
> > >  	/* verify fw_cfg device signature */
> > > -	fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE);
> > > +	fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE, false=
);
> > >  	if (memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) !=3D 0) {
> > >  		fw_cfg_io_cleanup();
> > >  		return -ENODEV;
> > > @@ -201,9 +308,6 @@ static int fw_cfg_do_platform_probe(struct
> > > platform_device *pdev)
> > >  	return 0;
> > >  }
> > > =20
> > > -/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-lev=
el dir.
> > > */
> > > -static u32 fw_cfg_rev;
> > > -
> > >  static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute =
*a, char
> > >  *buf)
> > >  {
> > >  	return sprintf(buf, "%u\n", fw_cfg_rev);
> > > @@ -351,8 +455,7 @@ static ssize_t fw_cfg_sysfs_read_raw(struct fil=
e *filp,
> > > struct kobject *kobj,
> > >  	if (count > entry->f.size - pos)
> > >  		count =3D entry->f.size - pos;
> > > =20
> > > -	fw_cfg_read_blob(entry->f.select, buf, pos, count);
> > > -	return count;
> > > +	return fw_cfg_read_blob(entry->f.select, buf, pos, count, true);
> > >  }
> > > =20
> > >  static struct bin_attribute fw_cfg_sysfs_attr_raw =3D {
> > > @@ -505,7 +608,7 @@ static int fw_cfg_register_dir_entries(void)
> > >  	struct fw_cfg_file *dir;
> > >  	size_t dir_size;
> > > =20
> > > -	fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count));
> > > +	fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count), false=
);
> > >  	count =3D be32_to_cpu(count);
> > >  	dir_size =3D count * sizeof(struct fw_cfg_file);
> > > =20
> > > @@ -513,7 +616,7 @@ static int fw_cfg_register_dir_entries(void)
> > >  	if (!dir)
> > >  		return -ENOMEM;
> > > =20
> > > -	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size);
> > > +	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size, t=
rue);
> > > =20
> > >  	for (i =3D 0; i < count; i++) {
> > >  		dir[i].size =3D be32_to_cpu(dir[i].size);
> > > @@ -544,9 +647,10 @@ static int fw_cfg_sysfs_probe(struct platform_=
device
> > > *pdev)
> > >  	 * one fw_cfg device exist system-wide, so if one was already fou=
nd
> > >  	 * earlier, we might as well stop here.
> > >  	 */
> > > -	if (fw_cfg_sel_ko)
> > > +	if (dev)
> > >  		return -EBUSY;
> > > =20
> > > +	dev =3D &pdev->dev;
> > >  	/* create by_key and by_name subdirs of /sys/firmware/qemu_fw_cfg=
/ */
> > >  	err =3D -ENOMEM;
> > >  	fw_cfg_sel_ko =3D kobject_create_and_add("by_key", fw_cfg_top_ko)=
;
> > > @@ -562,7 +666,7 @@ static int fw_cfg_sysfs_probe(struct platform_d=
evice
> > > *pdev)
> > >  		goto err_probe;
> > > =20
> > >  	/* get revision number, add matching top-level attribute */
> > > -	fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev));
> > > +	fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev), f=
alse);
> > >  	fw_cfg_rev =3D le32_to_cpu(fw_cfg_rev);
> > >  	err =3D sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
> > >  	if (err)
> > > @@ -587,6 +691,7 @@ static int fw_cfg_sysfs_probe(struct platform_d=
evice
> > > *pdev)
> > >  err_name:
> > >  	fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
> > >  err_sel:
> > > +	dev =3D NULL;
> > >  	return err;
> > >  }
> > > =20
> > > @@ -598,6 +703,7 @@ static int fw_cfg_sysfs_remove(struct platform_=
device
> > > *pdev)
> > >  	fw_cfg_io_cleanup();
> > >  	fw_cfg_kset_unregister_recursive(fw_cfg_fname_kset);
> > >  	fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
> > > +	dev =3D NULL;
> > >  	return 0;
> > >  }
> > > =20
> > > --
> > > 2.15.0.277.ga3d2ad2c43
> >=20
