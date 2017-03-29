Received: from eggs.gnu.org ([2001:4830:134:3::10]:39886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ctEet-0006ix-7k
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 10:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ctEes-00013D-D8
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 10:33:11 -0400
Date: Wed, 29 Mar 2017 16:32:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170329143259.GD16138@noname.redhat.com>
References: <1490625488-7980-1-git-send-email-den@openvz.org>
	<20170328162620.GD11725@noname.redhat.com>
	<94ecee49-3d48-946f-aedb-c4ecba3f29e2@openvz.org>
	<20170329104149.GB16138@noname.redhat.com>
	<7a477fb8-1380-294a-1a20-bd6516eef852@openvz.org>
	<20170329141127.GC16138@noname.redhat.com>
	<721a7870-e6e2-c70d-869c-ffb010b32322@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721a7870-e6e2-c70d-869c-ffb010b32322@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] parallels: wrong call to bdrv_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

Am 29.03.2017 um 16:18 hat Denis V. Lunev geschrieben:
> On 03/29/2017 05:11 PM, Kevin Wolf wrote:
> > Am 29.03.2017 um 15:53 hat Denis V. Lunev geschrieben:
> >> On 03/29/2017 01:41 PM, Kevin Wolf wrote:
> >>> The question is what the contract of bdrv_truncate() is. I think "you
> >>> can only call this when you got resize permissions" is the clearest
> >>> interface, and the current code enforces it.
> >> but in the original patch I have made check exactly over this simple
> >> condition and you says that it was not accurate. If this is wrong, I'll be
> >> rejected later on with EACCESS and will still be on the safe side.
> >> Original patch just avoids the assert().
> > No, you checked BDRV_O_RESIZE in bs->open_flags, not BLK_PERM_RESIZE in
> > child->perm. If you checked for BLK_PERM_RESIZE, that would work (though
> > I still think that checking for read-only gets closer to the actual
> > intent).
> OK. That is clear now, I'll send a fixup.
> Thank you for the explanation.

Ok, thanks.

> >>>> Another thing, should we add assert like added into bdrv_co_pwritev,
> >>>> namely
> >>>>     assert(!(bs->open_flags & BDRV_O_INACTIVE));
> >>>> in the same place below access check.
> >>> You mean asserting that we have write permission? We already do that in
> >>> bdrv_aligned_pwritev(), which is called by bdrv_co_pwritev().
> >> I mean that we should disallow image change if it is disallowed
> >> by the contract. Current contract says that we can not change
> >> image content once BDRV_O_INACTIVE is set. Should we
> >> Do we have implicit rule that (child->perm & BLK_PERM_RESIZE)
> >> is set only when INACTIVE is not set?
> > Ah, you want to assert cleared BDRV_O_INACTIVE in bdrv_truncate()?
> > That sounds like a good idea to me.
> but this is for 2.10. I think it is too late to do that right now.

Yes, definitely for 2.10. If you like, you can already send a patch
anyway, I always have a block-next queue while we're in freeze.

Kevin
