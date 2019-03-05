Received: from eggs.gnu.org ([209.51.188.92]:40681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h13yf-0007H2-4N
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h13ye-00030r-9n
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:55:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-5-armbru@redhat.com>
	<9218d2e9-5519-055b-dfb9-e78f99559b80@redhat.com>
Date: Tue, 05 Mar 2019 07:54:53 +0100
In-Reply-To: <9218d2e9-5519-055b-dfb9-e78f99559b80@redhat.com> (Thomas Huth's
	message of "Mon, 4 Mar 2019 19:45:07 +0100")
Message-ID: <87mum9x136.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] sysbus: Fix latent bug with
 onboard devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, lersek@redhat.com

Thomas Huth <thuth@redhat.com> writes:

> On 25/02/2019 19.37, Markus Armbruster wrote:
>> The first call of sysbus_get_default() creates the main system bus and
>> stores it in QOM as "/machine/unattached/sysbus".  This must not
>> happen before main() creates "/machine", or else container_get() would
>> "helpfully" create it as "container" object, and the real creation of
>> "/machine" would later abort with "attempt to add duplicate property
>> 'machine' to object (type 'container')".  Has been that way ever since
>> we wired up busses in QOM (commit f968fc6892d, v1.2.0).
>> 
>> I believe the bug is latent.  I got it to bite by trying to
>> qdev_create() a sysbus device from a machine's .instance_init()
>> method.
>> 
>> The fix is obvious: store the main system bus in QOM right after
>> creating "/machine".
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/core/sysbus.c | 3 ---
>>  vl.c             | 4 ++++
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
>> index 9f9edbcab9..307cf90a51 100644
>> --- a/hw/core/sysbus.c
>> +++ b/hw/core/sysbus.c
>> @@ -357,9 +357,6 @@ static void main_system_bus_create(void)
>>      qbus_create_inplace(main_system_bus, system_bus_info.instance_size,
>>                          TYPE_SYSTEM_BUS, NULL, "main-system-bus");
>>      OBJECT(main_system_bus)->free = g_free;
>> -    object_property_add_child(container_get(qdev_get_machine(),
>> -                                            "/unattached"),
>> -                              "sysbus", OBJECT(main_system_bus), NULL);
>>  }
>>  
>>  BusState *sysbus_get_default(void)
>> diff --git a/vl.c b/vl.c
>> index e3fdce410f..6ce3d2d448 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -3990,6 +3990,10 @@ int main(int argc, char **argv, char **envp)
>>      }
>>      object_property_add_child(object_get_root(), "machine",
>>                                OBJECT(current_machine), &error_abort);
>> +    object_property_add_child(container_get(OBJECT(current_machine),
>> +                                            "/unattached"),
>> +                              "sysbus", OBJECT(sysbus_get_default()),
>> +                              NULL);
>>  
>>      if (machine_class->minimum_page_bits) {
>>          if (!set_preferred_target_page_bits(machine_class->minimum_page_bits)) {
>> 
>
> Looks right. Especially, a device should also not add itself to a
> parent, so this definitely should not be done in sysbus.c
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>
> PS: Not directly related to your patch, but in a separate patch we
> should also object_unref(current_machine) here to drop the superfluous
> second reference to current_machine after we added it as a child of the
> root object.

Just for cleanliness.  Makes sense.

Thanks!
