Received: from eggs.gnu.org ([2001:4830:134:3::10]:38848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cr7Nm-0000pK-2g
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cr7Ni-0001dx-02
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:22:46 -0400
Received: from mail.kernel.org ([198.145.29.136]:43160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cr7Nh-0001dV-MR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:22:41 -0400
Date: Thu, 23 Mar 2017 11:22:37 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <28db5816-2ed9-0d92-a15d-af47b58a9da1@redhat.com>
Message-ID: <alpine.DEB.2.10.1703230953120.8001@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703201117560.23684@sstabellini-ThinkPad-X260>
	<1490033952-26735-1-git-send-email-sstabellini@kernel.org>
	<20170323140005.6b0853b3@bahia.lan>
	<15207674-c5cd-3874-7ac9-5b23cdac8888@suse.com>
	<28db5816-2ed9-0d92-a15d-af47b58a9da1@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v4 1/8] xen: import ring.h from xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com

On Thu, 23 Mar 2017, Paolo Bonzini wrote:
> On 23/03/2017 14:55, Juergen Gross wrote:
> > On 23/03/17 14:00, Greg Kurz wrote:
> >> On Mon, 20 Mar 2017 11:19:05 -0700
> >> Stefano Stabellini <sstabellini@kernel.org> wrote:
> >>
> >>> Do not use the ring.h header installed on the system. Instead, import
> >>> the header into the QEMU codebase. This avoids problems when QEMU is
> >>> built against a Xen version too old to provide all the ring macros.
> >>>
> >>> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> >>> Reviewed-by: Greg Kurz <groug@kaod.org>
> >>> CC: anthony.perard@citrix.com
> >>> CC: jgross@suse.com
> >>> ---
> >>> NB: The new macros have not been committed to Xen yet. Do not apply this
> >>> patch until they do.
> >>> ---
> >>
> >> Looking at your other series for the kernel part of this feature:
> >>
> >> https://lkml.org/lkml/2017/3/22/761
> >>
> >> I realize that the ring.h header from Xen also exists in the kernel tree... 
> >>
> >> Shouldn't all the code that can be used in both kernel and userspace go to a
> >> header file under include/uapi in the kernel tree ? And then we would import
> >> it under include/standard-headers/linux in the QEMU tree and we could keep it
> >> in sync using scripts/update-linux-headers.sh.
> >>
> >> Cc'ing Paolo for insights.
> > 
> > As Xen isn't part of the kernel we don't want that. You can use and/or
> > build qemu with xen-9pfs backend support on an old Linux kernel without
> > the related frontend.
> 
> As long as the header changes rarely, I guess it's fine not to go
> through update-linux-headers.sh.

Very rarely, last time ring.h was changed was 2015, and to introduce a
new macro (which we don't necessarily need in QEMU).


> > OTOH I don't see the advantage of not using the headers from Xen. This
> > is working for qdisk and pvusb backends and for all the Xen libraries.
> > Do you expect the 9pfs backend to be used for a qemu version built
> > against a Xen version not supporting that backend?

Yes, I think that is entirely possible: Xen and QEMU versions can mix
and match.

Keeping in mind that the 9pfs backend has actually no build dependencies
on Xen, except for these new ring.h macros, we have the following
options:

1) we build the 9pfs backend only for Xen >= 4.9, because of the new
   macros in ring.h that we need

2) we import ring.h into QEMU so that ring.h it's not a build dependency
   anymore, then we can build the 9pfs backend against any Xen versions

3) we don't use the new macros, we write our own in QEMU, so that there
   is no build dependency and we can build the 9pfs backend against any Xen
   versions

I think they are all acceptable options. I went with 2) because I
thought it provides the best trade-off.
