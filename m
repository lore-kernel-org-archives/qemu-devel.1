Received: from eggs.gnu.org ([2001:4830:134:3::10]:37100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f4Ayp-00025Y-GP
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 15:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f4Ayl-0001rA-Hm
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 15:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1f4Ayl-0001qi-A8
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 15:55:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 361A080B29
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 19:55:26 +0000 (UTC)
Date: Thu, 5 Apr 2018 13:55:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180405135511.03552ede@w520.home>
In-Reply-To: <20180405194654.GB2277@work-vm>
References: <20180323153939.16684-1-dgilbert@redhat.com>
	<20180405121313.3bf29ca8@w520.home> <20180405194654.GB2277@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] vhost: Allow adjoining regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org

On Thu, 5 Apr 2018 20:46:55 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Alex Williamson (alex.williamson@redhat.com) wrote:
> > On Fri, 23 Mar 2018 15:39:39 +0000
> > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> >   
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > My rework of section adding combines overlapping or adjoining regions,
> > > but checks they're actually the same underlying RAM block.
> > > Fix the case where two blocks adjoin but don't overlap; that new region
> > > should get added (but not combined), but my previous patch was disallowing it.
> > > 
> > > Fixes: c1ece84e7c9
> > > 
> > > Reported-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---  
> > 
> > 
> > Ping?  This error report is a regression and should be considered for
> > 2.12.
> > 
> > Tested-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> It's a change in vhost - so mst is taking it ?

That's my assumption, sorry, I should have set to/cc explicitly rather
than just replying.  Thanks,

Alex

> > >  hw/virtio/vhost.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 250f886acb..2a720cca3d 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -595,10 +595,15 @@ static void vhost_region_add_section(struct vhost_dev *dev,
> > >                                          prev_sec->offset_within_address_space,
> > >                                          prev_sec->offset_within_region);
> > >              } else {
> > > -                error_report("%s: Overlapping but not coherent sections "
> > > -                             "at %"PRIx64,
> > > -                             __func__, mrs_gpa);
> > > -                return;
> > > +                /* adjoining regions are fine, but overlapping ones with
> > > +                 * different blocks/offsets shouldn't happen
> > > +                 */
> > > +                if (mrs_gpa != prev_gpa_end + 1) {
> > > +                    error_report("%s: Overlapping but not coherent sections "
> > > +                                 "at %"PRIx64,
> > > +                                 __func__, mrs_gpa);
> > > +                    return;
> > > +                }
> > >              }
> > >          }
> > >      }  
> >   
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
