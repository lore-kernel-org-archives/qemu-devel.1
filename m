Received: from eggs.gnu.org ([2001:4830:134:3::10]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBHV9-0006ZG-UK
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBHV6-00053k-Oy
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:18:15 -0400
References: <1524633715-21393-1-git-send-email-thuth@redhat.com>
	<11bfff34-f237-69e3-5491-a048809d84a4@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fae01c1a-1780-7bb6-2396-f21dd9b2c6b6@redhat.com>
Date: Wed, 25 Apr 2018 12:17:55 +0200
MIME-Version: 1.0
In-Reply-To: <11bfff34-f237-69e3-5491-a048809d84a4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] hw/s390x: Allow to configure the
 consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 25.04.2018 11:50, David Hildenbrand wrote:
> On 25.04.2018 07:21, Thomas Huth wrote:
>> The consoles ("sclpconsole" and "sclplmconsole") can only be configure=
d
>> with "-device" and "-chardev" so far. Other machines use the convenien=
ce
>> option "-serial" to configure the default consoles, even for virtual
>> consoles like spapr-vty on the pseries machine. So let's support this
>> option on s390x, too. This way we can easily enable the serial console
>> here again with "-nodefaults", for example:
>>
>> qemu-system-s390x -no-shutdown -nographic -nodefaults -serial mon:stdi=
o
>>
>> ... which is way shorter than typing:
>>
>> qemu-system-s390x -no-shutdown -nographic -nodefaults \
>>   -chardev stdio,id=3Dc1,mux=3Don -device sclpconsole,chardev=3Dc1 \
>>   -mon chardev=3Dc1
>>
>> The -serial parameter can also be used if you only want to see the QEM=
U
>> monitor on stdio without using -nodefaults, but not the console output=
.
>> That's something that is pretty impossible with the current code today=
:
>>
>> qemu-system-s390x -no-shutdown -nographic -serial none
>>
>> While we're at it, this patch also maps the second -serial option to t=
he
>> "sclplmconsole", so that there is now an easy way to configure this se=
cond
>> console on s390x, too, for example:
>>
>> qemu-system-s390x -no-shutdown -nographic -serial null -serial mon:std=
io
>>
>> Additionally, the new code is also smaller than the old one and we hav=
e
>> less s390x-specific code in vl.c :-)
>>
>> I've also checked that migration still works as expected by migrating
>> a guest with console output back and forth between a qemu-system-s390x
>> that has this patch and an instance without this patch.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  RFC -> v1:
>>  - Improved the patch description (provided examples)
>>  - Moved the "init consoles" hunk in ccw_init to a later point in time
>>    so that the output of "info qom-tree" shows the same order of devic=
es
>>    in the "/machine/unattached" tree.
>>
>>  hw/s390x/event-facility.c         | 14 +++++++++++
>>  hw/s390x/s390-virtio-ccw.c        | 19 +++++++++++++--
>>  include/hw/boards.h               |  1 -
>>  include/hw/s390x/event-facility.h |  2 ++
>>  vl.c                              | 50 ------------------------------=
---------
>>  5 files changed, 33 insertions(+), 53 deletions(-)
>>
>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>> index 9c24bc6..e6940a2 100644
>> --- a/hw/s390x/event-facility.c
>> +++ b/hw/s390x/event-facility.c
>> @@ -511,3 +511,17 @@ static void register_types(void)
>>  }
>> =20
>>  type_init(register_types)
>> +
>> +BusState *sclp_get_event_facility_bus(void)
>> +{
>> +    Object *busobj;
>> +    SCLPEventsBus *sbus;
>> +
>> +    busobj =3D object_resolve_path_type("", TYPE_SCLP_EVENTS_BUS, NUL=
L);
>> +    sbus =3D OBJECT_CHECK(SCLPEventsBus, busobj, TYPE_SCLP_EVENTS_BUS=
);
>> +    if (!sbus) {
>> +        return NULL;
>> +    }
>> +
>> +    return &sbus->qbus;
>> +}
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 435f7c9..62d909e 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -288,6 +288,15 @@ static void s390_create_virtio_net(BusState *bus,=
 const char *name)
>>      }
>>  }
>> =20
>> +static void s390_create_sclpconsole(const char *type, Chardev *charde=
v)
>> +{
>> +    DeviceState *dev;
>> +
>> +    dev =3D qdev_create(sclp_get_event_facility_bus(), type);
>> +    qdev_prop_set_chr(dev, "chardev", chardev);
>> +    qdev_init_nofail(dev);
>> +}
>> +
>>  static void ccw_init(MachineState *machine)
>>  {
>>      int ret;
>> @@ -346,6 +355,14 @@ static void ccw_init(MachineState *machine)
>>      /* Create VirtIO network adapters */
>>      s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
>> =20
>> +    /* init consoles */
>> +    if (serial_hds[0]) {
>> +        s390_create_sclpconsole("sclpconsole", serial_hds[0]);
>> +    }
>> +    if (serial_hds[1]) {
>> +        s390_create_sclpconsole("sclplmconsole", serial_hds[1]);
>> +    }
>=20
> What happens if more -serial are defined? An error? Silently ignored?

Silently ignored, since this is also what almost all other machines are
doing (look for serial_hds in hw/ and you'll see what I mean).

> (e.g. do we have to redefine MAX_SERIAL_PORTS on s390x or add checking
> code here?)

As all the other machines are also not redefining MAX_SERIAL_PORTS, I
think we should also not do this on s390x now, should we?

 Thomas
