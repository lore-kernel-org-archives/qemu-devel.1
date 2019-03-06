Received: from eggs.gnu.org ([209.51.188.92]:52310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Y2l-0007Yf-Qw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Y2g-0003LH-6b
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:01:15 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-9-armbru@redhat.com>
	<71bfd7e6-abda-d26d-b3d3-e4c2ed9e98f8@redhat.com>
Date: Wed, 06 Mar 2019 16:00:51 +0100
In-Reply-To: <71bfd7e6-abda-d26d-b3d3-e4c2ed9e98f8@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Mar 2019 18:48:51
	+0100")
Message-ID: <8736o0vyho.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] r2d: Flash memory creation is
 confused about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, lersek@redhat.com, Magnus Damm <magnus.damm@gmail.com>, mreitz@redhat.com, qemu-ppc@nongnu.org, alex.bennee@linaro.org

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/26/19 8:34 PM, Markus Armbruster wrote:
>> pflash_cfi02_register() takes a size in bytes, a block size in bytes
>> and a number of blocks.  r2d_init() passes FLASH_SIZE, 16 * KiB,
>> FLASH_SIZE >> 16.  Does not compute: size doesn't match block size *
>> number of blocks.  The latter happens to win.  I tried to find
>> documentation on the physical hardware, no luck.
>>=20
>> For now, adjust the byte size passed to match the actual size created,
>> and add a FIXME comment.
>>=20
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/sh4/r2d.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
>> index dcdb3728cb..ed18d1f351 100644
>> --- a/hw/sh4/r2d.c
>> +++ b/hw/sh4/r2d.c
>> @@ -290,7 +290,14 @@ static void r2d_init(MachineState *machine)
>>=20=20
>>      /* onboard flash memory */
>>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
>> -    pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
>> +    /*
>> +     * FIXME The code is confused about the size of the flash.  It
>> +     * used to pass FLASH_SIZE bytes, in FLASH_SIZE >> 16 blocks of
>> +     * 16KiB each, which does not compute, but creates one of
>> +     * FLASH_SIZE / 4 bytes anyway.  The current code does so too, but
>> +     * whether it's the right size is anybody's guess.
>> +     */
>> +    pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE / 4,
>
> NAck, please see suggestion on v1:
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg01206.html

I'll use that to replace this patch in v3.  Thanks!

[...]
