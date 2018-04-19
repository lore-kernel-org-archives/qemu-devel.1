Received: from eggs.gnu.org ([2001:4830:134:3::10]:58746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Bxu-0006am-C3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Bxt-0007uS-EW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:59:18 -0400
References: <20180413143156.11409-1-vsementsov@virtuozzo.com>
	<461d56f3-4381-4cd6-f66d-1dd510c35fa8@redhat.com>
	<7c4c3551-6235-d8a0-db64-83c7952d8284@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0113b912-8e43-4ae3-460d-9433787975fa@redhat.com>
Date: Thu, 19 Apr 2018 10:59:09 -0500
MIME-Version: 1.0
In-Reply-To: <7c4c3551-6235-d8a0-db64-83c7952d8284@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wovlJq2Invg0WBz8mLAdzYtocwvpwaGme"
Subject: Re: [Qemu-devel] [PATCH] nbd/server: introduce NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wovlJq2Invg0WBz8mLAdzYtocwvpwaGme
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com
Message-ID: <0113b912-8e43-4ae3-460d-9433787975fa@redhat.com>
Subject: Re: [PATCH] nbd/server: introduce NBD_CMD_CACHE
References: <20180413143156.11409-1-vsementsov@virtuozzo.com>
 <461d56f3-4381-4cd6-f66d-1dd510c35fa8@redhat.com>
 <7c4c3551-6235-d8a0-db64-83c7952d8284@virtuozzo.com>
In-Reply-To: <7c4c3551-6235-d8a0-db64-83c7952d8284@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 03:36 AM, Vladimir Sementsov-Ogievskiy wrote:
> 18.04.2018 19:37, Eric Blake wrote:
>> On 04/13/2018 09:31 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Handle nbd CACHE command. Just do read, without sending read data bac=
k.
>>> Cache mechanism should be done by exported node driver chain.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 include/block/nbd.h |=C2=A0 3 ++-
>>> =C2=A0 nbd/server.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++=
++++----
>>> =C2=A0 2 files changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>>> index fcdcd54502..b4793d0a29 100644
>>> --- a/include/block/nbd.h
>>> +++ b/include/block/nbd.h
>>> @@ -135,6 +135,7 @@ typedef struct NBDExtent {
>>> =C2=A0 #define NBD_FLAG_SEND_TRIM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (1 << 5) /* Send TRIM (discard) */
>>> =C2=A0 #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZERO=
ES */
>>> =C2=A0 #define NBD_FLAG_SEND_DF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (1 << 7) /* Send DF (Do not
>>> Fragment) */
>>> +#define NBD_FLAG_SEND_CACHE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (1 << 8) /* Send CACHE (prefetch) */
>> Hmm, this flag is not documented in the upstream NBD protocol yet; are=

>> we sure it matches the xNBD implementation?=C2=A0 We'll want at least =
a
>> documentation patch proposed for the NBD list before taking this.
>>
>=20
> The discussion already on list:
> https://lists.debian.org/nbd/2018/03/msg00040.html

Indeed, and that made me realize that we may want to add NBD_CMD_FLAG_*
values corresponding to other useful posix_fadvise() modes before
finalizing the NBD protocol addition of this feature, in which case we'd
want to make sure the qemu implementation is in line with that.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wovlJq2Invg0WBz8mLAdzYtocwvpwaGme
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrYvM0ACgkQp6FrSiUn
Q2o7QAf/UWNAThgWrSfCY3yzchBY71MUQdLpIFHepoCliNjlvH+cN2vMFEgNpHsk
J2Z9sSnjlJw3ZIG81/MFW6iZGLvdHUvKIMRkXSsNEN1Y3e/+vzDbp7IaNH/8yD1k
pPg2ovZ5XPWIuKJ/Su/baolpcHR7eHCFFsQdixpHGcG3o2/DQRd0WDJZJcWSuoGE
KqoEtoH7LVt7+2Cqn7cIdKq2k+Q5JQebaehHDB+dM96MtnSe0mgzCSLFBbwA2+Fz
cOLX4bApE1N/R/98odex4r73nK9r/e2jB60kbQvMHLdzrjv14fUbQ2SoC9AKdnxq
05Z5yHDGzjAYhBvHfT4FedD9b+4htg==
=mWTb
-----END PGP SIGNATURE-----

--wovlJq2Invg0WBz8mLAdzYtocwvpwaGme--
