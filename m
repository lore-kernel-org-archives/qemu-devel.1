Received: from eggs.gnu.org ([2001:4830:134:3::10]:60300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e9WNt-0004ls-7G
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e9WNm-0000rP-1p
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:15:13 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:50314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e9WNl-0000r1-Qg
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:15:05 -0400
Received: by mail-ua0-x243.google.com with SMTP id v27so11981375uav.7
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 06:15:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21B11A378@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E21B11A378@G01JPEXMBYT03>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Oct 2017 14:15:04 +0100
Message-ID: <CAJ+F1CJciWXg_-TCLVjhzQz_GnD-vrDbdC0vBMj-qcDquao=cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] fw_cfg: write vmcoreinfo details
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "somlo@cmu.edu" <somlo@cmu.edu>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Oct 30, 2017 at 10:44 AM, Hatayama, Daisuke <
d.hatayama@jp.fujitsu.com> wrote:

> Resend because the mail address for LKML was wrong in the previous mail..=
.
>
> Marc-Andre,
>
> Sorry, I missed your original mails from my local data, so I'm replying
> this mail as a new thread...
>
> > From: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> >
> > If the "etc/vmcoreinfo" file is present, write the addr/size of the
> > vmcoreinfo ELF note.
> >
> > Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> > ---
> >  drivers/firmware/qemu_fw_cfg.c | 80 ++++++++++++++++++++++++++++++
> +++++++++++-
> >  1 file changed, 79 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_
> cfg.c
> > index 19b4b4d31547..54b569da3257 100644
> > --- a/drivers/firmware/qemu_fw_cfg.c
> > +++ b/drivers/firmware/qemu_fw_cfg.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/io.h>
> >  #include <linux/ioport.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/crash_core.h>
> >
> >  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
> >  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
> > @@ -57,6 +58,8 @@ MODULE_LICENSE("GPL");
> >  /* fw_cfg "file name" is up to 56 characters (including terminating
> nul) */
> >  #define FW_CFG_MAX_FILE_PATH 56
> >
> > +#define VMCOREINFO_FORMAT_ELF 0x1
> > +
> >  /* platform device for dma mapping */
> >  static struct device *dev;
> >
> > @@ -107,7 +110,8 @@ static ssize_t fw_cfg_dma_transfer(void *address,
> u32 length, u32 control)
> >       dma_addr_t dma;
> >       ssize_t ret =3D length;
> >       enum dma_data_direction dir =3D
> > -             (control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0);
> > +             (control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0) |
> > +             (control & FW_CFG_DMA_CTL_WRITE ? DMA_TO_DEVICE : 0);
> >
> >       if (address && length) {
> >               dma_addr =3D dma_map_single(dev, address, length, dir);
> > @@ -203,6 +207,46 @@ static ssize_t fw_cfg_read_blob(u16 key,
> >       return ret;
> >  }
> >
> > +/* write chunk of given fw_cfg blob (caller responsible for
> sanity-check) */
> > +static ssize_t fw_cfg_write_blob(u16 key,
> > +                              void *buf, loff_t pos, size_t count)
> > +{
> > +     u32 glk =3D -1U;
> > +     acpi_status status;
> > +     ssize_t ret =3D count;
> > +
> > +     /* If we have ACPI, ensure mutual exclusion against any potential
> > +      * device access by the firmware, e.g. via AML methods:
> > +      */
> > +     status =3D acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
> > +     if (ACPI_FAILURE(status) && status !=3D AE_NOT_CONFIGURED) {
> > +             /* Should never get here */
> > +             WARN(1, "%s: Failed to lock ACPI!\n", __func__);
> > +             memset(buf, 0, count);
> > +             return -EBUSY;
> > +     }
> > +
> > +     mutex_lock(&fw_cfg_dev_lock);
> > +     if (pos =3D=3D 0) {
> > +             ret =3D fw_cfg_dma_transfer(buf, count, key << 16
> > +                                       | FW_CFG_DMA_CTL_SELECT
> > +                                       | FW_CFG_DMA_CTL_WRITE);
> > +     } else {
> > +             iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> > +             ret =3D fw_cfg_dma_transfer(0, pos, FW_CFG_DMA_CTL_SKIP);
> > +             if (ret < 0)
> > +                     goto end;
> > +             ret =3D fw_cfg_dma_transfer(buf, count,
> FW_CFG_DMA_CTL_WRITE);
> > +     }
> > +
> > +end:
> > +     mutex_unlock(&fw_cfg_dev_lock);
> > +
> > +     acpi_release_global_lock(glk);
> > +
> > +     return ret;
> > +}
> > +
> >  /* clean up fw_cfg device i/o */
> >  static void fw_cfg_io_cleanup(void)
> >  {
> > @@ -321,6 +365,35 @@ struct fw_cfg_sysfs_entry {
> >       struct list_head list;
> >  };
> >
> > +static ssize_t write_vmcoreinfo(const struct fw_cfg_file *f)
> > +{
> > +     struct vmci {
> > +             __le16 host_format;
> > +             __le16 guest_format;
> > +             __le32 size;
> > +             __le64 paddr;
> > +     } __packed;
> > +     struct vmci *data;
> > +     ssize_t ret;
> > +
> > +     data =3D kmalloc(sizeof(struct vmci), GFP_KERNEL | GFP_DMA);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     /* spare ourself reading host format support for now since we
> > +      * don't know what else to format - host may ignore ours
> > +      */
> > +     *data =3D (struct vmci) {
> > +             .guest_format =3D cpu_to_le16(VMCOREINFO_FORMAT_ELF),
> > +             .size =3D cpu_to_le32(VMCOREINFO_NOTE_SIZE),
> > +             .paddr =3D cpu_to_le64(paddr_vmcoreinfo_note())
> > +     };
> > +     ret =3D fw_cfg_write_blob(f->select, data, 0, sizeof(struct vmci)=
);
> > +
> > +     kfree(data);
> > +     return ret;
> > +}
> > +
> >  /* get fw_cfg_sysfs_entry from kobject member */
> >  static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *kobj=
)
> >  {
> > @@ -560,6 +633,11 @@ static int fw_cfg_register_file(const struct
> fw_cfg_file *f)
> >       int err;
> >       struct fw_cfg_sysfs_entry *entry;
> >
> > +     if (strcmp(f->name, "etc/vmcoreinfo") =3D=3D 0) {
> > +             if (write_vmcoreinfo(f) < 0)
> > +                     pr_warn("fw_cfg: failed to write vmcoreinfo");
> > +     }
> > +
>
> Here, it's necessary to care for guest machine to be running in the
> kdump capture kernel. How about the following patch? Without this,
> vmcoreinfo device is reinitialized by the kdump capture kernel, but
> what we need is the vmcoreinfo in the system kernel.
>
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_
> cfg.c
> index e2f2ad1..d51e4bb 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -35,6 +35,7 @@
>  #include <linux/ioport.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/crash_core.h>
> +#include <linux/crash_dump.h>
>
>  MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
>  MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
> @@ -653,6 +654,8 @@ static int fw_cfg_register_file(const struct
> fw_cfg_file *f)
>         struct fw_cfg_sysfs_entry *entry;
>
>         if (strcmp(f->name, "etc/vmcoreinfo") =3D=3D 0) {
> +               if (is_kdump_kernel())
> +                       return 0;
>                 if (write_vmcoreinfo(f) < 0)
>                         pr_warn("fw_cfg: failed to write vmcoreinfo");
>         }
>
> >       /* allocate new entry */
> >       entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> >       if (!entry)
>

That makes sense, I added a similar change in my patch.

Michael, do you want me to resubmit the series now or do you have more
comments regarding preliminary patches 1 and 2 ?

thanks



--=20
Marc-Andr=C3=A9 Lureau
