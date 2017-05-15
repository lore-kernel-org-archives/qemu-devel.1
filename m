Received: from eggs.gnu.org ([2001:4830:134:3::10]:52743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAGdX-0004pr-S9
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAGdW-00035J-LB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAGdW-000354-CQ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:06:10 -0400
References: <20170512233843.27713-1-f4bug@amsat.org>
	<20170512233843.27713-2-f4bug@amsat.org>
	<b5660d99-c854-1930-8806-5989c69f90d1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27c7761e-48c8-9398-ea89-b1fb67602cef@redhat.com>
Date: Mon, 15 May 2017 16:06:04 +0200
MIME-Version: 1.0
In-Reply-To: <b5660d99-c854-1930-8806-5989c69f90d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v4 1/6] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>, Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>



On 15/05/2017 16:04, Eric Blake wrote:
> On 05/12/2017 06:38 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> If you have coccinelle installed you can apply this script using:
>>
>>     $ spatch \
>>         --macro-file scripts/cocci-macro-file.h \
>>         --dir target --in-place
>>
>> You can also use directly Peter Senna Tschudin docker image (easier):
>>
>>     $ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
>>         --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
>>         --macro-file scripts/cocci-macro-file.h \
>>         --dir target --in-place
>>
>> Then verified that no manual touchups are required.
>>
>> The following thread was helpful while writing this script:
>>
>>     https://github.com/coccinelle/coccinelle/issues/86
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  scripts/coccinelle/tcg_gen_extract.cocci | 103 ++++++++++++++++++++++=
+++++++++
>>  1 file changed, 103 insertions(+)
>>  create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci
>=20
> It's still not obvious to me whether we want this script in the tree (a=
s
> something we plan to rerun regularly to check for regressions), or just
> in the commit message (useful for the one-time location of spots to
> optimize, but something we don't anticipate repeating).

I think it's useful.  New backends can have this issue, plus it shows
some advanced Coccinelle techniques.

Paolo

>=20
>=20
>> +@@
>> +import sys
>> +fd =3D sys.stderr
>> +def debug(msg=3D"", trailer=3D"\n"):
>> +    fd.write("[DBG] " + msg + trailer)
>> +def low_bits_count(value):
>> +    bits_count =3D 0
>> +    while (value & (1 << bits_count)):
>> +        bits_count +=3D 1
>=20
> Surely python has a faster method than this (after all, we have ctz and
> friends in C code)?  But my python is limited enough that I don't know
> of one off-hand.
>=20
>> +    return bits_count
>> +def Mn(order): # Mersenne number
>> +    return (1 << order) - 1
>=20
> Correct name...
>=20
>=20
>> +else:
>> +    debug("candidate at %s:%s" % (shr_p[0].file, shr_p[0].line))
>> +    try: # only eval integer, no #define like 'SR_M' (cpp did this, e=
lse some headers are missing).
>> +        msk_v =3D long(msk_s.strip("UL"), 0)
>> +        msk_b =3D low_bits_count(msk_v)
>> +        if msk_b =3D=3D 0:
>> +            debug("  value: 0x%x low_bits: %d" % (msk_v, msk_b))
>> +        else:
>> +            debug("  value: 0x%x low_bits: %d [Mersenne prime: 0x%x]"=
 % (msk_v, msk_b, Mn(msk_b)))
>=20
> ...but this name is still wrong.
>=20
