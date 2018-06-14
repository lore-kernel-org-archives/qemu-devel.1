Received: from eggs.gnu.org ([2001:4830:134:3::10]:45360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTQLp-0006Ka-LD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 07:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTQLm-0004GG-Ff
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 07:23:37 -0400
References: <1528966108-28324-1-git-send-email-thuth@redhat.com>
	<5b07c617-318d-53d5-46ee-8e4f3646cd79@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b995f060-6075-ca56-1fca-3e0091b02a83@redhat.com>
Date: Thu, 14 Jun 2018 13:23:31 +0200
MIME-Version: 1.0
In-Reply-To: <5b07c617-318d-53d5-46ee-8e4f3646cd79@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] pc-bios/s390-ccw: Optimize
 the s390-ccw bios for size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 14.06.2018 12:55, Christian Borntraeger wrote:
>=20
> On 06/14/2018 10:48 AM, Thomas Huth wrote:
>> Since we're storing the firmware blobs in the QEMU git repository, it
>> would be nice if the blobs would be a little bit smaller. By using -Os
>> and -fno-asynchronous-unwind-tables the size of the s390-ccw.img can b=
e
>> decreased by ca. 4kB, and the size of s390-netboot.img even by ca. 45k=
B.
>> The change of speed of the firmware should not really matter compared =
to
>> a binary that has been compiled with -O2 since the firmware still star=
ts
>> very fast.
>=20
>=20
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  pc-bios/s390-ccw/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 439e3cc..f22a5ca 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -13,6 +13,7 @@ OBJECTS =3D start.o main.o bootmap.o jump2ipl.o sclp=
.o menu.o \
>>  	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o
>> =20
>>  QEMU_CFLAGS :=3D $(filter -W%, $(QEMU_CFLAGS))
>> +QEMU_CFLAGS +=3D -Os -fno-asynchronous-unwind-tables
>=20
> Hmm, it looks like that the O2 comes after Os for me (which would overr=
ide Os).
>=20
> cc -iquote /home/cborntra/REPOS/qemu/build/. -iquote . -iquote /home/cb=
orntra/REPOS/qemu/tcg -iquote /home/cborntra/REPOS/qemu/tcg/s390 -I/home/=
cborntra/REPOS/qemu/linux-headers -I/home/cborntra/REPOS/qemu/build/linux=
-headers -iquote . -iquote /home/cborntra/REPOS/qemu -iquote /home/cbornt=
ra/REPOS/qemu/accel/tcg -iquote /home/cborntra/REPOS/qemu/include -Werror=
 -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmi=
ssing-prototypes -Wexpansion-to-defined -Wendif-labels -Wno-shift-negativ=
e-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-=
security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declar=
ation -Wold-style-definition -Wtype-limits -Os -fno-asynchronous-unwind-t=
ables -ffreestanding -fno-delete-null-pointer-checks -msoft-float -march=3D=
z900 -fPIE -fno-strict-aliasing   -fno-stack-protector -MMD -MP -MT libc.=
o -MF ./libc.d -O2 -g  -c -o libc.o /home/cborntra/REPOS/qemu/pc-bios/s39=
0-ccw/libc.c
>=20
> so the effect is only because of the -fno-asynchronous-unwind-tables.

Ugh, you're right - at least for the objects for s390-ccw.img. Seems
like the -O2 comes from "CFLAGS" and not from "QEMU_CFLAGS" here, so the
flags should be added to the CFLAGS variable instead.

Actually, I was only looking at the object files from s390-netboot.img,
and the libc files from SLOF get *only* compiled with QEMU_CFLAGS there
(see LIBC_CFLAGS in netboot.mak). So the huge part of the
s390-netboot.img binary got compiled without optimizations so far!
That's why I was seeing such a big improvement there! Wow, I wonder why
we did not notice this before... Anyway, I'll send a v2 to fix these issu=
es.

 Thomas
