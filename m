Received: from eggs.gnu.org ([2001:4830:134:3::10]:34093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctcem-0007l5-MQ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctceg-0005KL-Tq
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:10:40 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-5-git-send-email-armbru@redhat.com>
	<5e1790e7-5e12-adc6-a049-ca004682025d@redhat.com>
	<87fuhvfe96.fsf@dusky.pond.sub.org>
	<2e07453b-4d48-3acb-91bd-526de637c5c2@redhat.com>
	<871ste4yi9.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b97d1a29-f3ac-8209-f895-a28458d78e1c@redhat.com>
Date: Thu, 30 Mar 2017 18:10:23 +0200
MIME-Version: 1.0
In-Reply-To: <871ste4yi9.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a6R0ABIxLv1sFVSaS1LAal66SUNTjR5Tc"
Subject: Re: [Qemu-devel] [for-2.9 4/8] block: Document -drive problematic
 code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a6R0ABIxLv1sFVSaS1LAal66SUNTjR5Tc
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 jcody@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 namei.unix@gmail.com
Message-ID: <b97d1a29-f3ac-8209-f895-a28458d78e1c@redhat.com>
Subject: Re: [Qemu-devel] [for-2.9 4/8] block: Document -drive problematic
 code and bugs
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-5-git-send-email-armbru@redhat.com>
 <5e1790e7-5e12-adc6-a049-ca004682025d@redhat.com>
 <87fuhvfe96.fsf@dusky.pond.sub.org>
 <2e07453b-4d48-3acb-91bd-526de637c5c2@redhat.com>
 <871ste4yi9.fsf@dusky.pond.sub.org>
In-Reply-To: <871ste4yi9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 16:42, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/30/2017 01:52 AM, Markus Armbruster wrote:
>>
>>>>> +++ b/block.c
>>>>> @@ -1157,6 +1157,12 @@ static int bdrv_open_common(BlockDriverState=
 *bs, BlockBackend *file,
>>>>>      if (file !=3D NULL) {
>>>>>          filename =3D blk_bs(file)->filename;
>>>>>      } else {
>>>>> +       /*
>>>>> +        * Caution: direct use of non-string @options members is
>>>>> +        * problematic.  When they come from -blockdev or blockdev_=
add,
>>>>> +        * members are typed according to the QAPI schema, but when=

>>>>> +        * they come from -drive, they're all QString.
>>>>> +        */
>>>>>          filename =3D qdict_get_try_str(options, "filename");
>>>>
>>>> For instance this one: Well, yes, for -drive, this will always be a
>>>> QString. Which is OK, because that's what we're trying to get.
>>>>
>>>> The comment makes this confusing, IMO. If you really want a comment =
here
>>>> it should at least contain a mention that it's totally fine in pract=
ice
>>>> here. Calling the code "problematic" sounds like this could blow up =
when
>>>> it reality it can't; and I would think it actually is the most sane
>>>> solution given the current state of the whole infrastructure (i.e. h=
ow
>>>> -drive and -blockdev work).
>>>
>>> Well, if it could blow up, I'd call it wrong, and start the comment w=
ith
>>> FIXME :)
>>>
>>> Even though qdict_get_try_str() is indeed fine, I propose to have a
>>> comment, because someone with less detailed understanding of how the
>>> configuration machine works (me, until yesterday, and probably again
>>> after next month) could conclude that qdict_get_try_bool() would be j=
ust
>>> as fine.
>>>
>>> What about:
>>>
>>>    /*
>>>     * Caution: while qdict_get_try_str() is fine, getting non-string
>>>     * types would require more care.  When @options come from -blockd=
ev
>>>     * or blockdev_add, its members are typed according to the QAPI
>>>     * schema, but when they come from -drive, they're all QString.
>>>     */
>>
>> Yes, that's better - it makes it obvious that our current usage works,=

>> but that the code must not be carelessly edited if we add another fiel=
d
>> in the future.
>=20
> If Max is also happy with it, I'll put it in v3.

Yes, more than happy, thanks! (Same for the other comment.)

Max


--a6R0ABIxLv1sFVSaS1LAal66SUNTjR5Tc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljdLfASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9x4IAJ4Ls0bdZYqgsjO1zBFT67cFxL8Hx1tu
0ZicYfbRhvNgnQmT5HEdZNJoB2l2FCLnXRS+FF5f29DgPg8nQMRxfmhrU8TVBtda
K0JcWuNRalRB43JW4NVTxhjToMd+rhZexdnX28cnThjbBvC0s4B5Ht66NK9R7bek
OSlndpHFgNBcOxyNrBIz/J4QFVEUFnYgj1ssz6iax58DPpYAeNRrsrnN9+7RyAVP
W5Czr9/NvAuZvSxtw1tiL6c/Hw1v313RaNtUaFDWMkY6sAbumjnZfdFVDaxog/vH
YY1CUz2R5KULpJelW2I8htuJZm6llCEDj23sfrn9bI970wUvY+KJYOA=
=4i2l
-----END PGP SIGNATURE-----

--a6R0ABIxLv1sFVSaS1LAal66SUNTjR5Tc--
