Received: from eggs.gnu.org ([2001:4830:134:3::10]:45915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3N5b-0006xr-Sd
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3N5X-0008Bt-Va
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:39:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1f3N5X-0008BX-Qb
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:39:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11F77402314E
	for <qemu-devel@nongnu.org>; Tue,  3 Apr 2018 14:39:04 +0000 (UTC)
Date: Tue, 3 Apr 2018 16:38:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180403143857.GF11070@localhost.localdomain>
References: <20180328170207.49512-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328170207.49512-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Don't activate block devices if
 using -S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, jdenemar@redhat.com, peterx@redhat.com

Am 28.03.2018 um 19:02 hat Dr. David Alan Gilbert (git) geschrieben:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Activating the block devices causes the locks to be taken on
> the backing file.  If we're running with -S and the destination libvirt
> hasn't started the destination with 'cont', it's expecting the locks are
> still untaken.
> 
> Don't activate the block devices if we're not going to autostart the VM;
> 'cont' already will do that anyway.
> 
> bz: https://bugzilla.redhat.com/show_bug.cgi?id=1560854
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I'm not sure that this is a good idea. Going back to my old writeup of
the migration phases...

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07917.html

...the phase between migration completion and 'cont' is described like
this:

    b) Migration converges:
       Both VMs are stopped (assuming -S is given on the destination,
       otherwise this phase is skipped), the destination is in control of
       the resources

This patch changes the definition of the phase so that neither side is
in control of the resources. We lose the phase where the destination is
in control, but the VM isn't running yet. This feels like a problem to
me.

Consider a case where the management tool keeps a mirror job with
sync=none running to expose all I/O requests to some external process.
It needs to shut down the old block job on the source in the
'pre-switchover' state, and start a new block job on the destination
when the destination controls the images, but the VM doesn't run yet (so
that it doesn't miss an I/O request). This patch removes the migration
phase that the management tool needs to implement this correctly.

If we need a "neither side has control" phase, we might need to
introduce it in addition to the existing phases rather than replacing a
phase that is still needed in other cases.

Kevin
