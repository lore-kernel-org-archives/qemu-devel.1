Received: from eggs.gnu.org ([2001:4830:134:3::10]:40365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5bAQ-0007Rk-VD
	for qemu-devel@nongnu.org; Tue, 02 May 2017 13:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5bAM-0001Fu-PO
	for qemu-devel@nongnu.org; Tue, 02 May 2017 13:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d5bAM-0001En-DY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 13:00:46 -0400
Date: Tue, 2 May 2017 18:00:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170502170031.GB5640@work-vm>
References: <1493732857-10721-1-git-send-email-den@openvz.org>
	<87bmrbgvzf.fsf@dusky.pond.sub.org>
	<e90d1680-6212-862e-bd3b-fdc415ec1890@openvz.org>
	<877f1zcjcf.fsf@dusky.pond.sub.org> <20170502163629.GA5640@work-vm>
	<20170502164838.GL16624@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502164838.GL16624@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] monitor: increase amount of data for
 monitor to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Tue, May 02, 2017 at 05:36:30PM +0100, Dr. David Alan Gilbert wrote:
> > * Markus Armbruster (armbru@redhat.com) wrote:
> > > "Denis V. Lunev" <den@openvz.org> writes:
> > > 
> > > > On 05/02/2017 05:43 PM, Markus Armbruster wrote:
> > > >> "Denis V. Lunev" <den@openvz.org> writes:
> > > >>
> > > >>> Right now QMP and HMP monitors read 1 byte at a time from the socket, which
> > > >>> is very inefficient. With 100+ VMs on the host this easily reasults in
> > > >>> a lot of unnecessary system calls and CPU usage in the system.
> > > >>>
> > > >>> This patch changes the amount of data to read to 4096 bytes, which matches
> > > >>> buffer size on the channel level. Fortunately, monitor protocol is
> > > >>> synchronous right now thus we should not face side effects in reality.
> > > >> Can you explain briefly why this relies on "synchronous"?  I've spent
> > > >> all of two seconds on the question myself...
> > > > Each command is processed in sequence as it appears in the
> > > > channel. The answer to the command is sent and only after that
> > > > next command is processed.
> > > 
> > > Yes, that's how QMP works.
> > > 
> > > > Theoretically tith asynchronous processing we can have some side
> > > > effects due to changed buffer size.
> > > 
> > > What kind of side effects do you have in mind?
> > > 
> > > It's quite possible that this obviously inefficient way to read had some
> > > deep reason back when it was created.  Hmm, git-blame is our friend:
> > > 
> > > commit c62313bbdc48f72e93fa8196f2fff96ba35e4e9d
> > > Author: Jan Kiszka <jan.kiszka@siemens.com>
> > > Date:   Fri Dec 4 14:05:29 2009 +0100
> > > 
> > >     monitor: Accept input only byte-wise
> > >     
> > >     This allows to suspend command interpretation and execution
> > >     synchronously, e.g. during migration.
> > >     
> > >     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > >     Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> > 
> > I don't think I understand why that's a problem; if we read more bytes,
> > we're not going to interpret them and execute them until after the previous
> > command returns are we?
> 
> Actually it sees we might do, due to the way the "migrate" command works
> in HMP when you don't give the '-d' flag.
> 
> Most monitors commands will block the caller until they are finished,
> but "migrate" is different. The hmp_migrate() method will return
> immediately, but we call monitor_suspend() to block processing of
> further commands. If another command has already been read off
> the wire though (due to "monitor_read" having a buffer that contains
> multiple commands), we would in fact start processing this command
> despite having suspended the monitor.

Ah OK; yes that's painful.

> This is only a problem, however, if the client app has issued "migrate"
> followed by another command, at the same time without waiting for the
> respond to "migrate". So in practice the only way you'd hit the bug
> is probably if you just cut+paste a big chunk of commands into the
> monitor at once without waiting for completion and one of the commands
> was "migrate" without "-d".

That's probably not unusual for scripts;  doing something like:
  migrate  ....
  info migrate

isn't that unusual.

> Still, I think we would need to figure out a proper fix for this before
> we could increase the buffer size.

Nod, it's a bit grim.

Dave

> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
