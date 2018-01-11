Received: from eggs.gnu.org ([2001:4830:134:3::10]:47156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZRem-0003To-2Y
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 20:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZReh-0001CY-MX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 20:27:48 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Thu, 11 Jan 2018 01:27:25 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB36CF8@DGGEMM505-MBS.china.huawei.com>
References: <1515515975-28968-1-git-send-email-jianjay.zhou@huawei.com>
	<20180110143118.39b47b16@redhat.com>
In-Reply-To: <20180110143118.39b47b16@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 1/4] vhost: remove assertion to prevent
 crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>

Hi Igor,

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Wednesday, January 10, 2018 9:31 PM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: qemu-devel@nongnu.org; Huangweidong (C) <weidong.huang@huawei.com>;
> mst@redhat.com; wangxin (U) <wangxinxin.wang@huawei.com>; qemu-
> stable@nongnu.org; Gonglei (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahri=
y,
> Euler) <liuzhe13@huawei.com>
> Subject: Re: [Qemu-devel] [PATCH v5 1/4] vhost: remove assertion to preve=
nt
> crash
>=20
> On Wed, 10 Jan 2018 00:39:35 +0800
> Jay Zhou <jianjay.zhou@huawei.com> wrote:
>=20
> > Start QEMU with more DIMM devices than limit but without any vhost
> > backends and then hotplug a vhost user backend, the VM will be
> > crashed.
> > Instead of asserting in vhost_user_set_mem_table(), error number is
> > used to gracefully prevent device to start. This fixes the crash
> > issue.
>=20
> I'd rewrite commit message as following:
> --
> QEMU will assert on vhsot-user backed virtio device hotplug if QEMU is us=
ing
> more RAM regions than VHOST_MEMORY_MAX_NREGIONS (for example if it  were
> started with a lot of DIMM devices).
>=20
> Fix it by returning error instead of asserting and let callers of
> vhost_set_mem_table() handle error condition gracefully.
> --

s/vhsot-user/vhost-user, otherwise much better than mine, will use it
in the next version, thanks!

Jay

> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > ---
> >  hw/virtio/vhost-user.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c index
> > 093675e..8500562 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -317,11 +317,14 @@ static int vhost_user_set_mem_table(struct vhost_=
dev
> *dev,
> >                                       &offset);
> >          fd =3D memory_region_get_fd(mr);
> >          if (fd > 0) {
> > +            if (fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> > +                error_report("Failed preparing vhost-user memory table
> msg");
> > +                return -1;
> > +            }
> >              msg.payload.memory.regions[fd_num].userspace_addr =3D reg-
> >userspace_addr;
> >              msg.payload.memory.regions[fd_num].memory_size  =3D reg-
> >memory_size;
> >              msg.payload.memory.regions[fd_num].guest_phys_addr =3D reg=
-
> >guest_phys_addr;
> >              msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
> > -            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
> >              fds[fd_num++] =3D fd;
> >          }
> >      }
