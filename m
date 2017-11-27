Received: from eggs.gnu.org ([2001:4830:134:3::10]:41947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eJF1U-0003Sx-5M
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 03:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eJF1S-0004xS-Vu
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 03:44:16 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:44681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eJF1S-0004x4-OP
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 03:44:14 -0500
Received: by mail-wm0-x241.google.com with SMTP id r68so32532652wmr.3
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 00:44:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171127073233.15376-1-fangying1@huawei.com>
References: <20171127073233.15376-1-fangying1@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Nov 2017 09:44:12 +0100
Message-ID: <CAJ+F1CJHNgOGKow4jhJVyiM9-9r1WnB7vJDb9+PORjE+0ei2DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] vhost: Cancel migration when vhost-user
 process restarted during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fangying <fangying1@huawei.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>

Hi

On Mon, Nov 27, 2017 at 8:32 AM, fangying <fangying1@huawei.com> wrote:
> QEMU will abort when vhost-user process is restarted during migration
> and vhost_log_global_start/stop is called. The reason is clear that
> vhost_dev_set_log returns -1 because network connection is temporarily
> lost. To handle this situation, let's cancel migration here.
>
> Signed-off-by: Ying Fang <fangying1@huawei.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/virtio/vhost.c     | 15 +++++++++++++--
>  migration/migration.c |  2 +-
>  migration/migration.h |  2 +-
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index ddc42f0..e2ade93 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -26,6 +26,7 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/blocker.h"
> +#include "migration/migration.h"
>  #include "sysemu/dma.h"
>
>  /* enabled until disconnected backend stabilizes */
> @@ -882,20 +883,30 @@ static int vhost_migration_log(MemoryListener *list=
ener, int enable)
>  static void vhost_log_global_start(MemoryListener *listener)
>  {
>      int r;
> +    MigrationState *s =3D NULL;
>
>      r =3D vhost_migration_log(listener, true);
>      if (r < 0) {
> -        abort();
> +        error_report("Failed to start vhost dirty log");
> +        s =3D migrate_get_current();
> +        if (s->migration_thread_running) {
> +            migrate_fd_cancel(s);
> +        }
>      }
>  }
>
>  static void vhost_log_global_stop(MemoryListener *listener)
>  {
>      int r;
> +    MigrationState *s =3D NULL;
>
>      r =3D vhost_migration_log(listener, false);
>      if (r < 0) {
> -        abort();
> +        error_report("Failed to stop vhost dirty log");
> +        s =3D migrate_get_current();
> +        if (s->migration_thread_running) {
> +            migrate_fd_cancel(s);
> +        }
>      }
>  }
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 4de3b55..6d2b7df 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1131,7 +1131,7 @@ void migrate_fd_error(MigrationState *s, const Erro=
r *error)
>      block_cleanup_parameters(s);
>  }
>
> -static void migrate_fd_cancel(MigrationState *s)
> +void migrate_fd_cancel(MigrationState *s)
>  {
>      int old_state ;
>      QEMUFile *f =3D migrate_get_current()->to_dst_file;
> diff --git a/migration/migration.h b/migration/migration.h
> index 663415f..f0261e3 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -167,7 +167,7 @@ uint64_t migrate_max_downtime(void);
>
>  void migrate_set_error(MigrationState *s, const Error *error);
>  void migrate_fd_error(MigrationState *s, const Error *error);
> -
> +void migrate_fd_cancel(MigrationState *s);
>  void migrate_fd_connect(MigrationState *s);
>
>  MigrationState *migrate_init(void);
> --
> 1.8.3.1
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
