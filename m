Received: from eggs.gnu.org ([2001:4830:134:3::10]:42793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJLcG-0003A9-Lr
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 09:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJLcC-0008VA-H5
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 09:42:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cJLcC-0008US-8E
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 09:42:04 -0500
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
Date: Tue, 20 Dec 2016 08:42:01 -0600
MIME-Version: 1.0
In-Reply-To: <1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SbA7i5NDl0oGAXknjFfJJR1fCBSGcQshS"
Subject: Re: [Qemu-devel] [PATCH for-2.9 V4 2/2] Add a new qmp command to do
 checkpoint, get replication error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SbA7i5NDl0oGAXknjFfJJR1fCBSGcQshS
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>,
 Changlong Xie <xiecl.fnst@cn.fujitsu.com>,
 Wen Congyang <wencongyang@gmail.com>
Message-ID: <7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
Subject: Re: [PATCH for-2.9 V4 2/2] Add a new qmp command to do checkpoint,
 get replication error
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2016 08:46 PM, Zhang Chen wrote:
> We can call this qmp command to do checkpoint outside of qemu.
> Like Xen colo need this function.
>=20
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> ---
>  docs/qmp-commands.txt | 24 ++++++++++++++++++++++++
>  migration/colo.c      | 10 ++++++++++
>  qapi-schema.json      | 22 ++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>=20

> =20
> +void qmp_xen_get_replication_error(Error **errp)
> +    {
> +        replication_get_error_all(errp);
> +    }

Is this trying to cause a replication error, or is it trying to collect
status on whether an error has occurred? The name 'get' usually implies
a query that does not change state, but a query usually needs some way
to return what was queried back to the user, so a void function with no
parameters other than error is odd (either the command succeeds because
there was no error, or the command fails with an error message because
the query had something to get?).


> +++ b/qapi-schema.json
> @@ -4695,6 +4695,28 @@
>    'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' =
} }
> =20
>  ##
> +# @xen-get-replication-error
> +#
> +# Get replication error that occurs when the vm is running.
> +#
> +# Returns: nothing.
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'xen-get-replication-error' }

So I don't think this is the right name for its signature, but I don't
know what you are trying to accomplish with this command to suggest the
right name.

> +
> +##
> +# @xen-do-checkpoint
> +#
> +# Do checkpoint.
> +#
> +# Returns: nothing.
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'xen-do-checkpoint' }

This one is probably okay.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SbA7i5NDl0oGAXknjFfJJR1fCBSGcQshS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYWUM5AAoJEKeha0olJ0Nqpx0H/1CFRqJXKvdQBHpBV7DcwjjR
LT2Topm7ESaZtx/OlGWT9HvYuW2uK1mEp11A55ElQDcbPCzqytujNJUoVyymSj9A
7QEX4lp5tCoUk0ie02B6/utbfnLi14DMk9aMRVXAHTDfu6r2ZgLe5asSawua9l6J
7lkTWZDgMWklDpTTF0dgP9rrgxTBZLfjMVFllKLy3nYbCl9RKo+uC2M97OjJIDoW
8uRlAYQjjNdZXK+mj3hxRoSoukUxWkcnj6xy3bqkeqhyjiH/MwEdsA/dtKyMGIWq
+XyALkg5ogmLsQVt4ALQwtLGkaEUojyyYpBmVsPGQpRS91d/s3r90EuljEThO2A=
=iqNc
-----END PGP SIGNATURE-----

--SbA7i5NDl0oGAXknjFfJJR1fCBSGcQshS--
