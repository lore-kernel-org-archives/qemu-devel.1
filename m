Received: from eggs.gnu.org ([209.51.188.92]:53463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gtVql-0005ob-Dk
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gtVqf-0002QT-1A
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:03:37 -0500
Date: Tue, 12 Feb 2019 12:03:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <28a8cd58-51a9-6301-1d25-02289af8c81d@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1902121157470.75929@zero.eik.bme.hu>
References: <20190210174421.22062-1-mark.cave-ayland@ilande.co.uk>
	<442139a2-5ab2-9259-03a0-11d2f3c86c59@redhat.com>
	<28a8cd58-51a9-6301-1d25-02289af8c81d@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] cuda: decrease time delay
 before raising VIA SR interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, hsp.cat7@gmail.com

On Tue, 12 Feb 2019, Mark Cave-Ayland wrote:
> On 11/02/2019 23:35, Philippe Mathieu-Daud=C3=A9 wrote:
>
>> Hi Mark,
>>
>> On 2/10/19 6:44 PM, Mark Cave-Ayland wrote:
>>> In order to handle a race condition in MacOS 9, a delay was introduce=
d when
>>> raising the VIA SR interrupt inspired by similar code in MacOnLinux.
>>>
>>> During original testing of the MacOS 9 patches it was found that the =
30us
>>> delay used in MacOnLinux did not work reliably within QEMU, and a val=
ue of
>>> 300us was required to function correctly.
>>>
>>> Recent experiments have shown that the previous reliability issues ar=
e no
>>> longer present, and this value can be reduced down to 20us with no ap=
parent
>>> ill effects in my local tests. This has the benefit of considerably i=
mproving
>>> the responsiveness of the ADB keyboard and mouse with the guest.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/misc/macio/cuda.c | 11 +----------
>>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>>
>>> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
>>> index c4f7a2f39b..3febacdd1e 100644
>>> --- a/hw/misc/macio/cuda.c
>>> +++ b/hw/misc/macio/cuda.c
>>> @@ -97,17 +97,8 @@ static void cuda_set_sr_int(void *opaque)
>>>
>>>  static void cuda_delay_set_sr_int(CUDAState *s)
>>>  {
>>> -    MOS6522CUDAState *mcs =3D &s->mos6522_cuda;
>>> -    MOS6522State *ms =3D MOS6522(mcs);
>>> -    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(ms);
>>>      int64_t expire;
>>>
>>> -    if (ms->dirb =3D=3D 0xff || s->sr_delay_ns =3D=3D 0) {
>>> -        /* Disabled or not in Mac OS, fire the IRQ directly */
>>> -        mdc->set_sr_int(ms);
>>> -        return;
>>> -    }
>>
>> The change of sr_delay_ns below is well explained, but I don't
>> understand why you remove the previous if().
>
> IIRC it was a hack by Alex to try and restrict the delay on the interru=
pt just to
> MacOS instead of Linux, but with the reduced value it doesn't really ma=
tter any more.

If this delay is to prevent a bug which only happens in MacOS then that's=
=20
the hack not the normal code path to run without the delay that you've=20
just removed. So maybe this should be kept if possible to avoid unecessar=
y=20
delays for other guests. (Although if this only affects mac99,via=3Dcuda =
but=20
not mac99,via=3Dpmu then I don't care much as long as pmu works.)

> As a plus it also prevents a guest OS from accidentally triggering the =
hack whilst
> programming the VIA port.

That may be a problem though. What's the issue exactly? Why is the delay=20
needed in the first place?

Regards,
BALATON Zoltan
