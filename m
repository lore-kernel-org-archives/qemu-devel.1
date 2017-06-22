Received: from eggs.gnu.org ([2001:4830:134:3::10]:55181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dO7E5-0008Qb-GH
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dO7E2-00006A-Bo
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:53:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dO7E2-00005r-2k
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:53:06 -0400
Date: Thu, 22 Jun 2017 21:53:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170622215125-mutt-send-email-mst@kernel.org>
References: <d2e8cf65-ea3d-7db2-9382-a063daf1168a@gmail.com>
	<20170605050423-mutt-send-email-mst@kernel.org>
	<20170606024211-mutt-send-email-mst@kernel.org>
	<CAOTcU=u_HSMQiwDF3Snv5P8mT-b_Aepeb=Z9gbLd1j=2P+Yy+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAOTcU=u_HSMQiwDF3Snv5P8mT-b_Aepeb=Z9gbLd1j=2P+Yy+A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] BUG: KASAN: use-after-free in free_old_xmit_skbs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jean-philippe menil <jpmenil@gmail.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org

On Thu, Jun 22, 2017 at 08:15:58AM +0200, jean-philippe menil wrote:
> 2017-06-06 1:52 GMT+02:00 Michael S. Tsirkin <mst@redhat.com>:
>=20
>     On Mon, Jun 05, 2017 at 05:08:25AM +0300, Michael S. Tsirkin wrote:
>     > On Mon, Jun 05, 2017 at 12:48:53AM +0200, Jean-Philippe Menil wro=
te:
>     > > Hi,
>     > >
>     > > while playing with xdp and ebpf, i'm hitting the following:
>     > >
>     > > [=A0 309.993136]
>     > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     > > [=A0 309.994735] BUG: KASAN: use-after-free in
>     > > free_old_xmit_skbs.isra.29+0x2b7/0x2e0 [virtio_net]
>     > > [=A0 309.998396] Read of size 8 at addr ffff88006aa64220 by tas=
k sshd/323
>     > > [=A0 310.000650]
>     > > [=A0 310.002305] CPU: 1 PID: 323 Comm: sshd Not tainted 4.12.0-=
rc3+ #2
>     > > [=A0 310.004018] Hardware name: QEMU Standard PC (i440FX + PIIX=
, 1996),
>     BIOS
>     > > 1.10.2-20170228_101828-anatol 04/01/2014

...

>     >
>     > Since commit 680557cf79f82623e2c4fd42733077d60a843513
>     >=A0 =A0 =A0virtio_net: rework mergeable buffer handling
>     >
>     > we no longer must do the resets, we now have enough space
>     > to store a bit saying whether a buffer is xdp one or not.
>     >
>     > And that's probably a cleaner way to fix these issues than
>     > try to find and fix the race condition.
>     >
>     > John?
>     >
>     > --
>     > MST
>=20
>=20
>     I think I see the source of the race. virtio net calls
>     netif_device_detach and assumes no packets will be sent after
>     this point. However, all it does is stop all queues so
>     no new packets will be transmitted.
>=20
>     Try locking with HARD_TX_LOCK?
>   =20
>=20
>     --
>     MST
>=20
>=20
> Hi Michael,
>=20
> from what i see, the race appear when we hit virtnet_reset in virtnet_x=
dp_set.
> virtnet_reset
> =A0 _remove_vq_common
> =A0=A0=A0 virtnet_del_vqs
> =A0=A0=A0=A0=A0 virtnet_free_queues
> =A0=A0=A0=A0=A0 =A0 kfree(vi->sq)
> when the xdp program (with two instances of the program to trigger it f=
aster)
> is added or removed.
>=20
> It's easily repeatable, with 2 cpus and 4 queues on the qemu command li=
ne,
> running the xdp_ttl tool from Jesper.
>=20
> For now, i'm able to continue my qualification, testing if xdp_qp is no=
t null,
> but do not seem to be a sustainable trick.
> if (xdp_qp && vi->xdp_queues_pairs !=3D xdp_qp)
>=20
> Maybe it will be more clear to you with theses informations.
>=20
> Best regards.
>=20
> Jean-Philippe


I'm pretty clear about the issue here, I was trying to figure out a fix.
Jason, any thoughts?


--=20
MST
