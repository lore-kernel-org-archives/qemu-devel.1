Received: from eggs.gnu.org ([2001:4830:134:3::10]:55443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPmqC-0003GW-Pl
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPmq7-0002xt-Py
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:35:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1fPmq7-0002xV-J6
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:35:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C479BD9E
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 10:35:51 +0000 (UTC)
References: <20180604102752.32260-1-berrange@redhat.com>
	<8297e5b4-dca4-f080-fb87-4cf29a2bb857@redhat.com>
	<20180604103515.GE19749@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e6bfce7d-75e5-bdb9-bc01-03ed8f1c540c@redhat.com>
Date: Mon, 4 Jun 2018 12:35:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180604103515.GE19749@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Nmpj6nRBBeuC5pkrRtWcVrnhWvbNwREMg"
Subject: Re: [Qemu-devel] [PATCH] vl: don't use RUN_STATE_PRECONFIG unless
 --preconfig is given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik <mprivozn@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nmpj6nRBBeuC5pkrRtWcVrnhWvbNwREMg
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik <mprivozn@redhat.com>
Message-ID: <e6bfce7d-75e5-bdb9-bc01-03ed8f1c540c@redhat.com>
Subject: Re: [PATCH] vl: don't use RUN_STATE_PRECONFIG unless --preconfig is
 given
References: <20180604102752.32260-1-berrange@redhat.com>
 <8297e5b4-dca4-f080-fb87-4cf29a2bb857@redhat.com>
 <20180604103515.GE19749@redhat.com>
In-Reply-To: <20180604103515.GE19749@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-04 12:35, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Jun 04, 2018 at 12:33:04PM +0200, Max Reitz wrote:
>> On 2018-06-04 12:27, Daniel P. Berrang=C3=A9 wrote:
>>> The RUN_STATE_PRECONFIG state is not supposed to be reachable unless =
the
>>> --preconfig argument is given to QEMU, but when it was introduced in:=

>>>
>>>   commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac
>>>   Author: Igor Mammedov <imammedo@redhat.com>
>>>   Date:   Fri May 11 19:24:43 2018 +0200
>>>
>>>     cli: add --preconfig option
>>>
>>> The global 'current_run_state' variable was changed to have an initia=
l
>>> value of RUN_STATE_PRECONFIG regardless of whether --preconfig is giv=
en.
>>>
>>> It then relies on the main loop to toggle it back to RUN_STATE_PRELAU=
NCH
>>> when --preconfig is not given. This is racy because it means that the=
re
>>> is a window where QEMU is in RUN_STATE_PRECONFIG despite --preconfig =
not
>>> being given. This can be seen with the failure:
>>>
>>>   $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
>>>   QEMU 2.12.50 monitor - type 'help' for more information
>>>   (qemu)
>>>   HMP not available in preconfig state, use QMP instead
>>>
>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> ---
>>>  vl.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> This indeed fixes the issue that the preconfig state is reachable
>> without --preconfig, but it still keeps the main loop being invoked
>> twice (which means that e.g. HMP will process a single character befor=
e
>> the main loop is actually really invoked:
>>
>> $ echo quit | x86_64-softmmu/qemu-system-x86_64 \
>>     -drive file=3D/dev/null,if=3Dide,readonly=3Don -monitor stdio
>> QEMU 2.12.50 monitor - type 'help' for more information
>> (qemu) qqemu-system-x86_64: Initialization of device ide-hd failed:
>> Block node is read-only
>>
>> (Note the "q" before "qemu-system-x86_64"))
>>
>> (Naively,) I agree with Michal that the main loop should only be invok=
ed
>> twice if --preconfig has been given, which is implemented by his patch=
:
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00367.html
>=20
> I think we probably need a combination of both patches for maximum safe=
ty.

Sounds good to me.

Max


--Nmpj6nRBBeuC5pkrRtWcVrnhWvbNwREMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsVFgMACgkQ9AfbAGHV
z0A+WggAusXD7HXcPOOPh3775SZx+8RAfegTvQKowc+pW9OJgI+wnt74tDpndtAA
rVlHWlcbiQsD9W1EokehKAAPhCok5NXcyqjAX2ETzzypa+q64BDjknLzg6ekh+qE
aRHTMxe1G8UX1bnATkR3JA5nZrEgbyleyhAK+e+8RFfIt/oR/7JIJr64HdhiyxsA
qchAD8ecJA/T5lFdFrWZfZ0yEov9aXGwC6dBrjBiFp23f4kctIB7LdsfZjqtr5ei
u8Mow9pHIjGHGNqYEo5qSHwV79ce5vc0Yk82p0wErP4ibnFCJXOKdS8HTEEwayPn
ClWuNt2gtwhcThDKQz+cL/LmzD4C0w==
=DJkB
-----END PGP SIGNATURE-----

--Nmpj6nRBBeuC5pkrRtWcVrnhWvbNwREMg--
