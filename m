Received: from eggs.gnu.org ([2001:4830:134:3::10]:56230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAXWr-0003Ue-Um
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAXWq-0004Ih-Oo
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:12:57 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAXWq-0004IG-KJ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:12:56 -0400
Received: by mail-ot0-x242.google.com with SMTP id h8-v6so12681255otb.2
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 02:12:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180423064020.25434-1-clg@kaod.org>
References: <20180423064020.25434-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 10:12:35 +0100
Message-ID: <CAFEAcA-LtNpGTV08jvK4i5C5i64WjM5gMB4zGr8P4fkVSkNH7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

On 23 April 2018 at 07:40, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> commit 1d3e65aa7ac5 ("hw/timer: Add value matching support to
> aspeed_timer") increased the vmstate version of the timers array but
> doing so, it broke migration. To fix, we also need to change the
> vmstate version of the aspeed timer controller model.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>
>  To test on a 'palmetto-bmc' board, download the latest built OpenBMC
>  flash image :
>
>    wget https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3D=
palmetto/lastSuccessfulBuild/artifact/deploy/images/palmetto/flash-palmetto
>
>  start two instances of QEMU with :
>
>    qemu-system-arm -m 512 -M palmetto-bmc -drive file=3D./flash-palmetto,=
format=3Draw,if=3Dmtd -serial mon:stdio -nographic -nodefaults
>
>  and :
>
>    qemu-system-arm -m 512 -M palmetto-bmc -drive file=3D./flash-palmetto,=
format=3Draw,if=3Dmtd -serial mon:stdio -nographic -nodefaults -incoming tc=
p::1234
>
>  then, run migrate from the monitor:
>
>    (qemu) migrate tcp:localhost:1234
>
>  hw/timer/aspeed_timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index 50acbf530a3a..7df19bd9df91 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -498,8 +498,8 @@ static const VMStateDescription vmstate_aspeed_timer =
=3D {
>
>  static const VMStateDescription vmstate_aspeed_timer_state =3D {
>      .name =3D "aspeed.timerctrl",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
>          VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),

Wouldn't it be simpler to just fix the incorrect value in
the VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
line ?

thanks
-- PMM
