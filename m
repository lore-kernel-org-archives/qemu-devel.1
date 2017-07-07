Received: from eggs.gnu.org ([2001:4830:134:3::10]:32792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTUql-0003LZ-7K
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTUqj-0006I0-O6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:07:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTUqj-0006HR-FB
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:07:17 -0400
From: "Eduardo Habkost" <ehabkost@redhat.com>
Date: Fri, 7 Jul 2017 12:07:07 -0300
Message-ID: <20170707150707.GJ10776@localhost.localdomain>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
	<20170707164453.4ba325fd@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707164453.4ba325fd@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On Fri, Jul 07, 2017 at 04:44:53PM +0200, Igor Mammedov wrote:
[...]
> > > taking in account that fwcfg in not user creatable device how about:
> > > 
> > > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > > index 316fca9..8f6eef8 100644
> > > --- a/hw/nvram/fw_cfg.c
> > > +++ b/hw/nvram/fw_cfg.c
> > > @@ -1014,7 +1014,10 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
> > >  
> > >  FWCfgState *fw_cfg_find(void)
> > >  {
> > > -    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
> > > +    bool ambig = false;
> > > +    FWCfgState *f = FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, &ambig));
> > > +    assert(!ambig);
> > > +    return f;
> > >  }
> > > 
> > > or if we must to print user friendly error and fail realize gracefully
> > > (not sure why) just add errp argument to function so it could report
> > > error back to caller, then places that do not care much about graceful
> > > exit would use error_abort as argument and realize would use
> > > its local_error/errp argument.  
> > 
> > My understanding from the thread was that we should only use assert()s
> > where there is no other choice so that any failures can be handled in a
> > more friendly manner.
> the rule I use to decide assert vs nice error handling:
> 1: try to avoid crash on hotplug path
> 2: if error could be induced by end user on startup, try to print nice error
>    before dying
> 3: when error should not happen just assert or use error_abort
>    which would print nice error message before dying.

I would add this to the list:

If returning error instead of aborting is easy, return an error
and let the caller decide if it should use &error_abort or not.

> 
> > Now as Laszlo pointed out, fw_cfg_find() is used externally to locate
> > the fw_cfg device in other parts of the QEMU codebase. Yes I agree that
> > it is possible to change the way in which it returns, however I would
> > argue that changing those semantics are outside of the scope of this patch.
> I'd just kill qemu in fw_cfg case, which is small not intrusive change.
> 
> [...]
> 
> > >>>>  
> > >>>> -    assert(!fw_cfg_unattached_at_realize());
> > >>>> +    if (fw_cfg_unattached_at_realize()) {    
> > >>> as I pointed out in v6, this condition will always be false,
> > >>> I suggest to drop 4/6 patch and this hunk here so it won't to confuse
> > >>> readers with assumption that condition might succeed.    
> > >>
> > >> Definitely look more closely at the fw_cfg_unattached_at_realize()
> > >> implementation in patch 4. You'll see that the check to determine if the
> > >> device is attached does not check obj->parent but checks to see if the
> > >> device exists under /machine/unattached which is what the
> > >> device_set_realised() does if the device doesn't have a parent.  
> > >
> > > looking more fw_cfg_unattached_at_realize(),
> > >  returns true if fwcfg is direct child of/machine/unattached
> > > meaning implicit parent assignment.
> > > 
> > > As result, above condition essentially forbids having fwcfg under
> > > /machine/unattached and forces user to explicitly set parent
> > > outside of /machine/unattached or be a child of some other device.
> > > 
> > > Is this your intent (why)?  
> > 
> > Yes that is entirely correct. All current fw_cfg users setup the device
> > using fw_cfg_init_io() and fw_cfg_init_mem() which is fine for those
> > cases because these functions attach the fw_cfg device directly to the
> > machine at /machine/fw_cfg. This makes it trivial to determine whether
> > or not an existing fw_cfg has been instantiated and prevent any more
> > instances, which Laszlo has stated is an underlying assumption for
> > fw_cfg_find().
> > 
> > In my particular use case for SPARC64, I need to move the fw_cfg device
> > behind a PCI bridge. Therefore in order to allow the QOM tree to reflect
> > the actual hardware DT then the fw_cfg device needs to be attached to
> > the PCI bridge and not the machine. Hence the check for an existing
> > device at /machine/fw_cfg is no longer good enough to determine if a
> > fw_cfg device already exists since if they do, they can be in several
> > different locations in the QOM tree.
> > 
> > This explains the change to fw_cfg_find() to make sure that we find any
> > other fw_cfg instances, no matter where they are in the QOM tree.
> without using ambiguous argument object_resolve_path_type() isn't
> returning NULL in case of duplicates in different leafs of tree.

This doesn't sound right.  object_resolve_path_type() should
always return NULL if multiple matches are found.  See its
documentation.

> 
> for reason, see https://www.mail-archive.com/qemu-devel@nongnu.org/msg460692.html
> or look at object_resolve_partial_path() impl.
> 
[...]
> > Finally for reference here is the current version of the code in my
> > outstanding sun4u patchset which wires up the fw_cfg device behind a PCI
> > bridge in hw/sparc64/sun4u:
> > 
> >   dev = qdev_create(NULL, TYPE_FW_CFG_IO);
> >   qdev_prop_set_bit(dev, "dma_enabled", false);
> >   object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev),
> >                             NULL);
> >   qdev_init_nofail(dev);
> >   memory_region_add_subregion(pci_address_space_io(ebus),
> >                               BIOS_CFG_IOPORT,
> >                               &FW_CFG_IO(dev)->comb_iomem);
> looks fine,
> 
> so what I'd do is:
>  * drop 4/6

Agreed on this point.  But:

>  * make fw_cfg_find() use ambiguous argument and error_abort if ambiguous == true
>  * from fw_cfg_common_realize() just call
> 
>      // if fw_cfg_find() returns NULL it means that device isn't in QOM tree
>      // which shouldn't ever happen, fw_cfg_find() will abort itself if
>      // another instance of device present in QOM tree.
>      assert(fw_cfg_find());

That would work, but I don't see why doing that if just returning
NULL would: 1) make the code in fw_cfg_find() simpler and
shorter; 2) make realize error handling friendlier (returning
error instead of aborting).  We just need to document that
explicitly in fw_cfg_find() (see find_vmgenid_dev() for an
example).

If you still want to make realize abort instead of returning
error, you don't even need assert(ambiguous) on fw_cfg_find().
All you need is this on realize:

   assert(fw_cfg_find() == dev);

-- 
Eduardo
