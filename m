Received: from eggs.gnu.org ([2001:4830:134:3::10]:55337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVZKi-0003F9-LN
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVZKd-0000Bu-MS
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVZKd-0000B6-D2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:18:43 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-12-git-send-email-borntraeger@de.ibm.com>
	<27238e54-2a92-dbb8-73b0-e3f5b0e67934@redhat.com>
	<2c703b61-a77f-c5dc-0f26-9af136dd8181@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b0663361-85e6-81aa-a988-7fec18e23dfd@redhat.com>
Date: Thu, 13 Jul 2017 10:18:39 +0200
MIME-Version: 1.0
In-Reply-To: <2c703b61-a77f-c5dc-0f26-9af136dd8181@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/11] s390x/css: update
 css_adapter_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Fei Li <sherrylf@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 13.07.2017 10:08, Christian Borntraeger wrote:
> On 07/12/2017 04:26 PM, Thomas Huth wrote:
>> On 12.07.2017 14:57, Christian Borntraeger wrote:
>>> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>
>>> Let's use the new inject_airq callback of flic to inject adapter
>>> interrupts. For kvm case, if the kernel flic doesn't support the new
>>> interface, the irq routine remains unchanged. For non-kvm case,
>>> qemu-flic handles the suppression process.
>>>
>>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>> Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  hw/s390x/css.c          | 18 ++++++++++++++++--
>>>  hw/s390x/s390-pci-bus.c |  2 +-
>>>  hw/s390x/virtio-ccw.c   |  2 +-
>>>  include/hw/s390x/css.h  |  2 +-
>>>  4 files changed, 19 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>> index 7b82176..ee4ebbf 100644
>>> --- a/hw/s390x/css.c
>>> +++ b/hw/s390x/css.c
>>> @@ -547,12 +547,26 @@ out:
>>>      return r;
>>>  }
>>>  
>>> -void css_adapter_interrupt(uint8_t isc)
>>> +void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
>>>  {
>>> +    S390FLICState *fs = s390_get_flic();
>>> +    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
>>>      uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
>>> +    IoAdapter *adapter = channel_subsys.io_adapters[type][isc];
>>> +
>>> +    if (!adapter) {
>>> +        return;
>>> +    }
>>>  
>>>      trace_css_adapter_interrupt(isc);
>>> -    s390_io_interrupt(0, 0, 0, io_int_word);
>>> +    if (fs->ais_supported) {
>>> +        if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
>>> +            fprintf(stderr, "Failed to inject airq with AIS supported\n");
>>
>> Use error_report() instead?
> 
> something like this on top?
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 3d28caa..997815c 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -674,7 +674,7 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
>      trace_css_adapter_interrupt(isc);
>      if (fs->ais_supported) {
>          if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
> -            fprintf(stderr, "Failed to inject airq with AIS supported\n");
> +            error_report("Failed to inject airq with AIS supported");
>              exit(1);
>          }
>      } else {

Yes, that looks fine. Alternatively, this could maybe be a g_assert()
instead? ... but then you don't get the nice error message anymore, so I
think error_report + exit is OK here.

 Thomas
