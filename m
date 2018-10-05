Received: from eggs.gnu.org ([2001:4830:134:3::10]:43844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8M8i-0003Gy-WA
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8M8h-0006sh-Fs
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:11:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:47001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8M8g-0006qZ-4r
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:11:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id o21so11731753otb.13
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 02:11:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <eee0054a-4d73-53a2-ca52-dbce4f1996e5@vivier.eu>
References: <20180928142533.8451-1-peter.maydell@linaro.org>
	<52177933-047f-d99b-e7d7-2a85e4c8d59c@vivier.eu>
	<eee0054a-4d73-53a2-ca52-dbce4f1996e5@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 10:10:50 +0100
Message-ID: <CAFEAcA_3o3FSScwUcrDX2aFoj-RvNjo=F_Em2HaP=pK5o4=Bng@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 5 October 2018 at 01:28, Laurent Vivier <laurent@vivier.eu> wrote:
> I have the following error when building on Fedora 28 and gcc (GCC)
> 8.1.1 20180712 (Red Hat 8.1.1-5)
>
>   CC      aarch64_be-linux-user/target/arm/arm-semi.o
> .../target/arm/arm-semi.c: In function =E2=80=98do_arm_semihosting=E2=80=
=99:
> .../target/arm/arm-semi.c:270:1: error: unknown option after =E2=80=98#pr=
agma
> GCC diagnostic=E2=80=99 kind [-Werror=3Dpragmas]
>
> Perhaps you should use a "#if defined(__clang__)" to apply your fix only
> to clang?

I did test on gcc, but not that version. The point of the
   _Pragma("GCC diagnostic ignored \"-Wpragmas\"");
line is to suppress that error (which it does on my gcc 5)
so I don't know why your gcc is complaining :-(

If you add an extra diagnostic push, so:

+        _Pragma("GCC diagnostic push");                                   =
  \
+        _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                  =
  \
+        _Pragma("GCC diagnostic push");                                   =
  \
+        _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\""); =
  \

and then a balancing extra

+        _Pragma("GCC diagnostic pop");                                    =
  \

at the end, I don't suppose that helps?

(I generally prefer to avoid marking things as clang- or gcc-
specific where I can.)

thanks
-- PMM
