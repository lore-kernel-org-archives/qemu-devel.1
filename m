Received: from eggs.gnu.org ([209.51.188.92]:43077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gz2MB-0003yr-Tc
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gz2Lz-0001GA-CO
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:46:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gz2Ly-0001Cn-Ax
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:46:43 -0500
Received: by mail-wm1-x329.google.com with SMTP id a62so6551836wmh.4
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 08:46:41 -0800 (PST)
References: <20190227121052.GD2602@work-vm>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190227121052.GD2602@work-vm>
Date: Wed, 27 Feb 2019 16:46:37 +0000
Message-ID: <87imx5kwlu.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com


Dr. David Alan Gilbert <dgilbert@redhat.com> writes:

> Hi Alex,
>   Can you see if the attached patch fixes the ahci/migrate failure you
> see;  it won't fail for me however mean I am to it.

over 2000 iterations without issue, commit before crashed within 30

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

How quickly can we get this merged?

>
>
> From f4c327d14d656d1c0f0e694d0efc6165493416f0 Mon Sep 17 00:00:00 2001
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Date: Wed, 27 Feb 2019 12:04:37 +0000
> Subject: [PATCH] migration: Cleanup during exit
>
> Currently we cleanup the migration object as we exit main after the
> main_loop finishes; however if there's a migration running things
> get messy and we can end up with the migration thread still trying
> to access freed structures.
>
> We now take a ref to the object around the migration thread itself,
> so the act of dropping the ref during exit doesn't cause us to lose
> the state until the thread quits.
>
> Cancelling the migration during migration also tries to get the thread
> to quit.
>
> We do this a bit earlier; so hopefully migration gets out of the way
> before all the devices etc are freed.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c | 8 ++++++++
>  vl.c                  | 7 ++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index e44f77af02..f612313d09 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -126,6 +126,7 @@ static bool migration_object_check(MigrationState *ms=
, Error **errp);
>  static int migration_maybe_pause(MigrationState *s,
>                                   int *current_active_state,
>                                   int new_state);
> +static void migrate_fd_cancel(MigrationState *s);
>
>  void migration_object_init(void)
>  {
> @@ -169,6 +170,11 @@ void migration_object_init(void)
>
>  void migration_object_finalize(void)
>  {
> +    /*
> +     * Cancel the current migration - that will (eventually)
> +     * stop the migration using this structure
> +     */
> +    migrate_fd_cancel(current_migration);
>      object_unref(OBJECT(current_migration));
>  }
>
> @@ -3134,6 +3140,7 @@ static void *migration_thread(void *opaque)
>
>      rcu_register_thread();
>
> +    object_ref(OBJECT(s));
>      s->iteration_start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
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
> --
> 2.20.1


--
Alex Benn=C3=A9e
