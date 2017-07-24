Received: from eggs.gnu.org ([2001:4830:134:3::10]:59249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkYZ-000750-66
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkYY-0004IH-BD
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:06:23 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZkYY-0004G5-5J
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:06:22 -0400
Received: by mail-wm0-x235.google.com with SMTP id t201so29601717wmt.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:06:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-21-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-21-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:06:00 +0100
Message-ID: <CAFEAcA9RvWoL0cr=irYQ0iphHT9E4pqoQKTW+Bu28uoEJGR3mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 20/35] arm/boot: fix undefined
 instruction on secondary smp cpu bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> In a ARM multicore system, write_secondary_boot() only initializes fixups=
 for
> FIXUP_GIC_CPU_IF and FIXUP_BOOTREG, while smpboot[] also uses FIXUP_DSB.
> This results in write_bootloader() using uninitialized fixupcontext[FIXUP=
_DSB]
> instruction in the bootloader code...

Hmm? The code does:

    if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
        fixupcontext[FIXUP_DSB] =3D DSB_INSN;
    } else {
        fixupcontext[FIXUP_DSB] =3D CP15_DSB_INSN;
    }

so fixupcontext[FIXUP_DSB] is guaranteed initialized,
as are FIXUP_GIC_CPU_IF and FIXUP_BOOTREG, which are
the only fixups that the smpboot[] code uses.

thanks
-- PMM
