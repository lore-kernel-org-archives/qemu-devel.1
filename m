Received: from eggs.gnu.org ([209.51.188.92]:55874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBH26-00071N-Tr
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hBH07-0006hA-VL
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:50:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hBH07-0006gj-KK
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:50:43 -0400
Date: Tue, 2 Apr 2019 12:50:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190402125034.1a052992@redhat.com>
In-Reply-To: <20190401090827.20793-2-armbru@redhat.com>
References: <20190401090827.20793-1-armbru@redhat.com>
	<20190401090827.20793-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] Revert "vl: Fix to create migration
 object before block backends again"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, anthony.perard@citrix.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, kwolf@redhat.com

On Mon,  1 Apr 2019 11:08:23 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> This reverts commit e60483f2f8498ae08ae79ca4c6fb03a3317f5e1e.
> 
> Recent commit cda4aa9a5a0 moved block backend creation before machine
> property evaluation.

Side note:
I've also looked at
 "[PATCH v3 11/12] pc: Support firmware configuration  with -blockdev"
that caused movement and have a similar issue with hostmem backends
where I wanted to set machine.inital-ram-memdev property pointing to
backend. But hostmem backends are created, since they have to be created
after machine_set_properties/configure_accelerator due to dependencies.

After some playing around with link property on machine and trying
to untangle dependency chain I gave up (doesn't look feasible).
Idea with aliasing like with blockdev won't work either due to
dependencies (also it looks to me to be quite complicated one).
So I've resorted to "usual" machine practice 'machine.set_string_property'
and deal with 'id' referred by it later at machine_run_board_init() time to
instantiate initial RAM, when we already created all backends.

> This broke block backends registering migration
> blockers.  Commit e60483f2f84 fixed it by moving migration object
> creation before block backend creation.  This broke migration with
> Xen.  Turns out we need to configure the accelerator before we create
> the migration object so that Xen's accelerator compat properties get
> applied.  Revert the flawed commit.  This fixes the Xen regression,
> but brings back the block backend regression.  The next commits will
> fix it again.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  vl.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index d61d5604e5..c1d5484e12 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4276,17 +4276,10 @@ int main(int argc, char **argv, char **envp)
>          exit(0);
>      }
>  
> -    /*
> -     * Migration object can only be created after global properties
> -     * are applied correctly.
> -     */
> -    migration_object_init();
> -
>      /*
>       * Note: we need to create block backends before
>       * machine_set_property(), so machine properties can refer to
> -     * them, and after migration_object_init(), so we can create
> -     * migration blockers.
> +     * them.
>       */
>      configure_blockdev(&bdo_queue, machine_class, snapshot);
>  
> @@ -4304,6 +4297,12 @@ int main(int argc, char **argv, char **envp)
>                       machine_class->name, machine_class->deprecation_reason);
>      }
>  
> +    /*
> +     * Migration object can only be created after global properties
> +     * are applied correctly.
> +     */
> +    migration_object_init();
> +
>      if (qtest_chrdev) {
>          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
>      }
