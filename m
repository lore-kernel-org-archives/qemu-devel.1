Received: from eggs.gnu.org ([2001:4830:134:3::10]:35157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elZ7E-0007BV-VW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elZ7D-0000Ep-Mp
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:51:17 -0500
Date: Tue, 13 Feb 2018 11:51:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180213115102.GF573@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com>
	<20180213105024.GC5083@localhost.localdomain>
	<20180213114355.GC2378@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213114355.GC2378@work-vm>
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Richard Palethorpe <richiejp@f-m.fm>, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, rpalethorpe@suse.com

On Tue, Feb 13, 2018 at 11:43:55AM +0000, Dr. David Alan Gilbert wrote:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Am 11.01.2018 um 14:04 hat Daniel P. Berrange geschrieben:
> > > On Thu, Jan 11, 2018 at 01:46:38PM +0100, Max Reitz wrote:
> > > > On 2018-01-08 14:52, Eric Blake wrote:
> > > > > On 01/07/2018 06:23 AM, Richard Palethorpe wrote:
> > > > >> Add QAPI wrapper functions for the existing snapshot functionality. These
> > > > >> functions behave the same way as the HMP savevm, loadvm and delvm
> > > > >> commands. This will allow applications, such as OpenQA, to programmatically
> > > > >> revert the VM to a previous state with no dependence on HMP or qemu-img.
> > > > > 
> > > > > That's already possible; libvirt uses QMP's human-monitor-command to
> > > > > access these HMP commands programmatically.
> > > > > 
> > > > > We've had discussions in the past about what it would take to have
> > > > > specific QMP commands for these operations; the biggest problem is that
> > > > > these commands promote the use of internal snapshots, and there are
> > > > > enough performance and other issues with internal snapshots that we are
> > > > > not yet ready to commit to a long-term interface for making their use
> > > > > easier.  At this point, our recommendation is to prefer external snapshots.
> > > > 
> > > > We already have QMP commands for internal snapshots, though.  Isn't the
> > > > biggest issue that savevm takes too much time to be a synchronous QMP
> > > > command?
> > > 
> > > Ultimately savevm/loadvm are using much of the migration code internally,
> > > but are not exposed as URI schemes. Could we perhaps take advantage of
> > > the internal common layer and define a migration URI scheme
> > > 
> > >    snapshot:<name>
> > > 
> > > where '<name>' is the name of the internal snapshot in the qcow2 file.
> > 
> > Let's include a node-name there, please. QEMU automagically deciding
> > where to store the VM state is one of the major problems of the HMP
> > interface.
> > 
> > And while we're at it, we can make it more future-proof by allowing to
> > specify arbitrary options:
> > 
> >     snapshot:node=<node-name>,name=<snapshot-name>
> > 
> > That would allow us to add something like compressed=on|off later.
> > Actually, compressed VM state sounds pretty nice. Why don't we have this
> > yet? The qcow2 format already provides everything you need for it.
> > 
> > > Then you could just use the regular migrate QMP commands for loading
> > > and saving snapshots.
> > 
> > Yes, you could. I think for a proper implementation you would want to do
> > better, though. Live migration provides just a stream, but that's not
> > really well suited for snapshots. When a RAM page is dirtied, you just
> > want to overwrite the old version of it in a snapshot, you don't want to
> > waste space by keeping both the old and the current version of the page
> > content in the file.
> 
> The current snapshots are run with the CPU paused aren't they?  They
> share exactly the same RAM saving code as migration.

The commands block the monitor too, so I always assumed they were non-live

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
