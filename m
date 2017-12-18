Received: from eggs.gnu.org ([2001:4830:134:3::10]:33013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQwow-0007En-Um
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQwop-0007ne-45
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:55:11 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171217204912.12420-1-f4bug@amsat.org>
	<20171217204912.12420-3-f4bug@amsat.org>
	<d0ab7c99-1174-1629-b8ac-87961f17fc4c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3c50449d-870a-6347-74ba-cde968322891@amsat.org>
Date: Mon, 18 Dec 2017 11:54:42 -0300
MIME-Version: 1.0
In-Reply-To: <d0ab7c99-1174-1629-b8ac-87961f17fc4c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/pci-host/piix: QOM'ify the IGD
 Passthrough host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Hi Marcel,

On 12/18/2017 04:05 AM, Marcel Apfelbaum wrote:
> Hi Philippe,
> 
> Thanks for the patch.
> 
> On 17/12/2017 22:49, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci-host/piix.c | 31 +++++++++++++++----------------
>>   1 file changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
>> index a684a7cca9..0153f32a32 100644
>> --- a/hw/pci-host/piix.c
>> +++ b/hw/pci-host/piix.c
>> @@ -804,7 +804,7 @@ static const IGDHostInfo igd_host_bridge_infos[] = {
>>       {0xa8, 4},  /* SNB: base of GTT stolen memory */
>>   };
>>   -static int host_pci_config_read(int pos, int len, uint32_t *val)
>> +static void host_pci_config_read(int pos, int len, uint32_t *val,
>> Error **errp)
>>   {
>>       char path[PATH_MAX];
>>       int config_fd;
>> @@ -812,19 +812,19 @@ static int host_pci_config_read(int pos, int
>> len, uint32_t *val)
>>       /* Access real host bridge. */
>>       int rc = snprintf(path, size,
>> "/sys/bus/pci/devices/%04x:%02x:%02x.%d/%s",
>>                         0, 0, 0, 0, "config");
>> -    int ret = 0;
>>         if (rc >= size || rc < 0) {
>> -        return -ENODEV;
>> +        error_setg(&error_abort, "Invalid PCI device");
> 
> I think a return statement is missing here.

Well, error_setg(&error_abort) will never return, however checking the
documentation again I noticed I forgot these recommendations:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.
 * Likewise, don't error_setg(&error_abort, ...), use assert().

abort() might be OK but a bit harsh, so I'll use error_report() + exit()
here.

>>       }
>>         config_fd = open(path, O_RDWR);
>>       if (config_fd < 0) {
>> -        return -ENODEV;
>> +        error_setg_errno(errp, errno, "Failed to open: %s", path);
>> +        return;
>>       }
>>         if (lseek(config_fd, pos, SEEK_SET) != pos) {
>> -        ret = -errno;
>> +        error_setg_errno(errp, errno, "Failed to seek: %s", path);
>>           goto out;
>>       }
>>   @@ -832,32 +832,31 @@ static int host_pci_config_read(int pos, int
>> len, uint32_t *val)
>>           rc = read(config_fd, (uint8_t *)val, len);
>>       } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>>       if (rc != len) {
>> -        ret = -errno;
>> +        error_setg_errno(errp, errno, "Failed to read: %s", path);
>>       }
>>     out:
>>       close(config_fd);
>> -    return ret;
>>   }
>>   -static int igd_pt_i440fx_initfn(struct PCIDevice *pci_dev)
>> +static void igd_pt_i440fx_realize(PCIDevice *pci, Error **errp)
> 
> I would keep pci_dev, pci is too "broad".
> Also is kind of convention, try to grep the source code.

Ok.

> Other than that the patch looks good to me.

Thanks!

> Thanks,
> Marcel
> 
>>   {
>>       uint32_t val = 0;
>> -    int rc, i, num;
>> +    int i, num;
>>       int pos, len;
>> +    Error *local_err = NULL;
>>         num = ARRAY_SIZE(igd_host_bridge_infos);
>>       for (i = 0; i < num; i++) {
>>           pos = igd_host_bridge_infos[i].offset;
>>           len = igd_host_bridge_infos[i].len;
>> -        rc = host_pci_config_read(pos, len, &val);
>> -        if (rc) {
>> -            return -ENODEV;
>> +        host_pci_config_read(pos, len, &val, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>>           }
>> -        pci_default_write_config(pci_dev, pos, val, len);
>> +        pci_default_write_config(pci, pos, val, len);
>>       }
>> -
>> -    return 0;
>>   }
>>     static void igd_passthrough_i440fx_class_init(ObjectClass *klass,
>> void *data)
>> @@ -865,7 +864,7 @@ static void
>> igd_passthrough_i440fx_class_init(ObjectClass *klass, void *data)
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>   -    k->init = igd_pt_i440fx_initfn;
>> +    k->realize = igd_pt_i440fx_realize;
>>       dc->desc = "IGD Passthrough Host bridge";
>>   }
>>  
> 
