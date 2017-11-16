Received: from eggs.gnu.org ([2001:4830:134:3::10]:48704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMfO-0005op-Ko
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMfE-0006TZ-Mr
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:05:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFMfE-0006RU-Ab
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:05:16 -0500
Date: Thu, 16 Nov 2017 18:05:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171116180302-mutt-send-email-mst@kernel.org>
References: <20171113192958.22953-1-marcandre.lureau@redhat.com>
	<20171113192958.22953-6-marcandre.lureau@redhat.com>
	<20171116035606-mutt-send-email-mst@kernel.org>
	<183118826.40770917.1510839263526.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <183118826.40770917.1510839263526.JavaMail.zimbra@redhat.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, somlo@cmu.edu, qemu-devel@nongnu.org

On Thu, Nov 16, 2017 at 08:34:23AM -0500, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
> > On Mon, Nov 13, 2017 at 08:29:58PM +0100, Marc-Andr=E9 Lureau wrote:
> > > If the "etc/vmcoreinfo" fw_cfg file is present and we are not runni=
ng
> > > the kdump kernel, write the addr/size of the vmcoreinfo ELF note.
> > >=20
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > Reviewed-by: Gabriel Somlo <somlo@cmu.edu>
> > > ---
> > >  drivers/firmware/qemu_fw_cfg.c | 87
> > >  +++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 86 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/firmware/qemu_fw_cfg.c
> > > b/drivers/firmware/qemu_fw_cfg.c
> > > index 2ac4cd869fe6..7a70e7a549f6 100644
> > > --- a/drivers/firmware/qemu_fw_cfg.c
> > > +++ b/drivers/firmware/qemu_fw_cfg.c
> > > @@ -35,6 +35,8 @@
> > >  #include <linux/ioport.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/dma-mapping.h>
> > > +#include <linux/crash_core.h>
> > > +#include <linux/crash_dump.h>
> > > =20
> > >  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
> > >  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
> > > @@ -59,6 +61,8 @@ MODULE_LICENSE("GPL");
> > >  /* fw_cfg "file name" is up to 56 characters (including terminatin=
g nul)
> > >  */
> > >  #define FW_CFG_MAX_FILE_PATH 56
> > > =20
> > > +#define VMCOREINFO_FORMAT_ELF 0x1
> > > +
> > >  /* platform device for dma mapping */
> > >  static struct device *dev;
> > > =20
> > > @@ -127,7 +131,8 @@ static ssize_t fw_cfg_dma_transfer(void *addres=
s, u32
> > > length, u32 control)
> > >  	dma_addr_t dma;
> > >  	ssize_t ret =3D length;
> > >  	enum dma_data_direction dir =3D
> > > -		(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0);
> > > +		(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0) |
> > > +		(control & FW_CFG_DMA_CTL_WRITE ? DMA_TO_DEVICE : 0);
> > > =20
> > >  	if (address && length) {
> > >  		dma_addr =3D dma_map_single(dev, address, length, dir);
> > > @@ -225,6 +230,48 @@ static ssize_t fw_cfg_read_blob(u16 key,
> > >  	return ret;
> > >  }
> > > =20
> > > +#ifdef CONFIG_CRASH_CORE
> > > +/* write chunk of given fw_cfg blob (caller responsible for sanity=
-check)
> > > */
> > > +static ssize_t fw_cfg_write_blob(u16 key,
> > > +				 void *buf, loff_t pos, size_t count)
> > > +{
> > > +	u32 glk =3D -1U;
> > > +	acpi_status status;
> > > +	ssize_t ret =3D count;
> > > +
> > > +	/* If we have ACPI, ensure mutual exclusion against any potential
> > > +	 * device access by the firmware, e.g. via AML methods:
> > > +	 */
> > > +	status =3D acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
> > > +	if (ACPI_FAILURE(status) && status !=3D AE_NOT_CONFIGURED) {
> > > +		/* Should never get here */
> > > +		WARN(1, "%s: Failed to lock ACPI!\n", __func__);
> > > +		memset(buf, 0, count);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	mutex_lock(&fw_cfg_dev_lock);
> > > +	if (pos =3D=3D 0) {
> > > +		ret =3D fw_cfg_dma_transfer(buf, count, key << 16
> > > +					  | FW_CFG_DMA_CTL_SELECT
> > > +					  | FW_CFG_DMA_CTL_WRITE);
> > > +	} else {
> > > +		iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> > > +		ret =3D fw_cfg_dma_transfer(NULL, pos, FW_CFG_DMA_CTL_SKIP);
> > > +		if (ret < 0)
> > > +			goto end;
> > > +		ret =3D fw_cfg_dma_transfer(buf, count, FW_CFG_DMA_CTL_WRITE);
> > > +	}
> > > +
> > > +end:
> > > +	mutex_unlock(&fw_cfg_dev_lock);
> > > +
> > > +	acpi_release_global_lock(glk);
> > > +
> > > +	return ret;
> > > +}
> > > +#endif /* CONFIG_CRASH_CORE */
> > > +
> > >  /* clean up fw_cfg device i/o */
> > >  static void fw_cfg_io_cleanup(void)
> > >  {
> > > @@ -343,6 +390,37 @@ struct fw_cfg_sysfs_entry {
> > >  	struct list_head list;
> > >  };
> > > =20
> > > +#ifdef CONFIG_CRASH_CORE
> > > +static ssize_t write_vmcoreinfo(const struct fw_cfg_file *f)
> > > +{
> > > +	struct vmci {
> > > +		__le16 host_format;
> > > +		__le16 guest_format;
> > > +		__le32 size;
> > > +		__le64 paddr;
> > > +	} __packed;
> > > +	struct vmci *data;
> > > +	ssize_t ret;
> > > +
> > > +	data =3D kmalloc(sizeof(struct vmci), GFP_KERNEL | GFP_DMA);
> > > +	if (!data)
> > > +		return -ENOMEM;
> >=20
> > It's a small bit of data - you can just keep it in a global variable,
> > this way failures won't be an issue.
>=20
> It would still need to be allocated

No - you can just make it a global variable.

> with GFP_DMA.

Are you sure?

 * GFP_DMA exists for historical reasons and should be avoided where poss=
ible.
 *   The flags indicates that the caller requires that the lowest zone be
 *   used (ZONE_DMA or 16M on x86-64). Ideally, this would be removed but
 *   it would require careful auditing as some users really require it an=
d
 *   others use the flag to avoid lowmem reserves in ZONE_DMA and treat t=
he
 *   lowest zone as a type of emergency reserve.


> Since it's a one time thing, this is just moving the problem isn't it?

Isn't the timeout just moving the problem too?
Avoiding memory corruption is a priority.

> >=20
> > > +
> > > +	/* spare ourself reading host format support for now since we
> > > +	 * don't know what else to format - host may ignore ours
> > > +	 */
> > > +	*data =3D (struct vmci) {
> > > +		.guest_format =3D cpu_to_le16(VMCOREINFO_FORMAT_ELF),
> > > +		.size =3D cpu_to_le32(VMCOREINFO_NOTE_SIZE),
> > > +		.paddr =3D cpu_to_le64(paddr_vmcoreinfo_note())
> > > +	};
> > > +	ret =3D fw_cfg_write_blob(f->select, data, 0, sizeof(struct vmci)=
);
> > > +
> > > +	kfree(data);
> > > +	return ret;
> > > +}
> > > +#endif /* CONFIG_CRASH_CORE */
> > > +
> > >  /* get fw_cfg_sysfs_entry from kobject member */
> > >  static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *=
kobj)
> > >  {
> > > @@ -582,6 +660,13 @@ static int fw_cfg_register_file(const struct
> > > fw_cfg_file *f)
> > >  	int err;
> > >  	struct fw_cfg_sysfs_entry *entry;
> > > =20
> > > +#ifdef CONFIG_CRASH_CORE
> > > +	if (strcmp(f->name, "etc/vmcoreinfo") =3D=3D 0 && !is_kdump_kerne=
l()) {
> > > +		if (write_vmcoreinfo(f) < 0)
> > > +			pr_warn("fw_cfg: failed to write vmcoreinfo");
> > > +	}
> > > +#endif
> > > +
> > >  	/* allocate new entry */
> > >  	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> > >  	if (!entry)
> > > --
> > > 2.15.0.125.g8f49766d64
> >=20
