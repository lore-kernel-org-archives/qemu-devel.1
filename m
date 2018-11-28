Received: from eggs.gnu.org ([2001:4830:134:3::10]:44460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gRxzV-0004su-Pa
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gRxzT-0006DV-4m
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:26:49 -0500
Date: Wed, 28 Nov 2018 12:26:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <0bb0d399-bec9-f653-5d2c-3f9f72e42ee1@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1811281207320.57349@zero.eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<ce619ddd11a875caae4c221c18ebf7c6a6f4bd4f.1529398335.git.balaton@eik.bme.hu>
	<0bb0d399-bec9-f653-5d2c-3f9f72e42ee1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 28 Nov 2018, Thomas Huth wrote:
> On 2018-06-19 10:52, BALATON Zoltan wrote:
>> As well as being able to generate its own i2c transactions, the ppc4xx
>> i2c controller has a DIRECTCNTL register which allows explicit control
>> of the i2c lines.
>>
>> Using this register an OS can directly bitbang i2c operations. In
>> order to let emulated i2c devices respond to this, we need to wire up
>> the DIRECTCNTL register to qemu's bitbanged i2c handling code.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
> [...]
>> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
>> index e4b6ded..ea6c8e1 100644
>> --- a/include/hw/i2c/ppc4xx_i2c.h
>> +++ b/include/hw/i2c/ppc4xx_i2c.h
>> @@ -31,6 +31,9 @@
>>  #include "hw/sysbus.h"
>>  #include "hw/i2c/i2c.h"
>>
>> +/* from hw/i2c/bitbang_i2c.h */
>> +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
>
> This breaks compilation with clang 3.4:
>
> In file included from /home/thuth/devel/qemu/hw/i2c/ppc4xx_i2c.c:33:
> hw/i2c/bitbang_i2c.h:6:38: error: redefinition of typedef
> 'bitbang_i2c_interface'
>      is a C11 feature [-Werror,-Wtypedef-redefinition]
> typedef struct bitbang_i2c_interface bitbang_i2c_interface;
>                                     ^
> include/hw/i2c/ppc4xx_i2c.h:35:38: note: previous definition is here
> typedef struct bitbang_i2c_interface bitbang_i2c_interface;
>                                     ^
> 1 error generated.
> make[1]: *** [hw/i2c/ppc4xx_i2c.o] Error 1
>
> Not sure about the best way to fix this ... move the typedef to
> include/qemu/typedefs.h maybe? Or include the "hw/i2c/bitbang_i2c.h"
> header instead of "i2c.h" here?

Not sure either but I could not include bitbang_i2c.h here because that's 
a private header in hw/i2c, whereas ppc4xx_i2c.h is a public header in 
include/hw/i2c. That's why it had to be duplicated here. I had it 
differently in first version but this was thought to be simpler way, see 
http://lists.nongnu.org/archive/html/qemu-ppc/2018-06/msg00374.html

Maybe we could move this typedef to include/hw/i2c/i2c.h which both 
ppc4xx_i2c.h and bitbang_i2c.h include?

Regards,
BALATON Zoltan
