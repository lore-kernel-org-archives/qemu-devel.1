Received: from eggs.gnu.org ([2001:4830:134:3::10]:55507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g8Dyz-0001uJ-VG
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 20:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g8Dyw-0003UI-Ri
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 20:28:41 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1g8Dyw-0003SH-IQ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 20:28:38 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20180928142533.8451-1-peter.maydell@linaro.org>
	<52177933-047f-d99b-e7d7-2a85e4c8d59c@vivier.eu>
Message-ID: <eee0054a-4d73-53a2-ca52-dbce4f1996e5@vivier.eu>
Date: Fri, 5 Oct 2018 02:28:25 +0200
MIME-Version: 1.0
In-Reply-To: <52177933-047f-d99b-e7d7-2a85e4c8d59c@vivier.eu>
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, patches@linaro.org

On 04/10/2018 18:55, Laurent Vivier wrote:
> Le 28/09/2018 à 16:25, Peter Maydell a écrit :
>> Our __get_user_e() and __put_user_e() macros cause newer versions
>> of clang to generate false-positive -Waddress-of-packed-member
>> warnings if they are passed the address of a member of a packed
>> struct (see https://bugs.llvm.org/show_bug.cgi?id=39113).
>> Suppress these using the _Pragma() operator.
>>
>> To put in the pragmas we need to convert the macros from
>> expressions to statements, but all the callsites effectively
>> treat them as statements already so this is OK.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  linux-user/qemu.h | 57 +++++++++++++++++++++++++++++++----------------
>>  1 file changed, 38 insertions(+), 19 deletions(-)
>>
> 
> Applied to my linux-user branch.

I have the following error when building on Fedora 28 and gcc (GCC)
8.1.1 20180712 (Red Hat 8.1.1-5)

  CC      aarch64_be-linux-user/target/arm/arm-semi.o
.../target/arm/arm-semi.c: In function ‘do_arm_semihosting’:
.../target/arm/arm-semi.c:270:1: error: unknown option after ‘#pragma
GCC diagnostic’ kind [-Werror=pragmas]

Perhaps you should use a "#if defined(__clang__)" to apply your fix only
to clang?

Thanks,
Laurent
