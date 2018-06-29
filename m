Received: from eggs.gnu.org ([2001:4830:134:3::10]:47959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYkx2-0006ep-HX
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fYkwz-0003Dq-Av
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:24:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fYkwz-0002vC-3R
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:24:01 -0400
Date: Fri, 29 Jun 2018 07:23:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180629072313-mutt-send-email-mst@kernel.org>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<355310d0-a33d-dab1-1781-2de37dd648f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <355310d0-a33d-dab1-1781-2de37dd648f7@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: guangrong.xiao@gmail.com, pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Thu, Jun 28, 2018 at 09:36:00PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B406=E6=9C=8804=E6=97=A5 17:55, guangrong.xiao@gmail.com =
wrote:
> > From: Xiao Guangrong<xiaoguangrong@tencent.com>
> >=20
> > It's the simple lockless ring buffer implement which supports both
> > single producer vs. single consumer and multiple producers vs.
> > single consumer.
> >=20
> > Many lessons were learned from Linux Kernel's kfifo (1) and DPDK's
> > rte_ring (2) before i wrote this implement. It corrects some bugs of
> > memory barriers in kfifo and it is the simpler lockless version of
> > rte_ring as currently multiple access is only allowed for producer.
> >=20
> > If has single producer vs. single consumer, it is the traditional fif=
o,
> > If has multiple producers, it uses the algorithm as followings:
> >=20
> > For the producer, it uses two steps to update the ring:
> >     - first step, occupy the entry in the ring:
> >=20
> > retry:
> >        in =3D ring->in
> >        if (cmpxhg(&ring->in, in, in +1) !=3D in)
> >              goto retry;
> >=20
> >       after that the entry pointed by ring->data[in] has been owned b=
y
> >       the producer.
> >=20
> >       assert(ring->data[in] =3D=3D NULL);
> >=20
> >       Note, no other producer can touch this entry so that this entry
> >       should always be the initialized state.
> >=20
> >     - second step, write the data to the entry:
> >=20
> >       ring->data[in] =3D data;
> >=20
> > For the consumer, it first checks if there is available entry in the
> > ring and fetches the entry from the ring:
> >=20
> >       if (!ring_is_empty(ring))
> >            entry =3D &ring[ring->out];
> >=20
> >       Note: the ring->out has not been updated so that the entry poin=
ted
> >       by ring->out is completely owned by the consumer.
> >=20
> > Then it checks if the data is ready:
> >=20
> > retry:
> >       if (*entry =3D=3D NULL)
> >              goto retry;
> > That means, the producer has updated the index but haven't written an=
y
> > data to it.
> >=20
> > Finally, it fetches the valid data out, set the entry to the initiali=
zed
> > state and update ring->out to make the entry be usable to the produce=
r:
> >=20
> >        data =3D *entry;
> >        *entry =3D NULL;
> >        ring->out++;
> >=20
> > Memory barrier is omitted here, please refer to the comment in the co=
de.
> >=20
> > (1)https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/include/linux/kfifo.h
> > (2)http://dpdk.org/doc/api/rte__ring_8h.html
> >=20
> > Signed-off-by: Xiao Guangrong<xiaoguangrong@tencent.com>
> > ---
>=20
> May I ask why you need a MPSC ring here? Can we just use N SPSC ring fo=
r
> submitting pages and another N SPSC ring for passing back results?
>=20
> Thanks

Or just an SPSC ring + a lock.
How big of a gain is lockless access to a trivial structure
like the ring?

--=20
MST
