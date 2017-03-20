Received: from eggs.gnu.org ([2001:4830:134:3::10]:58183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cpz0G-0006UJ-W8
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cpz0F-000798-V5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:13:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cpz0F-00078z-MB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:13:47 -0400
References: <20170320115951.25345-1-lersek@redhat.com>
	<20170320115951.25345-3-lersek@redhat.com>
	<20170320161539-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <783bd4f6-faf9-1562-99f6-36556ed3d0cb@redhat.com>
Date: Mon, 20 Mar 2017 16:13:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170320161539-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/acpi/vmgenid: prevent more than one
 vmgenid device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>

On 03/20/17 15:16, Michael S. Tsirkin wrote:
> On Mon, Mar 20, 2017 at 12:59:51PM +0100, Laszlo Ersek wrote:
>> Multiple instances make no sense.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Ben Warren <ben@skyportsystems.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> 
> find_vmgenid_dev would be a better place for this.
> This is where the single instance assumption comes from ATM.

object_resolve_path_type() -- used internally in find_vmgenid_dev() --
returns NULL in either of two cases: there is no such device, or there
are multiple devices. You can tell them apart by looking at the last
parameter (called "ambiguous"), but find_vmgenid_dev() doesn't use that
parameter.

By the time we are in the vmgenid_realize() function, at least one
vmgenid device is guaranteed to exist (the one which we are realizing).
Therefore, this patch could be simplified as:

if (find_vmgenid_dev() == NULL) {
  error_setg(errp, "at most one %s device is permitted", VMGENID_DEVICE);
  return;
}

I found that confusing, and wanted to spell out "ambiguous" with the
assert(). If you prefer the above simpler (but harder to understand)
check, I can do that too.

Thanks
Laszlo

> 
> 
>> ---
>>  hw/acpi/vmgenid.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>> index c3ddcc8e7cb0..b5c0dfcf19e1 100644
>> --- a/hw/acpi/vmgenid.c
>> +++ b/hw/acpi/vmgenid.c
>> @@ -214,6 +214,8 @@ static Property vmgenid_properties[] = {
>>  static void vmgenid_realize(DeviceState *dev, Error **errp)
>>  {
>>      VmGenIdState *vms = VMGENID(dev);
>> +    Object *one_vmgenid;
>> +    bool ambiguous;
>>  
>>      if (!vms->write_pointer_available) {
>>          error_setg(errp, "%s requires DMA write support in fw_cfg, "
>> @@ -221,6 +223,14 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
>>          return;
>>      }
>>  
>> +    one_vmgenid = object_resolve_path_type("", VMGENID_DEVICE, &ambiguous);
>> +    if (one_vmgenid == NULL) {
>> +        assert(ambiguous);
>> +        error_setg(errp, "at most one %s device is permitted", VMGENID_DEVICE);
>> +        return;
>> +    }
>> +    assert(one_vmgenid == OBJECT(vms));
>> +
>>      qemu_register_reset(vmgenid_handle_reset, vms);
>>  }
>>  
>> -- 
>> 2.9.3
