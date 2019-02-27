Received: from eggs.gnu.org ([209.51.188.92]:56764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gyzip-0001EP-CP
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gyzio-0006RK-Ak
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:58:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gyzio-0006NS-1c
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:58:06 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20190227121052.GD2602@work-vm> (David Alan Gilbert's message of
	"Wed, 27 Feb 2019 12:10:52 +0000")
References: <20190227121052.GD2602@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 27 Feb 2019 13:41:48 +0100
Message-ID: <877edltncj.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] possible ahci/migrate fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> Hi Alex,
>   Can you see if the attached patch fixes the ahci/migrate failure you
> see;  it won't fail for me however mean I am to it.
>
>

....

>  void migration_object_finalize(void)
>  {
> +    /*
> +     * Cancel the current migration - that will (eventually)
> +     * stop the migration using this structure
> +     */
> +    migrate_fd_cancel(current_migration);

This can only happen during "civilized" exit of qemu, right?
Otherwise, we are changing the migration status.

>      object_unref(OBJECT(current_migration));
>  }
>  
> @@ -3134,6 +3140,7 @@ static void *migration_thread(void *opaque)
>  
>      rcu_register_thread();
>  
> +    object_ref(OBJECT(s));

It is weird that this is not enough :-(

>      s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>  
>      qemu_savevm_state_header(s->to_dst_file);
> @@ -3230,6 +3237,7 @@ static void *migration_thread(void *opaque)
>  
>      trace_migration_thread_after_loop();
>      migration_iteration_finish(s);
> +    object_unref(OBJECT(s));
>      rcu_unregister_thread();
>      return NULL;
>  }
> diff --git a/vl.c b/vl.c
> index 2f340686a7..c1920165f3 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4579,6 +4579,12 @@ int main(int argc, char **argv, char **envp)
>  
>      gdbserver_cleanup();
>  
> +    /*
> +     * cleaning up the migration object cancels any existing migration
> +     * try to do this early so that it also stops using devices.
> +     */
> +    migration_object_finalize();
> +
>      /* No more vcpu or device emulation activity beyond this point */
>      vm_shutdown();
>  
> @@ -4594,7 +4600,6 @@ int main(int argc, char **argv, char **envp)
>      monitor_cleanup();
>      qemu_chr_cleanup();
>      user_creatable_cleanup();
> -    migration_object_finalize();
>      /* TODO: unref root container, check all devices are ok */
>  
>      return 0;

Ok, it was happening really late.

Once that you are at this, can we rename it?

migration_cleanup()

looks more consistent with everything else, and makes sure that it does
"more" than finalize the object, no?

Furthermore, it is enough to "just" cancel the migration?  It is not
needed that we wait for the migration thread to finish?

If the problem was that migration_thread() was accessing the object
after main thread freed it, then just the ref counting should be enough,
no?  My understanding is that returning from main is the quivalent of
exit() and kill all threads?  Or are we doing something special for that
not to happen?

Later, Juan.
