Received: from eggs.gnu.org ([2001:4830:134:3::10]:51339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dS2oj-0003JA-Dw
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dS2of-0007Hg-Fd
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dS2of-0007Gt-6O
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB2463F1E7
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 14:59:07 +0000 (UTC)
Date: Mon, 3 Jul 2017 11:59:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170703145903.GL12152@localhost.localdomain>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1499049848-18012-3-git-send-email-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] vl: move global property,
 migrate init earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jul 03, 2017 at 10:44:06AM +0800, Peter Xu wrote:
> Currently drive_init_func() may call migrate_get_current() while the
> migrate object is still not ready yet at that time. Move the migration
> object init earlier, along with the global properties, right after
> acceleration init.
>=20
> This fixes a breakage for iotest 055, which caused an assertion failure=
.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Reported-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Fixes: 3df663 ("migration: move only_migratable to MigrationState")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  vl.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 0c497a3..2ae4313 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4414,6 +4414,18 @@ int main(int argc, char **argv, char **envp)
> =20
>      configure_accelerator(current_machine);
> =20
> +    /*
> +     * Register all the global properties, including accel properties,
> +     * machine properties, and user-specified ones.
> +     */
> +    register_global_properties(current_machine);
> +
> +    /*
> +     * Migration object can only be created after global properties
> +     * are applied correctly.
> +     */
> +    migration_object_init();
> +

So, things that might introduce bugs here are:
1) Unexpected qdev_prop_register_global() calls between this place and
   the original register_global_properties() call (that would now happen
   in a different order).
2) register_global_properties() seeing a different global property list
   because it is being called earlier.
   2.1) AccelClass::global_props is statically defined and will be the
        same here. Not a problem.
   2.2) MachineClass::compat_props: same as above.
   2.3) user-provided global properties: we need to ensure all
        properties in the "global" QemuOpts section are already
        available at this point.


To ensure (1) is not a problem, we need to check all calls for
qdev_prop_register_global().  The callers are:

* configure_rtc()
  - Called very early, when parsing command-line options.  Not a problem.=
[1]
* global_init_func()
  * Called by user_register_global_props()
    * Called by register_global_properties().
      - That's the code we're moving.  Not a problem.
* QEMU_OPTION_rtc_td_hack case in main()
  - Called very early, when parsing command-line options.  Not a problem.=
[1]
* QEMU_OPTION_no_kvm_pit_reinjection case in main()
  - Called very early, when parsing command-line options.  Not a problem.=
[1]
* register_compat_prop()
  * Called by machine_register_compat_props()
    * Called by register_global_properties().
      - That's the code we're moving.  Not a problem.
  * Called by machine_register_compat_for_subclass()
    * Called by machine_register_compat_props() (see above)
  * Called by register_compat_props_array()
    * Called by accel_register_compat_props()
      * Called by register_global_properties().
        - That's the code we're moving.  Not a problem.
* qdev_prop_register_global_list()
  - Used only by unit test code.
* cpu_common_parse_features()
  - Used when initializing CPUs, which is done much later, when
    machine_run_board_init() is called (or when -device is handled by
    device_init_func()).  Not a problem.[2]
* x86_cpu_parse_featurestr()
  - Same as above.


To ensure (2.3) is not a problem, we need to look for references to
qemu_find_opts("global") or qemu_global_opts.  They are:

* user_register_global_props()
  - This is the code we're moving.  Not a problem.
* default_driver_check() call at main()
  - This happens earlier, before the code we're moving.  Not a problem.
* qemu_global_option()
  - Called very early, when parsing command-line options.  Not a problem.


So the code reordering looks OK.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>


Notes about things we need to fix in the future:

[1] I think they should be replaced by qemu_global_option() calls, though=
.
[2] This is a fragile portion of the global property code and should be
    eventually moved to the command-line parsing section of main().


>      if (qtest_chrdev) {
>          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
>      }
> @@ -4595,18 +4607,6 @@ int main(int argc, char **argv, char **envp)
>              exit (i =3D=3D 1 ? 1 : 0);
>      }
> =20
> -    /*
> -     * Register all the global properties, including accel properties,
> -     * machine properties, and user-specified ones.
> -     */
> -    register_global_properties(current_machine);
> -
> -    /*
> -     * Migration object can only be created after global properties
> -     * are applied correctly.
> -     */
> -    migration_object_init();
> -
>      /* This checkpoint is required by replay to separate prior clock
>         reading from the other reads, because timer polling functions q=
uery
>         clock values from the log. */
> --=20
> 2.7.4
>=20

--=20
Eduardo
