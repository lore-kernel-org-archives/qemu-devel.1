Received: from eggs.gnu.org ([2001:4830:134:3::10]:41393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dMxeh-0006JV-5k
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dMxed-0003y0-W9
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dMxed-0003xn-Ms
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DE5B85359
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 14:27:46 +0000 (UTC)
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-2-git-send-email-peterx@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <4ed9fab7-19e4-42b7-03cb-99f640f8ec0a@redhat.com>
Date: Mon, 19 Jun 2017 16:27:39 +0200
MIME-Version: 1.0
In-Reply-To: <1497876588-947-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/13] machine: export
 register_compat_prop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 19/06/2017 14:49, Peter Xu wrote:
> We have HW_COMPAT_*, however that's only binded to machines, not other
> things (like accelerators).  Behind it, it was register_compat_prop()
> that played the trick.  Let's export the function for further use
> outside HW_COMPAT_* magic.
> 
> Meanwhile, move it to qdev-properties.c where seems more proper.
> Refactor it a bit to provide global_prop_list_add() for further
> use (will use it in cases where we need a GlobalProperty list).
> 
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  accel.c                      |  1 +
>  hw/core/machine.c            | 14 +-------------
>  hw/core/qdev-properties.c    | 22 ++++++++++++++++++++++
>  include/hw/qdev-properties.h |  5 +++++
>  4 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/accel.c b/accel.c
> index 664bb88..62edd29 100644
> --- a/accel.c
> +++ b/accel.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "sysemu/accel.h"
>  #include "hw/boards.h"
> +#include "hw/qdev-properties.h"
>  #include "qemu-common.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2e7e977..b4b3449 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -16,6 +16,7 @@
>  #include "qapi-visit.h"
>  #include "qapi/visitor.h"
>  #include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "qemu/error-report.h"
> @@ -770,19 +771,6 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
>      g_free(mc->name);
>  }
>  
> -static void register_compat_prop(const char *driver,
> -                                 const char *property,
> -                                 const char *value)
> -{
> -    GlobalProperty *p = g_new0(GlobalProperty, 1);
> -    /* Machine compat_props must never cause errors: */
> -    p->errp = &error_abort;
> -    p->driver = driver;
> -    p->property = property;
> -    p->value = value;
> -    qdev_prop_register_global(p);
> -}
> -
>  static void machine_register_compat_for_subclass(ObjectClass *oc, void *opaque)
>  {
>      GlobalProperty *p = opaque;
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 9f1a497..4b74382 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1042,6 +1042,28 @@ void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value)
>  
>  static GList *global_props;
>  
> +GList *global_prop_list_add(GList *list, const char *driver,
> +                            const char *property, const char *value)
> +{
> +    GlobalProperty *p = g_new0(GlobalProperty, 1);
> +
> +    /* These properties cannot fail the apply */
> +    p->errp = &error_abort;
> +    p->driver = driver;
> +    p->property = property;
> +    p->value = value;
> +
> +    return g_list_append(list, p);
> +}
> +
> +void register_compat_prop(const char *driver,
> +                          const char *property,
> +                          const char *value)
> +{
> +    global_props = global_prop_list_add(global_props, driver,
> +                                        property, value);
> +}
> +
>  void qdev_prop_register_global(GlobalProperty *prop)
>  {
>      global_props = g_list_append(global_props, prop);
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index d206fc9..15ee6ba 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -201,6 +201,11 @@ void qdev_prop_set_globals(DeviceState *dev);
>  void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
>                                      Property *prop, const char *value);
>  
> +GList *global_prop_list_add(GList *list, const char *driver,
> +                            const char *property, const char *value);
> +void register_compat_prop(const char *driver, const char *property,
> +                          const char *value);
> +
>  /**
>   * qdev_property_add_static:
>   * @dev: Device to add the property to.
> 
