Received: from eggs.gnu.org ([209.51.188.92]:52982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1w1n-0006YJ-5a
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1w1m-0004Sr-8v
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:37:51 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-8-jsnow@redhat.com>
	<1055b446-a34d-2413-3e0c-85b433ae15b7@virtuozzo.com>
	<5c1f1971-5050-9678-f7f4-d8d4c4b53709@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba994232-719e-1d6c-c502-23e0ad1532e5@redhat.com>
Date: Thu, 7 Mar 2019 10:37:35 -0600
MIME-Version: 1.0
In-Reply-To: <5c1f1971-5050-9678-f7f4-d8d4c4b53709@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nr1MLiOfMGfovbLJzus8FFm72I8JhorzT"
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block/dirty-bitmaps: implement
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nr1MLiOfMGfovbLJzus8FFm72I8JhorzT
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>
Message-ID: <ba994232-719e-1d6c-c502-23e0ad1532e5@redhat.com>
Subject: Re: [PATCH v3 7/7] block/dirty-bitmaps: implement inconsistent bit
References: <20190301191545.8728-1-jsnow@redhat.com>
 <20190301191545.8728-8-jsnow@redhat.com>
 <1055b446-a34d-2413-3e0c-85b433ae15b7@virtuozzo.com>
 <5c1f1971-5050-9678-f7f4-d8d4c4b53709@redhat.com>
In-Reply-To: <5c1f1971-5050-9678-f7f4-d8d4c4b53709@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/6/19 3:46 PM, John Snow wrote:

>> I think, inconsistent bitmaps should have readonly flag always set or =
always unset, independently on can_write,
>> as we are not going to write something related to inconsistent bitmaps=
=2E
>>
>=20
> We'll never change metadata for inconsistent bitmaps, no. We might
> delete them which causes a metadata change, though -- and right now the=

> readonly check stops that in blockdev.c before we attempt (and fail) th=
e
> operation. It does have at least a light usage.
>=20
> It's not a crucial feature, but I think the error message is nicer.
>=20
>> And I think, better is always unset, to have inconsistent bitmaps as s=
omething unrelated to readonly.
>>
>=20
> The way I think of it is as unrelated, which is why I set readonly and
> inconsistent orthogonally.
>=20
>> Readonly are bitmaps, which are not marked IN_USE on open for some rea=
son..
>>
>=20
> I tend to think of readonly bitmaps as persistent bitmaps attached to
> storage we are unable to write back to, so we must prevent their
> modification.

I like that wording (keeping read-only and inconsistent orthogonal),

>=20
> I suppose the IN_USE viewpoint works too; "This is a bitmap that we hav=
e
> not marked as IN_USE so it must not be used."
>=20

Yes, it does work, but it is a bit more of a stretch, so I'm not quite
as sure about using it.

>> I understand, that inconsistent bitmaps are some kind of readonly too,=
 as we can't write to them..
>> But we can't read too anyway, and we don't interfere with reopen logic=
 at all. So again, better is
>> don't mark inconsistent bitmaps as readonly.
>>
>=20
> Hm, so in your model; we just NEVER set readonly for persistent bitmaps=
,
> which incurs some changes at load time, but allows the reload_rw
> function to go completely unmodified.
>=20
> That's not unreasonable in terms of SLOC, but semantically I am not sur=
e
> which approach is better. I'm leaning towards keeping this as written
> for now, but... well. Any thoughts, Eric? Would you like to flip a coin=
?

No strong preferences, other than let's get it in before soft freeze, to
make sure we don't miss out on it entirely due to waiting for the coin
flip :)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nr1MLiOfMGfovbLJzus8FFm72I8JhorzT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBSM8ACgkQp6FrSiUn
Q2rQmAf8C9NL4fv5TSgtYhgXlrevaKabLBosAO05AE/CNh/G9afsIOhc1w4Ofefp
afhMDncxDH8qVuxRtfc3IVyCEigjVBTd7gtuxapRSEtftmJYzqcMZbR6B+qdJCm4
zrSYVzByHgpWf/++oN3VhryNNz1FYHBCcWB49Xydw4P+bGk5YtnLfnkN6X5P3vcW
HBCZF17785q+w5OIszb4OXhaQ6but5Ez9vyUJrq9XLg6TwA4r8U8nrwEYyzagT1+
ahu1ZZEIbFjxsNsfZdz0aLmrXQJ4kZPwamGzLGNGVYmRgID3VkiWeAQtQClgkPDq
kNM8O+o22uDRvs4lIp3lIacg/M6HSA==
=c5MD
-----END PGP SIGNATURE-----

--nr1MLiOfMGfovbLJzus8FFm72I8JhorzT--
