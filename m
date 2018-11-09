Received: from eggs.gnu.org ([2001:4830:134:3::10]:58839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKvtL-0008Ld-DV
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 20:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKvtH-0002JJ-2o
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 20:47:23 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60314
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKvtG-0002HJ-Jw
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 20:47:18 -0500
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
Date: Fri, 9 Nov 2018 09:47:10 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de
Cc: QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com, linux-kernel@vger.kernel.org


On 11/08/2018 07:06 PM, Peter Maydell wrote:
> On 8 November 2018 at 10:59, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>> x86/x86_64 has alredy supported 4G initrd.
>>
>> linux/arch/x86/boot/header.S:
>>   # (Header version 0x0203 or later) the highest safe address for the contents
>>   # of an initrd. The current kernel allows up to 4 GB, but leave it at 2 GB to
>>   # avoid possible bootloader bugs.
>>
>> CC: Philip Li <philip.li@intel.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>   hw/i386/pc.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index cd5029c..e1b910f 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -913,6 +913,12 @@ static void load_linux(PCMachineState *pcms,
>>       /* highest address for loading the initrd */
>>       if (protocol >= 0x203) {
>>           initrd_max = ldl_p(header+0x22c);
>> +        if (initrd_max == 0x7fffffff) {
>> +            /* for some reasons, initrd_max is hard code with 0x7fffffff
>> +             * hard code to 4G - 1 to allow 4G initrd
>> +             */
>> +            initrd_max = UINT32_MAX - 1;
>> +        }
> I don't understand this. If the header of the file we're using
> says "this is the maximum", then we should trust the header to
> in fact not be lying to us, shouldn't we ?
>
> If the kernel initrd creation process creates an initrd which
> is larger than 2GB and also claims that it can't be placed
> with any part of it above 2GB, then that sounds like a bug
> in the initrd creation process...

Exactly, it's a real problem.

Add x86 maintainers and LKML:

The background is that QEMU want to support up to 4G initrd. but linux header (
initrd_addr_max field) only allow 2G-1.
Is one of the below approaches reasonable:
1) change initrd_addr_max to 4G-1 directly simply(arch/x86/boot/header.S)?
2) lie QEMU bootloader the initrd_addr_max is 4G-1 even though header said 2G-1
3) any else






>
>>       } else {
>>           initrd_max = 0x37ffffff;
>>       }
> This patch should come last in the series: only after we have fixed all
> of QEMU's internal plumbing to handle larger initrd sizes should we
> enable it.

Got it.

Thanks
Zhijian

>
> thanks
> -- PMM
>
>
>
