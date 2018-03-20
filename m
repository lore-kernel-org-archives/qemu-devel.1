Received: from eggs.gnu.org ([2001:4830:134:3::10]:34546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ey6aW-0000Jf-7i
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ey6aT-0002oe-6m
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:01:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2264 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ey6aS-0002hr-Rs
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 22:01:17 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Tue, 20 Mar 2018 02:01:07 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473ABF2928@DGGEMM505-MBS.china.huawei.com>
References: <1521224390-425343-1-git-send-email-mst@redhat.com>
In-Reply-To: <1521224390-425343-1-git-send-email-mst@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vhost-user: avoid misaligned access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Saturday, March 17, 2018 2:20 AM
> To: qemu-devel@nongnu.org
> Cc: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Subject: [PATCH] vhost-user: avoid misaligned access
>=20
> We can't pass a pointer to memory field directly since it's within a pack=
ed
> structure, so isn't aligned.
> Pass a pointer on stack and copy.
>=20
> Fixes: 30c4cc7 ("vhost: used_memslots refactoring")
> Cc: Jay Zhou <jianjay.zhou@huawei.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> I had to apply this to fix make check errors with clang.
> Pls review, test and ack.
>=20
> Thanks!
>=20
>  hw/virtio/vhost-user.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c index
> c12fdd9..a44ee7f 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -396,6 +396,7 @@ static int vhost_user_set_mem_table_postcopy(struct
> vhost_dev *dev,
>      bool reply_supported =3D virtio_has_feature(dev->protocol_features,
>=20
> VHOST_USER_PROTOCOL_F_REPLY_ACK);
>      VhostUserMsg msg_reply;
> +    VhostUserMemory memory =3D {};
>      int region_i, msg_i;
>=20
>      VhostUserMsg msg =3D {
> @@ -407,10 +408,11 @@ static int vhost_user_set_mem_table_postcopy(struct
> vhost_dev *dev,
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>      }
>=20
> -    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0) {
> +    if (vhost_user_prepare_msg(dev, &memory, fds) < 0) {
>          error_report("Failed preparing vhost-user memory table msg");
>          return -1;
>      }
> +    msg.payload.memory =3D memory;
>=20
>      fd_num =3D msg.payload.memory.nregions;
>=20
> @@ -549,16 +551,19 @@ static int vhost_user_set_mem_table(struct vhost_de=
v
> *dev,
>          .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
>          .hdr.flags =3D VHOST_USER_VERSION,
>      };
> +    VhostUserMemory memory =3D {};
>=20
>      if (reply_supported) {
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>      }
>=20
> -    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0) {
> +    if (vhost_user_prepare_msg(dev, &memory, fds) < 0) {
>          error_report("Failed preparing vhost-user memory table msg");
>          return -1;
>      }
>=20
> +    msg.payload.memory =3D memory;
> +
>      fd_num =3D msg.payload.memory.nregions;
>=20
>      if (!fd_num) {
> @@ -1575,8 +1580,11 @@ static void vhost_user_set_used_memslots(struct
> vhost_dev *dev)  {
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
>      VhostUserMsg msg;
> +    VhostUserMemory memory =3D {};
> +
> +    vhost_user_prepare_msg(dev, &memory, fds);
>=20
> -    vhost_user_prepare_msg(dev, &msg.payload.memory, fds);
> +    msg.payload.memory =3D memory;
>  }

Hi Michael, here should be like this:


static void vhost_user_set_used_memslots(struct vhost_dev *dev)
 {
     int fds[VHOST_MEMORY_MAX_NREGIONS];
-    VhostUserMsg msg;
+    VhostUserMemory memory =3D {};
=20
-    vhost_user_prepare_msg(dev, &msg.payload.memory, fds);
+    vhost_user_prepare_msg(dev, &memory, fds);
 }


Regards,
Jay

>=20
>  const VhostOps user_ops =3D {
> --
> MST
