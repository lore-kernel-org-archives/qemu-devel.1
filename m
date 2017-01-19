Received: from eggs.gnu.org ([2001:4830:134:3::10]:44270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUILa-0006P3-K4
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUILW-0001nD-0U
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:26:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cUILV-0001lq-NS
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:26:05 -0500
Date: Thu, 19 Jan 2017 12:26:04 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170119122604.2ee85ebc@t450s.home>
In-Reply-To: <58802CC5.1080005@cn.fujitsu.com>
References: <1483175736-17137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170110005600-mutt-send-email-mst@kernel.org>
	<5874C989.9080504@cn.fujitsu.com>
	<20170110170832-mutt-send-email-mst@kernel.org>
	<20170118143239.68c3ee86@t450s.home>
	<58802CC5.1080005@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] vfio/pci: Support error recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com

On Thu, 19 Jan 2017 11:04:37 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> On 01/19/2017 05:32 AM, Alex Williamson wrote:
> > On Tue, 10 Jan 2017 17:11:01 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> >> On Tue, Jan 10, 2017 at 07:46:17PM +0800, Cao jin wrote:  
> >>>
> >>>
> >>> On 01/10/2017 07:04 AM, Michael S. Tsirkin wrote:    
> >>>> On Sat, Dec 31, 2016 at 05:15:36PM +0800, Cao jin wrote:    
> >>>>> Support serious device error recovery    
> >>>>
> >>>> serious?
> >>>>    
> >>>
> >>> Sorry for my poor vocabulary if it confuses people. I wanted to express
> >>> the meaning that: vfio-pci actually cannot do a real recovery for device
> >>> even if it provides the callbacks, it relies on the user to do a
> >>> effective(or word "serious"?) recovery.
> >>>
> >>> Welcome the amendment on the commit log.    
> >>
> >> It's up to Alex, maybe he's able to figure it all out from
> >> code, but the rest of us could benefit from a description
> >> of what the patch does from userspace point of view.
> >>
> >> Also, is it a pre-requisite of the userspace patches you posted?  
> > 
> > This is the same blocking user accesses while the device is in recovery
> > that you thought was ineffective/wrong before.  Why do we still need it
> > if QEMU isn't trying to handle fatal errors?  If the kernel is doing a
> > reset shouldn't the user consider the device dead?  A commit log
> > explaining this is absolutely necessary.  Thanks,
> > 
> > Alex
> >   
> 
> Yes, it is the same blocking user access as before, and I did said it is
> not effective as we expected, and I drew the figure to illustrate my
> analysis. I think the blocking is right, maybe just not enough to work
> fine, because it is possible that vfio's blocking is over, while
> hardware reset is not done, results in inaccessible device.
> 
> Leave the blocking here is no harm for now, and could be useful in
> future(when we handle fatal error).

If you want this in the kernel, you're going to need to invest the
effort to make it work.  I'm not going to put in code that is
ineffective at what it intends to do.
 
> We don't forward fatal error events to guest, why would guest kernel do
> a reset? Or do you mean some device driver would do hardware reset on
> non-fatal error?

The question is if we're only trying to recover from non-fatal events,
what is the scenario where the user is attempting to access the device
while it's in reset?  Do we need to consider the existing notifier to
be a fatal event where access to the device should stop immediately and
add a new notifier for non-fatal events where it's safe for the user to
access the device?  Trying to use the eventfd to push status through a
single notifier seems flawed.  Thanks,

Alex
