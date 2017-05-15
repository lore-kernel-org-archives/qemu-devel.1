Received: from eggs.gnu.org ([2001:4830:134:3::10]:55460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAB9E-0004ji-Er
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAB9A-00062C-Fh
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:14:32 -0400
Received: from [59.151.112.132] (port=16936 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAB99-0005zO-Nt
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:14:28 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<80a52ceb-6e69-f4ee-04c7-1219bb7947c1@amsat.org>
	<ed2e0bd5-4a69-63d9-497c-b0b6aaac404d@redhat.com>
	<11a77586-ec42-d1cd-f4d1-f7444cf5febb@cn.fujitsu.com>
	<8bc88f06-105e-db58-9a73-a0b76769ca64@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <1b884ac2-0cd4-bbd6-0b60-6c232f995781@cn.fujitsu.com>
Date: Mon, 15 May 2017 16:14:36 +0800
MIME-Version: 1.0
In-Reply-To: <8bc88f06-105e-db58-9a73-a0b76769ca64@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 01/12] net: Add vnet_hdr_len related
 arguments in NetClientState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, bian naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>



On 05/15/2017 04:06 PM, Jason Wang wrote:
>
>
> On 2017年05月15日 14:56, Zhang Chen wrote:
>>
>>
>> On 05/15/2017 11:24 AM, Jason Wang wrote:
>>>
>>>
>>> On 2017年05月14日 05:24, Philippe Mathieu-Daudé wrote:
>>>> Hi Zhang
>>>>
>>>> On 05/11/2017 10:41 PM, Zhang Chen wrote:
>>>>> Add vnet_hdr_len and using_vnet_hdr arguments in NetClientState
>>>>> that make othermodule get real vnet_hdr_len easily.
>>>>>
>>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>>> ---
>>>>>  include/net/net.h | 2 ++
>>>>>  net/net.c         | 2 ++
>>>>>  2 files changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/include/net/net.h b/include/net/net.h
>>>>> index 99b28d5..70edfc0 100644
>>>>> --- a/include/net/net.h
>>>>> +++ b/include/net/net.h
>>>>> @@ -100,6 +100,8 @@ struct NetClientState {
>>>>>      unsigned int queue_index;
>>>>>      unsigned rxfilter_notify_enabled:1;
>>>>>      int vring_enable;
>>>>> +    bool using_vnet_hdr;
>>>>> +    int vnet_hdr_len;
>>>>>      QTAILQ_HEAD(NetFilterHead, NetFilterState) filters;
>>>>>  };
>>>>>
>>>>> diff --git a/net/net.c b/net/net.c
>>>>> index 0ac3b9e..a00a0c9 100644
>>>>> --- a/net/net.c
>>>>> +++ b/net/net.c
>>>>> @@ -472,6 +472,7 @@ void qemu_using_vnet_hdr(NetClientState *nc, 
>>>>> bool enable)
>>>>>          return;
>>>>>      }
>>>>>
>>>>> +    nc->using_vnet_hdr = enable;
>>>>>      nc->info->using_vnet_hdr(nc, enable);
>>>>>  }
>>>>>
>>>>> @@ -491,6 +492,7 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, 
>>>>> int len)
>>>>>          return;
>>>>>      }
>>>>>
>>>>> +    nc->vnet_hdr_len = len;
>>>>>      nc->info->set_vnet_hdr_len(nc, len);
>>>>>  }
>>>>>
>>>>
>>>> For what it's worth, now having those fields in NetClientState it 
>>>> is possible to remove a deref to NetClientInfo in 
>>>> qemu_has_vnet_hdr() and qemu_has_vnet_hdr_len().
>>>>
>>>> Anyway,
>>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>
>>>>
>>>
>>> Yes and this could be done on top with removing private e.g 
>>> vnet_hdr_len.
>>
>> Do you means we will remove the qemu_has_vnet_hdr() and 
>> qemu_has_vnet_hdr_len() in the future?
>>
>> Thanks
>> Zhang Chen
>
> Yes and e.g both tap and netmap have its private vnet header field. We 
> can remove them too.

Maybe I should do this job in this series next version or a independent 
series?

Thanks
Zhang Chen

>
> Thanks
>
>>
>>>
>>> Thanks
>>>
>>>
>>> .
>>>
>>
>
>
>
> .
>

-- 
Thanks
Zhang Chen
