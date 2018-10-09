Received: from eggs.gnu.org ([2001:4830:134:3::10]:58895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9qfh-0005FS-AW
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9qff-0008Oe-Ip
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:59:29 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9qfe-0008N1-JP
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:59:27 -0400
Received: by mail-ot1-x341.google.com with SMTP id h26-v6so1283217otl.9
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 04:59:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1947e824-2aec-1d93-3b96-f472a7a88611@vivier.eu>
References: <20180928142533.8451-1-peter.maydell@linaro.org>
	<52177933-047f-d99b-e7d7-2a85e4c8d59c@vivier.eu>
	<eee0054a-4d73-53a2-ca52-dbce4f1996e5@vivier.eu>
	<CAFEAcA_3o3FSScwUcrDX2aFoj-RvNjo=F_Em2HaP=pK5o4=Bng@mail.gmail.com>
	<2998097f-bb40-409c-16aa-f8bef811444c@linaro.org>
	<1947e824-2aec-1d93-3b96-f472a7a88611@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 12:59:01 +0100
Message-ID: <CAFEAcA-F+=h=Hm71RpXF5wTQaq2bG7jBxMSbm0d2mCyHtXBGwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, "patches@linaro.org" <patches@linaro.org>

On 5 October 2018 at 17:09, Laurent Vivier <laurent@vivier.eu> wrote:
> On 05/10/2018 17:25, Richard Henderson wrote:
>> On 10/5/18 4:10 AM, Peter Maydell wrote:
>>> On 5 October 2018 at 01:28, Laurent Vivier <laurent@vivier.eu> wrote:
>>>> I have the following error when building on Fedora 28 and gcc (GCC)
>>>> 8.1.1 20180712 (Red Hat 8.1.1-5)
>>>>
>>>>   CC      aarch64_be-linux-user/target/arm/arm-semi.o
>>>> .../target/arm/arm-semi.c: In function =E2=80=98do_arm_semihosting=E2=
=80=99:
>>>> .../target/arm/arm-semi.c:270:1: error: unknown option after =E2=80=98=
#pragma
>>>> GCC diagnostic=E2=80=99 kind [-Werror=3Dpragmas]
>>>>
>>>> Perhaps you should use a "#if defined(__clang__)" to apply your fix on=
ly
>>>> to clang?
>>>
>>> I did test on gcc, but not that version. The point of the
>>>    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");
>>> line is to suppress that error (which it does on my gcc 5)
>>> so I don't know why your gcc is complaining :-(
>>
>> I suppose you could try -Wunknown-pragmas.
>> But from reading the manual it shouldn't make a difference.
>> OTOH, what you wrote should have worked...
>
> Could it be a bug in _Pragma()?

I got an f28 VM and can repro this. It looks like the problem
only happens when the get_user/put_user stuff is used via some
other macro, for some reason -- so the GET_ARG and SET_ARG
macros in arm-semi.c and the NEW_AUX_ENT macro in elfload.c
cause problems, but less indirect use does not. I'll try to
trim this down to a smaller test case somehow...

thanks
-- PMM
