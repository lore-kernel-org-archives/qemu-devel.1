Received: from eggs.gnu.org ([2001:4830:134:3::10]:38274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOsue-0004cj-49
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOsua-0006Tt-Uw
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:16:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOsua-0006Th-LT
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 16:15:56 -0500
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-9-marcandre.lureau@redhat.com>
	<4f5926bd-557f-de20-025b-d640a6aefa17@redhat.com>
	<CAJ+F1C+EtPLpyLvpEA1Ex6jZnih2uCMTeXbQuXeivTwO9BafhQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9449592-86db-ca48-9e3e-d6ab2c42a93f@redhat.com>
Date: Wed, 4 Jan 2017 15:15:50 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+EtPLpyLvpEA1Ex6jZnih2uCMTeXbQuXeivTwO9BafhQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JvxXmDb02rbhA9CuqvphFdo8WUX6DdGTh"
Subject: Re: [Qemu-devel] [PATCH 08/54] char: allocate CharDriverState as a
 single object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JvxXmDb02rbhA9CuqvphFdo8WUX6DdGTh
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <a9449592-86db-ca48-9e3e-d6ab2c42a93f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/54] char: allocate CharDriverState as a
 single object
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-9-marcandre.lureau@redhat.com>
 <4f5926bd-557f-de20-025b-d640a6aefa17@redhat.com>
 <CAJ+F1C+EtPLpyLvpEA1Ex6jZnih2uCMTeXbQuXeivTwO9BafhQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+EtPLpyLvpEA1Ex6jZnih2uCMTeXbQuXeivTwO9BafhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/2017 03:09 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Jan 4, 2017 at 9:26 PM Eric Blake <eblake@redhat.com> wrote:
>=20
>> On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> Use a single allocation for CharDriverState, this avoids extra
>>> allocations & pointers, and is a step towards more object-oriented
>>> CharDriver.
>>>
>>> Gtk console is a bit peculiar, gd_vc_chr_set_echo
>>
>> Truncated paragraph?
>>
>=20
> yes, fixed
>=20

>>> @@ -270,7 +270,7 @@ static int baum_deferred_init(BaumDriverState *ba=
um)
>>>  /* The serial port can receive more of our data */
>>>  static void baum_accept_input(struct CharDriverState *chr)
>>>  {
>>> -    BaumDriverState *baum =3D chr->opaque;
>>> +    BaumDriverState *baum =3D (BaumDriverState *)chr;
>>
>> It might be a little nicer to use:
>>
>> BaumDriverState *baum =3D container_of(chr, BaumDriverState, parent);
>>
>>
> The follow-up of the series converts it to the more appropriate
>  BaumChardev *baum =3D BAUM_CHARDEV(obj);
>=20
> So considering that this is temporary commit, do I have to change that?=


Ah, nice. So BAUM_CHARDEV(obj) will be a nice wrapper around
container_of(). I can live with it being temporary (although a note in
the commit message can't hurt).

>=20
> to avoid a cast and work even if the members are rearranged within the
>> structure. You can even write a one-line helper function to hide the
>> cast behind a more legible semantic (for example, see to_qov() in
>> qobject-output-visitor.c).

My example of to_qov() is matched by your BAUM_CHARDEV() macro.

>> My biggest gripe is the number of casts that could be container_of()
>> instead; but otherwise it looks like a sane conversion.
>>
>>
> thanks, the goal is to get rid of them, but not in this commit :) See
> "chardev: qom-ify".

That's what I get for only reviewing the series one patch at a time. I'm
fine with temporary and partial hacks, but calling them out as such
makes review easier if we know it's going to improve later.

Since I think you've answered my questions, then with an improved commit
message, v2 can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JvxXmDb02rbhA9CuqvphFdo8WUX6DdGTh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbWYGAAoJEKeha0olJ0NqQBYIAJFSR+2LuChSvoBnXxSLnyEE
622tQRymtsj/3UDUNnAKlZ38ZBZfnQ3iDFOwF77tJd9fhUCnt4jQEUUAihehKg0/
jiEzqKGQ5SX4H6UAhyXybwGZLtu7AN8OG3KVEE16SsQog5G7l4QOBQuh6N4PUovF
gZ33BSXbNzXWfwGcvNyYl7/GatqWLUIgOPZewn9bAMec1ku+nYOqRnS3uAZelhBz
yYmsTLUVqIuieoiiwah1uD1ZKgR0/GFC7QKofNlb7E0H8IowBou5UC4qVS35nvz/
+8tgHJ9jN0oR2jjHHtxx9UVIFBScu7weLbwRmaITC/4jPfR8bJRxkINwt8y4myM=
=esjF
-----END PGP SIGNATURE-----

--JvxXmDb02rbhA9CuqvphFdo8WUX6DdGTh--
