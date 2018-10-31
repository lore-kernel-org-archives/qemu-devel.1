Received: from eggs.gnu.org ([2001:4830:134:3::10]:49151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gHqtS-0002zn-GW
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gHqtN-0001JZ-FO
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:50:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:40716 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gHqtL-00019S-OH
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 09:50:41 -0400
References: <20181029125818.28720-1-fli@suse.com>
	<20181029125818.28720-6-fli@suse.com>
From: Fei Li <fli@suse.com>
Message-ID: <5cd70ffc-a761-f7c5-aaab-32e408fb253c@suse.com>
Date: Wed, 31 Oct 2018 21:50:21 +0800
MIME-Version: 1.0
In-Reply-To: <20181029125818.28720-6-fli@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v6 5/7] migration: fix the multifd code
 when receiving less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, famz@redhat.com, armbru@redhat.com, peterx@redhat.com, dgilbert@redhat.com

Hi all,

I create a new thread to inquiry one live migration issue when using=20
multifd :)
I am not so sure with the rule that when and how to use the multifd is=20
correct,
so I'd like to confirm. This is because when I use the current upstream q=
emu
code and run into a failed case: "Migration status: failed (Unable to=20
write to
socket: Connection reset by peer)".

The detailed is as follows and the "failed" situation can not reproduce=20
100%.
But as far as I tested, if I do the live migration using multifd* just=20
after the
guest started for less than one minute*, I almost can reproduce this for=20
100%.

My steps are:
1. start the vm in the src side;
2. start the -incoming in the dst side;
3. after the vm started for a little while (After I open a file inside=20
the vm),
 =C2=A0=C2=A0=C2=A0 I begin the live migration, steps are:
- on src: migrate_set_capability x-multifd on
- on src: migrate_set_parameter x-multifd-channels 4
- on dst: migrate_set_capability x-multifd on
- on dst: migrate_set_parameter x-multifd-channels 4
- on src: migrate -d tcp:192.168.120.5:4444

Errors are:
[src]
linux-50ts:/mnt/live-migration # ./sle12-source.sh
QEMU 3.0.50 monitor - type 'help' for more information
(qemu) Running QEMU with SDL 1.2 is deprecated, and will be removed
in a future release. Please switch to SDL 2.0 instead
 =C2=A0migrate_set_capability x-multifd on
