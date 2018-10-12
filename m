Received: from eggs.gnu.org ([2001:4830:134:3::10]:48815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gAuYd-00029m-A8
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gAuYc-00044D-Cv
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:20:35 -0400
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<20181002142443.30976-4-damien.hedde@greensocs.com>
	<2478a2c0-7f5f-556c-09c3-1fa503984f38@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <d8807487-72b9-e5c4-ba81-281218023dc6@greensocs.com>
Date: Fri, 12 Oct 2018 12:20:17 +0200
MIME-Version: 1.0
In-Reply-To: <2478a2c0-7f5f-556c-09c3-1fa503984f38@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/9] qdev-monitor: print the device's
 clock with info qtree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, konrad@adacore.com, luc.michel@greensocs.com

Hi Philippe,

On 10/3/18 12:42 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Damien,
>=20
> On 10/2/18 4:24 PM, Damien Hedde wrote:
>> This prints the clocks attached to a DeviceState when using "info qtre=
e" monitor
>> command. For every clock, it displays the direction, the name and if t=
he
>> clock is forwarded. For input clock, it displays also the frequency.
>=20
> What would also be really useful (during development mostly)
> is a "info clktree" monitor command.

What would be the output ? A list of all clock related devices and their
clocks ? Or something more like a clock tree starting from the source(s)
clock up to the last ones ? (or the opposite starting from a
clocked-device down to the sources)

Concerning development, it might also be useful to have access to the
frequency of a clock output. Maybe I should add the value in the object
for that purpose ?

>=20
>>
>> This is based on the original work of Frederic Konrad.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> ---
>>  qdev-monitor.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 61e0300991..8c39a3a65b 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -682,6 +682,7 @@ static void qdev_print(Monitor *mon, DeviceState *=
dev, int indent)
>>      ObjectClass *class;
>>      BusState *child;
>>      NamedGPIOList *ngl;
>> +    NamedClockList *clk;
>> =20
>>      qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(de=
v)),
>>                  dev->id ? dev->id : "");
>> @@ -696,6 +697,17 @@ static void qdev_print(Monitor *mon, DeviceState =
*dev, int indent)
>>                          ngl->num_out);
>>          }
>>      }
>> +    QLIST_FOREACH(clk, &dev->clocks, node) {
>> +        if (clk->out) {
>> +            qdev_printf("clock-out%s \"%s\"\n",
>> +                        clk->forward ? " (fw)" : "",
>> +                        clk->name);
>> +        } else {
>> +            qdev_printf("clock-in%s \"%s\" freq=3D%" PRIu64 "Hz\n",
>=20
> IMHO 'freq_hz=3D%" PRIu64 "\n"' is easier to read.

The frequency value in hertz is not easy to read in general (eg:
33333333Hz). Maybe we should print it with an apropriate unit (eg:
33.333333MHz). We can also use the "'" printf flag for thousand
separator but it's locale-dependent (and in my case it prints nothing).

>=20
> However if we plan to add/use a qemu_strtohz() similar to
> qemu_strtosz_metric(), that would be fine.

You mean for test purpose ?

>=20
>> +                        clk->forward ? " (fw)" : "",
>> +                        clk->name, clock_get_frequency(clk->in));
>> +        }
>> +    }
>>      class =3D object_get_class(OBJECT(dev));
>>      do {
>>          qdev_print_props(mon, dev, DEVICE_CLASS(class)->props, indent=
);
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
