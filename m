Received: from eggs.gnu.org ([2001:4830:134:3::10]:43060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d5jjz-00062f-7J
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d5jjv-00087N-NU
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:10:07 -0400
Received: from [59.151.112.132] (port=59724 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d5jju-000855-QK
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:10:03 -0400
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1493372840-24551-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<d487205d-6957-d8c1-678a-38a5668586df@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <aaf193ca-42fc-9117-71c7-d8520639b406@cn.fujitsu.com>
Date: Wed, 3 May 2017 10:08:40 +0700
MIME-Version: 1.0
In-Reply-To: <d487205d-6957-d8c1-678a-38a5668586df@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V3 01/10] net: Add vnet_hdr_len related
 callback in NetClientInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 05/02/2017 12:46 PM, Jason Wang wrote:
>
>
> On 2017年04月28日 17:47, Zhang Chen wrote:
>> Add get_vnet_hdr_len and get_using_vnet_hdr callback
>> that make we get vnet_hdr_len easily.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   include/net/net.h |  6 ++++++
>>   net/net.c         | 18 ++++++++++++++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/include/net/net.h b/include/net/net.h
>> index 99b28d5..402d913 100644
>> --- a/include/net/net.h
>> +++ b/include/net/net.h
>> @@ -57,7 +57,9 @@ typedef RxFilterInfo 
>> *(QueryRxFilter)(NetClientState *);
>>   typedef bool (HasUfo)(NetClientState *);
>>   typedef bool (HasVnetHdr)(NetClientState *);
>>   typedef bool (HasVnetHdrLen)(NetClientState *, int);
>> +typedef int (GetVnetHdrLen)(NetClientState *);
>>   typedef void (UsingVnetHdr)(NetClientState *, bool);
>> +typedef bool (GetUsingVnetHdr)(NetClientState *);
>>   typedef void (SetOffload)(NetClientState *, int, int, int, int, int);
>>   typedef void (SetVnetHdrLen)(NetClientState *, int);
>>   typedef int (SetVnetLE)(NetClientState *, bool);
>> @@ -79,7 +81,9 @@ typedef struct NetClientInfo {
>>       HasUfo *has_ufo;
>>       HasVnetHdr *has_vnet_hdr;
>>       HasVnetHdrLen *has_vnet_hdr_len;
>> +    GetVnetHdrLen *get_vnet_hdr_len;
>>       UsingVnetHdr *using_vnet_hdr;
>> +    GetUsingVnetHdr *get_using_vnet_hdr;
>>       SetOffload *set_offload;
>>       SetVnetHdrLen *set_vnet_hdr_len;
>>       SetVnetLE *set_vnet_le;
>> @@ -155,7 +159,9 @@ void qemu_format_nic_info_str(NetClientState *nc, 
>> uint8_t macaddr[6]);
>>   bool qemu_has_ufo(NetClientState *nc);
>>   bool qemu_has_vnet_hdr(NetClientState *nc);
>>   bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
>> +int qemu_get_vnet_hdr_len(NetClientState *nc);
>>   void qemu_using_vnet_hdr(NetClientState *nc, bool enable);
>> +bool qemu_get_using_vnet_hdr(NetClientState *nc);
>>   void qemu_set_offload(NetClientState *nc, int csum, int tso4, int 
>> tso6,
>>                         int ecn, int ufo);
>>   void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
>> diff --git a/net/net.c b/net/net.c
>> index 0ac3b9e..f69260f 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -466,6 +466,15 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, 
>> int len)
>>       return nc->info->has_vnet_hdr_len(nc, len);
>>   }
>>   +int qemu_get_vnet_hdr_len(NetClientState *nc)
>> +{
>> +    if (!nc || !nc->info->get_vnet_hdr_len) {
>> +        return false;
>> +    }
>> +
>> +    return nc->info->get_vnet_hdr_len(nc);
>> +}
>> +
>>   void qemu_using_vnet_hdr(NetClientState *nc, bool enable)
>>   {
>>       if (!nc || !nc->info->using_vnet_hdr) {
>> @@ -475,6 +484,15 @@ void qemu_using_vnet_hdr(NetClientState *nc, 
>> bool enable)
>>       nc->info->using_vnet_hdr(nc, enable);
>>   }
>>   +bool qemu_get_using_vnet_hdr(NetClientState *nc)
>> +{
>> +    if (!nc || !nc->info->get_using_vnet_hdr) {
>> +        return false;
>> +    }
>> +
>> +    return nc->info->get_using_vnet_hdr(nc);
>> +}
>
> Looks like we can do this simply by:
>
> Introduce two common fields in NetClientState:
>
> bool using_vnet_hdr;
> int vnet_hdr_len;
>
> And set them during qemu_using_vnet_hdr() and qemu_set_vnet_hdr_len(). 
> Then we can query them directly without introducing any new callbacks.

Good idea~
I will implement in next version.

Thanks
Zhang Chen

>
> Thanks
>
>> +
>>   void qemu_set_offload(NetClientState *nc, int csum, int tso4, int 
>> tso6,
>>                             int ecn, int ufo)
>>   {
>
>
>
> .
>

-- 
Thanks
Zhang Chen
