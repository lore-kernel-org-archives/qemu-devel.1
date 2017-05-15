Received: from eggs.gnu.org ([2001:4830:134:3::10]:33590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAKvx-0006R7-5a
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAKvv-0004zu-Kz
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:41:29 -0400
References: <20170511182705.23648-1-jsnow@redhat.com>
	<19a665be-12c2-2876-0438-08327d94473e@redhat.com>
	<6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
	<815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
Date: Mon, 15 May 2017 20:41:12 +0200
MIME-Version: 1.0
In-Reply-To: <815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IJVw5iKNPpfqTrDn1rRgqnHsk5CVNNr9x"
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
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IJVw5iKNPpfqTrDn1rRgqnHsk5CVNNr9x
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Message-ID: <de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
Subject: Re: [PATCH v4] qemu-img: Check for backing image if specified during
 create
References: <20170511182705.23648-1-jsnow@redhat.com>
 <19a665be-12c2-2876-0438-08327d94473e@redhat.com>
 <6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
 <815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
In-Reply-To: <815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-12 21:47, John Snow wrote:
>=20
>=20
> On 05/12/2017 03:46 PM, Eric Blake wrote:
>> On 05/12/2017 01:07 PM, Max Reitz wrote:
>>> On 2017-05-11 20:27, John Snow wrote:
>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
>>>>
>>>> Or, rather, force the open of a backing image if one was specified
>>>> for creation. Using a similar -unsafe option as rebase, allow qemu-i=
mg
>>>> to ignore the backing file validation if possible.
>>>>
>>
>>>> +++ b/block.c
>>>> @@ -4275,37 +4275,37 @@ void bdrv_img_create(const char *filename, c=
onst char *fmt,
>>>>      // The size for the image must always be specified, with one ex=
ception:
>>>>      // If we are using a backing file, we can obtain the size from =
there
>>>>      size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
>>>> -    if (size =3D=3D -1) {
>>>
>>> "Hang on, why should this be -1 when the defval is 0? Where does the =
-1
>>> come from?"
>>> "..."
>>> "Oh, the option exists and is set to -1? Why is that?"
>>> "..."
>>> "Oh, because this function always sets it itself, and because @img_si=
ze
>>> is set to (uint64_t)-1."
>>
>> I had pretty much the same conversation on my v1 review.
>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01097.html
>>
>>>
>>> First, I won't start with how signed integer overflow is
>>> implementation-defined in C because I hope you have thrashed that out=

>>> with Eric (I hope that "to thrash out" is a good translation for
>>> "auskaspern" (lit. "to buffoon out").).
>>
>> Sounds like a reasonable choice of words, even if I don't speak the
>> counterpart language to validate your translation.
>>
>> (uint64_t)-1 is well-defined in C (so I think we're just fine here). B=
ut
>> (int64_t)UINT64_MAX is where signed integer overflow does indeed throw=

>> wrinkles at you.

We're not really fine because that conversion happens when the result of
qemu_opt_get_size() (a uint64_t) is stored in size (an int64_t).

>> I seem to recall that qemu has chosen to use compiler flags and/or
>> assumptions that we are using 2s-complement arithmetic with sane
>> behavior (that is, tighter behavior than the bare minimum that C
>> requires), because it was easier than auditing our code for strict C
>> compliance on border cases of conversions from unsigned to signed that=

>> trigger undefined behavior.  But again, I don't think it affects this
>> patch (where our conversion is only from signed to unsigned, and that =
is
>> well-defined behavior).

Right. Which is why I said I won't even start on it, but of course I
did. O:-)

>>> Second, well, at least we should put -1 as the default value here, th=
en.
>>
>> Indeed, now that two reviewers have tripped on it,
>> qemu_opt_get_size(,,-1) would be nicer.
>>
>>>
>>> Not strictly your fault or something that you need to fix, but it is
>>> just a single line in the vicinity...
>>>
>>> Let me know if you want to address this, for now I'll leave a
>>>
>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>
>>> here if you don't want to.
>>
>> I'm okay whether you want to squash that fix into this patch, or wheth=
er
>> you do it as a separate followup patch.
>>
>=20
> I had considered the issue separate; but you're welcome to either write=

> a patch or squish it into this one, I'm not going to be picky.

Yep, it is a separate issue, just related. :-)

But since you and Eric agree, I've squashed it in and thus I'm more than
glad to thank you very much and announce this patch as applied to my
block branch:

https://github.com/XanClic/qemu/commits/block

Max


--IJVw5iKNPpfqTrDn1rRgqnHsk5CVNNr9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZGfZJEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKU5
B/9UZ0fE1iiQN4Be8Jnc0Y8dVj856okTJxc1GcQpjz5c1pzHjYWWQmsx1JQ0wI0K
4EnmJtO9/L6mHiEFF0T6Kh4GkhdFkfJbeHpkWcFfKrLOposMk7sP0v1/rS2Bp9S4
KkNXB95sXoO2D4pIQ5SjVyFvxeyv7Lv435REFyIHUt15QAF6mqwMTsm0hECtxUAK
HEHHFqiL+kxRGnkaNaO5hg1eHx+eY5dxvIP/aeKmbxDUelTshBFJrH8lBSB7JT0y
iEDr/O8ekIQrreSO7YALClKVtkvThszKevMoMzf++FJXYcteQWDM1T2pL1j4+/l1
UDVK6uIp+FQDxXpR/Ksh4L2L
=T8A8
-----END PGP SIGNATURE-----

--IJVw5iKNPpfqTrDn1rRgqnHsk5CVNNr9x--
