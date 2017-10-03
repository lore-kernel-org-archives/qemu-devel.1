Received: from eggs.gnu.org ([2001:4830:134:3::10]:59774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzSGR-00060r-VS
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzSGO-00061j-1Y
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzSGN-0005w0-Ng
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 14:49:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CA5F5F2973
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 18:49:50 +0000 (UTC)
Date: Tue, 3 Oct 2017 15:49:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003184946.GR17385@localhost.localdomain>
References: <1507049162-27026-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507049162-27026-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qdev: Check for the availability of a
 hotplug controller before adding a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Oct 03, 2017 at 06:46:02PM +0200, Thomas Huth wrote:
> The qdev_unplug() function contains a g_assert(hotplug_ctrl) statement,
> so QEMU crashes when the user tries to device_add + device_del a device
> that does not have a corresponding hotplug controller. This could be
> provoked for a couple of devices in the past (see commit 4c93950659487c7ad
> or 84ebd3e8c7d4fe955 for example). So devices clearly need a hotplug
> controller when they are suitable for device_add.
> The code in qdev_device_add() already checks whether the bus has a proper
> hotplug controller, but for devices that do not have a corresponding bus,
> there is no appropriate check available. In that case we should check
> whether the machine itself provides a suitable hotplug controller and
> refuse to plug the device if none is available.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  This is the follow-up patch from my earlier try "hw/core/qdev: Do not
>  allow hot-plugging without hotplug controller" ... AFAICS the function
>  qdev_device_add() is now the right spot to do the check.
> 
>  hw/core/qdev.c         | 28 ++++++++++++++++++++--------
>  include/hw/qdev-core.h |  1 +
>  qdev-monitor.c         |  9 +++++++++
>  3 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 606ab53..a953ec9 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -253,19 +253,31 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>      dev->alias_required_for_version = required_for_version;
>  }
>  
> +HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
> +{
> +    MachineState *machine;
> +    MachineClass *mc;
> +    Object *m_obj = qdev_get_machine();
> +
> +    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
> +        machine = MACHINE(m_obj);
> +        mc = MACHINE_GET_CLASS(machine);
> +        if (mc->get_hotplug_handler) {
> +            return mc->get_hotplug_handler(machine, dev);
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
>  {
> -    HotplugHandler *hotplug_ctrl = NULL;
> +    HotplugHandler *hotplug_ctrl;
>  
>      if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>          hotplug_ctrl = dev->parent_bus->hotplug_handler;
> -    } else if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
> -        MachineState *machine = MACHINE(qdev_get_machine());
> -        MachineClass *mc = MACHINE_GET_CLASS(machine);
> -
> -        if (mc->get_hotplug_handler) {
> -            hotplug_ctrl = mc->get_hotplug_handler(machine, dev);
> -        }
> +    } else {
> +        hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
>      }
>      return hotplug_ctrl;
>  }
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 0891461..5aa536d 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -285,6 +285,7 @@ DeviceState *qdev_try_create(BusState *bus, const char *name);
>  void qdev_init_nofail(DeviceState *dev);
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
> +HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
>  void qdev_unplug(DeviceState *dev, Error **errp);
>  void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 8fd6df9..2891dde 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -626,6 +626,15 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>          return NULL;
>      }
>  
> +    /* In case we don't have a bus, there must be a machine hotplug handler */
> +    if (qdev_hotplug && !bus && !qdev_get_machine_hotplug_handler(dev)) {
> +        error_setg(errp, "Device '%s' can not be hotplugged on this machine",
> +                   driver);
> +        object_unparent(OBJECT(dev));

Isn't it better to check qdev_get_machine_hotplug_handler()
earlier (before the qdev_set_parent_bus() and qdev_set_id()
lines), so object_unparent() isn't necessary?

(We probably don't need to call object_unparent() here, already,
because bus is NULL.  But moving the check before the "if (bus)
qdev_set_parent_bus()" statement would make this more obvious).

I would prefer to eventually make
MachineClass::get_hotplug_handler() get a typename or
DeviceClass* argument instead of DeviceState*, so we don't even
create the device object.  But I don't think it's a requirement
for this bug fix.


> +        object_unref(OBJECT(dev));
> +        return NULL;
> +    }
> +
>      dev->opts = opts;
>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
>      if (err != NULL) {
> -- 
> 1.8.3.1
> 

-- 
Eduardo
