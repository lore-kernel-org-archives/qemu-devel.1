Received: from eggs.gnu.org ([2001:4830:134:3::10]:44221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cS238-00022v-2H
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cS235-0000vS-02
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:37:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:61174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cS234-0000vA-Mn
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:37:42 -0500
Date: Fri, 13 Jan 2017 21:37:38 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170113133738.k3vyvysehcz2gppc@hz-desktop>
References: <20170113115651.17607-1-haozhong.zhang@intel.com>
	<20170113131727.GA10706@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20170113131727.GA10706@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: check if nvdimm is enabled before
 plugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com

On 01/13/17 13:17 +0000, Stefan Hajnoczi wrote:
>On Fri, Jan 13, 2017 at 07:56:51PM +0800, Haozhong Zhang wrote:
>> The missing of 'nvdimm' in the machine type option '-M' means NVDIMM
>> is disabled. QEMU should refuse to plug any NVDIMM device in this case
>> and report the misconfiguration.
>>
>> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> Message-Id: 20170112110928.GF4621@stefanha-x1.localdomain
>> Message-Id: 20170111093630.2088-1-stefanha@redhat.com
>> ---
>>  hw/i386/pc.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 25e8586..3907609 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1715,6 +1715,11 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>>      }
>>
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
>> +        if (!pcms->acpi_nvdimm_state.is_enabled) {
>> +            error_setg(&local_err,
>> +                       "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>> +            goto out;
>> +        }
>
>A warning is definitely useful to notify users of a possible
>configuration error.

If NVDIMM is plugged at boot time, QEMU with this patch will stop and report a
message like
    qemu-system-x86_64: -device nvdimm,...: nvdimm is not enabled: missing 'nvdimm' in '-M'

If NVDIMM is plugged via 'device_add' command, QEMU with this patch will report a warning message
    nvdimm is not enabled: missing 'nvdimm' in '-M'
and continue to run w/o plugging this device.

>
>I wonder what happens when you plug an NVDIMM into a motherboard where
>the firmware lacks support.  Does it:
> * Refuse to boot?
> * Treat the DIMM as regular RAM?
> * Boot but the DIMM will not be used by firmware and kernel?

Good question. Guangrong, any idea?

Thanks,
Haozhong

>
>QEMU should act the same way as real hardware.
>
>Stefan
