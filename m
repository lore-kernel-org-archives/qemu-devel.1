Received: from eggs.gnu.org ([2001:4830:134:3::10]:54826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1f5YiQ-0007yg-FH
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1f5YiN-0005eo-Be
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:28:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1f5YiN-0005ap-75
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:28:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 063354074450
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 15:28:06 +0000 (UTC)
Date: Mon, 9 Apr 2018 17:28:01 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20180409152801.GA4510@orkuz.home>
References: <20180328170207.49512-1-dgilbert@redhat.com>
	<20180403143857.GF11070@localhost.localdomain>
	<20180403205237.GA2501@work-vm>
	<20180404100303.GE4482@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404100303.GE4482@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, peterx@redhat.com

On Wed, Apr 04, 2018 at 12:03:03 +0200, Kevin Wolf wrote:
> Am 03.04.2018 um 22:52 hat Dr. David Alan Gilbert geschrieben:
> > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > Consider a case where the management tool keeps a mirror job with
> > > sync=none running to expose all I/O requests to some external process.
> > > It needs to shut down the old block job on the source in the
> > > 'pre-switchover' state, and start a new block job on the destination
> > > when the destination controls the images, but the VM doesn't run yet (so
> > > that it doesn't miss an I/O request). This patch removes the migration
> > > phase that the management tool needs to implement this correctly.
> > > 
> > > If we need a "neither side has control" phase, we might need to
> > > introduce it in addition to the existing phases rather than replacing a
> > > phase that is still needed in other cases.
> > 
> > This is yet another phase to be added.
> > IMHO this needs the managment tool to explicitly take control in the
> > case you're talking about.
> 
> What kind of mechanism do you have in mind there?
> 
> Maybe what could work would be separate QMP commands to inactivate (and
> possibly for symmetry activate) all block nodes. Then the management
> tool could use the pre-switchover phase to shut down its block jobs
> etc., inactivate all block nodes, transfer its own locks and then call
> migrate-continue.

Libvirt's migration protocol consists of several phases, the ones
relevant to QEMU are:

1. destination libvirtd starts a new QEMU process with -incoming
2. source libvirtd calls migrate QMP command and waits until migration
   completes; in this step we actually wait for the pre-switchover, shut
   down all block jobs, and call migrate-continue
3. destination libvirtd calls cont QMP command

The daemons only communicated between these steps, i.e., the result of
each steps is transferred to the other side of migration. In other
words, transferring of locks and other state

IIUC what you suggested would require step 2. to be split so that some
work can be done on the destination between "migrate" command and
completed migration. This would be pretty complicated and I don't think
the problem we're trying to solve would be worth it. Not to mention that
it would multiply the number of possible code paths in the migration
code.

However, I don't think the extra step is even necessary. We could just
have a separate QMP command to activate block nodes. Thus the source
would wait for pre-switchover, shut down all block jobs and call
migrate-continue. Once migration completes, the control would be
transferred to the destination which would call the new command to
activate block nodes followed by cont. That is, the "cont" command would
just be replaced with two commands. And this similarly to the
pre-switchover state, this could be controlled by a new migration
capability to make sure all block nodes are activated automatically with
old libvirt which doesn't know anything about the new command. This
would solve compatibility with non-libvirt use cases too.

Jirka
