Received: from eggs.gnu.org ([2001:4830:134:3::10]:57977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etnAh-0007uC-UB
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 23:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etnAd-0008Te-0z
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 23:28:51 -0500
References: <1520317081-5341-1-git-send-email-thuth@redhat.com>
	<383b6582-4953-4256-f4fa-abe0fe4a0e6b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <58365548-b4f1-a6fe-9533-c2239082b0fb@redhat.com>
Date: Thu, 8 Mar 2018 05:28:27 +0100
MIME-Version: 1.0
In-Reply-To: <383b6582-4953-4256-f4fa-abe0fe4a0e6b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] pc-bios/s390-ccw: Move string arrays
 from bootmap header to .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 08.03.2018 00:11, Eric Blake wrote:
> On 03/06/2018 12:18 AM, Thomas Huth wrote:
>> bootmap.h can currently only be included once - otherwise the linker
>> complains about multiple definitions of the "magic" strings.
>=20
> My first thought when reading that was "Huh? bootmap.h has a proper[*]
> double-inclusion header guard, and therefore a second #include
> "bootmap.h" is a no-op - so how can including the header more than once
> cause a linker complaint?"

Sorry if the description was not precise enough ... but I think it's
clear if you think about it twice ;-)

> [*] Well, proper if you overlook the fact that the name
> _PC_BIOS_S390_CCW_BOOTMAP_H starts with a leading underscore followed b=
y
> uppercase, and is therefore violating namespace safety rules, as it
> could collide with a symbol reserved for the implementation

Yeah, we've got a couple of these left. I recently added a task to the
BiteSizedTasks page to clean those up.

> Your change is fine (moving the declaration into the one .c file that
> needs them), so no need to change this, but...
>=20
>> +++ b/pc-bios/s390-ccw/bootmap.h
>> @@ -375,9 +375,6 @@ static inline void read_iso_boot_image(uint32_t
>> block_offset, void *load_addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read boot image!");
>> =C2=A0 }
>> =C2=A0 -const uint8_t el_torito_magic[] =3D "EL TORITO SPECIFICATION"
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0";
>=20
> ...would adding 'static' here also solved the linker error (at the risk
> of possibly causing a compiler warning/error about unused variable)?

Yes, we would likely get a warning about unused variable instead, so
that's not a real option.

 Thomas
