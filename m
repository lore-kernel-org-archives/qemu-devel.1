Received: from eggs.gnu.org ([2001:4830:134:3::10]:48080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAAkW-00072Z-GF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 03:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAAkT-0001HX-DZ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 03:49:00 -0400
Received: from [59.151.112.132] (port=53891 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAAkS-0001H8-E5
	for qemu-devel@nongnu.org; Mon, 15 May 2017 03:48:57 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-6-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<adbf3cf7-29c5-13c3-c4ff-d05598c7bb17@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <34128ab7-e2b2-fb10-2dad-0f54a3f907ff@cn.fujitsu.com>
Date: Mon, 15 May 2017 15:49:05 +0800
MIME-Version: 1.0
In-Reply-To: <adbf3cf7-29c5-13c3-c4ff-d05598c7bb17@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 05/12] net/net.c: Add vnet_hdr support
 in SocketReadState
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



On 05/15/2017 12:02 PM, Jason Wang wrote:
>
>
> On 2017年05月12日 09:41, Zhang Chen wrote:
>> Address Jason Wang's comments add vnet header length to SocketReadState.
>
> Better to use "Suggested-by" instead of this :).

I got it~

>
>> We add a flag to dicide whether net_fill_rstate() to read
>> struct  {int size; int vnet_hdr_len; const uint8_t buf[];} or not.
>
> Few words to explain the format is better than e.g a struct.

OK, will fix it in next version.

>
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   include/net/net.h   |  9 +++++++--
>>   net/colo-compare.c  |  4 ++--
>>   net/filter-mirror.c |  2 +-
>>   net/net.c           | 36 ++++++++++++++++++++++++++++++++----
>>   net/socket.c        |  2 +-
>>   5 files changed, 43 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/net/net.h b/include/net/net.h
>> index 70edfc0..0763636 100644
>> --- a/include/net/net.h
>> +++ b/include/net/net.h
>> @@ -113,14 +113,19 @@ typedef struct NICState {
>>   } NICState;
>>     struct SocketReadState {
>> -    int state; /* 0 = getting length, 1 = getting data */
>> +    /* 0 = getting length, 1 = getting vnet header length, 2 = 
>> getting data */
>> +    int state;
>>       uint32_t index;
>>       uint32_t packet_len;
>> +    uint32_t vnet_hdr_len;
>>       uint8_t buf[NET_BUFSIZE];
>>       SocketReadStateFinalize *finalize;
>>   };
>>   -int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int 
>> size);
>> +int net_fill_rstate(SocketReadState *rs,
>> +                    const uint8_t *buf,
>> +                    int size,
>> +                    bool vnet_hdr);
>
> Why not just move vnet_hdr to SocketReadState?

Good idea.

Thanks
Zhang Chen

>
> Thanks
>
>>   char *qemu_mac_strdup_printf(const uint8_t *macaddr);
>>   NetClientState *qemu_find_netdev(const char *id);
>>   int qemu_find_net_clients_except(const char *id, NetClientState **ncs,
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 4ab80b1..332f57e 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -530,7 +530,7 @@ static void compare_pri_chr_in(void *opaque, 
>> const uint8_t *buf, int size)
>>       CompareState *s = COLO_COMPARE(opaque);
>>       int ret;
>>   -    ret = net_fill_rstate(&s->pri_rs, buf, size);
>> +    ret = net_fill_rstate(&s->pri_rs, buf, size, false);
>>       if (ret == -1) {
>>           qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL,
>>                                    NULL, NULL, true);
>> @@ -547,7 +547,7 @@ static void compare_sec_chr_in(void *opaque, 
>> const uint8_t *buf, int size)
>>       CompareState *s = COLO_COMPARE(opaque);
>>       int ret;
>>   -    ret = net_fill_rstate(&s->sec_rs, buf, size);
>> +    ret = net_fill_rstate(&s->sec_rs, buf, size, false);
>>       if (ret == -1) {
>>           qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL,
>>                                    NULL, NULL, true);
>> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
>> index a65853c..4649416 100644
>> --- a/net/filter-mirror.c
>> +++ b/net/filter-mirror.c
>> @@ -134,7 +134,7 @@ static void redirector_chr_read(void *opaque, 
>> const uint8_t *buf, int size)
>>       MirrorState *s = FILTER_REDIRECTOR(nf);
>>       int ret;
>>   -    ret = net_fill_rstate(&s->rs, buf, size);
>> +    ret = net_fill_rstate(&s->rs, buf, size, s->vnet_hdr);
>>         if (ret == -1) {
>>           qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
>> diff --git a/net/net.c b/net/net.c
>> index a00a0c9..a9c97cf 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -1618,13 +1618,20 @@ void net_socket_rs_init(SocketReadState *rs,
>>    * 0: success
>>    * -1: error occurs
>>    */
>> -int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
>> +int net_fill_rstate(SocketReadState *rs,
>> +                    const uint8_t *buf,
>> +                    int size,
>> +                    bool vnet_hdr)
>>   {
>>       unsigned int l;
>>         while (size > 0) {
>> -        /* reassemble a packet from the network */
>> -        switch (rs->state) { /* 0 = getting length, 1 = getting data */
>> +        /* Reassemble a packet from the network.
>> +         * 0 = getting length.
>> +         * 1 = getting vnet header length.
>> +         * 2 = getting data.
>> +         */
>> +        switch (rs->state) {
>>           case 0:
>>               l = 4 - rs->index;
>>               if (l > size) {
>> @@ -1638,10 +1645,31 @@ int net_fill_rstate(SocketReadState *rs, 
>> const uint8_t *buf, int size)
>>                   /* got length */
>>                   rs->packet_len = ntohl(*(uint32_t *)rs->buf);
>>                   rs->index = 0;
>> -                rs->state = 1;
>> +                if (vnet_hdr) {
>> +                    rs->state = 1;
>> +                } else {
>> +                    rs->state = 2;
>> +                    rs->vnet_hdr_len = 0;
>> +                }
>>               }
>>               break;
>>           case 1:
>> +            l = 4 - rs->index;
>> +            if (l > size) {
>> +                l = size;
>> +            }
>> +            memcpy(rs->buf + rs->index, buf, l);
>> +            buf += l;
>> +            size -= l;
>> +            rs->index += l;
>> +            if (rs->index == 4) {
>> +                /* got vnet header length */
>> +                rs->vnet_hdr_len = ntohl(*(uint32_t *)rs->buf);
>> +                rs->index = 0;
>> +                rs->state = 2;
>> +            }
>> +            break;
>> +        case 2:
>>               l = rs->packet_len - rs->index;
>>               if (l > size) {
>>                   l = size;
>> diff --git a/net/socket.c b/net/socket.c
>> index b8c931e..4e58eff 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -182,7 +182,7 @@ static void net_socket_send(void *opaque)
>>       }
>>       buf = buf1;
>>   -    ret = net_fill_rstate(&s->rs, buf, size);
>> +    ret = net_fill_rstate(&s->rs, buf, size, false);
>>         if (ret == -1) {
>>           goto eoc;
>
>
>
> .
>

-- 
Thanks
Zhang Chen
