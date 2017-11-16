Received: from eggs.gnu.org ([2001:4830:134:3::10]:52446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eFKJJ-0005mD-Aw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eFKJF-0005Bf-2d
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:34:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eFKJE-00059s-QF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:34:25 -0500
Date: Thu, 16 Nov 2017 08:34:23 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <183118826.40770917.1510839263526.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171116035606-mutt-send-email-mst@kernel.org>
References: <20171113192958.22953-1-marcandre.lureau@redhat.com>
	<20171113192958.22953-6-marcandre.lureau@redhat.com>
	<20171116035606-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 5/5] fw_cfg: write vmcoreinfo details
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
> On Mon, Nov 13, 2017 at 08:29:58PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > If the "etc/vmcoreinfo" fw_cfg file is present and we are not running
> > the kdump kernel, write the addr/size of the vmcoreinfo ELF note.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Gabriel Somlo <somlo@cmu.edu>
> > ---
> >  drivers/firmware/qemu_fw_cfg.c | 87
> >  +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 86 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/firmware/qemu_fw_cfg.c
> > b/drivers/firmware/qemu_fw_cfg.c
> > index 2ac4cd869fe6..7a70e7a549f6 100644
> > --- a/drivers/firmware/qemu_fw_cfg.c
> > +++ b/drivers/firmware/qemu_fw_cfg.c
> > @@ -35,6 +35,8 @@
> >  #include <linux/ioport.h>
> >  #include <linux/delay.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/crash_core.h>
> > +#include <linux/crash_dump.h>
> > =20
> >  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
> >  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
> > @@ -59,6 +61,8 @@ MODULE_LICENSE("GPL");
> >  /* fw_cfg "file name" is up to 56 characters (including terminating nu=
l)
> >  */
> >  #define FW_CFG_MAX_FILE_PATH 56
> > =20
> > +#define VMCOREINFO_FORMAT_ELF 0x1
> > +
> >  /* platform device for dma mapping */
> >  static struct device *dev;
> > =20
> > @@ -127,7 +131,8 @@ static ssize_t fw_cfg_dma_transfer(void *address, u=
32
> > length, u32 control)
> >  =09dma_addr_t dma;
> >  =09ssize_t ret =3D length;
> >  =09enum dma_data_direction dir =3D
> > -=09=09(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0);
> > +=09=09(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0) |
> > +=09=09(control & FW_CFG_DMA_CTL_WRITE ? DMA_TO_DEVICE : 0);
> > =20
> >  =09if (address && length) {
> >  =09=09dma_addr =3D dma_map_single(dev, address, length, dir);
> > @@ -225,6 +230,48 @@ static ssize_t fw_cfg_read_blob(u16 key,
> >  =09return ret;
> >  }
> > =20
> > +#ifdef CONFIG_CRASH_CORE
> > +/* write chunk of given fw_cfg blob (caller responsible for sanity-che=
ck)
> > */
> > +static ssize_t fw_cfg_write_blob(u16 key,
> > +=09=09=09=09 void *buf, loff_t pos, size_t count)
> > +{
> > +=09u32 glk =3D -1U;
> > +=09acpi_status status;
> > +=09ssize_t ret =3D count;
> > +
> > +=09/* If we have ACPI, ensure mutual exclusion against any potential
> > +=09 * device access by the firmware, e.g. via AML methods:
> > +=09 */
> > +=09status =3D acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
> > +=09if (ACPI_FAILURE(status) && status !=3D AE_NOT_CONFIGURED) {
> > +=09=09/* Should never get here */
> > +=09=09WARN(1, "%s: Failed to lock ACPI!\n", __func__);
> > +=09=09memset(buf, 0, count);
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09mutex_lock(&fw_cfg_dev_lock);
> > +=09if (pos =3D=3D 0) {
> > +=09=09ret =3D fw_cfg_dma_transfer(buf, count, key << 16
> > +=09=09=09=09=09  | FW_CFG_DMA_CTL_SELECT
> > +=09=09=09=09=09  | FW_CFG_DMA_CTL_WRITE);
> > +=09} else {
> > +=09=09iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> > +=09=09ret =3D fw_cfg_dma_transfer(NULL, pos, FW_CFG_DMA_CTL_SKIP);
> > +=09=09if (ret < 0)
> > +=09=09=09goto end;
> > +=09=09ret =3D fw_cfg_dma_transfer(buf, count, FW_CFG_DMA_CTL_WRITE);
> > +=09}
> > +
> > +end:
> > +=09mutex_unlock(&fw_cfg_dev_lock);
> > +
> > +=09acpi_release_global_lock(glk);
> > +
> > +=09return ret;
> > +}
> > +#endif /* CONFIG_CRASH_CORE */
> > +
> >  /* clean up fw_cfg device i/o */
> >  static void fw_cfg_io_cleanup(void)
> >  {
> > @@ -343,6 +390,37 @@ struct fw_cfg_sysfs_entry {
> >  =09struct list_head list;
> >  };
> > =20
> > +#ifdef CONFIG_CRASH_CORE
> > +static ssize_t write_vmcoreinfo(const struct fw_cfg_file *f)
> > +{
> > +=09struct vmci {
> > +=09=09__le16 host_format;
> > +=09=09__le16 guest_format;
> > +=09=09__le32 size;
> > +=09=09__le64 paddr;
> > +=09} __packed;
> > +=09struct vmci *data;
> > +=09ssize_t ret;
> > +
> > +=09data =3D kmalloc(sizeof(struct vmci), GFP_KERNEL | GFP_DMA);
> > +=09if (!data)
> > +=09=09return -ENOMEM;
>=20
> It's a small bit of data - you can just keep it in a global variable,
> this way failures won't be an issue.

It would still need to be allocated with GFP_DMA. Since it's a one time thi=
ng, this is just moving the problem isn't it?

>=20
> > +
> > +=09/* spare ourself reading host format support for now since we
> > +=09 * don't know what else to format - host may ignore ours
> > +=09 */
> > +=09*data =3D (struct vmci) {
> > +=09=09.guest_format =3D cpu_to_le16(VMCOREINFO_FORMAT_ELF),
> > +=09=09.size =3D cpu_to_le32(VMCOREINFO_NOTE_SIZE),
> > +=09=09.paddr =3D cpu_to_le64(paddr_vmcoreinfo_note())
> > +=09};
> > +=09ret =3D fw_cfg_write_blob(f->select, data, 0, sizeof(struct vmci));
> > +
> > +=09kfree(data);
> > +=09return ret;
> > +}
> > +#endif /* CONFIG_CRASH_CORE */
> > +
> >  /* get fw_cfg_sysfs_entry from kobject member */
> >  static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *kobj=
)
> >  {
> > @@ -582,6 +660,13 @@ static int fw_cfg_register_file(const struct
> > fw_cfg_file *f)
> >  =09int err;
> >  =09struct fw_cfg_sysfs_entry *entry;
> > =20
> > +#ifdef CONFIG_CRASH_CORE
> > +=09if (strcmp(f->name, "etc/vmcoreinfo") =3D=3D 0 && !is_kdump_kernel(=
)) {
> > +=09=09if (write_vmcoreinfo(f) < 0)
> > +=09=09=09pr_warn("fw_cfg: failed to write vmcoreinfo");
> > +=09}
> > +#endif
> > +
> >  =09/* allocate new entry */
> >  =09entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> >  =09if (!entry)
> > --
> > 2.15.0.125.g8f49766d64
>=20
