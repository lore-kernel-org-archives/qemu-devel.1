Received: from eggs.gnu.org ([2001:4830:134:3::10]:46190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dMa-0006V9-EU
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dMW-00088P-Dd
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:17:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e2dMW-00087b-3H
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0671768BE
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 13:17:19 +0000 (UTC)
References: <20171012142153.125b5bd8@nial.brq.redhat.com>
	<20171012122826.GK16125@redhat.com>
	<20171012143815.746b0d14@nial.brq.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78ea3fd4-56e6-2b03-5a65-0fb9026ffdb7@redhat.com>
Date: Thu, 12 Oct 2017 08:17:16 -0500
MIME-Version: 1.0
In-Reply-To: <20171012143815.746b0d14@nial.brq.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A430kflN78dr2jlrsb2gNv8uvPv6H2Jh0"
Subject: Re: [Qemu-devel] QAPI magician wanted ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A430kflN78dr2jlrsb2gNv8uvPv6H2Jh0
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <78ea3fd4-56e6-2b03-5a65-0fb9026ffdb7@redhat.com>
Subject: Re: [Qemu-devel] QAPI magician wanted ...
References: <20171012142153.125b5bd8@nial.brq.redhat.com>
 <20171012122826.GK16125@redhat.com>
 <20171012143815.746b0d14@nial.brq.redhat.com>
In-Reply-To: <20171012143815.746b0d14@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 07:38 AM, Igor Mammedov wrote:
> On Thu, 12 Oct 2017 13:28:26 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>=20
>> On Thu, Oct 12, 2017 at 02:21:53PM +0200, Igor Mammedov wrote:
>>>
>>> I'm working on introducing QMP command to set numa mappings
>>> via QMP interface at runtime instead of CLI.
>>>
>>> I'd prefer to reuse NumaOptions for parsing input,
>>> but I can't wrap my head around QAPI magic.
>>>
>>> So far I've added new command in qapi-schema.json:
>>>
>>>   {
>>>     'command': 'set-numa-node',                                      =
             =20
>>>     'data': {'cmd': 'NumaOptions'}                                   =
             =20
>>>   } =20
>>
>> I don't see any point in the extra level of nesting you have here, vs
>> using NumaOptions as the data directly eg
>>
>>    {
>>      'command': 'set-numa-node',
>>      'data': 'NumaOptions'             =20
>>    }
> I've tried that, it doesn't compile
>    'data' for command 'set-numa-node' cannot use union type 'NumaOption=
s'

{ 'command': 'set-numa-node', 'boxed': true,
  'data': 'NumaOptions' }

To use a union directly as the command (which is a GOOD idea), you have
to tell the generator to pass it as a boxed item to the
qmp_set_numa_node function, rather than as exploded parameters, since
the generator can't explode parameters from a union..

>> I think the union gets flattenned - ie you probably want
>>
>>    { "execute": "set-numa-node", "arguments": { "cmd": { "type": "node=
", "nodeid": 1 } } }
> thanks, that works for me=20
>=20
>>
>> Though with my suggestion above you could get it to just
>>
>>    { "execute": "set-numa-node", "arguments": { "type": "node", "nodei=
d": 1 } }

Yes, I'd prefer this form without the extra nesting.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--A430kflN78dr2jlrsb2gNv8uvPv6H2Jh0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnfa1wACgkQp6FrSiUn
Q2poNggAkS2B9manzrspLGjLoA5tF/qNpQVnEUl7QdThIDuO5zBxM9njkPcp7AfT
Y+6CsD9BiwGkA62HtAht3RrKZEk2x6XEaojjjbnTT3JhzEyN1fnF+IejHvTOAFl1
Sziqn7BUB07mugGMR7E/c0Hx+fTV69mPde0iuZEwuAglGWYLxF/6xjYjLdDx3/jU
WVMYDX3gwNkcJVAF81nkzg6+mLQJyk1N0xHKlvfWynzReGhwN+fxTipceMgH5QB/
Pp30CZ00OUk12X/8yq2X7Dcz8mftsJtufai8mpmo3ff4A49ZEb4yFS7+mAx0OMuO
wjNFGWyvMsnfW8cGO3KUQvAU/kkxdg==
=aQuL
-----END PGP SIGNATURE-----

--A430kflN78dr2jlrsb2gNv8uvPv6H2Jh0--
