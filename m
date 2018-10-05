Received: from eggs.gnu.org ([2001:4830:134:3::10]:36902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g8Sg6-0002Ew-MB
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g8Sfz-00024e-Jm
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:10:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40577)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1g8Sfv-0001wH-Q9
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:10:01 -0400
References: <20180928142533.8451-1-peter.maydell@linaro.org>
	<52177933-047f-d99b-e7d7-2a85e4c8d59c@vivier.eu>
	<eee0054a-4d73-53a2-ca52-dbce4f1996e5@vivier.eu>
	<CAFEAcA_3o3FSScwUcrDX2aFoj-RvNjo=F_Em2HaP=pK5o4=Bng@mail.gmail.com>
	<2998097f-bb40-409c-16aa-f8bef811444c@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1947e824-2aec-1d93-3b96-f472a7a88611@vivier.eu>
Date: Fri, 5 Oct 2018 18:09:08 +0200
MIME-Version: 1.0
In-Reply-To: <2998097f-bb40-409c-16aa-f8bef811444c@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, "patches@linaro.org" <patches@linaro.org>

On 05/10/2018 17:25, Richard Henderson wrote:
> On 10/5/18 4:10 AM, Peter Maydell wrote:
>> On 5 October 2018 at 01:28, Laurent Vivier <laurent@vivier.eu> wrote:
>>> I have the following error when building on Fedora 28 and gcc (GCC)
>>> 8.1.1 20180712 (Red Hat 8.1.1-5)
>>>
>>>   CC      aarch64_be-linux-user/target/arm/arm-semi.o
>>> .../target/arm/arm-semi.c: In function ‘do_arm_semihosting’:
>>> .../target/arm/arm-semi.c:270:1: error: unknown option after ‘#pragma
>>> GCC diagnostic’ kind [-Werror=pragmas]
>>>
>>> Perhaps you should use a "#if defined(__clang__)" to apply your fix only
>>> to clang?
>>
>> I did test on gcc, but not that version. The point of the
>>    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");
>> line is to suppress that error (which it does on my gcc 5)
>> so I don't know why your gcc is complaining :-(
> 
> I suppose you could try -Wunknown-pragmas.
> But from reading the manual it shouldn't make a difference.
> OTOH, what you wrote should have worked...

Could it be a bug in _Pragma()?

If I use "#pragma" for the file, it works:

--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -474,10 +474,10 @@ static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
  *   an unknown warning type from older compilers that don't know about
  *   -Waddress-of-packed-member.
  */
+#pragma GCC diagnostic ignored "-Wpragmas"
 #define __put_user_e(x, hptr, e)                                            \
     do {                                                                    \
         _Pragma("GCC diagnostic push");                                     \
-        _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
         _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"");   \
         (__builtin_choose_expr(sizeof(*(hptr)) == 1, stb_p,                 \
         __builtin_choose_expr(sizeof(*(hptr)) == 2, stw_##e##_p,            \
@@ -490,7 +490,6 @@ static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
 #define __get_user_e(x, hptr, e)                                            \
     do {                                                                    \
         _Pragma("GCC diagnostic push");                                     \
-        _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
         _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"");   \
         ((x) = (typeof(*hptr))(                                             \
         __builtin_choose_expr(sizeof(*(hptr)) == 1, ldub_p,                 \
