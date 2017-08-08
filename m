Received: from eggs.gnu.org ([2001:4830:134:3::10]:39130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1deww8-0008KP-Qv
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 01:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1deww3-0005Gl-O4
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 01:20:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1deww3-0005EM-EZ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 01:20:07 -0400
References: <1501767019-4989-1-git-send-email-thuth@redhat.com>
	<20170807232833-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <016df631-ccf8-69bd-0211-becbecac4450@redhat.com>
Date: Tue, 8 Aug 2017 07:19:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170807232833-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/pxe: Check virtio-net-ccw on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Victor Kaplansky <victork@redhat.com>

On 07.08.2017 22:35, Michael S. Tsirkin wrote:
> On Thu, Aug 03, 2017 at 03:30:19PM +0200, Thomas Huth wrote:
>> Now that we've got a firmware that can do TFTP booting on s390x (i.e.
>> the pc-bios/s390-netboot.img), we can enable the PXE tester for this
>> architecture, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Since this only adds a test, I guess this could still be included
>>  for 2.10 ... otherwise, I think it's also OK to simply postpone this
>>  to 2.11 instead
>=20
> I think 2.11 is preferable.
>=20
>>  tests/Makefile.include |  1 +
>>  tests/boot-sector.c    | 25 ++++++++++++++++++++++---
>>  tests/pxe-test.c       |  7 +++++++
>>  3 files changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 59e536b..f9af5e3 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -337,6 +337,7 @@ check-qtest-microblazeel-y =3D $(check-qtest-micro=
blaze-y)
>>  check-qtest-xtensaeb-y =3D $(check-qtest-xtensa-y)
>> =20
>>  check-qtest-s390x-y =3D tests/boot-serial-test$(EXESUF)
>> +check-qtest-s390x-y +=3D tests/pxe-test$(EXESUF)
>> =20
>>  check-qtest-generic-y +=3D tests/qom-test$(EXESUF)
>>  check-qtest-generic-y +=3D tests/test-hmp$(EXESUF)
>> diff --git a/tests/boot-sector.c b/tests/boot-sector.c
>> index e3880f4..87a8fb5 100644
>> --- a/tests/boot-sector.c
>> +++ b/tests/boot-sector.c
>> @@ -21,6 +21,7 @@
>>  #define SIGNATURE 0xdead
>>  #define SIGNATURE_OFFSET 0x10
>>  #define BOOT_SECTOR_ADDRESS 0x7c00
>> +#define SIGNATURE_ADDR (BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET)
>> =20
>>  /* Boot sector code: write SIGNATURE into memory,
>>   * then halt.
>> @@ -73,6 +74,7 @@ int boot_sector_init(char *fname)
>>  {
>>      int fd, ret;
>>      size_t len =3D sizeof boot_sector;
>> +    const char *arch =3D qtest_get_arch();
>> =20
>>      fd =3D mkstemp(fname);
>>      if (fd < 0) {
>> @@ -81,10 +83,27 @@ int boot_sector_init(char *fname)
>>      }
>> =20
>>      /* For Open Firmware based system, we can use a Forth script inst=
ead */
>> -    if (strcmp(qtest_get_arch(), "ppc64") =3D=3D 0) {
>> +    if (g_str_equal(arch, "ppc64")) {
>>          len =3D sprintf((char *)boot_sector, "\\ Bootscript\n%x %x c!=
 %x %x c!\n",
>> -                LOW(SIGNATURE), BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSE=
T,
>> -                HIGH(SIGNATURE), BOOT_SECTOR_ADDRESS + SIGNATURE_OFFS=
ET + 1);
>> +                LOW(SIGNATURE), SIGNATURE_ADDR,
>> +                HIGH(SIGNATURE), SIGNATURE_ADDR + 1);
>> +    } else if (g_str_equal(arch, "s390x")) {
>> +        /* For s390x, fake a kernel signature */
>> +        const uint8_t psw[] =3D {
>> +            0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00
>> +        };
>> +        const uint8_t code[] =3D {
>> +            0xa7, 0xf4, 0x00, 0x0a,     /* j 0x10010 */
>> +            0x00, 0x00, 0x00, 0x00,
>> +            'S', '3', '9', '0',
>> +            'E', 'P', 0x00, 0x01,
>> +            0xa7, 0x38, HIGH(SIGNATURE_ADDR), LOW(SIGNATURE_ADDR), /*=
 lhi r3 */
>> +            0xa7, 0x48, LOW(SIGNATURE), HIGH(SIGNATURE),    /* lhi r4=
,0xadde */
>> +            0x40, 0x40, 0x30, 0x00,     /* sth r4,0(r3) */
>> +            0xa7, 0xf4, 0xff, 0xfa      /* j 0x10010 */
>> +        };
>> +        memcpy(boot_sector, psw, 8);
>> +        memcpy(&boot_sector[0x10000], code, sizeof(code));
>=20
>=20
> Could we avoid overwriting boot sector?
> We really should have
> x86_boot_sector
> ppc64_boot_sector
> s390_boot_sector
>=20
> And write out the correct thing.

Ok, I don't mind either way ... I can try to come up with a patch.

> Also:
>  * Q35 machine requires a minimum 0x7e000 bytes disk.
>  * (bug or feature?)
>=20
> probably does not apply to s390x, does it?

We can also just load 0x10000 + sizeof(code) bytes here. I'll fix it.

Cornelia, please unqueue the patch, I'll send a v2...

 Thomas
