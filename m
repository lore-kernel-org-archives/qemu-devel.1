Received: from eggs.gnu.org ([2001:4830:134:3::10]:51483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgvQ8-0005KO-MN
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgvQ5-0004Uu-Ik
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:35:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgvQ5-0004UJ-Ax
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:35:01 -0500
References: <1487834070-31374-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487834070-31374-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f7cd737-e851-1e1f-2fe7-0ac969e0f86b@redhat.com>
Date: Thu, 23 Feb 2017 09:34:57 -0600
MIME-Version: 1.0
In-Reply-To: <1487834070-31374-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9pddPWff9bIXuwtUMAGH6SdxGh1NBKWFH"
Subject: Re: [Qemu-devel] [PATCH V8 2/2] Add a new qmp command to do
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
--9pddPWff9bIXuwtUMAGH6SdxGh1NBKWFH
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <0f7cd737-e851-1e1f-2fe7-0ac969e0f86b@redhat.com>
Subject: Re: [PATCH V8 2/2] Add a new qmp command to do checkpoint, query xen
 replication status
References: <1487834070-31374-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1487834070-31374-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1487834070-31374-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 01:14 AM, Zhang Chen wrote:
> We can call this qmp command to do checkpoint outside of qemu.
> Xen colo will need this function.
>=20
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

You made a substantial change to this patch since v7 in response to my
comments; when you do that, it's best to remove the R-b to make sure I
re-review the changes and am still happy with them.

>=20
> ---
>  migration/colo.c | 23 +++++++++++++++++++++++
>  qapi-schema.json | 48 ++++++++++++++++++++++++++++++++++++++++++++++++=

>  2 files changed, 71 insertions(+)
>=20

>  ##
> +# @ReplicationStatus:
> +#
> +# The result format for 'query-xen-replication-status'.
> +#
> +# @status: true to error, false to normal.

This is now a poor name for the parameter.  Please rename it; probably
to @error (if you want to keep true meaning a problem has been
detected), or to @okay (if you want to invert the sense, and @desc is
only present when @okay is false).

> +#
> +# @desc: #optional the human readable error description string, when
> +#        @status is 'true'.
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'ReplicationStatus',
> +  'data': { 'status': 'bool', '*desc': 'str' } }
> +
> +##
> +# @query-xen-replication-status:
> +#
> +# Query replication status while the vm is running.
> +#
> +# Returns: A @ReplicationResult objects showing the status.

s/objects/object/

> +#
> +# Example:
> +#
> +# -> { "execute": "query-xen-replication-status" }
> +# <- { "return": { "status": "normal" } }

This example is now wrong.

You'll need a v9.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9pddPWff9bIXuwtUMAGH6SdxGh1NBKWFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrwEhAAoJEKeha0olJ0Nqpb4H/2SHtsUaJD7wl3pNJ/kaREIc
D0/TMZbUPWlfScQ8JihN0Q54pB/WAr+EhH9b2cl8pmiTVViFznKDzf7syKHu4KfW
NVT9+uBvKQ5NBLprwwa5jRQpj0/KanXY96WTv68nisx1ztX8BQjh/J/bcIe+B2xU
frkvKdDaa2Ch88jj1RCpaEEf9ISKs/XnnhzSt2o9tmYMm0GMgWmpnzNPLPczDBcs
6EqmYl7Fl0EqHyhyVsRmi33DATuxokDpqFTx3FmQAEyYCSwXfWZ4iCpLqUMXQWZk
t9hYEJigpiRbYm6t5ystG/N4W4LuYZQvk51DTWMklEMq+CdZUaUAZnPvBM+ZJxk=
=hc5t
-----END PGP SIGNATURE-----

--9pddPWff9bIXuwtUMAGH6SdxGh1NBKWFH--
