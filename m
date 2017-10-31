Received: from eggs.gnu.org ([2001:4830:134:3::10]:39289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e9ZzT-0004pc-69
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e9ZzP-0004VV-4a
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e9ZzO-0004Uu-RL
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:06:11 -0400
Date: Tue, 31 Oct 2017 19:06:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171031185505-mutt-send-email-mst@kernel.org>
References: <33710E6CAA200E4583255F4FB666C4E21B120583@G01JPEXMBYT03>
	<20171030181711-mutt-send-email-mst@kernel.org>
	<33710E6CAA200E4583255F4FB666C4E21B153BF6@G01JPEXMBYT03>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21B153BF6@G01JPEXMBYT03>
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

On Tue, Oct 31, 2017 at 09:55:39AM +0000, Hatayama, Daisuke wrote:
>=20
>=20
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Michael S. T=
sirkin
> > Sent: Tuesday, October 31, 2017 1:19 AM
> > To: Hatayama, Daisuke <d.hatayama@jp.fujitsu.com>
> > Cc: 'marcandre.lureau@redhat.com' <marcandre.lureau@redhat.com>;
> > 'somlo@cmu.edu' <somlo@cmu.edu>; linux-kernel@vger.kernel.org;
> > 'qemu-devel@nongnu.org' <qemu-devel@nongnu.org>
> > Subject: Re: [PATCH v3 5/5] RFC: fw_cfg: add DMA write operation in s=
ysfs
> >=20
> > On Mon, Oct 30, 2017 at 11:07:20AM +0000, Hatayama, Daisuke wrote:
> > > > From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > >
> > > > Since qemu 2.9, DMA write operations are allowed. However, usage =
of this
> > > > interface from kernel or user-space is strongly discouraged by th=
e
> > > > maintainers. This patch is meant for experimentations for now.
> > > >
> > >
> > > Could you (or maintainers?) tell me how experimental the DMA write
> > > operations from kernel are?
> > >
> > > From some technical reason?
> > > Or simply there has not been enough test yet so far?
> >=20
> > The concern is security, talking from userspace to hypervisor
> > might become a trivial DOS vector.
> >=20
> > If there's need for a specific entry to be accessible from userspace,
> > I'd rather white-list it.
> >=20
>=20
> Thanks for the explanation.
>=20
> If so, I guess the white-list is done in userspace qemu side,
> and no additional change would be needed for this kernel-side patch set=
 for the white-list feature.
> Is this understanding correct?

No - host side has no idea whether it's guest userspace or
kernel initiating the access.

> > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  drivers/firmware/qemu_fw_cfg.c | 21 ++++++++++++++++++++-
> > > >  1 file changed, 20 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/qemu_fw_cfg.c
> > b/drivers/firmware/qemu_fw_cfg.c
> > > > index 54b569da3257..e2f2ad1c9c0c 100644
> > > > --- a/drivers/firmware/qemu_fw_cfg.c
> > > > +++ b/drivers/firmware/qemu_fw_cfg.c
> > > > @@ -524,9 +524,28 @@ static ssize_t fw_cfg_sysfs_read_raw(struct =
file *filp,
> > struct kobject *kobj,
> > > >       return fw_cfg_read_blob(entry->f.select, buf, pos, count, t=
rue);
> > > >  }
> > > >
> > > > +static ssize_t fw_cfg_sysfs_write_raw(struct file *filp, struct =
kobject
> > *kobj,
> > > > +                                   struct bin_attribute *bin_att=
r,
> > > > +                                   char *buf, loff_t pos, size_t=
 count)
> > > > +{
> > > > +     struct fw_cfg_sysfs_entry *entry =3D to_entry(kobj);
> > > > +
> > > > +     if (!fw_cfg_dma_enabled())
> > > > +             return -ENOTSUPP;
> > > > +
> > > > +     if (pos > entry->f.size)
> > > > +             return -EINVAL;
> > > > +
> > > > +     if (count > entry->f.size - pos)
> > > > +             count =3D entry->f.size - pos;
> > > > +
> > > > +     return fw_cfg_write_blob(entry->f.select, buf, pos, count);
> > > > +}
> > > > +
> > > >  static struct bin_attribute fw_cfg_sysfs_attr_raw =3D {
> > > > -     .attr =3D { .name =3D "raw", .mode =3D S_IRUSR },
> > > > +     .attr =3D { .name =3D "raw", .mode =3D S_IRUSR | S_IWUSR },
> > > >       .read =3D fw_cfg_sysfs_read_raw,
> > > > +     .write =3D fw_cfg_sysfs_write_raw,
> > > >  };
> > > >
> > > >  /*
> > > > --
> > > > 2.14.1.146.gd35faa819
> > >
> > > Thanks.
> > > HATAYAMA, Daisuke
> > >
> >=20
>=20
