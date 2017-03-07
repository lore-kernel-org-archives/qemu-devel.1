Received: from eggs.gnu.org ([2001:4830:134:3::10]:57858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clMRn-0004ff-P0
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 16:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clMRm-0007Cw-IR
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 16:15:07 -0500
References: <20170214192525.18624-1-eblake@redhat.com>
	<20170214192525.18624-7-eblake@redhat.com>
	<20170215162007.GF4935@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f1103c9-142b-85c5-bc29-69110407136e@redhat.com>
Date: Tue, 7 Mar 2017 15:14:58 -0600
MIME-Version: 1.0
In-Reply-To: <20170215162007.GF4935@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X7MT9uhjJt7xKuP4CGKI1N8FSwB90Pk42"
Subject: Re: [Qemu-devel] [PATCH v5 6/7] blkdebug: Add ability to override
 unmap geometries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X7MT9uhjJt7xKuP4CGKI1N8FSwB90Pk42
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <9f1103c9-142b-85c5-bc29-69110407136e@redhat.com>
Subject: Re: [PATCH v5 6/7] blkdebug: Add ability to override unmap geometries
References: <20170214192525.18624-1-eblake@redhat.com>
 <20170214192525.18624-7-eblake@redhat.com>
 <20170215162007.GF4935@noname.redhat.com>
In-Reply-To: <20170215162007.GF4935@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 10:20 AM, Kevin Wolf wrote:
> Am 14.02.2017 um 20:25 hat Eric Blake geschrieben:
>> Make it easier to simulate various unusual hardware setups (for
>> example, recent commits 3482b9b and b8d0a98 affect the Dell
>> Equallogic iSCSI with its 15M preferred and maximum unmap and
>> write zero sizing, or b2f95fe deals with the Linux loopback
>> block device having a max_transfer of 64k), by allowing blkdebug
>> to wrap any other device with further restrictions on various
>> alignments.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>>  # @inject-error:    #optional array of error injection descriptions
>>  #
>>  # @set-state:       #optional array of state-change descriptions
>> @@ -2472,7 +2493,9 @@
>>  { 'struct': 'BlockdevOptionsBlkdebug',
>>    'data': { 'image': 'BlockdevRef',
>>              '*config': 'str',
>> -            '*align': 'int',
>> +            '*align': 'int', '*max-transfer': 'int32',
>> +            '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
>> +            '*opt-discard': 'int32', '*max-discard': 'int32',
>=20
> Hm, strictly speaking, this schema allows for negative values. Should w=
e
> document that they aren't allowed?

Doesn't power of two imply positive? But yes, I can tweak the wording.


>> -    /* Set request alignment */
>> +    /* Set alignment overrides */
>>      s->align =3D qemu_opt_get_size(opts, "align", 0);
>>      if (s->align && (s->align >=3D INT_MAX || !is_power_of_2(s->align=
))) {
>>          error_setg(errp, "Invalid alignment, align must be integer po=
wer of 2");
>>          goto fail_unref;
>>      }
>> +    align =3D MAX(s->align, bs->file->bs->bl.request_alignment);
>> +
>> +    s->max_transfer =3D qemu_opt_get_size(opts, "max-transfer", 0);
>> +    if (s->max_transfer &&
>> +        (s->max_transfer >=3D INT_MAX ||
>> +         !QEMU_IS_ALIGNED(s->max_transfer, align))) {
>> +        error_setg(errp, "Invalid max-transfer, must be multiple of a=
lign");
>=20
> It's not that I'm generally a friend of unspecific messages, but in thi=
s
> case I think I would prefer being unspecific to the potentially wrong
> error message that is returned here. We're checking multiple conditions=

> and the error message mentions only one of them as the reason, which ma=
y
> or may not be the right one.
>=20
> This is the same for all new options.

I'm leaning towards "Cannot meet constraints with max-transfer %lld" as
being non-specific enough to cover all the cases while still describing
the problem to be fixed.  Any other wording suggestions would be
welcome, if someone has a particular bikeshed color they like.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--X7MT9uhjJt7xKuP4CGKI1N8FSwB90Pk42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvyLSAAoJEKeha0olJ0NqmQ8IAJ3uvzJBrMh54d8gYXLCEukh
YG0+BuywkpbzYiG3ziOETjDS/mEtRrDsWA27UOe9tNW6odEGGrMgG4HRRjoyxoQS
tphVSpF3w/hhaIuUPvt6YdainaCDdtpcnCwhUl7O1kOgVNAb8sSyn0UEmFavcB2p
10muR38kcHMGEX7WIcrlMXT3MdGuLuwG2cZbvTTTekZh5eAuePU0BX58yLwIYTjB
aEo9BogeVyvpuBOdQ9Zd8wPUuNMWiMUsNzPpZqiBk1e8yPC9ohyKt/r85IBSXvUi
f7DoGDzgqbnhALbUBdASAkJbc3bR5b4lXRlvjoEFT9XqXtMvGYA/2uTVrtEKWuU=
=kDCU
-----END PGP SIGNATURE-----

--X7MT9uhjJt7xKuP4CGKI1N8FSwB90Pk42--
