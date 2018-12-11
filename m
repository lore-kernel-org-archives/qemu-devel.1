Received: from eggs.gnu.org ([2001:4830:134:3::10]:55864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWldJ-0003F4-Jf
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWldF-00080f-5k
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:15:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWldD-0007wo-AA
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:15:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-28-marcandre.lureau@redhat.com>
Date: Tue, 11 Dec 2018 18:15:34 +0100
In-Reply-To: <20181208111606.8505-28-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 8 Dec 2018 15:16:06 +0400")
Message-ID: <87o99snfwp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 27/27] qapi: add conditions to
 REPLICATION type/commands on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add #if defined(CONFIG_REPLICATION) in generated code, and adjust the
> code accordingly.
>
> Made conditional:
>
> * xen-set-replication, query-xen-replication-status,
>   xen-colo-do-checkpoint
>
>   Before the patch, we first register the commands unconditionally in
>   generated code (requires a stub), then conditionally unregister in
>   qmp_unregister_commands_hack().
>
>   Afterwards, we register only when CONFIG_REPLICATION.  The command
>   fails exactly the same, with CommandNotFound.
>
>   Improvement, because now query-qmp-schema is accurate, and we're one
>   step closer to killing qmp_unregister_commands_hack().
>
> * enum BlockdevDriver value "replication" in command blockdev-add
>
> * BlockdevOptions variant @replication
>
> and related structures.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json | 13 +++++++++----
>  qapi/migration.json  | 12 ++++++++----
>  migration/colo.c     | 16 ++++------------
>  monitor.c            |  5 -----
>  4 files changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 92e0205d91..762000f31f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2623,7 +2623,9 @@
>              'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
>              'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks=
',
>              'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'q=
cow',
> -            'qcow2', 'qed', 'quorum', 'raw', 'rbd', 'replication', 'shee=
pdog',
> +            'qcow2', 'qed', 'quorum', 'raw', 'rbd',
> +            { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)'=
 },
> +            'sheepdog',
>              'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'v=
xhs' ] }
>=20=20
>  ##
> @@ -3380,7 +3382,8 @@
>  #
>  # Since: 2.9
>  ##
> -{ 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ] }
> +{ 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ],
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @BlockdevOptionsReplication:
> @@ -3398,7 +3401,8 @@
>  { 'struct': 'BlockdevOptionsReplication',
>    'base': 'BlockdevOptionsGenericFormat',
>    'data': { 'mode': 'ReplicationMode',
> -            '*top-id': 'str' } }
> +            '*top-id': 'str' },
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @NFSTransport:
> @@ -3714,7 +3718,8 @@
>        'quorum':     'BlockdevOptionsQuorum',
>        'raw':        'BlockdevOptionsRaw',
>        'rbd':        'BlockdevOptionsRbd',
> -      'replication':'BlockdevOptionsReplication',
> +      'replication': { 'type': 'BlockdevOptionsReplication',
> +                       'if': 'defined(CONFIG_REPLICATION)' },
>        'sheepdog':   'BlockdevOptionsSheepdog',
>        'ssh':        'BlockdevOptionsSsh',
>        'throttle':   'BlockdevOptionsThrottle',
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5fd33316a0..31b589ec26 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1257,7 +1257,8 @@
>  # Since: 2.9
>  ##
>  { 'command': 'xen-set-replication',
> -  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
> +  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' },
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @ReplicationStatus:
> @@ -1272,7 +1273,8 @@
>  # Since: 2.9
>  ##
>  { 'struct': 'ReplicationStatus',
> -  'data': { 'error': 'bool', '*desc': 'str' } }
> +  'data': { 'error': 'bool', '*desc': 'str' },
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @query-xen-replication-status:
> @@ -1289,7 +1291,8 @@
>  # Since: 2.9
>  ##
>  { 'command': 'query-xen-replication-status',
> -  'returns': 'ReplicationStatus' }
> +  'returns': 'ReplicationStatus',
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @xen-colo-do-checkpoint:
> @@ -1305,7 +1308,8 @@
>  #
>  # Since: 2.9
>  ##
> -{ 'command': 'xen-colo-do-checkpoint' }
> +{ 'command': 'xen-colo-do-checkpoint',
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @COLOStatus:
> diff --git a/migration/colo.c b/migration/colo.c
> index fcff04c78c..398b239d1c 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -24,7 +24,9 @@
>  #include "trace.h"
>  #include "qemu/error-report.h"
>  #include "migration/failover.h"
> +#ifdef CONFIG_REPLICATION
>  #include "replication.h"
> +#endif
>  #include "net/colo-compare.h"
>  #include "net/colo.h"
>  #include "block/block.h"
> @@ -201,11 +203,11 @@ void colo_do_failover(MigrationState *s)
>      }
>  }
>=20=20
> +#ifdef CONFIG_REPLICATION
>  void qmp_xen_set_replication(bool enable, bool primary,
>                               bool has_failover, bool failover,
>                               Error **errp)
>  {
> -#ifdef CONFIG_REPLICATION
>      ReplicationMode mode =3D primary ?
>                             REPLICATION_MODE_PRIMARY :
>                             REPLICATION_MODE_SECONDARY;
> @@ -224,14 +226,10 @@ void qmp_xen_set_replication(bool enable, bool prim=
ary,
>          }
>          replication_stop_all(failover, failover ? NULL : errp);
>      }
> -#else
> -    abort();
> -#endif
>  }
>=20=20
>  ReplicationStatus *qmp_query_xen_replication_status(Error **errp)
>  {
> -#ifdef CONFIG_REPLICATION
>      Error *err =3D NULL;
>      ReplicationStatus *s =3D g_new0(ReplicationStatus, 1);
>=20=20
> @@ -246,19 +244,13 @@ ReplicationStatus *qmp_query_xen_replication_status=
(Error **errp)
>=20=20
>      error_free(err);
>      return s;
> -#else
> -    abort();
> -#endif
>  }
>=20=20
>  void qmp_xen_colo_do_checkpoint(Error **errp)
>  {
> -#ifdef CONFIG_REPLICATION
>      replication_do_checkpoint_all(errp);
> -#else
> -    abort();
> -#endif
>  }
> +#endif

/* CONFIG_REPLICATION */ after the endif wouldn't hurt.

>=20=20
>  COLOStatus *qmp_query_colo_status(Error **errp)
>  {
> diff --git a/monitor.c b/monitor.c
> index d39390c2f2..16a180dd50 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1146,11 +1146,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QOb=
ject **ret_data,
>   */
>  static void qmp_unregister_commands_hack(void)
>  {
> -#ifndef CONFIG_REPLICATION
> -    qmp_unregister_command(&qmp_commands, "xen-set-replication");
> -    qmp_unregister_command(&qmp_commands, "query-xen-replication-status"=
);
> -    qmp_unregister_command(&qmp_commands, "xen-colo-do-checkpoint");
> -#endif
>  #ifndef TARGET_I386
>      qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
>      qmp_unregister_command(&qmp_commands, "query-sev");

Only TARGET conditionals left here.  Good.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
