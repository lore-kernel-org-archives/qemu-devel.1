Received: from eggs.gnu.org ([2001:4830:134:3::10]:60403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1epyHh-0004Yo-D9
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 10:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1epyHd-0000yZ-F2
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 10:32:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yvugenfi@redhat.com>) id 1epyHd-0000x3-9P
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 10:32:13 -0500
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
From: Yan Vugenfirer <yvugenfi@redhat.com>
In-Reply-To: <20180225114138.GB21248@north>
Date: Sun, 25 Feb 2018 17:32:03 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A2BB664-A8E0-41F0-988C-390C094AAA73@redhat.com>
References: <CAOCGu7mjmpvre4y5KhTwm6paD5Enr8NHj=qPh-Vb7MoqE6E13w@mail.gmail.com>
	<20180225114138.GB21248@north>
Subject: Re: [Qemu-devel] Windows vioinput guest driver tablet input bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Justin Gatzen <justin.gatzen@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ladi Prosek <lprosek@redhat.com>

Hello Justin,

Thanks a lot for the patch proposal.
I opened the issue on virtio-win GitHub page to track the issue: =
https://github.com/virtio-win/kvm-guest-drivers-windows/issues/249

Best regards,
Yan.

> On 25 Feb 2018, at 13:41, Justin Gatzen <justin.gatzen@gmail.com> =
wrote:
>=20
> The last email's diff got mangled due to long lines. The original
> source has long lines still but it shouldnt get cut off his time.
>=20
> Justin,
>=20
>=20
> diff --git a/vioinput/sys/HidMouse.c b/vioinput/sys/HidMouse.c
> index 69dac235..528bd3d6 100644
> --- a/vioinput/sys/HidMouse.c
> +++ b/vioinput/sys/HidMouse.c
> @@ -325,7 +325,12 @@ HIDMouseProbe(
>     DynamicArrayReserve(&AxisMap, AXIS_MAP_INITIAL_LENGTH * 2 * =
sizeof(ULONG));
>=20
>     // Windows won't drive a mouse without at least the X and Y =
relative axes
> -    if (InputCfgDataHasBit(pRelAxes, REL_X) && =
InputCfgDataHasBit(pRelAxes, REL_Y))
> +    if (InputCfgDataHasBit(pRelAxes, REL_X) && =
InputCfgDataHasBit(pRelAxes, REL_Y)
> +#ifdef EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
> +        || (pMouseDesc->uNumOfButtons > 0 && =
InputCfgDataHasBit(pAbsAxes, ABS_X)
> +            && InputCfgDataHasBit(pAbsAxes, ABS_Y))
> +#endif // EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
> +        )
>     {
>         for (i =3D 0; i < pRelAxes->size; i++)
>         {
> @@ -391,7 +396,8 @@ HIDMouseProbe(
>     }
>=20
> #ifdef EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
> -    if (uNumOfRelAxes =3D=3D 0 &&
> +    if ((!InputCfgDataHasBit(pRelAxes, REL_X) ||
> +         !InputCfgDataHasBit(pRelAxes, REL_Y)) &&
>         pMouseDesc->uNumOfButtons > 0 &&
>         InputCfgDataHasBit(pAbsAxes, ABS_X) && =
InputCfgDataHasBit(pAbsAxes, ABS_Y))
>     {
>=20
>=20
> On Sun, Feb 25, 2018 at 05:21:29AM -0500, Justin Gatzen wrote:
>> Hi,
>>=20
>> The vioinput Windows guest driver does not seem to work with mouse =
wheel or
>> side buttons for virtio-tablet-pci devices, while virtio-mouse-pci =
works as
>> expected. Linux guest drivers are unaffected. Tablets are being =
categorized as
>> mice due to the EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE compile flag. =
But when
>> there are no relative REL_X or REL_Y input axes the driver ignores =
all other
>> relative axis entries. Mouse wheel is one such relative axis. I've =
attached a
>> proof of concept fix for the guest driver that seems to fix both the =
mouse
>> wheel and side buttons but I believe this needs a more robust fix and =
deeper
>> look at the HIDMouseProbe function.
>>=20
>> Thanks,
>> Justin
>>=20
>>=20
>> diff --git a/vioinput/sys/HidMouse.c b/vioinput/sys/HidMouse.c
>> index 69dac235..ea188991 100644
>> --- a/vioinput/sys/HidMouse.c
>> +++ b/vioinput/sys/HidMouse.c
>> @@ -325,7 +325,11 @@ HIDMouseProbe(
>>     DynamicArrayReserve(&AxisMap, AXIS_MAP_INITIAL_LENGTH * 2 * =
sizeof(ULONG));
>>=20
>>     // Windows won't drive a mouse without at least the X and Y =
relative axes
>> -    if (InputCfgDataHasBit(pRelAxes, REL_X) &&
>> InputCfgDataHasBit(pRelAxes, REL_Y))
>> +    if (InputCfgDataHasBit(pRelAxes, REL_X) &&
>> InputCfgDataHasBit(pRelAxes, REL_Y)
>> +#ifdef EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
>> +        || (pMouseDesc->uNumOfButtons > 0 &&
>> InputCfgDataHasBit(pAbsAxes, ABS_X) && InputCfgDataHasBit(pAbsAxes,
>> ABS_Y))
>> +#endif // EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
>> +        )
>>     {
>>         for (i =3D 0; i < pRelAxes->size; i++)
>>         {
>> @@ -391,7 +395,7 @@ HIDMouseProbe(
>>     }
>>=20
>> #ifdef EXPOSE_ABS_AXES_WITH_BUTTONS_AS_MOUSE
>> -    if (uNumOfRelAxes =3D=3D 0 &&
>> +    if ((!InputCfgDataHasBit(pRelAxes, REL_X) ||
>> !InputCfgDataHasBit(pRelAxes, REL_Y)) &&
>>         pMouseDesc->uNumOfButtons > 0 &&
>>         InputCfgDataHasBit(pAbsAxes, ABS_X) &&
>> InputCfgDataHasBit(pAbsAxes, ABS_Y))
>>     {
>=20
