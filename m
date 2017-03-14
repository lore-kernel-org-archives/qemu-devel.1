Received: from eggs.gnu.org ([2001:4830:134:3::10]:55056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnr7c-0004pn-Te
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnr7b-0000ag-QU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:24:36 -0400
Received: from mail-lf0-x232.google.com ([2a00:1450:4010:c07::232]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnr7b-0000aB-EO
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:24:35 -0400
Received: by mail-lf0-x232.google.com with SMTP id j90so80099710lfk.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 11:24:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314173513.wruppu4js7ikaxu2@kozik-lap>
References: <20170313180432.7067-1-krzk@kernel.org> <87mvcnpzll.fsf@linaro.org>
	<20170314173513.wruppu4js7ikaxu2@kozik-lap>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Tue, 14 Mar 2017 18:24:33 +0000
Message-ID: <CAHDbmO1apk81csbC7BJK2JFK23fvVBLb-wA5z7_y29T=ueFPyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 0/5] hw: arm: exynos: Bring
 up secondary CPU + CPUIDLE issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

That means you're on a pre-mttcg tree so that's not the reason.

On 14 Mar 2017 5:35 pm, "Krzysztof Kozlowski" <krzk@kernel.org> wrote:

> On Tue, Mar 14, 2017 at 04:55:34PM +0000, Alex Benn=C3=A9e wrote:
> >
> > Krzysztof Kozlowski <krzk@kernel.org> writes:
> >
> > > Hi,
> > >
> > <snip>
> > >
> > > Overview of the problem
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > On Exynos4210, by default Linux kernel uses cpuidle driver which trie=
s
> > > to enter low power mode, called AFTR (Arm Off, Top Running).  On real
> > > hardware this brings some power savings.  This AFTR mode requires
> second
> > > CPU to be off, so the driver (coupled cpuidle driver) when system is
> idle:
> > > 1. Turns off second CPU,
> > > 2. Enters AFTR on CPU0.
> > >
> > > However the QEMU system is then totally unresponsive (e.g. on serial
> console)
> > > and RCU stalls appear from time to time.  I spent some time on it and
> did not
> > > find the real cause behind the lag.  Maybe it is because the second C=
PU
> > > does not really power down itself and system just burns the cycles
> under spin
> > > locks?
> >
> > Was this tested post the MTTCG merge? Maybe there is an interaction
> > between power saving/halting the vCPU?
> >
> > I mention this because I already made some minor tweaks for handing the
> > WFI instruction in MTTCG. See commit c22edfebff. You can test this by
> > forcing the original behaviour by adding:
> >
> >   -accel tcg,thread=3Dsingle
> >
> > to your command line.
> >
>
> I am testing it on v2.8.0-2005-g17783ac828ad. Without any -accel, the
> system boots but responsiveness of serial console is bad. Bad but at
> least it is responding still a little bit.
>
> With the -accel you mentioned, system does not even reach user-space
> (initramfs).
>
> I tried rebasing on newer (e.g. v2.8.0-2182-g5e2fb7c598c6) but
> compilation fails all the time on:
> /home/dev/qemu/qemu/vl.c: In function =E2=80=98main=E2=80=99:
> /home/dev/qemu/qemu/vl.c:3131:18: error: =E2=80=98QEMU_OPTION_blockdev=E2=
=80=99
> undeclared (first use in this function)
>              case QEMU_OPTION_blockdev:
>
>
> Best regards,
> Krzysztof
>
>
