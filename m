Received: from eggs.gnu.org ([2001:4830:134:3::10]:38816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coDsX-0003ym-Gm
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1coDsU-0000Ec-Eh
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:42:33 -0400
Received: from mail.kernel.org ([198.145.29.136]:38648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1coDsU-0000EB-86
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:42:30 -0400
Date: Wed, 15 Mar 2017 11:42:25 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <e8cec3ca-7056-f7d4-add8-6b2f81e71184@redhat.com>
Message-ID: <alpine.DEB.2.10.1703151141480.4807@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
	<1b077b13-2464-224a-3942-db0015951c32@redhat.com>
	<alpine.DEB.2.10.1703141201300.4807@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1703141318470.4807@sstabellini-ThinkPad-X260>
	<e8cec3ca-7056-f7d4-add8-6b2f81e71184@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 1/9] configure: change
 CONFIG_XEN_BACKEND to be a target property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, peter.maydell@linaro.org, groug@kaod.org, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, stefanha@redhat.com, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, rth@twiddle.net

On Wed, 15 Mar 2017, Paolo Bonzini wrote:
> On 14/03/2017 21:23, Stefano Stabellini wrote:
> > On Tue, 14 Mar 2017, Stefano Stabellini wrote:
> >>> Then you add to Makefile:
> >>>
> >>>  CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
> >>>  CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_DIRS)),y)
> >>> +CONFIG_XEN := $(CONFIG_XEN_BACKEND)
> >>>  CONFIG_ALL=y
> >>>  -include config-all-devices.mak
> >>>  -include config-all-disas.mak
> >>>
> >>> The Makefile change ensures that they are built before descending in the
> >>> target-specific directories.
> >>
> >> But I don't understand this. Please correct me if I am wrong, but this
> >> change looks like it would end up setting CONFIG_XEN every time that
> >> CONFIG_XEN_BACKEND is set. Without the configure change at the top, it
> >> would end up setting CONFIG_XEN whenever the host supports Xen, even for
> >> non-x86 and non-ARM targets. What am I missing?
> 
> This CONFIG_XEN assignment applies to the toplevel only, i.e. to files
> that are built once.  Targets will still take CONFIG_XEN from
> config-target.mak, and it will not be set for non-x86/non-ARM targets.
> This CONFIG_XEN assignment applies to files that are compiled once.
> 
> The issue you reported here:
> 
> >   LINK    aarch64-softmmu/qemu-system-aarch64
> > ../hw/9pfs/xen-9p-backend.o: In function `xen_9pfs_alloc':
> > /local/qemu/hw/9pfs/xen-9p-backend.c:387: undefined reference to `xenstore_write_be_str'
> > /local/qemu/hw/9pfs/xen-9p-backend.c:388: undefined reference to `xenstore_write_be_int'
> 
> is because you need this in patch 9:
> 
> -common-obj-$(CONFIG_XEN_BACKEND) += xen-9p-backend.o
> +common-obj-$(CONFIG_XEN) += xen-9p-backend.o
> 

/me shakes his head in shame.
Thank you for the explanation!
