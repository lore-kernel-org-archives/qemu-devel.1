Received: from eggs.gnu.org ([208.118.235.92]:57864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhijianx.li@intel.com>) id 1gcmVV-0002UZ-SZ
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 02:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhijianx.li@intel.com>) id 1gcmS3-0004IF-V1
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 02:21:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:23462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhijianx.li@intel.com>)
	id 1gcmS1-00043w-CT
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 02:20:58 -0500
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-5-git-send-email-lizhijian@cn.fujitsu.com>
	<20181221110913-mutt-send-email-mst@kernel.org>
	<20181227203118.GA19442@habkost.net>
From: Li Zhijian <zhijianx.li@intel.com>
Message-ID: <45189e76-3ae0-34ab-bbef-50ab066d957e@intel.com>
Date: Fri, 28 Dec 2018 15:20:43 +0800
MIME-Version: 1.0
In-Reply-To: <20181227203118.GA19442@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 4/4] i386: allow to load initrd
 below 4G for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, philip.li@intel.com, philmd@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>


On 12/28/2018 4:31 AM, Eduardo Habkost wrote:
> On Fri, Dec 21, 2018 at 11:10:30AM -0500, Michael S. Tsirkin wrote:
>> On Thu, Dec 06, 2018 at 10:32:13AM +0800, Li Zhijian wrote:
>>>   
>>>       /* highest address for loading the initrd */
>>> -    if (protocol >= 0x203) {
>>> +    if (protocol >= 0x20c &&
>>> +        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
>>> +        /*
>>> +         * Although kernel allows initrd loading to above 4G,
>>> +         * it just makes it as large as possible while still staying below 4G
>>> +         * since current BIOS always loads initrd below pcms->below_4g_mem_size
>>> +         */
>>> +        initrd_max = UINT32_MAX;
>>> +    } else if (protocol >= 0x203) {
>>>           initrd_max = ldl_p(header+0x22c);
>>>       } else {
>>>           initrd_max = 0x37ffffff;
>>
>> I still have trouble understanding the above.
>> Anyone else wants to comment / help rephrase the comment
>> and commit log so it's readable?
>
> The comment seems to contradict what I see on the code:
>
> | Although kernel allows initrd loading to above 4G,
>
> Sounds correct.
>
>
> | it just makes it as large as possible while still staying below 4G
>
> I'm not a native English speaker, but I believe "it" here should
> be interpreted as "the kernel", which would be incorrect.  It's
> this QEMU function that limits initrd_max to a uint32 value, not
> the kernel.
>
>
> | since current BIOS always loads initrd below pcms->below_4g_mem_size
>
> I don't know why the BIOS is mentioned here.  The
> below_4g_mem_size limit comes from these 2 lines inside
> load_linux():
>
>      if (initrd_max >= pcms->below_4g_mem_size - pcmc->acpi_data_size) {
>          initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
>      }
> In addition to that, initrd_max is uint32_t simply because QEMU
> doesn't support the 64-bit boot protocol (specifically the
> ext_ramdisk_image field),

Thanks for explaining this :), i'm not clear before.



> so all talk about below_4g_mem_size
> seems to be just a distraction.
>
> All that said, I miss one piece of information here: is
> XLF_CAN_BE_LOADED_ABOVE_4G really supposed to override
> header+0x22c?  linux/Documentation/x86/boot.txt isn't clear about
> that.  Is there any reference that can help us confirm this?

Good question.

Since i'm not familiar with boot protocol, at the beginning, i also CCed to LKML for helps
https://lkml.org/lkml/2018/11/10/82

Ingo said:
>> > If XLF_CAN_BE_LOADED_ABOVE_4G is not > set, then you most likely 
>> are on a 32-bit kernel and there are more > fundamental limits (even 
>> if you were to load it above the 2 GB mark, you > would be limited by 
>> the size of kernel memory.) > > So, in case you are wondering: the 
>> bootloader that broke when setting > the initrd_max field above 2 GB 
>> was, of course, Grub. > > So just use XLF_CAN_BE_LOADED_ABOVE_4G. 
>> There is no need for a new flag > or new field. That's nice, and 
>> that's the best solution!

that make me to believe that if XLF_CAN_BE_LOADED_ABOVE_4G is set, BELOW_4G is allowed too.

if above is credible, might be we can update the comments like:
-------
QEMU doesn't support the 64-bit boot protocol (specifically the
ext_ramdisk_image field).

In addition, kernel allows to load initrd above 4G if XLF_CAN_BE_LOADED_ABOVE_4G is set,
so we believe that load initrd below 4G is allowed too.

For simplicity, so just set initrd_max to UINT32_MAX is enough and safe.
-------
  
Thanks
Zhijian
