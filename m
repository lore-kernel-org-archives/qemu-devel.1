Received: from eggs.gnu.org ([2001:4830:134:3::10]:55023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTUVE-0007bx-JP
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTUVB-0004sK-FC
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:45:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dTUVB-0004rn-5C
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:45:01 -0400
Date: Fri, 7 Jul 2017 16:44:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170707164453.4ba325fd@nial.brq.redhat.com>
In-Reply-To: <1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On Fri, 7 Jul 2017 14:12:19 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 07/07/17 12:33, Igor Mammedov wrote:
> 
> > On Tue, 4 Jul 2017 19:08:44 +0100
> > Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> >   
> >> On 03/07/17 10:39, Igor Mammedov wrote:
> >>  
> >>> On Thu, 29 Jun 2017 15:07:19 +0100
> >>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> >>>     
> >>>> When looking to instantiate a TYPE_FW_CFG_MEM or TYPE_FW_CFG_IO device to be
> >>>> able to wire it up differently, it is much more convenient for the caller to
> >>>> instantiate the device and have the fw_cfg default files already preloaded
> >>>> during realize.
> >>>>
> >>>> Move fw_cfg_init1() to the end of both the fw_cfg_mem_realize() and
> >>>> fw_cfg_io_realize() functions so it no longer needs to be called manually
> >>>> when instantiating the device, and also rename it to fw_cfg_common_realize()
> >>>> which better describes its new purpose.
> >>>>
> >>>> Since it is now the responsibility of the machine to wire up the fw_cfg device
> >>>> it is necessary to introduce a object_property_add_child() call into
> >>>> fw_cfg_init_io() and fw_cfg_init_mem() to link the fw_cfg device to the root
> >>>> machine object as before.
> >>>>
> >>>> Finally we can now convert the asserts() preventing multiple fw_cfg devices
> >>>> and unparented fw_cfg devices being instantiated and replace them with proper
> >>>> error reporting at realize time. This allows us to remove FW_CFG_NAME and
> >>>> FW_CFG_PATH since they are no longer required.
> >>>>
> >>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>>> ---
> >>>>  hw/nvram/fw_cfg.c |   41 +++++++++++++++++++++++++++++------------
> >>>>  1 file changed, 29 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> >>>> index 2291121..31029ac 100644
> >>>> --- a/hw/nvram/fw_cfg.c
> >>>> +++ b/hw/nvram/fw_cfg.c
> >>>> @@ -37,9 +37,6 @@
> >>>>  
> >>>>  #define FW_CFG_FILE_SLOTS_DFLT 0x20
> >>>>  
> >>>> -#define FW_CFG_NAME "fw_cfg"
> >>>> -#define FW_CFG_PATH "/machine/" FW_CFG_NAME
> >>>> -
> >>>>  #define TYPE_FW_CFG     "fw_cfg"
> >>>>  #define TYPE_FW_CFG_IO  "fw_cfg_io"
> >>>>  #define TYPE_FW_CFG_MEM "fw_cfg_mem"
> >>>> @@ -920,19 +917,22 @@ static int fw_cfg_unattached_at_realize(void)
> >>>>  }
> >>>>  
> >>>>  
> >>>> -static void fw_cfg_init1(DeviceState *dev)
> >>>> +static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
> >>>>  {
> >>>>      FWCfgState *s = FW_CFG(dev);
> >>>>      MachineState *machine = MACHINE(qdev_get_machine());
> >>>>      uint32_t version = FW_CFG_VERSION;
> >>>>  
> >>>> -    assert(!object_resolve_path(FW_CFG_PATH, NULL));
> >>>> -
> >>>> -    object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
> >>>> -
> >>>> -    qdev_init_nofail(dev);
> >>>> +    if (!fw_cfg_find()) {    
> >>> maybe add comment that here, that fw_cfg_find() will return NULL if more than
> >>> 1 device is found.    
> >>
> >> This should be the same behaviour as before, i.e. a NULL means that the
> >> fw_cfg device couldn't be found. It seems intuitive to me from the name
> >> of the function exactly what it does, so I don't find the lack of
> >> comment too confusing. Does anyone else have any thoughts here?  
> >
> > intuitive meaning from the function name would be return NULL if nothing were found,
> > however it's not the case here.  
> 
> The function with its current name has always existed, so all I'm doing
> here is reusing it as per your comment on an earlier patchset.
that's why I've asked for comment explaining what's going on here


> > taking in account that fwcfg in not user creatable device how about:
> > 
> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > index 316fca9..8f6eef8 100644
> > --- a/hw/nvram/fw_cfg.c
> > +++ b/hw/nvram/fw_cfg.c
> > @@ -1014,7 +1014,10 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
> >  
> >  FWCfgState *fw_cfg_find(void)
> >  {
> > -    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
> > +    bool ambig = false;
> > +    FWCfgState *f = FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, &ambig));
> > +    assert(!ambig);
> > +    return f;
> >  }
> > 
> > or if we must to print user friendly error and fail realize gracefully
> > (not sure why) just add errp argument to function so it could report
> > error back to caller, then places that do not care much about graceful
> > exit would use error_abort as argument and realize would use
> > its local_error/errp argument.  
> 
> My understanding from the thread was that we should only use assert()s
> where there is no other choice so that any failures can be handled in a
> more friendly manner.
the rule I use to decide assert vs nice error handling:
1: try to avoid crash on hotplug path
2: if error could be induced by end user on startup, try to print nice error
   before dying
3: when error should not happen just assert or use error_abort
   which would print nice error message before dying.

