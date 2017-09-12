Received: from eggs.gnu.org ([2001:4830:134:3::10]:39501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drpZY-00073L-G6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drpZS-0002Px-K1
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:06:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1drpZS-0002PE-BT
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:06:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF6025F723
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 18:06:00 +0000 (UTC)
Date: Tue, 12 Sep 2017 15:05:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170912180556.GD7570@localhost.localdomain>
References: <1504776162-31400-1-git-send-email-thuth@redhat.com>
	<20170911145344.4f2e192c@nial.brq.redhat.com>
	<f62b660d-596a-f5ed-b4c7-d5adf58d2913@redhat.com>
	<20170911170600.145e752d@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170911170600.145e752d@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/core/qdev: Do not allow hot-plugging
 without hotplug controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Mon, Sep 11, 2017 at 05:06:00PM +0200, Igor Mammedov wrote:
> On Mon, 11 Sep 2017 16:31:39 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
> > On 11.09.2017 14:53, Igor Mammedov wrote:
> > > On Thu,  7 Sep 2017 11:22:42 +0200
> > > Thomas Huth <thuth@redhat.com> wrote:
> > >   
> > >> qdev_unplug() bails out with an assertion if the user tries to device_del
> > >> a hot-plugged device that does not have a hotplug controller. Unfortunately,
> > >> our devices are all marked with hotpluggable = true by default (see the
> > >> device_class_init() function in qdev.c), so it currently can happen that
> > >> the user runs into this situation and QEMU gets terminated unexpectedly:
> > >>
> > >> $ qemu-system-aarch64 -M virt -nographic -nodefaults -monitor stdio -S
> > >> QEMU 2.10.50 monitor - type 'help' for more information
> > >> (qemu) device_add aux-to-i2c-bridge,id=x
> > >> (qemu) device_del x
> > >> **
> > >> ERROR:qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
> > >> Aborted (core dumped)
> > >> Hotplugging devices without a hotplug controller does not make much sense,
> > >> so we should disallow this during the device_add process already!
> > >>
> > >> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > >> ---
> > >>  hw/core/qdev.c | 5 +++++
> > >>  1 file changed, 5 insertions(+)
> > >>
> > >> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > >> index 606ab53..d9ccce6 100644
> > >> --- a/hw/core/qdev.c
> > >> +++ b/hw/core/qdev.c
> > >> @@ -908,6 +908,11 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
> > >>              if (local_err != NULL) {
> > >>                  goto fail;
> > >>              }
> > >> +        } else if (dev->hotplugged) {
> > >> +            /* Hot-plugged device without hotplug controller? No way! */
> > >> +            error_setg(&local_err, QERR_DEVICE_NO_HOTPLUG,
> > >> +                       object_get_typename(obj));
> > >> +            goto fail;
> > >>          }
> > >>  
> > >>          if (dc->realize) {  
> > > 
> > > maybe it should be other way around, i.e, fix device so that following would work
> > > 
> > >   device_set_realized()
> > >     if (dev->hotplugged && !dc->hotpluggable) {                                  
> > >         error_setg(errp, QERR_DEVICE_NO_HOTPLUG, object_get_typename(obj));      
> > >         return;                                                                  
> > >     }
> > > 
> > > instead of leaving device broken, like in yours
> > >  84ebd3e watchdog/wdt_diag288: Mark diag288 watchdog as non-hotpluggable  
> > 
> > No, that apparently does not work right for new devices since people
> > keep forgetting to set hotpluggable = false there. Both, Paolo and Peter
> > suggested that we should not allow hot-plugging if there's no hot plug
> > controller - it indeed does not make sense, so we should not allow it.
> historically all devices were hotpluggble and conversion to hotplug
> controller didn't fix it which os fine as far as user did not attempt
> unreasonable things. However it should be fixedfor code to work correctly.
> 
> I'd suggest to flip default
>  dc->hotpluggable = false;
> and set it to true explicitly for devices that support hotplug,
> it obviously harder to do than this patch as it requires audit
> of all devices, but it looks more correct than fixing symptoms of
> incorrectly set dc->hotpluggable property.

I agree we should do this.  If we have any device-type that is
not hotpluggable on any machine because no machine will return a
hotplug controller for it, we shouldn't report it as hotpluggable
through QMP and HMP.

But this patch also seems to be required, for cases where not all
machine-types accept hotplug of a given device type.

-- 
Eduardo
