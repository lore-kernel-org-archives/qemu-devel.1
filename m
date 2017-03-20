Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpv8A-0000kY-OQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpv89-0002PT-Sz
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:05:42 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpv89-0002OS-NF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:05:41 -0400
Received: by mail-wm0-x234.google.com with SMTP id u132so60274059wmg.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:05:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87pohcnrlu.fsf@linaro.org>
References: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
	<1487616072-9226-3-git-send-email-peter.maydell@linaro.org>
	<87pohcnrlu.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 11:05:20 +0000
Message-ID: <CAFEAcA967QpqPygNGO7977=uj1xz9hG4-_FhuRY89HHksCu_6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] arm: Don't decode MRS(banked) or
 MSR(banked) for M profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>

On 20 March 2017 at 10:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> M profile doesn't have the MSR(banked) and MRS(banked) instructions
>> and uses the encodings for different kinds of M-profile MRS/MSR.
>> Guard the relevant bits of the decode logic to make sure we don't
>> accidentally fall into them by accident on M-profile.
>
> The ARMv7-A documentation talks about banked registers being a feature
> of application processors with Virtualisation Extensions which make the
> sense of the test a bit weird. But I guess they are functionally
> equivalent. Are there in practice any -A cores without virt?

You can have an A profile core without EL2 implemented, yes.
In particular in ARMv8 this encoding is legal (and has defined
effects) even if EL2 is not implemented. It's introduced in
ARMv7VE, and there's an argument for allowing it even if we
don't implement EL2 for those CPUs which in real hardware do
implement it, because system software might assume it can use
these encodings.

We should probably UNDEF it for pre-v7VE cores though. For
this patchset what I really wanted was to avoid the different
decode used by M profile getting mixed up with the A profile
decode path.

thanks
-- PMM
