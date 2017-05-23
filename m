Received: from eggs.gnu.org ([2001:4830:134:3::10]:38347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD7Qs-0006HL-0s
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD7Qn-0001mQ-IV
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD7Qn-0001kb-DF
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:52:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<29c33313efd2ee4f7bf3abb71a4809582891f408.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<87wp97hqi4.fsf@dusky.pond.sub.org>
	<58d3de16-a911-5f15-eac1-b9794acf38c6@cn.fujitsu.com>
Date: Tue, 23 May 2017 12:52:45 +0200
In-Reply-To: <58d3de16-a911-5f15-eac1-b9794acf38c6@cn.fujitsu.com> (Mao
	Zhongyi's message of "Tue, 23 May 2017 18:09:48 +0800")
Message-ID: <8760gretfm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: jasowang@redhat.com, jiri@resnulli.us, qemu-devel@nongnu.org, f4bug@amsat.org

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> Hi, Markus
>
>
> On 05/23/2017 05:27 PM, Markus Armbruster wrote:
>> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>>
>>> Memory allocation functions like world_alloc, desc_ring_alloc etc,
>>> they are all wrappers around g_malloc, g_new etc. But g_malloc and
>>> similar functions doesn't return null. Because they ignore the fact
>>
>> don't
>
> Will I need to make a separated patch to fix it? or when you merge to
> help me repair?

Perhaps Jason can touch it up on commit.

> Thanks a lot.
>
>>
>>> that g_malloc() of 0 bytes returns null. So error checks for these
>>> allocation failure are superfluous. Now, remove them entirely.
>>>
>>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks for your quick review:)

You're welcome.

>> There's one more cleanup opportunity:
>>
>>> diff --git a/hw/net/rocker/rocker_desc.c b/hw/net/rocker/rocker_desc.c
>>> index ac02797..d0df89a 100644
>>> --- a/hw/net/rocker/rocker_desc.c
>>> +++ b/hw/net/rocker/rocker_desc.c
>>> @@ -65,10 +65,6 @@ char *desc_get_buf(DescInfo *info, bool read_only)
>>>          info->buf_size = size;
>>>      }
>>>
>>> -    if (!info->buf) {
>>> -        return NULL;
>>> -    }
>>> -
>>>      if (pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->buf, size)) {
>>>          return NULL;
>>>      }
>>
>> None of the pci_dma_read() calls outside rocker check the return value.
>> Just as well, because it always returns 0.  Please clean this up in a
>> separate followup patch.
>
> Thanks for the reminder. I just read the code, it's true.
> Will fix it right away.

Thanks!
