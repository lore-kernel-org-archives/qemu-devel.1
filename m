Received: from eggs.gnu.org ([2001:4830:134:3::10]:56194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBG4B-00021q-Ru
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBG47-00005l-Qt
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:46:19 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBG47-00005R-JM
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:46:15 -0400
Received: by mail-wr0-x244.google.com with SMTP id v60-v6so52468388wrc.7
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 01:46:15 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-22-alex.bennee@linaro.org>
	<118ab4fa-b0a1-ba50-0ee6-035431b889c7@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <118ab4fa-b0a1-ba50-0ee6-035431b889c7@redhat.com>
Date: Wed, 25 Apr 2018 09:46:13 +0100
Message-ID: <87h8nzllm2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 21/46] tests/tcg/i386: fix
 test-i386-fprem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Thomas Huth <thuth@redhat.com> writes:

> On 24.04.2018 17:23, Alex Benn=C3=A9e wrote:
>> Remove dependencies on QEMU's source tree and build directly.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/i386/test-i386-fprem.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/tcg/i386/test-i386-fprem.c b/tests/tcg/i386/test-i386=
-fprem.c
>> index 1a71623204..66f5a9657d 100644
>> --- a/tests/tcg/i386/test-i386-fprem.c
>> +++ b/tests/tcg/i386/test-i386-fprem.c
>> @@ -23,7 +23,10 @@
>>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
>>   */
>>
>> -#include "qemu/osdep.h"
>> +#include <stdio.h>
>> +#include <stdint.h>
>> +
>> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>>
>>  /*
>>   * Inspired by <ieee754.h>'s union ieee854_long_double, but with single
>> @@ -39,7 +42,7 @@ union float80u {
>>          unsigned int exponent:15;
>>          unsigned int negative:1;
>>          unsigned int empty:16;
>> -    } QEMU_PACKED ieee;
>> +    } __attribute__((packed)) ieee;
>>
>>      /* This is for NaNs in the IEEE 854 double-extended-precision forma=
t.  */
>>      struct {
>> @@ -49,7 +52,7 @@ union float80u {
>>          unsigned int exponent:15;
>>          unsigned int negative:1;
>>          unsigned int empty:16;
>> -    } QEMU_PACKED ieee_nan;
>> +    } __attribute__((packed)) ieee_nan;
>>  };
>>
>>  #define IEEE854_LONG_DOUBLE_BIAS 0x3fff
>> @@ -229,6 +232,7 @@ static void test_fprem_cases(void)
>>      do_fprem_stack_underflow();
>>
>>      printf("=3D invalid operation =3D\n");
>> +    do_fprem(q_nan.d, 1.0);
>>      do_fprem(s_nan.d, 1.0);
>>      do_fprem(1.0, 0.0);
>>      do_fprem(pos_inf.d, 1.0);
>> @@ -238,6 +242,8 @@ static void test_fprem_cases(void)
>>      do_fprem(pos_denorm.d, 1.0);
>>      do_fprem(1.0, pos_denorm.d);
>>
>> +    do_fprem(smallest_positive_norm.d, smallest_positive_norm.d);
>
> How's that change related to the patch description? ... i.e. maybe you
> should mention these changes in the patch description, too?

Yeah I'll fix that up - they got added to stop the compiler bithing
about un-used things.

>
> Apart from that:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>


--
Alex Benn=C3=A9e
