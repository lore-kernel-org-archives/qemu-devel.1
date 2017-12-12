Received: from eggs.gnu.org ([2001:4830:134:3::10]:59244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eOZUt-0006JB-Jh
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eOZUp-0003I9-Lc
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:36:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:31767)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eOZUp-0003Gz-Bn
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:36:35 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 12 Dec 2017 01:36:31 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5E539D@SHSMSX103.ccr.corp.intel.com>
References: <1512455239-8296-1-git-send-email-changpeng.liu@intel.com>
	<1512455239-8296-5-git-send-email-changpeng.liu@intel.com>
	<20171211143310.GD5962@stefanha-x1.localdomain>
In-Reply-To: <20171211143310.GD5962@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 4/4] contrib/vhost-user-blk: introduce a
 vhost-user-blk sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Monday, December 11, 2017 10:33 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; mst@redhat.com;
> marcandre.lureau@redhat.com; felipe@nutanix.com; Harris, James R
> <james.r.harris@intel.com>
> Subject: Re: [PATCH v6 4/4] contrib/vhost-user-blk: introduce a vhost-use=
r-blk
> sample application
>=20
> > +static int vub_virtio_process_req(VubDev *vdev_blk,
> > +                                     VuVirtq *vq)
> > +{
> > +    VugDev *gdev =3D &vdev_blk->parent;
> > +    VuDev *vu_dev =3D &gdev->parent;
> > +    VuVirtqElement *elem;
> > +    uint32_t type;
> > +    unsigned in_num;
> > +    unsigned out_num;
> > +    VubReq *req;
> > +
> > +    elem =3D vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement));
> > +    if (!elem) {
> > +        return -1;
> > +    }
> > +
> > +    /* refer to hw/block/virtio_blk.c */
> > +    if (elem->out_num < 1 || elem->in_num < 1) {
> > +        fprintf(stderr, "virtio-blk request missing headers\n");
> > +        free(elem);
> > +        return -1;
> > +    }
> > +
> > +    req =3D g_new0(VubReq, 1);
> > +    req->vdev_blk =3D vdev_blk;
> > +    req->vq =3D vq;
> > +    req->elem =3D elem;
> > +
> > +    in_num =3D elem->in_num;
> > +    out_num =3D elem->out_num;
> > +
> > +    /* don't support VIRTIO_F_ANY_LAYOUT and virtio 1.0 only */
> > +    if (elem->out_sg[0].iov_len < sizeof(struct virtio_blk_outhdr)) {
> > +        fprintf(stderr, "Invalid outhdr size\n");
> > +        goto err;
> > +    }
>=20
> QEMU has iov_discard_front() and iov_discard_back().  They make it
> pretty easy to support VIRTIO_F_ANY_LAYOUT.  If you have time, please
> consider adding it to libvhost-user, but it's not a requirement for this
> patch series.
>=20
> > +    req->out =3D (struct virtio_blk_outhdr *)elem->out_sg[0].iov_base;
> > +    out_num--;
> > +
> > +    if (elem->in_sg[in_num - 1].iov_len < sizeof(struct virtio_blk_inh=
dr)) {
> > +        fprintf(stderr, "Invalid inhdr size\n");
> > +        goto err;
> > +    }
> > +    req->in =3D (struct virtio_blk_inhdr *)elem->in_sg[in_num - 1].iov=
_base;
> > +    in_num--;
> > +
> > +    type =3D le32toh(req->out->type);
>=20
> Endianness is more complicated if you want to support both VIRTIO 1.0
> and Legacy (0.9.7).  I guess it's okay to make libvhost-user code only
> support VIRTIO 1.0.
> > +static void vub_queue_set_started(VuDev *vu_dev, int idx, bool started=
)
> > +{
> > +    VuVirtq *vq;
> > +
> > +    assert(vu_dev);
> > +
> > +    if ((idx < 0) || (idx >=3D VHOST_MAX_NR_VIRTQUEUE)) {
> > +        fprintf(stderr, "VQ Index out of range: %d\n", idx);
> > +        vub_panic_cb(vu_dev, NULL);
> > +        return;
> > +    }
>=20
> Is it necessary to check num_queues?  The vhost-user master should not
> be able to enable idx >=3D num_queues.
Yes, this part of code can be removed.
