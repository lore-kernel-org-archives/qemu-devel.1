Received: from eggs.gnu.org ([2001:4830:134:3::10]:53645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eFJVc-0002je-TB
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eFJVZ-0005ci-HE
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eFJVZ-0005be-7j
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:43:05 -0500
Date: Thu, 16 Nov 2017 07:43:03 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2130338277.40704113.1510836183020.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171116033116-mutt-send-email-mst@kernel.org>
References: <20171113192750.6505-1-marcandre.lureau@redhat.com>
	<20171113192750.6505-4-marcandre.lureau@redhat.com>
	<20171116033116-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, somlo@cmu.edu, qemu-devel@nongnu.org

Hi

----- Original Message -----
> On Mon, Nov 13, 2017 at 08:27:48PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Modify fw_cfg_read_blob() to use DMA if the device supports it.
> > Return errors, because the operation may fail.
> >=20
> > To avoid polling with unbound amount of time, the DMA operation is
> > expected to complete within 200ms, or will return ETIME error.
> >=20
> > We may want to switch all the *buf addresses to use only kmalloc'ed
> > buffers (instead of using stack/image addresses with dma=3Dfalse).
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Gabriel Somlo <somlo@cmu.edu>
>=20
> This is causing issues for some people. I have reverted it for now.

I didn't know you merged it, where did it go?

If you are talking about kernel test robot, it seems to be the timeout. I p=
icked FW_CFG_DMA_TIMEOUT 200ms by guess, we may want to extend that for bus=
y hosts. How much? several seconds?

> I wonder why bother with DMA reads. Can we limit DMA to writes?

Well, we could, but DMA reads are supposedly quite faster. And if DMA read =
is broken, there are good chances that DMA write will too.

> > ---
> >  drivers/firmware/qemu_fw_cfg.c | 154
> >  ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 137 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/firmware/qemu_fw_cfg.c
> > b/drivers/firmware/qemu_fw_cfg.c
> > index 1f3e8545dab7..2ac4cd869fe6 100644
> > --- a/drivers/firmware/qemu_fw_cfg.c
> > +++ b/drivers/firmware/qemu_fw_cfg.c
> > @@ -33,6 +33,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/io.h>
> >  #include <linux/ioport.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > =20
> >  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
> >  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
> > @@ -43,12 +45,26 @@ MODULE_LICENSE("GPL");
> >  #define FW_CFG_ID         0x01
> >  #define FW_CFG_FILE_DIR   0x19
> > =20
> > +#define FW_CFG_VERSION_DMA     0x02
> > +#define FW_CFG_DMA_CTL_ERROR   0x01
> > +#define FW_CFG_DMA_CTL_READ    0x02
> > +#define FW_CFG_DMA_CTL_SKIP    0x04
> > +#define FW_CFG_DMA_CTL_SELECT  0x08
> > +#define FW_CFG_DMA_CTL_WRITE   0x10
> > +#define FW_CFG_DMA_TIMEOUT     200 /* ms */
> > +
> >  /* size in bytes of fw_cfg signature */
> >  #define FW_CFG_SIG_SIZE 4
> > =20
> >  /* fw_cfg "file name" is up to 56 characters (including terminating nu=
l)
> >  */
> >  #define FW_CFG_MAX_FILE_PATH 56
> > =20
> > +/* platform device for dma mapping */
> > +static struct device *dev;
> > +
> > +/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level d=
ir.
> > */
> > +static u32 fw_cfg_rev;
> > +
> >  /* fw_cfg file directory entry type */
> >  struct fw_cfg_file {
> >  =09u32 size;
> > @@ -57,6 +73,12 @@ struct fw_cfg_file {
> >  =09char name[FW_CFG_MAX_FILE_PATH];
> >  };
> > =20
> > +struct fw_cfg_dma {
> > +=09u32 control;
> > +=09u32 length;
> > +=09u64 address;
> > +} __packed;
> > +
> >  /* fw_cfg device i/o register addresses */
> >  static bool fw_cfg_is_mmio;
> >  static phys_addr_t fw_cfg_p_base;
> > @@ -75,12 +97,93 @@ static inline u16 fw_cfg_sel_endianness(u16 key)
> >  =09return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
> >  }
> > =20
> > +static inline bool fw_cfg_dma_enabled(void)
> > +{
> > +=09return fw_cfg_rev & FW_CFG_VERSION_DMA && fw_cfg_reg_dma;
> > +}
> > +
> > +static bool fw_cfg_wait_for_control(struct fw_cfg_dma *d, unsigned lon=
g
> > timeout)
> > +{
> > +=09ktime_t start;
> > +=09ktime_t stop;
> > +
> > +=09start =3D ktime_get();
> > +=09stop =3D ktime_add(start, ms_to_ktime(timeout));
> > +
> > +=09do {
> > +=09=09if ((be32_to_cpu(d->control) & ~FW_CFG_DMA_CTL_ERROR) =3D=3D 0)
> > +=09=09=09return true;
> > +
> > +=09=09usleep_range(50, 100);
> > +=09} while (ktime_before(ktime_get(), stop));
> > +
> > +=09return false;
> > +}
> > +
> > +static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 cont=
rol)
> > +{
> > +=09dma_addr_t dma_addr =3D 0;
> > +=09struct fw_cfg_dma *d;
> > +=09dma_addr_t dma;
> > +=09ssize_t ret =3D length;
> > +=09enum dma_data_direction dir =3D
> > +=09=09(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0);
> > +
> > +=09if (address && length) {
> > +=09=09dma_addr =3D dma_map_single(dev, address, length, dir);
> > +=09=09if (dma_mapping_error(NULL, dma_addr)) {
> > +=09=09=09WARN(1, "%s: failed to map address\n", __func__);
> > +=09=09=09return -EFAULT;
> > +=09=09}
> > +=09}
> > +
> > +=09d =3D kmalloc(sizeof(*d), GFP_KERNEL | GFP_DMA);
> > +=09if (!d) {
> > +=09=09ret =3D -ENOMEM;
> > +=09=09goto end;
> > +=09}
> > +
> > +=09dma =3D dma_map_single(dev, d, sizeof(*d), DMA_BIDIRECTIONAL);
> > +=09if (dma_mapping_error(NULL, dma)) {
> > +=09=09WARN(1, "%s: failed to map fw_cfg_dma\n", __func__);
> > +=09=09ret =3D -EFAULT;
> > +=09=09goto end;
> > +=09}
> > +
> > +=09*d =3D (struct fw_cfg_dma) {
> > +=09=09.address =3D cpu_to_be64(dma_addr),
> > +=09=09.length =3D cpu_to_be32(length),
> > +=09=09.control =3D cpu_to_be32(control)
> > +=09};
> > +
> > +=09iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
> > +=09iowrite32be(dma, fw_cfg_reg_dma + 4);
> > +
> > +=09if (!fw_cfg_wait_for_control(d, FW_CFG_DMA_TIMEOUT)) {
> > +=09=09WARN(1, "%s: timeout", __func__);
> > +=09=09ret =3D -ETIME;
> > +=09} else if (be32_to_cpu(d->control) & FW_CFG_DMA_CTL_ERROR) {
> > +=09=09ret =3D -EIO;
> > +=09}
> > +
> > +=09dma_unmap_single(dev, dma, sizeof(*d), DMA_BIDIRECTIONAL);
> > +
> > +end:
> > +=09kfree(d);
> > +=09if (dma_addr)
> > +=09=09dma_unmap_single(dev, dma_addr, length, dir);
> > +
> > +=09return ret;
> > +}
> > +
> >  /* read chunk of given fw_cfg blob (caller responsible for sanity-chec=
k)
> >  */
> > -static inline void fw_cfg_read_blob(u16 key,
> > -=09=09=09=09    void *buf, loff_t pos, size_t count)
> > +static ssize_t fw_cfg_read_blob(u16 key,
> > +=09=09=09=09void *buf, loff_t pos, size_t count,
> > +=09=09=09=09bool dma)
> >  {
> >  =09u32 glk =3D -1U;
> >  =09acpi_status status;
> > +=09ssize_t ret =3D count;
> > =20
> >  =09/* If we have ACPI, ensure mutual exclusion against any potential
> >  =09 * device access by the firmware, e.g. via AML methods:
> > @@ -90,17 +193,36 @@ static inline void fw_cfg_read_blob(u16 key,
> >  =09=09/* Should never get here */
> >  =09=09WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
> >  =09=09memset(buf, 0, count);
> > -=09=09return;
> > +=09=09return -EINVAL;
> >  =09}
> > =20
> >  =09mutex_lock(&fw_cfg_dev_lock);
> > -=09iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> > -=09while (pos-- > 0)
> > -=09=09ioread8(fw_cfg_reg_data);
> > -=09ioread8_rep(fw_cfg_reg_data, buf, count);
> > +=09if (dma && fw_cfg_dma_enabled()) {
> > +=09=09if (pos =3D=3D 0) {
> > +=09=09=09ret =3D fw_cfg_dma_transfer(buf, count, key << 16
> > +=09=09=09=09=09=09  | FW_CFG_DMA_CTL_SELECT
> > +=09=09=09=09=09=09  | FW_CFG_DMA_CTL_READ);
> > +=09=09} else {
> > +=09=09=09iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> > +=09=09=09ret =3D fw_cfg_dma_transfer(NULL, pos, FW_CFG_DMA_CTL_SKIP);
> > +=09=09=09if (ret < 0)
> > +=09=09=09=09goto end;
> > +=09=09=09ret =3D fw_cfg_dma_transfer(buf, count,
> > +=09=09=09=09=09=09  FW_CFG_DMA_CTL_READ);
> > +=09=09}
> > +=09} else {
> > +=09=09iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> > +=09=09while (pos-- > 0)
> > +=09=09=09ioread8(fw_cfg_reg_data);
> > +=09=09ioread8_rep(fw_cfg_reg_data, buf, count);
> > +=09}
> > +
> > +end:
> >  =09mutex_unlock(&fw_cfg_dev_lock);
> > =20
> >  =09acpi_release_global_lock(glk);
> > +
> > +=09return ret;
> >  }
> > =20
> >  /* clean up fw_cfg device i/o */
> > @@ -192,7 +314,7 @@ static int fw_cfg_do_platform_probe(struct
> > platform_device *pdev)
> >  #endif
> > =20
> >  =09/* verify fw_cfg device signature */
> > -=09fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE);
> > +=09fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE, false);
> >  =09if (memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) !=3D 0) {
> >  =09=09fw_cfg_io_cleanup();
> >  =09=09return -ENODEV;
> > @@ -201,9 +323,6 @@ static int fw_cfg_do_platform_probe(struct
> > platform_device *pdev)
> >  =09return 0;
> >  }
> > =20
> > -/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level d=
ir.
> > */
> > -static u32 fw_cfg_rev;
> > -
> >  static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, =
char
> >  *buf)
> >  {
> >  =09return sprintf(buf, "%u\n", fw_cfg_rev);
> > @@ -351,8 +470,7 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *f=
ilp,
> > struct kobject *kobj,
> >  =09if (count > entry->f.size - pos)
> >  =09=09count =3D entry->f.size - pos;
> > =20
> > -=09fw_cfg_read_blob(entry->f.select, buf, pos, count);
> > -=09return count;
> > +=09return fw_cfg_read_blob(entry->f.select, buf, pos, count, true);
> >  }
> > =20
> >  static struct bin_attribute fw_cfg_sysfs_attr_raw =3D {
> > @@ -505,7 +623,7 @@ static int fw_cfg_register_dir_entries(void)
> >  =09struct fw_cfg_file *dir;
> >  =09size_t dir_size;
> > =20
> > -=09fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count));
> > +=09fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count), false);
> >  =09count =3D be32_to_cpu(count);
> >  =09dir_size =3D count * sizeof(struct fw_cfg_file);
> > =20
> > @@ -513,7 +631,7 @@ static int fw_cfg_register_dir_entries(void)
> >  =09if (!dir)
> >  =09=09return -ENOMEM;
> > =20
> > -=09fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size);
> > +=09fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size, tru=
e);
> > =20
> >  =09for (i =3D 0; i < count; i++) {
> >  =09=09dir[i].size =3D be32_to_cpu(dir[i].size);
> > @@ -544,9 +662,10 @@ static int fw_cfg_sysfs_probe(struct platform_devi=
ce
> > *pdev)
> >  =09 * one fw_cfg device exist system-wide, so if one was already found
> >  =09 * earlier, we might as well stop here.
> >  =09 */
> > -=09if (fw_cfg_sel_ko)
> > +=09if (dev)
> >  =09=09return -EBUSY;
> > =20
> > +=09dev =3D &pdev->dev;
> >  =09/* create by_key and by_name subdirs of /sys/firmware/qemu_fw_cfg/ =
*/
> >  =09err =3D -ENOMEM;
> >  =09fw_cfg_sel_ko =3D kobject_create_and_add("by_key", fw_cfg_top_ko);
> > @@ -562,7 +681,7 @@ static int fw_cfg_sysfs_probe(struct platform_devic=
e
> > *pdev)
> >  =09=09goto err_probe;
> > =20
> >  =09/* get revision number, add matching top-level attribute */
> > -=09fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev));
> > +=09fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev), fal=
se);
> >  =09fw_cfg_rev =3D le32_to_cpu(fw_cfg_rev);
> >  =09err =3D sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
> >  =09if (err)
> > @@ -587,6 +706,7 @@ static int fw_cfg_sysfs_probe(struct platform_devic=
e
> > *pdev)
> >  err_name:
> >  =09fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
> >  err_sel:
> > +=09dev =3D NULL;
> >  =09return err;
> >  }
> > =20
> > --
> > 2.15.0.125.g8f49766d64
>=20
