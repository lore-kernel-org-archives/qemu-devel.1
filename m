Received: from eggs.gnu.org ([2001:4830:134:3::10]:45919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRy3N-00081L-Ti
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRy3J-0000cd-Nl
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:30:49 -0500
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<ce619ddd11a875caae4c221c18ebf7c6a6f4bd4f.1529398335.git.balaton@eik.bme.hu>
	<0bb0d399-bec9-f653-5d2c-3f9f72e42ee1@redhat.com>
	<alpine.BSF.2.21.9999.1811281207320.57349@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <69c0ab61-841c-963d-8b8f-d8588a9e8fd1@redhat.com>
Date: Wed, 28 Nov 2018 12:30:41 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1811281207320.57349@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/11] ppc4xx_i2c: Implement directcntl
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 2018-11-28 12:26, BALATON Zoltan wrote:
> On Wed, 28 Nov 2018, Thomas Huth wrote:
>> On 2018-06-19 10:52, BALATON Zoltan wrote:
>>> As well as being able to generate its own i2c transactions, the ppc4x=
x
>>> i2c controller has a DIRECTCNTL register which allows explicit contro=
l
>>> of the i2c lines.
>>>
>>> Using this register an OS can directly bitbang i2c operations. In
>>> order to let emulated i2c devices respond to this, we need to wire up
>>> the DIRECTCNTL register to qemu's bitbanged i2c handling code.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>> [...]
>>> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.=
h
>>> index e4b6ded..ea6c8e1 100644
>>> --- a/include/hw/i2c/ppc4xx_i2c.h
>>> +++ b/include/hw/i2c/ppc4xx_i2c.h
>>> @@ -31,6 +31,9 @@
>>> =C2=A0#include "hw/sysbus.h"
>>> =C2=A0#include "hw/i2c/i2c.h"
>>>
>>> +/* from hw/i2c/bitbang_i2c.h */
>>> +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
>>
>> This breaks compilation with clang 3.4:
>>
>> In file included from /home/thuth/devel/qemu/hw/i2c/ppc4xx_i2c.c:33:
>> hw/i2c/bitbang_i2c.h:6:38: error: redefinition of typedef
>> 'bitbang_i2c_interface'
>> =C2=A0=C2=A0=C2=A0=C2=A0 is a C11 feature [-Werror,-Wtypedef-redefinit=
ion]
>> typedef struct bitbang_i2c_interface bitbang_i2c_interface;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>> include/hw/i2c/ppc4xx_i2c.h:35:38: note: previous definition is here
>> typedef struct bitbang_i2c_interface bitbang_i2c_interface;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>> 1 error generated.
>> make[1]: *** [hw/i2c/ppc4xx_i2c.o] Error 1
>>
>> Not sure about the best way to fix this ... move the typedef to
>> include/qemu/typedefs.h maybe? Or include the "hw/i2c/bitbang_i2c.h"
>> header instead of "i2c.h" here?
>=20
> Not sure either but I could not include bitbang_i2c.h here because
> that's a private header in hw/i2c, whereas ppc4xx_i2c.h is a public
> header in include/hw/i2c. That's why it had to be duplicated here. I ha=
d
> it differently in first version but this was thought to be simpler way,
> see http://lists.nongnu.org/archive/html/qemu-ppc/2018-06/msg00374.html
>=20
> Maybe we could move this typedef to include/hw/i2c/i2c.h which both
> ppc4xx_i2c.h and bitbang_i2c.h include?

Fine for me, too. Do you have some spare time to create a patch?

 Thanks,
  Thomas
