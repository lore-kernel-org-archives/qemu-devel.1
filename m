Received: from eggs.gnu.org ([2001:4830:134:3::10]:52064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g8Mel-00071v-NF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g8Med-0001oK-SC
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:44:22 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36787)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1g8MeY-0001bj-E7
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:44:12 -0400
References: <20180928142533.8451-1-peter.maydell@linaro.org>
	<52177933-047f-d99b-e7d7-2a85e4c8d59c@vivier.eu>
	<eee0054a-4d73-53a2-ca52-dbce4f1996e5@vivier.eu>
	<CAFEAcA_3o3FSScwUcrDX2aFoj-RvNjo=F_Em2HaP=pK5o4=Bng@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9a8ab9d1-8f09-c82e-165b-b585ef244a6e@vivier.eu>
Date: Fri, 5 Oct 2018 11:43:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3o3FSScwUcrDX2aFoj-RvNjo=F_Em2HaP=pK5o4=Bng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Suppress
 address-of-packed-member warnings in __get/put_user_e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 05/10/2018 11:10, Peter Maydell wrote:
> On 5 October 2018 at 01:28, Laurent Vivier <laurent@vivier.eu> wrote:
>> I have the following error when building on Fedora 28 and gcc (GCC)
>> 8.1.1 20180712 (Red Hat 8.1.1-5)
>>
>>   CC      aarch64_be-linux-user/target/arm/arm-semi.o
>> .../target/arm/arm-semi.c: In function ‘do_arm_semihosting’:
>> .../target/arm/arm-semi.c:270:1: error: unknown option after ‘#pragma
>> GCC diagnostic’ kind [-Werror=pragmas]
>>
>> Perhaps you should use a "#if defined(__clang__)" to apply your fix only
>> to clang?
> 
> I did test on gcc, but not that version. The point of the
>    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");
> line is to suppress that error (which it does on my gcc 5)
> so I don't know why your gcc is complaining :-(

You should add Fedora 28 to you collection of virtual machines :)

> 
> If you add an extra diagnostic push, so:
> 
> +        _Pragma("GCC diagnostic push");                                     \
> +        _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
> +        _Pragma("GCC diagnostic push");                                     \
> +        _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"");   \
> 
> and then a balancing extra
> 
> +        _Pragma("GCC diagnostic pop");                                      \
> 
> at the end, I don't suppose that helps?

No, it doesn't help

> (I generally prefer to avoid marking things as clang- or gcc-
> specific where I can.)

I understand.
But it's a clang bug, it seems reasonable to have specific code to
workaround it.

Thanks,
Laurent
