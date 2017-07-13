Received: from eggs.gnu.org ([2001:4830:134:3::10]:53603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVZAv-0000DC-RD
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVZAs-0001L0-Kp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:08:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVZAs-0001KB-AQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:08:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D83uKa061649
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 04:08:36 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3r53u5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 04:08:35 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 04:08:34 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-12-git-send-email-borntraeger@de.ibm.com>
	<27238e54-2a92-dbb8-73b0-e3f5b0e67934@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 10:08:29 +0200
MIME-Version: 1.0
In-Reply-To: <27238e54-2a92-dbb8-73b0-e3f5b0e67934@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <2c703b61-a77f-c5dc-0f26-9af136dd8181@de.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Fei Li <sherrylf@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 07/12/2017 04:26 PM, Thomas Huth wrote:
> On 12.07.2017 14:57, Christian Borntraeger wrote:
>> From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>
>> Let's use the new inject_airq callback of flic to inject adapter
>> interrupts. For kvm case, if the kernel flic doesn't support the new
>> interface, the irq routine remains unchanged. For non-kvm case,
>> qemu-flic handles the suppression process.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/css.c          | 18 ++++++++++++++++--
>>  hw/s390x/s390-pci-bus.c |  2 +-
>>  hw/s390x/virtio-ccw.c   |  2 +-
>>  include/hw/s390x/css.h  |  2 +-
>>  4 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 7b82176..ee4ebbf 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -547,12 +547,26 @@ out:
>>      return r;
>>  }
>>  
>> -void css_adapter_interrupt(uint8_t isc)
>> +void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
>>  {
>> +    S390FLICState *fs = s390_get_flic();
>> +    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
>>      uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
>> +    IoAdapter *adapter = channel_subsys.io_adapters[type][isc];
>> +
>> +    if (!adapter) {
>> +        return;
>> +    }
>>  
>>      trace_css_adapter_interrupt(isc);
>> -    s390_io_interrupt(0, 0, 0, io_int_word);
>> +    if (fs->ais_supported) {
>> +        if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
>> +            fprintf(stderr, "Failed to inject airq with AIS supported\n");
> 
> Use error_report() instead?

something like this on top?

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 3d28caa..997815c 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -674,7 +674,7 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
     trace_css_adapter_interrupt(isc);
     if (fs->ais_supported) {
         if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
-            fprintf(stderr, "Failed to inject airq with AIS supported\n");
+            error_report("Failed to inject airq with AIS supported");
             exit(1);
         }
     } else {
