Received: from eggs.gnu.org ([2001:4830:134:3::10]:59070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkB4T-0004j5-J2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkB4S-0000zC-J7
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:26:25 -0400
References: <1503414375-21009-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-92Jjz2uCC387oX2u0NWfijPwB_8zGaagC1m=sKD8zhQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <443135b4-4b36-bae6-b50a-12fb4a55a858@redhat.com>
Date: Tue, 22 Aug 2017 17:26:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-92Jjz2uCC387oX2u0NWfijPwB_8zGaagC1m=sKD8zhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/misc/auxbus.c: Mark the
 aux-to-i2c-bridge device as non-hotpluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 22.08.2017 17:12, Peter Maydell wrote:
> On 22 August 2017 at 16:06, Thomas Huth <thuth@redhat.com> wrote:
>> QEMU currently aborts if the user tries to do something like this:
>>
>> $ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
>> QEMU 2.9.93 monitor - type 'help' for more information
>> (qemu) device_add aux-to-i2c-bridge,id=3Dx
>> (qemu) device_del x
>> **
>> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_=
ctrl)
>> Aborted (core dumped)
>>
>> Looks like the device is not hot-pluggable, so let's mark it
>> accordingly.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/misc/auxbus.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
>> index 8a90ddd..2c62515 100644
>> --- a/hw/misc/auxbus.c
>> +++ b/hw/misc/auxbus.c
>> @@ -222,9 +222,17 @@ static inline I2CBus *aux_bridge_get_i2c_bus(AUXT=
OI2CState *bridge)
>>      return bridge->i2c_bus;
>>  }
>>
>> +static void aux_bridge_class_init(ObjectClass *oc, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
>> +
>> +    dc->hotpluggable =3D false;
>> +}
>=20
> Why is our default "hotpluggable" rather than "not hotpluggable" ?
> We must have way more non-hotpluggable devices than hotpluggable
> ones, and it takes active effort to make a hotpluggable device
> model, so it seems like it would be much less bug-prone to
> require hotpluggable devices to set dc->hotpluggable true
> rather than all the non-hotpluggable ones to set it false...

I think most devices are already non-hotpluggable automatically because
they sit on a bus that is not hot-pluggable (e.g. sysbus devices). The
problematic ones are the devices with .parent =3D TYPE_DEVICE. And for
these, I think it is quite hard to say whether they should be
hot-pluggable by default or not?
Anyway, according to my tests (I'm currently working on a test that
automatically does device_add + device_del for all devices, as you might
have guessed already), there are not that many devices that cause
problems here, so I guess marking some few with hotpluggable =3D false
should be OK?

 Thomas
