Received: from eggs.gnu.org ([2001:4830:134:3::10]:34070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWSSb-0000UU-LH
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWSSY-00077o-Ip
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:38:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cWSSY-00077W-9G
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:38:18 -0500
Date: Wed, 25 Jan 2017 18:38:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170125183812.GE6581@work-vm>
References: <20170106182823.1960-2-dgilbert@redhat.com>
	<CGME20170125080145eucas1p2a0b06b64d9687cc3d2efcbaf0bd925a1@eucas1p2.samsung.com>
	<e3d95aa1-d112-c9fa-2810-a3d41ff79ebb@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3d95aa1-d112-c9fa-2810-a3d41ff79ebb@samsung.com>
Subject: Re: [Qemu-devel] [01/15] postcopy: Transmit and compare individual
 page sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com, aarcange@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> Hi David,

Hi Alexey,

> I checked you whole patch set with Andrea's kernel
> git://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git
> 
> It works and really gives sufficient decreasing of the downtime.
> 
> I'm newby in qemu and here in the mailing list.

Welcome!

> I have some remarks on current patch.
> 
> On both client and server side post copy capability should be enabled
> 
> migrate_set_capability postcopy-ram on
> 
> and serialization/deserialization relies on it.
> 
>  So if destination host
> doesn't set post copy capability ram_load will skip reading of
> remote_page_size and in case of multiple RAMBlocks the next read of len
> will be incorrect. Hopefully usually len is 0, but it could be bigger and
> overrun buffer ;).
> Maybe it's better to pass post copy capability attribute from host to
> destination to avoid
> such assumption.

We already pass an 'advise' command from the source to the destination
to tell it we're using postcopy - that's effectively us passing the
capability.  You can see in the 2nd patch I modify it's contents;
that happens before the RAM code we see here, so we
so we should always be safe in the case of the source having enabled
postcopy but the destination not having done.

'len' is always read as a byte, and the buffer is 256 bytes long - so
even if we read garbage off the stream we can never overrun the buffer.

However, you have made me think of a related case;  if the destination
has postcopy capability set, but the source does NOT have it set
then we'll incorrectly read this data.
I can fix that by changing the migrate_postcopy_ram() on
the receive side to:
  postcopy_state_get() >= POSTCOPY_INCOMING_ADVISE

so we'll only do it if the source has it enabled.

Thanks,

Dave

> 
> 
> On 01/06/2017 09:28 PM, Dave Gilbert wrote:
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
> >   migration/ram.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index a1c8089..39998f5 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1970,6 +1970,9 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >           qemu_put_byte(f, strlen(block->idstr));
> >           qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
> >           qemu_put_be64(f, block->used_length);
> > +        if (migrate_postcopy_ram() && block->page_size != qemu_host_page_size) {
> > +            qemu_put_be64(f, block->page_size);
> > +        }
> >       }
> >       rcu_read_unlock();
> > @@ -2536,6 +2539,18 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >                               error_report_err(local_err);
> >                           }
> >                       }
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
> >                       ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
> >                                             block->idstr);
> >                   } else {
> 
> 
> -- 
> Best regards,
> Alexey Perevalov
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
