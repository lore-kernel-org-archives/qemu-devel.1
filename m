Received: from eggs.gnu.org ([2001:4830:134:3::10]:41188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dz00f-0000XO-UK
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dz00a-0006Up-UM
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:39:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:51538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dz00a-0006Tu-L0
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:39:40 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Mon, 2 Oct 2017 12:39:30 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73931FDB5@shsmsx102.ccr.corp.intel.com>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-4-git-send-email-wei.w.wang@intel.com>
	<20171002072106-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171002072106-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v16 3/5] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "'Michael S. Tsirkin'" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "willy@infradead.org" <willy@infradead.org>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <qemu-devel.nongnu.org>

On Monday, October 2, 2017 12:30 PM, Michael S. Tsirkin wrote:
> On Sat, Sep 30, 2017 at 12:05:52PM +0800, Wei Wang wrote:
> > +static int send_balloon_page_sg(struct virtio_balloon *vb,
> > +				 struct virtqueue *vq,
> > +				 void *addr,
> > +				 uint32_t size,
> > +				 bool batch)
> > +{
> > +	int err;
> > +
> > +	err =3D add_one_sg(vq, addr, size);
> > +
> > +	/* If batchng is requested, we batch till the vq is full */
>=20
> typo
>=20
> > +	if (!batch || !vq->num_free)
> > +		kick_and_wait(vq, vb->acked);
> > +
> > +	return err;
> > +}
>=20
> If add_one_sg fails, kick_and_wait will hang forever.
>=20
> The reason this might work in because
> 1. with 1 sg there are no memory allocations 2. if adding fails on vq ful=
l, then
> something
>    is in queue and will wake up kick_and_wait.
>=20
> So in short this is expected to never fail.
> How about a BUG_ON here then?
> And make it void, and add a comment with above explanation.
>=20


Yes, agree that this wouldn't fail - the worker thread performing the ballo=
oning operations has been put into sleep when the vq is full, so I think th=
ere shouldn't be anyone else to put more sgs onto the vq then.
Btw, not sure if we need to mention memory allocation in the comment, I fou=
nd virtqueue_add() doesn't return any error when allocation (for indirect d=
esc-s) fails - it simply avoids the use of indirect desc.

What do you think of the following?=20

err =3D add_one_sg(vq, addr, size);
/*=20
  * This is expected to never fail: there is always at least 1 entry availa=
ble on the vq,
  * because when the vq is full the worker thread that adds the sg will be =
put into
  * sleep until at least 1 entry is available to use.
  */
BUG_ON(err);

Best,
Wei



=20
