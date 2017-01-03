Received: from eggs.gnu.org ([2001:4830:134:3::10]:43688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOPyw-0003g8-Vj
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOPyt-0005ck-Pm
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:22:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cOPyt-0005cN-Gx
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 09:22:27 -0500
Date: Tue, 3 Jan 2017 12:22:23 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170103142223.GB3315@thinpad.lan.raisama.net>
References: <20161229223815.13705-1-ehabkost@redhat.com>
	<20161230152834.6d1fa963@Igors-MacBook-Pro.local>
	<20161230182308.GK3441@thinpad.lan.raisama.net>
	<20170103140252.1a2df147@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170103140252.1a2df147@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qdev: Make "hotplugged" property read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Tue, Jan 03, 2017 at 02:02:52PM +0100, Igor Mammedov wrote:
> On Fri, 30 Dec 2016 16:23:08 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Fri, Dec 30, 2016 at 03:28:34PM +0100, Igor Mammedov wrote:
> > > On Thu, 29 Dec 2016 20:38:15 -0200
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > > > The "hotplugged" property is user visible, but it was never meant
> > > > to be set by the user. There are probably multiple ways to break
> > > > or crash device code by overriding the property. One example:
> > > > 
> > > >   $ qemu-system-x86_64 -cpu qemu64,hotplugged=true
> > > >   Segmentation fault (core dumped)
> > > > 
> > > > The DeviceState::hotplugged struct field is set directly by
> > > > device_initfn(), there's no need to provide a setter for the
> > > > property.  
> > > this property is meant to be used for individual devices on target side
> > > of migration.  
> > 
> > I didn't know that. Is this documented somewhere?
> > Is it actually used by any existing software?
> not that I know of. But users should be fixed if they are not using it.

I see. The problem is that the mechanism is undocumented,
untested, and seems very likely to trigger bugs in device code.

> 
> > > Doing above is a rather big hammer with behavioral change of migrated
> > > instance.  
> > 
> > If the property is really supposed to be set directly by users,
> > then I agree. But I would like to understand how exactly it is
> > supposed to work, so we can fix those issues properly.
> > 
> > Do you have any existing example where setting "hotplugged=true"
> > on the command-line is necessary and where it really works?
> > 
> > > 
> > > So I'd  fix crash caused by assumption that hotplugged CPU
> > > guarantied to have rtc&fw_cfg available.
> > > I'll post a patch with the fix.  
> > 
> > Most of the cases where I see DeviceState::hotplugged being used
> > are related to generation of hotplug events[1] or completing
> > steps that are normally done by machine init code[2][3], and I am
> > not sure this should be the case when we're just migrating
> > hotplugged devices. Are all those cases broken, and they should
> > be checking the qdev_hotplug global variable instead?
> skipping hotplugged for x86 CPUs and pc-dimms on target side shouldn't
> affect functionality as current ACPI code doesn't depends on it
> and it's safe to drop hotplug events for already plugged devices
> as machine init/done code would do the rest of initialization
> in this case.
> 
> However if hotplugged property is not set on target then
> mgmt would loose information that device has been hotplugged
> when it would query qemu. For example:
> info memory-devices 
> Memory device [dimm]: ""
>   addr: 0x100000000
>   slot: 1
>   node: 0
>   size: 1073741824
>   memdev: /objects/mem2
>   hotplugged: false
>   hotpluggable: true  <=== would become false
> 
> 
> Also beside of simplistic use of hotplugged by x86 cpus/pc-dimm,
> 'git grep hotplugged' shows that it's used by
> pci, spapr and other devices and I'm not sure that
> changing hotplugged from true to false is safe thing to do.

Yes. But for the same reason I am not sure that setting
hotplugged=on on command-line devices is a safe thing to do.

So, we have two problems we want to avoid:
A) Not changing hotplugged from true to false on migration;
B) Not breaking devices when using
   "-device ...,hotplugged=true" on the command-line.

Problem (A) already exists, as far as I can see, but we never got
any bug reports related to it.

The fix for (A) you propose is to set "hotplugged=true" on the
command-line. This triggered (B) on the CPU code, but your patch
fixed it.

The fix I proposed for (B) (this patch) prevents your fix for (A)
from being implemented. This is a problem.

Your patch to fix (B) in the CPU code looks good, but I am
worried about other possible instances of (B).

So, I propose we do this:

1) Drop this patch, by now;
2) Document properly what management software is supposed
   to do to fix (A), and test if the proposed solution doesn't
   break anything (I think we will find other device code to
   crash or misbehave if using "-device ...,hotplugged=true");
3) If we don't do (2) in the next QEMU release, I will resubmit
   this patch to remove the unused/undocumented/untested feature.

> 
> 
> > Examples:
> > 
> > [1] acpi_cpu_plug_cb(), acpi_pcihp_device_plug_cb(),
> >     nvdimm_acpi_plug_cb();
> > [2] cpu_common_realizefn() calls cpu_synchronize_post_init() and
> >     cpu_resume() if dev->hotplug is set.
> > [3] pc_cpu_plug()
> > 
> > >   
> > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > ---
> > > >  hw/core/qdev.c | 9 +--------
> > > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > > > 
> > > > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > > > index 57834423b9..f5989c41cb 100644
> > > > --- a/hw/core/qdev.c
> > > > +++ b/hw/core/qdev.c
> > > > @@ -1013,13 +1013,6 @@ static bool device_get_hotplugged(Object *obj, Error **err)
> > > >      return dev->hotplugged;
> > > >  }
> > > >  
> > > > -static void device_set_hotplugged(Object *obj, bool value, Error **err)
> > > > -{
> > > > -    DeviceState *dev = DEVICE(obj);
> > > > -
> > > > -    dev->hotplugged = value;
> > > > -}
> > > > -
> > > >  static void device_initfn(Object *obj)
> > > >  {
> > > >      DeviceState *dev = DEVICE(obj);
> > > > @@ -1039,7 +1032,7 @@ static void device_initfn(Object *obj)
> > > >      object_property_add_bool(obj, "hotpluggable",
> > > >                               device_get_hotpluggable, NULL, NULL);
> > > >      object_property_add_bool(obj, "hotplugged",
> > > > -                             device_get_hotplugged, device_set_hotplugged,
> > > > +                             device_get_hotplugged, NULL,
> > > >                               &error_abort);
> > > >  
> > > >      class = object_get_class(OBJECT(dev));  
> > >   
> > 
> 

-- 
Eduardo
