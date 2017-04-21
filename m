Received: from eggs.gnu.org ([2001:4830:134:3::10]:48977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1llj-0005jv-Jq
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1lli-0004xv-GE
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:31:31 -0400
From: Eric Blake <eblake@redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-5-famz@redhat.com>
	<20170421132509.GD4318@noname.redhat.com>
Message-ID: <65060af3-0984-dd20-43b7-1257d2dcbb6b@redhat.com>
Date: Fri, 21 Apr 2017 10:35:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170421132509.GD4318@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VnroslwBRdMJPe2kMXEJj2G83mi0LwSg9"
Subject: Re: [Qemu-devel] [PATCH v14 04/20] qemu-img: Add --share-rw option
 to subcommands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VnroslwBRdMJPe2kMXEJj2G83mi0LwSg9
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <65060af3-0984-dd20-43b7-1257d2dcbb6b@redhat.com>
Subject: Re: [PATCH v14 04/20] qemu-img: Add --share-rw option to subcommands
References: <20170421035606.448-1-famz@redhat.com>
 <20170421035606.448-5-famz@redhat.com>
 <20170421132509.GD4318@noname.redhat.com>
In-Reply-To: <20170421132509.GD4318@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/21/2017 08:25 AM, Kevin Wolf wrote:
> Am 21.04.2017 um 05:55 hat Fam Zheng geschrieben:
>> Similar to share-rw qdev property, this will force the opened images t=
o
>> allow shared write permission of other programs.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> General observation: We were considering to make share-rw require
> read-only. Some of the commands converted here always open the image
> read-write, so if we go ahead with the restriction, will the option
> become useless in many of the subcommands?
>=20

>>  static BlockBackend *img_open_opts(const char *optstr,
>>                                     QemuOpts *opts, int flags, bool wr=
itethrough,
>> -                                   bool quiet)
>> +                                   bool quiet, bool share_rw)
>>  {
>>      QDict *options;
>>      Error *local_err =3D NULL;
>>      BlockBackend *blk;
>>      options =3D qemu_opts_to_qdict(opts, NULL);
>> +    if (share_rw) {
>> +        qdict_put(options, BDRV_OPT_FORCE_SHARED_WRITE, qbool_from_bo=
ol(true));
>> +    }
>=20
> It's interesting that you chose a conditional qdict_put for true rather=

> than an unconditional one for share_rw here. The difference becomes
> visible when someone sets both -U and share-rw=3Doff; we need to decide=

> which one should take precedence.
>=20
> Generally, we always give explicit options the precedence, so if we wer=
e
> to follow suit here, we would set share-rw here only if the option isn'=
t
> already set. For strings, we have qdict_set_default_str() to achieve
> this, for bools we probably need a new function (or does Eric's series
> which introduces qdict_put_bool() also introduce a similar function,
> like some qdict_set_default_bool?)

It doesn't (yet), but I could add one if it is a common pattern that we
envision using.


>> @@ -3126,6 +3182,9 @@ static int img_rebase(int argc, char **argv)
>>              qdict_put(options, "driver", qstring_from_str(bs->backing=
_format));
>>          }
>> =20
>> +        if (share_rw) {
>> +            qdict_put(options, BDRV_OPT_FORCE_SHARED_WRITE, qbool_fro=
m_bool(true));
>=20
> This is longer than 80 lines and wrapping wouldn't make it unreadable. =
I
> think there are more similar instances in this series (even though you
> replied to the patchew mail that they are intentional).

This one would indeed benefit from my patch for qdict_put_bool().

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org



--VnroslwBRdMJPe2kMXEJj2G83mi0LwSg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+ia2AAoJEKeha0olJ0Nq7QIH/2H26FCQcnS2U+mBkTaDscH6
2lg83AQfNcLBxDPkyc5X4AN6iqN+nPusabY71Ec7+MZpZ7JaSE4dgPlLD/RIUW2l
Thkkmb6rM0Tjj6GMRMNOyUHFYVBMo6r2J9BeMbl+nJRWhsbosMZCwx3Xs2LatK1I
TsjT6XOfTem7y8LnpKROFjo4ELXakIFezO9Mu0N7H3dkQ1Vf6M6xhMHn8ZCOWwDU
Fai2/VntY0w+HdV8E25vqTUlO6W+czHTdSo3tP215NmPbZATfRs5QUXJO/ZqYb5p
j39ecv/UNxF5qDor8iz8LBC4BPLc4KBIHkReS0mOPmXRFjgB+V+eIzFjOxNiSHI=
=X0Ug
-----END PGP SIGNATURE-----

--VnroslwBRdMJPe2kMXEJj2G83mi0LwSg9--
