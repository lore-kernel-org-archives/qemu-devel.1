Received: from eggs.gnu.org ([209.51.188.92]:53485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2KT9-0002Bf-54
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2KT8-0007NE-Dx
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:43:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25301)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h2KT8-0007Mf-7h
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:43:42 -0500
Date: Fri, 8 Mar 2019 18:43:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190308184331.GJ2834@work-vm>
References: <20190306114227.9125-1-dgilbert@redhat.com>
	<20190306114227.9125-8-dgilbert@redhat.com>
	<CAFEAcA-pxfaooirQMhxasBwZAhKQGeo3BG_hwefLJ-o7EYZJYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-pxfaooirQMhxasBwZAhKQGeo3BG_hwefLJ-o7EYZJYQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 07/22] migration: Add an ability to ignore
 shared RAM blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, Zhang Chen <chen.zhang@intel.com>, Markus Armbruster <armbru@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Wed, 6 Mar 2019 at 11:55, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: Yury Kotov <yury-kotov@yandex-team.ru>
> >
> > If ignore-shared capability is set then skip shared RAMBlocks during the
> > RAM migration.
> > Also, move qemu_ram_foreach_migratable_block (and rename) to the
> > migration code, because it requires access to the migration capabilities.
> >
> 
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -644,7 +644,7 @@ static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
> >
> >      assert(rdma->blockmap == NULL);
> >      memset(local, 0, sizeof *local);
> > -    qemu_ram_foreach_migratable_block(qemu_rdma_init_one_block, rdma);
> > +    foreach_not_ignored_block(qemu_rdma_init_one_block, rdma);
> >      trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
> >      rdma->dest_blocks = g_new0(RDMADestBlock,
> >                                 rdma->local_ram_blocks.nb_blocks);
> 
> Hi. This change causes Coverity to gripe (CID 1399413) because
> the return value from foreach_not_ignored_block() is ignored
> here but it is checked on every other use of the function.
> 
> This is one of those Coverity errors where it's just using a
> sometimes-wrong heuristic, so we could just mark it as a false
> positive (AFAICT qemu_rdma_init_one_block() always returns 0),
> but OTOH rdma_add_block() and qemu_rdma_init_one_block()
> carefully pipe through a return value, so maybe it's worth assert()ing
> in case somebody changes rdma_add_block() to maybe fail later?
> 
> I don't think there's much in it -- let me know if you just want
> me to mark the issue as a false positive.

I'll patch it to check it, it's an easy enough check.
(Although how well a failure cleans up in practice could be fun).

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
