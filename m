Received: from eggs.gnu.org ([2001:4830:134:3::10]:57469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMyXv-0001mw-Fm
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMyXq-0000zN-GV
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:24:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dMyXq-0000xb-6r
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:24:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA3104E040
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 15:24:48 +0000 (UTC)
Date: Mon, 19 Jun 2017 12:24:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170619152445.GT5016@thinpad.lan.raisama.net>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497876588-947-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 02/13] qdev: enhance
 global_prop_list_add()
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

On Mon, Jun 19, 2017 at 08:49:37PM +0800, Peter Xu wrote:
> Originally it can only alloc new entries and insert. Let it be smarter
> that it can update existing fields, and even delete elements. This is
> preparation of (finally) the replacement of x86_cpu_apply_props(). If
> you see x86_cpu_apply_props(), it allows to skip entries when value is
> NULL. Here, it works just like deleting an existing entry.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

This makes the global property API much more complex, making the
interactions between different callers much more subtle.

Currently, the global property list was always an append-only
list, and we had only two possible sources of global properties:
 1) MachineClass::compat_props;
 2) User-provided globals (including -global and other
   command-line options that are simply translated to globals).
So it is easy to calculate the results of a given QEMU
configuration: just append both lists.

With this patch, the rules become more complex, and calculating
the actual results of multiple register_compat_prop() calls is
not trivial.  Tracking the actual register_compat_prop() calls
scattered around the code (and figuring out the order in which
they are called) makes it even more difficult.  IMO, this defeats
the purpose of introducing a AccelClass::global_props field.

I believe the main source of this complexity are the
x86_cpu_change_kvm_default() calls in pc_piix.c, and the rules
those calls represent are really more complex.  But I would like
to find a simpler solution to represent those rules inside either
MachineClass::compat_props or AccelClass::global_props.  If we
can't do that, I think we should keep that complexity inside the
PC/x86 code instead of exposing it to all users of the global
properties API.

I suggest we do this, to keep things simple in the first version:

1) Introduce AccelClass::global_props without this patch.
2) Move: kvmclock, kvm-nopiodelay, kvm-asyncpf, kvm-steal-time,
   kvmclock-stable-bit, acpi, monitor to AccelClass::global_props
   in kvm-accel.
3) Move: vme=off to AccelClass::global_props in tcg-accel.
4) Keep svm, x2apic and kvm-pv-eoi inside kvm_default_props in
   x86 code, because their rules are more complex.
5) Look for a simpler way to represent the rules from (4) later.


> ---
>  hw/core/qdev-properties.c    | 28 +++++++++++++++++++++++++++-
>  include/hw/qdev-properties.h | 10 ++++++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 4b74382..dc3b0ac 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1045,7 +1045,33 @@ static GList *global_props;
>  GList *global_prop_list_add(GList *list, const char *driver,
>                              const char *property, const char *value)
>  {
> -    GlobalProperty *p = g_new0(GlobalProperty, 1);
> +    GList *l;
> +    GlobalProperty *p;
> +
> +    /* Look up the (property, value) first in the list */
> +    for (l = list; l; l = l->next) {
> +        p = l->data;
> +        if (!strcmp(driver, p->driver) && !strcmp(property, p->property)) {
> +            if (value) {
> +                /* Modify existing value */
> +                p->value = value;
> +            } else {
> +                /* Delete this entry entirely */
> +                list = g_list_remove_link(list, l);
> +                g_free(p);
> +                g_list_free(l);
> +            }
> +            return list;
> +        }
> +    }
> +
> +    /* Entry not exist. If we are deleting one entry, we're done. */
> +    if (!value) {
> +        return list;
> +    }
> +
> +    /* If not found and value is set, we try to create a new entry */
> +    p = g_new0(GlobalProperty, 1);
>  
>      /* These properties cannot fail the apply */
>      p->errp = &error_abort;
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 15ee6ba..55ad507 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -201,6 +201,16 @@ void qdev_prop_set_globals(DeviceState *dev);
>  void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
>                                      Property *prop, const char *value);
>  
> +/*
> + * Register global property on the list. Elements of list should be
> + * GlobalProperty.
> + *
> + * - If (driver, property) is not existing on the list, create a new
> + *   one and link to the list.
> + * - If (driver, property) exists on the list, then:
> + *   - if value != NULL, update with new value
> + *   - if value == NULL, delete the entry
> + */
>  GList *global_prop_list_add(GList *list, const char *driver,
>                              const char *property, const char *value);
>  void register_compat_prop(const char *driver, const char *property,
> -- 
> 2.7.4
> 

-- 
Eduardo
