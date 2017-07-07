Received: from eggs.gnu.org ([2001:4830:134:3::10]:51993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTRVu-0001eg-R4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTRVr-0000Sr-L8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:33:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dTRVr-0000SI-Bq
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:33:31 -0400
Date: Fri, 7 Jul 2017 13:33:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170707133320.2e0d741d@nial.brq.redhat.com>
In-Reply-To: <0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
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

On Tue, 4 Jul 2017 19:08:44 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 03/07/17 10:39, Igor Mammedov wrote:
> 
> > On Thu, 29 Jun 2017 15:07:19 +0100
> > Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> >   
> >> When looking to instantiate a TYPE_FW_CFG_MEM or TYPE_FW_CFG_IO device to be
> >> able to wire it up differently, it is much more convenient for the caller to
> >> instantiate the device and have the fw_cfg default files already preloaded
> >> during realize.
> >>
> >> Move fw_cfg_init1() to the end of both the fw_cfg_mem_realize() and
> >> fw_cfg_io_realize() functions so it no longer needs to be called manually
> >> when instantiating the device, and also rename it to fw_cfg_common_realize()
> >> which better describes its new purpose.
> >>
> >> Since it is now the responsibility of the machine to wire up the fw_cfg device
> >> it is necessary to introduce a object_property_add_child() call into
> >> fw_cfg_init_io() and fw_cfg_init_mem() to link the fw_cfg device to the root
> >> machine object as before.
> >>
> >> Finally we can now convert the asserts() preventing multiple fw_cfg devices
> >> and unparented fw_cfg devices being instantiated and replace them with proper
> >> error reporting at realize time. This allows us to remove FW_CFG_NAME and
> >> FW_CFG_PATH since they are no longer required.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> ---
> >>  hw/nvram/fw_cfg.c |   41 +++++++++++++++++++++++++++++------------
> >>  1 file changed, 29 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> >> index 2291121..31029ac 100644
> >> --- a/hw/nvram/fw_cfg.c
> >> +++ b/hw/nvram/fw_cfg.c
> >> @@ -37,9 +37,6 @@
> >>  
> >>  #define FW_CFG_FILE_SLOTS_DFLT 0x20
> >>  
> >> -#define FW_CFG_NAME "fw_cfg"
> >> -#define FW_CFG_PATH "/machine/" FW_CFG_NAME
> >> -
> >>  #define TYPE_FW_CFG     "fw_cfg"
> >>  #define TYPE_FW_CFG_IO  "fw_cfg_io"
> >>  #define TYPE_FW_CFG_MEM "fw_cfg_mem"
> >> @@ -920,19 +917,22 @@ static int fw_cfg_unattached_at_realize(void)
> >>  }
> >>  
> >>  
> >> -static void fw_cfg_init1(DeviceState *dev)
> >> +static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
> >>  {
> >>      FWCfgState *s = FW_CFG(dev);
> >>      MachineState *machine = MACHINE(qdev_get_machine());
> >>      uint32_t version = FW_CFG_VERSION;
> >>  
> >> -    assert(!object_resolve_path(FW_CFG_PATH, NULL));
> >> -
> >> -    object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
> >> -
> >> -    qdev_init_nofail(dev);
> >> +    if (!fw_cfg_find()) {  
> > maybe add comment that here, that fw_cfg_find() will return NULL if more than
> > 1 device is found.  
> 
> This should be the same behaviour as before, i.e. a NULL means that the
> fw_cfg device couldn't be found. It seems intuitive to me from the name
> of the function exactly what it does, so I don't find the lack of
> comment too confusing. Does anyone else have any thoughts here?
intuitive meaning from the function name would be return NULL if nothing were found,
however it's not the case here.

taking in account that fwcfg in not user creatable device how about:

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 316fca9..8f6eef8 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1014,7 +1014,10 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
 
 FWCfgState *fw_cfg_find(void)
 {
-    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
+    bool ambig = false;
+    FWCfgState *f = FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, &ambig));
+    assert(!ambig);
+    return f;
 }

