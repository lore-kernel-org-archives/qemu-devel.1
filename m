Received: from eggs.gnu.org ([2001:4830:134:3::10]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fn7vj-0005JL-AX
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fn7ve-0003Id-Ce
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:46:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fn7ve-0003I9-4M
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:46:02 -0400
Date: Tue, 7 Aug 2018 16:45:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180807194558.GZ23195@localhost.localdomain>
References: <20180805112850.26063-1-mark.cave-ayland@ilande.co.uk>
	<20180805112850.26063-3-mark.cave-ayland@ilande.co.uk>
	<20180806201128.GB12341@localhost.localdomain>
	<987d9b7e-afdb-e954-4aae-ec192b2b51c9@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <987d9b7e-afdb-e954-4aae-ec192b2b51c9@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/2] fw_cfg: set the
 get_boot_devices_list() ignore_suffixes parameter from machine property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: lersek@redhat.com, qemu-devel@nongnu.org

On Tue, Aug 07, 2018 at 08:27:30PM +0100, Mark Cave-Ayland wrote:
> On 06/08/18 21:11, Eduardo Habkost wrote:
> > On Sun, Aug 05, 2018 at 12:28:50PM +0100, Mark Cave-Ayland wrote:
> > > For the older machines (such as Mac and SPARC) the DT nodes representing
> > > bootdevices for disk nodes are irregular for mainly historical reasons, and
> > > should be handled on an individual basis via a custom FWPathProvider.
> > > 
> > > Since the majority of bootdevice nodes for these machines either do not have a
> > > separate disk node or require different (custom) names then it is much easier
> > > to allow the ignore_suffixes parameter to be set on a per-machine basis via
> > > a machine property.
> > > 
> > > The default value for this new fwcfg_bootdevice_ignore_suffixes machine
> > > property is false to preserve compatibility for existing machines.
> > > 
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
[...]
> > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > index d139a431a6..2cf76d82a6 100644
> > > --- a/include/hw/boards.h
> > > +++ b/include/hw/boards.h
> > > @@ -204,6 +204,7 @@ struct MachineClass {
> > >       const char **valid_cpu_types;
> > >       strList *allowed_dynamic_sysbus_devices;
> > >       bool auto_enable_numa_with_memhp;
> > > +    bool fwcfg_bootdevice_ignore_suffixes;
> > 
> > We add MachineClass field when there's no obvious place for a
> > device property (that we could set using compat_props).
> > 
> > In this case you are controlling behavior of TYPE_FW_CFG, so I
> > suggest adding a compat property to TYPE_FW_CFG, and setting it
> > on MachineClass::compat_props.  This way we avoid adding a
> > fw_cfg-specific field to MachineClass.
> 
> Ah I see, thanks for the pointer! Just out of curiosity, is there any
> documentation anywhere regarding compat_props?
> 
> I've managed to get something working using a fw_cfg property (patch for
> follow shortly) and the relevant section of the machine code looks like
> this:
> 
> 
> #define HEATHROW_COMPAT \
>     {\
>         .driver = "fw_cfg",\
>         .property = "bootdevice_ignore_suffixes",\
>         .value = "on",\
>     },
> 
> static void heathrow_class_init(ObjectClass *oc, void *data)
> {
>     MachineClass *mc = MACHINE_CLASS(oc);
> 
>     ....
>     ....
>     SET_MACHINE_COMPAT(mc, HEATHROW_COMPAT);
> }
> 
> 
> Is this sufficient, or are the compat properties supposed to be versioned
> according to the QEMU machine version?

I never saw compat_properties being used for non-versioned
machines, but it should work for this use case as well.

But, I'm not sure this is the best option.  If the machine type
is not versioned, you can simply manually set the device property
to the desired value when creating the device inside your machine
init function.  See how the "data_width" and "dma_enabled"
properties are set by existing machines, for an example.

I think moving towards more introspectable/data-driven machine
initialization may be nice, but the existing SET_MACHINE_COMPAT
interface isn't pretty.  Maybe we should refactor that interface
before increasing its usage.

-- 
Eduardo
