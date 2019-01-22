Received: from eggs.gnu.org ([209.51.188.92]:59106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glsVu-0006AI-Kx
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glsMn-0004Cd-Vh
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:29:10 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glsMn-0004Bz-QH
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:29:09 -0500
Received: by mail-oi1-x244.google.com with SMTP id y23so16840065oia.4
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20190121184314.14311-1-peter.maydell@linaro.org>
	<383fd07d-9c2a-a7b2-5b88-f9a411c8b91a@redhat.com>
In-Reply-To: <383fd07d-9c2a-a7b2-5b88-f9a411c8b91a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 09:28:56 +0000
Message-ID: <CAFEAcA9G7CuZ3wSO9YLs-OH4m1zQ7s73yWp8rwsDBSyUZokyGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] xlnx-zynqmp: Don't create rpu-cluster if
 there are no RPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>, "patches@linaro.org" <patches@linaro.org>

On Mon, 21 Jan 2019 at 20:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 1/21/19 7:43 PM, Peter Maydell wrote:
> > If we aren't going to create any RPUs, then don't create the
> > rpu-cluster unit. This allows us to add an assertion to the
> > cluster object that it contains at least one CPU, which helps
> > to avoid bugs in creating clusters and putting CPUs in them.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This is a preparatory patch that is necessary for the series
> > "[PATCH v3 0/4] tcg: support heterogenous CPU clusters"
> > (20190121152218.9592-1-peter.maydell@linaro.org)
> > in order to avoid the xlnx-zcu102 board asserting if started with
> > fewer than 5 CPUs.
> >
> >  hw/arm/xlnx-zynqmp.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> > index 370b0e44a38..16cba433cb7 100644
> > --- a/hw/arm/xlnx-zynqmp.c
> > +++ b/hw/arm/xlnx-zynqmp.c
> > @@ -178,6 +178,11 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState=
 *s, const char *boot_cpu,
> >      int i;
> >      int num_rpus =3D MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYN=
QMP_NUM_RPU_CPUS);
>
> Not related to this patch, but this check seems dangerous, i.e. using
> "-smp 2" we get num_rpus=3D-2 which luckyly doesn't enter the for() loop.
>
> >
> > +    if (num_rpus =3D=3D 0) {
>
> With the current codebase, you'd have to check for "num_rpus <=3D 0", ...

Oops, nice catch.

> What about this instead?
>
> -- >8 --
> @@ -451,10 +451,12 @@ static void xlnx_zynqmp_realize(DeviceState *dev,
> Error **errp)
>                      "RPUs just use -smp 6.");
>      }
>
> -    xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> +    if (smp_cpus > XLNX_ZYNQMP_NUM_APU_CPUS) {
> +        xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>      }

Yeah, that would work too. I think I would just go for
using "if (num_rpus <=3D 0)" in the function, though.

thanks
-- PMM
