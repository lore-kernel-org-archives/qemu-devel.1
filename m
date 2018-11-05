Received: from eggs.gnu.org ([2001:4830:134:3::10]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gJgcy-0003Td-QH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gJgct-0004Jm-E8
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:17:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gJgct-0004GK-0p
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:17:15 -0500
References: <20181003114454.5662-1-marcandre.lureau@redhat.com>
	<20181003114454.5662-4-marcandre.lureau@redhat.com>
	<f4e920ad-e51a-6783-0522-6ed5f0351ca0@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <34ec2775-bd4e-e7ee-db25-26973f2412b2@redhat.com>
Date: Mon, 5 Nov 2018 16:17:09 +0100
MIME-Version: 1.0
In-Reply-To: <f4e920ad-e51a-6783-0522-6ed5f0351ca0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] memory-mapping: skip non-volatile
 memory regions in GuestPhysBlockList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 10/29/18 10:50, Paolo Bonzini wrote:
> On 03/10/2018 13:44, Marc-Andr=C3=A9 Lureau wrote:
>> diff --git a/memory_mapping.c b/memory_mapping.c
>> index 775466f3a8..724dd0b417 100644
>> --- a/memory_mapping.c
>> +++ b/memory_mapping.c
>> @@ -206,7 +206,8 @@ static void guest_phys_blocks_region_add(MemoryLis=
tener *listener,
>> =20
>>      /* we only care about RAM */
>>      if (!memory_region_is_ram(section->mr) ||
>> -        memory_region_is_ram_device(section->mr)) {
>> +        memory_region_is_ram_device(section->mr) ||
>> +        memory_region_is_nonvolatile(section->mr)) {
>>          return;
>>      }
>> =20
>=20
> We should also have
>=20
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> index 5a857cebcf..dd180b531c 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -417,7 +417,9 @@ def get_guest_phys_blocks():
>          memory_region =3D flat_range["mr"].dereference()
>=20
>          # we only care about RAM
> -        if not memory_region["ram"]:
> +        if not memory_region["ram"] \
> +           or memory_region["ram_device"] \
> +           or memory_region["nonvolatile"]:
>              continue
>=20
>          section_size =3D int128_get64(flat_range["addr"]["size"])
>=20
> here.  I queued the patches and will post this soon as a separate patch=
.

Thanks. I keep forgetting that this logic is duplicated.

Laszlo
