Received: from eggs.gnu.org ([2001:4830:134:3::10]:58644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGQdz-0008Mq-3c
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGQdv-000836-8G
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:00:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGQdv-00082t-0R
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:00:03 -0400
Date: Thu, 1 Jun 2017 16:59:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170601165540-mutt-send-email-mst@kernel.org>
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170530211819-mutt-send-email-mst@kernel.org>
	<7d4af4dd-270b-605f-9535-7bf8323e74c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d4af4dd-270b-605f-9535-7bf8323e74c2@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] vhost-user: Specify and implement
 device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

On Wed, May 31, 2017 at 04:33:33PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8831=E6=97=A5 02:20, Michael S. Tsirkin wrote:
> > On Fri, May 26, 2017 at 04:28:52PM +0200, Maxime Coquelin wrote:
> > > This series aims at specifying ans implementing the protocol update
> > > required to support device IOTLB with user backends.
> > >=20
> > > In this second non-RFC version, main changes are:
> > >   - spec fixes and clarification
> > >   - rings information update has been restored back to ring enablem=
ent time
> > >   - Work around GCC 4.4.7 limitation wrt assignment in unnamed unio=
n at
> > > declaration time.
> > >=20
> > > The series can be tested with vhost_iotlb_proto_v2 branch on my git=
lab
> > > account[0].
> > >=20
> > > The slave requests channel part is re-used from Marc-Andr=C3=A9's s=
eries submitted
> > > last year[1], with main changes from original version being request=
/feature
> > > names renaming and addition of the REPLY_ACK feature support.
> > >=20
> > > Regarding IOTLB protocol, one noticeable change is the IOTLB miss r=
equest
> > > reply made optionnal (i.e. only if slave requests it by setting the
> > > VHOST_USER_NEED_REPLY flag in the message header). This change prov=
ides
> > > more flexibility in the backend implementation of the feature.
> > >=20
> > > The protocol is very close to kernel backends, except that a new
> > > communication channel is introduced to enable the slave to send
> > > requests to the master.
> > >=20
> > > [0]:https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/vhost_iot=
lb_proto_v2
> > > [1]:https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.=
html
> > Overall, this looks good to me. I do think patch 3 isn't a good idea
> > though, if slave wants something let it request it.
> >=20
> > Need to find out why does vhost in kernel want the used ring iotlb at
> > start time - especially considering we aren't even guaranteed one ent=
ry
> > covers the whole ring, and invalidates should affect all addresses at
> > least in theory.
> >=20
> >=20
>=20
> The reason is probably we want to verify whether or not we could correc=
tly
> access used ring in vhost_vq_init_access(). It was there since vhost_ne=
t is
> introduced. We can think to remove this limitation maybe.
>=20
> Thanks


Well that's only called if iotlb is disabled:

        if (!vq->iotlb &&
            !access_ok(VERIFY_READ, &vq->used->idx, sizeof vq->used->idx)=
) {
                r =3D -EFAULT;
                goto err;
        }

Could you try removing that and see what breaks?

--=20
MST
