Received: from eggs.gnu.org ([2001:4830:134:3::10]:38982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDtHF-00005A-EE
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDtHE-0004c2-Fv
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:58:09 -0400
References: <20170524202842.26724-1-eblake@redhat.com>
	<20170524202842.26724-4-eblake@redhat.com>
	<20170525063444.GC27936@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c7d6a45-942d-a824-98e9-cf50a541e640@redhat.com>
Date: Thu, 25 May 2017 08:57:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170525063444.GC27936@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n9bCDDoAhDCaEGBswHTs2QxKqkPOa7H2A"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n9bCDDoAhDCaEGBswHTs2QxKqkPOa7H2A
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com,
 mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>
Message-ID: <9c7d6a45-942d-a824-98e9-cf50a541e640@redhat.com>
Subject: Re: [PATCH v2 3/5] block: Allow NULL file for bdrv_get_block_status()
References: <20170524202842.26724-1-eblake@redhat.com>
 <20170524202842.26724-4-eblake@redhat.com> <20170525063444.GC27936@lemon.lan>
In-Reply-To: <20170525063444.GC27936@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 01:34 AM, Fam Zheng wrote:
> On Wed, 05/24 15:28, Eric Blake wrote:
>> Not all callers care about which BDS owns the mapping for a given
>> range of the file.  This patch merely simplifies the callers by
>> consolidating the logic in the common call point, while guaranteeing
>> a non-NULL file to all the driver callbacks, for no semantic change.
>>
>> However, this will also set the stage for a future cleanup: when a
>> caller does not care about which BDS owns an offset, it would be
>> nice to allow the driver to optimize things to not have to return
>> BDRV_BLOCK_OFFSET_VALID in the first place.  In the case of fragmented=

>> allocation (for example, it's fairly easy to create a qcow2 image
>> where consecutive guest addresses are not at consecutive host
>> addresses), the current contract requires bdrv_get_block_status()
>> to clamp *pnum to the limit where host addresses are no longer
>> consecutive, but allowing a NULL file means that *pnum could be
>> set to the full length of known-allocated data.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v2: new patch
>=20
> Yes. any particular reason why this patch is useful, besides simplifyin=
g
> callers?

I guess it is not directly useful to this series. I can delay it to
later, and include it as part of my v2 of changing
bdrv_get_block_status() to be byte-based.  As mentioned in the commit
message, it opens the door for a potential optimization for callers that
don't care about offsets, but only allocation status, so that they can
traverse the entire device address space with fewer queries.

I'm fine if we want to just go with 1,2,4,5 for now.

>> @@ -1748,7 +1748,11 @@ static int64_t coroutine_fn bdrv_co_get_block_s=
tatus(BlockDriverState *bs,
>>      int64_t total_sectors;
>>      int64_t n;
>>      int64_t ret, ret2;
>> +    BlockDriverState *tmpfile;
>>
>> +    if (!file) {
>> +        file =3D &tmpfile;
>> +    }
>=20
> I don't like this hunk. Instead, how about replacing all "*file =3D ...=
" with
> "tmpfile =3D ..." and add "if (file) { *file =3D tmpfile; }" before ret=
urning?

Can do, particularly if I delay this patch to a later series, and we go
with the rest now.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--n9bCDDoAhDCaEGBswHTs2QxKqkPOa7H2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJuLdAAoJEKeha0olJ0NqTfQIAJfYBFDLpn7jR/M7FhTDQuPv
1KbfkugS3y4UJe2bBa7J5mRid02xkTV5rR9eam6TT6Lr51t3yQPghMPbuxDcf7Lf
j7uLhp9ggkJ7R7SYa69CUlPGDFkZ0fKPInxgpofEfJNG3/CDJbyx2jcmRImB5JqQ
EGFzQGd3A5TciXprSMMTqnYTSB+f7q2hwTsHWtiCGCpuGPrmxmFtQcr4yF0o3DrZ
cpfMAZwVNQSxiObtM/jBGqc3mcCF5OGimhknLk58Km2IrS031qzrFwmoNChfN5+g
k8j4pP+anbDu9P71VRM5Tl6L3trpJzCpwG+MBfbaK4ogxsd9VS6xHFjQAhNrMj4=
=rAU2
-----END PGP SIGNATURE-----

--n9bCDDoAhDCaEGBswHTs2QxKqkPOa7H2A--
