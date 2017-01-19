Received: from eggs.gnu.org ([2001:4830:134:3::10]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUASL-0001W3-HS
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUASK-0000yC-Hq
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:00:37 -0500
Received: from mail-vk0-x235.google.com ([2607:f8b0:400c:c05::235]:36604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUASK-0000xz-7k
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:00:36 -0500
Received: by mail-vk0-x235.google.com with SMTP id t8so26855807vke.3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 03:00:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lgu7ihps.fsf@dusky.pond.sub.org>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-5-git-send-email-mst@redhat.com>
	<87lgu7ihps.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 11:00:15 +0000
Message-ID: <CAFEAcA-ObxzuLmeb3cDbTt_AVP-aV61_nZ86-jwOTcSEvK_MWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 4/4] ARRAY_SIZE: check that argument is
 an array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Sergey Fedorov <serge.fdrv@gmail.com>

On 19 January 2017 at 08:20, Markus Armbruster <armbru@redhat.com> wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> It's a familiar pattern: some code uses ARRAY_SIZE, then refactoring
>> changes the argument from an array to a pointer to a dynamically
>> allocated buffer.  Code keeps compiling but any ARRAY_SIZE calls now
>> return the size of the pointer divided by element size.
>>
>> Let's add build time checks to ARRAY_SIZE before we allow more
>> of these in the code-base.
>
> Yes, please!
>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  include/qemu/osdep.h | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 689f253..24bfda0 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -199,7 +199,13 @@ extern int daemon(int, int);
>>  #endif
>>
>>  #ifndef ARRAY_SIZE
>> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>> +/*
>> + * &(x)[0] is always a pointer - if it's same type as x then the argument is a
>> + * pointer, not an array as expected.
>> + */
>> +#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + QEMU_BUILD_BUG_ON_ZERO( \
>> +                        __builtin_types_compatible_p(typeof(x), \
>> +                                                     typeof(&(x)[0]))))
>
> Please break the line near the operator, not within one of its operands:
>
>    #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0]))                  \
>                           + QEMU_BUILD_BUG_ON_ZERO(                     \
>                                __builtin_types_compatible_p(typeof(x),  \
>                                                             typeof(&(x)[0]))))


The other possible approach to the long-lines issue would be to do what
the Linux kernel does and abstract out a MUST_BE_ARRAY() macro.

thanks
-- PMM
