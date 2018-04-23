Received: from eggs.gnu.org ([2001:4830:134:3::10]:35710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAhQX-0001Lt-Ld
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAhQT-0008AP-0q
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:47:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fAhQS-00089P-QH
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 15:47:00 -0400
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
	<6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
	<954f83a5-675c-c4ff-6c89-6f8eb820a806@redhat.com>
	<20180422094728.GB29670@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68d7375c-ef2d-19ee-5bcd-cda8573c8492@redhat.com>
Date: Mon, 23 Apr 2018 14:46:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180422094728.GB29670@ruderich.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LI54ADOp51kHxDdijdDNY72irdvFXphLJ"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LI54ADOp51kHxDdijdDNY72irdvFXphLJ
From: Eric Blake <eblake@redhat.com>
To: Simon Ruderich <simon@ruderich.org>
Cc: qemu-devel@nongnu.org
Message-ID: <68d7375c-ef2d-19ee-5bcd-cda8573c8492@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] qmp: add pmemload command
References: <20180412124834.GA2025@ruderich.org>
 <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
 <6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
 <954f83a5-675c-c4ff-6c89-6f8eb820a806@redhat.com>
 <20180422094728.GB29670@ruderich.org>
In-Reply-To: <20180422094728.GB29670@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/22/2018 04:47 AM, Simon Ruderich wrote:
> On Tue, Apr 17, 2018 at 04:18:43PM -0500, Eric Blake wrote:
>> Focusing on just the interface:
>>
>>> +++ b/qapi/misc.json
>>> @@ -1185,6 +1185,26 @@
>>>  { 'command': 'pmemsave',
>>>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
>>>
>>> +##
>>> +# @pmemload:
>>> +#
>>> +# Load a portion of guest physical memory from a file.
>>> +#
>>> +# @val: the physical address of the guest to start from
>>> +#
>>> +# @size: the size of memory region to load
>>
>> Should size be an optional parameter (default read to the end of the f=
ile)?
>>
>>> +#
>>> +# @offset: the offset in the file to start from
>>
>> Should offset be an optional parameter (default start reading from
>> offset 0 of the file)?
>=20
>>From the QAPI point-of-view making both optional seems like a
> good idea, however then pmemsave should also mark its "size"
> parameter optional for consistency (this is backwards compatible
> as existing callers are not affected).

Correct.

>=20
> On the monitor API side this is more problematic as the order of
> the pmemsave/pmemload parameters make optional parameters
> impossible.

Back-compat in the QMP interface matters.  The HMP interface, however,
exists to serve humans not machines, and we can break it at will to
something that makes more sense to humans.  So don't let HMP concerns
hold you back from a sane interface.

>=20
> Personally I'd keep it as is because it's simple and consistent
> with the existing interface (and can be changed in the future
> without breaking compatibility).
>=20
> In case you prefer those parameters to be optional I'll require
> some help to implement that: I don't understand how
> qapi-schema.json, hmp-commands.hx and hmp.h interact (I've to
> admit I just copied that from the original patch and didn't give
> it much thought as it worked fine) and would require some
> pointers on how to implement optional arguments for
> qapi-schema.json.

Optional parameters are listed as '*name':'type' in the .json file,
which tells the generator to create a 'has_name' bool parameter
alongside the 'name' parameter in the C code for the QMP interface.  The
HMP interface should then call into the QMP interface.

Recent HMP patches that I've authored may offer some inspiration: commit
08fb10a added a new command, and commit dba4932 added an optional
parameter to an existing command.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LI54ADOp51kHxDdijdDNY72irdvFXphLJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlreODEACgkQp6FrSiUn
Q2p3Ywf+KjmygRbHDQ2c+cwxYjDaqSb+lifCJHHGHih1udAYx4WiJn2oqMBa1T0u
WB+2Bo48jqiQn/C2IMxXWptl8ERfkVNGwyOJ8sFTLrXYML2ggkaxt2XpMapaj/LH
RgJttuXQSCxtZrG5I0N7VOlGVk+VpMFHguJNQp8Ao+hEFjNTFRozul2tjkShb/pX
JxwEpcjM6EgNnrD1+Q08l7VSXzmvokAZeSUG5aqRyVQ2/D2WypdsoGEFtQppe/DM
G795abdcyNy0WC6W2p31hRQmkIxg/Ay/kRSMj8/5D/98RSd7fkkrFmh/VZYsmOp9
yK/qLMwOWsDiAboTEGybdd10nA7LXw==
=GAHx
-----END PGP SIGNATURE-----

--LI54ADOp51kHxDdijdDNY72irdvFXphLJ--
