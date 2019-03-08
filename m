Received: from eggs.gnu.org ([209.51.188.92]:54264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h2KXH-0003e0-4g
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h2KXG-0003CD-5a
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:47:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:7682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1h2KXF-0003AO-RX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:47:58 -0500
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Fri, 8 Mar 2019 18:47:52 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806070B11@shsmsx102.ccr.corp.intel.com>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190303145021.2962-8-chen.zhang@intel.com>
	<20190308174556.GH2834@work-vm>
In-Reply-To: <20190308174556.GH2834@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V3 7/7] Migration/colo.c: Make user obtain
 the COLO mode info after failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>




-----Original Message-----
From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]=20
Sent: Saturday, March 9, 2019 1:46 AM
To: Zhang, Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Zhang Chen <zhangckid@gmail.com>=
; Juan Quintela <quintela@redhat.com>; zhanghailiang <zhang.zhanghailiang@h=
uawei.com>; Markus Armbruster <armbru@redhat.com>; Eric Blake <eblake@redha=
t.com>; qemu-dev <qemu-devel@nongnu.org>
Subject: Re: [PATCH V3 7/7] Migration/colo.c: Make user obtain the COLO mod=
e info after failover

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> Add the last_colo_mode to save the status after failover.
> This patch can solve the issue that user got nothing to call=20
> query_colo_status after failover.

I don't understand what this is doing; cna you show me an example of the wa=
y the state looks before and after the patch?

Sure.
In current codes, when we use the " query_colo_status "  after failover, th=
e mode field will always return "none".
Because after failover we can't use  " get_colo_mode()" to get the mode, we=
 need the last_colo_mode args to save the last state.
I think we will use this args in new colo feature development.

Thanks
Zhang Chen

Dave

> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  migration/colo.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index=20
> d1ae2e6d11..6eba8e06f2 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -38,6 +38,9 @@
>  static bool vmstate_loading;
>  static Notifier packets_compare_notifier;
> =20
> +/* User need to know colo mode after COLO failover */ static COLOMode=20
> +last_colo_mode;
> +
>  #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
> =20
>  bool migration_in_colo_state(void)
> @@ -197,7 +200,10 @@ void colo_do_failover(MigrationState *s)
>          vm_stop_force_state(RUN_STATE_COLO);
>      }
> =20
> -    switch (get_colo_mode()) {
> +    /* Update last_COLO_mode to avoid unexpectedly exit COLO status */
> +    last_colo_mode =3D get_colo_mode();
> +
> +    switch (last_colo_mode) {
>      case COLO_MODE_PRIMARY:
>          primary_vm_do_failover();
>          break;
> @@ -263,7 +269,7 @@ COLOStatus *qmp_query_colo_status(Error **errp)  {
>      COLOStatus *s =3D g_new0(COLOStatus, 1);
> =20
> -    s->mode =3D get_colo_mode();
> +    s->mode =3D last_colo_mode;
> =20
>      switch (failover_get_state()) {
>      case FAILOVER_STATUS_NONE:
> @@ -515,6 +521,12 @@ static void colo_process_checkpoint(MigrationState *=
s)
>      Error *local_err =3D NULL;
>      int ret;
> =20
> +    last_colo_mode =3D get_colo_mode();
> +    if (last_colo_mode !=3D COLO_MODE_PRIMARY) {
> +        error_report("COLO mode must be COLO_MODE_PRIMARY");
> +        return;
> +    }
> +
>      failover_init_state();
> =20
>      s->rp_state.from_dst_file =3D=20
> qemu_file_get_return_path(s->to_dst_file);
> @@ -682,12 +694,18 @@ void *colo_process_incoming_thread(void *opaque)
>      Error *local_err =3D NULL;
>      int ret;
> =20
> -    rcu_register_thread();
> -    qemu_sem_init(&mis->colo_incoming_sem, 0);
> -
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_COLO);
> =20
> +    last_colo_mode =3D get_colo_mode();
> +    if (last_colo_mode !=3D COLO_MODE_SECONDARY) {
> +        error_report("COLO mode must be COLO_MODE_SECONDARY");
> +        return NULL;
> +    }
> +
> +    rcu_register_thread();
> +    qemu_sem_init(&mis->colo_incoming_sem, 0);
> +
>      failover_init_state();
> =20
>      mis->to_src_file =3D qemu_file_get_return_path(mis->from_src_file);
> --
> 2.17.GIT
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
