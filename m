Received: from eggs.gnu.org ([2001:4830:134:3::10]:33753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cDz1W-0003vm-O3
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cDz1T-0003dt-Ga
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:34:02 -0500
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:50123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cDz1T-0003dh-9L
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:33:59 -0500
Received: from player762.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 5308921500
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 20:33:57 +0100 (CET)
Date: Mon, 5 Dec 2016 20:33:46 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161205203346.0f89a85c@bahia>
In-Reply-To: <20161205164829.GB14457@thinpad.lan.raisama.net>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
	<20161205164829.GB14457@thinpad.lan.raisama.net>
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

Yes.

> And I am not sure the new behavior would be correct. Shouldn't we
> apply the properties in the order specified in the command-line?
> 

I would generally agree and this is what actually happens when setting
properties for a given class, but here we have the extra dimension of
class inheritance. Enforcing the command line ordering would require
to mix the setting of parent and child properties... maybe doable but
definitely a bigger change in the existing logic IMHO.

> On either case, changing the semantics of the command-line can
> break existing configurations. Let's do it more carefully in the
> 2.9 cycle, and fix the existing bug by changing the HW_COMPAT_*
> macros?
> 

That would be another possibility which is less intrusive indeed: change
the HW_COMPAT_2.6 macro to set properties for each individual virtio-pci
subtypes.

> >   
> > > 
> > > Please advise.
> > > 
> > >  hw/core/qdev-properties.c |   11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > > index 2a8276806721..1345f489d6b1 100644
> > > --- a/hw/core/qdev-properties.c
> > > +++ b/hw/core/qdev-properties.c
> > > @@ -1119,11 +1119,20 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
> > >  void qdev_prop_set_globals(DeviceState *dev)
> > >  {
> > >      ObjectClass *class = object_get_class(OBJECT(dev));
> > > +    GSList *class_list = NULL;
> > > 
> > >      do {
> > > -        qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
> > > +        class_list = g_slist_prepend(class_list, class);
> > >          class = object_class_get_parent(class);
> > >      } while (class);
> > > +
> > > +    do {
> > > +        GSList *head = class_list;
> > > +
> > > +        qdev_prop_set_globals_for_type(dev, object_class_get_name(head->data));
> > > +        class_list = g_slist_next(head);
> > > +        g_slist_free_1(head);
> > > +    } while (class_list);
> > >  }
> > > 
> > >  /* --- 64bit unsigned int 'size' type --- */
> > >   
> > 
> > It is a bit unfortunate that we need a double loop here, but I don't
> > see any good alternative.
> > 
> >   
> 
