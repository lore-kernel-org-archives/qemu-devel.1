Received: from eggs.gnu.org ([2001:4830:134:3::10]:55702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dD6m6-0000oc-0q
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dD6m2-0003gY-Ra
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:10:45 -0400
Received: from [59.151.112.132] (port=26126 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dD6m2-0003dg-Fs
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:10:42 -0400
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<29c33313efd2ee4f7bf3abb71a4809582891f408.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<87wp97hqi4.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <58d3de16-a911-5f15-eac1-b9794acf38c6@cn.fujitsu.com>
Date: Tue, 23 May 2017 18:09:48 +0800
MIME-Version: 1.0
In-Reply-To: <87wp97hqi4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/4] net/rocker: Remove the dead error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, jiri@resnulli.us, f4bug@amsat.org

Hi, Markus


On 05/23/2017 05:27 PM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> Memory allocation functions like world_alloc, desc_ring_alloc etc,
>> they are all wrappers around g_malloc, g_new etc. But g_malloc and
>> similar functions doesn't return null. Because they ignore the fact
>
> don't

Will I need to make a separated patch to fix it? or when you merge to
help me repair?

Thanks a lot.

>
>> that g_malloc() of 0 bytes returns null. So error checks for these
>> allocation failure are superfluous. Now, remove them entirely.
>>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks for your quick review:)

>
> There's one more cleanup opportunity:
>
>> diff --git a/hw/net/rocker/rocker_desc.c b/hw/net/rocker/rocker_desc.c
>> index ac02797..d0df89a 100644
>> --- a/hw/net/rocker/rocker_desc.c
>> +++ b/hw/net/rocker/rocker_desc.c
>> @@ -65,10 +65,6 @@ char *desc_get_buf(DescInfo *info, bool read_only)
>>          info->buf_size = size;
>>      }
>>
>> -    if (!info->buf) {
>> -        return NULL;
>> -    }
>> -
>>      if (pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->buf, size)) {
>>          return NULL;
>>      }
>
> None of the pci_dma_read() calls outside rocker check the return value.
> Just as well, because it always returns 0.  Please clean this up in a
> separate followup patch.

Thanks for the reminder. I just read the code, it's true.
Will fix it right away.

Mao
