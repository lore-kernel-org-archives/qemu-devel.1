Received: from eggs.gnu.org ([2001:4830:134:3::10]:33620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cRqDQ-0000si-7C
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 19:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@linux.intel.com>) id 1cRqDN-00021D-Lp
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 19:59:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:19565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guangrong.xiao@linux.intel.com>)
	id 1cRqDN-0001y7-BZ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 19:59:33 -0500
References: <20170111093630.2088-1-stefanha@redhat.com>
	<1b6e2788-f162-a709-f086-850adf7a70d3@linux.intel.com>
	<20170112110928.GF4621@stefanha-x1.localdomain>
From: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Message-ID: <1df82bd1-1b5d-3d68-b555-f405b43fccb0@linux.intel.com>
Date: Fri, 13 Jan 2017 08:50:11 +0800
MIME-Version: 1.0
In-Reply-To: <20170112110928.GF4621@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvdimm acpi: fix g_array_free() with NULL
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, "Zhang, Haozhong" <haozhong.zhang@intel.com>


CCed Haozhong

On 01/12/2017 07:09 PM, Stefan Hajnoczi wrote:
> On Thu, Jan 12, 2017 at 11:18:25AM +0800, Xiao Guangrong wrote:
>>
>>
>> On 01/11/2017 05:36 PM, Stefan Hajnoczi wrote:
>>> Unlike g_free(), g_array_free() does not accept a NULL pointer argument.
>>> The following error is logged when an nvdimm device is realized:
>>>
>>>   GLib-CRITICAL **: g_array_free: assertion 'array' failed
>>>
>>> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  hw/acpi/nvdimm.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> NACK
>
>>>
>>> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
>>> index 8e7d6ec..8f0a484 100644
>>> --- a/hw/acpi/nvdimm.c
>>> +++ b/hw/acpi/nvdimm.c
>>> @@ -375,7 +375,9 @@ static void nvdimm_init_fit_buffer(NvdimmFitBuffer *fit_buf)
>>>
>>>  static void nvdimm_build_fit_buffer(NvdimmFitBuffer *fit_buf)
>>>  {
>>> -    g_array_free(fit_buf->fit, true);
>>> +    if (fit_buf->fit) {
>>> +        g_array_free(fit_buf->fit, true);
>>> +    }
>>
>> Er, i do not know why it is NULL as we have init-ed it in nvdimm_init_fit_buffer:
>>
>> static void nvdimm_init_fit_buffer(NvdimmFitBuffer *fit_buf)
>> {
>>     fit_buf->fit = g_array_new(false, true /* clear */, 1);
>> }
>>
>> And i can not reproduce it on my box, could you share your command line and the
>> based commit id?
>
> Good point, it happens when nvdimm_plug() is called but -M pc,nvdimm is
> missing from the command-line.  This means nvdimm_init_acpi_state() was
> not called by pc_init1():
>
>   $ x86_64-softmmu/qemu-system-x86_64 \
>       -enable-kvm \
>       -m 1G,slots=2,maxmem=16G \
>       -drive if=virtio,file=test.img,format=raw \
>       -object memory-backend-file,id=hostmem0,mem-path=mydimm,share=on,size=8G \
>       -device nvdimm,id=nvdimm0,memdev=hostmem0
>
> Do you want to audit the code to check if anything else misbehaves when
> -device nvdimm is used without -M pc,nvdimm?

Yes. Haozhong will help me to audit the code and fix this crash.

Thanks for your report, Stefan!