(qemu)=C2=A0 migrate_set_parameter x-multifd-channels 4
(qemu) migrate -d tcp:192.168.120.5:4444
(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off=20
zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off=20
release-ram: off block: off return-path: off pause-before-switchover:=20
off x-multifd: on dirty-bitmaps: off postcopy-blocktime: off=20
late-block-activate: off
Migration status: failed (Unable to write to socket: Connection reset by=20
peer)
total time: 0 milliseconds

[dst]
linux-p6v6:/mnt/live-migration # ./sle12-dest.sh
QEMU 3.0.50 monitor - type 'help' for more information
(qemu) migrate_set_capability x-multifd on
(qemu)=C2=A0 migrate_set_parameter x-multifd-channels 4
(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on


Hope this does not bother you too much. ;)
Have a nice day, thanks again
Fei

On 10/29/2018 08:58 PM, Fei Li wrote:
> In our current code, when multifd is used during migration, if there
> is an error before the destination receives all new channels, the
> source keeps running, however the destination does not exit but keeps
> waiting until the source is killed deliberately.
>
> Fix this by simply killing the destination when it fails to receive
> packet via some channel.
>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>   migration/channel.c   |  7 ++++++-
>   migration/migration.c |  9 +++++++--
>   migration/migration.h |  2 +-
>   migration/ram.c       | 17 ++++++++++++++---
>   migration/ram.h       |  2 +-
>   5 files changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 33e0e9b82f..572be4245a 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -44,7 +44,12 @@ void migration_channel_process_incoming(QIOChannel *=
ioc)
>               error_report_err(local_err);
>           }
>       } else {
> -        migration_ioc_process_incoming(ioc);
> +        Error *local_err =3D NULL;
> +        migration_ioc_process_incoming(ioc, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            exit(EXIT_FAILURE);
> +        }
>       }
>   }
>  =20
> diff --git a/migration/migration.c b/migration/migration.c
> index 8b36e7f184..87dfc7374f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -541,7 +541,7 @@ void migration_fd_process_incoming(QEMUFile *f)
>       migration_incoming_process();
>   }
>  =20
> -void migration_ioc_process_incoming(QIOChannel *ioc)
> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>   {
>       MigrationIncomingState *mis =3D migration_incoming_get_current();
>       bool start_migration;
> @@ -563,9 +563,14 @@ void migration_ioc_process_incoming(QIOChannel *io=
c)
>            */
>           start_migration =3D !migrate_use_multifd();
>       } else {
> +        Error *local_err =3D NULL;
>           /* Multiple connections */
>           assert(migrate_use_multifd());
> -        start_migration =3D multifd_recv_new_channel(ioc);
> +        start_migration =3D multifd_recv_new_channel(ioc, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>       }
>  =20
>       if (start_migration) {
> diff --git a/migration/migration.h b/migration/migration.h
> index f7813f8261..7df4d426d0 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -229,7 +229,7 @@ struct MigrationState
>   void migrate_set_state(int *state, int old_state, int new_state);
>  =20
>   void migration_fd_process_incoming(QEMUFile *f);
> -void migration_ioc_process_incoming(QIOChannel *ioc);
> +void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>   void migration_incoming_process(void);
>  =20
>   bool  migration_has_all_channels(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index 4db3b3e8f4..8f03afe228 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1072,6 +1072,7 @@ out:
>   static void multifd_new_send_channel_async(QIOTask *task, gpointer op=
aque)
>   {
>       MultiFDSendParams *p =3D opaque;
> +    MigrationState *s =3D migrate_get_current();
>       QIOChannel *sioc =3D QIO_CHANNEL(qio_task_get_source(task));
>       Error *local_err =3D NULL;
>  =20
> @@ -1080,6 +1081,7 @@ static void multifd_new_send_channel_async(QIOTas=
k *task, gpointer opaque)
>       }
>  =20
>       if (qio_task_propagate_error(task, &local_err)) {
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED=
);
>           if (multifd_save_cleanup(&local_err) !=3D 0) {
>               migrate_set_error(migrate_get_current(), local_err);
>           }
> @@ -1337,16 +1339,20 @@ bool multifd_recv_all_channels_created(void)
>   }
>  =20
>   /* Return true if multifd is ready for the migration, otherwise false=
 */
> -bool multifd_recv_new_channel(QIOChannel *ioc)
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>   {
> +    MigrationIncomingState *mis =3D migration_incoming_get_current();
>       MultiFDRecvParams *p;
>       Error *local_err =3D NULL;
>       int id;
>  =20
>       id =3D multifd_recv_initial_packet(ioc, &local_err);
>       if (id < 0) {
> +        error_propagate_prepend(errp, local_err,
> +                        "failed to receive packet via multifd channel =
%x: ",
> +                        multifd_recv_state->count);
>           multifd_recv_terminate_threads(local_err, false);
> -        return false;
> +        goto fail;
>       }
>  =20
>       p =3D &multifd_recv_state->params[id];
> @@ -1354,7 +1360,8 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>           error_setg(&local_err, "multifd: received id '%d' already set=
up'",
>                      id);
>           multifd_recv_terminate_threads(local_err, true);
> -        return false;
> +        error_propagate(errp, local_err);
> +        goto fail;
>       }
>       p->c =3D ioc;
>       object_ref(OBJECT(ioc));
> @@ -1366,6 +1373,10 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>                          QEMU_THREAD_JOINABLE);
>       atomic_inc(&multifd_recv_state->count);
>       return multifd_recv_state->count =3D=3D migrate_multifd_channels(=
);
> +fail:
> +    qemu_fclose(mis->from_src_file);
> +    mis->from_src_file =3D NULL;
> +    return false;
>   }
>  =20
>   /**
> diff --git a/migration/ram.h b/migration/ram.h
> index 83ff1bc11a..046d3074be 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -47,7 +47,7 @@ int multifd_save_cleanup(Error **errp);
>   int multifd_load_setup(void);
>   int multifd_load_cleanup(Error **errp);
>   bool multifd_recv_all_channels_created(void);
> -bool multifd_recv_new_channel(QIOChannel *ioc);
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  =20
>   uint64_t ram_pagesize_summary(void);
>   int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_ad=
dr_t len);
