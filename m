Received: from eggs.gnu.org ([209.51.188.92]:35121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEVUo-0006nA-Ho
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEVEl-0004va-S3
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:39:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:8266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hEVEk-0004ad-G2
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:39:11 -0400
Date: Thu, 11 Apr 2019 16:38:27 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190411083827.GA24390@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190411071739.22889-1-richardw.yang@linux.intel.com>
	<fc11042f-023f-3396-e68a-22dfd4ab0be7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc11042f-023f-3396-e68a-22dfd4ab0be7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: check apci hotplug capability
 before nvdimm's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Thu, Apr 11, 2019 at 10:32:39AM +0200, Thomas Huth wrote:
>On 11/04/2019 09.17, Wei Yang wrote:
>> pc_memory_pre_plug() is called during hotplug for both pc-dimm and
>> nvdimm. This is more proper to check apci hotplug capability before
>> check nvdimm specific capability.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  hw/i386/pc.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f2c15bf1f2..d48b6f9582 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2091,17 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>          return;
>>      }
>>  
>> -    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>> -        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>> -        return;
>> -    }
>> -
>>      hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>>      }
>>  
>> +    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>> +        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>> +        return;
>> +    }
>> +
>>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
>>                       pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
>>  }
>
>Works fine for me, too (i.e. no crash with older machine types).
>
>Tested-by: Thomas Huth <thuth@redhat.com>
>

Thanks :-)

-- 
Wei Yang
Help you, Help me
