Received: from eggs.gnu.org ([2001:4830:134:3::10]:48381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9GW4-000270-0n
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d9GW2-0001zS-NR
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:46:20 -0400
References: <20170511182705.23648-1-jsnow@redhat.com>
	<19a665be-12c2-2876-0438-08327d94473e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
Date: Fri, 12 May 2017 14:46:08 -0500
MIME-Version: 1.0
In-Reply-To: <19a665be-12c2-2876-0438-08327d94473e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Afkwsf89AeDF6BwjX97IW1xeQpKslGVJj"
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Afkwsf89AeDF6BwjX97IW1xeQpKslGVJj
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Message-ID: <6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
Subject: Re: [PATCH v4] qemu-img: Check for backing image if specified during
 create
References: <20170511182705.23648-1-jsnow@redhat.com>
 <19a665be-12c2-2876-0438-08327d94473e@redhat.com>
In-Reply-To: <19a665be-12c2-2876-0438-08327d94473e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 01:07 PM, Max Reitz wrote:
> On 2017-05-11 20:27, John Snow wrote:
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
>>
>> Or, rather, force the open of a backing image if one was specified
>> for creation. Using a similar -unsafe option as rebase, allow qemu-img=

>> to ignore the backing file validation if possible.
>>

>> +++ b/block.c
>> @@ -4275,37 +4275,37 @@ void bdrv_img_create(const char *filename, con=
st char *fmt,
>>      // The size for the image must always be specified, with one exce=
ption:
>>      // If we are using a backing file, we can obtain the size from th=
ere
>>      size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
>> -    if (size =3D=3D -1) {
>=20
> "Hang on, why should this be -1 when the defval is 0? Where does the -1=

> come from?"
> "..."
> "Oh, the option exists and is set to -1? Why is that?"
> "..."
> "Oh, because this function always sets it itself, and because @img_size=

> is set to (uint64_t)-1."

I had pretty much the same conversation on my v1 review.
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01097.html

>=20
> First, I won't start with how signed integer overflow is
> implementation-defined in C because I hope you have thrashed that out
> with Eric (I hope that "to thrash out" is a good translation for
> "auskaspern" (lit. "to buffoon out").).

Sounds like a reasonable choice of words, even if I don't speak the
counterpart language to validate your translation.

(uint64_t)-1 is well-defined in C (so I think we're just fine here). But
(int64_t)UINT64_MAX is where signed integer overflow does indeed throw
wrinkles at you.

I seem to recall that qemu has chosen to use compiler flags and/or
assumptions that we are using 2s-complement arithmetic with sane
behavior (that is, tighter behavior than the bare minimum that C
requires), because it was easier than auditing our code for strict C
compliance on border cases of conversions from unsigned to signed that
trigger undefined behavior.  But again, I don't think it affects this
patch (where our conversion is only from signed to unsigned, and that is
well-defined behavior).


>=20
> Second, well, at least we should put -1 as the default value here, then=
=2E

Indeed, now that two reviewers have tripped on it,
qemu_opt_get_size(,,-1) would be nicer.

>=20
> Not strictly your fault or something that you need to fix, but it is
> just a single line in the vicinity...
>=20
> Let me know if you want to address this, for now I'll leave a
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> here if you don't want to.

I'm okay whether you want to squash that fix into this patch, or whether
you do it as a separate followup patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Afkwsf89AeDF6BwjX97IW1xeQpKslGVJj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFhEAAAoJEKeha0olJ0NqcnsH/Ajr6n1VIYTYzsw6zxO120K7
E85n1VDRUYmMrAdBEQf6jVpA3DxUudt9Zatj+2hpxFm/VHmSkGV+vvZ+6wsi/+IP
OEV0fUuGlO4/dveTMD8TpKTCMqTdbSV2kFGtaCQbahe3a7d9W0oL1o3WnXMss8/B
eI+8IIY23sjAbqn7hJpfSlnfMQa+zosajlVyidwoxFE6E5qOrTJvo/6uG9oQWHrq
ci0rp48Bw6JPOJxjdUJHSZ3FDSZ/gUwut3sETI5HCCIfq+JZuV8cfI83ZPsKHx98
8EPATmAdFqk0wwHKqUMyfj/tnajL+7XHJmUEVTol3Oe5Bcesaeq1DKJFYDEWqjA=
=nMpt
-----END PGP SIGNATURE-----

--Afkwsf89AeDF6BwjX97IW1xeQpKslGVJj--
