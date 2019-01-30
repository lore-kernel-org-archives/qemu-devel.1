Received: from eggs.gnu.org ([209.51.188.92]:34492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gogLE-0003fJ-9K
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gogLD-00055h-OK
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:15:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gogLD-00054t-Fy
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 22:15:07 -0500
Date: Tue, 29 Jan 2019 22:14:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190129213617-mutt-send-email-mst@kernel.org>
References: <20190122083152.10705-1-xieyongji@baidu.com>
	<20190122083152.10705-4-xieyongji@baidu.com>
	<09287313-0f6e-38a3-be36-9bf65bba7b9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09287313-0f6e-38a3-be36-9bf65bba7b9d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/6] libvhost-user: Support tracking
 inflight I/O in shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: elohimes@gmail.com, stefanha@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru, nixun@baidu.com, qemu-devel@nongnu.org, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Wed, Jan 30, 2019 at 10:31:49AM +0800, Jason Wang wrote:
>=20
> On 2019/1/22 =E4=B8=8B=E5=8D=884:31, elohimes@gmail.com wrote:
> > +static int
> > +vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
> > +{
> > +    if (!has_feature(dev->protocol_features,
> > +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> > +        return 0;
> > +    }
> > +
> > +    if (unlikely(!vq->inflight)) {
> > +        return -1;
> > +    }
> > +
> > +    vq->inflight->desc[desc_idx].inuse =3D 1;
> > +
> > +    vq->inflight->desc[desc_idx].avail_idx =3D vq->last_avail_idx;
> > +
> > +    return 0;
> > +}
> > +
> > +static int
> > +vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
> > +{
> > +    if (!has_feature(dev->protocol_features,
> > +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> > +        return 0;
> > +    }
> > +
> > +    if (unlikely(!vq->inflight)) {
> > +        return -1;
> > +    }
> > +
> > +    vq->inflight->desc[desc_idx].used_idx =3D vq->used_idx;
> > +
> > +    barrier();
> > +
> > +    vq->inflight->desc[desc_idx].version++;
> > +
> > +    return 0;
> > +}
>=20
>=20
> You probably need WRITE_ONCE() semantic (e.g volatile) to make sure the
> value reach memory.
>=20
> Thanks
>=20

WRITE_ONCE is literally volatile + dependency memory barrier.
So unless compiler is a very agressive one, it does not
buy you much.

--=20
MST
