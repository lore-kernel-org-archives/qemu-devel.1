Received: from eggs.gnu.org ([2001:4830:134:3::10]:43127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWmI-0007h7-IS
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWmH-0001Ou-Ma
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:37:06 -0400
References: <20170823134242.12080-1-famz@redhat.com>
	<20170823134242.12080-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dcc61514-4535-43bf-2b67-16051ef2b9c6@redhat.com>
Date: Wed, 23 Aug 2017 09:36:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170823134242.12080-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BLFQ4iHwR2AFrjN0V5m0Sn6RfkDPa8LaA"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/4] block-backend: Allow more
 "can inactivate" cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BLFQ4iHwR2AFrjN0V5m0Sn6RfkDPa8LaA
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Message-ID: <dcc61514-4535-43bf-2b67-16051ef2b9c6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/4] block-backend: Allow more "can
 inactivate" cases
References: <20170823134242.12080-1-famz@redhat.com>
 <20170823134242.12080-3-famz@redhat.com>
In-Reply-To: <20170823134242.12080-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 08:42 AM, Fam Zheng wrote:
> These two conditions corresponds to mirror job's source and target,

s/corresponds to/correspond to a/

[can touch up on pull request]

> which need to be allowed as they are part of the non-shared storage
> migration workflow: failing to inactivate either will result in a
> failure during migration completion.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c          | 21 ++++++++++++++++-----
>  include/sysemu/block-backend.h |  1 +
>  2 files changed, 17 insertions(+), 5 deletions(-)
>=20
> =20
> -    return false;
> +    /* Inactivating means no more write to the image can be done, even=
 if it's

s/write/writes/

> +     * guest invisible change. For block job BBs that satisfy this, we=
 can just

reads awkwardly. Maybe 'even if it's changes invisible to the guest'?
But I can leave your wording if I don't get confirmation.

> +     * allow it.  This is the case for mirror job source, which is req=
uired by
> +     * libvirt non-shared block migration. */
> +    if (!(blk->perm & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED))) {
> +        return true;
> +    }
> +
> +    return blk->force_allow_inactivate;
>  }

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BLFQ4iHwR2AFrjN0V5m0Sn6RfkDPa8LaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdkwQACgkQp6FrSiUn
Q2q9mQgAoya5vCNV3/vB2LH9qD3CLeRa1YtbUoAPgNisfPaKnsKZ6BVhR37/YjLc
yEAKPbkwSEUCjYWixs3NHfnAcMdJLmPk8sAwnzaV+WYRjEhfVYrhwUsVCWTjaJDL
4djS7BTYqYkDZ7cdprKxZ00XUmP46Sj6LlTxdFPImXe7r27+U4g4weteYCguqC7C
fTtbh1G7q74VEcPq5z2EtnbbCzcRy6lpNfINdyP3oDlPdianGpxHLoEM+QCWajZd
brgx1LXS3j6ylgkCFM8C2eptylf003PszrQNk4rrpr5cb3ZjGtApsUIEY1KQ6ZVX
+vd7hMWIYs2DAV/mdN+1IKserN/W3A==
=E+Jb
-----END PGP SIGNATURE-----

--BLFQ4iHwR2AFrjN0V5m0Sn6RfkDPa8LaA--
