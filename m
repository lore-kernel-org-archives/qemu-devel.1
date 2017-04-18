Received: from eggs.gnu.org ([2001:4830:134:3::10]:49406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0TSp-0000Wg-2J
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0TSo-0002cx-Az
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:46:39 -0400
Date: Tue, 18 Apr 2017 21:46:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170418134627.GC490@lemon.lan>
References: <20170418103948.13965-1-famz@redhat.com>
	<3b51de74-0d1b-ebae-1b98-fa74d028c982@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b51de74-0d1b-ebae-1b98-fa74d028c982@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9-rc5 v3] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, jcody@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, 04/18 14:36, Paolo Bonzini wrote:
> 
> 
> On 18/04/2017 12:39, Fam Zheng wrote:
> > +    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
> > +        BlockDriverState *bs = child->bs;
> > +        assert(bs->refcnt > 0);
> > +        bdrv_ref(bs);
> > +        waited |= bdrv_drain_recurse(bs);
> > +        bdrv_unref(bs);
> >      }
> 
> I think this accesses global state that is not protected by the
> AioContext lock?

Good catch! If called from IOThread, this bdrv_unref is simply wrong, although
in practice it cannot delete bs because of the reference held by the owning
device.

It may be better to wrap the bdrv_ref/bdrv_unref calls with

     if (qemu_get_current_aio_context() == qemu_get_aio_context())

because only the main loop needs it.

Will make this hunk a separate patch in v4.

Fam
