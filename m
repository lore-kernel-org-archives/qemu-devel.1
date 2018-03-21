Received: from eggs.gnu.org ([2001:4830:134:3::10]:47721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydqD-0001QW-LE
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydqC-0001xG-Rp
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:31:45 -0400
References: <20180320135515.16823-1-berto@igalia.com>
	<78205471-01fc-9d60-590e-feab0df79439@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <635c2d4a-3cb1-06db-70d0-423a28b78216@redhat.com>
Date: Wed, 21 Mar 2018 08:31:37 -0500
MIME-Version: 1.0
In-Reply-To: <78205471-01fc-9d60-590e-feab0df79439@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qcow2: Reset free_cluster_index when
 allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/21/2018 08:30 AM, Eric Blake wrote:
> On 03/20/2018 08:55 AM, Alberto Garcia wrote:

>> This can be reproduced easily:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-img create -f qcow2 -o cluster_siz=
e=3D512 hd.qcow2 1M
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-io -c 'write 0 124k' hd.qcow2
>=20
> This reproduction fails if you use non-default refcount_order...
>=20
>> +++ b/tests/qemu-iotests/121
>> @@ -93,6 +93,26 @@ $QEMU_IO -c 'write 63M 130K' "$TEST_IMG" |=20
>> _filter_qemu_io
>> =C2=A0 _check_test_img
>> +echo
>> +echo '=3D=3D=3D Allocating a new refcount block must not leave holes =
in the=20
>> image =3D=3D=3D'
>> +echo
>> +
>> +IMGOPTS=3D'cluster_size=3D512' _make_test_img 1M
>=20
> ...so here, I think IMGOPTS also has to include refcount_bits=3D4, so t=
hat=20
> calling iotests './check -o refcount_bits=3D3' or similar doesn't fail =
the=20
> test.

Except that it's spelled refcount_bits=3D16 vs. refcount_bits=3D8 (we=20
convert refcount_bits as a power of 2 to refcount_order as an exponent=20
value written into the qcow2 header).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
