Received: from eggs.gnu.org ([2001:4830:134:3::10]:41018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1foZwJ-0007c9-Q2
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 15:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1foZwI-0003eJ-1H
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 15:52:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1foZwH-0003dV-M2
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 15:52:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id h10-v6so10982081wre.6
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 12:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180722193350.6028-1-zhangckid@gmail.com>
	<20180722193350.6028-9-zhangckid@gmail.com>
	<20180727185131.GD2498@work-vm>
	<CAK3tnv+N94Fuev05WF3A4bBOuZ8-RfPrWWG2eGsFcEtjh0=mTA@mail.gmail.com>
	<20180807184447.GS2556@work-vm>
In-Reply-To: <20180807184447.GS2556@work-vm>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 12 Aug 2018 03:52:26 +0800
Message-ID: <CAK3tnvK_GKX2FEcFPf_b1CKZYJz-7ywLF_1b+6vcdi0FZu5dZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V10 08/20] ram/COLO: Record the dirty pages
 that SVM received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, jasowang@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com

On Wed, Aug 8, 2018 at 2:44 AM Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Zhang Chen (zhangckid@gmail.com) wrote:
> > On Sat, Jul 28, 2018 at 2:51 AM, Dr. David Alan Gilbert <
> dgilbert@redhat.com
> > > wrote:
> >
> > > * Zhang Chen (zhangckid@gmail.com) wrote:
> > > > We record the address of the dirty pages that received,
> > > > it will help flushing pages that cached into SVM.
> > > >
> > > > Here, it is a trick, we record dirty pages by re-using migration
> > > > dirty bitmap. In the later patch, we will start the dirty log
> > > > for SVM, just like migration, in this way, we can record both
> > > > the dirty pages caused by PVM and SVM, we only flush those dirty
> > > > pages from RAM cache while do checkpoint.
> > > >
> > > > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > > > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > ---
> > > >  migration/ram.c | 33 +++++++++++++++++++++++++++++++++
> > > >  1 file changed, 33 insertions(+)
> > > >
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index 33ebd09d70..d1060f1337 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -3325,6 +3325,15 @@ static inline void
> *colo_cache_from_block_offset(RAMBlock
> > > *block,
> > > >                       __func__, block->idstr);
> > > >          return NULL;
> > > >      }
> > > > +
> > > > +    /*
> > > > +    * During colo checkpoint, we need bitmap of these migrated
> pages.
> > > > +    * It help us to decide which pages in ram cache should be
> flushed
> > > > +    * into VM's RAM later.
> > > > +    */
> > > > +    if (!test_and_set_bit(offset >> TARGET_PAGE_BITS, block->bmap))
> {
> > > > +        ram_state->migration_dirty_pages++;
> > > > +    }
> > > >      return block->colo_cache + offset;
> > > >  }
> > > >
> > > > @@ -3555,6 +3564,24 @@ int colo_init_ram_cache(void)
> > > >          memcpy(block->colo_cache, block->host, block->used_length);
> > > >      }
> > > >      rcu_read_unlock();
> > > > +    /*
> > > > +    * Record the dirty pages that sent by PVM, we use this dirty
> bitmap
> > > together
> > > > +    * with to decide which page in cache should be flushed into
> SVM's
> > > RAM. Here
> > > > +    * we use the same name 'ram_bitmap' as for migration.
> > > > +    */
> > > > +    if (ram_bytes_total()) {
> > > > +        RAMBlock *block;
> > > > +
> > > > +        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> > >
> > > I think those need updating to check for 'qemu_ram_is_migratable' - it
> > > might be worth moving RAMBLOCK_FOREACH_MIGRATABLE.
> > >
> >
> >
> > OK, I will change to the " RAMBLOCK_FOREACH_MIGRATABLE " in next version.
> >
> >
> > >
> > > > +            unsigned long pages = block->max_length >>
> TARGET_PAGE_BITS;
> > > > +
> > > > +            block->bmap = bitmap_new(pages);
> > > > +            bitmap_set(block->bmap, 0, pages);
> > >
> > > Would it make sense to use the 'receivedmap' that was recently added
> > > for other uses rather than needing your own?
> > >
> >
> > Maybe we can do this job as optimization in the future, currently we want
> > to make this series merged into upstream first.
>
> Sure; I think it's getting there; I don't see anything too bad in the
> migration bits as is;  hopefully Jason can check the networking set
> again and Markus/Eric check the QMP side of things.
>

Hi Dave,

Yes, I will update new version for this series.

Thank you for your help with the COLO project.
Zhang Chen


>
> Dave
>
> > Thanks
> > Zhang Chen
> >
> >
> > >
> > > Dave
> > >
> > > > +         }
> > > > +    }
> > > > +    ram_state = g_new0(RAMState, 1);
> > > > +    ram_state->migration_dirty_pages = 0;
> > > > +
> > > >      return 0;
> > > >
> > > >  out_locked:
> > > > @@ -3574,6 +3601,10 @@ void colo_release_ram_cache(void)
> > > >  {
> > > >      RAMBlock *block;
> > > >
> > > > +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> > > > +        g_free(block->bmap);
> > > > +        block->bmap = NULL;
> > > > +    }
> > > >      rcu_read_lock();
> > > >      QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> > > >          if (block->colo_cache) {
> > > > @@ -3582,6 +3613,8 @@ void colo_release_ram_cache(void)
> > > >          }
> > > >      }
> > > >      rcu_read_unlock();
> > > > +    g_free(ram_state);
> > > > +    ram_state = NULL;
> > > >  }
> > > >
> > > >  /**
> > > > --
> > > > 2.17.1
> > > >
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
