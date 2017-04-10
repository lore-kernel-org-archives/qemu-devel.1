Received: from eggs.gnu.org ([2001:4830:134:3::10]:55625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cxebx-0001hZ-Ik
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 15:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cxebt-0004jB-KO
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 15:04:25 -0400
Received: from mail.kernel.org ([198.145.29.136]:54838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cxebt-0004i4-En
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 15:04:21 -0400
Date: Mon, 10 Apr 2017 12:04:15 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1704101159340.2759@sstabellini-ThinkPad-X260>
References: <CADZi59zNxk-Yr4rpN1E49s=AdsdW-W9YfhpCvpJeBz7oigyFSg@mail.gmail.com>
	<CADZi59xe6OcCasvtkPBjP7nTsgDA5r_E_Rt7W88BszYdJhuxGQ@mail.gmail.com>
	<CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC/BUG] xen-mapcache: buggy invalidate map cache?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hrg <hrgstephen@gmail.com>
Cc: anthony.perard@citrix.com, xen-devel@lists.xensource.com, qemu-devel@nongnu.org, jun.nakajima@intel.com, agraf@suse.de, sstabellini@kernel.org, xen-devel@lists.xenproject.org, xen-devel@lists.xen.org, "Herongguang (Stephen)" <herongguang.he@huawei.com>, wangxinxin.wang@huawei.com

On Mon, 10 Apr 2017, hrg wrote:
> On Sun, Apr 9, 2017 at 11:55 PM, hrg <hrgstephen@gmail.com> wrote:
> > On Sun, Apr 9, 2017 at 11:52 PM, hrg <hrgstephen@gmail.com> wrote:
> >> Hi,
> >>
> >> In xen_map_cache_unlocked(), map to guest memory maybe in entry->nex=
t
> >> instead of first level entry (if map to rom other than guest memory
> >> comes first), while in xen_invalidate_map_cache(), when VM ballooned
> >> out memory, qemu did not invalidate cache entries in linked
> >> list(entry->next), so when VM balloon back in memory, gfns probably
> >> mapped to different mfns, thus if guest asks device to DMA to these
> >> GPA, qemu may DMA to stale MFNs.
> >>
> >> So I think in xen_invalidate_map_cache() linked lists should also be
> >> checked and invalidated.
> >>
> >> What=E2=80=99s your opinion? Is this a bug? Is my analyze correct?

Yes, you are right. We need to go through the list for each element of
the array in xen_invalidate_map_cache. Can you come up with a patch?
