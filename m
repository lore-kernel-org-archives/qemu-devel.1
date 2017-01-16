Received: from eggs.gnu.org ([2001:4830:134:3::10]:43975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cT0Q7-0002cg-GZ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 01:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cT0Q3-0000es-UA
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 01:05:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:36426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guangrong.xiao@linux.intel.com>)
	id 1cT0Q3-0000W4-Id
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 01:05:27 -0500
References: <20170113115651.17607-1-haozhong.zhang@intel.com>
	<20170113131727.GA10706@stefanha-x1.localdomain>
	<20170113180243.GA3565@thinpad.lan.raisama.net>
From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Message-ID: <4ee4b67a-f00b-b2fd-f87b-4f0a74734412@linux.intel.com>
Date: Mon, 16 Jan 2017 13:55:34 +0800
MIME-Version: 1.0
In-Reply-To: <20170113180243.GA3565@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com, Richard Henderson <rth@twiddle.net>



On 01/14/2017 02:02 AM, Eduardo Habkost wrote:
> On Fri, Jan 13, 2017 at 01:17:27PM +0000, Stefan Hajnoczi wrote:
>> On Fri, Jan 13, 2017 at 07:56:51PM +0800, Haozhong Zhang wrote:
>>> The missing of 'nvdimm' in the machine type option '-M' means NVDIMM
>>> is disabled. QEMU should refuse to plug any NVDIMM device in this case
>>> and report the misconfiguration.
>>>
>>> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>>> Message-Id: 20170112110928.GF4621@stefanha-x1.localdomain
>>> Message-Id: 20170111093630.2088-1-stefanha@redhat.com
>>> ---
>>>  hw/i386/pc.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 25e8586..3907609 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -1715,6 +1715,11 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>>>      }
>>>
>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
>>> +        if (!pcms->acpi_nvdimm_state.is_enabled) {
>>> +            error_setg(&local_err,
>>> +                       "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>>> +            goto out;
>>> +        }
>>
>> A warning is definitely useful to notify users of a possible
>> configuration error.
>>
>> I wonder what happens when you plug an NVDIMM into a motherboard where
>> the firmware lacks support.  Does it:
>>  * Refuse to boot?
>>  * Treat the DIMM as regular RAM?
>>  * Boot but the DIMM will not be used by firmware and kernel?
>>
>> QEMU should act the same way as real hardware.
>
> If real hardware behavior is not useful in any way (e.g. first
> and third options above), is there a good reason for QEMU to not
> implement an additional safety mechanism preventing NVDIMM from
> being connected to a machine that doesn't support it?
>

Yes. i agree with Eduardo.

For the real hardware the behavior may be different between vendors, we
are asking our HW people to check what will happen on Intel's hardware
under this case.

Thanks!
