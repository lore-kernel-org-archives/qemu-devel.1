Received: from eggs.gnu.org ([2001:4830:134:3::10]:57684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOsMr-0003k6-BT
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOsMo-0002rD-7p
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:41:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOsMn-0002qy-VH
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:41:02 -0500
References: <1482831516-21862-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1482831516-21862-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e642e588-b874-f7ca-ded6-a5bcaa9dab48@redhat.com>
Date: Wed, 4 Jan 2017 14:40:58 -0600
MIME-Version: 1.0
In-Reply-To: <1482831516-21862-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ikPpU8DeV4rbO7os3C809SWvM8u3kiWGo"
Subject: Re: [Qemu-devel] [PATCH V5 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ikPpU8DeV4rbO7os3C809SWvM8u3kiWGo
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <e642e588-b874-f7ca-ded6-a5bcaa9dab48@redhat.com>
Subject: Re: [PATCH V5 2/2] Add a new qmp command to do checkpoint, query xen
 replication status
References: <1482831516-21862-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1482831516-21862-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1482831516-21862-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/27/2016 03:38 AM, Zhang Chen wrote:
> We can call this qmp command to do checkpoint outside of qemu.
> Like Xen colo need this function.

That sentence is awkward; maybe:

Xen colo will need this function.

>=20
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> ---
>  docs/qmp-commands.txt | 24 ++++++++++++++++++++++++
>  migration/colo.c      | 17 +++++++++++++++++
>  qapi-schema.json      | 50 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  3 files changed, 91 insertions(+)
>=20
> diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
> index d182147..a146745 100644
> --- a/docs/qmp-commands.txt
> +++ b/docs/qmp-commands.txt
> @@ -450,6 +450,30 @@ Example:
>       "arguments": {"enable": true, "primary": false} }
>  <- { "return": {} }
> =20
> +query-xen-replication-status
> +----------------------------
> +
> +Query replication status when vm is running.
> +
> +Arguments: None.
> +
> +Example:
> +
> +-> { "execute": "query-xen-replication-status" }
> +<- { "return": { "status": "normal" } }
> +
> +xen-do-checkpoint
> +-----------------
> +
> +Xen use this command to notify replication to do checkpoint.

s/use/uses/
s/do/trigger a/

> +
> +Arguments: None.
> +
> +Example:
> +
> +-> { "execute": "xen-do-checkpoint" }
> +<- { "return": {} }
> +
>  migrate
>  -------
> =20
> diff --git a/migration/colo.c b/migration/colo.c
> index 6fc2ade..7fc9f8a 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -127,6 +127,23 @@ void qmp_xen_set_replication(bool enable, bool pri=
mary,
>      }
>  }
> =20
> +ReplicationErrorResult *qmp_query_xen_replication_status(Error **errp)=

> +{
> +    Error *err =3D NULL;
> +    ReplicationErrorResult *result =3D g_new0(ReplicationErrorResult, =
1);
> +    replication_get_error_all(&err);
> +    result->status =3D err ?
> +                     REPLICATION_ERROR_STATUS_ERROR :
> +                     REPLICATION_ERROR_STATUS_NORMAL;
> +    error_free(err);
> +    return result;
> +}
> +
> +void qmp_xen_do_checkpoint(Error **errp)
> +{
> +    replication_do_checkpoint_all(errp);
> +}
> +
>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                Error **errp)
>  {
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 78802f4..6c162a5 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4695,6 +4695,56 @@
>    'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' =
} }
> =20
>  ##
> +# @ReplicationErrorStatus
> +#
> +# Describe the status of replication error.
> +#
> +# @error: Replication have a error.

s/have a/has an/

> +#
> +# @normal:  Replication running normal.

s/running normal/is running normally/

> +#
> +# Since 2.9
> +##
> +{ 'enum': 'ReplicationErrorStatus',
> +  'data': [ 'error', 'normal' ] }
> +
> +##
> +# @ReplicationErrorResult

The name of this struct is misleading (but harmless, since struct names
are not part of the API).  Better might be: ReplicationStatus

> +#
> +# The result format for 'xen-get-replication-error'.

Wrong name; you renamed the command 'query-xen-replication-status'.

> +#
> +# @status: enum of @ReplicationErrorStatus, which shows current
> +#          replication error status
> +#
> +# Since 2.9
> +##
> +{ 'struct': 'ReplicationErrorResult',
> +  'data': { 'status': 'ReplicationErrorStatus'} }
> +
> +##
> +# @query-xen-replication-status
> +#
> +# Query replication error that occurs when the vm is running.

Since you might extend this in the future, I'd just leave it at:

Query replication status while the vm is running.

> +#
> +# Returns: A @ReplicationErrorResult objects showing the status.
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'query-xen-replication-status',
> +  'returns': 'ReplicationErrorResult' }

Again, the struct name is misleading.

> +
> +##
> +# @xen-do-checkpoint
> +#
> +# Xen use this command to notify replication to do checkpoint.

s/use/uses/

> +#
> +# Returns: nothing.
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'xen-do-checkpoint' }
> +
> +##
>  # @GICCapability:
>  #
>  # The struct describes capability for a specific GIC (Generic
>=20

Getting closer!

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ikPpU8DeV4rbO7os3C809SWvM8u3kiWGo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbV3aAAoJEKeha0olJ0NqylIH/A1dHQhosw77J244ZJDiYTMh
jqLXgxzQEWRTQJSP7UVoHxWGLwTfU+j1Gf4/YXs3qZqmBoltB/oJPyxPRdmobsRa
iYQB8sebcuEddPVGVoNIsR23J7Ictk47m+nyHMToLH1wDGOoJjw5mm6tH/hwGT2K
Zh58kJhI6ljiDC440xpugC7nYYpAEGgo7MU/dnu/QiBwaQkfvD5FthIADJE7c/N1
sLf8rf4kSA8E2hXrESqxLrJ3oYAXI7gUC3q/qwlJOCdTSjISQevkM353Kj8H7UUz
F6sjkDHZF9NwGR+VDX61o+0VRz/WDPetXLR6HZGdyw1p46gPPdGWthZ14qnhX/E=
=HUM9
-----END PGP SIGNATURE-----

--ikPpU8DeV4rbO7os3C809SWvM8u3kiWGo--
