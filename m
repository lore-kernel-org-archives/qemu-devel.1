Received: from eggs.gnu.org ([2001:4830:134:3::10]:51428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr8FQ-00055y-35
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr8FM-0004oQ-W5
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr8FM-0004o7-NY
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:18:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46E564E4C8
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 19:18:08 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-4-git-send-email-armbru@redhat.com>
	<011d21ee-aa96-2541-2e54-16c423f07cce@redhat.com>
	<878tnv6e6q.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <385d2fa4-a7ec-e22c-e89d-5387cccc2ca4@redhat.com>
Date: Thu, 23 Mar 2017 14:18:03 -0500
MIME-Version: 1.0
In-Reply-To: <878tnv6e6q.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iriViH7g0isjjmiELnKIhcsWUdHOUrl07"
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to
 extract list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iriViH7g0isjjmiELnKIhcsWUdHOUrl07
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com,
 jcody@redhat.com, mreitz@redhat.com
Message-ID: <385d2fa4-a7ec-e22c-e89d-5387cccc2ca4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to extract
 list-valued options
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-4-git-send-email-armbru@redhat.com>
 <011d21ee-aa96-2541-2e54-16c423f07cce@redhat.com>
 <878tnv6e6q.fsf@dusky.pond.sub.org>
In-Reply-To: <878tnv6e6q.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 01:27 PM, Markus Armbruster wrote:

>>> -
>>> -    num_entries =3D qdict_array_entries(options, prefix);
>>> +    for (i =3D 0;; i++) {
>>> +        sprintf(keybuf, "auth-supported.%d.auth", i);
>>
>> By my count, and including a trailing NUL, this is 21 bytes + the
>> maximum size of a formatted int to fit in keybuf[32]; 32-bit INT_MIN i=
s
>> indeed 11 bytes.  Cutting it close there, but I don't see an overflow
>> (if gcc 7's new -Wformat-truncation spots something, then gcc is too
>> strict.)
>=20
> 11 decimal digits take a hell of a list :)
>=20
> Could double the buffer if it makes anyone sleep better.

I'm okay with its current size.


>>> -            value =3D host;
>>> -            if (port) {
>>> -                /* check for ipv6 */
>>> -                if (strchr(host, ':')) {
>>> -                    strbuf =3D g_strdup_printf("[%s]:%s", host, port=
);
>>> -                } else {
>>> -                    strbuf =3D g_strdup_printf("%s:%s", host, port);=

>>
>> The old code only prints port information if it is present...
>>

>>> +        host =3D qstring_get_str(qobject_to_qstring(val));
>>> +        sprintf(keybuf, "server.%d.port", i);
>>> +        port =3D qdict_get_str(options, keybuf);
>>> =20
>>> -
>>> -        /* each iteration in the for loop will build upon the string=
, and if
>>> -         * rados_str is NULL then it is our first pass */
>>> -        if (rados_str) {
>>> -            /* separate options with ';', as that  is what rados_con=
f_set()
>>> -             * requires */
>>> -            rados_str_tmp =3D rados_str;
>>> -            rados_str =3D g_strdup_printf("%s;%s", rados_str_tmp, va=
lue);
>>> -            g_free(rados_str_tmp);
>>> +        if (strchr(host, ':')) {
>>> +            vals[i] =3D g_strdup_printf("[%s]:%s", host, port);
>>>          } else {
>>> -            rados_str =3D g_strdup(value);
>>> +            vals[i] =3D g_strdup_printf("%s:%s", host, port);
>>
>> ...but the new code unconditionally prints port information, even when=

>> port =3D=3D NULL.  Oops.
>=20
> How can port be null?  SocketAddress member port is mandatory...

Indeed. Does that mean the old code had a dead branch? Looks like it!

So, if I'm not overlooking something, that means you've resolved all my
open questions, and can submit the patch as written with:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iriViH7g0isjjmiELnKIhcsWUdHOUrl07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1B9rAAoJEKeha0olJ0Nq6WIH/3uG2DiKn27E/yizpWXaUp5K
ccowO7O8mZMaSoCwyb3YdLeBaUy+pPSmnd3qldYv6Xx98Krj67mVT2mVZ5V7Vr26
HYO2iMY0emFDkRYTTfK2vB+xCObb6hDIzp2VDEe6VoDcuxaOgtN/SIWZs2PUd7cc
lTpFne/aaV41zlTRukL+E7+O0qXd2w3kLsP/iZux30skaxuokVEix0/ABtbhiooG
/8T2+4zTqeJt+LPKNkdllPX+sLLi0x7i0kWHg+exP8HP5cmbgSofYiv7ktwDfJRt
Ocm26Vtu18E9dqm7uE1CfKa3mLIYF6zNuatWrQQSNW3zR/Og9KBSmsJ+WbkQE88=
=Vh0O
-----END PGP SIGNATURE-----

--iriViH7g0isjjmiELnKIhcsWUdHOUrl07--
