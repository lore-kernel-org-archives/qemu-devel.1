Received: from eggs.gnu.org ([2001:4830:134:3::10]:46984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQXSR-0005hS-Ms
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 06:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQXSO-0008Vp-KC
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 06:50:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:38081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eQXSO-0008Of-BH
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 06:50:12 -0500
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sun, 17 Dec 2017 11:50:03 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739387B68@shsmsx102.ccr.corp.intel.com>
References: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<20171215184256.GA27160@bombadil.infradead.org>	<5A34F193.5040700@intel.com>
	<201712162028.FEB87079.FOJFMQHVOSLtFO@I-love.SAKURA.ne.jp>
	<5A35FF89.8040500@intel.com>
	<201712171921.IBB30790.VOOOFMQHFSLFJt@I-love.SAKURA.ne.jp>
In-Reply-To: <201712171921.IBB30790.VOOOFMQHFSLFJt@I-love.SAKURA.ne.jp>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "willy@infradead.org" <willy@infradead.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>



> -----Original Message-----
> From: Tetsuo Handa [mailto:penguin-kernel@I-love.SAKURA.ne.jp]
> Sent: Sunday, December 17, 2017 6:22 PM
> To: Wang, Wei W <wei.w.wang@intel.com>; willy@infradead.org
> Cc: virtio-dev@lists.oasis-open.org; linux-kernel@vger.kernel.org; qemu-
> devel@nongnu.org; virtualization@lists.linux-foundation.org;
> kvm@vger.kernel.org; linux-mm@kvack.org; mst@redhat.com;
> mhocko@kernel.org; akpm@linux-foundation.org; mawilcox@microsoft.com;
> david@redhat.com; cornelia.huck@de.ibm.com;
> mgorman@techsingularity.net; aarcange@redhat.com;
> amit.shah@redhat.com; pbonzini@redhat.com;
> liliang.opensource@gmail.com; yang.zhang.wz@gmail.com;
> quan.xu@aliyun.com; nilal@redhat.com; riel@redhat.com
> Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
>=20
> Wei Wang wrote:
> > > But passing GFP_NOWAIT means that we can handle allocation failure.
> > > There is no need to use preload approach when we can handle allocatio=
n
> failure.
> >
> > I think the reason we need xb_preload is because radix tree insertion
> > needs the memory being preallocated already (it couldn't suffer from
> > memory failure during the process of inserting, probably because
> > handling the failure there isn't easy, Matthew may know the backstory
> > of
> > this)
>=20
> According to https://lwn.net/Articles/175432/ , I think that preloading i=
s
> needed only when failure to insert an item into a radix tree is a signifi=
cant
> problem.
> That is, when failure to insert an item into a radix tree is not a proble=
m, I
> think that we don't need to use preloading.

It also mentions that the preload attempts to allocate sufficient memory to=
 *guarantee* that the next radix tree insertion cannot fail.

If we check radix_tree_node_alloc(), the comments there says "this assumes =
that the caller has performed appropriate preallocation".

So, I think we would get a risk of triggering some issue without preload().

> >
> > So, I think we can handle the memory failure with xb_preload, which
> > stops going into the radix tree APIs, but shouldn't call radix tree
> > APIs without the related memory preallocated.
>=20
> It seems to me that virtio-ballon case has no problem without using
> preloading.

Why is that?

Best,
Wei
