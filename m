Received: from eggs.gnu.org ([2001:4830:134:3::10]:58757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTUiE-0008PF-1V
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTUi9-0002aC-5O
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dTUi8-0002a3-S6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:58:25 -0400
Date: Fri, 7 Jul 2017 16:58:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170707165817.1a0103c1@nial.brq.redhat.com>
In-Reply-To: <20170707131300.GG10776@localhost.localdomain>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<20170707131300.GG10776@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On Fri, 7 Jul 2017 10:13:00 -0300
"Eduardo Habkost" <ehabkost@redhat.com> wrote:

> On Fri, Jul 07, 2017 at 01:33:20PM +0200, Igor Mammedov wrote:
> > On Tue, 4 Jul 2017 19:08:44 +0100
> > Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> >   
> > > On 03/07/17 10:39, Igor Mammedov wrote:
> > >   
> > > > On Thu, 29 Jun 2017 15:07:19 +0100
> > > > Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> > > >     
> > > >> When looking to instantiate a TYPE_FW_CFG_MEM or TYPE_FW_CFG_IO device to be
> > > >> able to wire it up differently, it is much more convenient for the caller to
> > > >> instantiate the device and have the fw_cfg default files already preloaded
> > > >> during realize.
> > > >>
> > > >> Move fw_cfg_init1() to the end of both the fw_cfg_mem_realize() and
> > > >> fw_cfg_io_realize() functions so it no longer needs to be called manually
> > > >> when instantiating the device, and also rename it to fw_cfg_common_realize()
> > > >> which better describes its new purpose.
> > > >>
> > > >> Since it is now the responsibility of the machine to wire up the fw_cfg device
> > > >> it is necessary to introduce a object_property_add_child() call into
> > > >> fw_cfg_init_io() and fw_cfg_init_mem() to link the fw_cfg device to the root
> > > >> machine object as before.
> > > >>
> > > >> Finally we can now convert the asserts() preventing multiple fw_cfg devices
> > > >> and unparented fw_cfg devices being instantiated and replace them with proper
> > > >> error reporting at realize time. This allows us to remove FW_CFG_NAME and
> > > >> FW_CFG_PATH since they are no longer required.
> > > >>
> > > >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > >> ---
> > > >>  hw/nvram/fw_cfg.c |   41 +++++++++++++++++++++++++++++------------
> > > >>  1 file changed, 29 insertions(+), 12 deletions(-)
> > > >>
> > > >> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > > >> index 2291121..31029ac 100644
> > > >> --- a/hw/nvram/fw_cfg.c
> > > >> +++ b/hw/nvram/fw_cfg.c
> > > >> @@ -37,9 +37,6 @@
> > > >>  
> > > >>  #define FW_CFG_FILE_SLOTS_DFLT 0x20
> > > >>  
> > > >> -#define FW_CFG_NAME "fw_cfg"
> > > >> -#define FW_CFG_PATH "/machine/" FW_CFG_NAME
> > > >> -
> > > >>  #define TYPE_FW_CFG     "fw_cfg"
> > > >>  #define TYPE_FW_CFG_IO  "fw_cfg_io"
> > > >>  #define TYPE_FW_CFG_MEM "fw_cfg_mem"
> > > >> @@ -920,19 +917,22 @@ static int fw_cfg_unattached_at_realize(void)
> > > >>  }
> > > >>  
> > > >>  
> > > >> -static void fw_cfg_init1(DeviceState *dev)
> > > >> +static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
> > > >>  {
> > > >>      FWCfgState *s = FW_CFG(dev);
> > > >>      MachineState *machine = MACHINE(qdev_get_machine());
> > > >>      uint32_t version = FW_CFG_VERSION;
> > > >>  
> > > >> -    assert(!object_resolve_path(FW_CFG_PATH, NULL));
> > > >> -
> > > >> -    object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
> > > >> -
> > > >> -    qdev_init_nofail(dev);
> > > >> +    if (!fw_cfg_find()) {    
> > > > maybe add comment that here, that fw_cfg_find() will return NULL if more than
> > > > 1 device is found.    
> > > 
> > > This should be the same behaviour as before, i.e. a NULL means that the
> > > fw_cfg device couldn't be found. It seems intuitive to me from the name
> > > of the function exactly what it does, so I don't find the lack of
> > > comment too confusing. Does anyone else have any thoughts here?  
> > intuitive meaning from the function name would be return NULL if nothing were found,
> > however it's not the case here.
> > 
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
> I don't disagree with adding the assert(), but it looks like
> making fw_cfg_find() return NULL if there are multiple devices
> can be useful for realize.
> 
> In this case, it looks like Mark is relying on that in
> fw_cfg_common_realize(): if multiple devices are created,
> fw_cfg_find() will return NULL, and realize will fail.  This
> sounds like a more graceful way to handle multiple-device
> creation than crashing on fw_cfg_find().  This is the solution
> used by find_vmgenid_dev()/vmgenid_realize(), BTW.

I suspect that find_vmgenid_dev() works by luck as it could be
placed only as /machine/peripheral-anon/foo1 or /machine/peripheral/foo2
  object_resolve_partial_path() : machine
           object_resolve_partial_path() : peripheral-anon => foo1
           object_resolve_partial_path() : peripheral => foo2
           if (found /* foo2 */) {
               if (obj /* foo1 */) {
                   return NULL;

[...]
