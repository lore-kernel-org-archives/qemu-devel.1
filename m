Received: from eggs.gnu.org ([2001:4830:134:3::10]:39222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6dwG-0005uS-JT
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6dwD-0007XI-Ed
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:15:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37638 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f6dwD-0007Ww-8P
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:15:01 -0400
References: <20180412101858.21304-1-clg@kaod.org>
	<CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ddb22501-d3d9-22ed-a966-8bb8afabfa17@redhat.com>
Date: Thu, 12 Apr 2018 10:14:49 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ktXbq1yWAlQqM2P6usfj2XqHqL4fX0y97"
Subject: Re: [Qemu-devel] [PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ktXbq1yWAlQqM2P6usfj2XqHqL4fX0y97
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com,
 Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com
Message-ID: <ddb22501-d3d9-22ed-a966-8bb8afabfa17@redhat.com>
Subject: Re: [PATCH] migration: discard RAMBlocks of type ram_device
References: <20180412101858.21304-1-clg@kaod.org>
 <CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
In-Reply-To: <CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2018 06:47 AM, Peter Maydell wrote:

>>  /*
>> + * Identifies RAM blocks which should be discarded from migration. Fo=
r
>> + * the moment, it only applies to blocks backed by a 'ram_device'
>> + * memory region.
>> + */
>> +static inline bool ram_block_is_migratable(RAMBlock *block)
>> +{
>> +    return !memory_region_is_ram_device(block->mr);
>> +}
>> +
>> +/* Should be holding either ram_list.mutex, or the RCU lock. */
>> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
>> +    RAMBLOCK_FOREACH(block)                            \
>> +        if (ram_block_is_migratable(block))
>=20
> This will mishandle some uses, like:
>=20
>     if (foo)
>         RAMBLOCK_FOREACH_MIGRATABLE(block)
>             stuff;
>     else
>         morestuff;
>=20
> as the if() inside the macro will capture the else clause.
> (The lack of braces in the calling code would be against our
> coding style, of course, so not very likely.)

All existing callers of RAMBLOCK_FOREACH() already supply their own {}
around stuff (same is true for QLIST_FOREACH_RCU(), which is what is
being used under the hood).  By the time you correct that to:

if (foo)
    RAMBLOCK_FOREACH_MIGRATABLE(block) {
        stuff;
    }
else
    morestuff;

then even though the outer if violates coding standard, the correct
usage of the macro with {} around stuff won't leak that there is a
trailing if.

But yeah, if you're worrying about code that omitted {}, then dealing
with omitted {} in both places is something to think about.

>=20
> Eric, is there a 'standard' trick for this? I thought of
> maybe
>=20
> #define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
>     RAMBLOCK_FOREACH(block)                            \
>         if (!ram_block_is_migratable(block)) {} else

at which point, yes, this is a little bit safer for taking exactly one
statement without risking that a later bare 'else' could match to the
wrong unbraced 'if'.  I'm not coming up with any better ideas for
(abusing?) the syntax.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ktXbq1yWAlQqM2P6usfj2XqHqL4fX0y97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrPd+kACgkQp6FrSiUn
Q2rqzQf/farJtTH+FkslJSnd+b6MMzJ+sCPV3lXTSXk1WtmA/WEzw+U3/lVEKGug
MDErrwSX4Hnxt8XLkRd3G56DNUyLuPOGYpd47Bmjgit9Pwzc1RAaTYlyw3813yC0
l6zjflX0KGKz3XWtEPJGNPd4GAk7Ll1KTS+Y2PsyenBxwlBK5ae5bUJFw78USWK8
52Tpq4spV1r03DyaBXj0HU3QM74crupl5JDUoOpkEeHnAALOF1wjBH+M3E74RVav
C8zYxtAswtlot/jFanzhfKXGK4M3DFwkZN9KuB/LwvH6QxvbiPmUSfajZmZfpO6M
tkR4kjxdKOQ3t9V0n8mL3Z1EueEBeg==
=u4i5
-----END PGP SIGNATURE-----

--ktXbq1yWAlQqM2P6usfj2XqHqL4fX0y97--
