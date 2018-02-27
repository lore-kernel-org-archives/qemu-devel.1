Received: from eggs.gnu.org ([2001:4830:134:3::10]:57893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eqTTT-0004De-HF
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 19:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eqTTQ-0005vd-GR
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 19:50:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eqTTQ-0005tp-9z
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 19:50:28 -0500
Date: Tue, 27 Feb 2018 02:50:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180227024325-mutt-send-email-mst@kernel.org>
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-4-git-send-email-wei.w.wang@intel.com>
	<20180209121517.GD2428@work-vm> <5A938E93.5020502@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A938E93.5020502@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] virtio-balloon: add a timer to
 limit the free page report waiting time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com

On Mon, Feb 26, 2018 at 12:35:31PM +0800, Wei Wang wrote:
> On 02/09/2018 08:15 PM, Dr. David Alan Gilbert wrote:
> > * Wei Wang (wei.w.wang@intel.com) wrote:
> > > This patch adds a timer to limit the time that host waits for the free
> > > page hints reported by the guest. Users can specify the time in ms via
> > > "free-page-wait-time" command line option. If a user doesn't specify a
> > > time, host waits till the guest finishes reporting all the free page
> > > hints. The policy (wait for all the free page hints to be reported or
> > > use a time limit) is determined by the orchestration layer.
> > That's kind of a get-out; but there's at least two problems:
> >     a) With a timeout of 0 (the default) we might hang forever waiting
> >        for the guest; broken guests are just too common, we can't do
> >        that.
> >     b) Even if we were going to do that, you'd have to make sure that
> >        migrate_cancel provided a way out.
> >     c) How does that work during a savevm snapshot or when the guest is
> >        stopped?
> >     d) OK, the timer gives us some safety (except c); but how does the
> >        orchestration layer ever come up with a 'safe' value for it?
> >        Unless we can suggest a safe value that the orchestration layer
> >        can use, or a way they can work it out, then they just wont use
> >        it.
> > 
> 
> Hi Dave,
> 
> Sorry for my late response. Please see below:
> 
> a) I think people would just kill the guest if it is broken.

There's no way to know whether it's broken.

> We can also
> change the default timeout value, for example 1 second, which is enough for
> the free page reporting.

There's no way to know whether it's enough.

> b) How about changing it this way: if timeout happens, host sends a stop
> command to the guest, and makes virtio_balloon_poll_free_page_hints()
> "return" immediately (without getting the guest's acknowledge). The "return"
> basically goes back to the migration_thread function:
> while (s->state == MIGRATION_STATUS_ACTIVE ||
>            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> ...
> }
> 
> migration_cancel sets the state to MIGRATION_CANCELLING, so it will stop the
> migration process.
> 
> c) This optimization needs the guest to report. If the guest is stopped, it
> wouldn't work. How about adding a check of "RUN_STATE" before going into the
> optimization?
> 
> d) Yes. Normally it is faster to wait for the guest to report all the free
> pages. Probably, we can just hardcode a value (e.g. 1s) for now (instead of
> making it configurable by users), this is used to handle the case that the
> guest is broken. What would you think?
> 
> Best,
> Wei

I think all this is premature optimization. It is not at all clear that
anything is gained by delaying migration. Just ask for hints and start
sending pages immediately.  If guest tells us a page is free before it's
sent, we can skip sending it.  OTOH if migration is taking less time to
complete than it takes for guest to respond, then we are better off just
ignoring the hint.

-- 
MST
