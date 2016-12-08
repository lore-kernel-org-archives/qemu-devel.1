Received: from eggs.gnu.org ([2001:4830:134:3::10]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF0m9-0002bx-L8
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF0m6-0002mS-Hi
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:38:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cF0m6-0002m4-9V
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:38:22 -0500
References: <1481183716-7342-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481183716-7342-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8be72d20-30c4-82f1-ba6c-300176f3f94d@redhat.com>
Date: Thu, 8 Dec 2016 09:38:14 -0600
MIME-Version: 1.0
In-Reply-To: <1481183716-7342-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8goX1j6FWxAI01SlWMPkUtPwVGDtT4IEj"
Subject: Re: [Qemu-devel] [PATCH for-2.9 V2 2/3] Add a new qmp command to
 start/stop replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8goX1j6FWxAI01SlWMPkUtPwVGDtT4IEj
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>,
 Changlong Xie <xiecl.fnst@cn.fujitsu.com>
Message-ID: <8be72d20-30c4-82f1-ba6c-300176f3f94d@redhat.com>
Subject: Re: [PATCH for-2.9 V2 2/3] Add a new qmp command to start/stop
 replication
References: <1481183716-7342-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1481183716-7342-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1481183716-7342-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2016 01:55 AM, Zhang Chen wrote:
> We can call this qmp command to start/stop replication outside of qemu.=

> Like Xen colo need this function.
>=20
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>  docs/qmp-commands.txt | 17 +++++++++++++++++
>  migration/colo.c      | 22 ++++++++++++++++++++++
>  qapi-schema.json      | 19 +++++++++++++++++++
>  3 files changed, 58 insertions(+)
>=20
> diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
> index abf210a..f7bae0d 100644
> --- a/docs/qmp-commands.txt
> +++ b/docs/qmp-commands.txt
> @@ -432,6 +432,23 @@ Example:
>       "arguments": { "enable": true } }
>  <- { "return": {} }
> =20
> +xen-set-replication
> +-------

Much of this file tries to match the ----- divider lines to the length
of the line above it (you're short by the length of '-replication')

> +
> +Enable or disable replication.
> +
> +Arguments:
> +
> +- "enable": Enable it or disable it.
> +- "primary": True for primary or false for secondary

We aren't very consistent on whether to end in '.'

> +- "failover": Enable to do failover when stoping replcation

"failover": Enable failover when stopping replication (optional, default
false)


> +void qmp_xen_set_replication(bool enable, bool primary,
> +                             bool has_failover, bool failover,
> +                             Error **errp)
> +{
> +    ReplicationMode mode =3D primary ?
> +                           REPLICATION_MODE_PRIMARY :
> +                           REPLICATION_MODE_SECONDARY;
> +
> +    if (has_failover && enable) {
> +        error_setg(errp, "Parameter 'failover' is only for"
> +                   " stopping replication");

At this point, errp is set, but you fall through...

> +    }
> +
> +    if (enable) {
> +        replication_start_all(mode, errp);

and could abort if something else also tries to set errp.  Simplest is
to add a return; statement after error_setg().

> +    } else {
> +        replication_stop_all(failover, failover ? NULL : errp);
> +    }
> +}
> +
>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                Error **errp)
>  {
> diff --git a/qapi-schema.json b/qapi-schema.json
> index f3e9bfc..f67b0a3 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4676,6 +4676,25 @@
>  { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
> =20
>  ##
> +# @xen-set-replication
> +#
> +# Enable or disable replication
> +#
> +# @enable: true to enable, false to disable.
> +#
> +# @primary: true for primary or false for secondary
> +#
> +# @failover: #optional true to do failover, false to stop.
> +#            default value is false.

May want to additionally document that 'failover' cannot be specified if
'enable' is true.

> +#
> +# Returns: nothing
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'xen-set-replication',
> +  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' =
} }
> +
> +##
>  # @GICCapability:
>  #
>  # The struct describes capability for a specific GIC (Generic
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8goX1j6FWxAI01SlWMPkUtPwVGDtT4IEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSX5mAAoJEKeha0olJ0Nq7RoH/1I6+PzEIePKYzfwnfgNY2uY
1o4GeFzRwvN6yN3/7+9V2Gh3DjpI+eAXtBpdSE6QFFc8pcZ3SI3rHRSmmtFgXBEZ
S/akmz1RxpUOLBKqjya4YPtCANoPkgSunmdDHm4fRU8q8ikRqNl0kkVtOzN9Uapt
IGfllSzfHkje5DA/mxAKp6Anv/xedfAZincsNfOSz8WlDKLPErdcU+NZss3QhOGA
DRAwyTlTlkYAWPjpnHOyAC9ZRL0LEBGjj0mUuAtciqrDX1UQ5cDueCXobfbnh3SO
cXHU8CWRfJpsDYwyLMTmB9+4NKgRQY0QQ5YasfqtxqiVILusVyXSwiA9nn4Yo+k=
=1G2M
-----END PGP SIGNATURE-----

--8goX1j6FWxAI01SlWMPkUtPwVGDtT4IEj--
