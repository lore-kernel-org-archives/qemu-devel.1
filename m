Received: from eggs.gnu.org ([2001:4830:134:3::10]:56253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fGN1r-0007bk-Ex
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fGN1q-0005Fl-Fk
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:13:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fGN1q-0005Eu-Ap
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:13:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05203814DF4C
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:13:02 +0000 (UTC)
Date: Wed, 9 May 2018 12:12:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180509111258.GE2527@work-vm>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-12-quintela@redhat.com>
	<20180502180447.GM2679@work-vm> <87bmdp5bmv.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmdp5bmv.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v12 11/21] migration: Create multifd packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> We still don't put anything there.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  migration/ram.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 136 insertions(+), 1 deletion(-)
> >> +    be32_to_cpus(&packet->magic);
> >> +    if (packet->magic != MULTIFD_MAGIC) {
> >> +        error_setg(errp, "multifd: received packet "
> >> +                   "version %d and expected version %d",
> >> +                   packet->magic, MULTIFD_VERSION);
> >
> > That's mixing magic and version. (Magic's as %x please)
> 
> Oops, fixed.
> 
> 
> >> +    p->seq = be32_to_cpu(packet->seq);
> >> +
> >> +    if (p->pages->used) {
> >> +        block = qemu_ram_block_by_name(packet->ramblock);
> >
> > Do you need to ensure that packet->ramblock is a terminated string
> > first?
> 
> packet->ramblock[255] = 0;
> 
> >
> >> +        if (!block) {
> >> +            error_setg(errp, "multifd: unknown ram block %s",
> >> +                       packet->ramblock);
> >> +            return -1;
> >> +        }
> >> +    }
> >> +
> >> +    for (i = 0; i < p->pages->used; i++) {
> >> +        ram_addr_t offset = be64_to_cpu(packet->offset[i]);
> >> +
> >> +        p->pages->iov[i].iov_base = block->host + offset;
> >
> > I think that needs validating to ensure that the source didn't
> > send us junk and cause us to overwrite after the end of block->host
> 
>         if (offset > block->used_length) {
>             error_setg(errp, "multifd: offest too long %" PRId64
>                        " (max %" PRId64 ")",
>                        offset, block->max_length);
>             return -1;
>         }
> ??

It's probably  (offset + TARGET_PAGE_SIZE) that needs checking
but it needs doing in a wrap-safe way.

Dave

> Thanks, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
