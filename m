Received: from eggs.gnu.org ([2001:4830:134:3::10]:34195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dumcd-0002g9-Hp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dumca-0002Va-E0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:33:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dumca-0002VH-5f
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:33:28 -0400
References: <20170920194144.20101-1-jsnow@redhat.com>
	<f6ec49d1-2e23-ebcb-7ace-8fe52348138e@ilande.co.uk>
From: John Snow <jsnow@redhat.com>
Message-ID: <dedbcfd6-52b6-333c-0b14-8ae12cd9eb7c@redhat.com>
Date: Wed, 20 Sep 2017 17:33:26 -0400
MIME-Version: 1.0
In-Reply-To: <f6ec49d1-2e23-ebcb-7ace-8fe52348138e@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ide: fix enum comparison for gcc 4.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org



On 09/20/2017 05:28 PM, Mark Cave-Ayland wrote:
> On 20/09/17 20:41, John Snow wrote:
>=20
>> Apparently GCC gets bent over comparing enum values against zero.
>> Replace the conditional with something less readable.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  hw/ide/core.c             | 2 +-
>>  include/hw/ide/internal.h | 3 +--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index a19bd90..d63eb4a 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -68,7 +68,7 @@ const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT] =3D {
>> =20
>>  static const char *IDE_DMA_CMD_str(enum ide_dma_cmd enval)
>>  {
>> -    if (enval >=3D IDE_DMA__BEGIN && enval < IDE_DMA__COUNT) {
>> +    if ((unsigned)enval < IDE_DMA__COUNT) {
>>          return IDE_DMA_CMD_lookup[enval];
>>      }
>>      return "DMA UNKNOWN CMD";
>> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
>> index 180e00e..e641012 100644
>> --- a/include/hw/ide/internal.h
>> +++ b/include/hw/ide/internal.h
>> @@ -333,8 +333,7 @@ struct unreported_events {
>>  };
>> =20
>>  enum ide_dma_cmd {
>> -    IDE_DMA__BEGIN =3D 0,
>> -    IDE_DMA_READ =3D IDE_DMA__BEGIN,
>> +    IDE_DMA_READ =3D 0,
>>      IDE_DMA_WRITE,
>>      IDE_DMA_TRIM,
>>      IDE_DMA_ATAPI,
>>
>=20
> Really close - it fixes the error in hw/ide/core.c but then I see a
> similar error a bit later in hw/ide/ahci.c:
>=20
> cc -I/home/build/src/qemu/git/qemu/hw/ide -Ihw/ide
> -I/home/build/src/qemu/git/qemu/tcg
> -I/home/build/src/qemu/git/qemu/tcg/i386
> -I/home/build/src/qemu/git/qemu/linux-headers
> -I/home/build/src/qemu/git/qemu/linux-headers -I.
> -I/home/build/src/qemu/git/qemu
> -I/home/build/src/qemu/git/qemu/accel/tcg
> -I/home/build/src/qemu/git/qemu/include -I/usr/include/pixman-1
> -I/home/build/src/qemu/git/qemu/dtc/libfdt -Werror -pthread
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
> -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -fstack-protector-all -I/usr/include/p11-kit-1
> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD -M=
P
> -MT hw/ide/ahci.o -MF hw/ide/ahci.d -O2 -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=3D2 -g   -c -o hw/ide/ahci.o hw/ide/ahci.c
> hw/ide/ahci.c: In function =E2=80=98ahci_trigger_irq=E2=80=99:
> hw/ide/ahci.c:187:5: error: comparison of unsigned expression >=3D 0 is
> always true [-Werror=3Dtype-limits]
> cc1: all warnings being treated as errors
> make: *** [hw/ide/ahci.o] Error 1
>=20
>=20
> ATB,
>=20
> Mark.
>=20

Man, what's with your compiler? ...

OK, let's try:

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 24c65df..32d1296 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -184,7 +184,7 @@ static void ahci_check_irq(AHCIState *s)
 static void ahci_trigger_irq(AHCIState *s, AHCIDevice *d,
                              enum AHCIPortIRQ irqbit)
 {
-    g_assert(irqbit >=3D 0 && irqbit < 32);
+    g_assert((unsigned)irqbit < 32);
     uint32_t irq =3D 1U << irqbit;
     uint32_t irqstat =3D d->port_regs.irq_stat | irq;


I can't remember immediately if I have more spots that might cause a
ruckus for you.
