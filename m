Received: from eggs.gnu.org ([209.51.188.92]:50971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gydNY-000495-NA
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gydNV-0007mx-Gs
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:06:39 -0500
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190225202630.GA4925@habkost.net>
	<CAMRbyysWcfctB8AeSZrQ9x9HRAKut7mWYFqVP=oQ5uVoQgvh0w@mail.gmail.com>
	<a8ca5f99-43d0-610b-ea09-28b2655f5cda@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d335bcf4-fae8-108d-2e24-9cfba80b5c2c@redhat.com>
Date: Tue, 26 Feb 2019 08:06:10 -0600
MIME-Version: 1.0
In-Reply-To: <a8ca5f99-43d0-610b-ea09-28b2655f5cda@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] iotests: handle TypeError
 for Python3 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Nir Soffer <nsoffer@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, qemu-block <qemu-block@nongnu.org>, philmd@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 2/26/19 4:39 AM, Andrey Shinkevich wrote:

>>     +++ b/tests/qemu-iotests/242
>>     @@ -64,10 +64,12 @@ def write_to_disk(offset, size):
>>      =C2=A0def toggle_flag(offset):
>>      =C2=A0 =C2=A0 =C2=A0with open(disk, "r+b") as f:
>>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.seek(offset, 0)
>>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 c =3D f.read(1)
>>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 toggled =3D chr(ord(c) ^ bitmap_flag_=
unknown)
>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The casts to bytearray() below are =
only necessary
>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # for Python 2 compatibility
>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 c =3D bytearray(f.read(1))[0]
>>
>>
>> This is simpler and makes the intent of the code more clear:
>>
>>  =C2=A0 =C2=A0 flag, =3D struct.unpack("B", f.read(1))
>>
>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 toggled =3D c ^ bitmap_flag_unknown
>>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.seek(-1, 1)
>>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(toggled)
>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(bytearray([toggled]))
>>
>>
>> For consistency, we can use struct.pack here:
>>
>>  =C2=A0 =C2=A0 f.write(struct.pack("B", toggled))
>>
>> Nir
>>
>=20
> Thank you all. I am OK with this approach.
> Will wait for Eric's response.

That looks better. Peter hasn't applied my pull request yet, so you have
time to submit a formal v3 (making it easier for me to 'git am' it
rather than reconstruct from this email), and then I will update my pull
request to use this improved version.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
