Received: from eggs.gnu.org ([2001:4830:134:3::10]:37532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cu3Ve-0004JM-HY
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 16:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cu3Vd-0005PI-Li
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 16:51:02 -0400
References: <20170331120431.1767-1-mreitz@redhat.com>
	<20170331120431.1767-3-mreitz@redhat.com>
	<6d0d11fc-1849-9acb-fc53-3c46c13878ab@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9821ca21-32fd-6054-05cc-2b505db402e2@redhat.com>
Date: Fri, 31 Mar 2017 22:50:52 +0200
MIME-Version: 1.0
In-Reply-To: <6d0d11fc-1849-9acb-fc53-3c46c13878ab@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LFe4lWTs7VPVLd1fu1BuxedE6M58sLe2P"
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] block/curl: Check protocol
 prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LFe4lWTs7VPVLd1fu1BuxedE6M58sLe2P
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9821ca21-32fd-6054-05cc-2b505db402e2@redhat.com>
Subject: Re: [PATCH for-2.9 2/2] block/curl: Check protocol prefix
References: <20170331120431.1767-1-mreitz@redhat.com>
 <20170331120431.1767-3-mreitz@redhat.com>
 <6d0d11fc-1849-9acb-fc53-3c46c13878ab@redhat.com>
In-Reply-To: <6d0d11fc-1849-9acb-fc53-3c46c13878ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 21:30, Eric Blake wrote:
> On 03/31/2017 07:04 AM, Max Reitz wrote:
>> If the user has explicitly specified a block driver and thus a protoco=
l,
>> we have to make sure the URL's protocol prefix matches. Otherwise the
>> latter will silently override the former which might catch some users =
by
>> surprise.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/curl.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>=20
> It feels a little bit dirty that we are parsing the URL rather than
> having a distinct discriminator, but I'm okay with the approach (with a=

> distinct discriminator, we would have to reconstruct a URL from the
> discriminator + the rest of the server/path information, and that's mor=
e
> work to libvirt to split a URL into the distinct JSON fields just to
> have qemu rebuild a URL).

Yes, you're right, there are a couple of points where the interface
could be nicer. Another thing is the cookie string which could be a list
of dicts or something similar. But in the end all of this block driver
really is just an interface for libcurl, so I thought it best to just
behave as such (i.e. take "blob" strings that are then just piped into
libcurl).

(The distinct discriminator would probably be just the block driver
name. But then every user would have to strip the protocol part from the
URL...)

>> +    if (!strstart(file, bs->drv->protocol_name, &protocol_delimiter) =
||
>> +        !strstart(protocol_delimiter, "://", NULL))

Regarding case sensitivity: I have to say that I actually can't remember
when I saw a not full lower-cased protocol specified in a URL, and I'm
glad about that. :-)

I also think we can wait until someone files a bug (at which point we
can always ask them how hard it would be to just write the protocol in
lower case...).

>> +    {
>> +        error_setg(errp, "%s curl driver cannot handle the URL '%s' (=
does not "
>> +                   "start with '%s://')", bs->drv->protocol_name, fil=
e,
>> +                   bs->drv->protocol_name);
>=20
> Perhaps splitting the message with an error_append_hint() for the
> parenthetical half would also be appropriate, but the line is not too
> terribly long so I won't insist on a respin.

Good idea. But I don't think it's quite worth a respin either at this poi=
nt.

(Also, it can be argued that the part in parentheses is in fact the
actual error source, so it kind of makes sense to keep it in the main
error message.)

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--LFe4lWTs7VPVLd1fu1BuxedE6M58sLe2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljewSwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/40IAKcqlpReSWhtIqqvtr7lmmR5hO2HMlh8
XmIowPpCcrjenURNYM+e1z43ZAvDX3eQ8vpVWsQk7YoskOzQOkNvbC4ErsI2GdxI
fMOxrjlnt71KtsUz2BIkV8X/BUZ7AUn6JjROaYhVczLHPoTLJb1AYSOB1F4qULkE
2F1NkbOdwIhmBG7Ts7lRcfFWDwzYyKoeCTVohZvWygU+4p3M3FC0xiIdRSkZ7x+S
ovbV8wBSfw6bkEb5re5qfNobA3349Gq56IwNgNFlIMJ13yu4kEKGEurcXMUIn51h
kqZkkuygJXN3wZh4+4WYdXMqFbzfkbwhmqR3kQnWdoCz9/j7QYZoVE0=
=AK6z
-----END PGP SIGNATURE-----

--LFe4lWTs7VPVLd1fu1BuxedE6M58sLe2P--
