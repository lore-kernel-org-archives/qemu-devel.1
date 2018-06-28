Received: from eggs.gnu.org ([2001:4830:134:3::10]:48166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYfnJ-0000zf-HW
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYfnG-0003LF-Fx
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:53:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-2-f4bug@amsat.org>
	<20180627132747.76773eb9@redhat.com>
	<3dd9341a-f4e6-c107-2f1f-0745d039f03e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <15aad1db-2f4c-ea49-9966-a969f0c769f5@amsat.org>
Date: Thu, 28 Jun 2018 19:53:31 -0300
MIME-Version: 1.0
In-Reply-To: <3dd9341a-f4e6-c107-2f1f-0745d039f03e@redhat.com>
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

On 06/27/2018 09:26 AM, Eric Blake wrote:
> On 06/27/2018 06:27 AM, Igor Mammedov wrote:
>> On Mon, 25 Jun 2018 09:41:53 -0300
>> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>>> Loosely based on 076b35b5a56.
>>>
>>> Suggested-by: Stefan Weil <sw@weilnetz.de>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
> 
>>> +#ifndef QEMU_UNITS_H
>>> +#define QEMU_UNITS_H
>>> +
>>> +#define KiB     (INT64_C(1) << 10)
>>> +#define MiB     (INT64_C(1) << 20)
>>> +#define GiB     (INT64_C(1) << 30)
>>> +#define TiB     (INT64_C(1) << 40)
>>> +#define PiB     (INT64_C(1) << 50)
>>> +#define EiB     (INT64_C(1) << 60)
>> Shouldn't above use UINT64_C()
> 
> Since the decision of signed vs. unsigned was intentional based on
> review on earlier versions, it may be worth a comment in this file that
> these constants are intentionally signed (in usage patterns, these tend
> to be multiplied by another value; and while it is easy to go to
> unsigned by doing '1U * KiB', you can't go in the opposite direction if
> you want a signed number for '1 * KiB' unless KiB is signed).

OK.

I'll also change this tests using your suggestion:

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
@@ -709,8 +709,7 @@ static void test_opts_parse_size(void)
                            false, &error_abort);
-    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0),
-                     ==, 16777215 * T_BYTE);
+    g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 16777215U
* TiB);

to avoid this error on 32-bit archs:

source/qemu/tests/test-qemu-opts.c: In function 'test_opts_parse_size':
source/qemu/tests/test-qemu-opts.c:713:71: error: integer overflow in
expression [-Werror=overflow]
  g_assert_cmphex(qemu_opt_get_size(opts, "size2", 0), ==, 16777215 * TiB);
                                                                       ^
