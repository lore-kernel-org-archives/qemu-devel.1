Received: from eggs.gnu.org ([2001:4830:134:3::10]:45034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWQER-0002yz-Gh
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWQEN-0003j8-KC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:15:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cWQEN-0003it-BV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:15:31 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A5F07FB6C
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 16:15:31 +0000 (UTC)
Date: Wed, 25 Jan 2017 16:15:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170125161526.GK2096@work-vm>
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-2-dgilbert@redhat.com>
	<871svr8o8o.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871svr8o8o.fsf@emacs.mitica>
Subject: Re: [Qemu-devel] [PATCH 01/15] postcopy: Transmit and compare
 individual page sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > When using postcopy with hugepages, we require the source
> > and destination page sizes for any RAMBlock to match.
> >
> > Transmit them as part of the RAM information header and
> > fail if there's a difference.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  migration/ram.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index a1c8089..39998f5 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1970,6 +1970,9 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >          qemu_put_byte(f, strlen(block->idstr));
> >          qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
> >          qemu_put_be64(f, block->used_length);
> > +        if (migrate_postcopy_ram() && block->page_size != qemu_host_page_size) {
> > +            qemu_put_be64(f, block->page_size);
> > +        }
> 
> Hi
> 
> 1- can different block have different page_size? 

Yes, you can specify a backing file for any DIMM or Numa node,
for (simple but odd) example:

  qemu -m 2G,slots=4,maxmem=8G -object memory-backend-file,id=huge,prealloc=yes,mem-path=/dev/hugepages/foo,size=1G -device pc-dimm,memdev=huge,id=dimm0

  ends up with 2G of normal base RAM, and 1G of (2MB) hugepages.
  You can do something similar with NUMA configurations where all your
main RAM comes from hugepages but things like ROMs and vram are normal
4k pages; that's a config I've seen from an end user.

> 2- can we remove the migrate_postocpy_ram() check and just send it for
>    newer versions and not for older ones?

You mean bind it so that hugepage postcopy only works on newer machine types?
We could do that, although it's a shame to restrict the machine type
if we don't need to.
The next patch (hmm I could swap them around) will catch a gross level
error before we get to this point, but it wont catch the case
where you've got the same set of page sizes just on different blocks.

Dave

> 
> >      }
> >  
> >      rcu_read_unlock();
> > @@ -2536,6 +2539,18 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >                              error_report_err(local_err);
> >                          }
> >                      }
> > +                    /* For postcopy we need to check hugepage sizes match */
> > +                    if (migrate_postcopy_ram() &&
> > +                        block->page_size != qemu_host_page_size) {
> > +                        uint64_t remote_page_size = qemu_get_be64(f);
> > +                        if (remote_page_size != block->page_size) {
> > +                            error_report("Mismatched RAM page size %s "
> > +                                         "(local) %" PRId64 "!= %" PRId64,
> > +                                         id, block->page_size,
> > +                                         remote_page_size);
> > +                            ret = -EINVAL;
> > +                        }
> > +                    }
> >                      ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
> >                                            block->idstr);
> >                  } else {
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
