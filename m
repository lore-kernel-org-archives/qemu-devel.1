Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkA0z-0003tS-BD
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkA0y-0002xh-EF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:18:45 -0400
References: <1503407712-9894-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-V1igN7Sz3SusczcPadtZC-z4fyw-pvPggGT5VFFMvRA@mail.gmail.com>
	<8fb75274-09a6-dbd3-5dba-1069d790b689@redhat.com>
	<CAFEAcA9PdXkh4t7gCT=3GNbD8V+_Abtqe31p2DV+=emyR1chcQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6bdaf758-98d1-d99d-20ae-b0f25747d6b1@redhat.com>
Date: Tue, 22 Aug 2017 16:18:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PdXkh4t7gCT=3GNbD8V+_Abtqe31p2DV+=emyR1chcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/digic: Mark device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Antony Pavlov <antonynpavlov@gmail.com>

On 22.08.2017 16:07, Peter Maydell wrote:
> On 22 August 2017 at 15:05, Thomas Huth <thuth@redhat.com> wrote:
>> On 22.08.2017 15:52, Peter Maydell wrote:
>>> On 22 August 2017 at 14:15, Thomas Huth <thuth@redhat.com> wrote:
>>>> QEMU currently hangs completely when the user is trying to do a
>>>> "device_add digic" on an unrelated ARM machine like integratorcp.
>>>> Looks like this device is not meant to be hot-pluggable at all, so
>>>> let's simply mark it with "user_creatable =3D false" to avoid the ha=
ng.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  hw/arm/digic.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/hw/arm/digic.c b/hw/arm/digic.c
>>>> index 94f3263..208dfb3 100644
>>>> --- a/hw/arm/digic.c
>>>> +++ b/hw/arm/digic.c
>>>> @@ -101,6 +101,8 @@ static void digic_class_init(ObjectClass *oc, vo=
id *data)
>>>>      DeviceClass *dc =3D DEVICE_CLASS(oc);
>>>>
>>>>      dc->realize =3D digic_realize;
>>>> +    /* Reason: Hangs QEMU when trying to device_add this directly *=
/
>>>> +    dc->user_creatable =3D false;
>>>>  }
>>>
>>> Maybe "uses serial_hds[]" is a better reason, or does it hang for
>>> some other reason?
>>
>> When I kill the hanging QEMU, the stack trace looks like this:
>>
>> #0  0x00007ffff13afaff in ppoll () at /lib64/libc.so.6
>> #1  0x0000555555bb3179 in qemu_poll_ns (__ss=3D0x0, __timeout=3D0x7fff=
ffffda60, __nfds=3D<optimized out>, __fds=3D<optimized out>)
>>     at /usr/include/bits/poll2.h:77
>> #2  0x0000555555bb3179 in qemu_poll_ns (fds=3D<optimized out>, nfds=3D=
<optimized out>, timeout=3Dtimeout@entry=3D1000000000)
>>     at /home/thuth/devel/qemu/util/qemu-timer.c:334
>> #3  0x0000555555bb3f88 in main_loop_wait (timeout=3D1000000000) at /ho=
me/thuth/devel/qemu/util/main-loop.c:255
>> #4  0x0000555555bb3f88 in main_loop_wait (nonblocking=3Dnonblocking@en=
try=3D0) at /home/thuth/devel/qemu/util/main-loop.c:515
>> #5  0x000055555578d927 in main () at /home/thuth/devel/qemu/vl.c:1917
>> #6  0x000055555578d927 in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>, envp=3D<optimized out>) at /home/thuth/devel/qemu/vl.c:4791
>>
>> I haven't investigated any further, but the usage of serial_hds
>> in the realize function could certainly be the reason. At least
>> it certainly is a reason that this device should not be creatable
>> by the user - so let me send a v2 with the comment changed
>> accordingly.
>=20
> Has QEMU itself actually hung (no response to monitor etc), or is
> that just the guest sitting doing nothing? "QEMU is sat in the main
> loop waiting for something to happen" is what you'd expect in the
> latter case. The backtraces for the other threads might be of
> interest or might also be unhelpful.

I thought that QEMU would hang ... but now I checked again, and it's
just that it does not return to the monitor prompt as expected. If I
press CTRL-a c again, I can get to the monitor again.
Anyway, QEMU then dies if I try to remove the device with device_del:

qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)

... so let's simply mark it with user_creatable =3D false and call it a
day... ;-)

 Thomas
