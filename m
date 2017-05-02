Received: from eggs.gnu.org ([2001:4830:134:3::10]:56012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5ZDT-0004JR-6F
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5ZDP-0001dN-Vg
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:55:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d5ZDP-0001b6-Mp
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:55:47 -0400
Date: Tue, 2 May 2017 15:55:40 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170502145540.GF16624@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1493732857-10721-1-git-send-email-den@openvz.org>
	<da1ab237-5dd0-cae9-7eb9-687203b37a64@redhat.com>
	<20170502144426.GE16624@redhat.com> <20170502144951.GE2072@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170502144951.GE2072@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Tue, May 02, 2017 at 03:49:52PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Tue, May 02, 2017 at 09:34:55AM -0500, Eric Blake wrote:
> > > On 05/02/2017 08:47 AM, Denis V. Lunev wrote:
> > > > Right now QMP and HMP monitors read 1 byte at a time from the socket, which
> > > > is very inefficient. With 100+ VMs on the host this easily reasults in
> > > 
> > > s/reasults/results/
> > > 
> > > > a lot of unnecessary system calls and CPU usage in the system.
> > > > 
> > > > This patch changes the amount of data to read to 4096 bytes, which matches
> > > > buffer size on the channel level. Fortunately, monitor protocol is
> > > > synchronous right now thus we should not face side effects in reality.
> > > 
> > > Do you have any easy benchmarks or measurements to prove what sort of
> > > efficiencies we get?  (I believe they exist, but quantifying them never
> > > hurts)
> > > 
> > > > 
> > > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > > CC: Markus Armbruster <armbru@redhat.com>
> > > > CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > CC: Eric Blake <eblake@redhat.com>
> > > > ---
> > > >  monitor.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/monitor.c b/monitor.c
> > > > index be282ec..00df5d0 100644
> > > > --- a/monitor.c
> > > > +++ b/monitor.c
> > > > @@ -3698,7 +3698,7 @@ static int monitor_can_read(void *opaque)
> > > >  {
> > > >      Monitor *mon = opaque;
> > > >  
> > > > -    return (mon->suspend_cnt == 0) ? 1 : 0;
> > > > +    return (mon->suspend_cnt == 0) ? 4096 : 0;
> > > 
> > > Is a hard-coded number correct, or should we be asking the channel for
> > > an actual number?
> > 
> > There's no need - this will cause the chardev code to just do a
> > gio_channel_read() with a 4096 byte buffer. The chardev backend
> > impl will then happily return fewer bytes than this - just whatever
> > happens to be pending. IOW this is just acting as an upper bound
> > on the amount of data we read at once. So 4k seems reasonable to
> > me, given the typical size of QMP/HMP command strings.
> 
> So there's *no* situation in which that will block?

Correct.

> I'm assuming the reason it read one byte was thats the only thing
> that poll() coming back to you guarantees.

Poll returning with POLLIN set, guarantees there is at least one byte
pending. A read on a pipe, socket or other FD, will return at long as
it has read at least one byte. It'll never block to fill the entire
buffer [1].

Regards,
Daniel

[1] Except if reading from a regular file, in which case POSIX I/O
    is broken and it'll happily block while the disk seeks to wherever
    the data lives, but that's not an issue for the monitor.
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
