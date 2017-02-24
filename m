Received: from eggs.gnu.org ([2001:4830:134:3::10]:38429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chDQw-0003Bv-Df
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chDQt-0004R0-CC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:49:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chDQt-0004Pc-6L
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:49:03 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 473AB19CF24
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 10:49:03 +0000 (UTC)
Date: Fri, 24 Feb 2017 10:48:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170224104858.GD2435@work-vm>
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-3-dgilbert@redhat.com>
	<2d0b399e-3ebe-620c-f845-5f61fc55e170@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0b399e-3ebe-620c-f845-5f61fc55e170@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/16] postcopy: Transmit and compare
 individual page sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, aarcange@redhat.com

* Laurent Vivier (lvivier@redhat.com) wrote:
> On 06/02/2017 18:32, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > When using postcopy with hugepages, we require the source
> > and destination page sizes for any RAMBlock to match; note
> > that different RAMBlocks in the same VM can have different
> > page sizes.
> > 
> > Transmit them as part of the RAM information header and
> > fail if there's a difference.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  migration/ram.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index b405e4a..5726563 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1979,6 +1979,9 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >          qemu_put_byte(f, strlen(block->idstr));
> >          qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
> >          qemu_put_be64(f, block->used_length);
> > +        if (migrate_postcopy_ram() && block->page_size != qemu_host_page_size) {
> > +            qemu_put_be64(f, block->page_size);
> > +        }
> 
> I understand we don't break migration to previous machine type by adding
> data in the migration stream because migration is already broken when
> block->page_size != qemu_host_page_size. Am I correct?

Right, the previous patch - the one with the summary word - should have failed
the migration before we get to this point.

This patch can detect a more subtle problem - e.g. we still have huge pages used
by some of the RAM Blocks, but not all the same ones as the source.

Dave

> Laurent
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
