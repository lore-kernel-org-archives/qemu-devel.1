Received: from eggs.gnu.org ([2001:4830:134:3::10]:60371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYuin-0003yb-Nr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYuii-0003It-Np
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:50:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-2-f4bug@amsat.org>
	<20180627132747.76773eb9@redhat.com>
	<3dd9341a-f4e6-c107-2f1f-0745d039f03e@redhat.com>
	<15aad1db-2f4c-ea49-9966-a969f0c769f5@amsat.org>
	<c1939f7b-76e2-eca9-2819-d0b4d9a134b1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0822da0f-1da2-bff3-e465-57654aad7c16@amsat.org>
Date: Fri, 29 Jun 2018 11:49:51 -0300
MIME-Version: 1.0
In-Reply-To: <c1939f7b-76e2-eca9-2819-d0b4d9a134b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 01/46] include: Add IEC binary prefixes
 in "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Hi Eric,

On 06/29/2018 09:19 AM, Eric Blake wrote:
> On 06/28/2018 05:53 PM, Philippe Mathieu-Daudé wrote:
> 
>>>>> +#ifndef QEMU_UNITS_H
>>>>> +#define QEMU_UNITS_H
>>>>> +
>>>>> +#define KiB     (INT64_C(1) << 10)
>>>>> +#define MiB     (INT64_C(1) << 20)
>>>>> +#define GiB     (INT64_C(1) << 30)
>>>>> +#define TiB     (INT64_C(1) << 40)
>>>>> +#define PiB     (INT64_C(1) << 50)
>>>>> +#define EiB     (INT64_C(1) << 60)
>>>> Shouldn't above use UINT64_C()
>>>
>>> Since the decision of signed vs. unsigned was intentional based on
>>> review on earlier versions, it may be worth a comment in this file that
>>> these constants are intentionally signed (in usage patterns, these tend
>>> to be multiplied by another value; and while it is easy to go to
>>> unsigned by doing '1U * KiB', you can't go in the opposite direction if
>>> you want a signed number for '1 * KiB' unless KiB is signed).
>>
>> OK.
> 
> Actually, '1U * KiB' still ends up signed.  Why? Because as written, KiB
> is a 64-bit quantity, but 1U is 32-bit; type promotion says that since a
> 64-bit int can represent all 32-bit unsigned values, the result of the
> expression is still signed 64-bit.

Are you suggesting this?

#define KiB     (INT32_C(1) << 10)
#define MiB     (INT32_C(1) << 20)
#define GiB     (INT32_C(1) << 30)

#define TiB     (INT64_C(1) << 40)
#define PiB     (INT64_C(1) << 50)
#define EiB     (INT64_C(1) << 60)

Now than I reread what Richard reviewed, I guess understand he suggested
the same change:
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg03284.html

> To get unsigned KiB, you either have to use '1ULL * KiB', or KiB should
> be changed to be (INT32_C(1) << 10) (a 32-bit constant, rather than a
> 64-bit one).
> 
>>
>> I'll also change this tests using your suggestion:
>>
>> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
>> @@ -709,8 +709,7 @@ static void test_opts_parse_size(void)
>>                              false, &error_abort);
>> -    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0),
>> -                     ==, 16777215 * T_BYTE);
>> +    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 16777215U
>> * TiB);
>>
>> to avoid this error on 32-bit archs:
>>
>> source/qemu/tests/test-qemu-opts.c: In function 'test_opts_parse_size':
>> source/qemu/tests/test-qemu-opts.c:713:71: error: integer overflow in
>> expression [-Werror=overflow]
>>    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 16777215 *
>> TiB);
>>                                                                         ^
> 
> And this compile error is proof of the confusion when we have a signed
> integer overflow (why it only happens on 32-bit arch and not also on
> 64-bit arch is subtle - it's because TiB is 'long long' on 32-bit, but
> merely 'long' on 64-bit, which results in a different type after type
> promotion - although I still find it odd that the 64-bit compiler isn't
> warning).
> 
