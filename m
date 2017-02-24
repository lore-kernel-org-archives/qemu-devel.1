Received: from eggs.gnu.org ([2001:4830:134:3::10]:33081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chJef-0003Sb-VT
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chJed-0005Ki-7p
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:27:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chJec-0005Kb-Ux
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:27:39 -0500
References: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487920971-16519-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d6cbd92-1699-3d11-7a24-63e888bb0e29@redhat.com>
Date: Fri, 24 Feb 2017 11:27:35 -0600
MIME-Version: 1.0
In-Reply-To: <1487920971-16519-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="huAKnxHfQF0bCmX9m9BS4ahtboQgOT2U9"
Subject: Re: [Qemu-devel] [PATCH V9 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--huAKnxHfQF0bCmX9m9BS4ahtboQgOT2U9
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <1d6cbd92-1699-3d11-7a24-63e888bb0e29@redhat.com>
Subject: Re: [PATCH V9 2/2] Add a new qmp command to do checkpoint, query xen
 replication status
References: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1487920971-16519-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1487920971-16519-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 01:22 AM, Zhang Chen wrote:
> We can call this qmp command to do checkpoint outside of qemu.
> Xen colo will need this function.
>=20
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> ---
>  migration/colo.c | 23 +++++++++++++++++++++++
>  qapi-schema.json | 49 ++++++++++++++++++++++++++++++++++++++++++++++++=
+
>  2 files changed, 72 insertions(+)
>=20

> +++ b/qapi-schema.json
> @@ -5931,6 +5931,55 @@
>    'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' =
} }
> =20
>  ##
> +# @ReplicationStatus:
> +#
> +# The result format for 'query-xen-replication-status'.
> +#
> +# @error: true to error, false to normal.

Maybe:

true if an error happened, false if replication is normal

Maintainer could touch that up during application, so it doesn't
necessarily require a v10.

> +##
> +# @query-xen-replication-status:
> +#
> +# Query replication status while the vm is running.
> +#
> +# Returns: A @ReplicationResult object showing the status.
> +#
> +# Example:
> +#
> +# -> { "execute": "query-xen-replication-status" }
> +# <- { "return": [ { "error": false },
> +#                  { "error": true } ] }

This example is bogus.  The command does NOT return an array.  It is
sufficient to use:

{ "return": { "error": false } }

but if you want, you could instead do:

{ "return": { "error": true, "desc": "..." } }

but if you do that, please be sure that desc matches an actual error
code that could occur, and not something made up.

If all you do is fix the example with the simpler "error":false (and
maybe the maintainer is okay doing that), then you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--huAKnxHfQF0bCmX9m9BS4ahtboQgOT2U9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsG0HAAoJEKeha0olJ0Nq1XcH/0mofPgFW7lZLvCstP09C7Yn
na4jtVDMiaE2IabMNzdc0NDFsnGVIYJINljcqPwYyhiXx2MKAkjwFlWoFSKwsIeN
b1zToh67ZGABls5UBqVkeQytJIsyr/WesBp5ldHsoSpNCqIkf4E029ynLbq1Sibl
pdky281Jfs2TcOklxoWrbfnOB+z5P38uRERvz8ngNvsiy/jvdAmb6qtlTPmIh8qS
g4/byk4BLP2frrrvCE/X0d2lesbZVjSGOqbZz6AKNICWFFdMW7+3n2079rY+6AVE
1HeJXbNOmTTN51QukYJhIGfZMR8LnrKNzp/57UMBPFyENSyQH+WJS0YMqZ5TjLc=
=xXA0
-----END PGP SIGNATURE-----

--huAKnxHfQF0bCmX9m9BS4ahtboQgOT2U9--
