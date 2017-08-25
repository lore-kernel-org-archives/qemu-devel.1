Received: from eggs.gnu.org ([2001:4830:134:3::10]:49619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlJxm-000790-Qo
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 15:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlJxl-0003Xo-S4
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 15:08:14 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-8-vsementsov@virtuozzo.com>
	<04916320-d8a4-80e2-d6b7-0fcd7b4a9cfa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77c8ea93-c65a-7d6d-18d0-7679fed0cb01@redhat.com>
Date: Fri, 25 Aug 2017 14:08:05 -0500
MIME-Version: 1.0
In-Reply-To: <04916320-d8a4-80e2-d6b7-0fcd7b4a9cfa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ulii33OLHEiCwAX0feWgkCAhXxBDaO83h"
Subject: Re: [Qemu-devel] [PATCH 07/17] block/nbd-client: refactor request
 send/receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ulii33OLHEiCwAX0feWgkCAhXxBDaO83h
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <77c8ea93-c65a-7d6d-18d0-7679fed0cb01@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/17] block/nbd-client: refactor request
 send/receive
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-8-vsementsov@virtuozzo.com>
 <04916320-d8a4-80e2-d6b7-0fcd7b4a9cfa@redhat.com>
In-Reply-To: <04916320-d8a4-80e2-d6b7-0fcd7b4a9cfa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/25/2017 01:49 PM, Eric Blake wrote:
> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Move nbd_co_receive_reply and nbd_coroutine_end calls into
>> nbd_co_send_request and rename the latter to just nbd_co_request.
>>
>> This removes code duplications in nbd_client_co_{pwrite,pread,...}
>> functions. Also this is needed for further refactoring.
>>

>> -static int nbd_co_send_request(BlockDriverState *bs,
>> -                               NBDRequest *request,
>> -                               QEMUIOVector *qiov)
>> +static void nbd_co_receive_reply(NBDClientSession *s,
>> +                                 NBDRequest *request,
>> +                                 NBDReply *reply,
>> +                                 QEMUIOVector *qiov);
>> +static void nbd_coroutine_end(BlockDriverState *bs,
>> +                              NBDRequest *request);
>=20
> Is it possible to organize the functions in topological order so that w=
e
> don't need forward declarations of static functions?  (If there is
> mutual recursion, you need the forward declaration; but other than that=
,
> I like reading the building blocks first rather than skipping around)

Answering myself: patch 9 inlines nbd_co_receive_reply into its lone
caller, eliminating the need for a forward reference, and it is less
code churn to have a temporary forward declaration than it is to move
the function body up and then back down.  (Maybe the commit message
could hint that nbd_co_receive_reply will later be inlined)

>=20
> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ulii33OLHEiCwAX0feWgkCAhXxBDaO83h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgdZUACgkQp6FrSiUn
Q2ooMwf7Bh/Pf1D5IeMp5Zd0Itfspp4AKxautML9a4oZOAFTsAkWsw1+zgVesghc
5RWNLaOjRPHrQFVs6k1EqFGCGB7PFJRtaIdBmZWv/ied/+Y3vYVe6mJbYx6RBlKO
/sRg/01Ilbdk5YvbTbrD8BCw7vV1TvvCBwhRPapNBlS+ji916SfdgJJ0wqUGfr7d
E3M4/0D87YLHBe2+bBzIFHFvJAAGvY45AIHm3+3bDPFTL/4U81Diti/Lx0U0d2/r
+ugchflgK8/EIoP2YogBhUrvEc/MDfcEcaxu591vnPROzMVECl5aILTnCuUvNAw1
82WtFUONjLevh1axJAepqIHHwEMryg==
=1oV/
-----END PGP SIGNATURE-----

--Ulii33OLHEiCwAX0feWgkCAhXxBDaO83h--
