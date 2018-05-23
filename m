Received: from eggs.gnu.org ([2001:4830:134:3::10]:36957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLVst-0002Sx-Gg
	for qemu-devel@nongnu.org; Wed, 23 May 2018 11:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLVss-0008Gn-Kw
	for qemu-devel@nongnu.org; Wed, 23 May 2018 11:41:03 -0400
References: <20180501211336.986372-1-eblake@redhat.com>
	<20180501211336.986372-4-eblake@redhat.com>
	<0df1a90d-bcca-ac1e-0f17-b982faefc253@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27e395fd-51e6-1b40-cfa2-c59ae8d3aea1@redhat.com>
Date: Wed, 23 May 2018 10:40:55 -0500
MIME-Version: 1.0
In-Reply-To: <0df1a90d-bcca-ac1e-0f17-b982faefc253@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] nbd/client: Support requests of
 additional block sizing info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 05/22/2018 10:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> 02.05.2018 00:13, Eric Blake wrote:
>> The NBD spec is clarifying [1] that a server may want to advertise
>> different limits for READ/WRITE (in our case, 32M) than for
>> TRIM/ZERO (in our case, nearly 4G).=C2=A0 Implement the client
>> side support for these alternate limits, by always requesting
>> the new information (a compliant server must ignore the
>> request if it is unknown), and by validating anything reported
>> by the server before populating the block layer limits.

I still need to do a v2 of this series based on feedback from the NBD=20
list, but answering your question in the meantime:


>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.request_alignment =3D min ? min =
: BDRV_SECTOR_SIZE;
>> -=C2=A0=C2=A0=C2=A0 bs->bl.max_pdiscard =3D max;
>> -=C2=A0=C2=A0=C2=A0 bs->bl.max_pwrite_zeroes =3D max;
>> +=C2=A0=C2=A0=C2=A0 if (s->info.max_trim) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.max_pdiscard =3D MI=
N(s->info.max_trim,=20
>> BDRV_REQUEST_MAX_BYTES);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.max_pdiscard =3D ma=
x;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 bs->bl.pdiscard_alignment =3D s->info.min_trim;
>> +=C2=A0=C2=A0=C2=A0 if (s->info.max_zero) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.max_pwrite_zeroes =3D=
 MIN(s->info.max_zero,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BDRV_REQUEST_MAX_BYTES);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.max_pwrite_zeroes =3D=
 max;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 bs->bl.pwrite_zeroes_alignment =3D s->info.min_zer=
o;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.max_transfer =3D max;
>=20
> Should not max_transfer be updated too? Looks like it limits all=20
> requests, is it right?

max_transfer affects read and write requests, but not write_zero=20
requests (where max_pwrite_zeroes is used instead) or trim requests=20
(where max_pdiscard is used instead).  Which is precisely the semantics=20
we want - the NBD extension is mirroring the fact that qemu already has=20
a way to track independent limits for trim/zero that can be larger than=20
the normal limits for read/write, because trim/zero do not involve a=20
transfer of a large data buffer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
