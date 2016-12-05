Received: from eggs.gnu.org ([2001:4830:134:3::10]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cDygO-0007YO-BD
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cDygK-0005VP-9E
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:12:12 -0500
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:44263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cDygK-0005Uz-2k
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:12:08 -0500
Received: from player762.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B83AF1F049
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 20:12:05 +0100 (CET)
Date: Mon, 5 Dec 2016 20:11:56 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161205201156.46b0116b@bahia>
In-Reply-To: <20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 5 Dec 2016 16:42:00 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Mon, 05 Dec 2016 16:21:22 +0100
> Greg Kurz <groug@kaod.org> wrote:
> 
> > The current code recursively applies global properties from child up to
> > parent. So, if you have:
> > 
> > -global virtio-pci.disable-modern=on
> > -global virtio-blk-pci.disable-modern=off
> > 
> > Then the default value of disable-modern for a virtio-blk-pci device is on,
> > which looks wrong from an OOP perspective.
> > 
> > This patch reverses the logic, so that a child property always prevail.  
> 
> This sounds reasonable...
> 
> > 
> > This fixes a subtle bug that got introduced in 2.7 with commit "9a4c0e220d8a
> > hw/virtio-pci: fix virtio behaviour" for older (< 2.7) machine types: the
> > HW_COMPAT_2_6 macro contains global virtio-pci.disable-* properties which
> > would silently override global properties passed on the command line for
> > virtio subtypes.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > 
> > AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
> > devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandline>
> > tag to pass global properties to QEMU. This patch ensures that XML files
> > used with older machine types remain valid with newer versions of QEMU.
> > 
> > FWIW I guess it could help to have this fix in 2.8, and also probably in
> > 2.7.1.  
> 
> ...but I'm a bit worried about doing that change this late in the
> cycle, as we may introduce subtle changes for other configurations. At
> the very least, we should look over the existing backwards compat
> properties (I'll look at those I'm familiar with).
> 

Yeah, it's unfortunate I encountered the issue this late... I usually
pass properties to -device directly. :-\ Maybe we should set global
options per virtio-pci subtype as you suggested on IRC ?

Note: sorry for the late answer but I've just received all the mails...

> > 
> > Please advise.
> > 
> >  hw/core/qdev-properties.c |   11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index 2a8276806721..1345f489d6b1 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -1119,11 +1119,20 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
> >  void qdev_prop_set_globals(DeviceState *dev)
> >  {
> >      ObjectClass *class = object_get_class(OBJECT(dev));
> > +    GSList *class_list = NULL;
> > 
> >      do {
> > -        qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
> > +        class_list = g_slist_prepend(class_list, class);
> >          class = object_class_get_parent(class);
> >      } while (class);
> > +
> > +    do {
> > +        GSList *head = class_list;
> > +
> > +        qdev_prop_set_globals_for_type(dev, object_class_get_name(head->data));
> > +        class_list = g_slist_next(head);
> > +        g_slist_free_1(head);
> > +    } while (class_list);
> >  }
> > 
> >  /* --- 64bit unsigned int 'size' type --- */
> >   
> 
> It is a bit unfortunate that we need a double loop here, but I don't
> see any good alternative.
> 
