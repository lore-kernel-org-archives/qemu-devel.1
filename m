Received: from eggs.gnu.org ([2001:4830:134:3::10]:50699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgvN3-0002ty-9m
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgvN0-00037t-6C
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:31:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgvMz-00037e-Th
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:31:50 -0500
References: <1487834070-31374-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487834070-31374-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c07b7cf1-20a1-abc2-a59d-f37d43421769@redhat.com>
Date: Thu, 23 Feb 2017 09:31:46 -0600
MIME-Version: 1.0
In-Reply-To: <1487834070-31374-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2u4MNxLINMi7MUrGPE8Fb9rbEl5xGDHh5"
Subject: Re: [Qemu-devel] [PATCH V8 1/2] Add a new qmp command to start/stop
 replication
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
--2u4MNxLINMi7MUrGPE8Fb9rbEl5xGDHh5
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <c07b7cf1-20a1-abc2-a59d-f37d43421769@redhat.com>
Subject: Re: [PATCH V8 1/2] Add a new qmp command to start/stop replication
References: <1487834070-31374-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1487834070-31374-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1487834070-31374-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 01:14 AM, Zhang Chen wrote:
> We can call this qmp command to start/stop replication outside of qemu.=

> Like Xen colo need this function.
>=20
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>=20
> ---

> @@ -104,6 +106,27 @@ void colo_do_failover(MigrationState *s)
>      }
>  }
> =20
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
> +        return;
> +    }
> +
> +    if (enable) {
> +        replication_start_all(mode, errp);
> +    } else {
> +        replication_stop_all(failover, failover ? NULL : errp);

Technically, this is use of failover without first checking
has_failover; it would be safer if you inserted:

if (!has_failover) {
    failover =3D NULL;
}

earlier in the function to be safe against any callers that don't go
through the QAPI-generated code.  Fortunately, our QAPI generated code
guarantees that failover is NULL when has_failover is false, so my R-b
can stand as-is if there is no other reason for a respin.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2u4MNxLINMi7MUrGPE8Fb9rbEl5xGDHh5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrwBiAAoJEKeha0olJ0NqtbYIAJC1Bs7Dz70nGeVfs7d1KONv
vSkG53M8iSWMbjwg8Xsv1TNmxdMt2F+aBmB3ntX8LhwwtIQzuaW6rIVVY4ri9ZzQ
WjxU8mJGKuIceNe3J0GJ3qB+2rBpXrCPnlcITouyeIKs7ozxRcYEOAQUHeSMIlZV
CjIAZiV8L5drKk1+HDNDP8y7nngbBBS/V9y7LdKh0vVF0vo0ZQFk1AIVcC98Hlda
QV4f1oKsQHsY0rmmE4GoIYprxWvM0G/5w4kJ9d2LWtZExfXF+SwjSGp99yaLl2+o
o6Am15JcrFB8p68Z8W7HPoQDEFXQdBp4+wdu6YDCIlWaAPTRGnDoG378cEdPXbo=
=WIgK
-----END PGP SIGNATURE-----

--2u4MNxLINMi7MUrGPE8Fb9rbEl5xGDHh5--