or if we must to print user friendly error and fail realize gracefully
(not sure why) just add errp argument to function so it could report
error back to caller, then places that do not care much about graceful
exit would use error_abort as argument and realize would use
its local_error/errp argument.

   
> >> +        error_setg(errp, "at most one %s device is permitted", TYPE_FW_CFG);  
> > s/TYPE_FW_CFG/object_get_typename()/
> > so it would print leaf type name   
> 
> Previously the code would add the device to the machine at FW_CFG_PATH
> which was fixed at /machine/fw_cfg regardless of whether it was
> fw_cfg_io or fw_cfg_mem type (see the top of fw_cfg.c).
> 
> This was a deliberate attempt to preserve the existing behaviour and if
> we were to give the leaf type name I think this would be misleading,
> since it implies you could have one fw_cfg_io and one fw_cfg_mem which
> isn't correct.
I don't have strong preference here, considering that it's
hardcoded in board (not user specified) device,
developer that stumbles upon error should be able to dig out which
concrete type caused it.
   
> >> +        return;
> >> +    }
> >>  
> >> -    assert(!fw_cfg_unattached_at_realize());
> >> +    if (fw_cfg_unattached_at_realize()) {  
> > as I pointed out in v6, this condition will always be false,
> > I suggest to drop 4/6 patch and this hunk here so it won't to confuse
> > readers with assumption that condition might succeed.  
> 
> Definitely look more closely at the fw_cfg_unattached_at_realize()
> implementation in patch 4. You'll see that the check to determine if the
> device is attached does not check obj->parent but checks to see if the
> device exists under /machine/unattached which is what the
> device_set_realised() does if the device doesn't have a parent.
looking more fw_cfg_unattached_at_realize(),
 returns true if fwcfg is direct child of/machine/unattached
meaning implicit parent assignment.

As result, above condition essentially forbids having fwcfg under
/machine/unattached and forces user to explicitly set parent
outside of /machine/unattached or be a child of some other device.

Is this your intent (why)?



> I can confirm that I've given this a fairly good test with parented and
> non-parented objects and it seems to work well here. Does it not work
> for you in testing?
> 
> >   
> >> +        error_setg(errp, "%s device must be added as a child device before "
> >> +                   "realize", TYPE_FW_CFG);
> >> +        return;
> >> +    }
> >>  
> >>      fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
> >>      fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
> >> @@ -965,7 +965,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
> >>          qdev_prop_set_bit(dev, "dma_enabled", false);
> >>      }
> >>  
> >> -    fw_cfg_init1(dev);
> >> +    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
> >> +                              OBJECT(dev), NULL);
> >> +    qdev_init_nofail(dev);
> >>  
> >>      sbd = SYS_BUS_DEVICE(dev);
> >>      ios = FW_CFG_IO(dev);
> >> @@ -1003,7 +1005,9 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> >>          qdev_prop_set_bit(dev, "dma_enabled", false);
> >>      }
> >>  
> >> -    fw_cfg_init1(dev);
> >> +    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
> >> +                              OBJECT(dev), NULL);
> >> +    qdev_init_nofail(dev);
> >>  
> >>      sbd = SYS_BUS_DEVICE(dev);
> >>      sysbus_mmio_map(sbd, 0, ctl_addr);
> >> @@ -1033,6 +1037,7 @@ FWCfgState *fw_cfg_find(void)
> >>      return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
> >>  }
> >>  
> >> +
> >>  static void fw_cfg_class_init(ObjectClass *klass, void *data)
> >>  {
> >>      DeviceClass *dc = DEVICE_CLASS(klass);
> >> @@ -1104,6 +1109,12 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
> >>                                &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
> >>                                sizeof(dma_addr_t));
> >>      }
> >> +
> >> +    fw_cfg_common_realize(dev, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >>  }
> >>  
> >>  static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
> >> @@ -1170,6 +1181,12 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
> >>                                sizeof(dma_addr_t));
> >>          sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
> >>      }
> >> +
> >> +    fw_cfg_common_realize(dev, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >>  }
> >>  
> >>  static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)  
> > patch looks good, with above comments fixed:  
> 
> Great, thanks! I think there is some misunderstanding about the points
> above so I'd be interested to hear your further comments.
> 
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>  
> 
> 
> ATB,
> 
> Mark.
> 
