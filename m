Received: from eggs.gnu.org ([2001:4830:134:3::10]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8nso-0001dt-At
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8nsn-000589-9q
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:16:26 -0400
References: <20180405170619.20480-1-kwolf@redhat.com>
	<99b844f2-7784-225a-37c4-77dad444fbd6@redhat.com>
	<20180418135009.GF4971@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2769edf8-0bf6-5163-d86d-f721c1af86bd@redhat.com>
Date: Wed, 18 Apr 2018 09:16:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180418135009.GF4971@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OKQIo9UisLAYXlRqebczzRNGAmPRE7tNR"
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OKQIo9UisLAYXlRqebczzRNGAmPRE7tNR
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jdurgin@redhat.com,
 jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <2769edf8-0bf6-5163-d86d-f721c1af86bd@redhat.com>
Subject: Re: [RFC][BROKEN] rbd: Allow configuration of authentication scheme
References: <20180405170619.20480-1-kwolf@redhat.com>
 <99b844f2-7784-225a-37c4-77dad444fbd6@redhat.com>
 <20180418135009.GF4971@localhost.localdomain>
In-Reply-To: <20180418135009.GF4971@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2018 08:50 AM, Kevin Wolf wrote:

>>> @@ -3195,6 +3215,8 @@
>>>              '*conf': 'str',
>>>              '*snapshot': 'str',
>>>              '*user': 'str',
>>> +            '*auth-none': 'bool',
>>> +            '*auth-cephx': 'RbdAuthCephx',
>>>              '*server': ['InetSocketAddressBase'] } }
>>
>> Would it be better to have this be a flat union with 'auth' with enum
>> values 'none', 'cephx', 'both' as a discriminator that determines whic=
h
>> additional fields can be present?  Or does that require that we first
>> fix the QAPI generator to allow nesting a flat union within another fl=
at
>> union (probably doable, just no one has needed it before now)?  Is it
>> also time to improve the QAPI generator to allow a default value to th=
e
>> discriminator field, rather than requiring the field to be present?
>=20
> Both options can be enabled at the same time, so that the client
> connects to a server no matter whether it does 'cephx' authentication o=
r
> only 'none. This is even the default for rbd driver (in the existing
> command line interface, but I think we need to stay compatible with it)=
=2E
> With a union you would have to explicitly choose one or the other, but
> could never accept both.
>=20
> The other option we were considering was a list of authentication
> options, which would be easier to implement, but isn't really an
> accurate representation of what we really accept. There is no way we
> could meaningfully implement something like this:
>=20
>     'auth': [ { 'type': 'cephx', 'key-secret': 'foo' },
>               { 'type': 'cephx', 'key-secret': 'bar' } ]
>=20
> Because Ceph only allows us to enable the 'cephx' authentication method=

> and to set a single key for it.

How does it look as a choice between:

{'enum':'CephxAuth', 'data': ['none', 'cephx', 'both' ]}

where both 'cephx' and 'both' support the optional 'key-secret'
parameter, but 'none' does not?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OKQIo9UisLAYXlRqebczzRNGAmPRE7tNR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXUygACgkQp6FrSiUn
Q2rbVgf/ayKYsnlvXtSnV0lFEtrIxqUFULS7jTVMAIjQnuQZA/SI1R/GERBHnPlL
3LQvhbxqK/pm/V7Zvj5aAj6QL98SASoRzk/X9N9alICdMFBBFa9yDdKCwQ4S0WWm
o0kg3xmSR/fs09lOtmojz1koDw8fk1bRotRX/dDxj6Re4s3+OBi83YLyF0tcosL7
l/JuR/C7601KuwZTD9VsvDWB5jxv1csifS+rzZEo86CqkyBK6ogRqptHWgPoi8ur
le/Zfa0DNv13d8JDgKknQeHb8Y36mjAi7JsXEczwLZme48pQkSrzFCnPVne+wnsu
Q1Lw9GbPw2TDWqlCSRrJUCqFNufddA==
=4p3c
-----END PGP SIGNATURE-----

--OKQIo9UisLAYXlRqebczzRNGAmPRE7tNR--
