Received: from eggs.gnu.org ([2001:4830:134:3::10]:43263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dekje-000245-TW
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dekjZ-0004N6-Q5
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:18:30 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-7-vsementsov@virtuozzo.com>
	<4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
	<cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
	<b204c5ab-2d4c-315d-7fe7-2111559052a8@redhat.com>
	<ec30e36d-e6b2-78f6-3cf9-eb8ef12a0532@redhat.com>
	<b11f4185-df95-5891-f7d3-43c64d9cb3b5@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be296867-fc8b-26a4-2759-b762910f6685@redhat.com>
Date: Mon, 7 Aug 2017 11:18:11 -0500
MIME-Version: 1.0
In-Reply-To: <b11f4185-df95-5891-f7d3-43c64d9cb3b5@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OWoT2RaEOm8terH3ukkFaBSnLpSdptxGg"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/17] block/nbd-client: fix
 nbd_read_reply_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, P J P <ppandit@redhat.com>, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OWoT2RaEOm8terH3ukkFaBSnLpSdptxGg
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org,
 P J P <ppandit@redhat.com>, mreitz@redhat.com
Message-ID: <be296867-fc8b-26a4-2759-b762910f6685@redhat.com>
Subject: Re: [Qemu-block] [PATCH 06/17] block/nbd-client: fix
 nbd_read_reply_entry
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-7-vsementsov@virtuozzo.com>
 <4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
 <cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
 <b204c5ab-2d4c-315d-7fe7-2111559052a8@redhat.com>
 <ec30e36d-e6b2-78f6-3cf9-eb8ef12a0532@redhat.com>
 <b11f4185-df95-5891-f7d3-43c64d9cb3b5@virtuozzo.com>
In-Reply-To: <b11f4185-df95-5891-f7d3-43c64d9cb3b5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 11:09 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>>> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Set reply.handle to 0 on error path to prevent normal path of
>>>>>> nbd_co_receive_reply.

>>
>> The client still tried to send a flush request to the server, when it
>> should REALLY quit talking to the server at all and just disconnect,
>> because the moment the client recognizes that the server has sent
>> garbage is the moment that the client can no longer assume that the
>> server will react correctly to any further commands.
>>
>> So I don't think your patch is quite correct, even if you have
>> identified a shortfall in our client code.
>>
> Why do you think so? It just does what it states in commit message.

The commit message doesn't state much on the way of WHY.  It it the
subsequent discussion that says that the reason WHY we need to fix
something is to make the client robustly hang up when it encounters a
broken server - but once you couch it in those terms, this patch is NOT
making the client hang up gracefully (it is making the client skip ONE
invalid reply, but then immediately lets the client send another request
and gets stuck waiting for a reply to that second request).  A full fix
for the issue would make sure the client hangs up as soon as it detects
a bogus server.

>=20
> Patch 17 should fix the case (but I doubt that it can be taken separate=
ly).

It's okay if it takes more than one patch to fix an issue, if the
earlier patches document that more work is still needed.  Or maybe we
can squash the best parts of 17 and this one.  I'm still playing with
the best way to minimally address the issue for 2.10.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OWoT2RaEOm8terH3ukkFaBSnLpSdptxGg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIksMACgkQp6FrSiUn
Q2pG6Qf+Onm7dq4N+DwRwDW3FqwZvKvvMOk/uA9houpsFuX2dm3SesEbvROKOSM+
daujcvDFbqUpRj4vCBK4F8Ypu6N1HQlsXUBsldfzwSq8cTuZEs9cG5iuuRJYeIbC
1ub5AQtlY8wY8/fvmgkRLs/O3ZfHFoeKvPKCKa7c2Tq8Q4IbsY5Qkv4goYaxlAa9
QTLsn6AjZ2W8dsM8MY1kELdYKUVWS+TGYwxdrgEgvoGtPf6IXYMxrp3DHc4xjtNX
neRQJ/GmHPrMN7ohK6G+yDUCrzf6yqjFsnCvzk0Zv4kZCDXhUiedEDUWhYnamcEg
dfFca+V+8HdVH+vq3LtyLS2JYbXC+Q==
=S3EU
-----END PGP SIGNATURE-----

--OWoT2RaEOm8terH3ukkFaBSnLpSdptxGg--
