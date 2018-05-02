Received: from eggs.gnu.org ([2001:4830:134:3::10]:59419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDqyn-0002L2-7T
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDqyj-00056P-46
	for qemu-devel@nongnu.org; Wed, 02 May 2018 08:35:29 -0400
References: <20180501220509.14152-1-mreitz@redhat.com>
	<20180501220509.14152-2-mreitz@redhat.com>
	<b61ec864-3f92-d945-af4b-d14260f23ce9@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a3590eb3-49c2-2b59-fba8-8032bbeb94ac@redhat.com>
Date: Wed, 2 May 2018 14:35:07 +0200
MIME-Version: 1.0
In-Reply-To: <b61ec864-3f92-d945-af4b-d14260f23ce9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QhSAEKRuzuafQOF8qpVk4hYBCVZY3D3RI"
Subject: Re: [Qemu-devel] [PATCH 1/2] block/mirror: Make cancel always
 cancel pre-READY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QhSAEKRuzuafQOF8qpVk4hYBCVZY3D3RI
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <a3590eb3-49c2-2b59-fba8-8032bbeb94ac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block/mirror: Make cancel always cancel
 pre-READY
References: <20180501220509.14152-1-mreitz@redhat.com>
 <20180501220509.14152-2-mreitz@redhat.com>
 <b61ec864-3f92-d945-af4b-d14260f23ce9@redhat.com>
In-Reply-To: <b61ec864-3f92-d945-af4b-d14260f23ce9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 01:31, Eric Blake wrote:
> On 05/01/2018 05:05 PM, Max Reitz wrote:
>> Commit b76e4458b1eb3c32e9824fe6aa51f67d2b251748 made the mirror block
>> job respect block-job-cancel's @force flag: With that flag set, it wou=
ld
>> now always really cancel, even post-READY.
>>
>> Unfortunately, it had a side effect: Without that flag set, it would n=
ow
>> never cancel, not even before READY.=C2=A0 Considering that is an
>> incompatible change and not noted anywhere in the commit or the
>> description of block-job-cancel's @force parameter, this seems
>> unintentional and we should revert to the previous behavior, which is =
to
>> immediately cancel the job when block-job-cancel is called before sour=
ce
>> and target are in sync (i.e. before the READY event).
>>
>> Cc: qemu-stable@nongnu.org
>=20
> Actually adding that in cc on this reply.

Thanks, I knew I was going to forget...

Max

>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1572856
>> Reported-by: Yanan Fu <yfu@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block/mirror.c | 4 +++-
>> =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 7bfad6e844..003f957b12 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -874,7 +874,9 @@ static void coroutine_fn mirror_run(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_mirror_be=
fore_sleep(s, cnt, s->synced, delay_ns);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block_job_sleep=
_ns(&s->common, delay_ns);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (block_job_is_cancelled=
(&s->common) && s->common.force) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (block_job_is_cancelled=
(&s->common) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!=
s->synced || s->common.force))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->last_pause_n=
s =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>>
>=20



--QhSAEKRuzuafQOF8qpVk4hYBCVZY3D3RI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrpsHsACgkQ9AfbAGHV
z0AToQf7BQ+UPnRZObWeE3jJJO747kJbvsuVYsbYv8YU35EthPffNAI/O//ivXqy
lITdKjc94WE/tXSL+sAnh1Zh8SBASNBfah3lg1TmHhyyFA7BLTziPmR8HrAZ+Bic
tHJy8jDWBaFcaf917DwBrJAjfJ4bHM6z0RcT7qi8pYYz3/8IBJAR1rJMwzyiVd8K
1y+mQRszi0hUFoACprcuXMB1UGyAGLlJyT7gflHQiH+RbfROueFCxMuoPaCjQWFR
nqV3Oi0KHF+pf2i7xaPwrje7N0PdQPyWALiMJn28mFL1HnB1saYX+OETPXhMrQsI
6YdsnVc/LGuyRYe7jLKUcMQNM8L7Qg==
=ZCfE
-----END PGP SIGNATURE-----

--QhSAEKRuzuafQOF8qpVk4hYBCVZY3D3RI--
