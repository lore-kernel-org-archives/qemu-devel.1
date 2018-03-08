Received: from eggs.gnu.org ([2001:4830:134:3::10]:34161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ett2U-00070V-4t
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ett2Q-0007cN-65
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:44:46 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ett2P-0007bm-VB
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:44:42 -0500
Received: by mail-wr0-f196.google.com with SMTP id p104so5153398wrc.12
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 02:44:41 -0800 (PST)
References: <20180306194600.9650-1-pbonzini@redhat.com>
	<20180306194600.9650-3-pbonzini@redhat.com>
	<ab061320-f21b-4a97-4abe-76ba33c7f1c1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <590faf90-64d2-151b-2efe-9f114329b0e3@redhat.com>
Date: Thu, 8 Mar 2018 11:44:29 +0100
MIME-Version: 1.0
In-Reply-To: <ab061320-f21b-4a97-4abe-76ba33c7f1c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] net: allow using any PCI NICs in -net
 or -nic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 08/03/2018 10:02, Thomas Huth wrote:
> On 06.03.2018 20:45, Paolo Bonzini wrote:
>> Remove the hard-coded list of PCI NIC names; instead, fill an array
>> using all PCI devices listed under DEVICE_CATEGORY_NETWORK. Keep
>> the old shortcut "virtio" for virtio-net-pci.
>>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/pci/pci.c | 61 ++++++++++++++++++++++++++++++------------------------------
>>  1 file changed, 30 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 2174c254eb..aa24a26680 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1815,49 +1815,48 @@ PciInfoList *qmp_query_pci(Error **errp)
>>      return head;
>>  }
>>  
>> -static const char * const pci_nic_models[] = {
>> -    "ne2k_pci",
>> -    "i82551",
>> -    "i82557b",
>> -    "i82559er",
>> -    "rtl8139",
>> -    "e1000",
>> -    "pcnet",
>> -    "virtio",
>> -    "sungem",
>> -    NULL
>> -};
>> -
>> -static const char * const pci_nic_names[] = {
>> -    "ne2k_pci",
>> -    "i82551",
>> -    "i82557b",
>> -    "i82559er",
>> -    "rtl8139",
>> -    "e1000",
>> -    "pcnet",
>> -    "virtio-net-pci",
>> -    "sungem",
>> -    NULL
>> -};
>> -
>>  /* Initialize a PCI NIC.  */
>>  PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>>                                 const char *default_model,
>>                                 const char *default_devaddr)
>>  {
>>      const char *devaddr = nd->devaddr ? nd->devaddr : default_devaddr;
>> +    GSList *list;
>> +    GPtrArray *pci_nic_models;
>>      PCIBus *bus;
>>      PCIDevice *pci_dev;
>>      DeviceState *dev;
>>      int devfn;
>>      int i;
>>  
>> -    if (qemu_show_nic_models(nd->model, pci_nic_models)) {
>> +    if (!strcmp(nd->model, "virtio")) {
>> +        g_free(nd->model);
>> +        nd->model = g_strdup("virtio-net-pci");
> 
> Should we maybe also print out a deprecation message in this case, so
> that we could get rid of this hack in a couple of releases? (i.e. only
> allow "virtio-net-pci" in future releases?)

I don't know... Like -net, this is probably present in countless
tutorials/blog posts, and it would be very hard to remove it.

>> +    }
>> +
>> +    list = object_class_get_list_sorted(TYPE_PCI_DEVICE, false);
>> +    pci_nic_models = g_ptr_array_new_with_free_func(g_free);
> 
> OK, so that means that the entries will be freed when the array is
> destroyed, right? ...

Duh.  valgrind isn't happy either.  I'll send v3. :(

Paolo
