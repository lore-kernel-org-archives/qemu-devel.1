Received: from eggs.gnu.org ([2001:4830:134:3::10]:35377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dBI0t-0005l9-N6
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dBI0p-0006DQ-Ma
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:46:31 -0400
Received: from [59.151.112.132] (port=35136 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dBI0p-0006CW-9m
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:46:27 -0400
References: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
	<c1f2bc8f51ab57ad99e103af6b36320ba8980fe2.1495018956.git.maozy.fnst@cn.fujitsu.com>
	<5e8882a9-d442-b306-3468-8a2f1b33f424@amsat.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <02d11dcc-7155-6349-4e94-534c4041ad80@cn.fujitsu.com>
Date: Thu, 18 May 2017 17:45:55 +0800
MIME-Version: 1.0
In-Reply-To: <5e8882a9-d442-b306-3468-8a2f1b33f424@amsat.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/3] net/rocker: Plug memory leak in
 pci_rocker_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com

Hi, Philippe
Thanks for your quick review:)

On 05/18/2017 01:22 AM, Philippe Mathieu-Daudé wrote:
> Hi Mao,
>
> On 05/17/2017 08:12 AM, Mao Zhongyi wrote:
>> pci_rocker_init() leaks a World when the name more than 9 chars,
>> then return a negative value directly, doesn't make a correct
>> cleanup. So add a new goto label to fix it.
>>
>> Cc: jasowang@redhat.com
>> Cc: jiri@resnulli.us
>> Cc: f4bug@amsat.org
>> Cc: armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  hw/net/rocker/rocker.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
>> index b2b6dc7..a382a6f 100644
>> --- a/hw/net/rocker/rocker.c
>> +++ b/hw/net/rocker/rocker.c
>> @@ -1371,7 +1371,8 @@ static int pci_rocker_init(PCIDevice *dev)
>>          fprintf(stderr,
>
> While here can you update fprintf -> qemu_log_mask?

In the patch 3, fprintf() has been updated to err_setg() which output error message
for more user-friendly. I'm not very clear why convert it to qemu_log_mask(). Could
you give me more hints about this?

Meanwhile, updating to qemu_log_mask() results in a segmentation fault. Because the
World memory was freed for 2 times. The first time is when the name more than 9 chars,
It was freed by the goto label "err_name_too_long" in the pci_rocker_realize(), the
second is freed by qemu_system_reset() which called in the main().

So I think convert it to Error maybe a little better. What do you think?

Thanks
Mao

>
>>                  "rocker: name too long; please shorten to at most %d chars\n",
>>                  MAX_ROCKER_NAME_LEN);
>> -        return -EINVAL;
>> +        err = -EINVAL;
>> +        goto err_name_too_long;
>>      }
>>
>>      if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) == 0) {
>> @@ -1430,6 +1431,7 @@ static int pci_rocker_init(PCIDevice *dev)
>>
>>      return 0;
>>
>> +err_name_too_long:
>>  err_duplicate:
>>      rocker_msix_uninit(r);
>>  err_msix_init:
>>
>
>
>
