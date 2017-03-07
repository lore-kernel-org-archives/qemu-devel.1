Received: from eggs.gnu.org ([2001:4830:134:3::10]:54379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clDAC-0003Pd-1m
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clDAB-0001UX-1P
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:20:20 -0500
Date: Tue, 7 Mar 2017 11:20:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170307112002.GD2869@work-vm>
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
	<20170225193155.447462-4-vsementsov@virtuozzo.com>
	<20170307095323.GB5871@noname.str.redhat.com>
	<b2c86843-1506-dba6-2446-a253f77f5b58@virtuozzo.com>
	<20170307110155.GH5871@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307110155.GH5871@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] savevm: fix savevm after migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 07.03.2017 um 10:59 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > 07.03.2017 12:53, Kevin Wolf wrote:
> > >Am 25.02.2017 um 20:31 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > >>After migration all drives are inactive and savevm will fail with
> > >>
> > >>qemu-kvm: block/io.c:1406: bdrv_co_do_pwritev:
> > >>    Assertion `!(bs->open_flags & 0x0800)' failed.
> > >>
> > >>Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > >What's the exact state you're in? I tried to reproduce this, but just
> > >doing a live migration and then savevm on the destination works fine for
> > >me.
> > >
> > >Hm... Or do you mean on the source? In that case, I think the operation
> > >must fail, but of course more gracefully than now.
> > 
> > Yes, I mean on the source. It may not be migration for "mirgration",
> > but for dumping state to file. In that case it seems not wrong to
> > make a snapshot on source.
> 
> Yes, resuming on the source is definitely valid. I'm only questioning if
> 'savevm' (and by extension, any other command that modifies the VM or
> its images) should automagically regain control of the VM, or whether
> that should be more explicit.

How many things other than 'cont' and 'savevm' are there?

We should definitely fix it so  a savevm there doesn't assert,
but I'm also unsure if it's worth a separate explicit command.

Dave

> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
