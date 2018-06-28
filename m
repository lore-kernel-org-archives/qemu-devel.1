Received: from eggs.gnu.org ([2001:4830:134:3::10]:52192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYYKa-00076g-Mo
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYYKZ-0007Bt-Q9
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:55:32 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYYKZ-0007AN-Ks
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:55:31 -0400
Received: by mail-oi0-x241.google.com with SMTP id 21-v6so5449989oip.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:55:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_EXZAHQEyj63Pko8XJqiEnsAHjLXAP6G1R29tqSf+W0A@mail.gmail.com>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<87y3ezuozw.fsf@linaro.org>
	<CAFEAcA_EXZAHQEyj63Pko8XJqiEnsAHjLXAP6G1R29tqSf+W0A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 15:55:10 +0100
Message-ID: <CAFEAcA-mRijxqR1k7g6TpeqDfgHD0WqvUAsQvgs7-W-GseVG2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 00/35] target/arm SVE patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 28 June 2018 at 15:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 28 June 2018 at 12:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
>>   loading test image
>>   sve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin...
>>   starting apprentice image at 0x4000801000
>>   starting image
>>   fish: =E2=80=9C../qemu.git/aarch64-linux-user/=E2=80=A6=E2=80=9D termi=
nated by signal SIGFPE
>>   (Floating point exception)
>
> Do you have the insn that it's barfing on? In particular,
> I'm guessing from the test name that this is for something
> covered by one of the SDIV_zpzz lines in sve.decode, which
> is already in master rather than in this test series.
> If that's true, then it shouldn't block applying this set...

Further discussion on IRC suggests that this is failing on
MININT idiv -1, which is an annoying special case that x86
happens to generate SIGFPE for. Compare our HELPER(sdiv) code:

int32_t HELPER(sdiv)(int32_t num, int32_t den)
{
    if (den =3D=3D 0)
      return 0;
    if (num =3D=3D INT_MIN && den =3D=3D -1)
      return INT_MIN;
    return num / den;
}

with what we do for SVE:

#define DO_DIV(N, M)  (M ? N / M : 0)

This is OK for unsigned division, but signed division needs to
special case INT_MIN / -1.

In any case, this is in an existing insn, so I'm going to apply
this series to target-arm.next (fixing up the patch 5 comment
typo).

thanks
-- PMM
