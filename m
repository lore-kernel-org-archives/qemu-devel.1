Received: from eggs.gnu.org ([2001:4830:134:3::10]:59477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fnUaV-0005za-Oj
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fnUaS-0001qC-Ly
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fnUaS-0001og-Bh
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:57:40 -0400
Date: Wed, 8 Aug 2018 16:57:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180808195737.GY23195@localhost.localdomain>
References: <20180808191951.23193-1-mark.cave-ayland@ilande.co.uk>
	<8de65abc-7623-b3ce-f1c6-a0efaec1fac4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de65abc-7623-b3ce-f1c6-a0efaec1fac4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: add bootdevice-ignore-suffixes
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On Wed, Aug 08, 2018 at 09:39:49PM +0200, Laszlo Ersek wrote:
> On 08/08/18 21:19, Mark Cave-Ayland wrote:
> > For the older machines (such as Mac and SPARC) the DT nodes representing
> > bootdevices for disk nodes are irregular for mainly historical reasons.
> > 
> > Since the majority of bootdevice nodes for these machines either do not have a
> > separate disk node or require different (custom) names then it is much easier
> > to disable all suffixes for a particular machine by setting the ignore_suffixes
> > parameter to get_boot_devices_list() to true, and customise the disk nodes as
> > required.
> > 
> > Here we add a new bootdevice-ignore-suffixes property to the FW_CFG device to
> > allow the generation of disk suffixes to be controlled on a per-machine basis.
> > 
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > ---
> >  hw/nvram/fw_cfg.c         | 9 ++++++++-
> >  include/hw/nvram/fw_cfg.h | 1 +
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > index b23e7f64a8..52488b999f 100644
> > --- a/hw/nvram/fw_cfg.c
> > +++ b/hw/nvram/fw_cfg.c
> > @@ -861,7 +861,8 @@ static void fw_cfg_machine_reset(void *opaque)
> >      void *ptr;
> >      size_t len;
> >      FWCfgState *s = opaque;
> > -    char *bootindex = get_boot_devices_list(&len, false);
> > +    char *bootindex = get_boot_devices_list(&len,
> > +                                            s->bootdevice_ignore_suffixes);
> >  
> >      ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
> >      g_free(ptr);
> > @@ -990,12 +991,18 @@ FWCfgState *fw_cfg_find(void)
> >      return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
> >  }
> >  
> > +static Property fw_cfg_properties[] = {
> > +    DEFINE_PROP_BOOL("bootdevice-ignore-suffixes", FWCfgState,
> > +                     bootdevice_ignore_suffixes, false),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> 
> I've got two questions which are not "loaded" -- I honestly have no clue:
> 
> - Do we intend to expose this to users and higher-level tools? If not,
> should it be called "x-..." (experimental)? I can't remember the rules
> about "x-" properties.

That would be a good idea.  But maybe we can skip using QOM to
address this, and go back to a MachineClass field (but this time
not fw_cfg-specific).  See my other reply.


> 
> - I vaguely recall that earlier we tried to add properties to the fw_cfg
> base class, but ultimately added them to the derived classes (see
> "fw_cfg_mem_properties" and "fw_cfg_io_properties"). Despite the fact
> that the referenced fields themselves (dma_enabled, file_slots) belong
> to the base class; IOW, the properties refer to "parent_obj.xxx". I
> don't really remember why we did this. I seem to recall issues
> otherwise, with setting the property from the command line due to object
> construction / realization order, or whatever.

Maybe it was a workaround to an old bug in compat_props handling.
I will try to find out.

> 
> Mark, can you verify whether you can control
> "bootdevice-ignore-suffixes" from the command line, e.g. via "-global"?
> 
> The object model keeps scaring me. :(

You're not alone.  :(

-- 
Eduardo
