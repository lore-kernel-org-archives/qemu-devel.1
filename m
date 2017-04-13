Received: from eggs.gnu.org ([2001:4830:134:3::10]:40862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cyg5V-0001gC-A7
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cyg5U-0006L7-6z
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:51:09 -0400
Date: Thu, 13 Apr 2017 10:50:52 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170413145052.GE15762@localhost.localdomain>
References: <20170412204641.GA15762@localhost.localdomain>
	<f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
	<20170412222251.GB15762@localhost.localdomain>
	<20170412235420.GB8607@lemon>
	<20170413011109.GC15762@localhost.localdomain>
	<c74d2b7d-d185-53ba-9bf9-8cf976d8f684@redhat.com>
	<20170413143959.GE13387@stefanha-x1.localdomain>
	<53e4fffa-2e35-daff-0bbc-13d8992c9e90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e4fffa-2e35-daff-0bbc-13d8992c9e90@redhat.com>
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kwolf@redhat.com, peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

On Thu, Apr 13, 2017 at 09:45:49AM -0500, Eric Blake wrote:
> On 04/13/2017 09:39 AM, Stefan Hajnoczi wrote:
> > On Thu, Apr 13, 2017 at 01:45:55PM +0800, Paolo Bonzini wrote:
> >>
> >>
> >> On 13/04/2017 09:11, Jeff Cody wrote:
> >>>> It didn't make it into 2.9-rc4 because of limited time. :(
> >>>>
> >>>> Looks like there is no -rc5, we'll have to document this as a known issue.
> >>>> Users should "block-job-complete/cancel" as soon as possible to avoid such a
> >>>> hang.
> >>>
> >>> I'd argue for including a fix for 2.9, since this is both a regression, and
> >>> a hard lock without possible recovery short of restarting the QEMU process.
> >>
> >> It is a bit of a corner case (and jobs on I/O thread are relatively rare
> >> too), so maybe it's not worth delaying 2.9.  It has been delayed already
> >> quite a bit.  Another reason I think I prefer to wait is to ensure that
> >> we have an entry in qemu-iotests to avoid the future regression.
> > 
> > I also think this does not require delaying the release:
> > 
> > 1. It needs to be marked as a known issue in the release notes.
> > 2. Let's roll the 2.9.1 stable release within a month of 2.9.0.
> > 
> > If both conditions are met then very few end users will be exposed to
> > the problem.  I hope libvirt will create IOThreads by default soon but
> > for the time being it is not a widely used configuration.
> 
> Also, is it something that can be avoided by not doing a system_reset
> while a block job is still running? Libvirt can be taught to block reset
> while a job has still not been finished, if needs be.
>

No - if the guest initiates a reboot itself, we still end up deadlocked.

-Jeff
