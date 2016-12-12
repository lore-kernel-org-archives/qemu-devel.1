Received: from eggs.gnu.org ([2001:4830:134:3::10]:40135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGO43-0002lH-OY
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cGO40-0006AY-JF
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:42:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cGO40-0006AJ-E9
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:42:32 -0500
Date: Mon, 12 Dec 2016 10:42:28 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161212104228.GA3597@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
	<151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
	<20161212103616.GB7918@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161212103616.GB7918@lemon>
Subject: Re: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Liviu Ionescu <ilg@livius.net>, QEMU Developer <Qemu-devel@nongnu.org>

On Mon, Dec 12, 2016 at 06:36:16PM +0800, Fam Zheng wrote:
> On Mon, 12/12 12:20, Liviu Ionescu wrote:
> > 
> > > On 12 Dec 2016, at 11:39, Fam Zheng <famz@redhat.com> wrote:
> > > 
> > > ... I myself know next to nothing about SDL project.
> > 
> > ok, neither do I.
> > 
> > 
> > do you have any comments on the current situation of the SDL integration in
> > QEMU? any comments on the conclusions I reached after integrating SDL2 into
> > GNU ARM Eclipse QEMU?
> > 
> > personally I do not like at all polling the SDL loop every 10 ms on a timer,
> > but I currently have no other solution. I tried to move the I/O loop on a
> > separate thread, but the Windows implementation of `poll` works only on the
> > main thread.
> 
> Like I said ealier, instead of "polling" SDL events in a timer, how about
> registering an EventNotifier in the main thread which is notified by the vCPU
> thread upon a new graphics operation? That will fix the latency issue.

Also, note that SDL is not the only backend that requires all graphics
operations to take place in a single thread. GTK2/3 both require that
everything is done in the same thread. So if there's any parts of QEMU
that are triggering graphics operations in non-main threads, we really
need to make sure any fix applies to all QEMU graphics backends, not
just SDL2.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
