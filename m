Received: from eggs.gnu.org ([209.51.188.92]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBIJt-0003gU-D4
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBIJr-0003ff-FU
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:15:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hBIJp-0003ZD-Id
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:15:09 -0400
Date: Tue, 2 Apr 2019 13:14:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190402121455.GB2861@work-vm>
References: <20190401090827.20793-1-armbru@redhat.com>
	<20190401090827.20793-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401090827.20793-5-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] vl: Document dependencies hiding in
 global and compat props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, anthony.perard@citrix.com, peterx@redhat.com, quintela@redhat.com, kwolf@redhat.com, imammedo@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  vl.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index e4d7ad6b85..8c6d06b01d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4285,16 +4285,36 @@ int main(int argc, char **argv, char **envp)
>      current_machine->maxram_size = maxram_size;
>      current_machine->ram_slots = ram_slots;
>  
> +    /*
> +     * Note: uses machine properties such as kernel-irqchip, must run
> +     * after machine_set_property().
> +     */
>      configure_accelerator(current_machine, argv[0]);
>  
> +    /*
> +     * Beware, QOM objects created before this point miss global and
> +     * compat properties.
> +     *
> +     * Global properties get set up by qdev_prop_register_global(),
> +     * called from user_register_global_props(), and certain option
> +     * desugaring.

Not to stop this patch series; but could we add a way to actually
detect when this has happened?  Like setting a flag on QOM objects
created before this point for example?

>  Also in CPU feature desugaring (buried in
> +     * parse_cpu_model()), which happens below this point, but may
> +     * only target the CPU type, which can only be created after
> +     * parse_cpu_model() returned the type.
> +     *
> +     * Machine compat properties: object_set_machine_compat_props().
> +     * Accelerator compat props: object_set_accelerator_compat_props(),
> +     * called from configure_accelerator().
> +     */
> +
>      if (!qtest_enabled() && machine_class->deprecation_reason) {
>          error_report("Machine type '%s' is deprecated: %s",
>                       machine_class->name, machine_class->deprecation_reason);
>      }
>  
>      /*
> -     * Migration object can only be created after global properties
> -     * are applied correctly.
> +     * Note: creates a QOM object, must run only after global and
> +     * compat properties have been set up.
>       */
>      migration_object_init();
>  
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
