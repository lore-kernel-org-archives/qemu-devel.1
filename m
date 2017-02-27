Received: from eggs.gnu.org ([2001:4830:134:3::10]:60361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciIZG-0003Fh-IA
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciIZC-000276-IG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:30:10 -0500
Received: from [45.249.212.188] (port=2941 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciIZB-00024t-PG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:30:06 -0500
References: <1487735198-127300-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487735198-127300-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<b0b04c02-7c97-ea04-1e38-99fd9344edae@redhat.com>
	<58AD4F8F.5030703@huawei.com> <58AD5125.4010306@huawei.com>
	<b792c68e-d67a-ac24-26ea-aaf24f1f9437@redhat.com>
	<58B398F8.1020205@huawei.com>
	<c7883f1d-99ed-d082-3eee-7e0c641257e6@redhat.com>
	<58B3A688.5040707@huawei.com>
	<3196d413-e99a-561a-310d-4d2fa93559d9@redhat.com>
	<58B3CCFE.5070909@huawei.com>
	<562f8a27-63dc-6be8-ca2d-cf91c1ce4fe8@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58B3FFA7.2040205@huawei.com>
Date: Mon, 27 Feb 2017 18:29:59 +0800
MIME-Version: 1.0
In-Reply-To: <562f8a27-63dc-6be8-ca2d-cf91c1ce4fe8@redhat.com>
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

On 2017/2/27 17:05, Jason Wang wrote:
>
>
> On 2017年02月27日 14:53, Hailiang Zhang wrote:
>>> I think the issue is that your code can not differ A from B.
>>>
>>
>> We have a parameter 'fin_ack_seq' recording the sequence of
>> 'FIN=1,ACK=1,seq=w,ack=u+1' and if the ack value from the opposite
>> side is is 'w+1', we can consider this connection is closed, no ?
>

Hi Jason,

Thanks very much for your patience.

> Let's see what happens, consider VM is doing active close (reuse the
> figure above):
>

(We didn't support tracking the connection start
by the VM in current rewriter codes.
I mean the Client side is VM).

Your figure is not quite correct, the process should be:
                                           (VM)
Client:                                    Server:

ESTABLISHED|                               |
            | -> FIN=1,seq=u   ->           |
FIN_WAIT_1 |                               |
            | <- ACK=1,seq=v,ack=u+1 <-     |
FINA_WAIT_2|                               |CLOSE_WAIT
            | <- FIN=1,ACK=1,seq=w,ack=u+1<-|
handle_secondary():
fin_ack_seq = w
tcp_state = TCPS_LAST_ACK

            |                               |LAST+ACK
            |   -> ACK=1,seq=u+1,ack=w+1    |
TIME_WAIT  |                               |CLOSED
CLOSED     |                               |

handle_primary():
if (ack = fin_ack_seq + 1)
    g_hash_table_remove()

> (VM)
> Client:                                    Server:
>
> ESTABLISHED|                               |
>              | -> FIN=1,seq=u   ->           |
>
> handle_secondary():
> fin_ack_seq = u
> tcp_state = TCPS_LAST_ACK
>
> FIN_WAIT_1 |                               |
>              | <- ACK=1,seq=v,ack=u+1 <-     |
>
> handle_primary():
> fin_ack_seq = ack + 1
> g_hash_table_remove()
>
> But we probably want it to be removed in TIME_WAIT_CLOSED.
>

Yes, we should removed it after 2MSL, because the last
the sever side may not get the 'ACK=1,seq=v,ack=u+1' packet,
and it will resend the 'FIN=1,ACK=1,seq=w,ack=u+1'.

Thanks.


> Thanks
>
> .
>
