Received: from eggs.gnu.org ([2001:4830:134:3::10]:41837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cthdu-0001rz-0I
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cthdt-0002hT-05
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:30:06 -0400
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
	<1490895797-29094-5-git-send-email-armbru@redhat.com>
	<21a9cc9f-03f4-382f-2816-b0c40c9c267a@redhat.com>
	<87r31ewq3x.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b5f1e0f5-0e7f-93bf-2f9f-a7c67630c828@redhat.com>
Date: Thu, 30 Mar 2017 23:29:56 +0200
MIME-Version: 1.0
In-Reply-To: <87r31ewq3x.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Je6gPcLTwKOdf42bSBufrO80hgtnD5dp1"
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9 4/9] block: Document -drive
 problematic code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Je6gPcLTwKOdf42bSBufrO80hgtnD5dp1
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com,
 namei.unix@gmail.com
Message-ID: <b5f1e0f5-0e7f-93bf-2f9f-a7c67630c828@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9 4/9] block: Document -drive
 problematic code and bugs
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
 <1490895797-29094-5-git-send-email-armbru@redhat.com>
 <21a9cc9f-03f4-382f-2816-b0c40c9c267a@redhat.com>
 <87r31ewq3x.fsf@dusky.pond.sub.org>
In-Reply-To: <87r31ewq3x.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 20:56, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/30/2017 12:43 PM, Markus Armbruster wrote:
>>> -blockdev and blockdev_add convert their arguments via QObject to
>>> BlockdevOptions for qmp_blockdev_add(), which converts them back to
>>> QObject, then to a flattened QDict.  The QDict's members are typed
>>> according to the QAPI schema.
>>>
>>> -drive converts its argument via QemuOpts to a (flat) QDict.  This
>>> QDict's members are all QString.
>>>
>>> Thus, the QType of a flat QDict member depends on whether it comes
>>> from -drive or -blockdev/blockdev_add, except when the QAPI type maps=

>>> to QString, which is the case for 'str' and enumeration types.
>>>
>>
>>> +++ b/block/file-posix.c
>>> @@ -2193,6 +2193,12 @@ static int hdev_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>>>      int ret;
>>> =20
>>>  #if defined(__APPLE__) && defined(__MACH__)
>>> +    /*
>>> +     * Caution: while qdict_get_try_str() is fine, getting non-strin=
g
>>> +     * types would require more care.  When @options come from -bloc=
kdev
>>> +     * or blockdev_add, its members are typed according to the QAPI
>>> +     * schema, but when they come from -drive, they're all QString.
>>> +     */
>>>      const char *filename =3D qdict_get_str(options, "filename");
>>
>> Comment mentions (via copy-and-past) qdict_get_try_str(), but this
>> instance uses qdict_get_str().  Doesn't bother me enough to withhold
>> review if you leave it, though.
>>
>>
>>> +++ b/block/nfs.c
>>> @@ -474,6 +474,13 @@ static NFSServer *nfs_config(QDict *options, Err=
or **errp)
>>>          goto out;
>>>      }
>>> =20
>>> +    /*
>>> +     * Caution: this works only because all scalar members of
>>> +     * NFSServer are QString in @crumpled_addr.  The visitor expects=

>>> +     * @crumpled_addr to be typed according to the QAPI scherma.  It=

>>
>> s/scherma/schema/
>=20
> In case nothing else comes up, I hope both can be touched up on commit.=

> Max?

Sure, will do.

Max

>>> +     * is when @options come from -blockdev or blockdev_add.  But wh=
en
>>> +     * they come from -drive, they're all QString.
>>> +     */
>>
>> With the typo fix,
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Thanks!
>=20



--Je6gPcLTwKOdf42bSBufrO80hgtnD5dp1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljdeNQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKLEIAI6Gh3ED0lj16eD35yqxNJG1FIwl6MTz
E1EXJMLq8W9VbkyIPTQj5rdCRDhbQovsgMSBhcAsv3hPdV59HzyagqDrMHpQRK20
fX2pUwXNxRSDkng6oXkJ88bosv64Rk9dj+lFHcEuDnjnEitukTFB0r4AFZaSU48K
KNsi4DcvRzPiqwTr4kJXA79Uj67/zOcOJ8FIoof0eW3xrlpzwdOrGJVllNEKeRiH
YGPh9ix38bq8Qu+CHH7xN/TwqnSRPXbxvoU7i/5AVUZqKyNqaJqGqfjwBpGW/bey
twpaBWCWJbHHWykmnCmtqm+6hVtJ6bHnCvYOl0GeovqUBofuYmq1i4A=
=ZSZV
-----END PGP SIGNATURE-----

--Je6gPcLTwKOdf42bSBufrO80hgtnD5dp1--
