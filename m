Received: from eggs.gnu.org ([2001:4830:134:3::10]:36252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dN0BI-00061x-EC
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dN0BE-0002Sx-6S
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dN0BD-0002S1-Th
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:09:36 -0400
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170619142852.GS5016@thinpad.lan.raisama.net>
	<7d5904ae-e66c-5594-cfff-747578d91f4b@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <08da52ec-e4d2-d836-49bd-90baf21747fb@redhat.com>
Date: Mon, 19 Jun 2017 19:09:13 +0200
MIME-Version: 1.0
In-Reply-To: <7d5904ae-e66c-5594-cfff-747578d91f4b@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

On 06/19/17 18:57, Mark Cave-Ayland wrote:
> On 19/06/17 15:28, Eduardo Habkost wrote:
> 
>> On Mon, Jun 19, 2017 at 01:59:07PM +0100, Mark Cave-Ayland wrote:
>>> In preparation for calling fw_cfg_init1() during realize rather than during
>>> init, move the assert() checking for existing fw_cfg devices and the linking
>>> of the device to the machine with object_property_add_child() to a new
>>> fw_cfg instance_init() function.
>>>
>>> This guarantees that we will still assert() correctly if more than one fw_cfg
>>> device is instantiated by accident.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>> Tested-by: Laszlo Ersek <lersek@redhat.com>
>>> ---
>>>  hw/nvram/fw_cfg.c |   14 ++++++++++----
>>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>> index 99bdbc2..af45012 100644
>>> --- a/hw/nvram/fw_cfg.c
>>> +++ b/hw/nvram/fw_cfg.c
>>> @@ -915,10 +915,6 @@ static void fw_cfg_init1(DeviceState *dev)
>>>      MachineState *machine = MACHINE(qdev_get_machine());
>>>      uint32_t version = FW_CFG_VERSION;
>>>  
>>> -    assert(!object_resolve_path(FW_CFG_PATH, NULL));
>>> -
>>> -    object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
>>> -
>>>      qdev_init_nofail(dev);
>>>  
>>>      fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
>>> @@ -1020,6 +1016,15 @@ FWCfgState *fw_cfg_find(void)
>>>      return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
>>>  }
>>>  
>>> +static void fw_cfg_init(Object *obj)
>>> +{
>>> +    MachineState *machine = MACHINE(qdev_get_machine());
>>> +
>>> +    assert(!object_resolve_path(FW_CFG_PATH, NULL));
>>> +
>>> +    object_property_add_child(OBJECT(machine), FW_CFG_NAME, obj, NULL);
>>
>> I don't think this belongs to instance_init.  We must always be
>> able to instantiate objects without crashing QEMU or affecting
>> QEMU global state.  This patch makes device-list-properties
>> crash:
>>
>>   $ qemu-system-x86_64 -display none -qmp unix:/tmp/qmp,server,nowait &
>>   [1] 2848
>>   $ echo 'device-list-properties typename=fw_cfg_mem' | ./scripts/qmp/qmp-shell /tmp/qmp
>>   Welcome to the QMP low-level shell!
>>   Connected to QEMU 2.9.50
>>   
>>   qemu-system-x86_64: qemu/hw/nvram/fw_cfg.c:974: fw_cfg_init: Assertion `!object_resolve_path(FW_CFG_PATH, NULL)' failed.
>>   (QEMU) Disconnected
>>   [1]+  Aborted                 (core dumped) qemu-system-x86_64 -display none -qmp unix:/tmp/qmp,server,nowait
>>   $ 
>>
>>
>> I suggest moving this check to realize, like the rest of
>> fw_cfg_init1(), but change it to do proper error reporting
>> instead of asserting.
> 
> In that case what do you think is the best way to prevent realization of
> a second instance? With some playing I've managed to come up with the
> following (partial) diff that seems to work in some simple local tests:
> 
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 9b0aaa2..e678ec0 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -862,12 +862,20 @@ static void fw_cfg_machine_ready(struct Notifier
> *n, void *data)
> 
> -static void fw_cfg_common_realize(DeviceState *dev)
> +static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
>  {
>      FWCfgState *s = FW_CFG(dev);
>      MachineState *machine = MACHINE(qdev_get_machine());
>      uint32_t version = FW_CFG_VERSION;
> -
> +    Object *obj;
> +
> +    obj = object_resolve_path(FW_CFG_PATH, NULL);
> +    if (obj != OBJECT(dev)) {
> +        error_setg(errp, "Only one fw_cfg device can be instantiated per "
> +                         "machine");
> +        return;
> +    }
> +
>      fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
>      fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
>      fw_cfg_add_i16(s, FW_CFG_NOGRAPHIC,
> (uint16_t)!machine->enable_graphics);
> 
> 
> What seems to happen is that calling object_property_add_child() only
> succeeds for the first instance and so a simple comparison is enough to
> determine that the device already exists at FW_CFG_PATH. Or is this a
> fairly terrible (ab)use of the QOM APIs?

This has jogged my memory about how we ensure "at most one" for the
vmgenid device. Please see:

  vmgenid_realize()    [hw/acpi/vmgenid.c]
    find_vmgenid_dev() [include/hw/acpi/vmgenid.h]

... I was quite silly not to think of this on my own now, despite having
authored commit f92063028a0e ("hw/acpi/vmgenid: prevent more than one
vmgenid device", 2017-03-20) :/

Thanks,
Laszlo
