Received: from eggs.gnu.org ([2001:4830:134:3::10]:36639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dosZW-0000Yx-71
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dosZP-0006z9-Hj
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:41:54 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:35397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dosZP-0006yh-Cx
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:41:47 -0400
Received: by mail-qt0-x231.google.com with SMTP id k2so2741518qte.2
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 07:41:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
	<1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
	<941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
	<c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <047f9b63-2dcc-e8ba-90c1-965e253fcbf5@amsat.org>
Date: Mon, 4 Sep 2017 11:41:35 -0300
MIME-Version: 1.0
In-Reply-To: <c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org

On 09/04/2017 11:09 AM, Laurent Vivier wrote:
> Le 04/09/2017 à 15:54, Kamil Rytarowski a écrit :
>> On 04.09.2017 02:27, Philippe Mathieu-Daudé wrote:
>>> On 09/03/2017 02:05 PM, Laurent Vivier wrote:
>>>> Le 03/09/2017 à 18:31, Kamil Rytarowski a écrit :
>>>>> GCC 4.7.2 on SunOS reports that the values assigned to array members
>>>>> are not
>>>>> real constants:
>>>>>
>>>>> target/m68k/fpu_helper.c:32:5: error: initializer element is not
>>>>> constant
>>>>> target/m68k/fpu_helper.c:32:5: error: (near initialization for
>>>>> 'fpu_rom[0]')
>>>>> rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
>>>>>
>>>>> Convert the array to switch() to workaround the issue.
>>>>
>>>> I don't like the idea. It's really an array and should be managed as an
>>>> array.
>>>
>>> I agree with Laurent.
>>>
>>>>
>>>> Could you try to use make_floatx80_init() instead of make_floatx80() ?
>>>
>>> I guess the problem comes from the macro which cast as not const:
>>>
>>> #define make_floatx80(exp, mant) ((floatx80) { mant, exp })
>>>
>>
>> Adding const to make_floatx80 - ((const floatx80) { mant, exp }) - does
>> not fix the problem.
>>
>>> make_floatx80_init() doesn't cast so it might work,
>>> else we could add a macro such const_floatx80():
>>>
>>> #define const_floatx80(exp, mant) ((const floatx80) { mant, exp })
>>
>> Switching make_floatx80() to make_floatx80_init() in works.
>>
>> How about floatx80_zero, floatx80_one etc? We cannot translate them to
>> make_floatx80_init() as this breaks in other parts of the code in
>> functions like:
>>
>> void helper_fldpi_ST0(CPUX86State *env)
>> {
>>      ST0 = floatx80_pi;
>> }
>>
>> -- target/i386/fpu_helper.c
>>
> 
> You can:
> 
> either replace the "#define floatx80_pi make_floatx80(...)" by a "const
> floatx80 floatx80_pi = make_floatx80_init(...)"

this won't work with:

const floatx80 2pi = floatx80_mul(floatx80_pi, floatx80_pi, &s);

however this should work fine:

#define floatx80_pi make_floatx80_init(0x4000, 0xc90fdaa22168c235LL)

> 
> or replace all the macros in the m68k/fpu_helper.c array by
> make_floatx80_init(...)
> 
> Thanks,
> Laurent
> 
