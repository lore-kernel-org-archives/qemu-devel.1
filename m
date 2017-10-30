Received: from eggs.gnu.org ([2001:4830:134:3::10]:38561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e9Cmj-0001T4-He
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e9Cmd-0006r2-Ph
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:19:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e9Cmd-0006ps-Hx
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:19:27 -0400
Date: Mon, 30 Oct 2017 18:19:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171030181711-mutt-send-email-mst@kernel.org>
References: <33710E6CAA200E4583255F4FB666C4E21B120583@G01JPEXMBYT03>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21B120583@G01JPEXMBYT03>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/5] RFC: fw_cfg: add DMA write
 operation in sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "'marcandre.lureau@redhat.com'" <marcandre.lureau@redhat.com>, "'somlo@cmu.edu'" <somlo@cmu.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>

On Mon, Oct 30, 2017 at 11:07:20AM +0000, Hatayama, Daisuke wrote:
> > From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >
> > Since qemu 2.9, DMA write operations are allowed. However, usage of t=
his
> > interface from kernel or user-space is strongly discouraged by the
> > maintainers. This patch is meant for experimentations for now.
> >
>=20
> Could you (or maintainers?) tell me how experimental the DMA write
> operations from kernel are?
>=20
> From some technical reason?
> Or simply there has not been enough test yet so far?

The concern is security, talking from userspace to hypervisor
might become a trivial DOS vector.

If there's need for a specific entry to be accessible from userspace,
I'd rather white-list it.

> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  drivers/firmware/qemu_fw_cfg.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_f=
w_cfg.c
> > index 54b569da3257..e2f2ad1c9c0c 100644
> > --- a/drivers/firmware/qemu_fw_cfg.c
> > +++ b/drivers/firmware/qemu_fw_cfg.c
> > @@ -524,9 +524,28 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file=
 *filp, struct kobject *kobj,
> >       return fw_cfg_read_blob(entry->f.select, buf, pos, count, true)=
;
> >  }
> >
> > +static ssize_t fw_cfg_sysfs_write_raw(struct file *filp, struct kobj=
ect *kobj,
> > +                                   struct bin_attribute *bin_attr,
> > +                                   char *buf, loff_t pos, size_t cou=
nt)
> > +{
> > +     struct fw_cfg_sysfs_entry *entry =3D to_entry(kobj);
> > +
> > +     if (!fw_cfg_dma_enabled())
> > +             return -ENOTSUPP;
> > +
> > +     if (pos > entry->f.size)
> > +             return -EINVAL;
> > +
> > +     if (count > entry->f.size - pos)
> > +             count =3D entry->f.size - pos;
> > +
> > +     return fw_cfg_write_blob(entry->f.select, buf, pos, count);
> > +}
> > +
> >  static struct bin_attribute fw_cfg_sysfs_attr_raw =3D {
> > -     .attr =3D { .name =3D "raw", .mode =3D S_IRUSR },
> > +     .attr =3D { .name =3D "raw", .mode =3D S_IRUSR | S_IWUSR },
> >       .read =3D fw_cfg_sysfs_read_raw,
> > +     .write =3D fw_cfg_sysfs_write_raw,
> >  };
> >
> >  /*
> > --
> > 2.14.1.146.gd35faa819
>=20
> Thanks.
> HATAYAMA, Daisuke
>=20
