Received: from eggs.gnu.org ([2001:4830:134:3::10]:36361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUynT-00026V-Sv
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUynS-0000YM-7i
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:54:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUynR-0000Y7-UV
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:54:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51E74A405D
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 18:54:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-27-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 19:54:34 +0100
In-Reply-To: <20180706105753.26700-27-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:52 +0200")
Message-ID: <87woom5vv9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 26/27] qapi: add more conditions to SPICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Now that member can be made conditional, let's make SPICE chardev
> conditional:
>
> * spiceport, spicevmc
>
>   Before and after the patch for !CONFIG_SPICE, the error is the
>   same ('spiceport' is not a valid char driver name).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/char.json | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index b7b2a05766..54e3b970f6 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -319,8 +319,8 @@
>  # Since: 1.5
>  ##
>  { 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
> -  'base': 'ChardevCommon' }
> -# TODO: 'if': 'defined(CONFIG_SPICE)'
> +  'base': 'ChardevCommon',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @ChardevSpicePort:
> @@ -332,8 +332,8 @@
>  # Since: 1.5
>  ##
>  { 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
> -  'base': 'ChardevCommon' }
> -# TODO: 'if': 'defined(CONFIG_SPICE)'
> +  'base': 'ChardevCommon',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @ChardevVC:
> @@ -387,10 +387,10 @@
>                                         'testdev': 'ChardevCommon',
>                                         'stdio'  : 'ChardevStdio',
>                                         'console': 'ChardevCommon',
> -                                       'spicevmc': 'ChardevSpiceChannel',
> -# TODO: { 'type': 'ChardevSpiceChannel', 'if': 'defined(CONFIG_SPICE)' },
> -                                       'spiceport': 'ChardevSpicePort',
> -# TODO: { 'type': 'ChardevSpicePort', 'if': 'defined(CONFIG_SPICE)' },
> +                                       'spicevmc': { 'type': 'ChardevSpi=
ceChannel',
> +                                                     'if': 'defined(CONF=
IG_SPICE)' },
> +                                       'spiceport': { 'type': 'ChardevSp=
icePort',
> +                                                      'if': 'defined(CON=
FIG_SPICE)' },
>                                         'vc'     : 'ChardevVC',
>                                         'ringbuf': 'ChardevRingbuf',
>                                         # next one is just for compatibil=
ity

Long lines due to foolish indentation.

Let me grep for the pattern:

    $ grep ", 'data.*,$" qapi/*json
    qapi/block-core.json:  'data': {'start': 'int', 'length': 'int', 'data'=
: 'bool',
    qapi/block-core.json:{ 'command': 'block_passwd', 'data': {'*device': '=
str',
    qapi/block-core.json:{ 'command': 'block_resize', 'data': { '*device': =
'str',
    qapi/block-core.json:{ 'enum' : 'ReplicationMode', 'data' : [ 'primary'=
, 'secondary' ],
    qapi/char.json:{ 'struct': 'ChardevInfo', 'data': {'label': 'str',
    qapi/char.json:  'data': {'device': 'str', 'data': 'str',
    qapi/char.json:{ 'struct': 'ChardevCommon', 'data': { '*logfile': 'str',
    qapi/char.json:{ 'struct': 'ChardevFile', 'data': { '*in' : 'str',
    qapi/char.json:{ 'struct': 'ChardevHostdev', 'data': { 'device' : 'str'=
 },
    qapi/char.json:{ 'struct': 'ChardevSocket', 'data': { 'addr'       : 'S=
ocketAddressLegacy',
    qapi/char.json:{ 'struct': 'ChardevUdp', 'data': { 'remote' : 'SocketAd=
dressLegacy',
    qapi/char.json:{ 'struct': 'ChardevMux', 'data': { 'chardev' : 'str' },
    qapi/char.json:{ 'struct': 'ChardevStdio', 'data': { '*signal' : 'bool'=
 },
    qapi/char.json:{ 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : '=
str' },
    qapi/char.json:{ 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str=
' },
    qapi/char.json:{ 'struct': 'ChardevVC', 'data': { '*width'  : 'int',
    qapi/char.json:{ 'struct': 'ChardevRingbuf', 'data': { '*size'  : 'int'=
 },
    qapi/char.json:{ 'union': 'ChardevBackend', 'data': { 'file'   : 'Chard=
evFile',
    qapi/char.json:{ 'command': 'chardev-add', 'data': {'id'      : 'str',
    qapi/char.json:{ 'command': 'chardev-change', 'data': {'id'      : 'str=
',
    qapi/migration.json:{ 'command': 'migrate-recover', 'data': { 'uri': 's=
tr' },
    qapi/misc.json:{ 'command': 'add-fd', 'data': {'*fdset-id': 'int', '*op=
aque': 'str'},
    qapi/misc.json:{'command': 'query-command-line-options', 'data': { '*op=
tion': 'str' },
    qapi/net.json:{ 'command': 'query-rx-filter', 'data': { '*name': 'str' =
},
    qapi/tpm.json:{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : =
'str',
    qapi/ui.json:{ 'command': 'change-vnc-password', 'data': {'password': '=
str'},
The first hit is a false positive.  For the rest, let's break the line
before 'data'.
