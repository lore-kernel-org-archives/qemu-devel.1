Received: from eggs.gnu.org ([2001:4830:134:3::10]:55870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG7Kk-0007gi-TJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG7Kk-0001R9-7I
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:27:30 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:42064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG7Kk-0001Qq-3O
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:27:30 -0400
Received: by mail-ot0-x22d.google.com with SMTP id l13-v6so37217675otk.9
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 11:27:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YUTbDrTKGBzZtR5MUS3VTCFANmxZ0cBLMMS=OuO_R9A@mail.gmail.com>
References: <20180508151437.4232-1-richard.henderson@linaro.org>
	<20180508151437.4232-5-richard.henderson@linaro.org>
	<CAFEAcA-6uQ4P=e7iJeNvPBVn6hxLFysG1-dLPdDeTpdpRn8mwQ@mail.gmail.com>
	<CAFEAcA_YUTbDrTKGBzZtR5MUS3VTCFANmxZ0cBLMMS=OuO_R9A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 19:27:08 +0100
Message-ID: <CAFEAcA9TU_xejXo7ZFUFWK1anqLJ-cHjBLJHmgNnEr=kd-mnXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 04/10] tcg: Introduce atomic helpers for
 integer min/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 May 2018 at 18:49, Peter Maydell <peter.maydell@linaro.org> wrote:
> [weird compiler errors]

This fixes them:

--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -187,7 +187,7 @@
 /* Returns the eventual value, failed or not */
 #define atomic_cmpxchg__nocheck(ptr, old, new)    ({                    \
     typeof_strip_qual(*ptr) _old = (old);                               \
-    __atomic_compare_exchange_n(ptr, &_old, new, false,                 \
+    (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \
                               __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);      \
     _old;                                                               \
 })

Seems pretty clearly a compiler bug -- rth says newer gcc don't
do this, so presumably fixed upstream somewhere between gcc 5 and 6.

thanks
-- PMM
