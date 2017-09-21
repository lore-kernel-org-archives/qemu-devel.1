Received: from eggs.gnu.org ([2001:4830:134:3::10]:46953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dvBEh-0008Ge-R0
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dvBEd-0004KS-Sj
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dvBEd-0004Jj-MT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:50:23 -0400
Date: Thu, 21 Sep 2017 16:50:20 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <59C37692020000780017DCCA@prv-mh.provo.novell.com>
Message-ID: <alpine.DEB.2.10.1709211641460.2968@sstabellini-ThinkPad-X260>
References: <59A9A6260200007800176A6A@prv-mh.provo.novell.com>
	<59A9A6260200007800176A6A@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1709201759580.2968@sstabellini-ThinkPad-X260>
	<59C37692020000780017DCCA@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] xen: use vMSI related #define-s from
 public interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org

On Thu, 21 Sep 2017, Jan Beulich wrote:
> >>> On 21.09.17 at 03:12, <sstabellini@kernel.org> wrote:
> > On Fri, 1 Sep 2017, Jan Beulich wrote:
> >> --- a/hw/xen/xen_pt_msi.c
> >> +++ b/hw/xen/xen_pt_msi.c
> >> @@ -18,6 +18,11 @@
> >>  
> >>  #define XEN_PT_AUTO_ASSIGN -1
> >>  
> >> +#ifndef XEN_DOMCTL_VMSI_X86_DEST_ID_MASK
> >> +#if XEN_DOMCTL_INTERFACE_VERSION >= 0x0000000e
> >> +#error vMSI defines missing from domctl.h
> >> +#endif
> > 
> > All the version compatibility stuff goes to
> > include/hw/xen/xen_common.h. Please move it there.
> 
> I know there's a central place, but moving there stuff that's
> needed only in this file seemed rather counterproductive to
> me - why would you want all files including that shared one
> have to see these definitions? If there was a remote chance
> that some other file may need to make use of it, I might
> agree, but I don't see any such chance at all.

Basically, xen_common.h is meant to supply all definitions and
declarations that should already be part of the Xen interface, but
because of versioning, they are not.

Xen headers + xen_common.h = all declarations and definitions

So far, we haven't distinguished based on how many users of a given
missing functions exist in QEMU. Simply, xen_common.h fills all gaps.
One day, xen_common.h could become a set of header files, so that in
cases such as this, one can only import the compat header file that she
needs. But today we only have one compat header in QEMU.


> > We usually assume that the Xen version we are building against is
> > "sane", so we don't do #error's typically.
> 
> Hmm, I can drop the #error, but to be honest I'm hesitant to do
> so - I've put it there intentionally.

It is difficult to draw the line when an #error is needed and when it is
not. I am just trying to be consistent. Why do you think we should have
it in this specific case? Do you think we cannot make correct
assumptions based on the XEN_DOMCTL_INTERFACE_VERSION only or the Xen
version? If so, please explain.
