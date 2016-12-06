Received: from eggs.gnu.org ([2001:4830:134:3::10]:34551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEC4u-0007ZJ-Pr
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEC4q-0007pd-0i
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:30:24 -0500
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:57419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cEC4p-0007p4-Qv
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:30:19 -0500
Received: from player762.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 4DE7221B06
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 10:30:18 +0100 (CET)
Date: Tue, 6 Dec 2016 10:30:08 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161206103008.5ea4ddd6@bahia>
In-Reply-To: <20161205174130.GH13060@thinpad.lan.raisama.net>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
	<20161205164829.GB14457@thinpad.lan.raisama.net>
	<20161205182555.2e988ac6.cornelia.huck@de.ibm.com>
	<20161205174130.GH13060@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 5 Dec 2016 15:41:30 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Dec 05, 2016 at 06:25:55PM +0100, Cornelia Huck wrote:
> > On Mon, 5 Dec 2016 14:48:29 -0200
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Mon, Dec 05, 2016 at 04:42:00PM +0100, Cornelia Huck wrote:  
> > > > On Mon, 05 Dec 2016 16:21:22 +0100
> > > > Greg Kurz <groug@kaod.org> wrote:
> > > >   
> > > > > The current code recursively applies global properties from child up to
> > > > > parent. So, if you have:
> > > > > 
> > > > > -global virtio-pci.disable-modern=on
> > > > > -global virtio-blk-pci.disable-modern=off
> > > > > 
> > > > > Then the default value of disable-modern for a virtio-blk-pci device is on,
> > > > > which looks wrong from an OOP perspective.
> > > > > 
> > > > > This patch reverses the logic, so that a child property always prevail.  
> > > > 
> > > > This sounds reasonable...
> > > >   
> > > > > 
> > > > > This fixes a subtle bug that got introduced in 2.7 with commit "9a4c0e220d8a
> > > > > hw/virtio-pci: fix virtio behaviour" for older (< 2.7) machine types: the
> > > > > HW_COMPAT_2_6 macro contains global virtio-pci.disable-* properties which
> > > > > would silently override global properties passed on the command line for
> > > > > virtio subtypes.
> > > > > 
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > ---
> > > > > 
> > > > > AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
> > > > > devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandline>
> > > > > tag to pass global properties to QEMU. This patch ensures that XML files
> > > > > used with older machine types remain valid with newer versions of QEMU.
> > > > > 
> > > > > FWIW I guess it could help to have this fix in 2.8, and also probably in
> > > > > 2.7.1.  
> > > > 
> > > > ...but I'm a bit worried about doing that change this late in the
> > > > cycle, as we may introduce subtle changes for other configurations. At
> > > > the very least, we should look over the existing backwards compat
> > > > properties (I'll look at those I'm familiar with).  
> > > 
> > > This patch would change the behavior for:
> > >  -global virtio-blk-pci.disable-modern=on
> > >  -global virtio-pci.disable-modern=off
> > > 
> > > And I am not sure the new behavior would be correct. Shouldn't we
> > > apply the properties in the order specified in the command-line?  
> > 
> > Probably; but how should this interact with compat props?  
> 
> compat props should be always applied in the order they appear.
> -global should always be applied after compat props.
> 

This is actually the way they're being registered to the global_props
static list: compat props as they appear in HW_COMPAT_* and then -global
as they appear on the command line.

> So, it looks like we have two additional reasons to just follow
> the order the global properties were registered.
> 

Thinking again, maybe we just need to reverse the logic in another
way: go through global_props and apply the property if the device
can be casted to the corresponding class (i.e. object_class_dynamic_cast()
!= NULL). I'll try that.

> >   
> > > 
> > > On either case, changing the semantics of the command-line can
> > > break existing configurations. Let's do it more carefully in the
> > > 2.9 cycle, and fix the existing bug by changing the HW_COMPAT_*
> > > macros?  
> > 
> > Changing the compat props is probably the best option at this point in
> > time. Let's take this slowly so we can come up with a reasonable
> > solution for 2.9.  
> 
> Agreed.
> 
