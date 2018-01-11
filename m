Received: from eggs.gnu.org ([2001:4830:134:3::10]:44067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZcpG-0007rD-BL
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZcpE-0003xk-So
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:23:22 -0500
Date: Thu, 11 Jan 2018 13:23:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180111132304.GD2669@work-vm>
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111130427.GG8326@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Palethorpe <richiejp@f-m.fm>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, armbru@redhat.com, rpalethorpe@suse.com

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Thu, Jan 11, 2018 at 01:46:38PM +0100, Max Reitz wrote:
> > On 2018-01-08 14:52, Eric Blake wrote:
> > > On 01/07/2018 06:23 AM, Richard Palethorpe wrote:
> > >> Add QAPI wrapper functions for the existing snapshot functionality. These
> > >> functions behave the same way as the HMP savevm, loadvm and delvm
> > >> commands. This will allow applications, such as OpenQA, to programmatically
> > >> revert the VM to a previous state with no dependence on HMP or qemu-img.
> > > 
> > > That's already possible; libvirt uses QMP's human-monitor-command to
> > > access these HMP commands programmatically.
> > > 
> > > We've had discussions in the past about what it would take to have
> > > specific QMP commands for these operations; the biggest problem is that
> > > these commands promote the use of internal snapshots, and there are
> > > enough performance and other issues with internal snapshots that we are
> > > not yet ready to commit to a long-term interface for making their use
> > > easier.  At this point, our recommendation is to prefer external snapshots.
> > 
> > We already have QMP commands for internal snapshots, though.  Isn't the
> > biggest issue that savevm takes too much time to be a synchronous QMP
> > command?
> 
> Ultimately savevm/loadvm are using much of the migration code internally,
> but are not exposed as URI schemes. Could we perhaps take advantage of
> the internal common layer and define a migration URI scheme
> 
>    snapshot:<name>
> 
> where '<name>' is the name of the internal snapshot in the qcow2 file.

I had wondered about that; I'd just thought of doing the migration
saving to a block device rather than the rest of the snapshot activity around it; 
but I guess that's possible.

> Then you could just use the regular migrate QMP commands for loading
> and saving snapshots.  Might need a little extra work on the incoming
> side, since we need to be able to load snapshots, despite QEMU not
> being started with '-incoming defer', but might still be doable ?
> This would theoretically give us progress monitoring, cancellation,
> etc for free.

What actually stops this working other than the sanity check in
migrate_incoming ?

Dave

> 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
