Received: from eggs.gnu.org ([2001:4830:134:3::10]:47051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRQP-00082H-PJ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRQJ-0003sj-Q2
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:33:53 -0500
References: <20171107172638.29942-1-kwolf@redhat.com>
	<9306085c-07c4-b6f7-5222-2b73ee706dac@redhat.com>
	<20171108100417.GA30890@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89958329-a6ac-9f65-f5a0-11bbea967174@redhat.com>
Date: Wed, 8 Nov 2017 08:33:33 -0600
MIME-Version: 1.0
In-Reply-To: <20171108100417.GA30890@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qEibSpF78fbHB3WAuu684HHRmFUTRCCHA"
Subject: Re: [Qemu-devel] [PATCH] block: Deprecate bdrv_set_read_only() and
 users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qEibSpF78fbHB3WAuu684HHRmFUTRCCHA
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <89958329-a6ac-9f65-f5a0-11bbea967174@redhat.com>
Subject: Re: [PATCH] block: Deprecate bdrv_set_read_only() and users
References: <20171107172638.29942-1-kwolf@redhat.com>
 <9306085c-07c4-b6f7-5222-2b73ee706dac@redhat.com>
 <20171108100417.GA30890@localhost.localdomain>
In-Reply-To: <20171108100417.GA30890@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 04:04 AM, Kevin Wolf wrote:

>=20
> Well, they don't only need an explicitly set option, but the important
> point is that they don't work with the default value. But I can add
> something to this effect.
>=20
>>> +++ b/block/vvfat.c
>>> @@ -1259,7 +1259,11 @@ static int vvfat_open(BlockDriverState *bs, QD=
ict *options, int flags,
>>>                         "Unable to set VVFAT to 'rw' when drive is re=
ad-only");
>>>              goto fail;
>>>          }
>>> -    } else  {
>>> +    } else  if (!bdrv_is_read_only(bs)) {
>>> +        error_report("Opening non-rw vvfat images without an explici=
t "
>>> +                     "read-only=3Don option is deprecated. Future ve=
rsions "
>>> +                     "will refuse to open the image instead of "
>>> +                     "automatically marking the image read-only.");
>>>          /* read only is the default for safety */
>>>          ret =3D bdrv_set_read_only(bs, true, &local_err);
>>
>> Is this also a good time to deprecate vvfat's duplication of rw vs.
>> read-only, and consolidate that into a single option?  No other device=

>> defaults to read-only, so the deprecation period is a good point to wa=
rn
>> that a future version may default to read-write without an explicit
>> read-only.  I guess vvfat is the only driver with a device-specific QA=
PI
>> change (for 'rw') that might be impacted if you make that additional c=
hange.
>=20
> I would love to get rid of the duplication, but there's a reason why
> vvfat defaults to read-only. I think we're relatively confident that a
> read-only vvfat can be safely implemented (and hopefully is), but write=

> support is really a clever hack that may or may not work reliably
> depending on how crazy the guest OS goes.
>=20
> So if we removed the 'rw' option, would we want 'read-only' to default
> to true for vvfat? I'm not sure if we want to go there, it would mean
> making the default value of some base BlockdevOptions depend on the
> driver.
>=20
> On the other hand, I'm not sure how useful 'read-only' even is apart
> from the protocol layer... Should it have been driver-specific? But it'=
s
> too late for that anyway.

Having a driver-specific default for read-only MIGHT make sense, as a
plan for something down the road (it matches current behavior, after
all, in that some drivers force read-only as their default).  I guess
now is the time to decide WHAT we want to do after the deprecation
period ends, so that we're only making an incompatible change once, and
tweak the deprecation (and resulting warning messages in the meantime)
to fit in with that plan.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qEibSpF78fbHB3WAuu684HHRmFUTRCCHA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDFb0ACgkQp6FrSiUn
Q2oEtgf+JmdawFc0F98uRfMwqdCoOuVGLGajRdEMFno4N/ImLYHPPNvzXhBlnP+Z
GO4LJpM9t8bM1bygGsxkny6oGdkbBOS5Dt0hb+9ms7tUvI9WBjYkFhi4MUPbrRrr
lR9mJiQsaE2HUJ8UlYA4hQxBLYq621lizZgDFIbtFvjxARwp1dF/10vlzmhUNPYP
s71xs4q1bMHcxnz4nbbVAfGWlGedwAZv7UT+zSwqz3iKBgN3zcJDBASsPop+ItTw
y0bovBHqcmnBkOp2F3e7/MeQBYLBD8ZxQU2f9MmxcBsUrO1O5wfDvHpA+KqI3niQ
im6eCdKPD0xWL9Iipe/JUTAaBzfXGw==
=Ij94
-----END PGP SIGNATURE-----

--qEibSpF78fbHB3WAuu684HHRmFUTRCCHA--
