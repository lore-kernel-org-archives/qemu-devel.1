Received: from eggs.gnu.org ([2001:4830:134:3::10]:35555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIRLG-0000R8-Bp
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIRLD-000643-5d
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIRLC-00063G-VY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1A033B70D
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 03:09:00 +0000 (UTC)
Date: Wed, 7 Jun 2017 11:08:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170607030857.GA6479@pxdev.xzpeter.org>
References: <20170601220813.30535-1-quintela@redhat.com>
	<20170601220813.30535-5-quintela@redhat.com>
	<20170605123444.GK2109@work-vm>
	<20170606080550.GD27621@pxdev.xzpeter.org>
	<87ink958cm.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ink958cm.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 4/5] ram: Use MigrationStats for statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com

On Tue, Jun 06, 2017 at 07:33:45PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Jun 05, 2017 at 01:34:45PM +0100, Dr. David Alan Gilbert wrote:
> >> * Juan Quintela (quintela@redhat.com) wrote:
> >> > RAM Statistics need to survive migration to make info migrate work, so we
> >> > need to store them outside of RAMState.  As we already have an struct
> >> > with those fields, just used them. (MigrationStats and XBZRLECacheStats).
> >> > 
> >> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> 
> >> Hmm OK; this feels very much like it's the opposite of 180f61f from
> >> March; these variables keep moving around over the last couple of months
> >> - are they going to stay still now?
> >
> > O:-)
> >
> > Meanwhile, I don't know whether it'll be necessary to remove all the
> > functions like ram_bytes_transferred(), e.g., it would be just:
> >
> > uint64_t ram_bytes_transferred(void)
> > {
> > -    return ram_state.bytes_transferred;
> > +    return ram_counters.transferred;
> > }
> >
> > But I'm okay with either.
> 
> That value was only used for filling the statistics.  And we are filling
> a struct from another struct of the exact same type.  Going through an
> exported function looks stranger.
> 
> And as said in $commit, the idea was that creating a new counter was
> easy, right now you have to:
> 
> - add it to MigrationParam (still have to do this)
> - add it to MigrationParams (still have to do this)
> - create the field in MigrationStats or RAMState
> - create a function that exports it
> - add that function in ram.h to export it
> - add it on qmp_query (still have to do this)
> 
> So, we are moving from 6 steps to 3 steps.  I think we are much better
> now, no? O:-)

Hmm, okay!

(as long as we won't move these functions back one day :-)

-- 
Peter Xu
