Received: from eggs.gnu.org ([2001:4830:134:3::10]:40651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1coYE3-0003Rm-GU
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1coYDz-0001CE-Fm
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:26:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1coYDz-00018O-17
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:26:03 -0400
References: <1489638621-31978-1-git-send-email-rimjhim0107@gmail.com>
	<874lytpgvh.fsf@linaro.org>
From: Wei Huang <wei@redhat.com>
Message-ID: <6c9e3f36-5791-d3d8-10bf-0161c7645ef4@redhat.com>
Date: Thu, 16 Mar 2017 11:25:54 -0500
MIME-Version: 1.0
In-Reply-To: <874lytpgvh.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] puv3: always compile-check debug printf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Anishka0107 <rimjhim0107@gmail.com>
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com



On 03/16/2017 07:04 AM, Alex Benn=C3=A9e wrote:
>=20
> Anishka0107 <rimjhim0107@gmail.com> writes:
>=20
>>     To prevent bitrot of the format string of the debug statement, fil=
es with
>>   conditional debug statements should ensure that printf is compiled a=
lways,
>>   and enclosed within if(0) statements and not in #ifdef.
>>
>> Signed-off-by: Anishka Gupta <rimjhim0107@gmail.com>
>> ---
>>  include/hw/unicore32/puv3.h | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
>> index 5a4839f..e268484 100644
>> --- a/include/hw/unicore32/puv3.h
>> +++ b/include/hw/unicore32/puv3.h
>> @@ -41,10 +41,14 @@
>>  #define PUV3_IRQS_OST0          (26)
>>
>>  /* All puv3_*.c use DPRINTF for debug. */
>> -#ifdef DEBUG_PUV3
>> -#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS_=
_)
>> -#else
>> -#define DPRINTF(fmt, ...) do {} while (0)
>> -#endif
>> +#define DEBUG_PUV3 0
>> +
>> +#define DPRINTF(fmt, ...)
>> +    if (DEBUG_PUV3) {
>> +        fprintf(stderr, "%s: " fmt , __func__, ## __VA_ARGS__)
>> +    }
>> +    else {
>> +        do {} while (0)
>> +    }
>=20
> This is incorrect. It's fine not to have an else leg as the compiler
> will dead-code away the if (0) part. However you still need to wrap in =
a
> do {} while to avoid problems with trailing ;'s. Also you need line
> continuations for defining macros.
>=20
> Did you actually compile test this patch? I suspect it wouldn't build
> due to the missing ;s for your fprintf and do while.

On top of what Alex pointed out, I think "PATCH v2" you posted is a fix
to this one. You should always post a complete patch for review.

If you compile QEMU with DEBUG_PUV3 enabled, you will notice compilation
errors in hw/dma/puv3_dma.c. Maybe you can fix them altogether.

qemu-upstream.git/include/hw/unicore32/puv3.h:46:34: error: format =E2=80=
=98%x=E2=80=99
expects argument of type =E2=80=98unsigned int=E2=80=99, but argument 3 h=
as type =E2=80=98hwaddr
{aka long unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
 #define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
                                  ^
hw/dma/puv3_dma.c:47:5: note: in expansion of macro =E2=80=98DPRINTF=E2=80=
=99
     DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
     ^~~~~~~


>=20
> See hw/misc/imx6_src.c for a debug printf I recently converted.
>=20
>>
>>  #endif /* QEMU_HW_PUV3_H */
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
