Received: from eggs.gnu.org ([2001:4830:134:3::10]:58248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cDx1l-00038g-MD
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cDx1j-00067V-IZ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:26:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cDx1j-00067B-9O
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:26:07 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB5HOemW118442
	for <qemu-devel@nongnu.org>; Mon, 5 Dec 2016 12:26:03 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275ah6gm10-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 12:26:03 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 5 Dec 2016 17:26:01 -0000
Date: Mon, 5 Dec 2016 18:25:55 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20161205164829.GB14457@thinpad.lan.raisama.net>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
	<20161205164829.GB14457@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161205182555.2e988ac6.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8] qdev: apply global properties in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 5 Dec 2016 14:48:29 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Dec 05, 2016 at 04:42:00PM +0100, Cornelia Huck wrote:
> > On Mon, 05 Dec 2016 16:21:22 +0100
> > Greg Kurz <groug@kaod.org> wrote:
> > 
> > > The current code recursively applies global properties from child up to
> > > parent. So, if you have:
> > > 
> > > -global virtio-pci.disable-modern=on
> > > -global virtio-blk-pci.disable-modern=off
> > > 
> > > Then the default value of disable-modern for a virtio-blk-pci device is on,
> > > which looks wrong from an OOP perspective.
> > > 
> > > This patch reverses the logic, so that a child property always prevail.
> > 
> > This sounds reasonable...
> > 
> > > 
> > > This fixes a subtle bug that got introduced in 2.7 with commit "9a4c0e220d8a
> > > hw/virtio-pci: fix virtio behaviour" for older (< 2.7) machine types: the
> > > HW_COMPAT_2_6 macro contains global virtio-pci.disable-* properties which
> > > would silently override global properties passed on the command line for
> > > virtio subtypes.
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > 
> > > AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
> > > devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandline>
> > > tag to pass global properties to QEMU. This patch ensures that XML files
> > > used with older machine types remain valid with newer versions of QEMU.
> > > 
> > > FWIW I guess it could help to have this fix in 2.8, and also probably in
> > > 2.7.1.
> > 
> > ...but I'm a bit worried about doing that change this late in the
> > cycle, as we may introduce subtle changes for other configurations. At
> > the very least, we should look over the existing backwards compat
> > properties (I'll look at those I'm familiar with).
> 
> This patch would change the behavior for:
>  -global virtio-blk-pci.disable-modern=on
>  -global virtio-pci.disable-modern=off
> 
> And I am not sure the new behavior would be correct. Shouldn't we
> apply the properties in the order specified in the command-line?

Probably; but how should this interact with compat props?

> 
> On either case, changing the semantics of the command-line can
> break existing configurations. Let's do it more carefully in the
> 2.9 cycle, and fix the existing bug by changing the HW_COMPAT_*
> macros?

Changing the compat props is probably the best option at this point in
time. Let's take this slowly so we can come up with a reasonable
solution for 2.9.
