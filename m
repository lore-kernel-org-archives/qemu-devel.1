Received: from eggs.gnu.org ([2001:4830:134:3::10]:60553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX923-0003n2-Op
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX91z-00019z-PT
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:10:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eX91z-00018N-Fx
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:10:15 -0500
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
	<1515045675-6993-11-git-send-email-zhangckid@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <225d94e2-feb5-6081-faa9-4d0a028e0dfc@redhat.com>
Date: Thu, 4 Jan 2018 11:10:12 -0600
MIME-Version: 1.0
In-Reply-To: <1515045675-6993-11-git-send-email-zhangckid@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3nUOqsTIR7pZD03tmCJWIFPAXyq9sQmj8"
Subject: Re: [Qemu-devel] [PATCH RESEND V3 10/16] qmp event: Add COLO_EXIT
 event to notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3nUOqsTIR7pZD03tmCJWIFPAXyq9sQmj8
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <225d94e2-feb5-6081-faa9-4d0a028e0dfc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 10/16] qmp event: Add COLO_EXIT
 event to notify users while exited COLO
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
 <1515045675-6993-11-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-11-git-send-email-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/2018 12:01 AM, Zhang Chen wrote:
> From: zhanghailiang <zhang.zhanghailiang@huawei.com>
>=20
> If some errors happen during VM's COLO FT stage, it's important to
> notify the users of this event. Together with 'x_colo_lost_heartbeat',

Isn't that spelled x-colo-lost-heartbeat in QMP?

> Users can intervene in COLO's failover work immediately.
> If users don't want to get involved in COLO's failover verdict,
> it is still necessary to notify users that we exited COLO mode.
>=20
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

Focusing on just the UI:


> +++ b/qapi-schema.json
> @@ -2921,6 +2921,27 @@
>  { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
> =20
>  ##
> +# @COLO_EXIT:
> +#
> +# Emitted when VM finishes COLO mode due to some errors happening or
> +# at the request of users.
> +#
> +# @mode: which COLO mode the VM was in when it exited.
> +#
> +# @reason: describes the reason for the COLO exit.
> +#
> +# Since: 2.11

You've missed 2.11; this should be 2.12.

> +#
> +# Example:
> +#
> +# <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
> +#      "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "re=
quest" } }
> +#
> +##
> +{ 'event': 'COLO_EXIT',
> +  'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }

Since COLOMode is in migration.json, shouldn't this 'event' declaration
live there as well?

> +
> +##
>  # @ACPI_DEVICE_OST:
>  #
>  # Emitted when guest executes ACPI _OST method.
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 03f57c9..f7b2cc6 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -854,6 +854,19 @@
>  ##
>  { 'enum': 'FailoverStatus',
>    'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
> +##
> +# @COLOExitReason:
> +#
> +# The reason for a COLO exit
> +#
> +# @request: COLO exit is due to an external request
> +#
> +# @error: COLO exit is due to an internal error
> +#
> +# Since: 2.11

2.12

> +##
> +{ 'enum': 'COLOExitReason',
> +  'data': [ 'request', 'error' ] }
> =20
>  ##
>  # @x-colo-lost-heartbeat:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3nUOqsTIR7pZD03tmCJWIFPAXyq9sQmj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpOX/QACgkQp6FrSiUn
Q2pTLwgAoT0KUDq5BoMAqGkPOYVxRTwCfqUwSY/sD0mHpx6KjhOsQThjHZYPq2ZW
FVmjuVxV7VRAnf9uZ2PsV+0aJuwEYDBA2lpA2wB8uGC+zPrA6sW4TwRnYNEVDxGj
ycop0FuZ/J3LRo2TzeiW0fPDypFWDCZpSDUcbqetz6pMB0HrdXEVGT5RCX0dtTqC
ae5GkidnvtQiIelpc4Z8qSA+Pu9O0cwn0pxN9igGBHNfE9E00if2IaCritoP2KMV
be40juhkP3c6Avp3rbUPh5FEyeYYRXJ7cfcjPH3hj3kOsdTjSM5/wP9pXKWYFtfG
uf9Zp7N9GQHDMqs9mKD9PdyuR8kCtA==
=ETgm
-----END PGP SIGNATURE-----

--3nUOqsTIR7pZD03tmCJWIFPAXyq9sQmj8--
