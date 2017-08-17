Received: from eggs.gnu.org ([2001:4830:134:3::10]:48627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diH4A-0002rZ-CA
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diH49-0003Lt-7m
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:26:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diH48-0003Ju-V0
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:26:13 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-19-marcandre.lureau@redhat.com>
Date: Thu, 17 Aug 2017 11:16:27 +0200
In-Reply-To: <20170727154126.11339-19-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 27 Jul 2017
	17:41:18 +0200")
Message-ID: <87h8x6k104.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/26] qapi: add conditions to REPLICATION
 type/commands on the schema
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
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi-schema.json | 12 ++++++++----
>  migration/colo.c | 14 ++------------
>  monitor.c        |  5 -----
>  3 files changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index bcee3157b0..2f4528c769 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -6337,7 +6337,8 @@
>  # Since: 2.9
>  ##
>  { 'command': 'xen-set-replication',
> -  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
> +  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' },
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @ReplicationStatus:
> @@ -6352,7 +6353,8 @@
>  # Since: 2.9
>  ##
>  { 'struct': 'ReplicationStatus',
> -  'data': { 'error': 'bool', '*desc': 'str' } }
> +  'data': { 'error': 'bool', '*desc': 'str' },
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @query-xen-replication-status:
> @@ -6369,7 +6371,8 @@
>  # Since: 2.9
>  ##
>  { 'command': 'query-xen-replication-status',
> -  'returns': 'ReplicationStatus' }
> +  'returns': 'ReplicationStatus',
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @xen-colo-do-checkpoint:
> @@ -6385,7 +6388,8 @@
>  #
>  # Since: 2.9
>  ##
> -{ 'command': 'xen-colo-do-checkpoint' }
> +{ 'command': 'xen-colo-do-checkpoint',
> +  'if': 'defined(CONFIG_REPLICATION)' }
>=20=20
>  ##
>  # @GICCapability:
> diff --git a/migration/colo.c b/migration/colo.c
> index a4255432ac..3bff9fc9a4 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -147,11 +147,11 @@ void colo_do_failover(MigrationState *s)
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
> @@ -170,14 +170,10 @@ void qmp_xen_set_replication(bool enable, bool prim=
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
> @@ -192,19 +188,13 @@ ReplicationStatus *qmp_query_xen_replication_status=
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
>=20=20
>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                Error **errp)
> diff --git a/monitor.c b/monitor.c
> index 4bf6a3ea2e..383c84d162 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -970,11 +970,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObje=
ct **ret_data,
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
>  #endif

Same drill as for PATCH 16.

Commands you make conditional:

* xen-set-replication, query-xen-replication-status,
  xen-colo-do-checkpoint

  Before the patch, we first register the commands unconditionally in
  generated code (requires a stub), then conditionally unregister in
  qmp_unregister_commands_hack().

  Afterwards, we register only when CONFIG_REPLICATION.  The command
  fails exactly the same, with CommandNotFound.

  Improvement, because now query-qmp-schema is accurate, and we're one
  step close to killing qmp_unregister_commands_hack().

Check for completeness by reviewing the case insensitive occurrences of
replication in the schema not covered by your patch, and review uses of
CONFIG_REPLICATION for possible schema connections (I did that for
CONFIG_VNC [PATCH 16] and CONFIG_SPICE [PATCH 17], too):

* enum BlockdevDriver value "replication" in command blockdev-add

* Makefile.objs:block-obj-$(CONFIG_REPLICATION) +=3D replication.o
  block/Makefile.objs:block-obj-$(CONFIG_REPLICATION) +=3D replication.o

I think the following should be ifdef CONFIG_REPLICATION: enum
BlockdevDriver value @replication BlockdevOptions variant @replication,
BlockdevOptionsReplication, BlockdevOptionsReplicationMode.

Some of this analysis should perhaps be worked into the commit message.
