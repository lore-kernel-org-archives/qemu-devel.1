Received: from eggs.gnu.org ([2001:4830:134:3::10]:54600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNefJ-0007MY-Gr
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNefF-0000MJ-Iq
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:23:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dNefF-0000Ls-Ao
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:23:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 679A5C04B925
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 12:23:16 +0000 (UTC)
Date: Wed, 21 Jun 2017 09:23:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170621122311.GC3928@thinpad.lan.raisama.net>
References: <1498031528-1990-1-git-send-email-peterx@redhat.com>
	<1498031528-1990-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498031528-1990-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/10] accel: introduce
 AccelClass.global_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jun 21, 2017 at 03:52:00PM +0800, Peter Xu wrote:
> Introduce this new field for the accelerator classes so that each
> specific accelerator in the future can register its own global
> properties to be used further by the system. It works just like how the
> old machine compatible properties do, but only tailored for
> accelerators.
> 
> Use the newly exported register_compat_prop() to pass the accelerator
> global properties to the global_props list.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/accel.c          | 10 ++++++++++
>  include/sysemu/accel.h | 10 ++++++++++
>  vl.c                   |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/accel/accel.c b/accel/accel.c
> index 7c079a5..212581c 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -120,6 +120,16 @@ void configure_accelerator(MachineState *ms)
>      }
>  }
>  
> +void accel_register_compat_props(AccelState *accel)
> +{
> +    AccelClass *class = ACCEL_GET_CLASS(accel);
> +    GlobalProperty *prop;
> +
> +    for (prop = class->global_props; prop && prop->driver; prop++) {
> +        register_compat_prop(prop->driver, prop->property, prop->value);
> +    }
> +}

I suggest adding a generic register_compat_props_array(GlobalProperty *props)
helper, so we can reuse it at machine_register_compat_props()
later (once we fix global property ordering in
qdev_prop_set_globals() and make the object_class_foreach() hack
in machine_register_compat_props() unnecessary).

> +
>  static void register_accel_types(void)
>  {
>      type_register_static(&accel_type);
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 15944c1..8a01e51 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -24,6 +24,7 @@
>  #define HW_ACCEL_H
>  
>  #include "qom/object.h"
> +#include "hw/qdev-properties.h"
>  
>  typedef struct AccelState {
>      /*< private >*/
> @@ -40,6 +41,13 @@ typedef struct AccelClass {
>      int (*available)(void);
>      int (*init_machine)(MachineState *ms);
>      bool *allowed;
> +    /*
> +     * Array of gobal properties that would be applied when specific

"global"

> +     * accelerator is chosen. It works just like
> +     * MachineClass.compat_props but it's for accelerators not
> +     * machines.
> +     */
> +    GlobalProperty *global_props;
>  } AccelClass;
>  
>  #define TYPE_ACCEL "accel"
> @@ -57,5 +65,7 @@ typedef struct AccelClass {
>  extern int tcg_tb_size;
>  
>  void configure_accelerator(MachineState *ms);
> +/* Register accelerator specific global properties */
> +void accel_register_compat_props(AccelState *accel);
>  
>  #endif
> diff --git a/vl.c b/vl.c
> index 59fea15..4452d7a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4571,6 +4571,7 @@ int main(int argc, char **argv, char **envp)
>              exit (i == 1 ? 1 : 0);
>      }
>  

I suggest a comment here warning about global property
registration ordering.  e.g.:

 /*
  * Ordering of global property registration matters:
  * - machine compat_props should override accelerator-specific
  *   globals.
  * - user-provided globals (-global, and global properties
  *   derived from other command-line options like -cpu) should
  *   override machine compat_props and accelerator-specific
  *   globals.
  */

> +    accel_register_compat_props(current_machine->accelerator);
>      machine_register_compat_props(current_machine);
>  
>      qemu_opts_foreach(qemu_find_opts("global"),

-- 
Eduardo
