Received: from eggs.gnu.org ([2001:4830:134:3::10]:51055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fR6fb-0001B0-S3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 21:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fR6fa-0006Ad-OG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 21:58:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fR6fa-0006AK-IX
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 21:58:26 -0400
Date: Fri, 8 Jun 2018 09:58:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180608015818.GR750@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180606064315.GB7815@xz-mi> <5B17B366.5030802@intel.com>
	<20180607031732.GG7815@xz-mi> <5B18C2B2.30709@intel.com>
	<20180607065808.GB750@xz-mi> <5B191EA6.3020004@intel.com>
	<20180608013723.GQ750@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608013723.GQ750@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Fri, Jun 08, 2018 at 09:37:23AM +0800, Peter Xu wrote:

[...]

> > > Asked since I see this in virtio spec (v1.0, though I guess it won't
> > > change) in chapter "2.2.1 Driver Requirements: Feature Bits":
> > > 
> > > "The driver MUST NOT accept a feature which the device did not offer"
> > > 
> > > Then I'm curious what would happen if:
> > > 
> > > - a emulator (not QEMU) only offered F_FREE_PAGE_HINT, not F_POISON
> > > - a guest that enabled PAGE_POISON
> > > 
> > > Then how the driver could tell the host that PAGE_POISON is enabled
> > > considering that guest should never set that feature bit if the
> > > emulation code didn't provide it?
> > > 
> > 
> > All the emulator implementations need to follow the virtio spec. We will
> > finally have this feature written to the virtio-balloon device section, and
> > state that the F_PAGE_POISON needs to be set on the device when
> > F_FREE_PAGE_HINT is set on the device.
> 
> Okay.  Still I would think a single feature cleaner here since they
> are actually tightly bound together, e.g., normally AFAIU this only
> happens when we introduce FEATURE1, after a while we introduced
> FEATURE2, then we need to have two features there since there are
> emulators that are already running only with FEATURE1.
> 
> AFAICT the thing behind is that your kernel patches are split (one for
> FEATURE1, one for FEATURE2), however when you only have FEATURE1 it's
> actually broken (if without the POISON support, PAGE_HINT feature
> might be broken).  So it would be nicer if the kernel patches are
> squashed so that no commit would broke any guest.  And, if they are
> squashed then IMHO we don't need two feature bits at all. ;)
> 
> But anyway, I understand it now.  Thanks,

This also reminds me that since we're going to declare both features
in this single patch, the final version of the patch should contain
the implementation of poisoned bits rather than a todo, am I right?

Regards,

-- 
Peter Xu
