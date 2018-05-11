Received: from eggs.gnu.org ([2001:4830:134:3::10]:53599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHCVz-0007Mx-5A
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHCVy-0006rw-29
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:11:35 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-7-mreitz@redhat.com>
	<105c40ee-d81a-2ebb-cd3a-63aa9e518d80@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9ad8a3f2-d56f-5eaf-3136-ed5264ec9eb4@redhat.com>
Date: Fri, 11 May 2018 20:11:24 +0200
MIME-Version: 1.0
In-Reply-To: <105c40ee-d81a-2ebb-cd3a-63aa9e518d80@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5u5iYTHiYuccty6iuLiVaRfCpfQ3f5ID1"
Subject: Re: [Qemu-devel] [PATCH 06/13] block: Add block-specific QDict
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5u5iYTHiYuccty6iuLiVaRfCpfQ3f5ID1
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <9ad8a3f2-d56f-5eaf-3136-ed5264ec9eb4@redhat.com>
Subject: Re: [PATCH 06/13] block: Add block-specific QDict header
References: <20180509165530.29561-1-mreitz@redhat.com>
 <20180509165530.29561-7-mreitz@redhat.com>
 <105c40ee-d81a-2ebb-cd3a-63aa9e518d80@redhat.com>
In-Reply-To: <105c40ee-d81a-2ebb-cd3a-63aa9e518d80@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-10 16:54, Eric Blake wrote:
> On 05/09/2018 11:55 AM, Max Reitz wrote:
>> There are numerous QDict functions that have been introduced for and a=
re
>> used only by the block layer.=C2=A0 Move their declarations into an ow=
n
>=20
> s/an own/their own/
>=20
>> header file to reflect that.
>>
>> While qdict_extract_subqdict() is in fact used outside of the block
>> layer (in util/qemu-config.c), it is still a function related very
>> closely to how the block layer works with nested QDicts, namely by
>> sometimes flattening them.=C2=A0 Therefore, its declaration is put int=
o this
>> header as well and util/qemu-config.c includes it with a comment stati=
ng
>> exactly which function it needs.
>>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> +++ b/include/block/qdict.h
>> @@ -0,0 +1,35 @@
>> +/*
>> + * Special QDict functions used by the block layer
>> + *
>> + * Copyright (c) 2018 Red Hat, Inc.
>=20
> You are extracting this from qdict.h which has:
> =C2=A0* Copyright (C) 2009 Red Hat Inc.
>=20
> Is it worth listing 2009-2018, instead of just this year?

I don't know, is it?  I don't know whether it makes a real difference.

>> +
>> +void qdict_copy_default(QDict *dst, QDict *src, const char *key);
>> +void qdict_set_default_str(QDict *dst, const char *key, const char
>> *val);
>=20
> These two might be useful outside of the block layer; we can move them
> back in a later patch if so.=C2=A0 But for now, I agree with your choic=
e of
> moving them.
>=20
>> +
>> +void qdict_join(QDict *dest, QDict *src, bool overwrite);
>=20
> This is borderline whether it would be useful outside of the block laye=
r.

I decided I wanted to move the *_default* functions, and if I did that,
I would have to move this one as well.  I decided I can't be biased just
because I wrote this one. :-)

But in general I'd say if anyone wants to use any of these functions
outside of the block layer, they are welcome to move them back to the
main header, provided they have a good reason to do so.  I suppose a
good reason for using qdict_join() may indeed turn up sooner or later.

Max

>> +
>> +void qdict_extract_subqdict(QDict *src, QDict **dst, const char *star=
t);
>> +void qdict_array_split(QDict *src, QList **dst);
>> +int qdict_array_entries(QDict *src, const char *subqdict);
>> +QObject *qdict_crumple(const QDict *src, Error **errp);
>> +void qdict_flatten(QDict *qdict);
>=20
> And these are definitely hacks that the block layer relies on, where
> hopefully someday long term we can rewrite the block layer to use QAPI
> types directly instead of constant reconversion between QemuOpts and
> QDict and QAPI types.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20



--5u5iYTHiYuccty6iuLiVaRfCpfQ3f5ID1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr13MwACgkQ9AfbAGHV
z0CBGAgAiCCx+VFiznXckGayL3kJAm6LY4r1o6G+soaNdy04JqdGL8EcnzC4Q61Q
24Mnzy//2bsv+VLO5mzPCnzX8nYsfq3HFPZYiZiGc7KtG1ys0Jzt4G9dvhboQ0M2
tqv0dX0l5ZXbB2XJ98Z6VL1lHuYYOksOCLBqhpt/gCF4hozmDizfHuoTk0obK43f
qBioBsgho9jQC2cVNHhxTrHb/zHYgfcTddcObOrQmW5rAxZH1sgfzC0Z9787JGsg
cWtQZ30otBFbUbEjhjnS89aiXiN+b4y3893XPOx7+c2Oebge2AffndOYwK7cRPlS
/atw+e3TACXBDoCMECbeVK8PJsQepA==
=hcr3
-----END PGP SIGNATURE-----

--5u5iYTHiYuccty6iuLiVaRfCpfQ3f5ID1--
