Received: from eggs.gnu.org ([2001:4830:134:3::10]:52732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eP7qz-0001hE-9Q
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 09:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eP7qw-0003zf-2m
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 09:17:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eP7qv-0003z6-Qq
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 09:17:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 180FB356F7
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 14:17:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-38-marcandre.lureau@redhat.com>
Date: Wed, 13 Dec 2017 15:17:32 +0100
In-Reply-To: <20170911110623.24981-38-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:06:10 +0200")
Message-ID: <87indaaf0j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 37/50] qapi: add conditions to SPICE
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add #if defined(CONFIG_SPICE) in generated code, and adjust the
> qmp/hmp code accordingly.

I'd like to see a description of how this affects QMP and HMP, like the
one in the previous patch.

Are there any occurrences of SPICE in the schema that aren't made
conditional by this patch?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/char.json | 10 ++++++----
>  qapi/ui.json   | 30 ++++++++++++++++++++----------
>  monitor.c      |  3 ---
>  qmp.c          | 16 ----------------
>  4 files changed, 26 insertions(+), 33 deletions(-)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index ae19dcd1ed..7fa1762ae5 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -318,7 +318,8 @@
>  # Since: 1.5
>  ##
>  { 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
> -  'base': 'ChardevCommon' }
> +  'base': 'ChardevCommon',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @ChardevSpicePort:
> @@ -330,7 +331,8 @@
>  # Since: 1.5
>  ##
>  { 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
> -  'base': 'ChardevCommon' }
> +  'base': 'ChardevCommon',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @ChardevVC:
> @@ -384,8 +386,8 @@
>                                         'testdev': 'ChardevCommon',
>                                         'stdio'  : 'ChardevStdio',
>                                         'console': 'ChardevCommon',
> -                                       'spicevmc' : 'ChardevSpiceChannel=
',
> -                                       'spiceport' : 'ChardevSpicePort',
> +                                       'spicevmc' : { 'type': 'ChardevSp=
iceChannel', 'if': 'defined(CONFIG_SPICE)' },
> +                                       'spiceport' : { 'type': 'ChardevS=
picePort', 'if': 'defined(CONFIG_SPICE)' },
>                                         'vc'     : 'ChardevVC',
>                                         'ringbuf': 'ChardevRingbuf',
>                                         # next one is just for compatibil=
ity
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 4b573d214b..daa4168c14 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -110,7 +110,8 @@
>  { 'struct': 'SpiceBasicInfo',
>    'data': { 'host': 'str',
>              'port': 'str',
> -            'family': 'NetworkAddressFamily' } }
> +            'family': 'NetworkAddressFamily' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SpiceServerInfo:
> @@ -123,7 +124,8 @@
>  ##
>  { 'struct': 'SpiceServerInfo',
>    'base': 'SpiceBasicInfo',
> -  'data': { '*auth': 'str' } }
> +  'data': { '*auth': 'str' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SpiceChannel:
> @@ -148,7 +150,8 @@
>  { 'struct': 'SpiceChannel',
>    'base': 'SpiceBasicInfo',
>    'data': {'connection-id': 'int', 'channel-type': 'int', 'channel-id': =
'int',
> -           'tls': 'bool'} }
> +           'tls': 'bool'},
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SpiceQueryMouseMode:
> @@ -167,7 +170,8 @@
>  # Since: 1.1
>  ##
>  { 'enum': 'SpiceQueryMouseMode',
> -  'data': [ 'client', 'server', 'unknown' ] }
> +  'data': [ 'client', 'server', 'unknown' ],
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SpiceInfo:
> @@ -204,7 +208,8 @@
>  { 'struct': 'SpiceInfo',
>    'data': {'enabled': 'bool', 'migrated': 'bool', '*host': 'str', '*port=
': 'int',
>             '*tls-port': 'int', '*auth': 'str', '*compiled-version': 'str=
',
> -           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChan=
nel']} }
> +           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChan=
nel']},
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @query-spice:
> @@ -249,7 +254,8 @@
>  #    }
>  #
>  ##
> -{ 'command': 'query-spice', 'returns': 'SpiceInfo' }
> +{ 'command': 'query-spice', 'returns': 'SpiceInfo',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SPICE_CONNECTED:
> @@ -274,7 +280,8 @@
>  ##
>  { 'event': 'SPICE_CONNECTED',
>    'data': { 'server': 'SpiceBasicInfo',
> -            'client': 'SpiceBasicInfo' } }
> +            'client': 'SpiceBasicInfo' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SPICE_INITIALIZED:
> @@ -302,7 +309,8 @@
>  ##
>  { 'event': 'SPICE_INITIALIZED',
>    'data': { 'server': 'SpiceServerInfo',
> -            'client': 'SpiceChannel' } }
> +            'client': 'SpiceChannel' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SPICE_DISCONNECTED:
> @@ -327,7 +335,8 @@
>  ##
>  { 'event': 'SPICE_DISCONNECTED',
>    'data': { 'server': 'SpiceBasicInfo',
> -            'client': 'SpiceBasicInfo' } }
> +            'client': 'SpiceBasicInfo' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SPICE_MIGRATE_COMPLETED:
> @@ -342,7 +351,8 @@
>  #      "event": "SPICE_MIGRATE_COMPLETED" }
>  #
>  ##
> -{ 'event': 'SPICE_MIGRATE_COMPLETED' }
> +{ 'event': 'SPICE_MIGRATE_COMPLETED',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # =3D=3D VNC
> diff --git a/monitor.c b/monitor.c
> index 5685697f59..135a1e0821 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -970,9 +970,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
t **ret_data,
>   */
>  static void qmp_unregister_commands_hack(void)
>  {
> -#ifndef CONFIG_SPICE
> -    qmp_unregister_command(&qmp_commands, "query-spice");
> -#endif
>  #ifndef CONFIG_REPLICATION
>      qmp_unregister_command(&qmp_commands, "xen-set-replication");
>      qmp_unregister_command(&qmp_commands, "query-xen-replication-status"=
);
> diff --git a/qmp.c b/qmp.c
> index 2c90dacb56..90816ba283 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -130,22 +130,6 @@ void qmp_cpu_add(int64_t id, Error **errp)
>      }
>  }
>=20=20
> -#ifndef CONFIG_SPICE
> -/*
> - * qmp-commands.hx ensures that QMP command query-spice exists only
> - * #ifdef CONFIG_SPICE.  Necessary for an accurate query-commands
> - * result.  However, the QAPI schema is blissfully unaware of that,
> - * and the QAPI code generator happily generates a dead
> - * qmp_marshal_query_spice() that calls qmp_query_spice().  Provide it
> - * one, or else linking fails.  FIXME Educate the QAPI schema on
> - * CONFIG_SPICE.
> - */
> -SpiceInfo *qmp_query_spice(Error **errp)
> -{
> -    abort();
> -};
> -#endif
> -
>  void qmp_cont(Error **errp)
>  {
>      BlockBackend *blk;

Hmm, shouldn't you compile out "info spice", like you did for "info vnc"
in the previous patch?
