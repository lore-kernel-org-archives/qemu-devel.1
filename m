Received: from eggs.gnu.org ([2001:4830:134:3::10]:34016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cnqM0-0006gK-DY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cnqLz-0003Et-Fl
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:35:24 -0400
Date: Tue, 14 Mar 2017 19:35:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170314173513.wruppu4js7ikaxu2@kozik-lap>
References: <20170313180432.7067-1-krzk@kernel.org> <87mvcnpzll.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87mvcnpzll.fsf@linaro.org>
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
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>

On Tue, Mar 14, 2017 at 04:55:34PM +0000, Alex Benn=C3=A9e wrote:
>=20
> Krzysztof Kozlowski <krzk@kernel.org> writes:
>=20
> > Hi,
> >
> <snip>
> >
> > Overview of the problem
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > On Exynos4210, by default Linux kernel uses cpuidle driver which tries
> > to enter low power mode, called AFTR (Arm Off, Top Running).  On real
> > hardware this brings some power savings.  This AFTR mode requires second
> > CPU to be off, so the driver (coupled cpuidle driver) when system is id=
le:
> > 1. Turns off second CPU,
> > 2. Enters AFTR on CPU0.
> >
> > However the QEMU system is then totally unresponsive (e.g. on serial co=
nsole)
> > and RCU stalls appear from time to time.  I spent some time on it and d=
id not
> > find the real cause behind the lag.  Maybe it is because the second CPU
> > does not really power down itself and system just burns the cycles unde=
r spin
> > locks?
>=20
> Was this tested post the MTTCG merge? Maybe there is an interaction
> between power saving/halting the vCPU?
>=20
> I mention this because I already made some minor tweaks for handing the
> WFI instruction in MTTCG. See commit c22edfebff. You can test this by
> forcing the original behaviour by adding:
>=20
>   -accel tcg,thread=3Dsingle
>=20
> to your command line.
>

I am testing it on v2.8.0-2005-g17783ac828ad. Without any -accel, the
system boots but responsiveness of serial console is bad. Bad but at
least it is responding still a little bit.

With the -accel you mentioned, system does not even reach user-space
(initramfs).

I tried rebasing on newer (e.g. v2.8.0-2182-g5e2fb7c598c6) but
compilation fails all the time on:
/home/dev/qemu/qemu/vl.c: In function =E2=80=98main=E2=80=99:
/home/dev/qemu/qemu/vl.c:3131:18: error: =E2=80=98QEMU_OPTION_blockdev=E2=
=80=99 undeclared (first use in this function)
             case QEMU_OPTION_blockdev:


Best regards,
Krzysztof