> Now as Laszlo pointed out, fw_cfg_find() is used externally to locate
> the fw_cfg device in other parts of the QEMU codebase. Yes I agree that
> it is possible to change the way in which it returns, however I would
> argue that changing those semantics are outside of the scope of this patch.
I'd just kill qemu in fw_cfg case, which is small not intrusive change.

[...]

> >>>>  
> >>>> -    assert(!fw_cfg_unattached_at_realize());
> >>>> +    if (fw_cfg_unattached_at_realize()) {    
> >>> as I pointed out in v6, this condition will always be false,
> >>> I suggest to drop 4/6 patch and this hunk here so it won't to confuse
> >>> readers with assumption that condition might succeed.    
> >>
> >> Definitely look more closely at the fw_cfg_unattached_at_realize()
> >> implementation in patch 4. You'll see that the check to determine if the
> >> device is attached does not check obj->parent but checks to see if the
> >> device exists under /machine/unattached which is what the
> >> device_set_realised() does if the device doesn't have a parent.  
> >
> > looking more fw_cfg_unattached_at_realize(),
> >  returns true if fwcfg is direct child of/machine/unattached
> > meaning implicit parent assignment.
> > 
> > As result, above condition essentially forbids having fwcfg under
> > /machine/unattached and forces user to explicitly set parent
> > outside of /machine/unattached or be a child of some other device.
> > 
> > Is this your intent (why)?  
> 
> Yes that is entirely correct. All current fw_cfg users setup the device
> using fw_cfg_init_io() and fw_cfg_init_mem() which is fine for those
> cases because these functions attach the fw_cfg device directly to the
> machine at /machine/fw_cfg. This makes it trivial to determine whether
> or not an existing fw_cfg has been instantiated and prevent any more
> instances, which Laszlo has stated is an underlying assumption for
> fw_cfg_find().
> 
> In my particular use case for SPARC64, I need to move the fw_cfg device
> behind a PCI bridge. Therefore in order to allow the QOM tree to reflect
> the actual hardware DT then the fw_cfg device needs to be attached to
> the PCI bridge and not the machine. Hence the check for an existing
> device at /machine/fw_cfg is no longer good enough to determine if a
> fw_cfg device already exists since if they do, they can be in several
> different locations in the QOM tree.
> 
> This explains the change to fw_cfg_find() to make sure that we find any
> other fw_cfg instances, no matter where they are in the QOM tree.
without using ambiguous argument object_resolve_path_type() isn't
returning NULL in case of duplicates in different leafs of tree.

for reason, see https://www.mail-archive.com/qemu-devel@nongnu.org/msg460692.html
or look at object_resolve_partial_path() impl.

> However this causes us a problem: if you instantiate the fw_cfg yourself
> with qdev_create()...qdev_init_nofail() then you can potentially access
> the underlying MemoryRegions directly and wire up the device without
> attaching it to the QOM tree. This is an invalid configuration but
> wouldn't be detected with fw_cfg_find().
device_set_realized() makes sure that it's attached to QOM tree,

it's up to board to decide if default /machine/unattached parent
is sufficient or fwcfg should be placed explicitly under another
parent. it's not upto device to decide on it's location though.


> The correct way to handle this is to wire up the device yourself with
> object_property_add_child() but then you find the situation whereby the
> people who know that you have to call object_property_add_child() when
> adding the fw_cfg device are the ones who don't need the error message.
> 
> Therefore the solution was to enforce that the fw_cfg device has been
> added to the QOM tree before realize because it solves all the problems:
there is no need to enforce that as device_set_realized() guaranties
that device's a child of some QOM object (explicitly or implictly) by the time
leaf realize is called.


> 1) The fw_cfg device can now be placed anywhere in the QOM tree, meaning
> that the QOM tree can be a topologically correct representation of the
> machine
with this series it can't be placed under /machine/unattached
I don't see any reason to disable it.

> 2) By enforcing that the fw_cfg device has been parented, we guarantee
> that the fw_cfg_find() check is correct and it is impossible to access a
> fw_cfg device that hasn't been wired up to the machine
fw_cfg_find() check at realize or later time is always correct if you use
ambiguous argument so object_resolve_path_type could properly detect duplicates.


> 3) Since these checks are done at realize time, we can provide nice
> friendly messages back to the developer to tell them what needs to be fixed
error_set(error_abort, ...) should work nice for fwcfg usecase,
you get error message and a stack trace in core file pointing to a place
of the error.


> Finally for reference here is the current version of the code in my
> outstanding sun4u patchset which wires up the fw_cfg device behind a PCI
> bridge in hw/sparc64/sun4u:
> 
>   dev = qdev_create(NULL, TYPE_FW_CFG_IO);
>   qdev_prop_set_bit(dev, "dma_enabled", false);
>   object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev),
>                             NULL);
>   qdev_init_nofail(dev);
>   memory_region_add_subregion(pci_address_space_io(ebus),
>                               BIOS_CFG_IOPORT,
>                               &FW_CFG_IO(dev)->comb_iomem);
looks fine,

so what I'd do is:
 * drop 4/6
 * make fw_cfg_find() use ambiguous argument and error_abort if ambiguous == true
 * from fw_cfg_common_realize() just call

     // if fw_cfg_find() returns NULL it means that device isn't in QOM tree
     // which shouldn't ever happen, fw_cfg_find() will abort itself if
     // another instance of device present in QOM tree.
     assert(fw_cfg_find());


> ATB,
> 
> Mark.
> 
