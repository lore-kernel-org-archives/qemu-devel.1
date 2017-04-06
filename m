Received: from eggs.gnu.org ([2001:4830:134:3::10]:60580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw7fG-0000LF-Ux
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw7fF-0007Fp-Sq
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:41:30 -0400
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-11-eblake@redhat.com>
	<20170406090045.GC4341@noname.redhat.com>
	<1313a278-947d-9b73-640f-3aa518019773@redhat.com>
	<20170406132738.GG4341@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aac10f8e-5903-2451-7784-6266b0e0ea69@redhat.com>
Date: Thu, 6 Apr 2017 08:41:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170406132738.GG4341@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UKxJIWSBmjInXX51VkUSQgLbANlT5MJEX"
Subject: Re: [Qemu-devel] [PATCH v3 10/13] block: Simplify
 bdrv_append_temp_snapshot() logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UKxJIWSBmjInXX51VkUSQgLbANlT5MJEX
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <aac10f8e-5903-2451-7784-6266b0e0ea69@redhat.com>
Subject: Re: [PATCH v3 10/13] block: Simplify bdrv_append_temp_snapshot()
 logic
References: <20170405194741.18956-1-eblake@redhat.com>
 <20170405194741.18956-11-eblake@redhat.com>
 <20170406090045.GC4341@noname.redhat.com>
 <1313a278-947d-9b73-640f-3aa518019773@redhat.com>
 <20170406132738.GG4341@noname.redhat.com>
In-Reply-To: <20170406132738.GG4341@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 08:27 AM, Kevin Wolf wrote:

>>>> @@ -2209,13 +2209,10 @@ static BlockDriverState *bdrv_append_temp_sn=
apshot(BlockDriverState *bs,

More context:

>     bs_snapshot =3D bdrv_open(NULL, NULL, snapshot_options, flags, errp=
);
>     snapshot_options =3D NULL;
>     if (!bs_snapshot) {
>         ret =3D -EINVAL;
>         goto out;
>     }

Up to here, bs_snapshot is NULL if we return.  What is the deal with
ret? Setting it to -EINVAL has no purpose, as we don't reference ret in
the out label.

>=20
>     /* bdrv_append() consumes a strong reference to bs_snapshot (i.e. i=
t will
>      * call bdrv_unref() on it), so in order to be able to return one, =
we have
>      * to increase bs_snapshot's refcount here */
>     bdrv_ref(bs_snapshot);
>     bdrv_append(bs_snapshot, bs, &local_err);
>     if (local_err) {
>         error_propagate(errp, local_err);
>         ret =3D -EINVAL;
>         goto out;
>     }

Again, what's with setting ret? But you are right that this is a place
where bs_snapshot would be non-null when we want to return an error.
The goto out looks a bit funny with no further code (although it's okay
to leave it as a defensive measure for code added later, as that's what
bdrv_append() does).

>>>>
>>>> +out:
>>>> +    QDECREF(snapshot_options);
>>>>      g_free(tmp_filename);
>>>>      return bs_snapshot;
>>>
>>> bs_snapshot is uninitialised or at least the wrong return value in er=
ror
>>> cases. (Hm... Shouldn't the compiler catch the uninitialised part?)
>>
>> Odd, and I agree that I recall the compiler generally able to catch th=
at
>> (maybe it's a matter of compiling with -g vs. -O2).  I'm surprised the=

>> autobuilder didn't flag it.  (I think I missed it due to rebase churn =
on
>> my end).  The obvious fix is to:
>>
>> -    BlockDriverState *bs_snapshot;
>> +    BlockDriverState *bs_snapshot =3D NULL;
>=20
> That's just half of the fix. It doesn't fix the cases where bs_snapshot=

> is already set. We still want to return NULL on errors there.

Thanks for calling it to my attention.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UKxJIWSBmjInXX51VkUSQgLbANlT5MJEX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5kWAAAoJEKeha0olJ0Nq2vIH/jWu8sotNViIZSNlrePovFxF
oOEo2exAbWyQQQC+nNIHPdMixmmAH+dyEZY808ZNHHudoIym7hTH3rwpoXFRiiVj
hmZsCIeHMzp4rw415/p6in9CawxvTSLDyuIn/XgvXR17jn7C4lR2wUzw2SJf543S
iT0YQiSzLCMMtk0w5iiMlWeLIe0uDXE3zS9oTwEDK5r6KB7mrrte17JAmwh7p+Uu
jc1tf1c8bc5UGhTkkpo0dar7FgeVCCTxv+/bfzx2w31CW7uAd4nr1JzOttIDS6QA
2GizkqqM4MvEm3Tdezp1JYS/H0nwLttJw+tluYnlUThlU0dkA6EBujln6XevFE8=
=F5l6
-----END PGP SIGNATURE-----

--UKxJIWSBmjInXX51VkUSQgLbANlT5MJEX--
