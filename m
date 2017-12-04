Received: from eggs.gnu.org ([2001:4830:134:3::10]:37124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eLn4J-0008RN-Jd
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 04:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eLn4G-0008S6-Bu
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 04:29:43 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eLn4G-0008Rm-4E
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 04:29:40 -0500
Received: by mail-wm0-x244.google.com with SMTP id f206so6747815wmf.5
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 01:29:39 -0800 (PST)
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
	<151204437224.3145.2784740143531482152.malone@gac.canonical.com>
	<74ce90f9-f123-8fba-1038-7dd181d9148c@physik.fu-berlin.de>
	<177a2c67-932a-8842-fc71-229373bc28aa@physik.fu-berlin.de>
	<01c38497-beda-2450-026d-38876cfda2cc@tuxfamily.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <01c38497-beda-2450-026d-38876cfda2cc@tuxfamily.org>
Date: Mon, 04 Dec 2017 09:29:37 +0000
Message-ID: <87fu8qsuwu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1735384] Re: OpenJDK JVM segfaults on
 qemu-sh4 (regression)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: Bug 1735384 <1735384@bugs.launchpad.net>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>


Thomas Huth <huth@tuxfamily.org> writes:

> On 01.12.2017 00:25, John Paul Adrian Glaubitz wrote:
>> The offending commit is:
>>=20
>> d25f2a72272b9ffe0d06710d6217d1169bc2cc7d is the first bad commit
>> commit d25f2a72272b9ffe0d06710d6217d1169bc2cc7d
>> Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Date:   Mon Nov 13 13:55:27 2017 +0000
>>=20
>>     accel/tcg/translate-all: expand cpu_restore_state addr check
>>=20
>>     We are still seeing signals during translation time when we walk over
>>     a page protection boundary. This expands the check to ensure the host
>>     PC is inside the code generation buffer. The original suggestion was
>>     to check versus tcg_ctx.code_gen_ptr but as we now segment the
>>     translation buffer we have to settle for just a general check for
>>     being inside.
>>=20
>>     I've also fixed up the declaration to make it clear it can deal with
>>     invalid addresses. A later patch will fix up the call sites.
>>=20
>>     Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>     Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>     Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>     Message-id: 20171108153245.20740-2-alex.bennee@linaro.org
>>     Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>     Cc: Richard Henderson <rth@twiddle.net>
>>     Tested-by: Peter Maydell <peter.maydell@linaro.org>
>>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>=20
>> :040000 040000 da50c4c43089d3ee7d1e9ad50d3c9036114e5f11 cd6a0dcaa1d284fe=
5439f6f3b61547d4b0662768 M      accel
>> :040000 040000 c294a7c102d27295f8d81cc06b5d4d17357440ad 5a1268b7634f69f0=
806f22161ec7d6a1a26c8812 M      include
>>=20
>> Reverting the commit resolves the issue.
>>=20
>
> Alex, any ideas what might be wrong here?

It's hard to imagine a scenario where taking the tb_lock() for resolving
something that will fail is going to be an improvement. However maybe
there is a subtle difference with sh4's javavm implementation.

A backtrace QEMU after the segv would be useful here.

--=20
Alex Benn=C3=A9e
