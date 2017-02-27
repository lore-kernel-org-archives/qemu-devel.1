Received: from eggs.gnu.org ([2001:4830:134:3::10]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciFC7-0003og-Ht
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 01:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciFC4-0005ea-EX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 01:54:03 -0500
Received: from [45.249.212.188] (port=2940 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciFC3-0005dq-91
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 01:54:00 -0500
References: <1487735198-127300-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487735198-127300-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<b0b04c02-7c97-ea04-1e38-99fd9344edae@redhat.com>
	<58AD4F8F.5030703@huawei.com> <58AD5125.4010306@huawei.com>
	<b792c68e-d67a-ac24-26ea-aaf24f1f9437@redhat.com>
	<58B398F8.1020205@huawei.com>
	<c7883f1d-99ed-d082-3eee-7e0c641257e6@redhat.com>
	<58B3A688.5040707@huawei.com>
	<3196d413-e99a-561a-310d-4d2fa93559d9@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58B3CCFE.5070909@huawei.com>
Date: Mon, 27 Feb 2017 14:53:50 +0800
MIME-Version: 1.0
In-Reply-To: <3196d413-e99a-561a-310d-4d2fa93559d9@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] filter-rewriter: fix memory leak
 for connection in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, pss.wulizhen@huawei.com

On 2017/2/27 13:35, Jason Wang wrote:
>
>
> On 2017年02月27日 12:09, Hailiang Zhang wrote:
>> On 2017/2/27 11:40, Jason Wang wrote:
>>>
>>>
>>> On 2017年02月27日 11:11, Hailiang Zhang wrote:
>>>> On 2017/2/23 12:16, Jason Wang wrote:
>>>>>
>>>>>
>>>>> On 2017年02月22日 16:51, Hailiang Zhang wrote:
>>>>>> On 2017/2/22 16:45, Hailiang Zhang wrote:
>>>>>>> On 2017/2/22 16:07, Jason Wang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2017年02月22日 11:46, zhanghailiang wrote:
>>>>>>>>> After a net connection is closed, we didn't clear its releated
>>>>>>>>> resources
>>>>>>>>> in connection_track_table, which will lead to memory leak.
>>>>>>>>
>>>>>>>> Not a real leak but would lead reset of hash table if too many
>>>>>>>> closed
>>>>>>>> connections.
>>>>>>>>
>>>>>>>
>>>>>>> Yes, you are right, there will be lots of stale connection data in
>>>>>>> hash table
>>>>>>> if we don't remove it while it is been closed. Which
>>>>>
>>>>>
>>>>> Ok, so let's come up with a better title of the patch.
>>>>>
>>>>
>>>> OK.
>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> Let't track the state of net connection, if it is closed, its
>>>>>>>>> related
>>>>>>>>> resources will be cleared up.
>>>>>>>>
>>>>>>>> The issue is the state were tracked partially, do we need a full
>>>>>>>> state
>>>>>>>> machine here?
>>>>>>>>
>>>>>>>
>>>>>>> Not, IMHO, we only care about the last state of it, because, we will
>>>>>>> do nothing
>>>>>>> even if we track the intermedial states.
>>>>>
>>>>> Well, you care at least syn state too. Without a complete state
>>>>> machine,
>>>>> it's very hard to track even partial state I believe. And you will
>>>>> fail
>>>>> to track some state transition for sure which makes the code fragile.
>>>>>
>>>>
>>>> Agree, but here things are a little different. There are some extreme
>>>> cases
>>>> that we may can't track the complete process of closing connection.
>>>> For example (I have explained that in the bellow, it seems that you
>>>> didn't
>>>> got it ;) ).
>>>> If VM is running before we want to make it goes into COLO FT state,
>>>> there maybe some connections exist already, in extreme case, VM is
>>>> going into
>>>> COLO state while some connections are in half closing state, we can
>>>> only track
>>>> the bellow half closing state in filter-rewriter and colo compare
>>>> object.
>>>>
>>>>
>
> [...]
>
>>>> Er, here we track the last two states 'FIN=1, ACK=1' and  'ACK=1' (
>>>> which asks
>>>> the 'FIN=1,ACK=1' packet, We will remove the connection while got the
>>>> 'ACK=1'
>>>> packet, so  is it enough ?
>>>
>>> But the connection is not closed in fact, no? It's legal for remote to
>>> continue sending tons of packet to us even after this.
>>>
>>
>> Er, I'm a little confused, Here, for server side,
>> i think after got the 'ACK=1,seq=u+1,ack=w+1', it is closed,
>> so i remove it from hash table, wrong ?
>>
>> Client:                                    Server:
>>
>> ESTABLISHED|                               |
>>             | -> FIN=1,seq=u   ->           |
>
> This is case A and ACK should be set in this segment too.
>
>> FIN_WAIT_1 |                               |
>>             | <- ACK=1,seq=v,ack=u+1 <-     |
>> FINA_WAIT_2|                               |CLOSE_WAIT
>>             | <- FIN=1,ACK=1,seq=w,ack=u+1<-|
>>             |                               |LAST+ACK
>
> This is case B.
>
>> |   -> ACK=1,seq=u+1,ack=w+1    |
>> TIME_WAIT  |                               |CLOSED
>> CLOSED     |                               |
>>
>
> I think the issue is that your code can not differ A from B.
>

We have a parameter 'fin_ack_seq' recording the sequence of
'FIN=1,ACK=1,seq=w,ack=u+1' and if the ack value from the opposite
side is is 'w+1', we can consider this connection is closed, no ?

> Thanks
>
>>>>
>>>>> What's more I don't think we can decide passive or active close by:
>>>>>
>>>>>
>>>>> +    if ((tcp_pkt->th_flags & (TH_ACK | TH_FIN)) == (TH_ACK |
>>>>> TH_FIN)) {
>>>>>
>>>>> Since both cases will send FIN,ACK for sure.
>>>>>
>>>>
>>>> I didn't quite understand, here we have tracked the closing request no
>>>> matter
>>>> it is from the server side (passive close ?) or client side ( active
>>>> close ?).
>>>> You can refer to the comment in codes, 'Case 1' and 'Case 2' comments.
>>>
>>> I think you need differ them since passive close is much simpler, and it
>>> seems that your code may work only in this case.
>>>
>>>>
>>>> Here, it seems that we can't track one case which both sides send the
>>>> closing
>>>> requests at the same time, in that case, there are only 'FIN=1' and
>>>> 'ACK=1'
>>>> packets.
>>>>
>>>
>>> Yes, RFC allows this.
>>>
>>
>> Hmm, I'd like to remove this patch from this series,
>> And send it as a single patch after all the above questions
>> been solved. How about the other patches ?
>>
>
> Looks good except for the compiling issue of patch 3.
>

OK, i will fix it in version 3.

Thanks

> Thanks
>
>> Thanks,
>> Hailiang
>>
>>
>>> Thanks
>>>
>>>>
>>>> Thanks.
>>>> Hailiang
>>>>
>
> [...]
>
> .
>
