Received: from eggs.gnu.org ([2001:4830:134:3::10]:54378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crA0u-00055B-1T
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crA0q-0002ay-3P
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1crA0p-0002ak-RN
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:11:16 -0400
Date: Thu, 23 Mar 2017 18:11:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170323211111.GB32071@thinpad.lan.raisama.net>
References: <20161122061059.26058-1-jgross@suse.com>
	<20161122061059.26058-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161122061059.26058-3-jgross@suse.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qdev: add function qdev_set_id()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xensource.com, anthony.perard@citrix.com, sstabellini@kernel.org, kraxel@redhat.com, armbru@redhat.com

On Tue, Nov 22, 2016 at 07:10:57AM +0100, Juergen Gross wrote:
> In order to have an easy way to add a new qdev with a specific id
> carve out the needed functionality from qdev_device_add() into a new
> function qdev_set_id().
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

I believe I now understand the has_dynamic_sysbus code on patch
3/4: the callers of qdev_set_id() outside qdev_device_add() are
breaking foreach_dynamic_sysbus_device(), and
xen_set_dynamic_sysbus() is a workaround for that bug.

We now need to fix that bug to be able to remove the
xen_set_dynamic_sysbus() hack.

> ---
>  include/monitor/qdev.h |  1 +
>  qdev-monitor.c         | 36 ++++++++++++++++++++----------------
>  2 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> index 8e504bc..0ff3331 100644
> --- a/include/monitor/qdev.h
> +++ b/include/monitor/qdev.h
> @@ -12,5 +12,6 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
>  
>  int qdev_device_help(QemuOpts *opts);
>  DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
> +void qdev_set_id(DeviceState *dev, const char *id);
>  
>  #endif
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 4f78ecb..c73410c 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -539,10 +539,28 @@ static BusState *qbus_find(const char *path, Error **errp)
>      return bus;
>  }
>  
> +void qdev_set_id(DeviceState *dev, const char *id)
> +{
> +    if (id) {
> +        dev->id = id;
> +    }
> +
> +    if (dev->id) {
> +        object_property_add_child(qdev_get_peripheral(), dev->id,
> +                                  OBJECT(dev), NULL);
> +    } else {
> +        static int anon_count;
> +        gchar *name = g_strdup_printf("device[%d]", anon_count++);
> +        object_property_add_child(qdev_get_peripheral_anon(), name,
> +                                  OBJECT(dev), NULL);
> +        g_free(name);
> +    }
> +}
> +
>  DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>  {
>      DeviceClass *dc;
> -    const char *driver, *path, *id;
> +    const char *driver, *path;
>      DeviceState *dev;
>      BusState *bus = NULL;
>      Error *err = NULL;
> @@ -591,21 +609,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>          qdev_set_parent_bus(dev, bus);
>      }
>  
> -    id = qemu_opts_id(opts);
> -    if (id) {
> -        dev->id = id;
> -    }
> -
> -    if (dev->id) {
> -        object_property_add_child(qdev_get_peripheral(), dev->id,
> -                                  OBJECT(dev), NULL);
> -    } else {
> -        static int anon_count;
> -        gchar *name = g_strdup_printf("device[%d]", anon_count++);
> -        object_property_add_child(qdev_get_peripheral_anon(), name,
> -                                  OBJECT(dev), NULL);
> -        g_free(name);
> -    }
> +    qdev_set_id(dev, qemu_opts_id(opts));
>  
>      /* set properties */
>      if (qemu_opt_foreach(opts, set_property, dev, &err)) {
> -- 
> 2.10.0
> 
> 

-- 
Eduardo
