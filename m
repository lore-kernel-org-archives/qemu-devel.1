Received: from eggs.gnu.org ([2001:4830:134:3::10]:60431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evO0D-00026z-UL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evO08-0004xL-Bd
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:00:38 -0400
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-7-git-send-email-vsementsov@virtuozzo.com>
	<b570a199-9139-5652-5ad8-407820680620@redhat.com>
	<540897fd-ceff-548e-ce96-11fc47ea4cd7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e10c055d-e90a-3500-ded6-f8c78598d575@redhat.com>
Date: Mon, 12 Mar 2018 09:00:12 -0500
MIME-Version: 1.0
In-Reply-To: <540897fd-ceff-548e-ce96-11fc47ea4cd7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/9] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/12/2018 08:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>>
>> We should probably validate that the length field is a multiple of=20
>> min_block (if a server tells us that all operations must be 512-byte=20
>> aligned, then reports an extent that is smaller than 512 bytes, we=20
>> have no way to ask for the status of the second half of the sector).=20
>> Probably also something that needs to be explicitly stated in the NBD=20
>> spec. [1]
>=20
> related question: what server should reply on zero-length request? I'll=
 add
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0 if (!bytes) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *pnum =3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> to nbd_client_co_block_status, to prevent such situation, but looks lik=
e=20
> spec lacks the information.

nbd.git commit ee926037 mentions that NBD_CMD_READ, _WRITE, _TRIM, and=20
_WRITE_ZEROES have unspecified behavior for zero-length transactions; we=20
should do the same for NBD_CMD_BLOCK_STATUS.  But in the meantime,=20
handling it gracefully with a no-op reply (the way qemu.git commit=20
ef8c887e handles 0-length structured read) is fine.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
